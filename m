Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E57422CD7F
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jul 2020 20:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgGXSYU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jul 2020 14:24:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbgGXSYU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Jul 2020 14:24:20 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89DC72073E;
        Fri, 24 Jul 2020 18:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595615059;
        bh=JIGBWZIBvi5jU1T/ZEWKVBLow+csPIMk/JB4+fyhpps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hkvJdpvi2wx3XSLbaKuQFzDjPpwam5Ln60vt6Lc9qLhVDUUhHzcBrVD7vqMhAFcTI
         NBMiTeG2mhggpn9YNbktP8MEJe3wj8uUAfO7N2LZl9ai2tFbyvzf/asGWhd0mYnZ1e
         gwl5FjgnDBPiXfXp5ULwRpB1A42xEzeff+hQZEJg=
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
Subject: [PATCH 02/16] memory: mvebu-devbus: Add missing braces to all arms of if statement
Date:   Fri, 24 Jul 2020 20:23:14 +0200
Message-Id: <20200724182328.3348-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724182328.3348-1-krzk@kernel.org>
References: <20200724182328.3348-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add missing braces to all arms of if statement to align with coding
convention.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/memory/mvebu-devbus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/memory/mvebu-devbus.c b/drivers/memory/mvebu-devbus.c
index 886aea587276..76efc653dc7e 100644
--- a/drivers/memory/mvebu-devbus.c
+++ b/drivers/memory/mvebu-devbus.c
@@ -124,11 +124,11 @@ static int devbus_get_timing_params(struct devbus *devbus,
 	 * The bus width is encoded into the register as 0 for 8 bits,
 	 * and 1 for 16 bits, so we do the necessary conversion here.
 	 */
-	if (r->bus_width == 8)
+	if (r->bus_width == 8) {
 		r->bus_width = 0;
-	else if (r->bus_width == 16)
+	} else if (r->bus_width == 16) {
 		r->bus_width = 1;
-	else {
+	} else {
 		dev_err(devbus->dev, "invalid bus width %d\n", r->bus_width);
 		return -EINVAL;
 	}
-- 
2.17.1

