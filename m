Return-Path: <linux-pm+bounces-7922-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DAE8C807A
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 06:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE57C1C20C82
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 04:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A2FD30B;
	Fri, 17 May 2024 04:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="c5kfACWn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9C9D28D
	for <linux-pm@vger.kernel.org>; Fri, 17 May 2024 04:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715920773; cv=none; b=aJXoYpSIlbgPXlM6Sqq6Pt0sFjhv0jT4RxMo7EtDj6LUEAqwuzo1zGkog5ZrkV2OpVRbXCcPaPx3rM+AF5yzFbCuc7ll6+zX+YH3qSUq7Dcaod1y2cSqqEBPVGulHpBCOa/7hHEu0jvCIyjxLafWmN8B2KQh6YuzyEXYll+h2vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715920773; c=relaxed/simple;
	bh=7yWR6LUX/LUln4RAXO+bVIVYSKMbM7bC2WXtzBdpMzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nmoKK0S7bXrSYx9jquftq0YxgMP46Ks63dX45VMkdzEanWLFM+x5mzdvNl/XDvdgFA66euzZhJOhLIyx5+ZyaCOhmBV1UJtXP9FuMBYj/9DlRqLYXDp7VNWirp33DhwZnQ9q/aglI+lJ97IGOmieMXPsrJNQ2jbM2Qe+hdvsMDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=c5kfACWn; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51f71e4970bso1853890e87.2
        for <linux-pm@vger.kernel.org>; Thu, 16 May 2024 21:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1715920770; x=1716525570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXsog4qOFxHNn+bj1EwI26SGwR8rdrDu1a+dbrSkxSM=;
        b=c5kfACWnW4ISDUndzFl+8JNOwkyt0GBYU/SG8GPyH9pDjDP23qem4dITgG3K+suv3I
         9TTzxL0SEz/FFODoRWAjEa/IskMbWyl2lw5Eqa7BZlUQQPANh8N7cAqUvdrAbufmEFGG
         IczANF/Ne11LXEJcYHbemMHu/HtcxK+pz5PhrHOjAnsSloIejNfycsDzDT+kp6ynFI7m
         mRsi2RlwNUPWP2aRV2bVOBnQNcvvPXgR35Mzlwg7UhOTYKDFfMnn2FI5+W2brQTyqd/z
         y2eLjK9nqoLWT37NHJ53hxGio/2ZMWwqUgeaNWpwsOPbhBbTakOOxse7llSn+njrIF+s
         oKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715920770; x=1716525570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXsog4qOFxHNn+bj1EwI26SGwR8rdrDu1a+dbrSkxSM=;
        b=cKd/Xok6ww5/mwq1SL2tdtw6biL6GZGu7ajrXhS4IpKf4CIRAo1HO+BCRG0KFpjxNf
         khFNrs5qtS3TEjYGllHCZ2W/beCa7o7Fy6c1+oM4iCi2WSENlGh9nwOSjof207nsbzuL
         XP/b8qzmW6XHrzc9uKS04+Jj7mCs59oYjXCd4H4+YWRpdQeJDVm+tgetJX2rtCvoO002
         iiDG2AtlKEhgYdHpEUzaa+Ru/cLbEffrSgOv5yJJY/+ShnOEvDfQ0bsbwJe0p3YJoK79
         JBnTyk1VSmcUCalbvkeFYU8B7JFz4ZWxf+9FOeX7UR0dHJ2x37BX6bnGhOpi/x30svSh
         tbDA==
X-Forwarded-Encrypted: i=1; AJvYcCWL7Jnw3JU4Lx3olReQsv1brG4kR89+bKjjqsiR3cHsexbXQK8pFgS7S0xgqRm1LwaCR/QFf6xylmu69b8MYrq/teRWoci5aoQ=
X-Gm-Message-State: AOJu0Yx7EB+aodZclEgsldKWuxcQSs2LSBC9amW/KItEdmlOHMrnZjj9
	caYVLMnspGlsRYlZ6R5/288DR8YteGpBZlqzpqHNzUUpYeSf9KupPk/J2Dsg+QmDIZNNzHe8sVN
	Ty/xD4OxpIhLioFKFyhJ/xbtSupzZQ6Eu5dp34Fm2H4GH5Y9+XWQ=
