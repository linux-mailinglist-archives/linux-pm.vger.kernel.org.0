Return-Path: <linux-pm+bounces-20107-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4173A0631F
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 18:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEFD7188A51F
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 17:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A30D20011E;
	Wed,  8 Jan 2025 17:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HG8hJgG1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E521FFC7F;
	Wed,  8 Jan 2025 17:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736356530; cv=none; b=IbOEo4G4UL/gjn4wydlqhZXO+NNQn1lh1XbtHK3zbaSHyKfahfWVajMtzoj7WuP4O5SYOsrbbJHgWUNFJAp8GEFeMoa/7V3xk5xoihxnN/c7rY4FNtX8etK7sw3990gw+Rvad91v24r43slXytKuJTunppaBO3mX+CjW1OdyAxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736356530; c=relaxed/simple;
	bh=qYtetr5HMEGJr1ZUeZNui68qc0xfaK2HdPqXLaZLml4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=liKwsd/zvCpHG0gaNIK3Kl6pSiqDdY3NuiZNaVj/EvYTz3f4MJ6kF7NYZPlFTGYg8vUlEnKbmTSjxcJGTyhY+3ZtQoBKWlPDjLCkQWyK3SdTE4ugYbdpYxhOEaKNQB3SDoMUuliJ8rIScTp/NKIMJ46aSUbRPsgtBicWT/X/faY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HG8hJgG1; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-29f88004a92so11129175fac.1;
        Wed, 08 Jan 2025 09:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736356525; x=1736961325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQjSIB+SpA8Xj2XbGtqFG9O6snqi8JpWaZDvK39g3CU=;
        b=HG8hJgG15ETw5WXFi6RCiARDe/dj/3aA4bpHrpFHZAPkwi/1HLPJHuPpALRmVCw9QF
         SI637v/GBf4w5O7VfUc2NuLvRXgzh1X3f213hCZOVbrf4uMTAiqSop6dFzUDZCHz9Wgv
         u9VZSyD7KOx0LcGIMa8Bc+YX95FEy4mYSn7H8caBKtECU59NvailEmVvI9e6fDZVzjtR
         5ybmPRksnHqmKsYEV30EPatuph6qHI/1PxfrUcXDiqZKf3TUCjJ0X2ISWb18jyGA/2wL
         qzTZjlsIGfZPvWJr9BLI0ri/gUwGhJFW+Z5CcshlUbzqUeOwniCxqG2U92z7I/WIzHxR
         rfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736356525; x=1736961325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQjSIB+SpA8Xj2XbGtqFG9O6snqi8JpWaZDvK39g3CU=;
        b=FMV9Q17tPENXSy9o/E6JQk0cn4xXeyNJTRNBu2Pzw7E0UQNXgSVg/zw5fMrVmyr2nY
         AoE7pvh6pW++8NlKRdbfhDZZPpBZCAl/e+uQO1nlF41sWxbEvrgzWCnYcRtoFdii39kk
         aefmfmqxrowE5Rf8k7ZX/PW5vyhpvSJwaxFgGbAtd6TeO2bgRUIyq4kXrxit3OFzPAy1
         6qxn6GulUFYmWtbzX5AATIhO0JIXvrtZPKvEc8LbWlVsZbgzwT/6fQEJsvLpeuvc7iXN
         cJ64jodDxjpcvOZ5ITurfebmcitkzVisMEBRGSwImg8klY2M6C/8m4c4WPhTxp6op1/l
         LVrg==
X-Forwarded-Encrypted: i=1; AJvYcCU1Ux6oCdXUNXmpeqz3BLf+PZoJ2lLn/DY1lxdDWgrlrs7rwz+dgacov1eo6vXbGVDUVPuUtqVMzH1tjtmCJw==@vger.kernel.org, AJvYcCUdxs9XEkA/jjUxMysyrfwbp0tzjd5xVO9XjvjpWmQzLJgmUlvc9EU3g5+HtYXSlSWsIeDFtEQCYTjV@vger.kernel.org, AJvYcCUmJcMVtO4lZ2EtZ6srTer210zES1/O4J8n44YAmlAymQGiN1DfZMgh6wduhqeNRIJrNcp16jUO8Uo9rXcz@vger.kernel.org, AJvYcCVr+W9QTM00Z+UGUVJQQ8Q1kj05r2Rv7jVbxjvxORvOl1Rz6gNgIhXzMUjLmrfLkXHETeGrfmcWJME=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhqNrN6HWHMqHPm+SP+GYquCS1sS9oxFm2B7c04tMCRoCepGi5
	OID6AOhTX9ftgN9WTpfmI3Dtdfy8TPZZ1A4jCTRT0O9Dwc1VAvjVtwBoyEHQT0dJKVb0/+sYT8Z
	xk7E6PXf8uFfCep2FnLU4QdfOufw=
