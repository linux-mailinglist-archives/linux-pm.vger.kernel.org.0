Return-Path: <linux-pm+bounces-7872-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 720C48C67AE
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2024 15:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951C41C212F6
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2024 13:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A855513EFE0;
	Wed, 15 May 2024 13:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="vrNcb+QU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C1613E8BE
	for <linux-pm@vger.kernel.org>; Wed, 15 May 2024 13:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715780770; cv=none; b=fHjO13LH2iUj/RjfvI+VBAZMg8YZ/fFsnmILg751k+YrTQr06Mq7V7wZbg1HtXNWnYL7DiEZzEYB1/pEtPP1/AkgTT3RR1eDR5eqRzlHL2ByLFuiNrBuUVEkhijWi3hjg8a0XEzTeZ3VNhsmkt0VtwIvqTfKdnwdmihe+DenzJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715780770; c=relaxed/simple;
	bh=5HjW26lbca6Llyx8ImP/yLnLhZdrPXey2HunqutPGao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZxtD/J5e7USKXsUj3L7Mnnin5UX+cedCk3YJxFKlUM1MPBzjK22YoPw2SdF4dd84NrOmB8bYJ5murftxVlQXqDDr8r+ltxYZgFanG28NA9OcKWbwITlItm3ZrdB8v99/516e+NSiJogtm7JzFMV6zOUPfP0opPFEOQJBpfgy9tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=vrNcb+QU; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7e1b547cf45so319297839f.3
        for <linux-pm@vger.kernel.org>; Wed, 15 May 2024 06:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1715780768; x=1716385568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnyM/dK6i4JOoTGho3SZkvUn6rmUzkYCgudsHIyI/Hk=;
        b=vrNcb+QUdMw17UpZuw8emOHdB1D8lrq1pIrqxQK2+aptyJP7TycKVF5HoPBW1ogkyn
         x4DnKg1DzoA9ZM9uJxSQVStgzeSyG+DYt/RLxGMzK32pt1y23lFfTam67QaQe5o8ScOr
         1fmkfeFJYA4scNGUIHHyNqpINGRAxlsc+EpS+mfHDgsKA3P6TY3dcaJmDRUesVMIweXB
         k9vstpuVmlZvEIxoHsfzp+lT9EMyltmSSd9wYZ50qJKQDBzETgxR8/3YKiP8tsaykiUj
         VszjPAB6quzLVhYbsSlYAWWzPd+vP0XUIOhKRXgaF7z3vUv3NIpLQ28ulPNEBjuz/CGJ
         idaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715780768; x=1716385568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YnyM/dK6i4JOoTGho3SZkvUn6rmUzkYCgudsHIyI/Hk=;
        b=aVUPP9GZGn5Km2cm65lR4ikenRl+kMTTfCjRouWv9AhFiZyG0IIIKNjQmQ8vTavbTU
         RGg6E4emhcaWXKVmGDRaDJLqBa3KWiYAXbt8xfoibq9HG/Owxy+H/I23WQbvxNaPs0M9
         G98kCg1c5VTUOHxXhIih/ad/CXOJTWiqxUTOrfVK5s9ObKUKNJe36zOojw3TS2EcXyYJ
         8GftOcD801ujg38mRs7uYsiNL8JxSOI7uY4W5pry8gEu6+30OwYZcW+h3ZNeVfuHc4mQ
         LqDAilcxiKBXj0pLttw4X66ZywZOFM81wkV16CMfu35dywfj7EWaVDD32/OO8xkaRQt/
         bLwA==
X-Forwarded-Encrypted: i=1; AJvYcCWCmKvqYRV6NlJCQDNmqthHJj9IpH5zfgtwVVHTw7ejAjmpRuySnMtZRuzqYzuEH3w5GX60hSC+id0vit0Sd/dEvgDQO28KSVc=
X-Gm-Message-State: AOJu0Yy/lZxiiPnMRYScnJeqSkKmaNszN4cnKofNAFaeFJSnUZzpCAjG
	HEgoYburgYqUAAhVSBQXAM1dvYFfp9NCdhkYZSq6mV142vYxoFFTy4DVHzGrI8q5kbx2vrSaR+t
	uNSxOJdrTfWeTje25H/+InR3lEP3Ia/Xe3RCKHA==
X-Google-Smtp-Source: AGHT+IGhC7f9/a84tl8qwHPKxs/t6nBikbVAhSqnh9SlC8tOa4tCfgr2qv+NbhGoQpYF1Oiy5M1gKwhhBdBIvTY3enY=
X-Received: by 2002:a05:6e02:1a89:b0:36c:c566:31e with SMTP id
 e9e14a558f8ab-36cc56606b1mr177450505ab.20.1715780767814; Wed, 15 May 2024
 06:46:07 -0700 (PDT)
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
 <CAAhSdy33DcNw+pbDRrR=hBH86kwvu3xZbomQby8XhRXcc-exqQ@mail.gmail.com> <CAKddAkBrP2iQBC+aY1Xw5pssBpiQZe4V-6ww5m8hbKP6V0jzLg@mail.gmail.com>
In-Reply-To: <CAKddAkBrP2iQBC+aY1Xw5pssBpiQZe4V-6ww5m8hbKP6V0jzLg@mail.gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 15 May 2024 19:15:56 +0530
Message-ID: <CAAhSdy12-_Hdb-WVrs8kyfCy_OQA0p27DS6TOV87dh9HODrU_Q@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: riscv-sbi: Add cluster_pm_enter()/exit()
To: Nick Hu <nick.hu@sifive.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, palmer@dabbelt.com, rafael@kernel.org, 
	daniel.lezcano@linaro.org, paul.walmsley@sifive.com, linux-pm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	zong.li@sifive.com, Cyan Yang <cyan.yang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nick,

On Wed, May 15, 2024 at 5:45=E2=80=AFPM Nick Hu <nick.hu@sifive.com> wrote:
>
> Hi Anup,
>
> Thank you for your guidance.
> After enabling the debug message, we found a way to solve the problem
> by the following steps:
> 1. Add a compatible string in 'power-domains' node otherwise it won't
> be the supplier of the consumers. (See of_link_to_phandle())

Hmm, requiring a compatible string is odd. Where should we document
this compatible string ?

> 2. Move the 'power-domains' node outside the 'cpus' node otherwise it
> won't be added to the device hierarchy by device_add().
> 3. Update the cpuidle-riscv-sbi driver to get the pds_node from
> '/power-domains'.

By adding a compatible string and moving the "power-domains" node
outside, you are simply forcing the OF framework to populate devices.

How about manually creating platform_device for each power-domain
DT node using of_platform_device_create() in sbi_pd_init() ?

>
> So the DTS will be like:
> cpus {
>     ...
>      domain-idle-states {
>            CLUSTER_SLEEP:cluster-sleep {
>                         compatible =3D "domain-idle-state";
>                         ...
>             }
>      }
> }
> power-domains {
>             compatible =3D "riscv,sbi-power-domains"
>             ...
>             ...
>             CLUSTER_PD: clusterpd {
>                     domain-idle-states =3D <&CLUSTER_SLEEP>;
>             };
> }
> soc {
>       deviceA@xxx{
>              ...
>              power-domains =3D <&CLUSTER_PD>;
>              ...
>       }
> }

Regards,
Anup

>
> Regards,
> Nick
>
> On Tue, May 14, 2024 at 10:54=E2=80=AFPM Anup Patel <anup@brainfault.org>=
 wrote:
> >
> > On Tue, May 14, 2024 at 7:53=E2=80=AFPM Anup Patel <anup@brainfault.org=
> wrote:
> > >
> > > Hi Nick,
> > >
> > > On Tue, May 14, 2024 at 3:20=E2=80=AFPM Nick Hu <nick.hu@sifive.com> =
wrote:
> > > >
> > > > Hi Ulf,
> > > >
> > > > Thank you for your valuable suggestion.
> > > > I sincerely apologize for the delay in responding to your message. =
We
> > > > have diligently worked on experimenting with the suggestion you
> > > > provided.
> > > >
> > > > As per your recommendation, we have incorporated the "power-domains=
=3D<>
> > > > property" into the consumer's node, resulting in modifications to t=
he
> > > > DTS as illustrated below:
> > > >
> > > > cpus {
> > > >     ...
> > > >      domain-idle-states {
> > > >            CLUSTER_SLEEP:cluster-sleep {
> > > >                         compatible =3D "domain-idle-state";
> > > >                         ...
> > > >             }
> > > >      }
> > > >      power-domains {
> > > >             ...
> > > >             ...
> > > >             CLUSTER_PD: clusterpd {
> > > >                     domain-idle-states =3D <&CLUSTER_SLEEP>;
> > > >             };
> > > >      }
> > > > }
> > > > soc {
> > > >       deviceA@xxx{
> > > >              ...
> > > >              power-domains =3D <&CLUSTER_PD>;
> > > >              ...
> > > >       }
> > > > }
> > > >
> > > > However, this adjustment has led to an issue where the probe for
> > > > 'deviceA' is deferred by 'device_links_check_suppliers()' within
> > > > 'really_probe()'. In an attempt to mitigate this issue, we
> > > > experimented with a workaround by adding the attribute
> > > > "status=3D"disabled"" to the 'CLUSTER_PD' node. This action aimed t=
o
> > > > prevent the creation of a device link between 'deviceA' and
> > > > 'CLUSTER_PD'. Nevertheless, we remain uncertain about the
> > > > appropriateness of this solution.
> > > >
> > > > Do you have suggestions on how to effectively address this issue?
> > >
> > > I totally missed this email since I was not CC'ed sorry about that. P=
lease
> > > use get_maintainers.pl when sending patches.
> >
> > I stand corrected. This patch had landed in the "spam" folder. I don't =
know why.
> >
> > Regards,
> > Anup
> >
> > >
> > > The genpd_add_provider() (called by of_genpd_add_provider_simple())
> > > does mark the power-domain DT node as initialized (fwnode_dev_initial=
ized())
> > > so after the cpuidle-riscv-sbi driver is probed the 'deviceA' depende=
ncy is
> > > resolved and 'deviceA' should be probed unless there are other unmet
> > > dependencies.
> > >
> > > Try adding "#define DEBUG" before all includes in drivers/core/base.c
> > > and add "loglevel=3D8" in kernel parameters, this will print producer=
-consumer
> > > linkage of all devices.
> > >
> > > Marking the power-domain DT node as "disabled" is certainly not the
> > > right way.
> > >
> > > Regards,
> > > Anup
> > >
> > > >
> > > > Regards,
> > > > Nick
> > > >
> > > > On Tue, Apr 30, 2024 at 4:13=E2=80=AFPM Ulf Hansson <ulf.hansson@li=
naro.org> wrote:
> > > > >
> > > > > On Mon, 29 Apr 2024 at 18:26, Nick Hu <nick.hu@sifive.com> wrote:
> > > > > >
> > > > > > On Tue, Apr 30, 2024 at 12:22=E2=80=AFAM Nick Hu <nick.hu@sifiv=
e.com> wrote:
> > > > > > >
> > > > > > > Hi Ulf
> > > > > > >
> > > > > > > On Mon, Apr 29, 2024 at 10:32=E2=80=AFPM Ulf Hansson <ulf.han=
sson@linaro.org> wrote:
> > > > > > > >
> > > > > > > > On Mon, 26 Feb 2024 at 07:51, Nick Hu <nick.hu@sifive.com> =
wrote:
> > > > > > > > >
> > > > > > > > > When the cpus in the same cluster are all in the idle sta=
te, the kernel
> > > > > > > > > might put the cluster into a deeper low power state. Call=
 the
