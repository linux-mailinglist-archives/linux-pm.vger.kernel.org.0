Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382EB52D2C3
	for <lists+linux-pm@lfdr.de>; Thu, 19 May 2022 14:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237999AbiESMoQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 May 2022 08:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237976AbiESMoO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2022 08:44:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E0BBA98C
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 05:44:12 -0700 (PDT)
Date:   Thu, 19 May 2022 12:44:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652964251;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AQ8wIZW/gX5qVCHR5mwg2xY8CjzCcj8k0dg7S6A/nAc=;
        b=AI9rL/IwCrqdpoqtZF1CfE02uwr9MojWQA9waCT4gkOe7s/htfyoTZ8Bq8kCNlEEyvppQD
        5OnvbY3O2IvEiZRFTuQArZc1BhdZGzmEfh6wAXtc4nNIzhduJdIqQ6/BjtoPNmctHNyN2U
        ZegnILR36fDmSItrk5m/8dO1Qrywkqo99p3YNnPYTHg562grSp+qu4KCoot5pxx0Efuxvj
        2UcNXmlpm1pK5FbEEKClQg/4S4EthLeDJIn1t0WMuqJ+oUbDEbFWsWNVHGh6SUy+KAwcEX
        QbYcFck2e6Sot+8GLhYbqxX5RGP+YxtZNpDrVY1RIDxxp7JHK0qQC/5M9GWDlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652964251;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AQ8wIZW/gX5qVCHR5mwg2xY8CjzCcj8k0dg7S6A/nAc=;
        b=13I92Q1UuzdK7oOpoiucDffM7U4mgG4y+P4Szp4mHnctDQ1USlE20cGo2WH2C9WeFPVnE7
        i4TFDqetPBYnnnDQ==
From:   "thermal-bot for Biju Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: rzg2l-thermal: Document
 RZ/G2UL bindings
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220501081930.23743-1-biju.das.jz@bp.renesas.com>
References: <20220501081930.23743-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Message-ID: <165296425018.4207.12815208444452730180.tip-bot2@tip-bot2>
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

Commit-ID:     e126ce0bcc082382497219c323e1b941583c9036
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//e126ce0bcc082382497219c323e1b941583c9036
Author:        Biju Das <biju.das.jz@bp.renesas.com>
AuthorDate:    Sun, 01 May 2022 09:19:30 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 19 May 2022 12:11:52 +02:00

dt-bindings: thermal: rzg2l-thermal: Document RZ/G2UL bindings

Document RZ/G2UL TSU bindings. The TSU block on RZ/G2UL is identical to one
found on RZ/G2L SoC. No driver changes are required as generic compatible
string "renesas,rzg2l-tsu" will be used as a fallback.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20220501081930.23743-1-biju.das.jz@bp.renesas.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml b/Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml
index dfb6dce..1d83733 100644
--- a/Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     items:
       - enum:
+          - renesas,r9a07g043-tsu # RZ/G2UL
           - renesas,r9a07g044-tsu # RZ/G2{L,LC}
           - renesas,r9a07g054-tsu # RZ/V2L
       - const: renesas,rzg2l-tsu
