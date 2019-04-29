Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3656DE98F
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2019 19:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbfD2R5L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 13:57:11 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:18027 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbfD2R5L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 13:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1556560630; x=1588096630;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=VP2cUI8KjAFIewDrbCGl5adztK+upR77ms3b6lJ7QZA=;
  b=vGMkC/TIMg40oY1Hbrd0Wc2gQyQNMKIhHUOTF4sFguENHVbeKt/yY64L
   oWsU0K9l67tOzd6sNx6HnLmXG1yJg6QD8PiZ3NybmaXYINX0MdCTOoy2s
   kxaD36wYKvnEZwQgOiF4APMYqFaic4nV0W/fHtEhL8e++4GaVMWCd7skj
   4=;
X-IronPort-AV: E=Sophos;i="5.60,410,1549929600"; 
   d="scan'208";a="730991733"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 29 Apr 2019 09:47:57 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x3T9ltnl088636
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 29 Apr 2019 09:47:55 GMT
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 29 Apr 2019 09:47:55 +0000
Received: from udc4a3e82dbc15a031435.hfa14.amazon.com (10.43.160.175) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 29 Apr 2019 09:47:48 +0000
From:   Talel Shenhar <talel@amazon.com>
To:     <talel@amazon.com>, <robh@kernel.org>, <edubezval@gmail.com>,
        <daniel.lezcano@linaro.org>, <dwmw@amazon.co.uk>,
        <jonnyc@amazon.com>, <rui.zhang@intel.com>, <hhhawa@amazon.com>,
        <ronenk@amazon.com>, <hanochu@amazon.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH 1/1] thermal: Fix build error of missing devm_ioremap_resource on UM
Date:   Mon, 29 Apr 2019 12:47:36 +0300
Message-ID: <1556531256-26321-1-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <201904261215.nJZXSFjx%lkp@intel.com>
References: <201904261215.nJZXSFjx%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.175]
X-ClientProxiedBy: EX13D18UWC004.ant.amazon.com (10.43.162.77) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The devres.o gets linked if HAS_IOMEM is present so on ARCH=um
allyesconfig (COMPILE_TEST) failed on many files with:

drivers/thermal/thermal_mmio.o:
In function 'thermal_mmio_probe':thermal_mmio.c:(.text+0xe1):
undefined reference to `devm_ioremap_resource'

The users of devm_ioremap_resource() which are compile-testable
should depend on HAS_IOMEM.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Talel Shenhar <talel@amazon.com>
---
 drivers/thermal/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 41f3943..66a709d 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -203,6 +203,7 @@ config THERMAL_EMULATION
 config THERMAL_MMIO
 	tristate "Generic Thermal MMIO driver"
 	depends on OF || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This option enables the generic thermal MMIO driver that will use
 	  memory-mapped reads to get the temperature.  Any HW/System that
-- 
2.7.4

