Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32D322CD75
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jul 2020 20:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgGXSYQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jul 2020 14:24:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbgGXSYP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Jul 2020 14:24:15 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 919042070B;
        Fri, 24 Jul 2020 18:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595615055;
        bh=Pr6t85r4RMxLw0dWCkeDg0s3yaMTSCzPiT5lUIQcFNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QdjJkRwssPG4fsDjAS7wm+y17p8oCeWa8IU+jy0xx3KQQLHEJl0EJxHHLZY12008D
         wtpxTj3Y93h5gbK5B5xk0hgOyd9pasFPGzxy4UQ0UvC8QIAD/k0cd8WOl9WJESTYpM
         Kaz90Zq11ucqUzG257RYeBkMeMN7scuLCFzD6Aao=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Roger Quadros <rogerq@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kukjin Kim <kgene@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 01/16] memory: bt1-l2-ctl: Add blank lines after declarations
Date:   Fri, 24 Jul 2020 20:23:13 +0200
Message-Id: <20200724182328.3348-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724182328.3348-1-krzk@kernel.org>
References: <20200724182328.3348-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add blank lines to improve code readability.  No functional change.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/memory/bt1-l2-ctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/memory/bt1-l2-ctl.c b/drivers/memory/bt1-l2-ctl.c
index 633fea6a4edf..85965fa26e0b 100644
--- a/drivers/memory/bt1-l2-ctl.c
+++ b/drivers/memory/bt1-l2-ctl.c
@@ -66,6 +66,7 @@ struct l2_ctl_device_attribute {
 	struct device_attribute dev_attr;
 	enum l2_ctl_stall id;
 };
+
 #define to_l2_ctl_dev_attr(_dev_attr) \
 	container_of(_dev_attr, struct l2_ctl_device_attribute, dev_attr)
 
@@ -242,6 +243,7 @@ static ssize_t l2_ctl_latency_store(struct device *dev,
 
 	return count;
 }
+
 static L2_CTL_ATTR_RW(l2_ws_latency, l2_ctl_latency, L2_WS_STALL);
 static L2_CTL_ATTR_RW(l2_tag_latency, l2_ctl_latency, L2_TAG_STALL);
 static L2_CTL_ATTR_RW(l2_data_latency, l2_ctl_latency, L2_DATA_STALL);
-- 
2.17.1

