Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCA6648515
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiLIP0e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiLIP03 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20FA8C6BD
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:27 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599586;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TNJY7kJbfs0ugicEVW89wESI31snSykBGiYiJ0agMrY=;
        b=xjYdRoDFJLFHgk2dxwSbGm6MhPz+umK0HLe+Gt7w3ynegcc+sLwglyOR23RL+Sz2t542cs
        tOiuwAEpo9+Fdj9S7D+JI7DEHIPZoOioPDe0DA7vlpBnEnazP6JFoXVWmCRc81ElWcbrxN
        PH7EjKLIxedXQj6UT05PAXbIISosHZSZUv5G0V7NGTIf71/kFM/ZgSRV8nwxdIEKCSkPs6
        W47F7bcxzPy41XhQzfPqWnCAq5Bk/BxAkC9xJBGSQAVFghFC+0Fufcl3/52Lce2SJ/zeoK
        /WhYd5b06i2VKuNikUBkMVmCRlAFKIeDGlpuVNm1Iwc43UXrjoeNZj0+x8nkzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599586;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TNJY7kJbfs0ugicEVW89wESI31snSykBGiYiJ0agMrY=;
        b=AYZTU2vZlwWwDyoj6/kRId0m6zwawujyrxxneCxjDCu8DPikX1+dmwKerD74M02+sR9DHd
        sPfQN1sB6W98URBA==
From:   "thermal-bot for Lad Prabhakar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: rzg2l-thermal: Document
 RZ/Five SoC
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
In-Reply-To: <20221115121629.1181667-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221115121629.1181667-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Message-ID: <167059958594.4906.7788671086192958433.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     2ee1412a50037b4ba6bfeac426a41c4c06aa7b86
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//2ee1412a50037b4ba6bfeac426a41c4c06aa7b86
Author:        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
AuthorDate:    Tue, 15 Nov 2022 12:16:29 
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:45 +01:00

dt-bindings: thermal: rzg2l-thermal: Document RZ/Five SoC

The TSU block on the RZ/Five SoC is identical to one found on the RZ/G2UL
SoC. "renesas,r9a07g043-tsu" compatible string will be used on the
RZ/Five SoC so to make this clear, update the comment to include RZ/Five
SoC.

No driver changes are required as generic compatible string
"renesas,rzg2l-tsu" will be used as a fallback on RZ/Five SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20221115121629.1181667-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml b/Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml
index 1d83733..03f4b92 100644
--- a/Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml
@@ -17,7 +17,7 @@ properties:
   compatible:
     items:
       - enum:
-          - renesas,r9a07g043-tsu # RZ/G2UL
+          - renesas,r9a07g043-tsu # RZ/G2UL and RZ/Five
           - renesas,r9a07g044-tsu # RZ/G2{L,LC}
           - renesas,r9a07g054-tsu # RZ/V2L
       - const: renesas,rzg2l-tsu
