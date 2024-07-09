Return-Path: <linux-pm+bounces-10842-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 260D292B534
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 12:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16D091C216C3
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 10:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66C7156654;
	Tue,  9 Jul 2024 10:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxCSywIZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451731474A2;
	Tue,  9 Jul 2024 10:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720520867; cv=none; b=fJoitP2OwNT18a1le31Eo5gWfy5wK3GiB+vl40cd9yMkD0TDT2/R0qu+DmpXiv3frZ4htOpzjRGeuFlSzRVmRLtTpgOp3/1iTIf9sE+tjY2TeSEO+abR4xiX4S07BMptCh/IWkzF+kqLjFglZ0o99exDMD9wviX4rFCY8pHIbg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720520867; c=relaxed/simple;
	bh=+z4hpqhDXZQ2pPLiuyALY3/MD/eHQlYfW+QYnPoY2fk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TqtHI644myi/mgpChFEKqngOMcKc9ue6bsHvaut3e52G3Xy/c1jJDeyhn5G7V6btYM6rONViCXY0iEsLyTvDidCgkr7Odn45J8e1gvRgd4kH+kmWk40QE96BU36kRHYzGD2ngv5OrVHc+q6g2reEs+XaD0Iyhbvfh8Dp3bC+GaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxCSywIZ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a77e392f59fso330174566b.1;
        Tue, 09 Jul 2024 03:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720520864; x=1721125664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DRAWz/V211r8tDaqG2IgXw6lhy00qgcG8GStOKSMZic=;
        b=KxCSywIZFX/cKVaACAq05t3MjNaScSwiao5TAd9jdxEq7gccXaL1FkF5d8wPun9FuK
         xX4bhXcvPAOKm5xo7MxYA41YtoWXl0Tf4gVz3OfZyv8kFpHmQ2yXvc7QYbycvO1A/iLT
         fbm+SV1pQVbwI7RqhXCfI8aILKXyHtI8BOs7sWqQ82cPSQNn3V47Pjq472tgvPxuoLgx
         sO3VKFPzwUeK2Z0qhgVGkSHEeXnKvlxmhS6txngP/eAvkp9j6ROGod3YYGUpWG8obJrf
         cTp9BFMVBNPD3JWI929FLLSXYQDeTS3cQNUffBHhIk4X3jIfxaRIdn7gRdsdiDhktktT
         MMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720520864; x=1721125664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DRAWz/V211r8tDaqG2IgXw6lhy00qgcG8GStOKSMZic=;
        b=SvUqsmpAPQfLMXGspgGQRnXi3AUg1fen9zHKRwKo1ngv4HvtUfEUh8sai9ez5DPA3l
         Xwd4F/todegWKwfpM01TYZtfAO5Vi82XuzfZUmGgLkZ7oCTwPiVog6pexZgeyovnnm+A
         5hQ1L5PlCiF6YqL3ydVU00AVkmmL7L8vRc9mQQ+iNVl092ID6OuKQJxbvHwKTnjAtH9d
         SdsJH3QdZJPXfTRKVhwOWxCRyUMKYXRo+FQeaY0dEMlEXFZFppHjEqU8LKpDYHJFnGzR
         qbXowAkyZLyZSN+oD0dYXFkcw/dYR405bqIq7VFIDHq6ACNG2UCbkAmFfYwrvK2xcxgs
         1BzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnrtUxmpMgb43LPXUrvxPBJ57l2vt6k/i0dUKemXBzdkiPrmaXFhaV1z0QfiC9VzB1Z67nrlassIKmiNAxrD0OfjAos/uA9YoCRLQ2YHCW4zjIZSvq3BGzw8Qh0mfxO3Iav7+r+MBMb7qfa8mexxWRvM+jDU/C3sYNPP/E7xrjghBPzp3TjOOA+oXCr9z8vMtw8YyHzG3fNxFfNUc1PuAxNw==
