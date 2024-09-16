Return-Path: <linux-pm+bounces-14340-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7F797A460
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2024 16:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449FB1F227D1
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2024 14:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F9C157495;
	Mon, 16 Sep 2024 14:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f30Jetk9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA71F156880
	for <linux-pm@vger.kernel.org>; Mon, 16 Sep 2024 14:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726497994; cv=none; b=qNjT9tEk5LhVn3j8N79oBEpDeS7qiLyC7E2T+nlpPNl7k7PGJZqfXC6pMTvCyQ+Dlcf1UPQUMK5GwqajalNJEmYQq/gc/9d2W+2ROUHGeThKCytQ8+4Fla55CIDB07rti/wUSiBM/8tUICQJkS1gmJrSQeu5PiW3XidMy+tKrdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726497994; c=relaxed/simple;
	bh=MeCsGvspALUWQ7yDteyrqz0wd2n0iGoFu9QcbDg3vs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJrgBTee9ZzYseE5jGAcNrE9xphZy6dinARldNR7KAhkgnIW996gVcHKTdHniH7fdUQF4iMDbO32OiEz/G2+39T6PTJGdSv61VOE1JY5lc2lwUdmhR79AXZFE76xTzNkv8BJDL4OYkNhj8vVu1KY/Nu0dYVcf8Yvuk0SetJ4pGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=f30Jetk9; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53658f30749so4664362e87.3
        for <linux-pm@vger.kernel.org>; Mon, 16 Sep 2024 07:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726497990; x=1727102790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1+v4o854bFOIIGkpxEu+0igja1wmagRW9vcdO6gesM=;
        b=f30Jetk9Nhc0k/a0FiJzRdU+m7Sdgx/e67DwkhuLKD5amiFRW96WU0hkg0t1j2XvwA
         mBWb8BsBU0Ygbz9xTvcnparI8vr1LVx11/eiPgzc3a8ThPkrdm+x5xFAW5RJIHKjwMjo
         IzoKvNF9jMNLz/dQYrySuAWeW2ZN8pEix9t64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726497990; x=1727102790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1+v4o854bFOIIGkpxEu+0igja1wmagRW9vcdO6gesM=;
        b=bEXl1bawJaTOy9mH2LBrksMvu4xoP7MYBjuRZQulePkl7P430guab5ykRnTL46tDLm
         XZV9p0YxKoFoIB/gxCzAUl4POYpATOZaAcHKlMGOZ3qWLyEgOcn4HCij+JYeYe/aWFT4
         v2iTk/rikRanZ5pPYD1dgRFDW4XX/wAlaNnnj/01doGR1NtAmhyDOwICTuK6PDWkKg3V
         ddH/VdYNYtlCHQA3vIzf91M6tQxWr6MN4p2sOT37219Lfnz92140rk9UZBWQEZklCOu+
         3WNqNmuSqZfavhEyj5WKjmyUD9ROLl3E42pT1wrI0u8TjxBIAYxEyfZyultqaAZ6GR7L
         Aqqg==
X-Forwarded-Encrypted: i=1; AJvYcCWRN26FDDxWkGzhUDWf1b2bBWvPC5ES7fFCrps7rExr2yWFC/UMAmd+4s0LYik0EWXFbzBxUb3dCw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxwIvU217nZtLxpP6sQA08tsiGO0jY2YD/mOxUG0wBXnuspiGwQ
	mM5MT6J64qyiCqBa1Uici56PfBBDA9mF4f93ICPiHxlguQHFk5FciRfaSyk8YswNIJz+kWUDlWb
	Akc0Rvcl1pFYiZ+RS3Gw9OHmyA3wEK5SmhG+s3XhLmQmvIUG+QA==
X-Google-Smtp-Source: AGHT+IGZLLXqA7jGXzSgClpOdkq+qu8L7F0/D6Yn6NHtTtRL59cN9w4cm0JDszAwHrBA96S2plRYN5Qh6l9MenhDMB4=
X-Received: by 2002:a05:6512:e89:b0:535:6892:3be6 with SMTP id
 2adb3069b0e04-53678ff48f6mr8268701e87.54.1726497989444; Mon, 16 Sep 2024
 07:46:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527181928.4fc6b5f0@xps-13> <20240619104101.3060b153@xps-13>