X-Google-Smtp-Source: AGHT+IHeKKLNIPRXAhbJL6F4BtgSqSFFsregZFMHXj3tlZvItc1t0y5KW+x47BPGVTGaTvaGmQ12GFNwpap9QV18B/0=
X-Received: by 2002:ac2:5331:0:b0:51d:a8ce:540 with SMTP id
 2adb3069b0e04-5220fd7bb24mr17319494e87.35.1715920769436; Thu, 16 May 2024
 21:39:29 -0700 (PDT)
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
 <CAKddAkBrP2iQBC+aY1Xw5pssBpiQZe4V-6ww5m8hbKP6V0jzLg@mail.gmail.com>
 <CAAhSdy12-_Hdb-WVrs8kyfCy_OQA0p27DS6TOV87dh9HODrU_Q@mail.gmail.com> <CAKddAkCQOvnci-bzKx1pBUJh5t1uPT-wNXGH1WyqDyb5qR_Scg@mail.gmail.com>
In-Reply-To: <CAKddAkCQOvnci-bzKx1pBUJh5t1uPT-wNXGH1WyqDyb5qR_Scg@mail.gmail.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Fri, 17 May 2024 10:09:16 +0530
Message-ID: <CAK9=C2V2xYwi4wK2+e=z7NF8Ph7+LxvWh4J4TmQrbVfSfpO-Ag@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: riscv-sbi: Add cluster_pm_enter()/exit()
To: Nick Hu <nick.hu@sifive.com>
Cc: Anup Patel <anup@brainfault.org>, Ulf Hansson <ulf.hansson@linaro.org>, palmer@dabbelt.com, 
	rafael@kernel.org, daniel.lezcano@linaro.org, paul.walmsley@sifive.com, 
	linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, zong.li@sifive.com, 
	Cyan Yang <cyan.yang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 9:40=E2=80=AFAM Nick Hu <nick.hu@sifive.com> wrote:
>
> Hi Anup
>
> On Wed, May 15, 2024 at 9:46=E2=80=AFPM Anup Patel <anup@brainfault.org> =
wrote:
> >
> > Hi Nick,
> >
> > On Wed, May 15, 2024 at 5:45=E2=80=AFPM Nick Hu <nick.hu@sifive.com> wr=
ote:
> > >
> > > Hi Anup,
> > >
> > > Thank you for your guidance.
> > > After enabling the debug message, we found a way to solve the problem
> > > by the following steps:
> > > 1. Add a compatible string in 'power-domains' node otherwise it won't
> > > be the supplier of the consumers. (See of_link_to_phandle())
> >
> > Hmm, requiring a compatible string is odd. Where should we document
> > this compatible string ?
> >
> Sorry, this is my fault. I didn't include some updates in
> of_link_to_phandle(). This led some misunderstandings here.
> You are right, we don't need it.
> The supplier will be linked to the CLUSTER_PD node.
>
> > > 2. Move the 'power-domains' node outside the 'cpus' node otherwise it
> > > won't be added to the device hierarchy by device_add().
> > > 3. Update the cpuidle-riscv-sbi driver to get the pds_node from
> > > '/power-domains'.
> >
> > By adding a compatible string and moving the "power-domains" node
> > outside, you are simply forcing the OF framework to populate devices.
> >
> > How about manually creating platform_device for each power-domain
> > DT node using of_platform_device_create() in sbi_pd_init() ?
> >
> Thanks for the suggestion! We have test the solution and it could work.
> We was wondering if it's feasible for us to relocate the
> 'power-domains' node outside of the /cpus? The CLUSTER_PD might
> encompass not only the CPUs but also other components within the
> cluster.

The cpuidle-riscv-sbi driver expects "power-domains" DT node
under "/cpus" DT node because this driver only deals with power
domains related to CPU cluster or CPU cache-hierarchy. It does
make sense to define L2/L3 power domains under
"/cpus/power-domain" since these are related to CPUs.

Moving the CPU "power-domains" DT node directly under "/" or
somewhere else would mean that it covers system-wide power
domains which is not true.

I suggest we continue using "/cpus/power-domains" DT node
only for power domains related to CPU clusters or CPU
cache-hierarchy.

For system wide power domains of SoC devices, we can either:
1) Use device power domains through the SBI MPXY extension
    via different driver
2) Use a platform specific driver

>
> We also look at cpuidle_psci_domain driver and it seems Arm doesn't
> create the devices for each subnode of psci domain.
> Is there any reason that they don't need it?

Existing ARM DTS files under arch/arm64/boot/dts, use device
power domains through SCMI (or platform specific mechanism)
which are already populated as devices by Linux DD framework.

Regards,
Anup