X-Gm-Gg: ASbGncvpAZi3wgSsMar0APQrWzWDS5ySE93sOadfLSSwxFTzJLPPbLj6uXI9BctSwmO
	S2rKroiWr3kmFKBYcb5akEmGpLoUFC2o2jVX562dBgeKrazJ8BxbvTvhTs4U2FxyASl75LXU=
X-Google-Smtp-Source: AGHT+IFOYu2zI0eI/ZEBSXvRujyJw5sTg9SU8LM20UymNfmWYiLeo3rutyCnE9H4ti6sd4aPiSqdNSeAmK4V7RQnZSM=
X-Received: by 2002:a05:6871:d106:b0:296:e6d9:a2e1 with SMTP id
 586e51a60fabf-2aa066af572mr1855075fac.11.1736356525229; Wed, 08 Jan 2025
 09:15:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241231-gpu-acd-v3-0-3ba73660e9ca@quicinc.com>
 <CAO_MupJ21kOQPZG_=87mC-fQKmL=-K9AgOjriWR=wXCKU0897w@mail.gmail.com>
 <CAF6AEGvYFL9Q88c727eFrTgDb+FvnPm2d=6niLu80DM1DJdm5g@mail.gmail.com> <20250106195539.tcta6yoyijfrgzhh@hu-akhilpo-hyd.qualcomm.com>
In-Reply-To: <20250106195539.tcta6yoyijfrgzhh@hu-akhilpo-hyd.qualcomm.com>
From: Maya Matuszczyk <maccraft123mc@gmail.com>
Date: Wed, 8 Jan 2025 18:14:46 +0100
X-Gm-Features: AbW1kvZoIa1SIG2WBthB7htvGPGQe3KsLSA-x7LZ0U_Ys8L5v4xzXxkp0ix07rU
Message-ID: <CAO_MupJZ+eGUNGXSd7jwEaC6DeZt60LNW_V_38-Jcpmbiy_9Bg@mail.gmail.com>
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

