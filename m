Return-Path: <linux-pm+bounces-35847-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A23BC9C06
	for <lists+linux-pm@lfdr.de>; Thu, 09 Oct 2025 17:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05AA519E86E9
	for <lists+linux-pm@lfdr.de>; Thu,  9 Oct 2025 15:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2741F4CBB;
	Thu,  9 Oct 2025 15:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fEh42Sh4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B7D1E3DCD
	for <linux-pm@vger.kernel.org>; Thu,  9 Oct 2025 15:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023510; cv=none; b=NmWGqT50Zt8ud2poHI7/dTJHa1UweTBh8vTF7+Q28rr9ybhOA5g7+6Xg05Sa7t07vKtPRbo/tk8/kshTwyEtmIpof5BVwQLIcHYZzmF5Nana+u1cLX909lb/bHmqD6+pJe9WBsRXYHqMlNhWv5BLtRI2POkFg3PXueEIfHoj70w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023510; c=relaxed/simple;
	bh=81jybtZ3s587CJJH0yCGA5kZLJlEWI3joc5fyisw8bc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FGzMUOSuRga4zY9q14vQT9jVr8+CwwXFUGTFLWvme246zt4sQO5tydOyKsxemZZmrH0aDb3I9Sxo53E5u+UT979TURqyfM/RWPVCCfHcBFNlP5rkP36Mf3Dhd5u4KtFshMtn+KlUoNIjHGdBR1C5YOaMxDtAcq6rzMLD5Xy/y4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fEh42Sh4; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b50645ecfbbso226277466b.1
        for <linux-pm@vger.kernel.org>; Thu, 09 Oct 2025 08:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760023505; x=1760628305; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B84jNTg7Yo8n7BGFGvQ15A/U09IRq0iw+ObZ/DfjbTI=;
        b=fEh42Sh4ZTts64I9k2hI4wxmvYV/aV2JAlYlunGkCTwvM9L1hUhnv7+dYxSRe4YS53
         pj3QAapZrKEXQIPUuCZ7bvfbr8HT51lpgDtkdd1CHWkhq42Zf9WMzdoyfB6CLtUSZsiF
         6fuIHhLr8YETYNth6R6Cavjvxz8YKrQzoab2cxpXsHMucxSKzQpQTxcXzYbe5ZtyMtCO
         kZ/xcXEO6gwJQvsPKdR7MBbcT7oXMCELC5KXR/POQ/v6+wquLb0Mxe+yPQ4eRXXkIh+n
         +EgGyx4mL9FB3Gf6b/MZCemuqlIPSMSHcetaEhukHJcexbl4dH5KJDvNDZSbTPY+Yicx
         cFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760023505; x=1760628305;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B84jNTg7Yo8n7BGFGvQ15A/U09IRq0iw+ObZ/DfjbTI=;
        b=TEk4CSjF/tCyECIy9hwueYZqCAZJnZWVhFxQ2ldwrWha81j/3inJrQawLKR3zSdZhp
         /+c8TW7vn+kCrR82pTmKIPi+G4/cC7CbCljdP9sVdBKIdJGPeJnpyubWJhFHozGjrmad
         +Rwe8ClDwHQH8pEXNvXi50O5Bgkg7vS7VXn8Og8aOSSnDHVWxUo+6ZN8wrwgJHdK3w0d
         /MIlmpGgAdyREnFE7ZfmGhbgtLNILNqnT9qEnOHHNdZfpzTabCI2lFHZa9pA0nyghRCx
         Q74anQafSNtFDw6nSM1dnxWuwNkaY/Jh88uLVXuZ2dEhG7mwL34DbQZOYeMvAPegkbR8
         eLRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ/2Vb2Sb6AMso+pycpv05GEKbn2K2c7k0zH+ShRt9yunCJKLgedLElPJ8+4nJ9e8PRudnuDhAlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEGwmsl0IOUB1ixJ7oez3g1zAwBEOW2l9Twgt8G/tVvkRTBrVv
	Z0FNDlIqx8QmrlgcJbFKY9UK7E3jr8guHd08CK1ALkgV/rmNKxtg8UJYIFOkE+CkeoA=
X-Gm-Gg: ASbGncs4OUQuoNY2fa0lEWtcIFhMiWsiJ0pQZzwVV9pTPqkaLz6u04ML6y8NZdvIeoU
	yqCTFTBhB4brFdvwJdeLVoo1xguIstpLx+fDln+mKWOyYP+k8w0M2UEa+HoIZyhLmka7CEVjpPO
	K8X6FJnsQCOF8yDM7a2k7kBNqH1htyf9OpGas25ccLiDpolZq8G42bysInhYSW75N/heZl7IWUl
	p4GEjaZ/AexIikgE/blPkqG6C4ZD5+PcOhNDE93cHWY1HPkM/MPARd197vTgIXVSBx2iwWOQXTm
	yTdGIdS8Kz5ArotZaU/4ko+TKyD+rVdYvn3Ul4YRtCulICfQvQdzyAK3Sr9VP75G3WyLaGrAYX2
	AEka5gEyKP1m8qcpV1hA8L0KXUOzo0kJ6T+U2KNmtKAPJt23Afsmjibu3I3MggmWCQ4RmAEd6fj
	8uQSfPFCxuCNX/si2qe7FJNveI6GKuuZ0VhGCTSfuB
X-Google-Smtp-Source: AGHT+IG4E2/BkqY+k6KCaob1FvNFhboNdxx7lEaSwbr4nblUCdc4u24xC8dmKvD/tTwPIY9VM74oUA==
X-Received: by 2002:a17:907:6d19:b0:b45:60ad:daff with SMTP id a640c23a62f3a-b50aa99e0f1mr827465866b.28.1760023505329;
        Thu, 09 Oct 2025 08:25:05 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b36fsm1908967566b.62.2025.10.09.08.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 08:25:04 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 09 Oct 2025 16:25:03 +0100
Subject: [PATCH v2 01/10] dt-bindings: power: samsung: add google,gs101-pd
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251009-gs101-pd-v2-1-3f4a6db2af39@linaro.org>
References: <20251009-gs101-pd-v2-0-3f4a6db2af39@linaro.org>
In-Reply-To: <20251009-gs101-pd-v2-0-3f4a6db2af39@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

Add support for the Google gs101 version of the Exynos power domains. A
new compatible is needed because register fields have changed.

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 Documentation/devicetree/bindings/power/pd-samsung.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/pd-samsung.yaml b/Documentation/devicetree/bindings/power/pd-samsung.yaml
index 9c2c51133457112ca0098c043e123f0a02fa1291..c35c9cb0115d79e5c36142da2c2a5dd30cd2ad47 100644
--- a/Documentation/devicetree/bindings/power/pd-samsung.yaml
+++ b/Documentation/devicetree/bindings/power/pd-samsung.yaml
@@ -19,6 +19,7 @@ allOf:
 properties:
   compatible:
     enum:
+      - google,gs101-pd
       - samsung,exynos4210-pd
       - samsung,exynos5433-pd
 

-- 
2.51.0.710.ga91ca5db03-goog


