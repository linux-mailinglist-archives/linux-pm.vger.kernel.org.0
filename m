Return-Path: <linux-pm+bounces-23970-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 655C9A5EF15
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 10:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E193A6206
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 09:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67074265CB9;
	Thu, 13 Mar 2025 09:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZjKhYlY9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDD42641FD
	for <linux-pm@vger.kernel.org>; Thu, 13 Mar 2025 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856917; cv=none; b=SCeY3s2mjmUxz8oXS6Wr9dwZEbWDm7A/SLvV0A6d9a/fNE2BNNcgEV/XA9s50ByG2351seL4IfMCg/wSp81Wzt7duJTCo+aYvYGknAeB839/SJAp0dpUZ9xMXWxV5ywYe3Nhdq7DEP/DpThLnS8tN1i+LubtG9dVvhrbZ0fIVLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856917; c=relaxed/simple;
	bh=qAyAb7vlWfwP2sfAoEmFlu57aFIDtj2aV3039FCy40s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rsdhzict+SDZ0Unql6E5TZdDDNCuIkAIEiZ6cF4WxJyw4lJirnmzjZ4Zd7WSKWMZDbft8cM+C2fW8gbkBWa7wsTLld9YO7srIAfhsr9PeeRcsrs0fGSU82FaZnAmE0hYgmCNiWl8OqveVjO7/4WLfl7xWo/U1SAQ2eVPLUWz1ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZjKhYlY9; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43d0953d3e1so950795e9.2
        for <linux-pm@vger.kernel.org>; Thu, 13 Mar 2025 02:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741856913; x=1742461713; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PyftRdAUh/+YzjqcuANuwKqvNAvdaMYJdlFw5zAWwfU=;
        b=ZjKhYlY9thTf5d2dPzv8OJgylR1sVmzNr3hVg9ByNVGmUKUXlXhes2I+yx3WHpx01j
         L8OyDyWL+VVpClWIKDIyta7S8dgkxNXW51ieDMzDHNIZuRmR5VCN5qVf3Bv88TPBsfqa
         rgENemmsieD5msWUo6BaM0Ma/h67oUx1Ip/mmkO1B/urGImtkassiVG6QbMqdXlFEB+w
         TK8RpB5tnPFdV7Usxx6bSOBrfnMsGhf8/2JD5m/AHG+rs5ivUO29UsXYkr6v1Vn6Src5
         Fa/FHA02FRSOQnD0ECY9B6c8MeYzcO5rmTv8ewwsnj8Re692IgPNCFIXhRhPgWB24Qy2
         ceGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741856913; x=1742461713;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PyftRdAUh/+YzjqcuANuwKqvNAvdaMYJdlFw5zAWwfU=;
        b=dpRtZ5BuImAcIhWmVyw+IUClwwu76ECKKDb4PtlBBaDCDR1CPDdOx0juwlULhE9IAC
         xo9rLSFavYcoIsas6x3R5ySkkcGf3v/LHXsoPdWWkY1lCS1fhwGq8njJF6DcbMuoiyr5
         inVrKiSvdTwzFryn9oZEf+9msv0neZY4V2pZ0vBYztb2YuZinBmngIMCjIkYE9MNHPIh
         dz7/u2uExbNkU7K8Cw/HwslQqlJV7WAwA6q+DTDx+7Y9yU5JkTBXsVm5AZYqdh+skj83
         63Uji/UBDVTWl8srvnbXZf/rK/WbkbBj2nNYfh8nOjFa16vzU2FUza3RKHRHsVQaXd1O
         IqQQ==
X-Gm-Message-State: AOJu0YwFNA9p5z/gBhv7QTphdALrJDDdag5CJIEUkjRL3CX4kYQA//kU
	Or15HXbnRZlQkoETWbtZQSR21izVW94lub7TzrpQPVpHPHCJHRR6rmyfeBki+IDDFOqAQ22y0nU
	d
