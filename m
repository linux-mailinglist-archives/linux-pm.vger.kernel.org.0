Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5B322CD83
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jul 2020 20:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgGXSYZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jul 2020 14:24:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:32850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbgGXSYZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Jul 2020 14:24:25 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D42A206F6;
        Fri, 24 Jul 2020 18:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595615064;
        bh=RYyMMVgWEW5lCfaf1U/r/2g9DqYwNBNdPlUu9TPs1gE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qGalTqKQdG9AB0+FVyM/3wXLT5iBamCBhy9/dVYN8uAw+n7wXaldq22/Swb0GrnUv
         g+opoNOZnYA0AAex3pQK4LmItDWwWPjGtozqtpkbXimlucvwGuAxIm3qAs3BrqbUHz
         vJl8m47EPrzIBthvU/MS+EkFyou+yGlrrrOIcpMs=
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
Subject: [PATCH 03/16] memory: mvebu-devbus: Align with open parenthesis
Date:   Fri, 24 Jul 2020 20:23:15 +0200
Message-Id: <20200724182328.3348-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724182328.3348-1-krzk@kernel.org>
References: <20200724182328.3348-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The line continuation contained spaces but still failed to properly
align with open parenthesis.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/memory/mvebu-devbus.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/memory/mvebu-devbus.c b/drivers/memory/mvebu-devbus.c
index 76efc653dc7e..8450638e8670 100644
--- a/drivers/memory/mvebu-devbus.c
+++ b/drivers/memory/mvebu-devbus.c
@@ -134,22 +134,22 @@ static int devbus_get_timing_params(struct devbus *devbus,
 	}
 
 	err = get_timing_param_ps(devbus, node, "devbus,badr-skew-ps",
-				 &r->badr_skew);
+				  &r->badr_skew);
 	if (err < 0)
 		return err;
 
 	err = get_timing_param_ps(devbus, node, "devbus,turn-off-ps",
-				 &r->turn_off);
+				  &r->turn_off);
 	if (err < 0)
 		return err;
 
 	err = get_timing_param_ps(devbus, node, "devbus,acc-first-ps",
-				 &r->acc_first);
+				  &r->acc_first);
 	if (err < 0)
 		return err;
 
 	err = get_timing_param_ps(devbus, node, "devbus,acc-next-ps",
-				 &r->acc_next);
+				  &r->acc_next);
 	if (err < 0)
 		return err;
 
@@ -175,17 +175,17 @@ static int devbus_get_timing_params(struct devbus *devbus,
 	}
 
 	err = get_timing_param_ps(devbus, node, "devbus,ale-wr-ps",
-				 &w->ale_wr);
+				  &w->ale_wr);
 	if (err < 0)
 		return err;
 
 	err = get_timing_param_ps(devbus, node, "devbus,wr-low-ps",
-				 &w->wr_low);
+				  &w->wr_low);
 	if (err < 0)
 		return err;
 
 	err = get_timing_param_ps(devbus, node, "devbus,wr-high-ps",
-				 &w->wr_high);
+				  &w->wr_high);
 	if (err < 0)
 		return err;
 
-- 
2.17.1