pon., 6 sty 2025 o 20:55 Akhil P Oommen <quic_akhilpo@quicinc.com> napisa=
=C5=82(a):
>
> On Sun, Jan 05, 2025 at 04:55:42PM -0800, Rob Clark wrote:
> > fwiw, I did see some perf boost (was mainly looking at gfxbench aztec
> > ruins vk high/normal, and also a separate mesa MR that fixes some LRZ
> > issues with turnip, so I don't remember how much boost was related to
> > which offhand)..  I've not seen corruption yet (gnome-shell / f41),
> > although what you describe sounds cache-line(ish) and could be just
> > timing related.  You could limit max freq via
> > /sys/devices/platform/soc@0/3d00000.gpu/devfreq/3d00000.gpu/max_freq
> > and see if that "fixes" things.  I don't really expect this patchset
> > to introduce these sorts of issues, but maybe the increased freq
> > exposes some preexisting conditions?
>
> Actually, ACD related issues may show up as weird glitches in HW because
> of HW spec violation. These issues are very very rare in production
> devices though. And the behavior may vary between devices due to silicon
> variations.
>
> @Maya, thanks for testing this series. Sorry, one of my patch is buggy.
> Could you please apply the below diff and check once?
>
> --- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> @@ -725,7 +725,7 @@ static int a6xx_hfi_enable_acd(struct a6xx_gmu *gmu)
>         }
>
>         /* Send ACD table to GMU */
> -       ret =3D a6xx_hfi_send_msg(gmu, HFI_H2F_MSG_ACD, &msg, sizeof(msg)=
, NULL, 0);
> +       ret =3D a6xx_hfi_send_msg(gmu, HFI_H2F_MSG_ACD, acd_table, sizeof=
(*acd_table), NULL, 0);
>         if (ret) {
>                 DRM_DEV_ERROR(gmu->dev, "Unable to ACD table (%d)\n", ret=
);
>                 return ret;
>
> --- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> @@ -109,7 +109,7 @@ static int a6xx_hfi_wait_for_ack(struct a6xx_gmu *gmu=
, u32 id, u32 seqnum,
>
>         /* Wait for a response */
>         ret =3D gmu_poll_timeout(gmu, REG_A6XX_GMU_GMU2HOST_INTR_INFO, va=
l,
> -               val & A6XX_GMU_GMU2HOST_INTR_INFO_MSGQ, 100, 5000);
> +               val & A6XX_GMU_GMU2HOST_INTR_INFO_MSGQ, 100, 1000000);
>
>         if (ret) {
>                 DRM_DEV_ERROR(gmu->dev,
>

With this change on top of this patch series I'm seeing an increase in
vkmark scores roughly in line with increased frequency.



>
> -Akhil
> >
> > BR,
> > -R
> >
> > On Sun, Jan 5, 2025 at 9:56=E2=80=AFAM Maya Matuszczyk <maccraft123mc@g=
mail.com> wrote:
> > >
> > > Hi,
> > > I've applied this series for testing, and I've no performance
> > > increase, and some screen corruption, there's some lines(mostly white=
)
> > > on my yoga slim 7x that appear on the bottom of the screen. When I
> > > move my cursor in swaywm over it, the lines get occluded by the curso=
r
> > > and screenshots don't show these lines.
> > >
> > > Best Regards,
> > > Maya Matuszczyk
> > >
> > > pon., 30 gru 2024 o 22:11 Akhil P Oommen <quic_akhilpo@quicinc.com> n=
apisa=C5=82(a):
> > > >
> > > > This series adds support for ACD feature for Adreno GPU which helps=
 to
> > > > lower the power consumption on GX rail and also sometimes is a requ=
irement
> > > > to enable higher GPU frequencies. At high level, following are the
> > > > sequences required for ACD feature:
> > > >         1. Identify the ACD level data for each regulator corner
> > > >         2. Send a message to AOSS to switch voltage plan
> > > >         3. Send a table with ACD level information to GMU during ev=
ery
> > > >         gpu wake up
> > > >
> > > > For (1), it is better to keep ACD level data in devicetree because =
this
> > > > value depends on the process node, voltage margins etc which are
> > > > chipset specific. For instance, same GPU HW IP on a different chips=
et
> > > > would have a different set of values. So, a new schema which extend=
s
> > > > opp-v2 is created to add a new property called "qcom,opp-acd-level"=
.
> > > >
> > > > ACD support is dynamically detected based on the presence of
> > > > "qcom,opp-acd-level" property in GPU's opp table. Also, qmp node sh=
ould be
> > > > present under GMU node in devicetree for communication with AOSS.
> > > >
> > > > The devicetree patch in this series adds the acd-level data for X1-=
85
> > > > GPU present in Snapdragon X1 Elite chipset.
> > > >
> > > > The last two devicetree patches are for Bjorn and all the rest for
> > > > Rob Clark.
> > > >
> > > > ---
> > > > Changes in v3:
> > > > - Rebased on top of v6.13-rc4 since X1E doesn't boot properly with =
msm-next
> > > > - Update patternProperties regex (Krzysztof)
> > > > - Update MAINTAINERS file include the new opp-v2-qcom-adreno.yaml
> > > > - Update the new dt properties' description
> > > > - Do not move qmp_get() to acd probe (Konrad)
> > > > - New patches: patch#2, #3 and #6
> > > > - Link to v2: https://lore.kernel.org/r/20241021-gpu-acd-v2-0-9c25a=
62803bc@quicinc.com
> > > >
> > > > Changes in v2:
> > > > - Removed RFC tag for the series
> > > > - Improve documentation for the new dt bindings (Krzysztof)
> > > > - Add fallback compatible string for opp-table (Krzysztof)
> > > > - Link to v1: https://lore.kernel.org/r/20241012-gpu-acd-v1-0-1e5e9=
1aa95b6@quicinc.com
> > > >
> > > > ---
> > > > Akhil P Oommen (6):
> > > >       drm/msm/adreno: Add support for ACD
> > > >       drm/msm: a6x: Rework qmp_get() error handling
> > > >       drm/msm/adreno: Add module param to disable ACD
> > > >       dt-bindings: opp: Add v2-qcom-adreno vendor bindings
> > > >       arm64: dts: qcom: x1e80100: Add ACD levels for GPU
> > > >       arm64: dts: qcom: x1e80100: Add OPPs up to Turbo L3 for GPU
> > > >
> > > >  .../bindings/opp/opp-v2-qcom-adreno.yaml           | 97 ++++++++++=
++++++++++++
> > > >  MAINTAINERS                                        |  1 +
> > > >  arch/arm64/boot/dts/qcom/x1e80100.dtsi             | 25 +++++-
> > > >  drivers/gpu/drm/msm/adreno/a6xx_gmu.c              | 96 ++++++++++=
++++++++---
> > > >  drivers/gpu/drm/msm/adreno/a6xx_gmu.h              |  1 +
> > > >  drivers/gpu/drm/msm/adreno/a6xx_hfi.c              | 36 ++++++++
> > > >  drivers/gpu/drm/msm/adreno/a6xx_hfi.h              | 21 +++++
> > > >  drivers/gpu/drm/msm/adreno/adreno_device.c         |  4 +
> > > >  8 files changed, 268 insertions(+), 13 deletions(-)
> > > > ---
> > > > base-commit: dbfac60febfa806abb2d384cb6441e77335d2799
> > > > change-id: 20240724-gpu-acd-6c1dc5dcf516
> > > >
> > > > Best regards,
> > > > --
> > > > Akhil P Oommen <quic_akhilpo@quicinc.com>
> > > >
> > > >

