Return-Path: <linux-pm+bounces-18632-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3599E5C1B
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 17:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ADC61663C5
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 16:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADB2225793;
	Thu,  5 Dec 2024 16:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEjvSqPa"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C4E22577F;
	Thu,  5 Dec 2024 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733417450; cv=none; b=i3swu52MfnUGtCtGY6jLJAw8A7+KmgJbhJ1ysG+xLcXmQIITpbvsbklF5qLmsogbg04Msl0yvNG6u83a5kk2CTKOMz2NNFiN//Weja4ds7vljYcG/YYbNnJF7LUAH8j3ZqCd2zgKKq6hDzCl1APV8PltKNgxfLFttAu1Yjq0028=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733417450; c=relaxed/simple;
	bh=yAhSThl4omNIzqdvqVD2D/bE/H1pTTvDk5NNbO9mc2w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qipAyKyUreHAcJmvp1Dw08N5L1Bl/X5nyecySjG6sQKWLLy17W0TZbUN+kIjSfdCWd+Rd/IHGUiJiej8PZQoc19i+3tWPOELYt4678inI7imoq38+Vcwe6OchWiRXbwWi7qynpDfkYogLsxmwB5F00m578wEg/Ux/pCzFNRJkoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEjvSqPa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8415C4CEDF;
	Thu,  5 Dec 2024 16:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733417448;
	bh=yAhSThl4omNIzqdvqVD2D/bE/H1pTTvDk5NNbO9mc2w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iEjvSqPaZoOAlTu1AD0+FWzRgVIS5YXMVRbev0VhWqn07XgRgaHqoKB2DnL9tL88E
	 C3DozHtwbDTbG/3v+JoFS1Vtc/hZs07fmE7YRtevjTxm/GfgVbRO1ETE3qqO+aS/S+
	 m8O3g5Z78u4aCvxnnecP/FzTEUpFO3ijjse16891SUflsWdAkserinhBNyXYRNzrKm
	 gc6OdBA6TrzPkADmFGkscopd1yya7eaTpZU5Q+TIZ4GhnEmZ35CROvLENWSTOgJ3Be
	 l6Jm0Z6bTCe0yUlIWY0wjSPh83fHQK4eMJXpBy9i2nWK5IDUS3xjn0mgcP+eTfn6HX
	 3Qx2KtbMrP5Aw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F0CE77179;
	Thu,  5 Dec 2024 16:50:48 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Thu, 05 Dec 2024 22:20:29 +0530
Subject: [PATCH 2/2] cpufreq: qcom: Implement clk_ops::determine_rate() for
 qcom_cpufreq* clocks
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-qcom-cpufreq-clk-fix-v1-2-de46c82e0fe5@linaro.org>
References: <20241205-qcom-cpufreq-clk-fix-v1-0-de46c82e0fe5@linaro.org>
In-Reply-To: <20241205-qcom-cpufreq-clk-fix-v1-0-de46c82e0fe5@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johan Hovold <johan+linaro@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2276;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=khSFbu3Z4tQbHex/WaQQeN/MsVZBUcID3RSSj5VHwnw=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnUdnlCmgQOzEeIEe7CpR9509WxbQACDzYr04S7
 Essu7wEu3eJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ1HZ5QAKCRBVnxHm/pHO
 9W6OB/42xevWovBzxQUliFA1DFCKS9UZqAyGl84jmf7C/A8jhyBqy4qi66pl6EYQ9v9lOgFNpfJ
 8Fn0sZ1kTAChcnxc7sQ3qgirhCFlMBmnksdBIlCe2cQtjxXzWw/fiAHWjvxWrbxvyYih1MuUGxy
 tXCEh8qPGlNiM8ks9mzllYqKLvQfDx9U1WEPbRXwglGaf5MsKpygOz4z5NOvRjbc3r8/XtABxOt
 q12B9GZcUgjrimiOcN5uhvySVZsnQ4bi7JFcrNtTZaYLNIBewInhHxtGVrL0HhKfpNaFllwZJl1
 BHjrm8py8bfbLCF9A2mQv0k3DKdr65edXdM/ckfJXd7C129P
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

determine_rate() callback is used by the clk_set_rate() API to get the
closest rate of the target rate supported by the clock. If this callback
is not implemented (nor round_rate() callback), then the API will assume
that the clock cannot set the requested rate. And since there is no parent,
it will return -EINVAL.

This is not an issue right now as clk_set_rate() mistakenly compares the
target rate with cached rate and bails out early. But once that is fixed
to compare the target rate with the actual rate of the clock (returned by
recalc_rate()), then clk_set_rate() for this clock will start to fail as
below:

cpu cpu0: _opp_config_clk_single: failed to set clock rate: -22

So implement the determine_rate() callback that just returns the actual
rate at which the clock is passed to the CPUs in a domain.

Fixes: 4370232c727b ("cpufreq: qcom-hw: Add CPU clock provider support")
Reported-by: Johan Hovold <johan+linaro@kernel.org>
Closes: https://lore.kernel.org/all/20241202100621.29209-1-johan+linaro@kernel.org
Suggested-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index c145ab7b0bb2..b2e7e89feaac 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -626,8 +626,21 @@ static unsigned long qcom_cpufreq_hw_recalc_rate(struct clk_hw *hw, unsigned lon
 	return __qcom_cpufreq_hw_get(data->policy) * HZ_PER_KHZ;
 }
 
+/*
+ * Since we cannot determine the closest rate of the target rate, let's just
+ * return the actual rate at which the clock is running at. This is needed to
+ * make clk_set_rate() API work properly.
+ */
+static int qcom_cpufreq_hw_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
+{
+	req->rate = qcom_cpufreq_hw_recalc_rate(hw, 0);
+
+	return 0;
+}
+
 static const struct clk_ops qcom_cpufreq_hw_clk_ops = {
 	.recalc_rate = qcom_cpufreq_hw_recalc_rate,
+	.determine_rate = qcom_cpufreq_hw_determine_rate,
 };
 
 static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)

-- 
2.25.1



