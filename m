Return-Path: <linux-pm+bounces-7848-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673B48C57D8
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 16:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F5E41C21958
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 14:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6EF145350;
	Tue, 14 May 2024 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="fAypVu8V"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BE9144D3B
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715696636; cv=none; b=tMgRoC/SWR0PAmpgAc0vxVGJgvFyOCKCqnikkuiCsIvH06GQsT7ZK63m0YU75LZPgJwivn8ObWGCxNN3k/1bFrydI+B+Tzcr9HtyYRCMfDmKNSFJk6pA7e1FLp61wuFJbGMngQ/+jF7IDkBRxuMkLR0HmnN3v5drwEZjbgOXop0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715696636; c=relaxed/simple;
	bh=MJNL3swls7/XFSBkIMHCbTJs1e4qifE3acRWRujrkd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rxnze3GrIpp8dQGJw7KacM1iS/bxu2t/l9dhtRKG/yMk0W7dhB4DHZrF1H3nmGUqsFqRIrbw1kMUTkGBK16Ie/BTmvkgYyZxjezRCb0VpMNNG+9O2lFKerEkdLMw3r65vD1GRNQR65oP2m29amr2CRIOzbSJemPKr1xVUPLwGwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=fAypVu8V; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-36c8f521122so24879065ab.0
        for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 07:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1715696633; x=1716301433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YWn5jiV2rbv9bUfRPQn5PpR5vLXDPL+5w2PCpg75zY=;
        b=fAypVu8V/SeQH3bpbDn4mLqOr2E6nr+3FvDXMFfFdmosYOM9Uc5eO9htG8U/YuMOdA
         FYFi5+LI6O0It2OqTXoeB75ncjcDTGmdqOwBa8L/+mtaMRJmGPefFfkR15qvqyg7kJeX
         eslF5to2A8m6lJtPoOBGbZRs4kfUMtLS0LGmnqySU+tc8tq/hWLXzOGCpiIKOLlH3+DA
         vSJvRNSMWjy7xcSSedT1qgJGx5WaavaDhMVCdnxBkdObwbl9QCheS8fcpbZzJgUXmFNY
         /5POWOWbTeTLMSRIfZ1m2gtSVvTiaxnEjuz9nv8SyUiKTvhR8zFk7rYF13y5xrd7YPSx
         KDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715696633; x=1716301433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YWn5jiV2rbv9bUfRPQn5PpR5vLXDPL+5w2PCpg75zY=;
        b=oCH9Q9GXCF0P51PkOd50GooJxqs/AfifiKymOpIM2OSe2XtY2qvfGB+lHB4KBuB9At
         3xbSeTQ0Z1sWvwJ6285CcKEJBqqmvHKekRQHdMO5ii+Kz9VpdDC2z7dGEGmZsGezdJye
         NpoomEeNZnuDUlhziShia1ebCey56eI7NfyWA2rlL6VDKQE0bz9rHjkpERvkrUtIaO0z
         2E0HnmRSjb98j/r4NWyAu5fmCYuHXMv6GsHUAkhj80gFSp7M7HhltEdOTPFM1WbA1Kg4
         iHhP4esTazRQ4Ul8g5N5W05g5/qIp3mBG/eafnn+5xji9pnOY8S3nvGnfZxW9d4eK8/R
         juFA==
X-Forwarded-Encrypted: i=1; AJvYcCWBdKZpdWiOtqb25jdTqAq+6kvsRmbfmPm0r18mxwvzylu2LPFMjsck1PjydROOCd1ZK09eoBIov+YTGuQFrp0MizF7KvIwrGc=
X-Gm-Message-State: AOJu0Yx1GjylmmjqFs/WD4Cg/QXk6hOo1l/UgCKL1u6jfjOMo3TlsH1F
	sw8dyjH16FbByoxLABxkv2UrXxzfS05QI3r5xLgk6ouGv6p2RcWFoBmI2BTVK3gQ9Morv63YBE7
	H1yd2/SfV7A1OwNEzGRRMGMO4p3bIHbFDjHoOGg==
