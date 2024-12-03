Return-Path: <linux-pm+bounces-18500-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5C29E2C13
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 20:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14E57B2662B
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 19:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3B51FECC3;
	Tue,  3 Dec 2024 19:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEOSSMAw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B705F1F8910;
	Tue,  3 Dec 2024 19:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733254210; cv=none; b=dRwIZKPPemSgMvPXrsk98QcH+TtqxGI2YgLCb9u4UwMkx1O2QQmeE+F5C3XAuIanWJk5CPKPfWmHsz1gU/Yw981po7wyn9OUN+Fzfg3GbeWYgymbxw+8G/bty9nR+IlFr75DZ/uwP5w2eY7FAKk6s/nDHU7LBQV1F97d0VUygsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733254210; c=relaxed/simple;
	bh=2K+i1S/3sf74gdv4NXTCEB0ZkasLUdboMLKU7Q6QF+A=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=ekvC1lDLFht7kGFWCUwNNBr+fTwPH7mC10Z1a91jafKpMCo5Vi5WjykIdiMs+6ocoPSNoOTDHNtNUIRn4M/iOCKZeYIYkJzg3+FfdL65JwigSalijp+LqJmzqIBeamNXjOYbO0wmzbLKwKkh7G/nUTw73VQauYIpOCMVOJ4R7gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rEOSSMAw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15598C4CECF;
	Tue,  3 Dec 2024 19:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733254210;
	bh=2K+i1S/3sf74gdv4NXTCEB0ZkasLUdboMLKU7Q6QF+A=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=rEOSSMAw4aRVIFfjkZ/b9s5WQsVAdJl8UqHu4CEvzDgMSq+RMuqTHTq8lEghwGUKz
	 bO/TpYbMyqWPDII5AOo6Y+XjPIF4RAWz7fHDNUjOirbOKvSIMZ/jKH5esQ+11WelbV
	 UnYzdUOIDRvWH/Gqhmb9IPBkGk5/VTlkc9794+uD/RzQ5I2HZTDWg/WQJTIiZl/UJb
	 yuOJf+zJOreYn2LK12Fh9NTPEhONJdWfdERUoESArOvdsDoJg7vLwjt5hQXygmHvLI
	 2zVSBEvJ3JpWm0xgNVM+25l7YjenhetnbxAs0bpmGBFsirgmULEBQvbGItgCnGVxY6
	 wihVM8k+X4Uhw==
Message-ID: <afa086b0b30ab5b810178f92fac96837.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241203092151.izcsgzqep4imbcwe@thinkpad>
References: <20241202100621.29209-1-johan+linaro@kernel.org> <3fd004add188460bf2bdd1a718387c7f.sboyd@kernel.org> <Z07AXbQvvZwI8Ki6@hovoldconsulting.com> <20241203092151.izcsgzqep4imbcwe@thinkpad>
Subject: Re: [PATCH] Revert "clk: Fix invalid execution of clk_set_rate"
From: Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Johan Hovold <johan+linaro@kernel.org>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, regressions@lists.linux.dev, Aishwarya TCV <aishwarya.tcv@arm.com>, Chuan Liu <chuan.liu@amlogic.com>, Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org
To: Johan Hovold <johan@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Tue, 03 Dec 2024 11:30:07 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Manivannan Sadhasivam (2024-12-03 01:21:51)
> On Tue, Dec 03, 2024 at 09:25:01AM +0100, Johan Hovold wrote:
> > [ +CC: Viresh and Sudeep ]
> >=20
> > On Mon, Dec 02, 2024 at 05:20:06PM -0800, Stephen Boyd wrote:
> > > Quoting Johan Hovold (2024-12-02 02:06:21)
> > > > This reverts commit 25f1c96a0e841013647d788d4598e364e5c2ebb7.
> > > >=20
> > > > The offending commit results in errors like
> > > >=20
> > > >         cpu cpu0: _opp_config_clk_single: failed to set clock rate:=
 -22
> > > >=20
> > > > spamming the logs on the Lenovo ThinkPad X13s and other Qualcomm
> > > > machines when cpufreq tries to update the CPUFreq HW Engine clocks.
> > > >=20
> > > > As mentioned in commit 4370232c727b ("cpufreq: qcom-hw: Add CPU clo=
ck
> > > > provider support"):
> > > >=20
> > > >         [T]he frequency supplied by the driver is the actual freque=
ncy
> > > >         that comes out of the EPSS/OSM block after the DCVS operati=
on.
> > > >         This frequency is not same as what the CPUFreq framework ha=
s set
> > > >         but it is the one that gets supplied to the CPUs after
> > > >         throttling by LMh.
> > > >=20
> > > > which seems to suggest that the driver relies on the previous behav=
iour
> > > > of clk_set_rate().
> > >=20
> > > I don't understand why a clk provider is needed there. Is anyone look=
ing
> > > into the real problem?
> >=20
> > I mentioned this to Mani yesterday, but I'm not sure if he has had time
> > to look into it yet. And I forgot to CC Viresh who was involved in
> > implementing this. There is comment of his in the thread where this
> > feature was added:
> >=20
> >       Most likely no one will ever do clk_set_rate() on this new
> >       clock, which is fine, though OPP core will likely do
> >       clk_get_rate() here.
> >=20
> > which may suggest that some underlying assumption has changed. [1]
> >=20

Yikes.

>=20
> I just looked into the issue this morning. The commit that triggered the =
errors
> seem to be doing the right thing (although the commit message was a bit h=
ard to
> understand), but the problem is this check which gets triggered now:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/clk/clk.c?h=3Dv6.13-rc1#n2319
>=20
> Since the qcom-cpufreq* clocks doesn't have parents now (they should've b=
een
> defined anyway) and there is no CLK_SET_RATE_PARENT flag set, the check r=
eturns
> NULL for the 'top' clock. Then clk_core_set_rate_nolock() returns -EINVAL,
> causing the reported error.
>=20
> But I don't quite understand why clk_core_set_rate_nolock() fails if ther=
e is no
> parent or CLK_SET_RATE_PARENT is not set. The API is supposed to set the =
rate of
> the passed clock irrespective of the parent. Propagating the rate change =
to
> parent is not strictly needed and doesn't make sense if the parent is a f=
ixed
> clock like XO.

The recalc_rate clk_op is telling the framework that the clk is at a
different rate than is requested by the clk consumer _and_ than what the
framework thinks the clk is currently running at. The clk_set_rate()
call is going to attempt to satisfy that request, and because there
isn't a determine_rate/round_rate clk_op it assumes the clk can't change
rate so it looks to see if there's a parent that can be changed to
satisfy the rate. There isn't a parent either, so the clk_set_rate()
call fails because the rate can't be achieved on this clk.

It may work to have a determine_rate clk_op that is like the recalc_rate
one that says "this rate you requested is going to turn into whatever
the hardware is running at" by simply returning the rate that the clk is
running at.

