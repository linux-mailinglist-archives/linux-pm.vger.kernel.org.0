Return-Path: <linux-pm+bounces-10303-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C0691E92A
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 22:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E11F12822FA
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 20:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7259816FF5C;
	Mon,  1 Jul 2024 20:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pV7iWmMn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0A216F840
	for <linux-pm@vger.kernel.org>; Mon,  1 Jul 2024 20:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719864436; cv=none; b=Usvnmw7WbAYxJ/9tuJ2i027I2/Vsk+iJE9fwgI4N4Ak9BcLHLNjo8t9TEw4ssRX9GM/JdQan8U4ao24HVxhVmONR5CkH6OFtlf9/xqjxo16i02trDmC7J4uBmbqryuQiRUJVTFqmdmB5v73lVbNP5vjkXZhu/TEw/ndJXmpuMUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719864436; c=relaxed/simple;
	bh=DTx0TnMXknMnU1py/GEV3TbUeQ0A4+c8OwKWSEIEY60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UYTjkk7tmwpnYHaf8Hqgx21hAQgyeg/O7EdaV1d3vtbtOfVuRqPvUYXUgxcQbaJeEyFvs2QrhxXTOABuIB4cpL2KtUxqVd9TA11y4OX7DLiqXvGmY1uFYGl1bFYB7E9fstSIG8RA7VMatLntuREgTdvq5aPXC6b/RmL3h0fAoho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pV7iWmMn; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57d119fddd9so10813a12.1
        for <linux-pm@vger.kernel.org>; Mon, 01 Jul 2024 13:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719864433; x=1720469233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HA1dU22m3UNj5lyj13MGSrb+8h3p7MYcfXDGMuEpnwo=;
        b=pV7iWmMnE4CLmq/TiV0X7tzonmq/wxD24BAM1cWI/CSi7jua2bZ+hR/8iqNnZvmmCD
         lqfrr8GMbU9DCJpVX3xmkkMZPAmd3kJImpE/q9WXkjnSZxlwd3WYd3Ay/r1od6cJWll7
         p6XX92skCQsVjeyAB6JEQuuBNPPtUGq4tvFpVRLtmHPgFxHr67+njCHPsasnMnCD6ji/
         T7D2HQ+O/ZRAozy5waDZoewOIK/hmXFu65GgxBVv9Wzsl/E99kKQGBQRWBExOBWRy6Xg
         GLhw2ySClsWGHZDTmrbVIkwm0r0/GcijvTusNEuaVAGv+zYb5MptAp3y9KMXp/IEwpsU
         0fBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719864433; x=1720469233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HA1dU22m3UNj5lyj13MGSrb+8h3p7MYcfXDGMuEpnwo=;
        b=ThmEtcRJB+3sGKwDQrXbIDQg1mIEUL1pdszPtQ6nnzaF3ROzyXPWcJ3vTV7uAoKuBr
         2aYPg8Afm6wOGTpqKObBn4/e9lQLmbYi+M+0B2c+YcnmzYZGr9E8JFvtPImFDYWRMp1v
         VOv1nsm3/Cj1dCeLB4fc2LmlaLM/utoKh6e0fKzI2Ac64B8Qx/o9JYoqsTYOjqC2Mrla
         ATpZsz7z3Q6hQskanx2pUNex2l/3kF8KKLPK4sNwyxf7UlugAJkeKJAJ+BGMsqvLsmPr
         82I+1Sd3bAzTHjP/N7ltr8S8C7lvx1EfhQWugZGXSCgHOcFdG0RvPnZAkVh3/EtZOi3L
         6N+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUh2JWg1PixbNJ+CLGZ+QBi5Rqy4c0CPjSY3pTKd3JBpkIZ7L5eJDcRawy1yZUQ1+6jP+E/MwKjYgbmo/K1ccOUPivVDywxkcE=
X-Gm-Message-State: AOJu0YwtYPpuPfI8HUkkewTggtdPCsVrVFF6BNOuLKxWmIGSNFUpyF7t
	NM92VqsZa8ZNMoIxVTrvZocO6RETjkhFIFmg95DdhawZUlK8/X1hfuTgeqZrkMX/shI1cXTcmzW
	ZsdSk81qp9hTGiveyduFCVB0qatYUO9nOTYM2
X-Google-Smtp-Source: AGHT+IH9YyeTHtOmKWNRjWDZNOFaOcyjCIO5hmhn2IbnyBQewSRB362+m++tv5m6fkb6HeoZ2TpHUYTYJYIbCgB85hk=
X-Received: by 2002:a50:d799:0:b0:58b:93:b624 with SMTP id 4fb4d7f45d1cf-58b0093b6fdmr89607a12.1.1719864432894;
 Mon, 01 Jul 2024 13:07:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701162025.375134-1-robdclark@gmail.com>
In-Reply-To: <20240701162025.375134-1-robdclark@gmail.com>
From: Pranjal Shrivastava <praan@google.com>
Date: Tue, 2 Jul 2024 01:37:00 +0530
Message-ID: <CAN6iL-TCsS1dxwZngJ77J1MJcBeRsZW22W9uNLG59Z-isy9J5w@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] iommu/arm-smmu: Prettyify context fault messages
To: Rob Clark <robdclark@gmail.com>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	Stephen Boyd <swboyd@chromium.org>, Robin Murphy <robin.murphy@arm.com>, 
	Rob Clark <robdclark@chromium.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Georgi Djakov <quic_c_gdjako@quicinc.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jerry Snitselaar <jsnitsel@redhat.com>, Joerg Roedel <jroedel@suse.de>, Krishna Reddy <vdumpa@nvidia.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>, 
	"open list:TEGRA IOMMU DRIVERS" <linux-tegra@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 9:50=E2=80=AFPM Rob Clark <robdclark@gmail.com> wrot=
e:
>
> From: Rob Clark <robdclark@chromium.org>
>
> v3: Split out the reg bitfield renaming, rework
>     print_context_fault_info() helper
>
> Rob Clark (3):
>   iommu/arm-smmu: Add CB prefix to register bitfields
>   iommu/arm-smmu-qcom-debug: Do not print for handled faults
>   iommu/arm-smmu: Pretty-print context fault related regs
>
>  drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c  |  2 +-
>  .../iommu/arm/arm-smmu/arm-smmu-qcom-debug.c  | 66 ++++++-----------
>  drivers/iommu/arm/arm-smmu/arm-smmu.c         | 74 ++++++++++++++-----
>  drivers/iommu/arm/arm-smmu/arm-smmu.h         | 71 +++++++++++-------
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c       |  4 +-
>  5 files changed, 127 insertions(+), 90 deletions(-)
>
> --
> 2.45.2
>
For the series:

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