X-Google-Smtp-Source: AGHT+IENHPgioCtyM7FQlXlQjrWZgq2dBdxVmW4+FCsDRQU7f9qoVwX+EnLVyxiIZV6uiDPiZpVti8QA6Ck39cfMdCc=
X-Received: by 2002:a05:6e02:1a46:b0:36d:ae10:3f83 with SMTP id
 e9e14a558f8ab-36dae103fe3mr21276645ab.11.1715696632801; Tue, 14 May 2024
 07:23:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226065113.1690534-1-nick.hu@sifive.com> <CAPDyKFph3WsZMmALnzBQKE4S_80Ji5h386Wi0vHda37QUsjMtg@mail.gmail.com>
 <CAKddAkDcdaXKzpcKN=LCCx9S4Trv+joLX2s=nyhzaRtM5HorqA@mail.gmail.com>
 <CAKddAkC6N=Cfo0z+F8herKTuJzCyt_MA0vWNbLCr6CbQnj0y8g@mail.gmail.com>
 <CAPDyKFr_M0NDH0gaunBpybnALOFfz4LpX4_JW2GCUxjwGzdZsg@mail.gmail.com> <CAKddAkC5CRX+ZTh=MgzPYU72SY13+AQYhknhV_CC+=XX9=DKyg@mail.gmail.com>
In-Reply-To: <CAKddAkC5CRX+ZTh=MgzPYU72SY13+AQYhknhV_CC+=XX9=DKyg@mail.gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 14 May 2024 19:53:40 +0530
Message-ID: <CAAhSdy1SDd=VUqDQA0T5n9LwHo=3uGzFq1dUcbDFcB3aBdaioA@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: riscv-sbi: Add cluster_pm_enter()/exit()
To: Nick Hu <nick.hu@sifive.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, palmer@dabbelt.com, rafael@kernel.org, 
	daniel.lezcano@linaro.org, paul.walmsley@sifive.com, linux-pm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	zong.li@sifive.com, Cyan Yang <cyan.yang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nick,

On Tue, May 14, 2024 at 3:20=E2=80=AFPM Nick Hu <nick.hu@sifive.com> wrote:
>
> Hi Ulf,
>
> Thank you for your valuable suggestion.
> I sincerely apologize for the delay in responding to your message. We
> have diligently worked on experimenting with the suggestion you
> provided.
>
> As per your recommendation, we have incorporated the "power-domains=3D<>
> property" into the consumer's node, resulting in modifications to the
> DTS as illustrated below:
>
> cpus {
>     ...
>      domain-idle-states {
>            CLUSTER_SLEEP:cluster-sleep {
>                         compatible =3D "domain-idle-state";
>                         ...
>             }
>      }
>      power-domains {
>             ...
>             ...
>             CLUSTER_PD: clusterpd {
>                     domain-idle-states =3D <&CLUSTER_SLEEP>;
>             };
>      }
> }
> soc {
>       deviceA@xxx{
>              ...
>              power-domains =3D <&CLUSTER_PD>;
>              ...
>       }
> }
>
> However, this adjustment has led to an issue where the probe for
> 'deviceA' is deferred by 'device_links_check_suppliers()' within
> 'really_probe()'. In an attempt to mitigate this issue, we
> experimented with a workaround by adding the attribute
> "status=3D"disabled"" to the 'CLUSTER_PD' node. This action aimed to
> prevent the creation of a device link between 'deviceA' and
> 'CLUSTER_PD'. Nevertheless, we remain uncertain about the
> appropriateness of this solution.
>
> Do you have suggestions on how to effectively address this issue?

I totally missed this email since I was not CC'ed sorry about that. Please
use get_maintainers.pl when sending patches.

The genpd_add_provider() (called by of_genpd_add_provider_simple())
does mark the power-domain DT node as initialized (fwnode_dev_initialized()=
)
so after the cpuidle-riscv-sbi driver is probed the 'deviceA' dependency is
resolved and 'deviceA' should be probed unless there are other unmet
dependencies.

Try adding "#define DEBUG" before all includes in drivers/core/base.c
and add "loglevel=3D8" in kernel parameters, this will print producer-consu=
mer
linkage of all devices.

