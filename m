Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6423B8001
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jun 2021 11:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbhF3Jdf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Jun 2021 05:33:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59564 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233827AbhF3Jde (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jun 2021 05:33:34 -0400
Date:   Wed, 30 Jun 2021 09:31:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625045464;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sn9tO8Zd2lyDWREqSHXe4v4qiKW+J4hrHo8Ee4D3Sps=;
        b=4Sz6TaBLgmBpDUHsaOJ1+ajLJ9vadWZd9jX5XrMLDebopOMERpQaMhE4eIgnfmx7NOZU2Q
        mqrv4Tw5crG7s7pjPTBf1nOHtu4azWB9yeCDdO1t8FeKpbrrwAWwgpI9ynPdpMJNsshpPT
        SYzUmoO4Cma4bFAoo8UpIEpbWF6YAcy3GiLFJ83fVHaFthgy5n+Df31YMvdbFkDdPvBct1
        Tvxnw3sPn6s+DSWU1FDT46hwq/rDCbojLRngN0TyIzsQq276vhqpvqL0iPgMchMDVgCuFs
        HTl97URm+Sn5vKWNPKX8ajncBdNtdiDzPBWsR1FfE+dlMB5prfHxZUAtQmv1Aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625045464;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sn9tO8Zd2lyDWREqSHXe4v4qiKW+J4hrHo8Ee4D3Sps=;
        b=snZTcQNw2A5c5CJwcNu5UDeGcZkAuMMGlu1dVgAGAlPQ0uRZvAG9pnc3FWNwhE0i9oy0Oa
        Q6pzY1L5r2suD9Ag==
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
Message-ID: <162504546412.395.16858670632126215451.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     b0abe16a26f7c79dcbee05b4eb18b590a8f625d9
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//b0abe16a26f7c79dcbee05b4eb18b590a8f625d9
Author:        Bjorn Andersson <bjorn.andersson@linaro.org>
AuthorDate:    Tue, 08 Jun 2021 13:16:38 -07:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 21 Jun 2021 13:43:36 +02:00

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
