Return-Path: <linux-pm+bounces-20244-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF1AA094F9
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 16:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9D44166280
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 15:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76797211713;
	Fri, 10 Jan 2025 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xp3b7SOd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C866211498
	for <linux-pm@vger.kernel.org>; Fri, 10 Jan 2025 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736522489; cv=none; b=ph9FBSkcitLuR7zx8y36kGGxBEVOhwemIH3hdB33W/GNgnjA/RJlUmd3DAF7tF2WOSeRIUWI7/cpuOzzcucD4Kmx7GhTusasMl21gU27jxc4Y08UhMls7+M46AHR66Oi1Dqbd9QQOyIfimfR7HNtrNfrLcCDPSvgdXT9W36NZqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736522489; c=relaxed/simple;
	bh=l534KaQHeipF5HnCgvu/4eiMXBXhIzMa6xV85UpDLN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OWqTKLe6qFlJRxLDh/Wb8j14wmi9L+I2qKQp8Eha9v2sUuVmoGatnmc18PMsbNZb+RqXQtZYZuvTQIxxvPtJhmrG1Np9MqSU6VFpZolJyncvLbDhQwOwgmju9/flYIMweLujinMmUzk/FTSoSfxQDH22pplS3rchMxH2uYK3GEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xp3b7SOd; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43635796b48so14324325e9.0
        for <linux-pm@vger.kernel.org>; Fri, 10 Jan 2025 07:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736522486; x=1737127286; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m2QbcPrM7Nmj9mrvDTmLOeka9cuKDtzuzeQZCl6bz48=;
        b=xp3b7SOd88kJ5nAmWr5rZtMbJy/cxH5fi/ImrAFelzk+3QvengnJ9wvoe48EgQXLyV
         spbH5mjgncl6Ocw0uL6ElXDIB6F1FG+neLIHtZ1fNCjpYaD74VBJ7wJRD6iWnyiFBGiy
         RpqGfrMLa/s3t3JvQuPQNpcjsxDg8IQIc3g45GLQmvqmxs2Weq8eHHbKHzqn6ZCzsWLy
         ynGSx4rTaPH7QPcwCRDzW2OV4vEBP5aCezDWqZ86vcihn9JqnLP9NNQRVGmiCeomJynU
         VTrBqsUuskJJl0Cd/ni+g509K0+5/PqYdR+r3JC03U91BkYPnMsMVhYhUa9YvYAyg6yo
         qw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736522486; x=1737127286;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2QbcPrM7Nmj9mrvDTmLOeka9cuKDtzuzeQZCl6bz48=;
        b=NXlfULqMJ4AkdfqbnfI03n0eJ3ZRaS3mGhNEm52hIG8adSQhCWIJcCk+9LLwrpjqJR
         XwJuq1PQEZQsh58JijT9l1KEC2d/NrbjzyadxdNVYoZCFanVsACab4xMts0oozLQApOK
         aJSTmSY32bGcOdT9mObU0OYQWVgB6QYmwlkdcHy1Bd0ngAsHoR6eZp+duEZXVRAoj0wt
         MQ+pWmsbhxp+nLNInurRSMULWGIE8EVu9nZmC1ItKjXzexjPSjzPqI3wZRrMAU38cDB1
         EEKeK7p3zdQ5btkdoEbaU0h8dUVkHpq1+NrBYD84qOAs/GFGLUx6cuwhlySawgkVbSw3
         jx9Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6jf7PZPdMIyzhqrnJ833EvzZ+DmxozDHCMa8tLi7XkmqxzWO0cCu0iU/rrE0srsU3Rk/xmmSM3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyV5+Q0MeL5YykAJCW5M7hkPlsrFIssRjT81b/5t6KVvHonlF/7
	WkefyegfNM0NzihT5J8m0GVvelpRI8nIF/4R1ZdxX/XOQJx7QT05dEYnTt8gJ78=
X-Gm-Gg: ASbGncuH7PyN0zl+u+xe/bVmULwrAhmMCSlbcDGT0UzXkgk5GaU5to9WM+N2D/qyh6T
	Fc2TLXrLo5Xr7nInzDO4Y2eu7CNSIDXEeOB1Bjx9ATXQRgKCMBaGjZhMjysUPp3qkZhgPX5aVV9
	uLBBgU2kM9CZpN0EhGX0l8YIL+Vlm30V/PDca80RwgJRArm13nzMh06biAbrSIjGTwGQfoRj2Ga
	UEIHK83fvKcrhclGd8nXFfo+n17o5Cxq3nPzNS07pCdfim8R+w7AMCAH496I9Bw+7MkVL+BfdvK
	dw==