In-Reply-To: <20240619104101.3060b153@xps-13>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 16 Sep 2024 16:46:18 +0200
Message-ID: <CAGXv+5EhRH0e1nmgooaq8kW023NdUqpiHN6Px1vn3hJ+C6EJwA@mail.gmail.com>
Subject: Re: Clocks vs. Power Domains circular dependency
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Lucas Stach <l.stach@pengutronix.de>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marek Vasut <marex@denx.de>, 
	Stephen Boyd <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Chen-Yu Tsai <wens@csie.org>, 
	linux-clk@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Fabio Estevam <festevam@denx.de>, 
	Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-imx@nxp.com, 
	Ian Ray <ian.ray@gehealthcare.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	=?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 10:41=E2=80=AFAM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Hello,
>
> miquel.raynal@bootlin.com wrote on Mon, 27 May 2024 18:19:28 +0200:
>
> > Hello all,
> >
> > I would like to re-open the clocks vs. runtime PM/power domains topic
> > that is currently still problematic on i.MX8. I am mentioning a
> > specific SoC here but the problem is hardware agnostic and any SoC with
> > a sufficiently advanced power scheme may suffer from the same issues.
> > When (mainline) Linux is running, we get lockdep warnings because of
> > circular dependencies between the clock and power domain subsystems, as
> > well as real deadlocks.
> >
> > I don't have the full history but here is an interesting attempt at
> > fixing this by Marek end of 2022:
> > https://lore.kernel.org/all/Y1cs++TV2GCuh4tS@pendragon.ideasonboard.com=
/
> > And here is an interesting discussion that happened on the mailing list
> > following a second attempt from Marek as well:
> > https://patchwork.kernel.org/project/linux-pm/patch/20221108013517.7496=
65-1-marex@denx.de
> >
> > Looking more closely at this problem, there is indeed a software design
> > issue. Both the clock and power domain subsystems are recursive and
> > interdependent, the power domain subsystem being sometimes accessed
> > through runtime PM calls.
> >
> > [TLDR: I'm drafting something, but issue #4 at the bottom is blocking]
>
> I understand getting involved in this thread is a bit tiresome :-), I'd
> really like to get some feedback from the interested parties, even if
> the feedback is not on the technical part, if this issue could get a
> bit of support it would already be a plus.

We have such an inter-dependecy between the clocks and power domain
subsystems on the MT8183.

On the MT8183 (and most other MediaTek SoCs used for Chromebooks) there
is a wrapper block around the GPU called MFGCFG. This block contains
clock controls for the GPU. The block lives in the same power domain
as the GPU itself. On the other side, the GPU power domain has the
main GPU clock and regulators tied to it. In certain conditions (this
is using the Mali DDK and not 100% reproducible) a clk_set_rate() from
one part of the kernel will deadlock with the power domain power-off
sequence in another part of the kernel:

Thread 1:
[  246.754818]  __switch_to+0x100/0x280
[  246.754831]  schedule+0x474/0x12b0
[  246.754835]  schedule_preempt_disabled+0x30/0x50
[  246.754840]  __mutex_lock_slowpath+0x334/0x800
[  246.754845]  mutex_lock+0x3c/0x70
[  246.754849]  genpd_lock_mtx+0x20/0x38
[  246.754855]  genpd_runtime_resume+0xa8/0x248
[  246.754862]  __rpm_callback+0x90/0x148
[  246.754868]  rpm_callback+0x34/0x90
[  246.754875]  rpm_resume+0x38c/0x638
[  246.754880]  __pm_runtime_resume+0x58/0xa8
[  246.754886]  clk_pm_runtime_get+0x34/0xb0
[  246.754892]  clk_set_rate+0x29c/0x448

Thread 2:

[  246.755367]  __switch_to+0x100/0x280
[  246.755372]  schedule+0x474/0x12b0
[  246.755376]  schedule_preempt_disabled+0x30/0x50
[  246.755381]  __mutex_lock_slowpath+0x334/0x800
[  246.755385]  mutex_lock+0x3c/0x70
[  246.755389]  clk_unprepare+0x64/0x110
[  246.755394]  clk_bulk_unprepare+0x38/0x58
[  246.755398]  scpsys_power_off+0x284/0x2d0
[  246.755405]  _genpd_power_off+0x88/0x118
[  246.755409]  genpd_power_off+0x170/0x218
[  246.755413]  genpd_power_off+0x1d8/0x218
[  246.755417]  genpd_power_off+0x1d8/0x218
[  246.755421]  genpd_power_off_work_fn+0x44/0x70

