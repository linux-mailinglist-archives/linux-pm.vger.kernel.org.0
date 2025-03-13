Return-Path: <linux-pm+bounces-23969-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B056CA5EF18
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 10:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 323F5188990E
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 09:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2936265628;
	Thu, 13 Mar 2025 09:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XK/t2fAs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819D0260366
	for <linux-pm@vger.kernel.org>; Thu, 13 Mar 2025 09:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856915; cv=none; b=e1MqgLM6lRaB/Eq7509FmqDCZTtRhCRqRXNMgvAzEtfHhRKfmLs2+TnWzRkFlN/i8z3+fJ2eoaSjflMNTe6b666UGfLzM3AEVwNexkkx+Z1T8geEqzQ12cRcOgKvmZuJUnruNYztlYBW4MIE59r4ZfqAOXmChDOnXdXmUaEIu7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856915; c=relaxed/simple;
	bh=Wl1KFtRjOwO2tzEjO8wj08wrGFSVuNWT+iOqvmo3a6Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZqqhJ1HdDFkgwtUb5uPUBvtR4TQpkMYqupVQSxmsPBsv5TGjRWlICZ6B0xaT3X+4Pjpl2MkgJvDyA3u14/dDsj8lzXWbCkIfkBrmwitlV3HFvwnYs/ttY7K9hAlG+xtxLGqXp5noFZV9LrKuuDBZFbYHUl9priR8TKC63RElOpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XK/t2fAs; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-390e0f7b272so76460f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 13 Mar 2025 02:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741856911; x=1742461711; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GAv7kyB5RuH4saAkG1KYzyZXe6xxCSOkaTrGXFZC8Wc=;
        b=XK/t2fAskdndYlpEF0qiH6rMV1kuvGrNR+S8Xv9GUd+gZ7/ZJcTBwbFZQWEziIM4dF
         gqk7ZXQiMkkmY4iF9hKmzRmK2pE5kK3L4IJWy99gyXjztI9O6m7CkT3vCZWv+OVFRSfu
         0corHgMtddhCFmbQCqcFuJWxVY+kVIEa1D//idf5BNnspifeFHh6o0+xsC1D1wjMnsUZ
         pldHJRoetUzoETtelZFUgv7F2DuEucTYIFSJcfvBUN7f4b/mCu2Aj6DfJ4yam3Hq5Yk3
         1xGXQLzD9M+uzKfsCabiDlaigq8pXQWssqQ6K2T9VkQ8EAIuWOXsx0dJi58wUqI7uWqK
         YcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741856911; x=1742461711;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GAv7kyB5RuH4saAkG1KYzyZXe6xxCSOkaTrGXFZC8Wc=;
        b=LRl2OALRmZViRt5drFsebxShsxxJIW8P9LjlJ03DVeDMwlZmi9UaRfm4Sek2ZmlHIC
         ROT9g7rx9cXQyLrjV+KSVSNIt+QYftAZH2M96fX/Rx/yO05RuA8jtvvyaY1h7GsCHNNC
         Ns0Wxx4g0IUrMt0R4XtFeyQbE/1EYBQxiyDIBtblDQzRrMc0PaSfinpg9/I/eCLHG9hm
         wAHMq+yjBddK1CYjW9UuOElqnAyJFix1PSRYNqQow8nRrE1zWj7u8V0i/MA+ssMptzeW
         bCpwcz8bjodC5Uzc7w1usIsWaaRIbn+witowRqHiNDTOr7estCU4iT43POr/z7QHF+8H
         L2Dw==
X-Gm-Message-State: AOJu0YxQz4IS/DRJWq+5a5yxq+DVJVsyTDfKrUElNYBy1gRejCdjyCeo
	1+DBbSy53+VpDqRZvENaxEYhfM/W5rqs5wXzUSqajGhp4YEs0Gw//FvRiiBWoXQskEvgD38CnHi
	k
X-Gm-Gg: ASbGnctghaSHOYqqu+cLqCXq8Y4AFiXARmLlmc0sqedSmtgdhl4Czqd68Zf1BgEYGFX
	fIin6JJYyJ7nwkmWiBRxlHK2QnBad4YRK6l79VG+f+8fNo6IDAnCmlFk7tvErKyuwRrRKJNfKF8
	Hi6/jEVbTrRLOnUarbOzsu0XZ6vmMj1vDv4joXZGutTr+4XNcxbAB2aZGvhBO1AY6s1aMCn/MLU
	1f1MprkFuJqdrG25ryiaRNewIphaEDrTJKIQpwCS3uQhU3NaM4rC9F372JzsKBm57Z1/z7gEP2u
	/8vNq5rEbq7fepnKpxePptC3o9KKUak3EDR/WuHxssT45tI6bBeCj9SJg0A=
