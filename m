Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207B8312B05
	for <lists+linux-pm@lfdr.de>; Mon,  8 Feb 2021 08:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhBHHRL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Feb 2021 02:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhBHHRJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2021 02:17:09 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BC8C06174A;
        Sun,  7 Feb 2021 23:16:28 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id p20so22949676ejb.6;
        Sun, 07 Feb 2021 23:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=krqWjImkL2aI2UxmellDdSuNGZ6V2RDP8gOeRiAmdmg=;
        b=qJVc36k8sBxNw2X02X+MJik2TCKX76BRTZGkc28zSjpfBWhdCvgtPxOF3bbFGwZorX
         yQbqJb3omUNY6hAvX/7utnFP/Jslo8ZzGMmcw4Ac32i8zcerZuHTny+1E8IlsrWrJKpi
         YUhSLYqczc9VpYVyy+mgA0b6xX/Q43kz+QZtQlaZSp4+pm/RKA5kDGZAE9J6lVreUEI7
         kSn+wfZPp581R7Tl4CdrQqPl6AMKgkqjrKDJrGuvKzi+4NKYgkM+odx4+V3TKsCadcZJ
         IYdNp3Scx0PSjfcrkmjJezuBAJtoST6dlAdLHbwL4YN+KMnHiD6Hj/mLlxAI7HUyeKRg
         MZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=krqWjImkL2aI2UxmellDdSuNGZ6V2RDP8gOeRiAmdmg=;
        b=sSLunMrLxGnkQofKXgin1aIjyGYCA+0v2ZexGJ6NdN7yb3WGATH4RITd0qvfy4jV5o
         5qq9+ksLWK/N0wjTjt/DyrlHm7TzwlRFTp9LWOKIxOaVn1Dm+EQkLq2WXGRDrG1oNBhR
         b7+9V9gH3t7G9eF2dDFufi3byhvAExpcKoWyxbNCf48Vq5Kua3GxKuyCBHeWUua/iAuV
         CPHynXdN5B+MwI1ekQbEDCdei901CrO/Gu/Fyp/rnLTUCjzBbNzuDyMAjGoei2bSuhHR
         IzB+jC0vm08GKFQ8nGX30gg647KezjGiFWPzwdKJV0uQBpIL+7wjl9FPjAY+e2sqtKQ5
         LbMA==
X-Gm-Message-State: AOAM530QcdqbfEaqp3tIT7tmr9sV28AHQY+BG7J/McM+Q8w1aUXZxbCr
        666OdDG2NLBE1BjQcKOUkwQ=
X-Google-Smtp-Source: ABdhPJyKkJ+xmxPCgvpMetHKmyyHLONSRFLlkA6IPTTWWCLsCmEB8YEVSkXWpIFguOsmFbbzjR9R2w==
X-Received: by 2002:a17:906:5857:: with SMTP id h23mr15170797ejs.465.1612768587484;
        Sun, 07 Feb 2021 23:16:27 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d8e:7300:842e:a74a:35f3:bd06])
        by smtp.gmail.com with ESMTPSA id b4sm3278152edh.40.2021.02.07.23.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 23:16:26 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: rectify BROADCOM PMB (POWER MANAGEMENT BUS) DRIVER
Date:   Mon,  8 Feb 2021 08:16:19 +0100
Message-Id: <20210208071619.3234-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit 8bcac4011ebe ("soc: bcm: add PM driver for Broadcom's PMB") includes
a new MAINTAINERS section BROADCOM PMB (POWER MANAGEMENT BUS) DRIVER with
'drivers/soc/bcm/bcm-pmb.c', but the file was actually added at
'drivers/soc/bcm/bcm63xx/bcm-pmb.c'.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:

  warning: no file matches  F:    drivers/soc/bcm/bcm-pmb.c

Point the file entry to the right location.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on next-20210205

Rafal, please ack.
Florian, please pick this minor fixup patch for soc next tree.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6b507e8d7828..c23731c88dc2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3647,7 +3647,7 @@ M:	bcm-kernel-feedback-list@broadcom.com
 L:	linux-pm@vger.kernel.org
 S:	Maintained
 T:	git git://github.com/broadcom/stblinux.git
-F:	drivers/soc/bcm/bcm-pmb.c
+F:	drivers/soc/bcm/bcm63xx/bcm-pmb.c
 F:	include/dt-bindings/soc/bcm-pmb.h
 
 BROADCOM SPECIFIC AMBA DRIVER (BCMA)
-- 
2.17.1

