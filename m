Return-Path: <linux-pm+bounces-17499-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 324C19C77B7
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 16:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E6F282922
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 15:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C9815C14B;
	Wed, 13 Nov 2024 15:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aamgEHkT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95AE13B2A5
	for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2024 15:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731512921; cv=none; b=N4vO1hEUCoKonlWSqTyVJtlojQAzKGMU8TtJmyxXYA9dXp7bnW5DaPJcNU+qGhR1lOsVBM95v0hewvuXpjiQRAILCeYcT/r4uK+0HvBjduvDi0+mwCYw8zSsEbqgICJVR6VOApHBP7KPWzU5+qkY/vjmi1KiA8it7e2FkoJztcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731512921; c=relaxed/simple;
	bh=RL659bnvQarRJ9r8n3sVbA7ZTQb14Rvkals8l0jQJCI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D4/jIobYoadvApcUFpasZdrJSxAy/ZOVK4zKtAPmh1znTWX639T4vaS1CBRGOUCdNWEL/FY4HUL2TRkPtHoFdOOMc2DMkfLwzL1a02HiERZMPAMkcYX607MfBy+UOD0wb0YGohQOII7iYzIWsjhOV+c6IFEJ/1f8n/yZHokglwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aamgEHkT; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-432d866f70fso3642695e9.2
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2024 07:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731512918; x=1732117718; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bd0up2GiRpn0qcOZHj+A/C3CFqnTXwWkcKHOS/86bmc=;
        b=aamgEHkTp6nzHZ3/JF7RcO4kooirHFjBQ3jhtSQM+T5FPlu8ayB1xk9RjsSiaW5dks
         pd0RbSoeABPxzRsL1mPXYfE/V5CW5acb5/qD5/2ajWpNf8uvzax95khp6wCfrellUAlm
         fFcNRISVCVEHAcXUWfiPw5vb8lPAAonXYkVu8ug7JVaF3BTdPfsYrvQFSEUkmlZ70t0X
         ZlUlZnI9zusm+xyTjYUKUecScB4R4RfpwQ/QIiwvoBPMpwXd44syS/bRI4z6A8mt86YI
         XaersYe81xJB2L45Bsl8Yelcza1akKAf63VxziElclM12VkOXWEcqh0OpxFw3R/q3Y2x
         LIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731512918; x=1732117718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bd0up2GiRpn0qcOZHj+A/C3CFqnTXwWkcKHOS/86bmc=;
        b=J0Cp2vp3E9ABiS72UcIG7HpLWS+S4TiYbL7XWB1WaUhEHYuD9qJnlx6fujwKq3XgbK
         nFyE1LVxKQeI00jV+qyJIJ1eVL/1M+FVQHUsn5j6WGPXtys21Gq79qvSWWS6h+o2zYmq
         KuYYezDBmy6Os+L04FB74wNuSRyTmmPoant/dcwKOf6hVGWU/YSOeQWqUAo3zSxcFX+P
         AHxld3ZWW+54XfDGm04msgs6C1cttEynZs+PfdqweM4Ob5/Fm8wB5rG/RCd6H6Lr3q2d
         HDpTHGFpk3uYYlOiGslbvnIu1QivWH9Gr4tBBH1zNJYy2twiIcX8RRsSAxhgjnQFwN6h
         TFBg==
X-Forwarded-Encrypted: i=1; AJvYcCUjm1J9eDuNCXyUPQtHGv8WdllYSdK9aYjhTrs4/sJy5y0R1g1iiISvIKQM+htt5KOl8JPEgAeJ4A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj7abox9ABzhvkkLjAcEtBbQ4YxPVRGUoLdyU0Wt0tVajiTaTb
	6IVt/vsNz/0Zgt3BBWyAU6gPW3KzSrILfrkdDNtqAtRKT9YwmLy2kIll8zK3X+8=
X-Google-Smtp-Source: AGHT+IG3pC8aUQ9X1rZkxa79Z/jTacpphqclCjnj8BHxkaLSW/fRvSir7tMu87smaI937OAMFUkyiQ==
X-Received: by 2002:a05:600c:35cd:b0:431:5eeb:2214 with SMTP id 5b1f17b1804b1-432b7519942mr174480365e9.33.1731512918050;
        Wed, 13 Nov 2024 07:48:38 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d54f772asm28445345e9.18.2024.11.13.07.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 07:48:37 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 13 Nov 2024 16:48:27 +0100
