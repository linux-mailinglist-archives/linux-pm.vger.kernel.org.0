Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D172F4D22B1
	for <lists+linux-pm@lfdr.de>; Tue,  8 Mar 2022 21:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350250AbiCHUeu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Mar 2022 15:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350256AbiCHUet (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Mar 2022 15:34:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3C83FBFB
        for <linux-pm@vger.kernel.org>; Tue,  8 Mar 2022 12:33:52 -0800 (PST)
Date:   Tue, 08 Mar 2022 20:33:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646771630;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+4MQmsNJlBVqihi/QEF2Im/WFD1D0YrDzH/ZMRF4f0o=;
        b=UJBgT8JQ4lXC3IpfYc7+gIEsMzBr2R25QN0J1TePMstr2v2PyixurL4skC4y3H3rND3TgV
        ugJD6y7iOkKBmnNG1/btKblRZ5H02xxfud1p7HI8hmxDdNYTrmgOgjL7wyDof1UVpyW/aI
        GA1nm3RqEQrMcRRM2EsYta0yYOSGwRc5TNhZjoki9GqHwechqZoZ7z9yO00FY1lChwQ1NM
        ML56LG5SYbdyj/wXFOP61sbnt3t80v6W8dnjSDevK2msoEPxMwPZIRjXfkJeG1crSm+QIl
        CWRK3fLgBNqthg9UfXYZ4ebBq3Zc1cF7X54cV9IPyfwBdPOUz0FZ3JHBSo/kkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646771630;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+4MQmsNJlBVqihi/QEF2Im/WFD1D0YrDzH/ZMRF4f0o=;
        b=hm7hiKLugn+gcKXphZftml9fjpc4SXhvVrz71jsgDAaO43PbtqfIEtU88JzKaG/4gHNAvl
        SKk1hg915zCfLpAw==
From:   "thermal-bot for Thara Gopinath" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: Add sm8150 compatible
 string for LMh
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220106173138.411097-4-thara.gopinath@linaro.org>
References: <20220106173138.411097-4-thara.gopinath@linaro.org>
MIME-Version: 1.0
Message-ID: <164677162852.16921.16466906434736673664.tip-bot2@tip-bot2>
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

Commit-ID:     1f43fad1018a47a3c1723608e64fa01c12bafb81
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//1f43fad1018a47a3c1723608e64fa01c12bafb81
Author:        Thara Gopinath <thara.gopinath@linaro.org>
AuthorDate:    Thu, 06 Jan 2022 12:31:38 -05:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 08 Mar 2022 21:26:09 +01:00

dt-bindings: thermal: Add sm8150 compatible string for LMh

Extend the LMh dt binding document to include compatible string
supporting sm8150 SoC.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20220106173138.411097-4-thara.gopinath@linaro.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/thermal/qcom-lmh.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
index 289e9a8..a9b7388 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
@@ -19,6 +19,7 @@ properties:
   compatible:
     enum:
       - qcom,sdm845-lmh
+      - qcom,sm8150-lmh
 
   reg:
     items:
