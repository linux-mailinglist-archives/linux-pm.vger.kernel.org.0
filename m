Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943613608D0
	for <lists+linux-pm@lfdr.de>; Thu, 15 Apr 2021 14:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbhDOME0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Apr 2021 08:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbhDOMEY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Apr 2021 08:04:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FF4C061756
        for <linux-pm@vger.kernel.org>; Thu, 15 Apr 2021 05:04:02 -0700 (PDT)
Date:   Thu, 15 Apr 2021 12:03:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618488240;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vVSTSEObDgSbWpuvk9rXnhHt0pG1N7lmb6HKMij7jBc=;
        b=OFeCKqxZNyPZkKdUpN4VUIjR0/jYLhxztAjbeJwN2TwSWeB2NTBerIo6miQfRvjboe8jFh
        Y/IRRiQPf0UR3JVRebEuVL3gIQECeci1jlAUiBQYPu/Ih2R1bK8PNNS/DbYdydv86WYDVU
        GvdgVCUmfIQIxJIpfqcbVqX4rt/x4Gc/vihk0X9AlbiKjyr2FlfMD+yMg0+dNOxeqdgUaw
        jY3tEwl1LqzkZSE8KHQxBLnLHF7tvk2XRnB20vCi5bCmkUBDbmvKY4lV92IXCaMnTz+I6l
        kk6BTIH00b16WGbCZBbiKEHwbduLuGSLxFoHk48N1Dnv/9s1DmOIGkjFQfpc5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618488240;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vVSTSEObDgSbWpuvk9rXnhHt0pG1N7lmb6HKMij7jBc=;
        b=9buFxcfDfuBO+pVHpozUFK72StPLgw/1ro1Oqv/rgQ200VNDmy8J4Bx/TRotb6Ktokbigz
        qjvsPgbBnRDOlGCg==
From:   "thermal-bot for Robert Foss" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: qcom-tsens: Add
 compatible for sm8350
Cc:     Robert Foss <robert.foss@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210324124308.1265626-1-robert.foss@linaro.org>
References: <20210324124308.1265626-1-robert.foss@linaro.org>
MIME-Version: 1.0
Message-ID: <161848823984.29796.18162327130011680736.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     c0612265295bc7bbbc7189ab811192fe77be8196
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//c0612265295bc7bbbc7189ab811192fe77be8196
Author:        Robert Foss <robert.foss@linaro.org>
AuthorDate:    Wed, 24 Mar 2021 13:43:08 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 15 Apr 2021 13:21:42 +02:00

dt-bindings: thermal: qcom-tsens: Add compatible for sm8350

Add tsens bindings for sm8350.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210324124308.1265626-1-robert.foss@linaro.org
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 8ad9dc1..fbd03cd 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -44,6 +44,7 @@ properties:
               - qcom,sdm845-tsens
               - qcom,sm8150-tsens
               - qcom,sm8250-tsens
+              - qcom,sm8350-tsens
           - const: qcom,tsens-v2
 
   reg:
