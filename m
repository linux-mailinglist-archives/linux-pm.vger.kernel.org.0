Return-Path: <linux-pm+bounces-20122-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B35CA06707
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 22:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 198BF1617AB
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 21:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB7C2046A3;
	Wed,  8 Jan 2025 21:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqhom3vz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C522115E8B;
	Wed,  8 Jan 2025 21:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736370915; cv=none; b=LiZM0nWZlSmo6O173u6gY82V0gjnDYO6MpVI6Jz9H5fsNGP05NEoBFp3lzoP3P6/seNuioLnCvELxt61HwzYqz+kpsRl7K/WhSS8xJUzvpcF5q68WoeHCpFecy96ooopchYhpfGT75AhB6NDIC++ZZLIG1fg1FR/x0SEiFSiqjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736370915; c=relaxed/simple;
	bh=xBjJ1KxwfFvxiC7h11TGNmY9Rbja0N+ZDUwGox1AIlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQjZ3aTMJNg/+eVZ3LqMcl4ytauR8Y3/OQm0tGnGo8O5ZSTM7XEJ73+pxZQxGxE0n+uwkWdW3k8jrzy1cb3+0Q9GUf2z2ijr11r2AUW2c2s2W+E7XjJwfFHVk7UTMXmCRjzrawO3kUNcUrJ1lqF8nrpEht03bGGOnpQrApunO/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqhom3vz; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2a383315d96so101255fac.3;
        Wed, 08 Jan 2025 13:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736370912; x=1736975712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMIhmiSEfVJ+BWqA4YgIxRvWxMlKC6xy2Wsp+SXaK4A=;
        b=gqhom3vzW9Yf5HMBxj6AjRLIaEWw0TTNC2O3rERVynq+F4U/xwsc9BLOlwiMzkQA9l
         Ahoudm2Tw/qgJziSfGg/Nmtqt6mCxf8OnPbJGrcr8UgBP4Nel0HQWsd4Z2OpCaZqv0HK
         KfinlTQTiuEG42DZiTVnpsyTMV7oXYV1548h9r0DCVln6aCqjhJLUDVcDrc2sIeR1jdq
         3uhLoXNP7mmo86AopPMCmB+HrjA9cz3oOLluMEL/GidqvukdSw68Bp/zvv/mP9aPF14K
         3ad+heyv8xjlwJ27shSvqXb+XhPVn70nxgI5X+hIBKoLhxG7e1bOIot6K24CxKe9UdsM
         cjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736370912; x=1736975712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMIhmiSEfVJ+BWqA4YgIxRvWxMlKC6xy2Wsp+SXaK4A=;
        b=JqXqfWeujwEetAQTf1HnNYEOq+qhBoLqZsDw+M4q6IRSqUM1WRkgnjYlIa0eWmUion
         BEG96RlqNKEoHYYFz8hGfvTDENERE02iwgkKw6EIcKyj6GNY2LkjHIF10w411G0ZQAOX
         sIoKh8nubJKsTwNNIYoDvAv7aLglrvD7khRmtnD9zaFzu6SKn3Btdko70AuViTN31OAx
         Y68KTDcBYAkl8rzsaQx5fgAJQQ1CY98Af6mwSG8otiSmWzbFkAPXdeSLj0dHu8bpHPLw
         yhmaPUGWMuxovluYkl0G0zl21uJ70SP7TCxPfeEq5xJDzBv3XlDRh/6Il6qbgynFy3ro
         oW9g==
X-Forwarded-Encrypted: i=1; AJvYcCVQnibUHK3OmC8jaTPoGMsnQ7UClhc5J3uYYMV4cO/wrn05zDHZSb0vm2Mq6/73L+Dm3F6p9M/UYY2G0h0hZA==@vger.kernel.org, AJvYcCWSvZQL+dPca3v5kppAhfOGPODpVg3P+mvEArPA75H5BomVKX0TL9u7sj6VQ3Vr7ZzHwoc+4jL0H9M=@vger.kernel.org, AJvYcCX+gQ4QZ/LTcN1qRE5Ycwwo4kMaq57YLNdM0Ag0taOu9+mRo5W1TIApDdQpCvDCLzihHS6zMshVETRuomQ6@vger.kernel.org, AJvYcCXZyIFHkWORE4ErlBBT07IxvtsTrqYjJXcBMBuS/Ljh4CLlvoYFjUo24o5jt9g9iTRzH1ql4n5QA0Cm@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7g9Fe9vylN8fcmSQTmPrUK20KnLsCXdY42jO4RnnrRJKCRVAp
	0eJUw1lm44t1FI0/4GQyGwe41LW4lbj/Ze3wb3fKPP7e3T+92S9dBkim5K17dGkG83lFA/11WVA
	jbfWcbZe32FF1sBTrc7JoPU6HJzc=
X-Gm-Gg: ASbGnctL3zHEIYxx/LM7tc7mC/xXXd2Rm1g5Z9dbscd2rsRAGE5yMuY14Shui4xDYNK
	A4TEQa9tQnfKYkhUWrffi4daJunHVjimnvnYqjYFORao/MXhBaoYNMZStcDJp/SQkX0qwKKzj
X-Google-Smtp-Source: AGHT+IHlXxeBVrwNiRJpStkRv3Fwe/nP4ij3BlZqHQWN7ErX2VOVjegnWYzp4FJ/MfeSVqZWzL+ObDp0S7Fu593f4Sk=
X-Received: by 2002:a05:6871:a110:b0:29e:7067:4eac with SMTP id
 586e51a60fabf-2aa067199b7mr2450431fac.23.1736370912440; Wed, 08 Jan 2025
 13:15:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109-gpu-acd-v4-0-08a5efaf4a23@quicinc.com>
In-Reply-To: <20250109-gpu-acd-v4-0-08a5efaf4a23@quicinc.com>
From: Maya Matuszczyk <maccraft123mc@gmail.com>
Date: Wed, 8 Jan 2025 22:14:36 +0100
X-Gm-Features: AbW1kvYFvW2kP1UkSKXNNDpLZqKRBQo82H7gTNUrdM7cUUo07-UKccvOzF9Au_o
Message-ID: <CAO_Mup+bedwaZadYitd9OufghQbmseE-s1RBS3_jEnLw2fS_7w@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Support for GPU ACD feature on Adreno X1-85
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
	devicetree@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks,

Tested-by: Maya Matuszczyk <maccraft123mc@gmail.com>

=C5=9Br., 8 sty 2025 o 21:40 Akhil P Oommen <quic_akhilpo@quicinc.com> napi=
sa=C5=82(a):
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
> Changes in v4:
> - Send correct acd data via hfi (Neil)
> - Fix dt-bindings error
> - Fix IB vote for the 1.1Ghz OPP
> - New patch#2 to fix the HFI timeout error seen when ACD is enabled
> - Link to v3: https://lore.kernel.org/r/20241231-gpu-acd-v3-0-3ba73660e9c=
a@quicinc.com
>
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
> Akhil P Oommen (7):
>       drm/msm/adreno: Add support for ACD
>       drm/msm/a6xx: Increase HFI response timeout
>       drm/msm: a6x: Rework qmp_get() error handling
>       drm/msm/adreno: Add module param to disable ACD
>       dt-bindings: opp: Add v2-qcom-adreno vendor bindings
>       arm64: dts: qcom: x1e80100: Add ACD levels for GPU
>       arm64: dts: qcom: x1e80100: Add OPPs up to Turbo L3 for GPU
>
>  .../bindings/opp/opp-v2-qcom-adreno.yaml           | 97 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  1 +
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi             | 27 +++++-
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c              | 96 ++++++++++++++++=
++---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.h              |  1 +
>  drivers/gpu/drm/msm/adreno/a6xx_hfi.c              | 38 ++++++++-
>  drivers/gpu/drm/msm/adreno/a6xx_hfi.h              | 21 +++++
>  drivers/gpu/drm/msm/adreno/adreno_device.c         |  4 +
>  8 files changed, 270 insertions(+), 15 deletions(-)
> ---
> base-commit: dbfac60febfa806abb2d384cb6441e77335d2799
> change-id: 20240724-gpu-acd-6c1dc5dcf516
>
> Best regards,
> --
> Akhil P Oommen <quic_akhilpo@quicinc.com>
>