>
> > >
> > > So the DTS will be like:
> > > cpus {
> > >     ...
> > >      domain-idle-states {
> > >            CLUSTER_SLEEP:cluster-sleep {
> > >                         compatible =3D "domain-idle-state";
> > >                         ...
> > >             }
> > >      }
> > > }
> > > power-domains {
> > >             compatible =3D "riscv,sbi-power-domains"
> > >             ...
> > >             ...
> > >             CLUSTER_PD: clusterpd {
> > >                     domain-idle-states =3D <&CLUSTER_SLEEP>;
> > >             };
> > > }
> > > soc {
> > >       deviceA@xxx{
> > >              ...
> > >              power-domains =3D <&CLUSTER_PD>;
> > >              ...
> > >       }
> > > }
> >
> > Regards,
> > Anup
> >
> > >
> > > Regards,
> > > Nick
> > >
> > > On Tue, May 14, 2024 at 10:54=E2=80=AFPM Anup Patel <anup@brainfault.=
org> wrote:
> > > >
> > > > On Tue, May 14, 2024 at 7:53=E2=80=AFPM Anup Patel <anup@brainfault=
.org> wrote:
> > > > >
> > > > > Hi Nick,
> > > > >
> > > > > On Tue, May 14, 2024 at 3:20=E2=80=AFPM Nick Hu <nick.hu@sifive.c=
om> wrote:
> > > > > >
> > > > > > Hi Ulf,
> > > > > >
> > > > > > Thank you for your valuable suggestion.
> > > > > > I sincerely apologize for the delay in responding to your messa=
ge We
> > > > > > have diligently worked on experimenting with the suggestion you
> > > > > > provided.
> > > > > >
> > > > > > As per your recommendation, we have incorporated the "power-dom=
ains=3D<>
> > > > > > property" into the consumer's node, resulting in modifications =
to the
> > > > > > DTS as illustrated below:
> > > > > >
> > > > > > cpus {
> > > > > >     ...
> > > > > >      domain-idle-states {
> > > > > >            CLUSTER_SLEEP:cluster-sleep {
> > > > > >                         compatible =3D "domain-idle-state";
> > > > > >                         ...
> > > > > >             }
> > > > > >      }
> > > > > >      power-domains {
> > > > > >             ...
> > > > > >             ...
> > > > > >             CLUSTER_PD: clusterpd {
> > > > > >                     domain-idle-states =3D <&CLUSTER_SLEEP>;
> > > > > >             };
> > > > > >      }
> > > > > > }
> > > > > > soc {
> > > > > >       deviceA@xxx{
> > > > > >              ...
> > > > > >              power-domains =3D <&CLUSTER_PD>;
> > > > > >              ...
> > > > > >       }
> > > > > > }
> > > > > >
> > > > > > However, this adjustment has led to an issue where the probe fo=
r
> > > > > > 'deviceA' is deferred by 'device_links_check_suppliers()' withi=
n
> > > > > > 'really_probe()'. In an attempt to mitigate this issue, we
> > > > > > experimented with a workaround by adding the attribute
> > > > > > "status=3D"disabled"" to the 'CLUSTER_PD' node. This action aim=
ed to
> > > > > > prevent the creation of a device link between 'deviceA' and
> > > > > > 'CLUSTER_PD'. Nevertheless, we remain uncertain about the
> > > > > > appropriateness of this solution.
> > > > > >
> > > > > > Do you have suggestions on how to effectively address this issu=
e?
> > > > >
> > > > > I totally missed this email since I was not CC'ed sorry about tha=
t. Please
> > > > > use get_maintainers.pl when sending patches.
> > > >
> > > > I stand corrected. This patch had landed in the "spam" folder. I do=
n't know why.
> > > >
> > > > Regards,
> > > > Anup
> > > >
> > > > >
> > > > > The genpd_add_provider() (called by of_genpd_add_provider_simple(=
))
> > > > > does mark the power-domain DT node as initialized (fwnode_dev_ini=
tialized())
> > > > > so after the cpuidle-riscv-sbi driver is probed the 'deviceA' dep=
endency is
> > > > > resolved and 'deviceA' should be probed unless there are other un=
met
> > > > > dependencies.
> > > > >
> > > > > Try adding "#define DEBUG" before all includes in drivers/core/ba=
sec
> > > > > and add "loglevel=3D8" in kernel parameters, this will print prod=
ucer-consumer
> > > > > linkage of all devices.
> > > > >
> > > > > Marking the power-domain DT node as "disabled" is certainly not t=
he
> > > > > right way.
> > > > >
> > > > > Regards,
> > > > > Anup
> > > > >
> > > > > >
> > > > > > Regards,
> > > > > > Nick
> > > > > >
> > > > > > On Tue, Apr 30, 2024 at 4:13=E2=80=AFPM Ulf Hansson <ulf.hansso=
n@linaro.org> wrote:
> > > > > > >
> > > > > > > On Mon, 29 Apr 2024 at 18:26, Nick Hu <nick.hu@sifive.com> wr=
ote:
> > > > > > > >
> > > > > > > > On Tue, Apr 30, 2024 at 12:22=E2=80=AFAM Nick Hu <nick.hu@s=
ifive.com> wrote:
> > > > > > > > >
> > > > > > > > > Hi Ulf
> > > > > > > > >
> > > > > > > > > On Mon, Apr 29, 2024 at 10:32=E2=80=AFPM Ulf Hansson <ulf=
.hansson@linaro.org> wrote:
> > > > > > > > > >
> > > > > > > > > > On Mon, 26 Feb 2024 at 07:51, Nick Hu <nick.hu@sifive.c=
om> wrote:
> > > > > > > > > > >
> > > > > > > > > > > When the cpus in the same cluster are all in the idle=
 state, the kernel
