Return-Path: <linux-pm+bounces-25419-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7333A890F0
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 03:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E623B27D2
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 01:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E5D2A1D8;
	Tue, 15 Apr 2025 01:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJNiQ3Lc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD13D517;
	Tue, 15 Apr 2025 01:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744678818; cv=none; b=ZS9bQQ+fS54Nd7quKMy6IPOobMB+n2jJ9NW/osBpW77MYIg5J8Gw5OtSYYz1CpAotCXBQAbqr9BU5ouQpksGWif7FUaGMazKgAvvYjNgX5P4UWzyGY+Tae13yQ/j7hqnu2/HUKwOsllJ9hOMjo94bKk7ABjqSZuTXyF8A0JkBfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744678818; c=relaxed/simple;
	bh=gVMfDkSLIjS/7XO3F4F881n6QNhkLoD49wbo+z8Lw6U=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=KhMtK78prXECxC51nXcrymwGWlhPKDAB355nl2KHWBnseW6SM/djq65UfyrLJVG9dYuTRbbB42A0m6KcP/52b9mN6b6DptV4XzJTEmzSSuBH5VW42KSWcV9Hbze5rVGWOjTwW9ESrpa2NgOBFHb4mAFfKA1tP6/IwZ+4u6j0K6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJNiQ3Lc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183D9C4CEE2;
	Tue, 15 Apr 2025 01:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744678817;
	bh=gVMfDkSLIjS/7XO3F4F881n6QNhkLoD49wbo+z8Lw6U=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=sJNiQ3LcU9fyzS3vZwO557svh1+HYjSsqEyGrDhgrZxwI3w2ZIFtVcJF9jL2pmloF
	 CIkf2jD5s38JFhEy+nqMHvDXNgQaNGVeb1sJBkH9RPwL3FG/yZU8tPEUACnHfCguZO
	 M+lez58bapBw2Q1nDvkCKGq2llW3PgmxGCm26qqFNbwaeZ667pN26oXv2OEWAJZyc2
	 9SjdoPmBX6mhbNjfRw9wYqZ9brjEw2LY1I9TQOcxrgqOb0sXPjUbPfP3v3UtmAqVZd
	 V00uze1+WdvVX2SZTmp5SAVrB524DDLyZhgmcKCmunYWuItEU/FythuFioK0cTVIqS
	 W4dmvqiBoIQdA==
Message-ID: <8dfe4bfff1256c1ceffeab81cd587d0d@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250326-cross-lock-dep-v1-0-3199e49e8652@bootlin.com>
References: <20250326-cross-lock-dep-v1-0-3199e49e8652@bootlin.com>
Subject: Re: [PATCH RFC 00/10] Fix the ABBA locking situation between clk and runtime PM
From: Stephen Boyd <sboyd@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>, Lucas Stach <l.stach@pengutronix.de>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marek Vasut <marex@denx.de>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, Fabio Estevam <festevam@denx.de>, Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>, linux-imx@nxp.com, Ian Ray <ian.ray@gehealthcare.com>, =?utf-8?q?Herv=C3=A9?= Codina <herve.codina@bootlin.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, Saravana Kannan <saravanak@google.com>, Miquel Raynal <miquel.raynal@bootlin.com>
To: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Michael Turquette <mturquette@baylibre.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Pavel Machek <pavel@ucw.cz>, Rafael J. Wysocki <rafael@kernel.org>
Date: Mon, 14 Apr 2025 18:00:15 -0700
User-Agent: alot/0.12.dev8+g17a99a841c4b

Quoting Miquel Raynal (2025-03-26 11:26:15)
> As explained in the following thread, there is a known ABBA locking
> dependency between clk and runtime PM.
> Link: https://lore.kernel.org/linux-clk/20240527181928.4fc6b5f0@xps-13/
>=20
> The problem is that the clk subsystem uses a mutex to protect concurrent
> accesses to its tree structure, and so do other subsystems such as
> generic power domains. While it holds its own mutex, the clk subsystem
> performs runtime PM calls which end up executing callbacks from other
> subsystems (again, gen PD is in the loop). But typically power domains
> may also need to perform clock related operations, and thus the
> following two situations may happen:
>=20
> mutex_lock(clk);
> mutex_lock(genpd);
>=20
> or
>=20
> mutex_lock(genpd);
> mutex_lock(clk);
>=20
> As of today I know that at least NXP i.MX8MP and MediaTek MT8183 SoCs
> are complex enough to face this kind of issues.
>=20
> There's been a first workaround to "silence" lockdep with the most
> obvious case triggering the warning: making sure all clocks are RPM
> enabled before running the clk_disable_unused() work, but this is just
> addressing one situation among many other potentially problematic
> situations. In the past, both Laurent Pinchart and Marek Vasut have
> experienced these issues when enabling HDMI and audio support,
> respectively.
>=20
> Following a discussion we had at last Plumbers with Steven, I am
> proposing to decouple both locks by changing a bit the clk approach:
> let's always runtime resume all clocks that we *might* need before
> taking the clock lock. But how do we know the list? Well, depending on
> the situation we may either need to wake up:
> - the upper part of the tree during prepare/unprepare operations.
> - the lower part of the tree during (read) rate operations.
> - the upper part and the lower part of the tree otherwise (especially
>   during rate changes which may involve reparenting).

Thanks for taking on this work. This problem is coming up more and more
often.

>=20
> Luckily, we do not need to do that by hand, are more importantly we do
> not need to use the clock tree for that because thanks to the work from
> Saravana, we already have device links describing exhaustively the
> consumer/supplier relationships. The clock topology (from a runtime PM
> perspective) is reflected in these links. In practice, we do not care
> about all consumers, but the few clock operations that will actually
> trigger runtime PM operations are probably not impacting enough to
> justify something more complex.

This won't always work, for a couple reasons. First because clk drivers
aren't required to describe their parent clks that are outside the clk
controller by using DT with a 'clocks' property in the clk controller
node. Second because there can be a many to one relationship between a
struct device and struct device_node. We're trying to push drivers to be
written in a way that the binding has the 'clocks' property, but that
isn't always the case, so we still need a solution that works in all
cases so as to not regress old (legacy?) implementations or ones that
divide a platform device into some number of auxiliary devices and
drivers.

One idea to do that would be to implement the device links between clk
controller devices based on all possible parents of the clk. We support
lazily registering clks though, meaning a parent could be registered at
any time, so we would have to explore the clk tree each time a clk is
registered to see if any new clks need to be found and device links made
between devices. The general algorithm is probably something like:

  clk_register()
   make_links_for_node()
    if device node missing 'clocks' property
     for each parent string
      pclk =3D find parent clk
      pdev =3D pclk->dev
      link pdev to dev node
    else
     for each clk in clocks property
      pclk =3D find parent clk
      pdev =3D pclk->dev
      link pdev to dev node

We have to get the parent clk in all cases because we don't know which
device it may be registered for (the platform device or auxiliary
device). If we optimize here, I'd prefer we optimize for the case where
the 'clocks' property is present to encourage migration. Maybe what we
can do is make some structure for a clk controller and have a linked
list of those that we look up when a new clk is registered. We actually
have that already with 'struct clock_provider' so maybe we need to
extend that.

Stash the device pointer in there and some variable sized array of the
clk_core pointers to the external clks. In the 'clocks' DT property
case, we can size this immediately and map the array index to the
property but in the non-property case we'll have to grow this array each
time a new clk is found to be a parent of the device. Maybe for that we
should just have some other sort of linked list of clk_core pointers
that we continue to stack clks onto.

  struct clock_provider {
    void (*clk_init_cb)(struct device_node *);
    struct device *dev;
    struct device_node *np;
    struct list_head node;
    struct clk_core *legacy_clks; // Or struct list_head legacy?
    size_t len_clocks;
    struct clk_core clocks_property[];
 };

