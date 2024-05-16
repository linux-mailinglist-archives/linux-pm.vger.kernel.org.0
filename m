Return-Path: <linux-pm+bounces-7885-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6378E8C70D3
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 06:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11B32B22581
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 04:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365B3441D;
	Thu, 16 May 2024 04:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="i7pafl0W"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECC44691
	for <linux-pm@vger.kernel.org>; Thu, 16 May 2024 04:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715832606; cv=none; b=HpwU5WFMEcUIZLNuxdFWycMi2HtFKzCazTKgaJCe7JklvoLBUzyQhEuZVyv0MtdVTtWDLG1VsSVEFFz+Hvvb/saVauajvL+atl8Wb23OJYTBIvMjoDcdeXC1Ra2gZorQYksZznArsEjMFWuUCGhbKAFiLlajqFtxmx3ql2QFEjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715832606; c=relaxed/simple;
	bh=c1j0wXz3522Y57qEplsyQOhz+FYX8Kznq+LiDDoyDnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMk1WFeJE0/EoJwCm/aoEV6hkxcuUzEs+flb7pUtdKoJW/59vbeoEVgTv0YgIQYlF0a/ilYU6Uog/eiglqjkeI7Ssk6Qlfd8hPRxQ4jlwAWy2nZBS3FK1khELVq3VGXZr1gYSGO/xORgJp6vU8hjECCbY5+CiSbo9tfyOHxMbKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=i7pafl0W; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5b2735f217aso4121969eaf.2
        for <linux-pm@vger.kernel.org>; Wed, 15 May 2024 21:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715832603; x=1716437403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFrog2h5nAkzpq5WoUadeeUmrdg//eB0XW+3OoY88O0=;
        b=i7pafl0WO2AxPLdD0GRqa0HmJx2uhXkS58pCsBy3LG3uSTQnurntnyGxrR9kBIxMe7
         McqzdkvMTgNCjjXpuNxR96nZf8kYAeWi/5TUvaFHsXdr6WczIE/jWHYSO/r5qpcDCLDt
         WarxKCJKE8LR0LTuydy9xt5XspOe/owzIHqEg5HKcxbn9NPYuKKaTU1MIkwcAxvLRHOu
         TmAEwUZsSHBDfBMlRu5P8iCfM2dTMLXjY+hOfBrhLa3/+6I6zRESyTNO+FKdq1X50AXp
         XSZvTDrrvUTC6cw9gX5+4vFTl3mtdV0ZmaU7GtbCyDGyp4NWW0i/ObaHN1qvS6cTUgUw
         EPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715832603; x=1716437403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFrog2h5nAkzpq5WoUadeeUmrdg//eB0XW+3OoY88O0=;
        b=UxOJ3Zs7b6AvyRJ67apEbuvKsuPRgF/N5IrEQql+byiYKXm1zXl9HLasvZOa8W7Arq
         eFmEghIEsur5dQtG4SfsYEWjwVzqAhMkQYy8hyaCfmLr7IxPaQYnPVJ1arKQ49Jq6RXQ
         pSuCpBO+ed2FMkOVch0soR7tyPEh8ntf1RmjaeGZbsw1DirNklWRh3L8nQ3yz18m9GAM
         Ii7OaueOXb69uJE0W+6gz3v3FIIdI8kpNsIW/VeHB4afEqqLxTpodIWbuX3SYnpTgioX
         A3+2Zr/wGA3QwG3JIfw/yM/1ITwuEsPUcKgolLYS+EeNQbuqcbhpTEiXw7AAEOJYF3W9
         B2Qg==
X-Forwarded-Encrypted: i=1; AJvYcCU/tPnBzAAL10hW0rixXvkyI9BuGXWeLKro/A+k1l6t1vmMAOD9bfL9d8C8dIfzsjd+hHxy9yGYX5k2qXDRPYq0XfL9L7MFcl0=
X-Gm-Message-State: AOJu0YxIQiJ1YrPvdi7T3m0E7x0k29ohdBNzL0/aQDGK7EiV4tH1+aCb
	BEfA6EPuPpJjidn1+isGc+xlpRY5NVO+008VDyhYlJFmwj5pXL5LzJErQ7hqCkEvVyPO3kV5c/g
	9fKL74ZRkh0+zwKJj0IlWiBRbdbmySO+OSvhdPA==
