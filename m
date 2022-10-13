Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4766C5FE46E
	for <lists+linux-pm@lfdr.de>; Thu, 13 Oct 2022 23:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJMVuP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Oct 2022 17:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiJMVtr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Oct 2022 17:49:47 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F344B194FB8
        for <linux-pm@vger.kernel.org>; Thu, 13 Oct 2022 14:49:26 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id r18so2655116pgr.12
        for <linux-pm@vger.kernel.org>; Thu, 13 Oct 2022 14:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=wseFX2xvL4KPdBggbIiWm5eR1PGhf7fGAiufwZVrGPE=;
        b=RPyk93n1QGBYXEGXygI8Neiz6lgfKwRWo/7wovUbwlQCd1TkF/8VkgeWZJyx+TJTdl
         xefVCLZ7UTo3HrWvDJte4uSIyhOuQ2tSQ84C150LDbnRMfTT65AsEsY0IGHdVQA53q6P
         ayQtRdx4yIIpCK23CBiMqjdCNx4mVd33NtXuipfuF+bzIjP011xQnoN+NWqzYFM9i25E
         vElfjcIaPvygYL8NzLiSWBWZSWVbn/Y1NIk6uqwXn251ZVJEnv3YbkSWCFXCxRNE3z+Y
         C6mGilpNFn2b8pKmZvTRdmbSeIwwBaRddm3xE8HdACJWecDYo+c6nZ/PqN4LqFwJ8RFR
         D9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wseFX2xvL4KPdBggbIiWm5eR1PGhf7fGAiufwZVrGPE=;
        b=CQvrD2r6e5fm3Z0zMo0QGFSEww249LcfcMdDe23poTFub9GZNkRmi2mdhoEvpCIu+K
         O8+LFJwrmjZKDi2vIs/lPNSJ1pwW8GgT0FcLZYRIXIbMF1lISnFx7oIAQg+MpWytJCmn
         QLR1Ef/axWMH8dECl74pJrB+9FU+yvZfy52LJkSr3im6FBpghgNIHvQL+vZApAtHVqU4
         SYKeHR+e4XAKVFswVq/2rjDx9P6VUstcj5vQCdq7cwxHx0gU/zznwdUVTCY3h0tsDyEX
         6xXFxEudahEWTuGAhW4d/l53gTwIwTAkomWfElRMekrdWb7Y3fehIFzBRtRSRDQFGS0y
         LOFw==
X-Gm-Message-State: ACrzQf2SE9BeY8x5nFYva6id0ovRYA1yDFn8qZcAw1Qb32phKRUrLoFJ
        nPAUbpJdsSITp6ivtPEJdkC2dA==
X-Google-Smtp-Source: AMsMyM4A4krgh5X46YbQvqj8mqnOZtPA0dIlLQHVzb0amy0HHCnSiVo3EuU5B4uhdmecVJNJyThmRA==
X-Received: by 2002:a63:4750:0:b0:43c:dac:9e4b with SMTP id w16-20020a634750000000b0043c0dac9e4bmr1726794pgk.300.1665697759268;
        Thu, 13 Oct 2022 14:49:19 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id iz12-20020a170902ef8c00b0018003571809sm290313plb.224.2022.10.13.14.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 14:49:18 -0700 (PDT)
Subject: [PATCH] MAINTAINERS: git://github -> https://github.com for broadcom
Date:   Thu, 13 Oct 2022 14:46:39 -0700
Message-Id: <20221013214639.31074-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:        linux-kernel@vger.kernel.org,
           Palmer Dabbelt <palmer@rivosinc.com>,
           Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     william.zhang@broadcom.com, anand.gore@broadcom.com,
        kursad.oney@broadcom.com, f.fainelli@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        rjui@broadcom.com, sbranden@broadcom.com, rafal@milecki.pl,
        linux-pm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Github deprecated the git:// links about a year ago, so let's move to
the https:// URLs instead.

Reported-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
I've split these up by github username so folks can take them
independently, as some of these repos have been renamed at github and
thus need more than just a sed to fix them.
---
 MAINTAINERS | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f552f839dd32..3699b2256dc2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3951,7 +3951,7 @@ M:	Florian Fainelli <f.fainelli@gmail.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-T:	git git://github.com/broadcom/stblinux.git
+T:	git https://github.com/broadcom/stblinux.git
 F:	Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml
 F:	arch/arm64/boot/dts/broadcom/bcmbca/*
 N:	bcmbca
@@ -3976,7 +3976,7 @@ R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-rpi-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-T:	git git://github.com/broadcom/stblinux.git
+T:	git https://github.com/broadcom/stblinux.git
 F:	Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
 F:	drivers/pci/controller/pcie-brcmstb.c
 F:	drivers/staging/vc04_services
@@ -3990,7 +3990,7 @@ M:	Ray Jui <rjui@broadcom.com>
 M:	Scott Branden <sbranden@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 S:	Maintained
-T:	git git://github.com/broadcom/mach-bcm
+T:	git https://github.com/broadcom/mach-bcm
 F:	arch/arm/mach-bcm/
 N:	bcm281*
 N:	bcm113*
@@ -4055,7 +4055,7 @@ M:	Florian Fainelli <f.fainelli@gmail.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-T:	git git://github.com/broadcom/stblinux.git
+T:	git https://github.com/broadcom/stblinux.git
 F:	Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
 F:	arch/arm/boot/dts/bcm7*.dts*
 F:	arch/arm/include/asm/hardware/cache-b15-rac.h
@@ -4087,7 +4087,7 @@ M:	Florian Fainelli <f.fainelli@gmail.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
-T:	git git://github.com/broadcom/stblinux.git
+T:	git https://github.com/broadcom/stblinux.git
 F:	arch/mips/bmips/*
 F:	arch/mips/boot/dts/brcm/bcm*.dts*
 F:	arch/mips/include/asm/mach-bmips/*
@@ -4226,7 +4226,7 @@ M:	Scott Branden <sbranden@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-T:	git git://github.com/broadcom/stblinux.git
+T:	git https://github.com/broadcom/stblinux.git
 F:	arch/arm64/boot/dts/broadcom/northstar2/*
 F:	arch/arm64/boot/dts/broadcom/stingray/*
 F:	drivers/clk/bcm/clk-ns*
@@ -4296,7 +4296,7 @@ M:	Florian Fainelli <f.fainelli@gmail.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
-T:	git git://github.com/broadcom/stblinux.git
+T:	git https://github.com/broadcom/stblinux.git
 F:	drivers/soc/bcm/bcm63xx/bcm-pmb.c
 F:	include/dt-bindings/soc/bcm-pmb.h
 
-- 
2.38.0

