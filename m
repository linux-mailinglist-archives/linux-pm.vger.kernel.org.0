Return-Path: <linux-pm+bounces-10631-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 810E5927E18
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 22:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 004071F22916
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 20:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C16313D250;
	Thu,  4 Jul 2024 20:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOTHJHXS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EDD2F23;
	Thu,  4 Jul 2024 20:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720123438; cv=none; b=RA89V9Uw7hdM09pEHnAL3CTtG8mHoGWLrdBsu1Zh9m5vlt5zEe0qfLI0eNTJyPwINwKvJZKLUuIVo1zv1AHyCAbDhOQHEiquXPVhCo0EPuC2CtHud6KxRBPKA+TUVjr5+y8OqdOzjn8QfV9r3tETX0aMyufJVEDboKjmY20BFlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720123438; c=relaxed/simple;
	bh=1DnNLBazUSRsAOAUzlGXuYFNGmdaee9RFCHZIt50HdU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aYjR7p59YCZK0qOHjACDVd48khUggq6YFVa1D+aJjoeeGnMiQX32Wq1U56nId33PUFLWScvnR1rmT51ODcNDkpyD3tPUlROF5zYOUOrUQjpMIA6efsBlIuViChCnc0xBmGn8EqRfa9+aH7dzv9uwDzKDWp6oY8tXDTRJCHyvu50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOTHJHXS; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57cc1c00ba6so1401107a12.1;
        Thu, 04 Jul 2024 13:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720123435; x=1720728235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YHjVjxmY/GZtWz2SeioO1B1jq99djljZK6Im27GcFo0=;
        b=hOTHJHXSehjWLCXNtwWP1jOnBJqZeaceljJfizAsSWHc29Zu12RzFqXN/W0A1uiHAy
         yc0lj4pfWSCU58B+NE6gSUwfuXjn3X18L/HvKjPHNMyGF2haDZPJvdlHE47Q4L8R80vZ
         LoJuL2u9OryI4Hxk+rX1C9WPIpcwlULtI8/QLExjIcEyNZZskoheywCjeP2TOzZLoM7Q
         jtXjiNHnJvdjbBMqkNB+5bDY2iTzPFhvc6tmy6QhDxschcdu5XpQQb346jKZ9mVPfViw
         g/Q1XzoWjXXQGXUNoFnSX3hnTCLPNoWClgbV25NcTD9y+5n6M9TU9fzaq0gyk1G3mO6/
         yilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720123435; x=1720728235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YHjVjxmY/GZtWz2SeioO1B1jq99djljZK6Im27GcFo0=;
        b=QASDkj15YYW7L8mpQNaNUhMCcObYzpVWqN2e6JIQV1xD1nvI2ZmmJ+cUpBekHZh0BZ
         Y0wrOMtNgtduEQHmKG+V+L1NJb60qC8DVbL+aVRNbi+hrfUpCUKDtIWtzD/RQKUIyt1r
         ZNO1qmtVFobbt7ht+d0ov6mz3+gRqQ+jcODlgkTF8s9XiQmxN0h5h+B6SiRCp48GyXpl
         z57Z418iz1lg0xFi/rHrPlM5xruzVI3jL/9xDjTx/hbv3dypCuh1lDepjaKIU2DHKE6G
         cPQowg1n1HF9y/4OCwSVL9zX5FU38UcuZFLAuFOyb76V0n7hyOkS37+ulsnDdZWRl8dj
         hCbA==
X-Forwarded-Encrypted: i=1; AJvYcCUbmehgvttV5Xj4pcCiUbog5oHyO5mfTtfCq5ycXRJqrojqXBU7O9Y03hcc8/mEeEw0RNMvQ1TaOa+G4YTl8aeYRwAdWbv+wMC2mbvGZeSQ6FpnHROPeaWvPjBJ3XBoxE/OoHyG0Hdisq/TAdqReZj8Wh0mnDv8oRmEejcZhXa85ipNtTjioo7/fOaaK6aOR+yHmitnilcf6KwEtIvU23Ds+w==
X-Gm-Message-State: AOJu0Yx+Lmt68sIq8NJUExKq9qozcTSQkWwe2MFeBGpROyL+3xgB0MC0
	fvV33bA0HYrlBS5DSCZA/bACzdCr5YInINCd0ITC3Vae1n7DH7TtJkhPRQ==
X-Google-Smtp-Source: AGHT+IExyxNkWXBOmCiMb4brNmyZn9Y2dgMgODNowbUu2j/Smrvf4EP6+DHnvT+mVPg+qqDFcbW3XQ==
X-Received: by 2002:a05:6402:270b:b0:58c:ea9e:2190 with SMTP id 4fb4d7f45d1cf-58e5965125cmr1880903a12.12.1720123434456;
        Thu, 04 Jul 2024 13:03:54 -0700 (PDT)
Received: from localhost.localdomain (byx56.neoplus.adsl.tpnet.pl. [83.30.43.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58b4a97b1f3sm4091149a12.18.2024.07.04.13.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 13:03:53 -0700 (PDT)
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
Subject: [PATCH v2 0/8] msm8937/msm8976/qcs404 icc patches
Date: Thu,  4 Jul 2024 22:02:23 +0200
Message-Id: <20240704200327.8583-1-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduce new ICC drivers for some legacy socs
while at it also updates a bit of qcs404 driver which seems
to not receive much attention lately.
Please take in consideration i do not own any qcs404 board
so i cannot test anything else than if it compiles.

Changes since v1
================
1. Reworded commit messages
2. Adjusted yamls.
3. Adjusted examples.
4. Added regmap include into qcs404 regmap commit.
5. Added coeffs to MSM8976 driver.
5. Added MSM8953 ab_coeff patch.

Adam Skladowski (8):
  dt-bindings: interconnect: qcom: Add Qualcomm MSM8976 NoC
  interconnect: qcom: Add MSM8976 interconnect provider driver
  dt-bindings: interconnect: qcom: Add Qualcomm MSM8937 NoC
  interconnect: qcom: Add MSM8937 interconnect provider driver
  interconnect: qcom: qcs404: Mark AP-owned nodes as such
  interconnect: qcom: qcs404: Add regmaps and more bus descriptions
  dt-bindings: interconnect: qcom: msm8939: Fix example
  interconnect: qcom: msm8953: Add ab_coeff

 .../bindings/interconnect/qcom,msm8937.yaml   |   63 +
 .../bindings/interconnect/qcom,msm8939.yaml   |   13 +-
 .../bindings/interconnect/qcom,msm8976.yaml   |   63 +
 drivers/interconnect/qcom/Kconfig             |   18 +
 drivers/interconnect/qcom/Makefile            |    4 +
 drivers/interconnect/qcom/msm8937.c           | 1372 ++++++++++++++++
 drivers/interconnect/qcom/msm8953.c           |    2 +
 drivers/interconnect/qcom/msm8976.c           | 1440 +++++++++++++++++
 drivers/interconnect/qcom/qcs404.c            |  127 +-
 .../dt-bindings/interconnect/qcom,msm8937.h   |   93 ++
 .../dt-bindings/interconnect/qcom,msm8976.h   |   97 ++
 11 files changed, 3277 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8937.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8976.yaml
 create mode 100644 drivers/interconnect/qcom/msm8937.c
 create mode 100644 drivers/interconnect/qcom/msm8976.c
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8937.h
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8976.h

-- 
2.45.2