X-Gm-Gg: ASbGncuJLOaT0UiFS7kstKM0UGEWQ5apMmytSDaH4rj2q4D56CoDVd2KZ1vgbS/AiX3
	2WcGXCpXiMwzL4nhciou+vuMSZqnzcyC5ZcLwDhktSnwmyeL4vSy85GjloMqUIx86KxhmBbfyTf
	gX4QxG3kiLv9qHG8rH1nOJwIZwl4N+exuubdh+1fk5cm+eONsWoBhjs+7zkystoSZnAKTONcz65
	RHjiEvEKMugTyaw72TfoNXoJkbBEV/gUj9yEIJHlqknBGtnYMf4gwio5/v3GlEM+plwa0qo4q3E
	9fTv6POTkxlA6ecgnY2MLUTrwjWVg7j3TVEUopOU7JaOYJnioW7XHKAvbEA=
X-Google-Smtp-Source: AGHT+IHq6iofUZBOgqFRLwrXGOhu4UCiFYMUJQXU5MMd9JdEmwlsyhYqkP/syRo57fMFpvw0fYixvw==
X-Received: by 2002:a05:600c:198e:b0:439:94f8:fc7b with SMTP id 5b1f17b1804b1-43d01b87df4mr42763155e9.0.1741856912678;
        Thu, 13 Mar 2025 02:08:32 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cd78sm1414706f8f.78.2025.03.13.02.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 02:08:32 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 13 Mar 2025 10:08:21 +0100
Subject: [PATCH 2/3] dt-bindings: cpufreq: cpufreq-qcom-hw: Drop redundant
 minItems:1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-dt-bindings-cpufreq-qcom-epss-v1-2-62b0f96ba888@linaro.org>
References: <20250313-dt-bindings-cpufreq-qcom-epss-v1-0-62b0f96ba888@linaro.org>
In-Reply-To: <20250313-dt-bindings-cpufreq-qcom-epss-v1-0-62b0f96ba888@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1016;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=qAyAb7vlWfwP2sfAoEmFlu57aFIDtj2aV3039FCy40s=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBn0qCK4ntAwaz6/yknB+AIAHicobzFZUJaHdz1/
 nU51xBfHgyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ9KgigAKCRDBN2bmhouD
 11k1D/41DYC+8VudiEjE9gwgYLoAsAMtqqDwiyl5Ng3/lXF4Yx+eJLqxxDtSSpzvt1bCK7J4TGm
 e1dqdt6iRCxgtn9WoVL9FuwLM188nEbPq9fxibkoHIIEIoQ6c7U4c8P+eIqk+PvmkXbb5T5QpFq
 jPOFMhaEg5/rTw9Xb+/zAY7TOGwmDlB2C/CgeUXc3n+dmdam7klkJ8y98Ypb88f2e5CPgY+cGly
 GOuiaef3ZPi2cnIwhDhq+JW+qj/RkaYGx9uylAk6jkwNj3qV965aaMRwy9qxun/FK1zBYCzrHhN
 GBTHFBsJlL1+wcniXrSOMUEY7j3SbtDPdsbwTBRykbj8fm2SfcqKQzq93FYa+Vh/uAxLO4G5nUC
 0AOZ8Ndd3ZtxNEjIxiQ+qZowAtv+MREIze8OlBBA2psY/HA9jPKpTcfsu1B3k5kAh5L+1bQYCus
 mbY3b6treDGe/kO35RW9/mhCSSxaRI7GoMEkEbnKtib1VWUIQC2g/1UV1jZXODGY3qSRqP6sLDH
 zoxASPBwkmyQ4S6GCxhTXIdg4SrvjQGJuwYqQiBscS+niaS07GjljT3h6zneR5JtKiZs4JDQreH
 nNgq6OOe35vuXt9V+2tbVbz6OigEn6EDkY34jrdX7ww+x2AkBHS3gNTeDLn31DF+6nN7mzM5nrR
 g2z45lJHMBOe4JQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

List cannot have 0 items, so 'minItems: 1' in each if:then: is
redundant.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index 6633a70e322019bf2f1cfdce8f3225b307dfffb6..5c53ceb265b6f0f98509ef1f45aa246e95a20a22 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -114,19 +114,15 @@ allOf:
     then:
       properties:
         reg:
-          minItems: 1
           maxItems: 1
 
         reg-names:
-          minItems: 1
           maxItems: 1
 
         interrupts:
-          minItems: 1
           maxItems: 1
 
         interrupt-names:
-          minItems: 1
           maxItems: 1
 
   - if:

-- 
2.43.0


