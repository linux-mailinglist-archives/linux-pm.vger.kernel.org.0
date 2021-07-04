Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2A13BAE2F
	for <lists+linux-pm@lfdr.de>; Sun,  4 Jul 2021 20:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhGDSFI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Jul 2021 14:05:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55822 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhGDSFF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jul 2021 14:05:05 -0400
Date:   Sun, 04 Jul 2021 18:02:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625421749;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UcpZMUIKtSL9qySp8tzLX8nBr5RS+uqGKZGjMDwcPMw=;
        b=T96Ic4Hh6Pt/IFh6FPR/tRup00Ez5W5/+GiAsXyyOnbmAPWTHvwYX5iffTF4d+DRyaXUsb
        HbrhOerite2JVq92mMP/3z1KsA6OhwcrblKjFvYfUKnLGWBQ4Bgy/MTOJogBraonakqwdW
        Ot9FIT7z4GbjXKkKgsRXi8XqV2HUpvkBA1R7dg6mkUM6CFy97qnyOdkT4L8DY3YWzY1w2P
        /u8f4k8ke3PXWMiMh9uD7myo3YrIWdSTUEbmNjov8Ke0+KE1etM0aNyJ+u2eh5VlFe/hh2
        lzACSllRRWX9HKOvsDtSVapZ8vWhIPiV72MR5v5WpYRdL3PFtIbz+eLs5B2AQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625421749;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UcpZMUIKtSL9qySp8tzLX8nBr5RS+uqGKZGjMDwcPMw=;
        b=q2t+ZwTskGH1ojyrfWNWgAXms8cTAU26wDMDnPBlim6jci3YcfsCaJad1qaTDX3Dsy0EcQ
        qCjED5lHW5+zwNAQ==
From:   "thermal-bot for Bjorn Andersson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: tsens: Add sc8180x compatible
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210608201638.2136344-1-bjorn.andersson@linaro.org>
References: <20210608201638.2136344-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Message-ID: <162542174883.395.3150109364004806490.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     481bd297291b59480b87f88f88fbcff59455dcc3
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//481bd297291b59480b87f88f88fbcff59455dcc3
Author:        Bjorn Andersson <bjorn.andersson@linaro.org>
AuthorDate:    Tue, 08 Jun 2021 13:16:38 -07:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sun, 04 Jul 2021 18:28:04 +02:00

dt-bindings: thermal: tsens: Add sc8180x compatible

The Qualcomm sc8180x platform has the usual tsens blocks, add compatible
for this.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Thara Gopinath <thara.gopinath@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210608201638.2136344-1-bjorn.andersson@linaro.org
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 0d4cfe0..ccf70dd 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -47,6 +47,7 @@ properties:
               - qcom,msm8998-tsens
               - qcom,sc7180-tsens
               - qcom,sc7280-tsens
+              - qcom,sc8180x-tsens
               - qcom,sdm845-tsens
               - qcom,sm8150-tsens
               - qcom,sm8250-tsens