X-Google-Smtp-Source: AGHT+IFgBtxJrpzTPr4g+5AQ2ZmIp4S/wCyOKInu/fGCQUJx0HNMsvBeprijdCnt0PR9GkdcT3tZBQ==
X-Received: by 2002:a05:600c:2282:b0:434:e65e:457b with SMTP id 5b1f17b1804b1-436e880fc75mr70436245e9.3.1736522485850;
        Fri, 10 Jan 2025 07:21:25 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e92794sm88714725e9.37.2025.01.10.07.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 07:21:25 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 10 Jan 2025 16:21:19 +0100
Subject: [PATCH 2/4] arm64: dts: qcom: sm8650: add OSM L3 node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-topic-sm8650-ddr-bw-scaling-v1-2-041d836b084c@linaro.org>
References: <20250110-topic-sm8650-ddr-bw-scaling-v1-0-041d836b084c@linaro.org>
In-Reply-To: <20250110-topic-sm8650-ddr-bw-scaling-v1-0-041d836b084c@linaro.org>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=963;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=l534KaQHeipF5HnCgvu/4eiMXBXhIzMa6xV85UpDLN8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBngTrxz8g//MYCqCmEp81WLET2vDE3BmWd9SKwIdrF
 eXn2UDSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ4E68QAKCRB33NvayMhJ0cCXEA
 CDcGyq9EzVUCATczcRHSHOAvThKlk0s+TWXlSNuCQzMOdXAc9pWzmIgF86yTYEM36sh68fCvsEjMUk
 MybLIG4bQTGhOXgQPHLns1OqH8lJeOth4E7uDdJo9xozuabGLnIEGN6Yo0Guj6OuVc2yLE7Wr8Q8lX
 ZFYa6bJT1c1KnF4+vrLYZZ4+gsn6A13I+9d3KKK0n0QibTC1OU50o7jaidwNfONi6Uia9EeY64Dpxc
 7j2Aw9N7DWwXX4rRw5r7Y3CE7dj3AN8j9lM4m1tKH19CMuJhLGu3tZcgptUEF4otjs3qe5L/wFgJTM
 LBeRr/MdZhZz+6QPCjL+nDZSRUA9npsn2LRWHokCM1y7fd+JmFqKsjB9p9MubklE18Ty9rPqjhDn74
 PUUIkTLOVqF/MMW95mRBOabkob4WldZgy+A9N5HVrT8ICBInK4cyvkocQ2rwbEOd3/eqoyHU7VpUZK
 BBw54qK4fclNeuAaEOkIXu1AJrp5gtHwN5DwLdELKA69ymr3TKVrmhjQWW/6DjoXQICs3zp5Exu46T
 2WJC5yfJUhh3JyHRjFAchCqvGNIdaanSYbFmq7YgbMUQXSTYXpWijeVWzlKcS9nCOsAExANm8WHbZX
 2LzzGBf/1yqqtHrVOILlU6Weau8aAPWgFG5fV6df5EccGJAgMmR15FQec1fA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add the OSC L3 Cache controller node.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 86684cb9a9325618ddb74458621cf4bbdc1cc0d1..bc09e879c1440873a52daf3fc7a38f451f1f972c 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -5506,6 +5506,16 @@ rpmhpd_opp_turbo_l1: opp-416 {
 			};
 		};
 
+		epss_l3: interconnect@17d90000 {
+			compatible = "qcom,sm8650-epss-l3", "qcom,epss-l3";
+			reg = <0 0x17d90000 0 0x1000>;
+
+			clocks = <&bi_tcxo_div2>, <&gcc GCC_GPLL0>;
+			clock-names = "xo", "alternate";
+
+			#interconnect-cells = <1>;
+		};
+
 		cpufreq_hw: cpufreq@17d91000 {
 			compatible = "qcom,sm8650-cpufreq-epss", "qcom,cpufreq-epss";
 			reg = <0 0x17d91000 0 0x1000>,

-- 
2.34.1