X-Gm-Message-State: AOJu0YwvLhwCg6XSa8OHEuvbd1zffcLxfC8zF8bz5IxbRI0509auUVl6
	tvNGuXmffAJS5Lj9mhWV6W9boVq+faMwcuvhml3cPD8cNKb1I70TrdGX5Q==
X-Google-Smtp-Source: AGHT+IGdMjoX8eHvB3eUQAtmm8Afat7ogcY4ocmuRNueAmmSsZOYBFwzCw7527LyhM3FGogPoeLYZQ==
X-Received: by 2002:a17:907:20f1:b0:a75:25ff:550d with SMTP id a640c23a62f3a-a780b6b361cmr113379666b.26.1720520863953;
        Tue, 09 Jul 2024 03:27:43 -0700 (PDT)
Received: from localhost.localdomain (bza125.neoplus.adsl.tpnet.pl. [83.30.46.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6bcc21sm66528166b.16.2024.07.09.03.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 03:27:43 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
To: 
Cc: phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Adam Skladowski <a39.skl@gmail.com>,
	Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Vladimir Lypak <vladimir.lypak@gmail.com>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Rohit Agarwal <quic_rohiagar@quicinc.com>,
	Danila Tikhonov <danila@jiaxyga.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Barnabas Czeman <barnabas.czeman@mainlining.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v3 0/9] msm8937/msm8976/qcs404 icc patches
Date: Tue,  9 Jul 2024 12:22:45 +0200
Message-ID: <20240709102728.15349-1-a39.skl@gmail.com>
X-Mailer: git-send-email 2.45.2
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

Changes since v2
================
1. Moved yamls from separate files into shared file.
2. Added commit to fix description of msm8953 yaml.
3. Reworded "Changes since v1" in cover.

Changes since v1
================
1. Reworded commit messages.
2. Dropped intf clocks from MSM8976 driver and yaml.
3. Aligned yamls to qcom,msm8953.yaml format.
4. Removed redundant nodes from MSM8939 examples.
5. Added regmap include into qcs404 regmap commit.
6. Added coeffs to MSM8976 driver.
7. Added MSM8953 ab_coeff patch.

Adam Skladowski (9):
  dt-bindings: interconnect: qcom: Add Qualcomm MSM8976 NoC
  interconnect: qcom: Add MSM8976 interconnect provider driver
  dt-bindings: interconnect: qcom: Add Qualcomm MSM8937 NoC
  interconnect: qcom: Add MSM8937 interconnect provider driver
  interconnect: qcom: qcs404: Mark AP-owned nodes as such
  interconnect: qcom: qcs404: Add regmaps and more bus descriptions
  dt-bindings: interconnect: qcom: msm8939: Fix example
  interconnect: qcom: msm8953: Add ab_coeff
  dt-bindings: interconnect: qcom: msm8953: Fix 'See also' in
    description

 .../bindings/interconnect/qcom,msm8939.yaml   |   25 +-
 .../bindings/interconnect/qcom,msm8953.yaml   |    3 +-
 drivers/interconnect/qcom/Kconfig             |   18 +
 drivers/interconnect/qcom/Makefile            |    4 +
 drivers/interconnect/qcom/msm8937.c           | 1372 ++++++++++++++++
 drivers/interconnect/qcom/msm8953.c           |    2 +
 drivers/interconnect/qcom/msm8976.c           | 1440 +++++++++++++++++
 drivers/interconnect/qcom/qcs404.c            |  127 +-
 .../dt-bindings/interconnect/qcom,msm8937.h   |   93 ++
 .../dt-bindings/interconnect/qcom,msm8976.h   |   97 ++
 10 files changed, 3165 insertions(+), 16 deletions(-)
 create mode 100644 drivers/interconnect/qcom/msm8937.c
 create mode 100644 drivers/interconnect/qcom/msm8976.c
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8937.h
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8976.h

-- 
2.45.2


