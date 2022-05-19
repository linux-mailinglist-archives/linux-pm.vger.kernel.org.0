Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE8A52D2C0
	for <lists+linux-pm@lfdr.de>; Thu, 19 May 2022 14:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238001AbiESMoP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 May 2022 08:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237995AbiESMoK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2022 08:44:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2D4BA57A
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 05:44:09 -0700 (PDT)
Date:   Thu, 19 May 2022 12:44:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652964248;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mOsvD/O6Vr7y2mNObl6W5rIyj9JaK+yXw4pr/DJNRgs=;
        b=oLFl/qDL4/w4Yp/LpQXxrbj4OMqKpKgd0rAd1zZ3vmuO37ruz6pqaMv587WZAnVbkxh+3L
        k0PdAKXTJeSLYCT8ZjyZh7O+WDWJCm69xzklViiSyknAP3HQ1dwY4J1xFn4gNDo3XI4eQv
        yy9Dbwf/hkIs3droHvf5e8cWCmcuJ1vAbT+qd9EYbPUpZ1uFiiIP4lShEGaK0VhIuU1oGO
        vuFMX/tk3ZNBhioSCs8I5o3HihduHnLUOWQqZrLFoCFro9xVuFEFSFzygif9ROZh2xt0AC
        rXftpeWmKv/2aZ275kq8GDQR12j9h/bFPO0dIQ8v57MVn8n/UL32s6w+n0OA2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652964248;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mOsvD/O6Vr7y2mNObl6W5rIyj9JaK+yXw4pr/DJNRgs=;
        b=V3lrCo8R8j464YvRvueJjKvjmAyVWxeVrqIHU2cvv2gSDO+7aqI3R38dKGUTUl1qlLhWAq
        vz8KbVt/ve6EKTCQ==
From:   "thermal-bot for Bjorn Andersson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: lmh: Add Qualcomm
 sc8180x compatible
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220502164504.3972938-2-bjorn.andersson@linaro.org>
References: <20220502164504.3972938-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Message-ID: <165296424748.4207.16771027320745324961.tip-bot2@tip-bot2>
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

Commit-ID:     b54d4dafc9fd97f1739eb06dd5a397ce69bbe00c
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//b54d4dafc9fd97f1739eb06dd5a397ce69bbe00c
Author:        Bjorn Andersson <bjorn.andersson@linaro.org>
AuthorDate:    Mon, 02 May 2022 09:45:04 -07:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 19 May 2022 12:11:52 +02:00

dt-bindings: thermal: lmh: Add Qualcomm sc8180x compatible

Add compatible for the LMh blocks found in the Qualcomm sc8180x
platform.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20220502164504.3972938-2-bjorn.andersson@linaro.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/thermal/qcom-lmh.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
index a9b7388..e1587dd 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
@@ -18,6 +18,7 @@ description:
 properties:
   compatible:
     enum:
+      - qcom,sc8180x-lmh
       - qcom,sdm845-lmh
       - qcom,sm8150-lmh
 