> > > > > > > > > cluster_pm_enter() before entering the low power state an=
d call the
> > > > > > > > > cluster_pm_exit() after the cluster woken up.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > > > > > > >
> > > > > > > > I was not cced this patch, but noticed that this patch got =
queued up
> > > > > > > > recently. Sorry for not noticing earlier.
> > > > > > > >
> > > > > > > > If not too late, can you please drop/revert it? We should r=
eally move
> > > > > > > > away from the CPU cluster notifiers. See more information b=
elow.
> > > > > > > >
> > > > > > > > > ---
> > > > > > > > >  drivers/cpuidle/cpuidle-riscv-sbi.c | 24 +++++++++++++++=
+++++++--
> > > > > > > > >  1 file changed, 22 insertions(+), 2 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/driver=
s/cpuidle/cpuidle-riscv-sbi.c
> > > > > > > > > index e8094fc92491..298dc76a00cf 100644
> > > > > > > > > --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> > > > > > > > > +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> > > > > > > > > @@ -394,6 +394,7 @@ static int sbi_cpuidle_pd_power_off(s=
truct generic_pm_domain *pd)
> > > > > > > > >  {
> > > > > > > > >         struct genpd_power_state *state =3D &pd->states[p=
d->state_idx];
> > > > > > > > >         u32 *pd_state;
> > > > > > > > > +       int ret;
> > > > > > > > >
> > > > > > > > >         if (!state->data)
> > > > > > > > >                 return 0;
> > > > > > > > > @@ -401,6 +402,10 @@ static int sbi_cpuidle_pd_power_off(=
struct generic_pm_domain *pd)
> > > > > > > > >         if (!sbi_cpuidle_pd_allow_domain_state)
> > > > > > > > >                 return -EBUSY;
> > > > > > > > >
> > > > > > > > > +       ret =3D cpu_cluster_pm_enter();
> > > > > > > > > +       if (ret)
> > > > > > > > > +               return ret;
> > > > > > > >
> > > > > > > > Rather than using the CPU cluster notifiers, consumers of t=
he genpd
> > > > > > > > can register themselves to receive genpd on/off notifiers.
> > > > > > > >
> > > > > > > > In other words, none of this should be needed, right?
> > > > > > > >
> > > > > > > Thanks for the feedback!
> > > > > > > Maybe I miss something, I'm wondering about a case like below=
:
> > > > > > > If we have a shared L2 cache controller inside the cpu cluste=
r power
> > > > > > > domain and we add this controller to be a consumer of the pow=
er
> > > > > > > domain, Shouldn't the genpd invoke the domain idle only after=
 the
> > > > > > > shared L2 cache controller is suspended?
> > > > > > > Is there a way that we can put the L2 cache down while all cp=
us in the
> > > > > > > same cluster are idle?
> > > > > > > > [...]
> > > > > > Sorry, I made some mistake in my second question.
> > > > > > Update the question here:
> > > > > > Is there a way that we can save the L2 cache states while all c=
pus in the
> > > > > > same cluster are idle and the cluster could be powered down?
> > > > >
> > > > > If the L2 cache is a consumer of the cluster, the consumer driver=
 for
> > > > > the L2 cache should register for genpd on/off notifiers.
> > > > >
> > > > > The device representing the L2 cache needs to be enabled for runt=
ime
> > > > > PM, to be taken into account correctly by the cluster genpd. In t=
his
> > > > > case, the device should most likely remain runtime suspended, but
> > > > > instead rely on the genpd on/off notifiers to understand when
> > > > > save/restore of the cache states should be done.
> > > > >
> > > > > Kind regards
> > > > > Uffe

