Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F623608DC
	for <lists+linux-pm@lfdr.de>; Thu, 15 Apr 2021 14:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbhDOMEa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Apr 2021 08:04:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59462 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbhDOME1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Apr 2021 08:04:27 -0400
Date:   Thu, 15 Apr 2021 12:04:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618488244;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eG8aglQ2X4cwEXZy+flpq3KniL0ec1Or7IAAM5XYrCE=;
        b=oCN5u4gUSdt0OfYvCpFWWQYynNg2XlxrcNcbiu01e9A9uG12kEsJ+avyWxmZoAeXiijQBc
        7lc19HQ7Ri7dJQAY+cT0A+1fGLhdszBgbg4zL6tQ6OF3f4uZUaATXnUhr0erRiVY9c3H+l
        UIwmb/5e0xqSS/naZy53qoT/X62snecUEEZTm0Q9PuMoKlzOcjaD3wqAMRrH4B84A5xoQ3
        KVu+HhziVlyshA4C2ESkFFTiRO6bgGHRCbVJXFNBibOlE1m9AdPZaYz7WN1n0OvYjQSTDy
        Hkp3zM99Gto9nJtT4j4fAR+/REOy7Dw/cjMAboTrV7YBikpxLux78NaaeDJE1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618488244;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eG8aglQ2X4cwEXZy+flpq3KniL0ec1Or7IAAM5XYrCE=;
        b=FSy7pJBAH6+8kHoSNHLvIclUjykweaRoGRbyYW/gObJirSXLfH8UbZXgQJXJjA1b/zX0H8
        rKOI1NlNOZzMD6AA==
From:   "thermal-bot for Thara Gopinath" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] MAINTAINERS: Add co-maintainer for Qualcomm
 tsens thermal drivers
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210319153711.2836652-1-thara.gopinath@linaro.org>
References: <20210319153711.2836652-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Message-ID: <161848824350.29796.16177302339421659946.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     ef6e01af398acff63eb33c58e72839e50a3e1c4b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//ef6e01af398acff63eb33c58e72839e50a3e1c4b
Author:        Thara Gopinath <thara.gopinath@linaro.org>
AuthorDate:    Fri, 19 Mar 2021 11:37:11 -04:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 19 Mar 2021 16:52:57 +01:00

MAINTAINERS: Add co-maintainer for Qualcomm tsens thermal drivers

Add myself as the maintainer for Qualcomm tsens drivers so that I
can help Daniel by taking care of/reviewing changes to these drivers.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210319153711.2836652-1-thara.gopinath@linaro.org
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d92f85c..f919aa8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14891,6 +14891,7 @@ F:	include/linux/if_rmnet.h
 
 QUALCOMM TSENS THERMAL DRIVER
 M:	Amit Kucheria <amitk@kernel.org>
+M:	Thara Gopinath <thara.gopinath@linaro.org>
 L:	linux-pm@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
