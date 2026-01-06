Return-Path: <linux-pm+bounces-40309-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B38CF8482
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 13:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9766B3012C46
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 12:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74794309EEC;
	Tue,  6 Jan 2026 12:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MndQZg5Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4199A2F1FD7;
	Tue,  6 Jan 2026 12:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767701994; cv=none; b=N+GMmFWZtbwEe62YT9eBv1YiyrbWwXSX219bP8A4z903R+JaeiDcTRPlla3Hs2D4MxsSPTRsWu14BQq1fhMDDcj6NQ0/17deinW5bgL1LDqBye5aGRMQeZgWlC9pesmN/NUAnuT2KAzvkFvY9MiKqIwTcccPeAE4tMiAjMTq/Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767701994; c=relaxed/simple;
	bh=O/dUHVimSNITbK1jFp8OUa64TxXXBUiAJEVnK2fNV/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CNfmAFtJNYhYHLdadq8OVqHxjZmQf8TQQOwBg75ynvRw7sLpFUBnRmxss3IrbSBZUw6Vh/jV/D/3eqkTVbLwECIJLt3e/k5EFd8MR5HmFQPCYguVXSc2mgkOk8dOrIaBveZljdJXiS73BdnLzlVEF0IUZVgxPmGs6UtCpFSk5GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MndQZg5Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B767FC116C6;
	Tue,  6 Jan 2026 12:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767701993;
	bh=O/dUHVimSNITbK1jFp8OUa64TxXXBUiAJEVnK2fNV/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MndQZg5QHrZwZC1tYQynC9cmXs+i3bh5G0apx7/tSIZthxiU6TtnFHAHMUZahaL8Q
	 p7i6PasNNZZiT19/veZrVEFTUXP//jULMvD/d9+mNJQhdqsPJxc8al5f7kWt4DacQX
	 1GL3S1d3AWG+ugm2hGSInej54TguCh/SmJWzI3whN54twSKAjw8m23yqWS/Y/fvqGN
	 UWY/hpbgbP2BuDdc+VbqOnOSUvz+Ss7e5hcMgN7rc9molpJkDAqmfm11HaqQWd3LCf
	 yVRVCjqdLB6bqV09T0pDlOdWL+dRVsKBYBrMCXA6kU2SNh52uBodk2eeJx5qwmEzxo
	 r8BsQZoIAKotw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Jon Hunter <jonathanh@nvidia.com>, Linux PM <linux-pm@vger.kernel.org>
Cc: linux-tegra@vger.kernel.org, Prashant Gaikwad <pgaikwad@nvidia.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>, linux-clk@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Dmitry Osipenko <digetx@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2] clk: tegra: Adjust callbacks in tegra_clock_pm
Date: Tue, 06 Jan 2026 13:19:47 +0100
Message-ID: <5956349.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To:
 <CAJZ5v0i7Rbk5sWCo2Z1Y4j_ZFW7nCUr18H8i2JCM=aPpfZOQ4w@mail.gmail.com>
References:
 <5088794.31r3eYUQgx@rafael.j.wysocki>
 <2d55ebec-1e42-4ddb-b0e2-529d3b2d7b85@nvidia.com>
 <CAJZ5v0i7Rbk5sWCo2Z1Y4j_ZFW7nCUr18H8i2JCM=aPpfZOQ4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Tuesday, January 6, 2026 1:07:15 PM CET Rafael J. Wysocki wrote:
> Hi Jon,
>=20
> On Tue, Jan 6, 2026 at 11:36=E2=80=AFAM Jon Hunter <jonathanh@nvidia.com>=
 wrote:
> >
> > Hi Rafael,
> >
> > On 04/01/2026 11:53, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > System suspend and resume callbacks run after the core has bumped
> > > up the runtime PM usage counters of all devices, so these callbacks
> > > need not worry about runtime PM reference counting.
> > >
> > > Accordingly, to eliminate useless overhead related to runtime PM
> > > usage counter manipulation, set the suspend callback pointer in
> > > tegra_clock_pm to pm_runtime_resume() and do not set the resume
> > > callback in it at all.
> > >
> > > This will also facilitate a planned change of the pm_runtime_put()
> > > return type to void in the future.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >
> > > This patch is requisite for converting pm_runtime_put() into a void
> > > function.
> > >
> > > If you decide to pick it up, please let me know.
> > >
> > > Otherwise, an ACK or equivalent will be appreciated, but also the lack
> > > of specific criticism will be eventually regarded as consent.
> > >
> > > ---
> > >   drivers/clk/tegra/clk-device.c |    2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > --- a/drivers/clk/tegra/clk-device.c
> > > +++ b/drivers/clk/tegra/clk-device.c
> > > @@ -175,7 +175,7 @@ unreg_clk:
> > >    * perspective since voltage is kept at a nominal level during susp=
end anyways.
> > >    */
> > >   static const struct dev_pm_ops tegra_clock_pm =3D {
> > > -     SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_resume_and_get, pm_runtime_p=
ut)
> > > +     SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_resume, NULL)
> > >   };
> > >
> > >   static const struct of_device_id tegra_clock_match[] =3D {
> >
> >
> > I gave this a quick test and this is causing a suspend regression on
> > Tegra20 and Tegra30 that use this driver. Looking at the console log
> > on Tegra20 I see the following errors ...
> >
> >   tegra-clock tegra_clk_sclk: PM: dpm_run_callback(): pm_runtime_resume=
 returns 1
>=20
> Of course, it needs a wrapper.

So the patch below should work better.

=2D--
=46rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH v2] clk: tegra: Adjust callbacks in tegra_clock_pm

System suspend and resume callbacks run after the core has bumped
up the runtime PM usage counters of all devices, so these callbacks
need not worry about runtime PM reference counting.

Accordingly, to eliminate useless overhead related to runtime PM
usage counter manipulation, set the suspend callback pointer in
tegra_clock_pm to a wrapper around pm_runtime_resume() called
tegra_clock_suspend() and do not set the resume callback in it at all.

This will also facilitate a planned change of the pm_runtime_put()
return type to void in the future.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
=2D--

v1 -> v2:
   * Use a wrapper around pm_runtime_resume() to avoid aborting
     system suspend when it returns 1 (which is always when the
     clock is active during system suspend).

=2D--
 drivers/clk/tegra/clk-device.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

=2D-- a/drivers/clk/tegra/clk-device.c
+++ b/drivers/clk/tegra/clk-device.c
@@ -174,8 +174,19 @@ unreg_clk:
  * problem. In practice this makes no difference from a power management
  * perspective since voltage is kept at a nominal level during suspend any=
ways.
  */
+static inline int tegra_clock_suspend(struct device *dev)
+{
+	int ret;
+
+	ret =3D pm_runtime_resume(dev);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static const struct dev_pm_ops tegra_clock_pm =3D {
=2D	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_resume_and_get, pm_runtime_put)
+	SET_SYSTEM_SLEEP_PM_OPS(tegra_clock_suspend, NULL)
 };
=20
 static const struct of_device_id tegra_clock_match[] =3D {