> > > > > > > > > > > might put the cluster into a deeper low power state. =
Call the
> > > > > > > > > > > cluster_pm_enter() before entering the low power stat=
e and call the
> > > > > > > > > > > cluster_pm_exit() after the cluster woken up.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > > > > > > > > >
> > > > > > > > > > I was not cced this patch, but noticed that this patch =
got queued up
> > > > > > > > > > recently. Sorry for not noticing earlier.
> > > > > > > > > >
> > > > > > > > > > If not too late, can you please drop/revert it? We shou=
ld really move
> > > > > > > > > > away from the CPU cluster notifiers. See more informati=
on below.
> > > > > > > > > >
> > > > > > > > > > > ---
> > > > > > > > > > >  drivers/cpuidle/cpuidle-riscv-sbi.c | 24 +++++++++++=
+++++++++++--
> > > > > > > > > > >  1 file changed, 22 insertions(+), 2 deletions(-)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/dr=
ivers/cpuidle/cpuidle-riscv-sbi.c
> > > > > > > > > > > index e8094fc92491..298dc76a00cf 100644
> > > > > > > > > > > --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> > > > > > > > > > > +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> > > > > > > > > > > @@ -394,6 +394,7 @@ static int sbi_cpuidle_pd_power_o=
ff(struct generic_pm_domain *pd)
> > > > > > > > > > >  {
> > > > > > > > > > >         struct genpd_power_state *state =3D &pd->stat=
es[pd->state_idx];
> > > > > > > > > > >         u32 *pd_state;
> > > > > > > > > > > +       int ret;
> > > > > > > > > > >
> > > > > > > > > > >         if (!state->data)
> > > > > > > > > > >                 return 0;
> > > > > > > > > > > @@ -401,6 +402,10 @@ static int sbi_cpuidle_pd_power_=
off(struct generic_pm_domain *pd)
> > > > > > > > > > >         if (!sbi_cpuidle_pd_allow_domain_state)
> > > > > > > > > > >                 return -EBUSY;
> > > > > > > > > > >
> > > > > > > > > > > +       ret =3D cpu_cluster_pm_enter();
> > > > > > > > > > > +       if (ret)
> > > > > > > > > > > +               return ret;
> > > > > > > > > >
> > > > > > > > > > Rather than using the CPU cluster notifiers, consumers =
of the genpd
> > > > > > > > > > can register themselves to receive genpd on/off notifie=
rs.
> > > > > > > > > >
> > > > > > > > > > In other words, none of this should be needed, right?
> > > > > > > > > >
> > > > > > > > > Thanks for the feedback!
> > > > > > > > > Maybe I miss something, I'm wondering about a case like b=
elow:
> > > > > > > > > If we have a shared L2 cache controller inside the cpu cl=
uster power
> > > > > > > > > domain and we add this controller to be a consumer of the=
 power
> > > > > > > > > domain, Shouldn't the genpd invoke the domain idle only a=
fter the
> > > > > > > > > shared L2 cache controller is suspended?
> > > > > > > > > Is there a way that we can put the L2 cache down while al=
l cpus in the
> > > > > > > > > same cluster are idle?
> > > > > > > > > > [...]
> > > > > > > > Sorry, I made some mistake in my second question.
> > > > > > > > Update the question here:
> > > > > > > > Is there a way that we can save the L2 cache states while a=
ll cpus in the
> > > > > > > > same cluster are idle and the cluster could be powered down=
?
> > > > > > >
> > > > > > > If the L2 cache is a consumer of the cluster, the consumer dr=
iver for
> > > > > > > the L2 cache should register for genpd on/off notifiers.
> > > > > > >
> > > > > > > The device representing the L2 cache needs to be enabled for =
runtime
> > > > > > > PM, to be taken into account correctly by the cluster genpd. =
In this
> > > > > > > case, the device should most likely remain runtime suspended,=
 but
> > > > > > > instead rely on the genpd on/off notifiers to understand when
> > > > > > > save/restore of the cache states should be done.
> > > > > > >
> > > > > > > Kind regards
> > > > > > > Uffe
>

