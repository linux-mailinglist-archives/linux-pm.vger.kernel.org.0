Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 196013608D9
	for <lists+linux-pm@lfdr.de>; Thu, 15 Apr 2021 14:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbhDOME2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Apr 2021 08:04:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59462 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbhDOME0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Apr 2021 08:04:26 -0400
Date:   Thu, 15 Apr 2021 12:04:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618488242;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zxEiPGLlAhnei/9Fj3y170UrWM1okjqbIybZJEzuMks=;
        b=r/tpxQHLRWan+FkHdApR4t7kXr6D4IzkLOrP+CLtxIlio0Btojo9hu+4idrg8EihDhUBO4
        5sBGB8nUnAIw77KakIxyhmNNqsY2TLSP8pMBUvYRSumjb+pe1R0zUJdAeTaCs0ZhJemBI9
        cIq59Gxa4MtqR6+nMeIVbBuzIvhGQmdZ/jO/zn/8KeDV4p4n1n63LWF3FhVKZn+dpMoWf/
        yYWn96a+fsaFbrPbLO9W/Cw0hsa2Pac3Q77NT9Lm+XrFYCXIYb4DbPydYvYA/gOkZj9kMH
        uhA73xdXtkxOKW7wT3N4EMlN7jC1PXFNzmuZGZxdezEGsXrcFWjEHDCgAMkUAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618488242;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zxEiPGLlAhnei/9Fj3y170UrWM1okjqbIybZJEzuMks=;
        b=Ig2X239sURr+czSh18zqOOEcj7wOGFs6l3nKMqHMEpp/MKo0mj1Ypfde0oMEUFaxmPyoOP
        QLeNEIy8VMh2lYBA==
From:   "thermal-bot for Konrad Dybcio" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: tsens: qcom: Document MDM9607 compatible
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh@kernel.org>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20210319220802.198215-1-konrad.dybcio@somainline.org>
References: <20210319220802.198215-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Message-ID: <161848824203.29796.721392079428413228.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     957781612e44f9525a8c7ed52086ab4caaa301f6
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//957781612e44f9525a8c7ed52086ab4caaa301f6
Author:        Konrad Dybcio <konrad.dybcio@somainline.org>
AuthorDate:    Fri, 19 Mar 2021 23:08:01 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 15 Apr 2021 13:21:42 +02:00

dt-bindings: tsens: qcom: Document MDM9607 compatible

Add the compatible for MDM9607.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20210319220802.198215-1-konrad.dybcio@somainline.org
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 95462e0..8ad9dc1 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -22,6 +22,7 @@ properties:
       - description: v0.1 of TSENS
         items:
           - enum:
+              - qcom,mdm9607-tsens
               - qcom,msm8916-tsens
               - qcom,msm8939-tsens
               - qcom,msm8974-tsens
@@ -94,6 +95,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,mdm9607-tsens
               - qcom,msm8916-tsens
               - qcom,msm8974-tsens
               - qcom,msm8976-tsens