X-Google-Smtp-Source: AGHT+IEZwOTguoznC6GO7B8DWo9mKJcJa+X8xXJwVFs0MwvGABgNROFhXX+idM0oJv5WOU5cfX3Gc8V5kZLRXZTdZrY=
X-Received: by 2002:a05:6870:d106:b0:23c:cab7:1310 with SMTP id
 586e51a60fabf-241730dc0edmr24147517fac.56.1715832602830; Wed, 15 May 2024
 21:10:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226065113.1690534-1-nick.hu@sifive.com> <CAPDyKFph3WsZMmALnzBQKE4S_80Ji5h386Wi0vHda37QUsjMtg@mail.gmail.com>
 <CAKddAkDcdaXKzpcKN=LCCx9S4Trv+joLX2s=nyhzaRtM5HorqA@mail.gmail.com>
 <CAKddAkC6N=Cfo0z+F8herKTuJzCyt_MA0vWNbLCr6CbQnj0y8g@mail.gmail.com>
 <CAPDyKFr_M0NDH0gaunBpybnALOFfz4LpX4_JW2GCUxjwGzdZsg@mail.gmail.com>
 <CAKddAkC5CRX+ZTh=MgzPYU72SY13+AQYhknhV_CC+=XX9=DKyg@mail.gmail.com>
 <CAAhSdy1SDd=VUqDQA0T5n9LwHo=3uGzFq1dUcbDFcB3aBdaioA@mail.gmail.com>
 <CAAhSdy33DcNw+pbDRrR=hBH86kwvu3xZbomQby8XhRXcc-exqQ@mail.gmail.com>
 <CAKddAkBrP2iQBC+aY1Xw5pssBpiQZe4V-6ww5m8hbKP6V0jzLg@mail.gmail.com> <CAAhSdy12-_Hdb-WVrs8kyfCy_OQA0p27DS6TOV87dh9HODrU_Q@mail.gmail.com>
In-Reply-To: <CAAhSdy12-_Hdb-WVrs8kyfCy_OQA0p27DS6TOV87dh9HODrU_Q@mail.gmail.com>
From: Nick Hu <nick.hu@sifive.com>
Date: Thu, 16 May 2024 12:09:52 +0800
Message-ID: <CAKddAkCQOvnci-bzKx1pBUJh5t1uPT-wNXGH1WyqDyb5qR_Scg@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: riscv-sbi: Add cluster_pm_enter()/exit()
To: Anup Patel <anup@brainfault.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, palmer@dabbelt.com, rafael@kernel.org, 
	daniel.lezcano@linaro.org, paul.walmsley@sifive.com, linux-pm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	zong.li@sifive.com, Cyan Yang <cyan.yang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Anup

On Wed, May 15, 2024 at 9:46=E2=80=AFPM Anup Patel <anup@brainfault.org> wr=
ote:
>
> Hi Nick,
>
> On Wed, May 15, 2024 at 5:45=E2=80=AFPM Nick Hu <nick.hu@sifive.com> wrot=
e:
> >
> > Hi Anup,
> >
> > Thank you for your guidance.
> > After enabling the debug message, we found a way to solve the problem
> > by the following steps:
> > 1. Add a compatible string in 'power-domains' node otherwise it won't
> > be the supplier of the consumers. (See of_link_to_phandle())
>
> Hmm, requiring a compatible string is odd. Where should we document
> this compatible string ?
>
Sorry, this is my fault. I didn't include some updates in
of_link_to_phandle(). This led some misunderstandings here.
You are right, we don't need it.
The supplier will be linked to the CLUSTER_PD node.

> > 2. Move the 'power-domains' node outside the 'cpus' node otherwise it
> > won't be added to the device hierarchy by device_add().
> > 3. Update the cpuidle-riscv-sbi driver to get the pds_node from
> > '/power-domains'.
>
> By adding a compatible string and moving the "power-domains" node
> outside, you are simply forcing the OF framework to populate devices.
>
> How about manually creating platform_device for each power-domain
> DT node using of_platform_device_create() in sbi_pd_init() ?
>
Thanks for the suggestion! We have test the solution and it could work.
We was wondering if it's feasible for us to relocate the
'power-domains' node outside of the /cpus? The CLUSTER_PD might
encompass not only the CPUs but also other components within the
cluster.

We also look at cpuidle_psci_domain driver and it seems Arm doesn't
create the devices for each subnode of psci domain.
Is there any reason that they don't need it?

