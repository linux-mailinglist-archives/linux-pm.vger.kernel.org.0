Return-Path: <linux-pm+bounces-8190-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666EA8D086D
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 18:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A08D1C22B6C
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 16:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8F417E909;
	Mon, 27 May 2024 16:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EX56jsut"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D3328387;
	Mon, 27 May 2024 16:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826775; cv=none; b=AOwswcfgKMaOgrfsV2BSJZDYgV3CNNx64961bicA+q0QIS28rWJ9lIbbanEG0sM5n+YMkrJJcPO2CLJ6K+Y+ssq++3YqVhtMDGm2WSZXervDH9WhDHUQmr5I2DsHGE5GhJvaK5oH3k+Paa9Eo2joTTTL+n/I4xE0KVxmkx312GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826775; c=relaxed/simple;
	bh=WG5gFYiA4JdlC+5B5ibo0jKew2w/+2l0N8k8IYUrIxI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=K65XePMHELiNppPTStkp9cd1PN88zlCh0yCejbADZeoaRkNezcSqJCwR+PFTVcWt4s0mB0MveK033AP6DmuKkRt2IiLO8SXZWiEScFskMzRTUjbaLEM69sVpULa1ml/tYX217GwGptb6l71/ZDQquB4NQ+WRiq5HST278Czk9Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EX56jsut; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A3466E0008;
	Mon, 27 May 2024 16:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716826771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ivr7Lv5/QaHOiNl1+Nm8U6SGLCjzfZglSZEAXAi9EvY=;
	b=EX56jsutXLo1XGVjnSSfguJ38LEy4rnuGeLdj/rNwnYlw9uA6/1lywfqqZ42c8ECb4wYJr
	H5PTfBGVudrF24TqPaRxhUZuuwRukvJ6M4Cm6E4tsifmJzarwaurod7/NeOeJTP9uBiRnV
	ZFh4/raWjLtspA3ajP4rUI6B0vjiZ2AV6JJszyf571+yOVOTYgdUk03tXBmZJlb4uDOr4V
	DJJampCsn0R/D3AW+i60ntbgRFy2b6L/y+ggl/NnYzVyxrlKwZwE1sUM9KYJvPKOqRkRM4
	QaRnxH2tD/kL/g5LOJ7NCSKb06C/6EtmiuURofJgfXkcb+YR2U3/XMVg5A6m4A==
Date: Mon, 27 May 2024 18:19:28 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Lucas Stach <l.stach@pengutronix.de>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Marek Vasut <marex@denx.de>, Stephen
 Boyd <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Chen-Yu Tsai <wens@csie.org>, linux-clk@vger.kernel.org, Ulf Hansson
 <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Kevin
 Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Fabio Estevam <festevam@denx.de>,
 Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>, Shawn Guo
 <shawnguo@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 linux-imx@nxp.com, Ian Ray <ian.ray@gehealthcare.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, =?UTF-8?B?SGVydsOp?= Codina
 <herve.codina@bootlin.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: Clocks vs. Power Domains circular dependency
Message-ID: <20240527181928.4fc6b5f0@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hello all,

I would like to re-open the clocks vs. runtime PM/power domains topic
that is currently still problematic on i.MX8. I am mentioning a
specific SoC here but the problem is hardware agnostic and any SoC with
a sufficiently advanced power scheme may suffer from the same issues.
When (mainline) Linux is running, we get lockdep warnings because of
circular dependencies between the clock and power domain subsystems, as
well as real deadlocks.

I don't have the full history but here is an interesting attempt at
fixing this by Marek end of 2022:
https://lore.kernel.org/all/Y1cs++TV2GCuh4tS@pendragon.ideasonboard.com/
And here is an interesting discussion that happened on the mailing list
following a second attempt from Marek as well:
https://patchwork.kernel.org/project/linux-pm/patch/20221108013517.749665-1=
-marex@denx.de

Looking more closely at this problem, there is indeed a software design
issue. Both the clock and power domain subsystems are recursive and
interdependent, the power domain subsystem being sometimes accessed
through runtime PM calls.

