Return-Path: <linux-pm+bounces-19973-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FABBA01B39
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2025 18:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25587162EF4
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2025 17:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6AC153BEE;
	Sun,  5 Jan 2025 17:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WL5pwI2Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D781BB658;
	Sun,  5 Jan 2025 17:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736099784; cv=none; b=HCaPGHY8nT7nyy02L+XBCAFHmEVvp7w1hJhm0Q/Cli2jai1ostr2vXjhl8gA6GeAgB9js3LcOcQLtwI1gyCf24yEXkeTV2uYl2AnFOljG6ILV6bCqbNRmLSwpzvHOuWpSdrsNa5k9w56OdDT5unO0MpMlRaD08P+BG2bsRd4drE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736099784; c=relaxed/simple;
	bh=59WbRrfzuqi4LwQlgVcvF7pyzGs+uagP//FmY9IXOxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i8Yrb5wIAUrFUrkCi1bYFxeGpKKecDAgmOi6SwH/hIaeCV6c99Nj6TIVWQhXpv+Jw2H00I8E3RWsOq7wrIuHzgfE5L0x5AqyTo3CmgNix3rI4EA4i5Z3XQeBQON+HCBwSrIHFgSlkruy1y23hG6BUevAZ0rlI19Rn1cuX2lx33I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WL5pwI2Q; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-29ff8053384so6200983fac.3;
        Sun, 05 Jan 2025 09:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736099782; x=1736704582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XxNEftZua09LK0hM2esB8aQB+qauXYBXnPyeQF/u7M=;
        b=WL5pwI2QlJMzGkrJBU6MRmjV618VMc5IrkXrI701r6fRLODbRr96ZbPISH2tT10iFD
         FUC4TG+VeKD48cXMvZxz+3qulkkykNN3p/TWD8QAI2uGtQ36g2gEnP+W2rDnW1KR+H9F
         E/TttzEIg37JqnwLA2iHYoqq2r7aqHa3rQznQwtCTxFixbyLRpt542XglhlP4QE1XSzB
         Z6HbEqBBs+Kj0xN1+C/I5rdEe6O4L7KV0u7aA2sMVNZ1RMeklU/aQNAApGoC+8aWP3hq
         QCpgBSpA1M6PgEiXanwI24z0jclN5WsxKnxxbuniGoc8eSQh3//2ZojBlkQ6u/v/8GiX
         AaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736099782; x=1736704582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XxNEftZua09LK0hM2esB8aQB+qauXYBXnPyeQF/u7M=;
        b=T4mvvos55BmR+uW+6zZ5xInRllakEbwAFMpRWcGqm6wARtCPy5qH4qVKmP4T/a2ttA
         ULm4fomG6VGv6EYNOfxVVH5j2WqG6n2cYlpf3aohJIJerpifjqysA0aKdG2QWVcKwXd7
         DmNXNhUCaee1iTmJCObkhMPz2rt11FN414zl7TDMVkOA8io92iLtgjceXzxm4weBXnrM
         9CMP6OWtyg7hDi513nAetmAPNTcnwD1whC7zz3es6UymbLGtdxYry3ML4Vjt0b2UsTGC
         +FRepCDUNKr8uVz8oJCJ/YkVbfNMjvH4kn0JudHZLQY7r4bJtrZFP6732+i6yl0VCoDD
         yB7A==
X-Forwarded-Encrypted: i=1; AJvYcCV084mmgYw3a6Xar9IZlYPi2ZIoYlacsvhz0PSmM8XCWCMLwuDgHPo5kytaouGj24pV2TzlCsBNvNbg@vger.kernel.org, AJvYcCV9m/8WIi1jZrV2TiVHY1vfK4Hmu1tA2Tlj1Jg4dlDdo1pn8p3XuMHdJovRMKsltDzfhGPdnxMFR1T2bF8Muw==@vger.kernel.org, AJvYcCW3ukd2EJuWf67qIat2Zt3SfJQoa3n4ELkjal9cNDEOirHuGuwku3NqfFDEoIqOlCA9g8q9zdkYFZrKiJab@vger.kernel.org, AJvYcCX2ZOXAzjj1LAl+bm0+mKp3dZH+sTkKupCxpVWArbhrvqRMH5WzicdSaF0Gx4kglwB31SHom1d9Ut0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1HHfTgd6qr30w5Jxhnxvu34oM5iEJ0HEtyQJWDnTwsUnozorH
	5nLQ/o5zQ3P01q+lUGtek+83b1DnYPV2ZGw7yMTqDf36+i9yUkq9/lretrYaZSXkU94xJ6gHKNq
	RgZ9HDBwYJYd5EugKN3nJ/n5rE5Q=
X-Gm-Gg: ASbGncuOqD/SVikkXjTl0RxCQC+Hreivkzw1sjfVvR0xutGBge/TfU6OKSUPQQPPenQ
	HZM+yanNU5t9NfZLoS2AsTeSc8B2ARSBPEQPSvchFI53qX8479bvkCSz1WvOTNmnyB7/dABaB