We've worked around this by removing the reference of the GPU clock from
the GPU power domain in

    https://lore.kernel.org/all/20240805065051.3129354-1-treapking@chromium=
.org/


ChenYu

> Also, I am really annoyed by the issue mentioned below, in case someone
> wants^W has the willingness to look into it. In any case I might try
> to go further myself.
>
> Thanks!
> Miqu=C3=A8l
>
> (keeping the context below, just in case)
>
> > ** THE ISSUE: FROM A CLOCK PERSPECTIVE **
> >
> > Clock changes (not only clk_prepare(), but getting/setting the rates as
> > well, re-parenting and so on) involve runtime resuming part of the cloc=
k
> > tree. Eg. registers for accessing/configuring a clock might be in a
> > power domain that must be resumed.
> >
> > Also, the clk subsystem is mostly written using recursivity, so for
> > instance preparing a clock works like this:
> >
> > /*
> >  * Same applies to the other clk consumer calls, but instead of going
> >  * through the parents, other parts of the clk tree are accessed (the
> >  * children subtree, the new parent tree, or both). So the prepare
> >  * situation is one of the simplest in this regard, but the following
> >  * basically applies to most consumer operations.
> >  */
> > clk_prepare(clk) {
> >       clk_prepare(clk->parent);
> >       runtime_resume(clk->domain);
> >       clk->ops->prepare();
> > }
> >
> > Now if we add another level of complexity, accesses to the clock tree
> > are serialized by the clk_prepare mutex, and runtime PM calls are also
> > protected by a global genpd lock:
> >
> > clk_prepare(clk) {
> >       mutex_lock(clk_prepare);
> >       clk_prepare(clk->parent); /* clk_prepare is reentrant, so this is=
 "fine" */
> >       runtime_resume(clk->domain);
> >       clk->ops->prepare();
> >       mutex_unlock(clk_prepare);
> > }
> >
> > runtime_resume(domain) {
> >       mutex_lock(genpd);
> >       domain->ops->resume();
> >       mutex_unlock(genpd);
> > }
> >
> > If we list the locking events in order, we will:
> > - acquire the clk lock
> > - acquire the genPD lock
> > - release the genPD lock
> > - release the clk lock
> >
> > ** THE ISSUE: FROM A POWER DOMAIN PERSPECTIVE **
> >
> > Now let's see the other side, from the power domain perspective. We can
> > imagine several situations where these locks are acquired in the revers=
e
> > order. From a hardware standpoint there is a prerequisite (met in the
> > i.MX8 in several places): a power domain is fed by a clock, hence
> > enabling the power domain also implies enabling the feeding clock.
> >
> >     #1: Probing/enabling peripherals involve attaching and powering up
> >     their power domain. If the power domain is fed by a clock the power
> >     domain implementation will request clock changes.
> >
> >     #2: Suspending devices happens asynchronously in a
> >     worker. Suspending a device implies turning off its power domain,
> >     and hence possibly reaching some clock internals as well.
> >
> > In these cases we will play with locks in this order:
> > - acquire the genPD lock
> > - acquire the clk lock
> > - release the clk lock
> > - release the genPD lock
> >
> > Here are two typical examples: power domains playing with upstream
> > clocks:
> > https://elixir.bootlin.com/linux/latest/source/drivers/pmdomain/imx/imx=
8mp-blk-ctrl.c#L538
> > https://elixir.bootlin.com/linux/latest/source/drivers/pmdomain/imx/gpc=
v2.c#L340
> >
> > ** CURRENT UNDERSTANDING **
> >
> > Clock changes and runtime PM calls can happen at any moment and if your
> > hardware is in a bad mood a dead lock *will* occur. I myself only
> > experienced deadlocks involving the clock worker disabling unused clock=
s
> > at the end of the boot, but chances are way too high that systems will
> > lock up at some point in production environment because of this circula=
r
> > dependency between the clock and power domain locks. It is possible to
> > avoid the deadlock I experienced by disabling the clk_disable_unused
> > worker and keeping all clocks enabled, but we will all agree that this
> > is a very sub-optimal and extremely unsatisfying solution for a SoC
> > explicitly designed for optimized power consumptions.
> >
> > There is no magic, we must dismangle the situation and prevent either
> > one lock ordering or the other from happening. So we should ask
> > ourselves: what lock order seems the most legitimate?
> >
> >     #1: Do clocks really depend on power domains?
> >
> >     -> Clock controllers may be part of a power domain, hence the power
> >     domain must be enabled in order to access the clock controller
> >     registers.
> >
> >     -> Same applies if a clock is generated by an external device
> >     (eg. an audio codec) and this codec is accessible through a serial
> >     bus: the bus controller must be resumed in order to configure the
> >     code, and the bus controller may be in its own power domain.
> >
> >     #2: Do power domains really depend on clocks?
> >
> >     -> Somehow yes. Most power domains are not explicitly "driven" by
> >     the upstream clocks described in device trees, ie: keeping these
> >     clocks gated does not prevent the use nor the access to the power
> >     domains per-se. However, the power domains may redistribute the
> >     clocks to the peripherals inside and somehow becoe themselves clock
> >     controllers (even though so far they are not flagged like that in
> >     any DTS). Hence it appears legitimate that they might want to play
> >     with the clock API.
> >
> >     DTSI example:
> >     https://elixir.bootlin.com/linux/latest/source/arch/arm64/boot/dts/=
freescale/imx8mp.dtsi#L1799
> >
> >     TRM extract:
> >
> >       13.2.1 Overview
> >       The MEDIAMIX domain contains control and status registers known a=
s
> >       Media Block Control (MEDIA BLK_CTRL). These registers have
> >       miscellaneous top-level controls for peripherals within the MEDIA=
MIX
> >       domain. Some of these controls includes clocking, [...]
> >
> >       13.2.2: Clocks and Resets
> >       The Media BLK_CTRL contains clock distribution and gating control=
s,
> >       as well as reset handling to several of the MEDIAMIX peripherals.
> >
> >     -> One specificity of the i.MX8 is that many power domains are
> >     also described with a "clocks" property which list clocks that are
> >     directly connected to the peripherals inside the power domain
> >     instead. The reason for this inaccurate description is: toggling a
> >     power domain on or off seems to involve propagating reset signals,
> >     which only happens correctly if a few specific clocks feeding the
> >     targeted peripherals are actually running. Then, as part of the
> >     on/off sequence, it is required that these clocks get enabled (and
> >     then disabled) earlier than in their respective probe functions,
> >     see:
> >     - ae1d2add26a4 ("soc: imx: gpcv2: handle reset clocks")
> >     - https://elixir.bootlin.com/linux/latest/source/arch/arm64/boot/dt=
s/freescale/imx8mp.dtsi#L795
> >     - https://elixir.bootlin.com/linux/latest/source/arch/arm64/boot/dt=
s/freescale/imx8mp.dtsi#L857
> >
> > It is hard to tell, without more details from NXP, how difficult it
> > would be to switch from the #2 "wrong" power domain DTS description to
> > something more accurate and still get the proper init sequence. Althoug=
h
> > maybe doing that would not be very relevant as there are anyway real
> > clock dependencies from some power domains, as expressed in the SoC
> > manual quoted above.
> >
> > #1 however, despite being a physical constraint, seems also tightly
> > related to the software design: runtime PM calls were introduced in the
> > clock subsystem initially for two reasons:
> > - The clock is itself in an area of the SoC that needs to be powered on
> >   before accessing its registers.
> > - The above situation also applies to all the possible parents of the
> >   clock.
> > See: 9a34b45397e5 ("clk: Add support for runtime PM")
> > https://lore.kernel.org/all/1503302703-13801-2-git-send-email-m.szyprow=
ski@samsung.com
> > The clock core being highly recursive, it was way easier (and also
> > probably cleaner) to include nested runtime PM calls like this. But in
> > practice, we could imagine moving the resume path outside of the clock
> > lock and avoid "by software" the conditions under which the two locks
> > are taken.
> >
> > Note: These suggestions have already been made by Ulf:
> > https://patchwork.kernel.org/project/linux-pm/patch/20221108013517.7496=
65-1-marex@denx.de/#25092554
> >
> > ** APPROACH UNDER EVALUATION **
> >
> > As hinted above, maybe we should clarify the conditions under which RPM
> > calls can be made in the clock subsystem, and instead of including the
> > RPM calls within the clock sub-calls, we could consider, on a
> > case-by-case basis:
> > - listing what needs to be resumed for the whole clock operation to
> >   succeed first,
> > - then runtime resume the needed domains outside of the main subsystem
> >   lock
> > - before continuing with the clock operations and eventually acquiring
> >   the main clk_prepare lock.
> > IOW, avoiding the runtime PM calls with the subsystem lock acquired.
> >
> > Let's imagine the following situation: clkA (in power domain A) is
> > parent of clkB (in power domain B). Like above, let's try to picture th=
e
> > call stack:
> >
> >  clk_prepare(clkB) {
> >       mutex_lock(clk_prepare);
> >       clkA =3D clkB->parent;
> >       clk_prepare(clkA) {
> >               mutex_lock(clk_prepare); /* fine, it's recursive */
> >               runtime_resume(clkA->domain); // BANG
> >               clkA->ops->prepare();
> >               mutex_unlock(clk_prepare); /* does nothing */
> >       }
> >       runtime_resume(clkB->domain); // BANG again
> >       clkB->ops->prepare();
> >       mutex_unlock(clk_prepare);
> >  }
> >
> > Now, let's imagine we know what clocks are going to be accessed and thu=
s
> > need to be runtime resumed. Maybe we could do that in advance. The logi=
c
> > could become:
> >
> >  clk_prepare(clkB) {
> > +     list =3D list_useful_clocks_for_prepare(clkB);
> > +     runtime_resume(list);
> >       mutex_lock(clk_prepare);
> >       clkA =3D clkB->parent;
> >       clk_prepare(clkA) {
> >               mutex_lock(clk_prepare); /* fine, it's recursive */
> > -             runtime_resume(clkA->domain);
> >               clkA->ops->prepare();
> >               mutex_unlock(clk_prepare); /* does nothing */
> >       }
> > -     runtime_resume(clkB->domain);
> >       clkB->ops->prepare();
> >       mutex_unlock(clk_prepare);
> >  }
> >
> > In the above example, the "list_useful_clocks_for_prepare()" is a bit
> > mysterious and has two aspects: first it needs to guess what clocks are
> > needed: this is addressed in the next paragraph. And second, we need to
> > make sure the tree does not change until the lock is acquired, this is
> > addressed in the "#1: Clock tree changes" chapter below.
> >
> > So, regarding the list itself, any operation on any clock in the tree
> > involves the said clock plus one or several clock "lists" among the
> > following choices:
> >
> > A- All its parents, through the clk_core->parent link.
> >    =3D> Typically during prepare/unprepare operations.
> >
> > B- All its children and sub children, through all the sub
> >    clk_core->children hlist.
> >    =3D> Typically during rate operations (get and set, see note below).
> >
> > C- Parents and children of the new parent.
> >    =3D> In case of re-parenting, explicitly asked or as a result of a r=
ate
> >    change.
> >
> > Side note: the clock core does not always remember the rate of the
> > clocks that were already configured. TBH I did not understand why,
> > because it seems trivial to do. Instead the core physically accesses th=
e
> > clock controller which involves a lot of runtime PM handling. In
> > practice, this is not always the case but some clock controller drivers
> > request to be "asked" to read the actual rate each time. Problem is,
> > they re-calculate the rate and then also propagate the result across al=
l
> > the children, which involves massive amounts of (IMHO) useless
> > wake-ups. This honestly feels a bit sub-optimal, without understanding
> > better why this is for.
> >
> > ** DRAWBACKS OF THIS APPROACH **
> >
> > #1: Clock tree changes
> >
> > Of course there was a point in making the runtime resume calls inside
> > the clk_prepare lock: the lock protects against clk tree changes. But
> > somehow this is still manageable, we could:
> > - acquire the lock
> > - parse the list of relevant clocks/reference counting them and save
> >   them in a list
> > - release the lock
> > - runtime resume the clocks in the list
> > - acquire the lock again
> > - compare the actual tree with the list and try again the whole
> >   operation if something changed.
> >
> > Estimated status: manageable.
> >
> > #2: Re-Parenting
> >
> > When performing almost any clock operation, we already know in advance
> > what clocks in the tree will be impacted and thus can precisely guess
> > what needs to be runtime resumed in advance. But this is not working
> > when re-parenting is involved, as the re-parenting opportunity is only
> > tried very deeply in the call stack far beyond acquiring the main lock.
> >
> > One idea to workaround the situation was to somehow save the new parent
> > handle, propagate a specific error up through the call stack (typically=
,
> > -EAGAIN), up to the point where we can process this error, perform a ne=
w
> > round of runtime resume calls over the new parent tree and retry the
> > operation.
> >
> > Estimated status: manageable.
> >
> > #3: Debug dumps might slightly get out of sync
> >
> > There are a couple of situations where all the clocks (or all the orpha=
n
> > clocks, or the root clocks) will be "shown/dumped" by the user. Problem
> > is: it is fine to show all the parents/children of a single clock
> > (typically all the children of one root clock), but involve a lot of
> > code duplication to cover eg. all the root clocks at the same time. If
> > we decide that this is okay, we can iterate over these root clocks,
> > releasing the lock between them, which is obviously racy.
> >
> > Estimated status: probably manageable, maybe not so important.
> >
> > #4: Clock core recursivity and unrelated clocks
> >
> > This is the main drawback with this approach, and that is what
> > motivated this letter in the first place.
> >
> > The clock core is recursive. At first I thought it was useful to
> > simplify the locking mechanism inside the core itself, in particular
> > because the core is mainly built off recursive functions, but there are
> > two actual use cases that are much harder to solve. They are mentioned
> > in the commit introducing the reentrance mechanism:
> > 533ddeb1e86f ("clk: allow reentrant calls into the clk framework")
> >
> > Basically, besides simplifying the locking mechanism in the core itself=
:
> >
> > A: Enabling a clock may require enabling a "totally unrelated" peripher=
al
> >    first. Typically, an I2C audio codec that would need to be configure=
d
> >    in order to produce a clock. In the ->prepare() hook implementation,
> >    one can expect some kind of i2c_xfer() call, which in turns will
> >    runtime resume the I2C controller used to access the codec. So we en=
d
> >    up acquiring again the power domain lock with the clk_prepare lock
> >    taken.
> >
> > B: There is one clock driver (tegra/clk-dfll.c) which performs pinctrl
> >    changes inside clock operations. If the platform is runtime PM
> >    enabled, the pin controller may require being runtime resumed and
> >    once again we might fall into the same recursivity issue.
> >
> > I don't see any positive outcome in trying to guess nor discover these
> > cases dynamically and if we want to address that I believe some kind of
> > static declarations must be done by the clock controller drivers (and
> > trying to do that now will inevitably lead to regressions if we miss
> > a single case).
> >
> > Estimated status: problematic.
> >
> > ** CONCLUSION AND QUESTIONS **
> >
> > I've actually drafted the idea explained above. I need more work to get
> > it up to a working state, as the whole clock core must be converted
> > to this logic in order for it to work. I believe this approach is
> > relevant, but it still has blind spots we need to figure out (#4 above)
> > for which I would like to get some feedback.
> >
> > Maybe however the approach will not be acknowledged and another
> > direction will be pointed. In this case I would be pleased to discuss i=
t
> > and see what we can do. In all cases, the i.MX8 issue is real and must
> > be fixed. If we don't do it properly, soon another power-oriented SoC
> > will also show similar defects. Basically any Linux based operating
> > system running on hardware featuring similarities is subject to deadloc=
k
> > at any moment.
> >
> > I hope this report will be precise enough and raise ideas to help going
> > forward and finally address this issue that has been opened since
> > 2022 (at least) in a rather satisfying way.
> >
> > Thanks,
> > Miqu=C3=A8l
> >
> > PS: There are maybe other ways. Of course I had to pick the one that
> > felt the more promising, even though I initially considered a couple
> > other alternatives:
> > * Addressing the issue in the power domain subsystem ? Seemed less
> >   relevant than in the clock core, because of the physical
> >   dependencies. But please convince me :-)
> > * I saw comments about changing the clk_prepare lock semantics, but we
> >   will always need to serialize accessed to the clock tree and after
> >   digging a bit in the clock core I don't see any way out with this
> >   solution.
> > * Preventing power domains from gathering clocks? Also a possible
> >   approach maybe, even though the situation listed above are far from
> >   straightforward to address in this case.
>
>

