Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A02A73AE66D
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 11:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhFUJt3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 05:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbhFUJtO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 05:49:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80474C061756
        for <linux-pm@vger.kernel.org>; Mon, 21 Jun 2021 02:47:00 -0700 (PDT)
Date:   Mon, 21 Jun 2021 09:46:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624268809;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KYqU0Bsv2J2ZVdkV+MqzEeklRUdwDghevJ6gUCUb/Lw=;
        b=20Kbsmu+t+Uy3jwQ1m0hukQ5PJCw4WaVR956juwwUWNhPQKhvdFVsEGy0uIjNW3oZ24zZO
        M05NXlV7ZYctwK0163Wn25ut01Y9jYO4qhH0tWVZ8otmKH9eAvC4Jpyi5equjpi69Tt+0r
        TmDCTWcUqLhOQzCY/hUt1wcAPI2zjtFdUUgBdX18mTyJeM8TyCqt8/VN+ASNhRTMK7e0Kx
        i2moM0K+bEA1FlR5Odoj46NKdomiKbncPvEe1C76oeGGcsPZdyoKKeiqoH/m5Fdr0GmLiL
        8/7PDYmJDLrZrwwJ4YqX3tGlb7mLGhnSzzyJ31bCJsbPspQeETg/eqrdWlnJuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624268809;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KYqU0Bsv2J2ZVdkV+MqzEeklRUdwDghevJ6gUCUb/Lw=;
        b=NX91Y7TVqaDAzo/c6aERCNHmByAkO9Fn+1Kn8bSL8LwvfuYrUMyTKGRpUggl0snPaI5NOP
        dsUBYH/OokbddXAg==
From:   "thermal-bot for Rajeshwari Ravindra Kamble" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: tsens: Add compatible
 string to TSENS binding for SC7280
Cc:     Rajeshwari Ravindra Kamble <rkambl@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <1620367641-23383-2-git-send-email-rkambl@codeaurora.org>
References: <1620367641-23383-2-git-send-email-rkambl@codeaurora.org>
MIME-Version: 1.0
Message-ID: <162426880851.395.17596472993346184043.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     c6e66f5c21147567f0a09c1d0cbfc32fc894b083
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//c6e66f5c21147567f0a09c1d0cbfc32fc894b083
Author:        Rajeshwari Ravindra Kamble <rkambl@codeaurora.org>
AuthorDate:    Fri, 07 May 2021 11:37:19 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 12 Jun 2021 21:07:23 +02:00

dt-bindings: thermal: tsens: Add compatible string to TSENS binding for SC7280

Adding compatible string in TSENS dt-bindings for SC7280.

Signed-off-by: Rajeshwari Ravindra Kamble <rkambl@codeaurora.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/1620367641-23383-2-git-send-email-rkambl@codeaurora.org
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 0242fd9..0d4cfe0 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -46,6 +46,7 @@ properties:
               - qcom,msm8996-tsens
               - qcom,msm8998-tsens
               - qcom,sc7180-tsens
+              - qcom,sc7280-tsens
               - qcom,sdm845-tsens
               - qcom,sm8150-tsens
               - qcom,sm8250-tsens