X-Google-Smtp-Source: AGHT+IF/8ByMRarbkFsf+R8z8fkwXjcJ86QdUPsdCg2X6h3hbckYkFiU5YKP7+DCf3ovRBepSe+Y2g==
X-Received: by 2002:a05:6000:1a8f:b0:391:10c5:d1b4 with SMTP id ffacd0b85a97d-3926487e440mr3980336f8f.7.1741856910965;
        Thu, 13 Mar 2025 02:08:30 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cd78sm1414706f8f.78.2025.03.13.02.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 02:08:30 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 13 Mar 2025 10:08:20 +0100
Subject: [PATCH 1/3] dt-bindings: cpufreq: cpufreq-qcom-hw: Add missing
 constraint for interrupt-names
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-dt-bindings-cpufreq-qcom-epss-v1-1-62b0f96ba888@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1446;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Wl1KFtRjOwO2tzEjO8wj08wrGFSVuNWT+iOqvmo3a6Y=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBn0qCJwff+jMlOofb1DFxJqc370CtsyihW7ia0E
 DJF9Pz9v36JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ9KgiQAKCRDBN2bmhouD
 162pEACEbAZZtuuWXJIMIBdfO8RinsnXO4Uz+y2VHSkbeeWoCsvK5XageSwL6LIJjDNYCTGQ/hE
 Asu1uTGx5cvGfv1YfeqjXYvbSv0LoYimvahXNK3Tpw9KMSC2jdtGFJERhDMFP2RMlbSM3Zz2P1/
 fmUfaTFiT6AeYnegX9lhqjb8GxL8jUmucALQb03dxYREDecJqPUIVUQDz9SVmml9X1A2cE1ARPv
 nCGxVjV4/fuGnpB7Af0KBXVrQA9PItMF5IDKogDRlZOmcElc94q9nt0uE507TIvUnHe7fcGq/eB
 MkRxNFSvjj0ISdNO59MQJfsS+LPDYo4pnAxONN8394U5tVWAkhZ5YcVtGTEX0Mpp3iEvsPgI3zM
 aArnTFcQcyVmvwaQ+/Fk4Mlg1zlMG0F46OknXEVCEVIRLmnuy1AT1zaM1k10pBsryTRZuZaupUg
 YgHhoYUUPt+eWgMSXB7JrH9dRz5MXOz3JmX7PpdpAYNFXggdrf2K2cmIlWPzT5A+59YoUaUM5l1
 TM7FIaMEpPC2CiaRhxlPTAAEfnmQzcdfMMvD5QvOXloYUNwpJYS4e4KY2ng/rXN1BxBRoBjeGi1
 TuaIkgDig607q5nRGlrep/5/ssTRQFOSDJ9nQ5RlsymXjotc8taWKozOHjezqaW2hcBrQbknMKr
 +ObqGCI5tkT3yTA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

When narrowing properties per variant, the 'interrupt-names' should have
the same constraints as 'interrupts'.  Add missing upper bound on the
property.

Fixes: e69003202434 ("dt-bindings: cpufreq: cpufreq-qcom-hw: Add QCM2290")
Fixes: 7ae24e054f75 ("dt-bindings: cpufreq: cpufreq-qcom-hw: Sanitize data per compatible")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index e937eb7355e7fb74c0aeafb4cb9f5ed80d96e6c3..6633a70e322019bf2f1cfdce8f3225b307dfffb6 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -127,6 +127,7 @@ allOf:
 
         interrupt-names:
           minItems: 1
+          maxItems: 1
 
   - if:
       properties:
@@ -160,6 +161,7 @@ allOf:
 
         interrupt-names:
           minItems: 2
+          maxItems: 2
 
   - if:
       properties:
@@ -187,6 +189,7 @@ allOf:
 
         interrupt-names:
           minItems: 3
+          maxItems: 3
 
   - if:
       properties:
@@ -211,6 +214,7 @@ allOf:
 
         interrupt-names:
           minItems: 2
+          maxItems: 2
 
 
 examples:

-- 
2.43.0


