Return-Path: <linux-pm+bounces-12822-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C2B95CCEB
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 14:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3B01F2203A
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 12:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD55188900;
	Fri, 23 Aug 2024 12:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T18ARMPQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A345C188001
	for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2024 12:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724417499; cv=none; b=NLzdxWR0yAtYoD96Y/THioDaPfUPAKojyb1VxsTmvLP7CIUIyyVI+Br7Lo04kVuKypFvCkcSXRBE2VMl0tQU2AP7Np3IlWQ4ZLTXnXaFgojKZVuq6KQVgPzJ8bKCFG/mE3UDgBKd22dH6V/gh0me3j/iekKfLmpQ3m821a5KDhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724417499; c=relaxed/simple;
	bh=SsKn+XKGNdg5Lu4TYJpa1Z5yeroNI9GQomQEQv1kKlo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AVEDNJBU++CXGjvpb/4rgEAzgyD12TD3Lvlkq+6uVZiDYFWZ8v0eihIYjb1RQEAMxHjCeLZGVvkWo7zE3Exapdb/6Xzv7RxP6vCaOy9qHApwheJlu4S3x/IqHANgYD60oX7dxBFqXYfNl5xdc+wqN0iYuKA09L1F/jnIiga3z/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T18ARMPQ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5bebc865578so325141a12.0
        for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2024 05:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724417496; x=1725022296; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sa/KHRgT6a9iG3/ETlQHPI59tAN0SqbzEBXVbMy78Ls=;
        b=T18ARMPQSlmoGh4NlPQ4GRI1+eex+9BQlgNe6kO0m6r2fab9xjGOzCrbodvb5EtrUu
         50xr3JNJbFmUuJqOdxBH0Sln0Y/WhYGzQXmUBGw6RrNJI+gUJSM1ES65/QuTsLWFqrh2
         J49qZT6ADr5BKWO1sMrP6hHgk6VV2ibYsXozDJmsz88rj4YkirWMoKsD5P/MozxZfAbV
         4SYJ053CTIZGhzxaai0JeLHLmQ3LbC5wydw1rWCDyb0Kb8+DNdmZWGMqcKJwbSLIpPa6
         f/FB+H2ZhmfnwYVIfQp0XznIbbmEH+ZIiF1GZpv8GSpNckivLcstfYHKWD+N/LdFBm/V
         TJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724417496; x=1725022296;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sa/KHRgT6a9iG3/ETlQHPI59tAN0SqbzEBXVbMy78Ls=;
        b=oQQXJ2+bRLKB+WFbDmbzvZYsNPYkvK1R7HU11x3PtEFwHEDocKclpQKlyLrhUaI666
         588Tf/bpOjR/g4qu6jrGVrowQ3ItfFeFafdnjIDIDDVHSzynkDe4DTFxMejYnv4eR9nz
         sB8PSp8fbwobQKOMkovIt4sleglV/eifcg9hxxAlrMaNfEvV+2EZXb1GIGL0IFoUPrMD
         N7vCMEgOkZS8XQbMTU/ZjgOJ64XuhAqdnyDO5/n0N4JXKG0LLd3O+HtJNnBcRIbKtAOJ
         o1g8domup27JSfUehDPJ6DTFZYJB70K7lvNGxieOR76j+2mwBdVfc/r4Oz+JtX4BkhIp
         9Xzw==
X-Gm-Message-State: AOJu0YxoiYYiStmIIqtKOnhyjGde6VjIImFt8sH6+A9ktmDywehl1Fey
	+run152XxIwlxS2IYASh7D8+OlvBq7rml7hwVhyixBVj7gMoEW5eBhp05XJ27gs=
X-Google-Smtp-Source: AGHT+IEdA/oEZ97C2qOqfjgHLdf7GZtFRbhRivaHzioPPap69e5acBh4T0xkHuu904RyEID7S6Zhew==
X-Received: by 2002:a17:907:968c:b0:a7a:a2e3:3736 with SMTP id a640c23a62f3a-a86a5489a72mr92536566b.5.1724417495945;
        Fri, 23 Aug 2024 05:51:35 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4f384bsm255931666b.192.2024.08.23.05.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 05:51:35 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 23 Aug 2024 14:51:09 +0200
Subject: [PATCH 05/10] pmdomain: qcom: cpr: Simplify with dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-cleanup-h-guard-pm-domain-v1-5-8320722eaf39@linaro.org>
References: <20240823-cleanup-h-guard-pm-domain-v1-0-8320722eaf39@linaro.org>
In-Reply-To: <20240823-cleanup-h-guard-pm-domain-v1-0-8320722eaf39@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=863;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=SsKn+XKGNdg5Lu4TYJpa1Z5yeroNI9GQomQEQv1kKlo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmyIXIAE/UDGNyaNfdauaVBO6LIu+O/X2S8PcEz
 tOZoQCDU0SJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZsiFyAAKCRDBN2bmhouD
 1z9AD/0SCxM4givKRDsROWCOR5j/+4VWWxQLgTTNLssfQNDBH81XPQ0y6u5DXPpwX6GDZuFE0KG
 AGCPQbxe50w0leYIkSfhdQcmHV5GegOp93DcIhTKAThLFFJJfNFoNYm6NLqFo+2/JngjpIWosI/
 jumqWnbvSxujOR/S5APTM6m2LisQte5FJFkVfp0fy7rTJNPjWBea8nhcre0gRoU+ECZ6hnDuogv
 Rc/ncG5TXQntXUbni/M98iXqDOMb79XVVsYwRMW0h2ZI5ATxcP+xF/BMpXSO4tSwAtuvaScNZrA
 +lOW8wz53KFD3F7iaOVpgEQ4vgqzNaWaBeh6g/8kgAwcWZZroJsPA/HGbulpkzCgvujAc8yIe4Y
 L3N7+1BRdGP1/+0DkFhr6q7hC6IoetUMtK8/S/OlnoZU6tIZCzL3dsFEGvIjlAGSJFV/eHSY5Ui
 X3BsRg5nI5eL5F5bwKuXxXzGX5IEu8uwLYdvRQfITeluiSylB/x5sDeQffM/PHtDoDQIddbd/D1
 eTzAs/GUBiAJiWE5lLNx1Wa65YWa3olzZhJCbZtGbt3XKLVv+gxrwcCCtFCJt8KpW5X5kcMIFNq
 RbIza/sGz8mkdHAj5bG4X5zTXQ8cabGsaE2qdP9UWVpiyzj4Jv+c8oDlCZ5WWwUlU5Z9cnpnkrW
 xm+1Jwl7sUAchbA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use dev_err_probe() to make defer code handling simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pmdomain/qcom/cpr.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pmdomain/qcom/cpr.c b/drivers/pmdomain/qcom/cpr.c
index c64e84a27cc7..1bef89712188 100644
--- a/drivers/pmdomain/qcom/cpr.c
+++ b/drivers/pmdomain/qcom/cpr.c
@@ -1470,9 +1470,8 @@ static int cpr_pd_attach_dev(struct generic_pm_domain *domain,
 	 */
 	drv->cpu_clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(drv->cpu_clk)) {
-		ret = PTR_ERR(drv->cpu_clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(drv->dev, "could not get cpu clk: %d\n", ret);
+		ret = dev_err_probe(drv->dev, PTR_ERR(drv->cpu_clk),
+				    "could not get cpu clk\n");
 		goto unlock;
 	}
 	drv->attached_cpu_dev = dev;

-- 
2.43.0