X-Google-Smtp-Source: AGHT+IHvCPNMz64lZgikf9PqNcOhvTMRwGCdjgxlvaOeMmuPREPE2VatSotMqePlInthqSEKKYUwoJA15I6O4EM0eaU=
X-Received: by 2002:a05:6870:20d:b0:29e:32e7:5f17 with SMTP id
 586e51a60fabf-2a7fb4b7bb3mr25812289fac.28.1736099781938; Sun, 05 Jan 2025
 09:56:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241231-gpu-acd-v3-0-3ba73660e9ca@quicinc.com>
In-Reply-To: <20241231-gpu-acd-v3-0-3ba73660e9ca@quicinc.com>
From: Maya Matuszczyk <maccraft123mc@gmail.com>
Date: Sun, 5 Jan 2025 18:55:46 +0100
Message-ID: <CAO_MupJ21kOQPZG_=87mC-fQKmL=-K9AgOjriWR=wXCKU0897w@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Support for GPU ACD feature on Adreno X1-85
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
I've applied this series for testing, and I've no performance
increase, and some screen corruption, there's some lines(mostly white)
on my yoga slim 7x that appear on the bottom of the screen. When I
move my cursor in swaywm over it, the lines get occluded by the cursor
and screenshots don't show these lines.

Best Regards,
Maya Matuszczyk

pon., 30 gru 2024 o 22:11 Akhil P Oommen <quic_akhilpo@quicinc.com> napisa=
=C5=82(a):
>
> This series adds support for ACD feature for Adreno GPU which helps to
> lower the power consumption on GX rail and also sometimes is a requiremen=
t
> to enable higher GPU frequencies. At high level, following are the
> sequences required for ACD feature:
>         1. Identify the ACD level data for each regulator corner
>         2. Send a message to AOSS to switch voltage plan
>         3. Send a table with ACD level information to GMU during every
>         gpu wake up
>
> For (1), it is better to keep ACD level data in devicetree because this
> value depends on the process node, voltage margins etc which are
> chipset specific. For instance, same GPU HW IP on a different chipset
> would have a different set of values. So, a new schema which extends
> opp-v2 is created to add a new property called "qcom,opp-acd-level".
>
> ACD support is dynamically detected based on the presence of
> "qcom,opp-acd-level" property in GPU's opp table. Also, qmp node should b=
e
> present under GMU node in devicetree for communication with AOSS.
>
> The devicetree patch in this series adds the acd-level data for X1-85
> GPU present in Snapdragon X1 Elite chipset.
>
> The last two devicetree patches are for Bjorn and all the rest for
> Rob Clark.
>
> ---
> Changes in v3:
> - Rebased on top of v6.13-rc4 since X1E doesn't boot properly with msm-ne=
xt
> - Update patternProperties regex (Krzysztof)
> - Update MAINTAINERS file include the new opp-v2-qcom-adreno.yaml
> - Update the new dt properties' description
> - Do not move qmp_get() to acd probe (Konrad)
> - New patches: patch#2, #3 and #6
> - Link to v2: https://lore.kernel.org/r/20241021-gpu-acd-v2-0-9c25a62803b=
c@quicinc.com
>
> Changes in v2:
> - Removed RFC tag for the series
> - Improve documentation for the new dt bindings (Krzysztof)
> - Add fallback compatible string for opp-table (Krzysztof)
> - Link to v1: https://lore.kernel.org/r/20241012-gpu-acd-v1-0-1e5e91aa95b=
6@quicinc.com
>
> ---
> Akhil P Oommen (6):
>       drm/msm/adreno: Add support for ACD
>       drm/msm: a6x: Rework qmp_get() error handling
>       drm/msm/adreno: Add module param to disable ACD
>       dt-bindings: opp: Add v2-qcom-adreno vendor bindings
>       arm64: dts: qcom: x1e80100: Add ACD levels for GPU
>       arm64: dts: qcom: x1e80100: Add OPPs up to Turbo L3 for GPU
>
>  .../bindings/opp/opp-v2-qcom-adreno.yaml           | 97 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  1 +
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi             | 25 +++++-
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c              | 96 ++++++++++++++++=
++---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.h              |  1 +
>  drivers/gpu/drm/msm/adreno/a6xx_hfi.c              | 36 ++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_hfi.h              | 21 +++++
>  drivers/gpu/drm/msm/adreno/adreno_device.c         |  4 +
>  8 files changed, 268 insertions(+), 13 deletions(-)
> ---
> base-commit: dbfac60febfa806abb2d384cb6441e77335d2799
> change-id: 20240724-gpu-acd-6c1dc5dcf516
>
> Best regards,
> --
> Akhil P Oommen <quic_akhilpo@quicinc.com>
>
>

