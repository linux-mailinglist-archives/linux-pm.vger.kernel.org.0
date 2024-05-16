Return-Path: <linux-pm+bounces-7891-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 507678C72B3
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 10:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E440D1F2244E
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 08:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE9B6BFBF;
	Thu, 16 May 2024 08:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXe5xgEv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223CC27269;
	Thu, 16 May 2024 08:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715847843; cv=none; b=PSvYTztF436tqUHS0hiZ2VRGUftT2R2Lju1cDFw9oPaQ6po3NY+EtTDhxT4aKkEug/xkH3c210sxsuJk16mkYkgXeebPsCk2S1UeK2mHpNWBnHGRguZmZQoDOC0mWdovT+L339B9+qfcnU7JvWxB8mTqgfSMlBhOpP/6x1q/lks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715847843; c=relaxed/simple;
	bh=hyQRYxU63IRWE515n+lMY3Cdi+hKZmN00P0ekqCBH88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSPBgL0XXDdyAzqLYLFHMm+VAvsIbpNP1j4AA/6E6bTWdGRXu5bEz8EkLmnQI7ksB7epj5D0HwNX8bralDSpJ1aCS0PT4ZOWFMOGCIVGt172bd4VIrhLyqyItMz1h6zzLC1AusC4Govyu7L2doTNqFw3jtWxM6tAN5sidFnwri8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXe5xgEv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FE8C4AF0A;
	Thu, 16 May 2024 08:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715847841;
	bh=hyQRYxU63IRWE515n+lMY3Cdi+hKZmN00P0ekqCBH88=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lXe5xgEvnEx8z6PUz2pL5ixMNeh9XpCBd+ztAAPImIBffjdluWJbOGot6MJJHYgon
	 i7tkaVASeISGC99mWPn56DIyzlkyByDSJULcIBTgSjX1czoKnLFIN0ktsRgvjhz95b
	 ROSwAFfAUMXgtEbjc8nWee5UTGzLg3yLF7iVaVov4UGpqzJkRNnzvSkq6WtUTjUNLN
	 6ZsfYyEGu/j3bXLdpWIoeoqswVPpiRUOglZwZ9PyZC15dYyGiQ2B6Uf+nX5yfLLbJO
	 7BK+U80vECPNxhZCf2vvym/S/Xa9kEl/ZM2Qesv3jNBSj7xnnFo3EZAQ0HnYCGeg4q
	 X1UeTKCzJ1G9Q==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c998b36c6bso1280551b6e.3;
        Thu, 16 May 2024 01:24:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUml9uCrp2ruRN3U1TosrCUDW+Pe/Ei7+P5Aj0xvi2qs7fIsLqC9gNxQwy7x5jsJzgCL2vSqUq/0PzNO6ZvzJ/RWHshBXbyYs4kIbt0/Sw9T3t0K338dcOW5Odo7ixo1kGFedTl9Zc=
X-Gm-Message-State: AOJu0YzB2ayi9ix3Hdc0IE9qBiLSPOnl9CdN1MJi4PR5gcK4B8zTl8TP
	CmQTlwHOQ9E3YSwOE65YGnyKl+cJ7b/kWj/T3Te0y0MKx6pYva3O9y4pxeqODoPEylz1tc1Fylc
	Ron06IK/7x5hHWtwoVI372wuENiM=
X-Google-Smtp-Source: AGHT+IGM4DTxf1p6aeFTp0onaB5jzEKQ/ZjKRM8n/2o6y3957FE/RdcAQjcwPEB4Sc47z2x9EU4JE9wEVsKIH1mBsWI=
X-Received: by 2002:a05:6870:d0c6:b0:22d:fb4b:9d11 with SMTP id
 586e51a60fabf-24172fc0c29mr20760363fac.4.1715847841119; Thu, 16 May 2024
 01:24:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PUZPR01MB5120A03DFF0EA1CE70E7334E92ED2@PUZPR01MB5120.apcprd01.prod.exchangelabs.com>
 <a0ecb036-c760-447a-abfb-78fb7928fb9c@amd.com>
In-Reply-To: <a0ecb036-c760-447a-abfb-78fb7928fb9c@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 16 May 2024 10:23:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gWDAws8vOvLXo4WEcz_jr38=87giN=RJSg=O1ec6F4rg@mail.gmail.com>
Message-ID: <CAJZ5v0gWDAws8vOvLXo4WEcz_jr38=87giN=RJSg=O1ec6F4rg@mail.gmail.com>
Subject: Re: [PATCH v4] cpufreq: amd-pstate: fix the memory to free after epp exist
To: "Limonciello, Mario" <mario.limonciello@amd.com>
Cc: zhida312@outlook.com, rafael@kernel.org, viresh.kumar@linaro.org, 
	Peng Ma <andypma@tencent.com>, Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Perry Yuan <perry.yuan@amd.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 9:47=E2=80=AFAM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
>
>
> On 5/16/2024 1:30 AM, zhida312@outlook.com wrote:
> > From: andypma <andypma.tencent.com>
> >
> > the cpudata memory from kzmalloc in epp init function is
> > not free after epp exist, so we should free it.
> >
> > Signed-off-by: Peng Ma <andypma@tencent.com>
> >
> > Changes from v3 to v4:
> >       update subject used git command "git format-patch -1 -v x"
> >
> > Changes from v2 to v3:
> >       update Signed-off-by to Peng Ma <andypma@tencent.com>.
> >       set a space between if and "(".
> >
> > Changes from v1 to v2:
> >       check whether it is empty before releasing
> >       set driver_data is NULL after free
> > ---
>
> Thanks for your submission!
>
> I would prefer the change list below the cut list, but otherwise this is
> fine.  Maybe Rafael can modify that while committing.

I can do that no problem.

> Acked-by: Mario Limonciello <mario.limonciello@amd.com>

Thanks!

> >   drivers/cpufreq/amd-pstate.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.=
c
> > index 6a342b0c0140..1b7e82a0ad2e 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -1441,6 +1441,13 @@ static int amd_pstate_epp_cpu_init(struct cpufre=
q_policy *policy)
> >
> >   static int amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
> >   {
> > +     struct amd_cpudata *cpudata =3D policy->driver_data;
> > +
> > +     if (cpudata) {
> > +             kfree(cpudata);
> > +             policy->driver_data =3D NULL;
> > +     }
> > +
> >       pr_debug("CPU %d exiting\n", policy->cpu);
> >       return 0;
> >   }