Marking the power-domain DT node as "disabled" is certainly not the
right way.

Regards,
Anup

>
> Regards,
> Nick
>
> On Tue, Apr 30, 2024 at 4:13=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > On Mon, 29 Apr 2024 at 18:26, Nick Hu <nick.hu@sifive.com> wrote:
> > >
> > > On Tue, Apr 30, 2024 at 12:22=E2=80=AFAM Nick Hu <nick.hu@sifive.com>=
 wrote:
> > > >
> > > > Hi Ulf
> > > >
> > > > On Mon, Apr 29, 2024 at 10:32=E2=80=AFPM Ulf Hansson <ulf.hansson@l=
inaro.org> wrote:
> > > > >
> > > > > On Mon, 26 Feb 2024 at 07:51, Nick Hu <nick.hu@sifive.com> wrote:
> > > > > >
> > > > > > When the cpus in the same cluster are all in the idle state, th=
e kernel
> > > > > > might put the cluster into a deeper low power state. Call the
> > > > > > cluster_pm_enter() before entering the low power state and call=
 the
> > > > > > cluster_pm_exit() after the cluster woken up.
> > > > > >
> > > > > > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > > > >
> > > > > I was not cced this patch, but noticed that this patch got queued=
 up
> > > > > recently. Sorry for not noticing earlier.
> > > > >
> > > > > If not too late, can you please drop/revert it? We should really =
move
> > > > > away from the CPU cluster notifiers. See more information below.
> > > > >
> > > > > > ---
> > > > > >  drivers/cpuidle/cpuidle-riscv-sbi.c | 24 +++++++++++++++++++++=
+--
> > > > > >  1 file changed, 22 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpui=
dle/cpuidle-riscv-sbi.c
> > > > > > index e8094fc92491..298dc76a00cf 100644
> > > > > > --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> > > > > > +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> > > > > > @@ -394,6 +394,7 @@ static int sbi_cpuidle_pd_power_off(struct =
generic_pm_domain *pd)
> > > > > >  {
> > > > > >         struct genpd_power_state *state =3D &pd->states[pd->sta=
te_idx];
> > > > > >         u32 *pd_state;
> > > > > > +       int ret;
> > > > > >
> > > > > >         if (!state->data)
> > > > > >                 return 0;
> > > > > > @@ -401,6 +402,10 @@ static int sbi_cpuidle_pd_power_off(struct=
 generic_pm_domain *pd)
> > > > > >         if (!sbi_cpuidle_pd_allow_domain_state)
> > > > > >                 return -EBUSY;
> > > > > >
> > > > > > +       ret =3D cpu_cluster_pm_enter();
> > > > > > +       if (ret)
> > > > > > +               return ret;
> > > > >
> > > > > Rather than using the CPU cluster notifiers, consumers of the gen=
pd
> > > > > can register themselves to receive genpd on/off notifiers.
> > > > >
> > > > > In other words, none of this should be needed, right?
> > > > >
> > > > Thanks for the feedback!
> > > > Maybe I miss something, I'm wondering about a case like below:
> > > > If we have a shared L2 cache controller inside the cpu cluster powe=
r
> > > > domain and we add this controller to be a consumer of the power
> > > > domain, Shouldn't the genpd invoke the domain idle only after the
> > > > shared L2 cache controller is suspended?
> > > > Is there a way that we can put the L2 cache down while all cpus in =
the
> > > > same cluster are idle?
> > > > > [...]
> > > Sorry, I made some mistake in my second question.
> > > Update the question here:
> > > Is there a way that we can save the L2 cache states while all cpus in=
 the
> > > same cluster are idle and the cluster could be powered down?
> >
> > If the L2 cache is a consumer of the cluster, the consumer driver for
> > the L2 cache should register for genpd on/off notifiers.
> >
> > The device representing the L2 cache needs to be enabled for runtime
> > PM, to be taken into account correctly by the cluster genpd. In this
> > case, the device should most likely remain runtime suspended, but
> > instead rely on the genpd on/off notifiers to understand when
> > save/restore of the cache states should be done.
> >
> > Kind regards
> > Uffe

