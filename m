Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA67648518
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiLIP0h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiLIP03 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25C58DBCA
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:27 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599585;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=96jYxJl4C5JGlu1+xN05ijcTvTHdJniwDSxiV7ebjrs=;
        b=ENsQRl8k/Y8DQz66BPhFdlcjKMg74RHPKa5SjT+EJAh+Ie9KHlwIg0aSwjhREtE+r8U7u6
        lOn7K13cJI/34vQTkH+jtlTKZdHWsehLWjX/Dr0SStOE4ZSCp8qdWWCxkxP6eCaS7KOUAv
        lNJ5HUfFMbjVlDugoG35X1BQESgUJq7jFeWlojyKxYHf2NFNw6Q8qQf81jujTz/pwQ8fqe
        SZ3QKOu0P31urZwgVXrgOccDmnKQSUWgnwmnASMYmp3VjVtp6WhF3yAAQ625dZcuE1f8FX
        O4puY7YiGouEZs2wrFmceqaF1q1Km7nySe1rBqOldh9K+HyVq8CS3md9LfBtfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599585;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=96jYxJl4C5JGlu1+xN05ijcTvTHdJniwDSxiV7ebjrs=;
        b=LYfhKzCcf0b1XwHcs04xE58B6zDRIPsw6hVaXTgQRnMbBQGR+nhqL3h9dSAJBgC3fCIGB6
        e1Oyrd2RSW82U4Cg==
From:   "thermal-bot for Neil Armstrong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: qcom-tsens: Add
 compatible for sm8550
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org
In-Reply-To: <20221114-narmstrong-sm8550-upstream-tsens-v1-0-0e169822830f@linaro.org>
References: <20221114-narmstrong-sm8550-upstream-tsens-v1-0-0e169822830f@linaro.org>
MIME-Version: 1.0
Message-ID: <167059958552.4906.15143657012593622851.tip-bot2@tip-bot2>
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

Commit-ID:     2d709c4f0520bafba4a797b116d3504fc70af99c
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//2d709c4f0520bafba4a797b116d3504fc70af99c
Author:        Neil Armstrong <neil.armstrong@linaro.org>
AuthorDate:    Wed, 16 Nov 2022 11:09:50 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:45 +01:00

dt-bindings: thermal: qcom-tsens: Add compatible for sm8550

The Qualcomm SM8550 platform has three instances of the tsens block,
add a compatible for these instances.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Amit Kucheria <amitk@kernel.org>
Link: https://lore.kernel.org/r/20221114-narmstrong-sm8550-upstream-tsens-v1-0-0e169822830f@linaro.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 5bcfddc..7e04804 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -58,6 +58,7 @@ properties:
               - qcom,sm8250-tsens
               - qcom,sm8350-tsens
               - qcom,sm8450-tsens
+              - qcom,sm8550-tsens
           - const: qcom,tsens-v2
 
       - description: v2 of TSENS with combined interrupt
