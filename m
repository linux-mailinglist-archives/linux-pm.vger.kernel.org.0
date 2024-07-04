Return-Path: <linux-pm+bounces-10639-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC80927E38
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 22:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 100AD2856B1
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 20:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E96145A14;
	Thu,  4 Jul 2024 20:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiQgKuhy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A6713D245;
	Thu,  4 Jul 2024 20:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720123468; cv=none; b=gO39EtjzyGWVBtHXh8gQfKAJxDBrspFMpJuq3ZbiaAqdQsVXgDXCiMZTAx2Mwi0DWmKh9fr0ocxKjvPnB9W+3W94x6e41x0ClE+vUmDkDGlQ9D3kGJqMFFLcGhHEb+NE117pZu/sb4SyMhoGv/cP0DZwkVhW5hq2mwdA9nDnufE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720123468; c=relaxed/simple;
	bh=IRg1OdfxSxvXT1sq0n2M0MkhmzQBEWJ5offR5cOD+xw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZGZb1dLJNeqs4yxV8kH1txf/I3MHIQNbEyblIt7kUSDiZ1ztDGb9bVvmZMjGwNuE1zdm5bBn0tOZm+OggOpibrJvPibzmLky4zl6gxLubKnwjyK0maQs4rwF3x0Y45tIJWU24bWjj1phJ08ssz9upLF55X3WPIBwxXfkWY2KVOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiQgKuhy; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57cd26347d3so1354664a12.1;
        Thu, 04 Jul 2024 13:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720123464; x=1720728264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6GqqCFWFVTzkawZoBGDseEtBHPCa6na2iuHXJweLRs=;
        b=kiQgKuhyslWaCnO5f/Ui3oHsqFT2bjWEZMCALwyUYbbd0Dcci67Yek4vwb7NtZWkar
         x9J5f1fEAqlfi0TjIp0NC1bS3ERxqMHF6/azdIe9IzrJRKg7l2TFXrZVwcCVuaVG0TOe
         IJ+PYJhSyTZgKufFmc8caWAIi4CBX1Wtl8XLYRMfn6KSIEes2W5oE4gV7BbQhKw3cnos
         AFcJxw2Z08lIsUKbBCvYA6iErJ6+GQ0qzgw4ZSyxQt6MKFuh3O4opn91TfEsUn3ZgGy7
         l/6auiuS1lW8gtNKaKrT7wTeT4xKsG6nWo6MlpQ+2qhHUw5z6ZfLis9Of+VhxXuw3bZ/
         AbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720123464; x=1720728264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6GqqCFWFVTzkawZoBGDseEtBHPCa6na2iuHXJweLRs=;
        b=EYXurk8TiLcDkKr1M2gdux/ib8BHELV6egVM2r30Pk+JTzOha98kalRUtB9w83Ytm9
         r3MKj2tlq5f2hwv8JFeLRigRPP0BF5Ep362d7tFa4s5t9Iuy8k39FCJepdTo0NiTgNcm
         rojcgD3o4MHg9M4nA+rZXW01acT2hPSwhzPokHbCRcZ9LoCQdFwxKL2Tvx+8qHdRu4s8
         s0UVtKL5OfJj6mdgrN6/lHKI0XoJ0PfOOuco5yVbvZVRKC0B362m9TtCSzECF6wRs4PV
         RzO3HNlyBye1ITiQMlmJ+4TNMA8sip7RIiWgLU8GBXEWyB9XRW6xE27A8YslMeCPM8++
         CSNg==
X-Forwarded-Encrypted: i=1; AJvYcCW1I2njcKikG88PnfEqjyjYhDNCQNLz7ySOOXHXggZIQ90lK4rbZiZv/0j5WNlHn1K0MFsmr9irF4JyxnHacJ4ft7XJ/B6pDgQGsnuFdtf+hvzsmZ40k3AoAVL8E94GugSNvGH7BwYU9w2a19PNEj8CTB/baJ419cLf6e+cYOOKtxRGMO/27KhTu1pa8SbKLQs7UIz8v+v+3u3C1efKlM5tbg==
X-Gm-Message-State: AOJu0YwDwpz4wTd+GI3leGNRz+kF7NrWsk1e3W23AhVySwhpsClDngaS
	Bhx8BxmP9G5UYTuRc7ZBve9NX3ObnCH+cou1wPhdTimq0K9Z/t5V2y4BlVEO
X-Google-Smtp-Source: AGHT+IHVI27OvUSVqiUY1QTwPgOyA49EPNnp4qFvEE///pT54x3j8RDHo/Nkab7Btkp/DKHh0+FKyA==
X-Received: by 2002:a05:6402:5192:b0:57d:3df:f882 with SMTP id 4fb4d7f45d1cf-58e5a6f265fmr1882853a12.7.1720123464036;
        Thu, 04 Jul 2024 13:04:24 -0700 (PDT)
Received: from localhost.localdomain (byx56.neoplus.adsl.tpnet.pl. [83.30.43.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58b4a97b1f3sm4091149a12.18.2024.07.04.13.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 13:04:23 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
To: 
Cc: phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Adam Skladowski <a39.skl@gmail.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] interconnect: qcom: msm8953: Add ab_coeff
Date: Thu,  4 Jul 2024 22:02:31 +0200
Message-Id: <20240704200327.8583-9-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240704200327.8583-1-a39.skl@gmail.com>
References: <20240704200327.8583-1-a39.skl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BIMC and SNOC-MM on downstream feature
qcom,util-fact which translates to ab_coeff, add it.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 drivers/interconnect/qcom/msm8953.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/interconnect/qcom/msm8953.c b/drivers/interconnect/qcom/msm8953.c
index 9e8867c07692..62f8c0774b3e 100644
--- a/drivers/interconnect/qcom/msm8953.c
+++ b/drivers/interconnect/qcom/msm8953.c
@@ -1169,6 +1169,7 @@ static const struct qcom_icc_desc msm8953_bimc = {
 	.nodes = msm8953_bimc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8953_bimc_nodes),
 	.qos_offset = 0x8000,
+	.ab_coeff = 153,
 	.regmap_cfg = &msm8953_bimc_regmap_config
 };
 
@@ -1295,6 +1296,7 @@ static const struct qcom_icc_desc msm8953_snoc_mm = {
 	.nodes = msm8953_snoc_mm_nodes,
 	.num_nodes = ARRAY_SIZE(msm8953_snoc_mm_nodes),
 	.qos_offset = 0x7000,
+	.ab_coeff = 153,
 	.regmap_cfg = &msm8953_snoc_regmap_config,
 };
 
-- 
2.45.2