> >
> > So the DTS will be like:
> > cpus {
> >     ...
> >      domain-idle-states {
> >            CLUSTER_SLEEP:cluster-sleep {
> >                         compatible =3D "domain-idle-state";
> >                         ...
> >             }
> >      }
> > }
> > power-domains {
> >             compatible =3D "riscv,sbi-power-domains"
> >             ...
> >             ...
> >             CLUSTER_PD: clusterpd {
> >                     domain-idle-states =3D <&CLUSTER_SLEEP>;
> >             };
> > }
> > soc {
> >       deviceA@xxx{
> >              ...
> >              power-domains =3D <&CLUSTER_PD>;
> >              ...
> >       }
> > }
>
> Regards,
> Anup
>
> >
> > Regards,
> > Nick
> >
> > On Tue, May 14, 2024 at 10:54=E2=80=AFPM Anup Patel <anup@brainfault.or=
g> wrote:
> > >
> > > On Tue, May 14, 2024 at 7:53=E2=80=AFPM Anup Patel <anup@brainfault.o=
rg> wrote:
> > > >
> > > > Hi Nick,
> > > >
> > > > On Tue, May 14, 2024 at 3:20=E2=80=AFPM Nick Hu <nick.hu@sifive.com=
> wrote:
> > > > >
> > > > > Hi Ulf,
> > > > >
> > > > > Thank you for your valuable suggestion.
> > > > > I sincerely apologize for the delay in responding to your message=
. We
> > > > > have diligently worked on experimenting with the suggestion you
> > > > > provided.
> > > > >
> > > > > As per your recommendation, we have incorporated the "power-domai=
ns=3D<>
> > > > > property" into the consumer's node, resulting in modifications to=
 the
> > > > > DTS as illustrated below:
> > > > >
> > > > > cpus {
> > > > >     ...
> > > > >      domain-idle-states {
> > > > >            CLUSTER_SLEEP:cluster-sleep {
> > > > >                         compatible =3D "domain-idle-state";
> > > > >                         ...
> > > > >             }
> > > > >      }
> > > > >      power-domains {
> > > > >             ...
> > > > >             ...
> > > > >             CLUSTER_PD: clusterpd {
> > > > >                     domain-idle-states =3D <&CLUSTER_SLEEP>;
> > > > >             };
> > > > >      }
> > > > > }
> > > > > soc {
> > > > >       deviceA@xxx{
> > > > >              ...
> > > > >              power-domains =3D <&CLUSTER_PD>;
> > > > >              ...
> > > > >       }
> > > > > }
> > > > >
> > > > > However, this adjustment has led to an issue where the probe for
> > > > > 'deviceA' is deferred by 'device_links_check_suppliers()' within
> > > > > 'really_probe()'. In an attempt to mitigate this issue, we
> > > > > experimented with a workaround by adding the attribute
> > > > > "status=3D"disabled"" to the 'CLUSTER_PD' node. This action aimed=
 to
> > > > > prevent the creation of a device link between 'deviceA' and
> > > > > 'CLUSTER_PD'. Nevertheless, we remain uncertain about the
> > > > > appropriateness of this solution.
> > > > >
> > > > > Do you have suggestions on how to effectively address this issue?
> > > >
> > > > I totally missed this email since I was not CC'ed sorry about that.=
 Please
> > > > use get_maintainers.pl when sending patches.
> > >
> > > I stand corrected. This patch had landed in the "spam" folder. I don'=
t know why.
> > >
> > > Regards,
> > > Anup
> > >
> > > >
> > > > The genpd_add_provider() (called by of_genpd_add_provider_simple())
> > > > does mark the power-domain DT node as initialized (fwnode_dev_initi=
alized())
> > > > so after the cpuidle-riscv-sbi driver is probed the 'deviceA' depen=
dency is
> > > > resolved and 'deviceA' should be probed unless there are other unme=
t
> > > > dependencies.
> > > >
> > > > Try adding "#define DEBUG" before all includes in drivers/core/base=
.c
> > > > and add "loglevel=3D8" in kernel parameters, this will print produc=
er-consumer
> > > > linkage of all devices.
> > > >
> > > > Marking the power-domain DT node as "disabled" is certainly not the
> > > > right way.
> > > >
> > > > Regards,
> > > > Anup
> > > >
> > > > >
> > > > > Regards,
> > > > > Nick
> > > > >
> > > > > On Tue, Apr 30, 2024 at 4:13=E2=80=AFPM Ulf Hansson <ulf.hansson@=
linaro.org> wrote:
> > > > > >
> > > > > > On Mon, 29 Apr 2024 at 18:26, Nick Hu <nick.hu@sifive.com> wrot=
e:
> > > > > > >
> > > > > > > On Tue, Apr 30, 2024 at 12:22=E2=80=AFAM Nick Hu <nick.hu@sif=
ive.com> wrote:
> > > > > > > >
> > > > > > > > Hi Ulf
> > > > > > > >
> > > > > > > > On Mon, Apr 29, 2024 at 10:32=E2=80=AFPM Ulf Hansson <ulf.h=
ansson@linaro.org> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, 26 Feb 2024 at 07:51, Nick Hu <nick.hu@sifive.com=
> wrote:
> > > > > > > > > >
> > > > > > > > > > When the cpus in the same cluster are all in the idle s=
tate, the kernel
> > > > > > > > > > might put the cluster into a deeper low power state. Ca=
ll the
> > > > > > > > > > cluster_pm_enter() before entering the low power state =
and call the
> > > > > > > > > > cluster_pm_exit() after the cluster woken up.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > > > > > > > >
> > > > > > > > > I was not cced this patch, but noticed that this patch go=
t queued up
> > > > > > > > > recently. Sorry for not noticing earlier.
> > > > > > > > >
> > > > > > > > > If not too late, can you please drop/revert it? We should=
 really move
