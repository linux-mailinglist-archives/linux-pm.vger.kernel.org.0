Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8394D22AC
	for <lists+linux-pm@lfdr.de>; Tue,  8 Mar 2022 21:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350243AbiCHUet (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Mar 2022 15:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350252AbiCHUes (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Mar 2022 15:34:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E41B3EF24
        for <linux-pm@vger.kernel.org>; Tue,  8 Mar 2022 12:33:51 -0800 (PST)
Date:   Tue, 08 Mar 2022 20:33:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646771629;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WnifazXYSwoeEWf/Zewysos1qvl8wj+iYkPYPNNzMDY=;
        b=UfmsUn02ZftqoRIgZceiSlTrUX61hgzumgBgH4B03gVyO0yIbMzB8GkjgwPp6GZ8MVRKak
        +u+w4ov1YtXLGTc0pbvBs+RtdURcHfnEzuJzrCAzpqfApA6MEnATCz7ptsNO4s/xxRHIyI
        NiCpP+rpEb20lzGRoccnSAqMW3nOy/rFwpM8aAZUfWoOC4ArJqr3E+nieqhwCZFwtMORdx
        bIHTt8vAf0QMwEKaOIX+CWZt+BPk8OGP7dQ0FrmOirSU54wOdn7M5R0I7/y5vEw1AaU4Ib
        FCsUKImN/+YFRcUACtC/GfLRG3mNwZYnC3eF07047oZf3MkXtc4vkSe7hldB9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646771629;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WnifazXYSwoeEWf/Zewysos1qvl8wj+iYkPYPNNzMDY=;
        b=0/RVNK+gddsC2WYuwmGmxCUP4ZHhlnuopsX4ljuWzBv+ECmKRKPmZQwaW8NrikBSNMkNmL
        pWMVVFg7eAJQMfAA==
From:   "thermal-bot for Luca Weiss" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: tsens: Add msm8953 compatible
Cc:     Luca Weiss <luca@z3ntu.xyz>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com
In-Reply-To: <20220220201909.445468-3-luca@z3ntu.xyz>
References: <20220220201909.445468-3-luca@z3ntu.xyz>
MIME-Version: 1.0
Message-ID: <164677162768.16921.11500472170962824846.tip-bot2@tip-bot2>
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

Commit-ID:     e8ec6bb302074e41268f9764bf6328599682b84f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//e8ec6bb302074e41268f9764bf6328599682b84f
Author:        Luca Weiss <luca@z3ntu.xyz>
AuthorDate:    Sun, 20 Feb 2022 21:18:55 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 08 Mar 2022 21:26:09 +01:00

dt-bindings: thermal: tsens: Add msm8953 compatible

Document the compatible string for tsens found in msm8953.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Acked-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Acked-by: Amit Kucheria <amitk@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20220220201909.445468-3-luca@z3ntu.xyz
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index d3b9e9b..b6406bc 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -43,6 +43,7 @@ properties:
       - description: v2 of TSENS
         items:
           - enum:
+              - qcom,msm8953-tsens
               - qcom,msm8996-tsens
               - qcom,msm8998-tsens
               - qcom,sc7180-tsens
