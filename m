Return-Path: <linux-pm+bounces-5187-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D54A388596A
	for <lists+linux-pm@lfdr.de>; Thu, 21 Mar 2024 13:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65D19B2155C
	for <lists+linux-pm@lfdr.de>; Thu, 21 Mar 2024 12:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599CE83CC6;
	Thu, 21 Mar 2024 12:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrrGZyrK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359E5134CD
	for <linux-pm@vger.kernel.org>; Thu, 21 Mar 2024 12:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711025512; cv=none; b=iFuOnTu8uIsRQovnGxVHMOjRB1cq3q1Dx9kfEimE0iLEk98xdUAfnEsUh4luXtjiDmagBE6w+oNyuI/PsvyINeHXMXcLkbDm3LutS/prD0i8hmw7R7RJUJoFoyOI2uuOlzo9hKQn69yNAd/C2P2ebBenBKxCe2jBZwlOMZ5BYL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711025512; c=relaxed/simple;
	bh=tGUTPWiNZmyTEBmQziDuediW/cGY2FBlQG+fCi+BA9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YfdqL3m9/XejQSlHD6XUpslEjZLvXtG2e/bx9fSLnP/g314Z9r1jkL/gBHtIl4UkcpchqQvOF0FJvWVGibjzj/uiWwsqrhzKFewMj0VG+4tcYBbZPynNtIerI0aUCf7ZTw72wohLXIoiWi4bxdOCesG+/jWvrF+wBA6sIozEE6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrrGZyrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C29C43394
	for <linux-pm@vger.kernel.org>; Thu, 21 Mar 2024 12:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711025511;
	bh=tGUTPWiNZmyTEBmQziDuediW/cGY2FBlQG+fCi+BA9Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NrrGZyrKKjEECTuzKq90MGyAqyzkdLIF/toSoU6Lk+8XHIJ9sJVzN/VOMV/BL4qzy
	 jtY6ag8zvgAH38pm70TXiTVxNxCs5CopB9s8l79AqIOjzl3ND1sQuykH+MKvRLfNcJ
	 H8cGR76cM92+6qGaTYPfaTWjlmDai/J9iy+63B7rby5RY6By4dQqeyCyVYcX86HiFZ
	 D+Z15kOglwQN1SjaA7IyypBxwvUb3CvI3s8B7j+LOtC0W79S49aGFw/6HAJFqRHosp
	 yC/GMfwuqQphk3N/NDdpuVz1EfdXFQXPG3bzzV/+ygg2A+t+N4xa6N85FmorSnjdQt
	 hlmGLUGI/WaMw==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a468226e135so111442966b.0
        for <linux-pm@vger.kernel.org>; Thu, 21 Mar 2024 05:51:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX2UPqjK+dRHXSJy0Uc1pCPshIgmq+F6oV8dteueg6voG9egfgJ1ZKXkF7U3nSTk8qrUJtiSwxt1fbK2M1vHviNXi3qONa0+X8=
X-Gm-Message-State: AOJu0YxV4TTwgxxfp/mOY94ZO1APkZTCUzr3IK7gS387vEjVC+oORZGH
	Hu2z60udFUrS3mezNj53PvxER01l6R6o4bRTdfAbTnZW+BmGmRHM9LSWE8eYkFVs36LiezrAYaB
	28mPRr2k2g+lB+h/cCT5g19U4jPr40u8eJw/l9Q==
X-Google-Smtp-Source: AGHT+IF9LJJnNu/4TATmxOndPgF92tRzgiGuIaKaFdbT3d+oswzEGtu0Ett6AQN5j84PqwLpl+thbLmTq/iDiVXd1zk=
X-Received: by 2002:a17:906:11db:b0:a46:6808:2cee with SMTP id
 o27-20020a17090611db00b00a4668082ceemr14453611eja.66.1711025510397; Thu, 21
 Mar 2024 05:51:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227160928.2671-1-quic_priyjain@quicinc.com>
 <CAHLCerModb=01WX=q6XU0XO8dr5EaSQ5RaBoFLFc_=vpOGAgaw@mail.gmail.com> <06ab4347-3ed0-432a-cc36-49837d8a28de@quicinc.com>
In-Reply-To: <06ab4347-3ed0-432a-cc36-49837d8a28de@quicinc.com>
From: Amit Kucheria <amitk@kernel.org>
Date: Thu, 21 Mar 2024 18:21:39 +0530
X-Gmail-Original-Message-ID: <CAHLCerPnyT56WukNqX6_4gM7siczYBpSsb7XM_eW=vb5dBwceA@mail.gmail.com>
Message-ID: <CAHLCerPnyT56WukNqX6_4gM7siczYBpSsb7XM_eW=vb5dBwceA@mail.gmail.com>
Subject: Re: [PATCH v3] thermal/drivers/tsens: Add suspend to RAM support for tsens
To: Priyansh Jain <quic_priyjain@quicinc.com>
Cc: Thara Gopinath <thara.gopinath@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_manafm@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 4:19=E2=80=AFPM Priyansh Jain <quic_priyjain@quicin=
c.com> wrote:
>
>
>
> On 3/17/2024 1:37 AM, Amit Kucheria wrote:
> > On Tue, Feb 27, 2024 at 9:40=E2=80=AFPM Priyansh Jain <quic_priyjain@qu=
icinc.com> wrote:
> >>
> >> As part of suspend to RAM, tsens hardware will be turned off.
> >> While resume callback, re-initialize tsens hardware.
> >>
> >> Signed-off-by: Priyansh Jain <quic_priyjain@quicinc.com>
> >> ---
> >> V2 -> V3: Remove suspend callback & interrupt enablement part from
> >> resume callback.
> >> V1 -> V2: Update commit text to explain the necessity of this patch
> >>
> >>   drivers/thermal/qcom/tsens-v2.c |  1 +
> >>   drivers/thermal/qcom/tsens.c    | 40 +++++++++++++++++++++++++++++++=
++
> >>   drivers/thermal/qcom/tsens.h    |  6 +++++
> >>   3 files changed, 47 insertions(+)
> >>
> >> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/ts=
ens-v2.c
> >> index 29a61d2d6ca3..0cb7301eca6e 100644
> >> --- a/drivers/thermal/qcom/tsens-v2.c
> >> +++ b/drivers/thermal/qcom/tsens-v2.c
> >> @@ -107,6 +107,7 @@ static const struct reg_field tsens_v2_regfields[M=
AX_REGFIELDS] =3D {
> >>   static const struct tsens_ops ops_generic_v2 =3D {
> >>          .init           =3D init_common,
> >>          .get_temp       =3D get_temp_tsens_valid,
> >> +       .resume         =3D tsens_resume_common,
> >>   };
> >
> > Please add resume callbacks for the other tsens hardware too and make
> > sure that your reinit function handles them too.
> >
> We have discussed internally on this and we think that if someone wants
> to extend the support (and do the validation) of one of those old
> platforms they can add the resume ops for that platform. There are many
> versions of tsens hardware so we are bit skeptical to add reinit support
> for all these platforms with any validations(since S2R mode is not
> enabled for all these older platforms so it is not possible to validate).

Then why does tsens_reinit refer to tsens_version(priv) >=3D VER_0_1
when re-enabling the irq?

Perhaps we should explicitly disable platforms that are not validated
for this functionality (.resume =3D NULL) and have the reinit function
only work for validated platforms (tsens_version >=3D VER_2_X)?

Regards,
Amit

