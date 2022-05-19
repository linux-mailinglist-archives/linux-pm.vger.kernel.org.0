Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D249952D2D8
	for <lists+linux-pm@lfdr.de>; Thu, 19 May 2022 14:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbiESMof (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 May 2022 08:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238029AbiESMoc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2022 08:44:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADE3BA9B0
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 05:44:29 -0700 (PDT)
Date:   Thu, 19 May 2022 12:44:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652964268;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G6T0zo7ZMZ2TZzP8vvIN4aOpTqfB79RuJ0UA3uw3hQ4=;
        b=AgEkx54UTU0eINX0u2nZmzCOe7siyZHfiPHHUcYJsp0Wvcg9TkM3R+wSKXwRxD841F5cKQ
        B4tKUuw7ui8722lq/Kw1FcGevkeZBYG8Xv1SrZclhifyAEQh4g5AI/pO9pKZlQIROy++mR
        34fjQIAyNR/MxRYIOo//0moSjAJPxp5vRp5IbFBT7HhOegr1rou56+cqiT+itMoolzxD9b
        z1T4pAC6rYp3rqqxG8Z43jsDjPgfztFRT8/hZoLiDysVvDBjjB0z72iFnYX10H6vGyxQJS
        GfpdxB3atVTWcGFVn0JPgnY1xANxSbTiytPKxXxls9oKyFcvjzRlDWV2w0yY8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652964268;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G6T0zo7ZMZ2TZzP8vvIN4aOpTqfB79RuJ0UA3uw3hQ4=;
        b=woc3futGWEwYX5Mgq3WbA7kYK8zBmrxrVLZ1NGLilWdLgqNRn92wTUddeed4Iei5McH2SP
        vu8egnmwnSXsSRDQ==
From:   "thermal-bot for Lad Prabhakar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: rzg2l-thermal: Document
 RZ/V2L bindings
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220308212315.4551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220308212315.4551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Message-ID: <165296426709.4207.8593711320110361176.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     feef7f32521eb169d7bcbb80291fc78bd39edb97
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//feef7f32521eb169d7bcbb80291fc78bd39edb97
Author:        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
AuthorDate:    Tue, 08 Mar 2022 21:23:15 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 19 May 2022 12:11:50 +02:00

dt-bindings: thermal: rzg2l-thermal: Document RZ/V2L bindings

Document RZ/V2L TSU bindings. The TSU block on RZ/V2L is identical to one
found on RZ/G2L SoC. No driver changes are required as generic compatible
string "renesas,rzg2l-tsu" will be used as a fallback.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20220308212315.4551-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml b/Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml
index ccab951..dfb6dce 100644
--- a/Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml
@@ -18,6 +18,7 @@ properties:
     items:
       - enum:
           - renesas,r9a07g044-tsu # RZ/G2{L,LC}
+          - renesas,r9a07g054-tsu # RZ/V2L
       - const: renesas,rzg2l-tsu
 
   reg:
