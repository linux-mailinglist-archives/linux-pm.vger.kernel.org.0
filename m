Return-Path: <linux-pm+bounces-38139-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 496F4C65D9A
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 20:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 47AFF34A12A
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 19:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5D3344045;
	Mon, 17 Nov 2025 18:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cy2msxp5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2893734403B;
	Mon, 17 Nov 2025 18:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763405853; cv=none; b=LvMhJiQzLUZMf8aI4wdr14VR0yYROdptKvZMP0EujX/UO8L46McIxdP7J//Q07PfRsYd6qaW1ODlFsDeMIL08cFQmicd81rrIpfd7LzVqGgVRGWQwNvb2/HNSHlWaJ7DhM8clBucjoqC9rCLLx+miFCL2PONNYQqHmST23Glr0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763405853; c=relaxed/simple;
	bh=wCVlNbvIcWAvCxR/dOfQhDqObPNEbFnAAdyTsqKCmtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CV0IYxGRgr9o9Fz4I/SqZ+DxBPDiy7sIKBj2ymJBYsmTcV6NpdEC8/jdRMh05MAQVyZPD0gRDTU0AHZmSvah5E9E9ShgCNagDNPKHIRsL6Y1p0rK7dD+TM6FSo/7101fEs214pYTimUkwNd0Mr0GuOaLKuyWeqsEkMQRYvQ2EiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cy2msxp5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5727DC2BCB0;
	Mon, 17 Nov 2025 18:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763405851;
	bh=wCVlNbvIcWAvCxR/dOfQhDqObPNEbFnAAdyTsqKCmtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cy2msxp5qZnKbc6Hhs7/ADxabra5pCs6yhUE7Jbj7WzJ7SbkM1AZ7I+xCsmaJi7RW
	 qKbEOFZ89lLDB4WVkzG2hs4dK/EyV9KjPqelTjw7U3UaW0cfq3qtNFg9mKEXfjWszb
	 mbhLo9UqyqJiFXZQEBQV/W3VuOkjXPgTrI6srM1+7/ypNYwwYln44Xv4v+13jx0OzP
	 bGId5EPtVh2YtqMk5n54jCFdXfqsrscorS7hXbtZwTA35Zmd31Jkq7Uc+OEb/nplSH
	 8Ck3SdOc44/s5wLeuyH26XxZI2VumTk//HArdxHuX/SAeVptCpb9Y0cBzAd8wRjF9b
	 sd5HOK1e75hrA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Rose Wu <ya-jou.wu@mediatek.com>, linux-pm@vger.kernel.org
Cc: rafael.j.wysocki@intel.com, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org, wsd_upstream <wsd_upstream@mediatek.com>,
 linux-mediatek@lists.infradead.org,
 =?utf-8?B?5aOr6aGPIOmCsQ==?= <artis.chiu@mediatek.com>,
 =?utf-8?B?6Z2W5pm6IOmrmA==?= <Johnny-cc.Kao@mediatek.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
Subject:
 [PATCH v1] PM: sleep: core: Fix runtime PM enabling in device_resume_early()
Date: Mon, 17 Nov 2025 19:57:24 +0100
Message-ID: <5940388.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To:
 <CAJZ5v0jjQgoa8eRyQ-MVQW=FeOEVQP6YTsY7o49LV2wnO=xEDw@mail.gmail.com>
References:
 <70b25dca6f8c2756d78f076f4a7dee7edaaffc33.camel@mediatek.com>
 <CAJZ5v0jjQgoa8eRyQ-MVQW=FeOEVQP6YTsY7o49LV2wnO=xEDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Monday, November 17, 2025 5:59:05 PM CET Rafael J. Wysocki wrote:
> Hi,
>=20
> On Mon, Nov 17, 2025 at 10:31=E2=80=AFAM Rose Wu <ya-jou.wu@mediatek.com>=
 wrote:
> >
> > Hi Rafael and All,
> >
> > I am reporting a regression introduced by the commit
> > 443046d1ad66607f324c604b9fbdf11266fa8aad (PM: sleep: Make suspend of
> > devices more asynchronous), which can lead to a kernel panic (data
> > abort) if a late suspend aborts.
> > The commit modifies list handling during suspend. When a device suspend
> > aborts at the "late" stage, `dpm_suspended_list` is spliced into
> > `dpm_late_early_list`.
> > This creates an imbalance. Devices on this list that had not yet
> > executed `pm_runtime_disable()` in `device_suspend_late()` are now
> > incorrectly subjected to `pm_runtime_enable()` during the subsequent
> > `device_resume_early()` sequence.
>=20
> Ah, obviously.
>=20
> Does the attached patch (that should apply on top of 6.18-rc6) help?
>=20
> If this patch doesn't apply to your kernel, making an analogous change
> to it should be straightforward enough.

That patch was incomplete because it was missing a complementary change
in device_suspend_late() to ensure that power.is_suspended will be set
for all devices with disabled runtime PM.

Please try the one below instead.

Thanks!

=2D--
=46rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Runtime PM should only be enabled in device_resume_early() if it has
been disabled for the given device by device_suspend_late().  Otherwise,
it may cause runtime PM callbacks to run prematurely in some cases
or cause runtime PM to be enabled for devices without runtime PM
support.  That leads to further functional issues.

Make two changes to address this problem.

=46irst, reorder device_suspend_late() to only disable runtime PM for a
device if the power.is_late_suspended flag is going to be set for it.
In all of the other cases, disabling runtime PM for the device is not
in fact necessary.

Second, make device_resume_early() only enable runtime PM for the
devices with the power.is_late_suspended flag set.

=46ixes: 443046d1ad66 ("PM: sleep: Make suspend of devices more asynchronou=
s")
Reported-by: Rose Wu <ya-jou.wu@mediatek.com>
Closes: https://lore.kernel.org/linux-pm/70b25dca6f8c2756d78f076f4a7dee7eda=
affc33.camel@mediatek.com/
Cc: 6.16+ <stable@vger.kernel.org> # 6.16+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
=2D--
 drivers/base/power/main.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

=2D-- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -941,11 +941,11 @@ Run:
=20
 Skip:
 	dev->power.is_late_suspended =3D false;
+	pm_runtime_enable(dev);
=20
 Out:
 	TRACE_RESUME(error);
=20
=2D	pm_runtime_enable(dev);
 	complete_all(&dev->power.completion);
=20
 	if (error) {
@@ -1630,12 +1630,6 @@ static void device_suspend_late(struct d
 	TRACE_DEVICE(dev);
 	TRACE_SUSPEND(0);
=20
=2D	/*
=2D	 * Disable runtime PM for the device without checking if there is a
=2D	 * pending resume request for it.
=2D	 */
=2D	__pm_runtime_disable(dev, false);
=2D
 	dpm_wait_for_subordinate(dev, async);
=20
 	if (READ_ONCE(async_error))
@@ -1649,6 +1643,12 @@ static void device_suspend_late(struct d
 	if (dev->power.syscore || dev->power.direct_complete)
 		goto Complete;
=20
+	/*
+	 * Disable runtime PM for the device without checking if there is a
+	 * pending resume request for it.
+	 */
+	__pm_runtime_disable(dev, false);
+
 	if (dev->pm_domain) {
 		info =3D "late power domain ";
 		callback =3D pm_late_early_op(&dev->pm_domain->ops, state);





