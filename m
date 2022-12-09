Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F698648537
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbiLIP1F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiLIP0l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62958900ED
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:35 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599592;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+nmFtaxdvKupHIPqBoHg2Qp5jEX+7YwB+eNs6DFwld0=;
        b=AoGbCobin9Cj6RlefKvPXMVc2tq4FlisNIEJodjzExNFXg5dMsvJcg9osmw1jWQuw0iw3P
        40B7R/qIFdJ47dz1qKDoeoedIzkeUn1yiofe1H2uoI0cSLjg8GCuuMKGmCsGR96Dv5erqP
        77M7pqIBAVItIDnrnCyn3pUokA/52k8buqMkOYy526WhIbqZaf8RHGZcOmCk+g/M2Kt0Ce
        yT1IqyagP++OpIsuUiT4aI1r78l4nMtDpFXrfdTf5+j2eUT4uwYlXSiVCpcYnpFrpNKqmx
        fPHCh89d6z8vkoUqFossbQUA7bvXHDhV4NAYR2ICljldz+VOpvr08QfJa1Llig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599592;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+nmFtaxdvKupHIPqBoHg2Qp5jEX+7YwB+eNs6DFwld0=;
        b=4w04+JMm0OzkA3/WtoaKA/t6hkThjrPh1bb2sYA4CD8T9H2K8jAA0qDFszQfWi7mpcvT7N
        4bGWyXPfPPsIf5Dw==
From:   "thermal-bot for Luca Weiss" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: tsens: Add sm8450 compatible
Cc:     Luca Weiss <luca@z3ntu.xyz>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20221016090035.565350-5-luca@z3ntu.xyz>
References: <20221016090035.565350-5-luca@z3ntu.xyz>
MIME-Version: 1.0
Message-ID: <167059959190.4906.3499958315515314066.tip-bot2@tip-bot2>
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

Commit-ID:     b7fb2fb8af74f9d5d90dde7cdddd16ee626e8a3d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//b7fb2fb8af74f9d5d90dde7cdddd16ee626e8a3d
Author:        Luca Weiss <luca@z3ntu.xyz>
AuthorDate:    Sun, 16 Oct 2022 11:00:34 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:43 +01:00

dt-bindings: thermal: tsens: Add sm8450 compatible

Document the tsens-v2 compatible for sm8450 SoC.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20221016090035.565350-5-luca@z3ntu.xyz
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 038d813..7db905c 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -57,6 +57,7 @@ properties:
               - qcom,sm8150-tsens
               - qcom,sm8250-tsens
               - qcom,sm8350-tsens
+              - qcom,sm8450-tsens
           - const: qcom,tsens-v2
 
   reg:
