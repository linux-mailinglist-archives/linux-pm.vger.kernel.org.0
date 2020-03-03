Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFB21777CC
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 14:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgCCNwL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 08:52:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:40386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728592AbgCCNwL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Mar 2020 08:52:11 -0500
Received: from mail.kernel.org (tmo-101-56.customers.d1-online.com [80.187.101.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 564A420857;
        Tue,  3 Mar 2020 13:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583243530;
        bh=vWl+nyAmbI4wwUurGPGeToUMpjxhS/tUqKAcmoxzrmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hGPvVm2KU1VYOPmeajB9lSJDKiZkWTK51OoSe9Bz1HlrIO5+Ia0l2qaG0OmN4JELs
         Rx5PQUo3NOSBlUXOxlp0H9qD8/wn11i1+F9PizOYrRm2hPp1OzxXw/NPdmL7/WAEYF
         XwLPnKmq0DK3NZnn3oc+v6TkLgPv5IaVzzj9CcTA=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j97xw-001YXN-1v; Tue, 03 Mar 2020 14:52:08 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 1/5] docs: cpufreq: fix a broken reference
Date:   Tue,  3 Mar 2020 14:52:02 +0100
Message-Id: <0bda11fd334238a21e429355616caff26e99cc77.1583243272.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1583243272.git.mchehab+huawei@kernel.org>
References: <cover.1583243272.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The old cpufreq docs got moved. Let's also update its
pointer inside Kconfig.x86.

Fixes: 78a0abeca1bd ("Documentation: cpufreq: Move legacy driver documentation")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/cpufreq/Kconfig.x86 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index a6528388952e..62502d0e4c33 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -25,7 +25,7 @@ config X86_PCC_CPUFREQ
 	  This driver adds support for the PCC interface.
 
 	  For details, take a look at:
-	  <file:Documentation/cpu-freq/pcc-cpufreq.txt>.
+	  <file:Documentation/admin-guide/pm/cpufreq_drivers.rst>.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called pcc-cpufreq.
-- 
2.24.1

