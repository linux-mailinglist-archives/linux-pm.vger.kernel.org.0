Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE04382A39
	for <lists+linux-pm@lfdr.de>; Mon, 17 May 2021 12:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbhEQKx7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 May 2021 06:53:59 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.102]:31746 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236466AbhEQKx7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 May 2021 06:53:59 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1621248753; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=m113RwB0gSIQ3fvmP9w4rbNtV6j4btx/FuYll0TaG313uq5MaMPvPtcKK58Nqa36Rg
    VF0IDHOnUG8s3eofnTtq/8H3BaBRPE8xQ/5QpNBAzmcw6Sf+65MOaRDd6fyRBApOTbbj
    cmIGUPnxxbXL2oeME9uE6UZpDYMEwHpzcL3DfqL/J5J0+mCotRC8WNIAbDPLDbpyIzmD
    eiJsY5zUYDqAVM9NS/cjVAgLd9KdLnNKyTtYb69hRAVZEKMdXr+FYC5OcH0Ps4HK75D6
    Ixa7aMNxfKy7KnkfgQwIiLJVVlpJjNhOy4004KYwrZ01LfgPXNPV4NrdHFilnNch05Tb
    n9Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1621248753;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=4Dcy2LTLgJk8PaoF6Y+q8hdBpMw3cHT4pkb5zRFtSJs=;
    b=d5PwweypdFNHpvJ0zEqyMHc9qsbPCh3++xx+C7jDpSfopWlGT58Yuhl7VU0B/wecFc
    jmSlOwwzTRpaXWvzVLYs70T+PhYsYX9dhtnWt1QfrD5HwXUhmmmxjLaj47SWQ0z0xpMe
    wuUL2pbxiMKkm4rznvBlCyN+EjO5J7zVNNcyJzOFpYL1GE4+C9jhNgIsu8NwEr5PshRP
    9wCVpGbuCTpkQf+lzTPJ+/A984o3DMfFLwOYm6u7bv2oNUIH4D5mHFow9ZnHJTfddyVA
    YDdIIJq6gKHBIXfKHWpSdhEagAujoM7JsaPTFcrUu2rq1Qy2jsusuPI/OU03TI7kcE7R
    Lu2g==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1621248753;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=4Dcy2LTLgJk8PaoF6Y+q8hdBpMw3cHT4pkb5zRFtSJs=;
    b=bbvWQHOZPg85k46M2/t5+1qXW81G7StYdTlHatE4e3LScWLY1xi1QRY+iFiIbv+TTh
    kFCqBL2uhiKvYP/uEvv3dQvJKyefAoiMDSzZoCeAnI0s2fmcrAnqatuLDY19OlWlWiKp
    tli/anMLU99VpPaVkHTAVrdM8BjDxff41UgOyfvRLzhkq0sjGHHRNWifmbgsBKRGowar
    qQV51OZCuVBdzREdtV/Aui3svRtVSH27Zs4cbMn0P7GAUwwH5YuPtcQSx2SWr4yBqVYy
    lVkQxTQYgbqBKOyrdhdOGnYOYb5YImtEimOi0U9fScdO221DNTBq3+xxbChWmIgxScNm
    EyTQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB526NcMiO"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.26.0 DYNA|AUTH)
    with ESMTPSA id 50be75x4HAqX1Vb
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 17 May 2021 12:52:33 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2 3/3] mfd: rt5033: Drop rt5033-battery sub-device
Date:   Mon, 17 May 2021 12:51:13 +0200
Message-Id: <20210517105113.240379-4-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517105113.240379-1-stephan@gerhold.net>
References: <20210517105113.240379-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The fuel gauge in the RT5033 PMIC (rt5033-battery) has its own I2C bus
and interrupt lines. Therefore, it is not part of the MFD device
and needs to be specified separately in the device tree.

Cc: Beomho Seo <beomho.seo@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Fixes: 0b271258544b ("mfd: rt5033: Add Richtek RT5033 driver core.")
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/mfd/rt5033.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mfd/rt5033.c b/drivers/mfd/rt5033.c
index f1236a9acf30..df095e91e266 100644
--- a/drivers/mfd/rt5033.c
+++ b/drivers/mfd/rt5033.c
@@ -41,9 +41,6 @@ static const struct mfd_cell rt5033_devs[] = {
 	{
 		.name = "rt5033-charger",
 		.of_compatible = "richtek,rt5033-charger",
-	}, {
-		.name = "rt5033-battery",
-		.of_compatible = "richtek,rt5033-battery",
 	}, {
 		.name = "rt5033-led",
 		.of_compatible = "richtek,rt5033-led",
-- 
2.31.1