Subject: [PATCH RFC 1/8] opp: core: implement dev_pm_opp_get_bandwidth
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-topic-sm8x50-gpu-bw-vote-v1-1-3b8d39737a9b@linaro.org>
References: <20241113-topic-sm8x50-gpu-bw-vote-v1-0-3b8d39737a9b@linaro.org>
In-Reply-To: <20241113-topic-sm8x50-gpu-bw-vote-v1-0-3b8d39737a9b@linaro.org>
To: Akhil P Oommen <quic_akhilpo@quicinc.com>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Connor Abbott <cwabbott0@gmail.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2795;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=RL659bnvQarRJ9r8n3sVbA7ZTQb14Rvkals8l0jQJCI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnNMpQcWF2xTmHi0CbOPCj4dM7H9LbwzfNdxCENI0p
 /HEe2reJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZzTKUAAKCRB33NvayMhJ0WYgD/
 9oblUNeJo5NT6quZjlr2ntrLscrbf7o685MvS6EDfwofPgT4DUuz2mSRJf6yNihR0i7i5Ff9awQqwN
 VQEfonRUBdbRELS05q+5gj7kZUoMxOepmrHKtyiIn87+ntd0LO6auCSv8Q2Zm5LLHaQgl/1XIhz3q2
 zsFBrtD6qtMT+N+aaZiPMKjoRS9oxcczjSC3GaxjK7YRxXwpQTJ4lbuVFz9mIQT1FgTbBZehJL0viB
 NE8pD8SvFg/tQT8ZA4/Zym/D4H2U6Z4nWtzb1Jxl3LdnVYb6NFeOQhirvHIn6klg3UbZ4LY+wMKbXA
 AjzKN7/fF3TVzfJiZC9kdUBh5HwapbW7Ata+u1vdgzqWe4LFxcSvd6S3rRCwvD3JKOAoDI81ParWAj
 s5enSuA6Ef9C9say+bLcFtyQP9KnWBaFW2K4tvrbDVlau7jtEaswWoCAjny/rPNc/cArF6OXqLgx92
 eT9XHZJCz18z98NeOmTLBt6SNYso3wVc/B2P3sVGvpMTJVdS0umM4sGJFu2hcDQEF3YVyyfoWGmTj0
 kqeNHTBjdP2+MzwCMRH75uEkTf5VcaRCio2ErkkiYLv7nj1ra744MqifB/ZdOtIJWeZz8TEHwC1W4R
 qzQCz9yLKTkt0mMswtLDOIgdHWMD8yIne+8dAu7Pvjw9JO1I9RgEF8A/eGzA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add and implement the dev_pm_opp_get_bandwidth() to retrieve
the OPP's bandwidth in the same was as the dev_pm_opp_get_voltage()
helper.

Retrieving bandwidth is required in the case of the Adreno GPU
where the GPU Management Unit can handle the Bandwidth scaling.

The helper can get the peak or everage bandwidth for any of
the interconnect path.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/opp/core.c     | 25 +++++++++++++++++++++++++
 include/linux/pm_opp.h |  7 +++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 494f8860220d97fc690ebab5ed3b7f5f04f22d73..19fb82033de26b74e9604c33b9781689df2fe80a 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -106,6 +106,31 @@ static bool assert_single_clk(struct opp_table *opp_table)
 	return !WARN_ON(opp_table->clk_count > 1);
 }
 
+/**
+ * dev_pm_opp_get_bandwidth() - Gets the peak bandwidth corresponding to an opp
+ * @opp:	opp for which voltage has to be returned for
+ * @peak:	select peak or average bandwidth
+ * @index:	bandwidth index
+ *
+ * Return: peak bandwidth in kBps, else return 0
+ */
+unsigned long dev_pm_opp_get_bandwidth(struct dev_pm_opp *opp, bool peak, int index)
+{
+	if (IS_ERR_OR_NULL(opp)) {
+		pr_err("%s: Invalid parameters\n", __func__);
+		return 0;
+	}
+
+	if (index > opp->opp_table->path_count)
+		return 0;
+
+	if (!opp->bandwidth)
+		return 0;
+
+	return peak ? opp->bandwidth[index].peak : opp->bandwidth[index].avg;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_bandwidth);
+
 /**
  * dev_pm_opp_get_voltage() - Gets the voltage corresponding to an opp
  * @opp:	opp for which voltage has to be returned for
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 6424692c30b71fca471a1b7d63e018605dd9324b..526b707a8d61204227222f8c28394dc3a85c4c9a 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -106,6 +106,8 @@ struct dev_pm_opp_data {
 struct opp_table *dev_pm_opp_get_opp_table(struct device *dev);
 void dev_pm_opp_put_opp_table(struct opp_table *opp_table);
 
+unsigned long dev_pm_opp_get_bandwidth(struct dev_pm_opp *opp, bool peak, int index);
+
 unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp);
 
 int dev_pm_opp_get_supplies(struct dev_pm_opp *opp, struct dev_pm_opp_supply *supplies);
@@ -209,6 +211,11 @@ static inline struct opp_table *dev_pm_opp_get_opp_table_indexed(struct device *
 
 static inline void dev_pm_opp_put_opp_table(struct opp_table *opp_table) {}
 
+static inline unsigned long dev_pm_opp_get_bandwidth(struct dev_pm_opp *opp, bool peak, int index)
+{
+	return 0;
+}
+
 static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 {
 	return 0;

-- 
2.34.1


