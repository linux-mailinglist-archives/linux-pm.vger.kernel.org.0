Return-Path: <linux-pm+bounces-11428-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EE593D207
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 13:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8854F1C21CC9
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 11:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B853917B41A;
	Fri, 26 Jul 2024 11:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MOpzWCsb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E5617A5B1
	for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2024 11:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721992726; cv=none; b=dJ61WameINGVzK6KlDKtU5giezm5QGp6u2/2ImZNLdH1wmsTy/6MxJsKtgglkUKy/LUhBfzDHpVVHHv4YZSaRIxLEEScwZH0jhJPH7kunCdFZRJh9mFO+M5jzA1au4uW9AvMLqmvGRgy8FiwZoPX4BP2m5pR0vFcEKSjHdGQGZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721992726; c=relaxed/simple;
	bh=/dPro3zmVHXBKc6IoJRwERhe3BXDGxTNO7EBgEZy8h0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HEu+1H7bHLahyuHddDioMkvnqgiAmfHSPYDHVcf+4utkCrLXQ0E+T1v+iF4Ymd79Z7viTZdLaHkVKolh75Z17JqmVnuEEZUqKeF+XTj7dWjb+qznhXBfp7H8Qp+xEIwyPYKkZJ91z99S8KfUSkSmvzmaP+er83DjhcaDtAwfwko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MOpzWCsb; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7a9a7af0d0so198504466b.3
        for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2024 04:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721992723; x=1722597523; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VxGxU8SYIBjBWPzi4Sb41+wNLkpnb94P+sh7kj+6cNA=;
        b=MOpzWCsbzeg4cantUz4Y6bvtEe081OTTCjfOiAuOkxAeohDbl4fk0BPOlTUrwOCnPV
         PR+6Eo/TRNwfQ6U09iHAdx5JIUuC8KKI7bRZ9yyfCqdy2U2nimDvm/53aeCCfsdnJbPg
         DrRPEdpxp5L0G6/u9BeJ+0e4/pI1q9UOUcRLQvnkYjwb7U2/I0FtZO84NNUtnE30IY45
         vuh8ClpQeqUpR4FibhM5Olfmobc+eMlZV+hFSqupL18hwatDo4alYpMpHiUzcLiAPo6M
         VIorIaM3iYff6ShlMFwdd8qz6Z9FdFzJ9Ru1GZIJSHfqdHv5fqY250l9fbrtg2CdvOM+
         2Nxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721992723; x=1722597523;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxGxU8SYIBjBWPzi4Sb41+wNLkpnb94P+sh7kj+6cNA=;
        b=KpMgjoMSCzhe7i7Csjl1iyKcUA3cDJpSrMQ1+vlIrqJZJyIPgfvnhSqikKFjx8jU8I
         zzl/EbjebnWrugz4oUlpLWTFqML3Yezc1bKJ/iax/rSZCDjGtyRsaF9xWOEQWpPxLrUY
         ckvC3QbV+pxuTVPfglHexvxIpx+9TNS/t1lBLGavI+pyvs72e7an8tpAKRI3w4EFiTyT
         lC1NmwuF2gTmHfYiL68Iz0Ix8mpPtRk1enDdNpOqI20KMkWq179Wkg2pdBwlfAkLYXUz
         6ruKm+IKpPmt8GRRFyxDKvS4T+trqQ5AolRGUTRHHoPBc/MUIeIAymEsCA2qLSp+wZYg
         d0/A==
X-Forwarded-Encrypted: i=1; AJvYcCUbhTWDVyAhuMOf6h1E3g0R0kqZlgtgeHo7I/3p034sT1zgD9Vl/C9zsKEW//eTHkcct69XrS5g6G+nc6OzWHvSyAj6mvKwpPA=
X-Gm-Message-State: AOJu0YyLBhNZ513fl/fhil6Opu9OvJh7rtYF+j88Fe6SZPmoaW4fp7q7
	x29E+ALPtga4GlPXybFNK6I+rKxU/y1OSqeziz9D8JBI3MiSvg4x9K2z/uBEb5Q=
X-Google-Smtp-Source: AGHT+IH+rwWCKvZykJlAAH6LNkpi65KtAACKb0MHHBRIglRLIVIJhjuI3O0okF7LvJcM+Fs+Wg3qfw==
X-Received: by 2002:a17:907:971d:b0:a7a:ac5f:bbfa with SMTP id a640c23a62f3a-a7acad1c3f2mr345732466b.0.1721992722770;
        Fri, 26 Jul 2024 04:18:42 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab233aasm164703166b.8.2024.07.26.04.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 04:18:42 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
X-Google-Original-From: Konrad Dybcio <konradybcio@kernel.org>
Date: Fri, 26 Jul 2024 13:18:24 +0200
Subject: [PATCH 2/3] MAINTAINERS: Update Konrad Dybcio's email address
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-topic-konrad_email-v1-2-f94665da2919@kernel.org>
References: <20240726-topic-konrad_email-v1-0-f94665da2919@kernel.org>
In-Reply-To: <20240726-topic-konrad_email-v1-0-f94665da2919@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-pm@vger.kernel.org, iommu@lists.linux.dev, linux-gpio@vger.kernel.org, 
 linux-remoteproc@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721992717; l=1340;
 i=konradybcio@kernel.org; s=20230215; h=from:subject:message-id;
 bh=/dPro3zmVHXBKc6IoJRwERhe3BXDGxTNO7EBgEZy8h0=;
 b=ju0yvv6H2nwlTdVb9cib/k9p3rqemfp5NXS7b/Y34MGtZuQUegciMPzF7tHC7+U6QA00B1Za2
 ECyneyJz3BfD/m8cFCsM6T6occxCyUbApmwMI8k8On8FV3B08w8yBoX
X-Developer-Key: i=konradybcio@kernel.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Use my @kernel.org address everywhere.

Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9200d953868e..6c7d3951192f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2745,7 +2745,7 @@ F:	include/linux/soc/qcom/
 
 ARM/QUALCOMM SUPPORT
 M:	Bjorn Andersson <andersson@kernel.org>
-M:	Konrad Dybcio <konrad.dybcio@linaro.org>
+M:	Konrad Dybcio <konradybcio@kernel.org>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git
@@ -7107,7 +7107,7 @@ F:	drivers/gpu/drm/tiny/panel-mipi-dbi.c
 DRM DRIVER for Qualcomm Adreno GPUs
 M:	Rob Clark <robdclark@gmail.com>
 R:	Sean Paul <sean@poorly.run>
-R:	Konrad Dybcio <konrad.dybcio@linaro.org>
+R:	Konrad Dybcio <konradybcio@kernel.org>
 L:	linux-arm-msm@vger.kernel.org
 L:	dri-devel@lists.freedesktop.org
 L:	freedreno@lists.freedesktop.org
@@ -18765,7 +18765,7 @@ F:	include/uapi/drm/qaic_accel.h
 
 QUALCOMM CORE POWER REDUCTION (CPR) AVS DRIVER
 M:	Bjorn Andersson <andersson@kernel.org>
-M:	Konrad Dybcio <konrad.dybcio@linaro.org>
+M:	Konrad Dybcio <konradybcio@kernel.org>
 L:	linux-pm@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained

-- 
2.45.2