[TLDR: I'm drafting something, but issue #4 at the bottom is blocking]

** THE ISSUE: FROM A CLOCK PERSPECTIVE **

Clock changes (not only clk_prepare(), but getting/setting the rates as
well, re-parenting and so on) involve runtime resuming part of the clock
tree. Eg. registers for accessing/configuring a clock might be in a
power domain that must be resumed.

Also, the clk subsystem is mostly written using recursivity, so for
instance preparing a clock works like this:

/*
 * Same applies to the other clk consumer calls, but instead of going
 * through the parents, other parts of the clk tree are accessed (the
 * children subtree, the new parent tree, or both). So the prepare
 * situation is one of the simplest in this regard, but the following
 * basically applies to most consumer operations.
 */
clk_prepare(clk) {
	clk_prepare(clk->parent);
	runtime_resume(clk->domain);
	clk->ops->prepare();
}

Now if we add another level of complexity, accesses to the clock tree
are serialized by the clk_prepare mutex, and runtime PM calls are also
protected by a global genpd lock:

clk_prepare(clk) {
	mutex_lock(clk_prepare);
	clk_prepare(clk->parent); /* clk_prepare is reentrant, so this is "fine" */
	runtime_resume(clk->domain);
	clk->ops->prepare();
	mutex_unlock(clk_prepare);
}

runtime_resume(domain) {
	mutex_lock(genpd);
	domain->ops->resume();
	mutex_unlock(genpd);
}

If we list the locking events in order, we will:
- acquire the clk lock
- acquire the genPD lock
- release the genPD lock
- release the clk lock

** THE ISSUE: FROM A POWER DOMAIN PERSPECTIVE **

Now let's see the other side, from the power domain perspective. We can
imagine several situations where these locks are acquired in the reverse
order. From a hardware standpoint there is a prerequisite (met in the
i.MX8 in several places): a power domain is fed by a clock, hence
enabling the power domain also implies enabling the feeding clock.

    #1: Probing/enabling peripherals involve attaching and powering up
    their power domain. If the power domain is fed by a clock the power
    domain implementation will request clock changes.

    #2: Suspending devices happens asynchronously in a
    worker. Suspending a device implies turning off its power domain,
    and hence possibly reaching some clock internals as well.

In these cases we will play with locks in this order:
- acquire the genPD lock
- acquire the clk lock
- release the clk lock
- release the genPD lock

Here are two typical examples: power domains playing with upstream
clocks:
https://elixir.bootlin.com/linux/latest/source/drivers/pmdomain/imx/imx8mp-=
blk-ctrl.c#L538
https://elixir.bootlin.com/linux/latest/source/drivers/pmdomain/imx/gpcv2.c=
#L340

** CURRENT UNDERSTANDING **

Clock changes and runtime PM calls can happen at any moment and if your
hardware is in a bad mood a dead lock *will* occur. I myself only
experienced deadlocks involving the clock worker disabling unused clocks
at the end of the boot, but chances are way too high that systems will
lock up at some point in production environment because of this circular
dependency between the clock and power domain locks. It is possible to
avoid the deadlock I experienced by disabling the clk_disable_unused
worker and keeping all clocks enabled, but we will all agree that this
is a very sub-optimal and extremely unsatisfying solution for a SoC
explicitly designed for optimized power consumptions.

There is no magic, we must dismangle the situation and prevent either
one lock ordering or the other from happening. So we should ask
ourselves: what lock order seems the most legitimate?

    #1: Do clocks really depend on power domains?

    -> Clock controllers may be part of a power domain, hence the power
    domain must be enabled in order to access the clock controller
    registers.

    -> Same applies if a clock is generated by an external device
    (eg. an audio codec) and this codec is accessible through a serial
    bus: the bus controller must be resumed in order to configure the
    code, and the bus controller may be in its own power domain.

    #2: Do power domains really depend on clocks?

    -> Somehow yes. Most power domains are not explicitly "driven" by
    the upstream clocks described in device trees, ie: keeping these
    clocks gated does not prevent the use nor the access to the power
    domains per-se. However, the power domains may redistribute the
    clocks to the peripherals inside and somehow becoe themselves clock
    controllers (even though so far they are not flagged like that in
    any DTS). Hence it appears legitimate that they might want to play
    with the clock API.

    DTSI example:
    https://elixir.bootlin.com/linux/latest/source/arch/arm64/boot/dts/free=
scale/imx8mp.dtsi#L1799

    TRM extract:

      13.2.1 Overview
      The MEDIAMIX domain contains control and status registers known as
      Media Block Control (MEDIA BLK_CTRL). These registers have
      miscellaneous top-level controls for peripherals within the MEDIAMIX
      domain. Some of these controls includes clocking, [...]

      13.2.2: Clocks and Resets
      The Media BLK_CTRL contains clock distribution and gating controls,
      as well as reset handling to several of the MEDIAMIX peripherals.

    -> One specificity of the i.MX8 is that many power domains are
    also described with a "clocks" property which list clocks that are
    directly connected to the peripherals inside the power domain
    instead. The reason for this inaccurate description is: toggling a
    power domain on or off seems to involve propagating reset signals,
    which only happens correctly if a few specific clocks feeding the
    targeted peripherals are actually running. Then, as part of the
    on/off sequence, it is required that these clocks get enabled (and
    then disabled) earlier than in their respective probe functions,
    see:
    - ae1d2add26a4 ("soc: imx: gpcv2: handle reset clocks")
    - https://elixir.bootlin.com/linux/latest/source/arch/arm64/boot/dts/fr=
eescale/imx8mp.dtsi#L795
    - https://elixir.bootlin.com/linux/latest/source/arch/arm64/boot/dts/fr=
eescale/imx8mp.dtsi#L857

It is hard to tell, without more details from NXP, how difficult it
would be to switch from the #2 "wrong" power domain DTS description to
something more accurate and still get the proper init sequence. Although
maybe doing that would not be very relevant as there are anyway real
clock dependencies from some power domains, as expressed in the SoC
manual quoted above.

#1 however, despite being a physical constraint, seems also tightly
related to the software design: runtime PM calls were introduced in the
clock subsystem initially for two reasons:
- The clock is itself in an area of the SoC that needs to be powered on
  before accessing its registers.
- The above situation also applies to all the possible parents of the
  clock.
See: 9a34b45397e5 ("clk: Add support for runtime PM")
https://lore.kernel.org/all/1503302703-13801-2-git-send-email-m.szyprowski@=
samsung.com
The clock core being highly recursive, it was way easier (and also
probably cleaner) to include nested runtime PM calls like this. But in
practice, we could imagine moving the resume path outside of the clock
lock and avoid "by software" the conditions under which the two locks
are taken.

Note: These suggestions have already been made by Ulf:
https://patchwork.kernel.org/project/linux-pm/patch/20221108013517.749665-1=
-marex@denx.de/#25092554

** APPROACH UNDER EVALUATION **

As hinted above, maybe we should clarify the conditions under which RPM
calls can be made in the clock subsystem, and instead of including the
RPM calls within the clock sub-calls, we could consider, on a
case-by-case basis:
- listing what needs to be resumed for the whole clock operation to
  succeed first,
- then runtime resume the needed domains outside of the main subsystem
  lock
- before continuing with the clock operations and eventually acquiring
  the main clk_prepare lock.
IOW, avoiding the runtime PM calls with the subsystem lock acquired.

Let's imagine the following situation: clkA (in power domain A) is
parent of clkB (in power domain B). Like above, let's try to picture the
call stack:

 clk_prepare(clkB) {
 	mutex_lock(clk_prepare);
 	clkA =3D clkB->parent;
 	clk_prepare(clkA) {
 		mutex_lock(clk_prepare); /* fine, it's recursive */
 		runtime_resume(clkA->domain); // BANG
 		clkA->ops->prepare();
 		mutex_unlock(clk_prepare); /* does nothing */
 	}
 	runtime_resume(clkB->domain); // BANG again
 	clkB->ops->prepare();
 	mutex_unlock(clk_prepare);
 }

Now, let's imagine we know what clocks are going to be accessed and thus
need to be runtime resumed. Maybe we could do that in advance. The logic
could become:

 clk_prepare(clkB) {
+	list =3D list_useful_clocks_for_prepare(clkB);
+	runtime_resume(list);
 	mutex_lock(clk_prepare);
 	clkA =3D clkB->parent;
 	clk_prepare(clkA) {
 		mutex_lock(clk_prepare); /* fine, it's recursive */
-		runtime_resume(clkA->domain);
 		clkA->ops->prepare();
 		mutex_unlock(clk_prepare); /* does nothing */
 	}
-	runtime_resume(clkB->domain);
 	clkB->ops->prepare();
 	mutex_unlock(clk_prepare);
 }

In the above example, the "list_useful_clocks_for_prepare()" is a bit
mysterious and has two aspects: first it needs to guess what clocks are
needed: this is addressed in the next paragraph. And second, we need to
make sure the tree does not change until the lock is acquired, this is
addressed in the "#1: Clock tree changes" chapter below.

So, regarding the list itself, any operation on any clock in the tree
involves the said clock plus one or several clock "lists" among the
following choices:

A- All its parents, through the clk_core->parent link.
   =3D> Typically during prepare/unprepare operations.

B- All its children and sub children, through all the sub
   clk_core->children hlist.
   =3D> Typically during rate operations (get and set, see note below).

C- Parents and children of the new parent.
   =3D> In case of re-parenting, explicitly asked or as a result of a rate
   change.

Side note: the clock core does not always remember the rate of the
clocks that were already configured. TBH I did not understand why,
because it seems trivial to do. Instead the core physically accesses the
clock controller which involves a lot of runtime PM handling. In
practice, this is not always the case but some clock controller drivers
request to be "asked" to read the actual rate each time. Problem is,
they re-calculate the rate and then also propagate the result across all
the children, which involves massive amounts of (IMHO) useless
wake-ups. This honestly feels a bit sub-optimal, without understanding
better why this is for.

** DRAWBACKS OF THIS APPROACH **

#1: Clock tree changes

Of course there was a point in making the runtime resume calls inside
the clk_prepare lock: the lock protects against clk tree changes. But
somehow this is still manageable, we could:
- acquire the lock
- parse the list of relevant clocks/reference counting them and save
  them in a list
- release the lock
- runtime resume the clocks in the list
- acquire the lock again
- compare the actual tree with the list and try again the whole
  operation if something changed.

Estimated status: manageable.

#2: Re-Parenting

When performing almost any clock operation, we already know in advance
what clocks in the tree will be impacted and thus can precisely guess
what needs to be runtime resumed in advance. But this is not working
when re-parenting is involved, as the re-parenting opportunity is only
tried very deeply in the call stack far beyond acquiring the main lock.

One idea to workaround the situation was to somehow save the new parent
handle, propagate a specific error up through the call stack (typically,
-EAGAIN), up to the point where we can process this error, perform a new
round of runtime resume calls over the new parent tree and retry the
operation.

Estimated status: manageable.

#3: Debug dumps might slightly get out of sync

There are a couple of situations where all the clocks (or all the orphan
clocks, or the root clocks) will be "shown/dumped" by the user. Problem
is: it is fine to show all the parents/children of a single clock
(typically all the children of one root clock), but involve a lot of
code duplication to cover eg. all the root clocks at the same time. If
we decide that this is okay, we can iterate over these root clocks,
releasing the lock between them, which is obviously racy.

Estimated status: probably manageable, maybe not so important.

#4: Clock core recursivity and unrelated clocks

This is the main drawback with this approach, and that is what
motivated this letter in the first place.

The clock core is recursive. At first I thought it was useful to
simplify the locking mechanism inside the core itself, in particular
because the core is mainly built off recursive functions, but there are
two actual use cases that are much harder to solve. They are mentioned
in the commit introducing the reentrance mechanism:
533ddeb1e86f ("clk: allow reentrant calls into the clk framework")

Basically, besides simplifying the locking mechanism in the core itself:

A: Enabling a clock may require enabling a "totally unrelated" peripheral
   first. Typically, an I2C audio codec that would need to be configured
   in order to produce a clock. In the ->prepare() hook implementation,
   one can expect some kind of i2c_xfer() call, which in turns will
   runtime resume the I2C controller used to access the codec. So we end
   up acquiring again the power domain lock with the clk_prepare lock
   taken.

B: There is one clock driver (tegra/clk-dfll.c) which performs pinctrl
   changes inside clock operations. If the platform is runtime PM
   enabled, the pin controller may require being runtime resumed and
   once again we might fall into the same recursivity issue.

I don't see any positive outcome in trying to guess nor discover these
cases dynamically and if we want to address that I believe some kind of
static declarations must be done by the clock controller drivers (and
trying to do that now will inevitably lead to regressions if we miss
a single case).

Estimated status: problematic.

** CONCLUSION AND QUESTIONS **

I've actually drafted the idea explained above. I need more work to get
it up to a working state, as the whole clock core must be converted
to this logic in order for it to work. I believe this approach is
relevant, but it still has blind spots we need to figure out (#4 above)
for which I would like to get some feedback.

Maybe however the approach will not be acknowledged and another
direction will be pointed. In this case I would be pleased to discuss it
and see what we can do. In all cases, the i.MX8 issue is real and must
be fixed. If we don't do it properly, soon another power-oriented SoC
will also show similar defects. Basically any Linux based operating
system running on hardware featuring similarities is subject to deadlock
at any moment.

I hope this report will be precise enough and raise ideas to help going
forward and finally address this issue that has been opened since
2022 (at least) in a rather satisfying way.

Thanks,
Miqu=C3=A8l

PS: There are maybe other ways. Of course I had to pick the one that
felt the more promising, even though I initially considered a couple
other alternatives:
* Addressing the issue in the power domain subsystem ? Seemed less
  relevant than in the clock core, because of the physical
  dependencies. But please convince me :-)
* I saw comments about changing the clk_prepare lock semantics, but we
  will always need to serialize accessed to the clock tree and after
  digging a bit in the clock core I don't see any way out with this
  solution.
* Preventing power domains from gathering clocks? Also a possible
  approach maybe, even though the situation listed above are far from
  straightforward to address in this case.