> > > > > > > > > away from the CPU cluster notifiers. See more information=
 below.
> > > > > > > > >
> > > > > > > > > > ---
> > > > > > > > > >  drivers/cpuidle/cpuidle-riscv-sbi.c | 24 +++++++++++++=
+++++++++--
> > > > > > > > > >  1 file changed, 22 insertions(+), 2 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/driv=
ers/cpuidle/cpuidle-riscv-sbi.c
> > > > > > > > > > index e8094fc92491..298dc76a00cf 100644
> > > > > > > > > > --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> > > > > > > > > > +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> > > > > > > > > > @@ -394,6 +394,7 @@ static int sbi_cpuidle_pd_power_off=
(struct generic_pm_domain *pd)
> > > > > > > > > >  {
> > > > > > > > > >         struct genpd_power_state *state =3D &pd->states=
[pd->state_idx];
> > > > > > > > > >         u32 *pd_state;
> > > > > > > > > > +       int ret;
> > > > > > > > > >
> > > > > > > > > >         if (!state->data)
> > > > > > > > > >                 return 0;
> > > > > > > > > > @@ -401,6 +402,10 @@ static int sbi_cpuidle_pd_power_of=
f(struct generic_pm_domain *pd)
> > > > > > > > > >         if (!sbi_cpuidle_pd_allow_domain_state)
> > > > > > > > > >                 return -EBUSY;
> > > > > > > > > >
> > > > > > > > > > +       ret =3D cpu_cluster_pm_enter();
> > > > > > > > > > +       if (ret)
> > > > > > > > > > +               return ret;
> > > > > > > > >
> > > > > > > > > Rather than using the CPU cluster notifiers, consumers of=
 the genpd
> > > > > > > > > can register themselves to receive genpd on/off notifiers=
.
> > > > > > > > >
> > > > > > > > > In other words, none of this should be needed, right?
> > > > > > > > >
> > > > > > > > Thanks for the feedback!
> > > > > > > > Maybe I miss something, I'm wondering about a case like bel=
ow:
> > > > > > > > If we have a shared L2 cache controller inside the cpu clus=
ter power
> > > > > > > > domain and we add this controller to be a consumer of the p=
ower
> > > > > > > > domain, Shouldn't the genpd invoke the domain idle only aft=
er the
> > > > > > > > shared L2 cache controller is suspended?
> > > > > > > > Is there a way that we can put the L2 cache down while all =
cpus in the
> > > > > > > > same cluster are idle?
> > > > > > > > > [...]
> > > > > > > Sorry, I made some mistake in my second question.
> > > > > > > Update the question here:
> > > > > > > Is there a way that we can save the L2 cache states while all=
 cpus in the
> > > > > > > same cluster are idle and the cluster could be powered down?
> > > > > >
> > > > > > If the L2 cache is a consumer of the cluster, the consumer driv=
er for
> > > > > > the L2 cache should register for genpd on/off notifiers.
> > > > > >
> > > > > > The device representing the L2 cache needs to be enabled for ru=
ntime
> > > > > > PM, to be taken into account correctly by the cluster genpd. In=
 this
> > > > > > case, the device should most likely remain runtime suspended, b=
ut
> > > > > > instead rely on the genpd on/off notifiers to understand when
> > > > > > save/restore of the cache states should be done.
> > > > > >
> > > > > > Kind regards
> > > > > > Uffe

