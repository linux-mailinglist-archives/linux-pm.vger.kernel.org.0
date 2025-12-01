Return-Path: <linux-pm+bounces-39007-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB117C98EF4
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 20:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A1943A2CC2
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 19:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA572505AA;
	Mon,  1 Dec 2025 19:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhdDW7uo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04A1248F47;
	Mon,  1 Dec 2025 19:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764619118; cv=none; b=EL//dnCjKmsWp32HVEAuRvwy9mGi7ZbcDoQxKbO9pHM3Rl1l1Z3Ud9EceTXPJ1Jsm+0giXP74kMybA841ZwGC172ZNKwtYyPJY8R09sjWq9B23DgD0WmNimOvLOFDZy5mK5ib+9ivwkdX+d0XwbaYo8y44aCKtqhD0+wLTdcbYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764619118; c=relaxed/simple;
	bh=s0fMGevd5Fm/3xSmEf+RPqgeV/MjpUh+2RceDci38tY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oq5kJc5D4K2JGOuKAWOXRruCgtXThO266AlndYQyHDco9+fZeeDQIhITvZnHr1hoQO+TPOAQXPmz+yWNQTJWId9PH6nsDFqFQkFMFXBzNIf7fRR+dbUYwrzhQRO1hYaA6DzqoZlVafrhza4QdDxexprCV4iM5ObJJDZQLjXu2Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhdDW7uo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370ACC4CEF1;
	Mon,  1 Dec 2025 19:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764619118;
	bh=s0fMGevd5Fm/3xSmEf+RPqgeV/MjpUh+2RceDci38tY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dhdDW7uoy1J5dzc6fBB5tY//BhpTb3lHhc3OFMXvTiX6y4lJqcM7oBdmkLh2UxTry
	 VnQhkdCYmqLYMpVJDZnbtiLUK1vaLD1y/9xzoxhEV8YcA9VTSJg57xozekQiZwwYlm
	 qKmvuYQZJKmgPDKz7Qhsv1z/WkhuyZ5jFcGMhAM2vvPNI6Vfm7iOJAEpIsBpuZR7J6
	 4oIA58eQx9JxuV39yQBdIiPBPrjrdCm21PoqtonnpArG+ipMluDgLZc4Kbug1mqIIy
	 iL5So/dvVyKSJ1p6oNVoMqmvimVdp26GY5XxgnsGs42tNg7hXyWY9cR3QSZQJLZVxm
	 DiGO1Yg/bRIaA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: YangYang <yang.yang@vivo.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v1] PM: sleep: Do not flag runtime PM workqueue as freezable
Date: Mon, 01 Dec 2025 20:58:33 +0100
Message-ID: <6216669.lOV4Wx5bFT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To:
 <CAJZ5v0hm=jfSyBXF0qMYnpATJf56JTxQ-+4JBy3YMjS0cMUMHg@mail.gmail.com>
References:
 <20251126101636.205505-1-yang.yang@vivo.com>
 <82bcdf73-54c5-4220-86c0-540a5cb59bb7@vivo.com>
 <CAJZ5v0hm=jfSyBXF0qMYnpATJf56JTxQ-+4JBy3YMjS0cMUMHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Monday, December 1, 2025 7:47:46 PM CET Rafael J. Wysocki wrote:
> On Mon, Dec 1, 2025 at 10:46=E2=80=AFAM YangYang <yang.yang@vivo.com> wro=
te:

[cut]

> If blk_queue_enter() or __bio_queue_enter() is allowed to race with
> disabling runtime PM for q->dev, failure to resume q->dev is alway
> possible and there are no changes that can be made to
> pm_runtime_disable() to prevent that from happening.  If
> __pm_runtime_disable() wins the race, it will increment
> power.disable_depth and rpm_resume() will bail out when it sees that
> no matter what.
>=20
> You should not conflate "runtime PM doesn't work when it is disabled"
> with "asynchronous runtime PM doesn't work after freezing the PM
> workqueue".  They are both true, but they are not the same.

So I've been testing the patch below for a few days and it will eliminate
the latter, but even after this patch runtime PM will be disabled in
device_suspend_late() and if the problem you are facing is still there
after this patch, it will need to dealt with at the driver level.

Generally speaking, driver involvement is needed to make runtime PM and
system suspend/resume work together in the majority of cases.

=2D--
=46rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject:=20

Till now, the runtime PM workqueue has been flagged as freezable, so it
does not process work items during system-wide PM transitions like
system suspend and resume.  The original reason to do that was to
reduce the likelihood of runtime PM getting in the way of system-wide
PM processing, but now it is mostly an optimization because (1) runtime
suspend of devices is prevented by bumping up their runtime PM usage
counters in device_prepare() and (2) device drivers are expected to
disable runtime PM for the devices handled by them before they embark
on system-wide PM activities that may change the state of the hardware
or otherwise interfere with runtime PM.  However, it prevents
asynchronous runtime resume of devices from working during system-wide
PM transitions, which is confusing because synchronous runtime resume
is not prevented at the same time, and it also sometimes turns out to
be problematic.

=46or example, it has been reported that blk_queue_enter() may deadlock
during a system suspend transition because of the pm_request_resume()
usage in it [1].  That happens because the asynchronous runtime resume
of the given device is not processed due to the freezing of the runtime
PM workqueue.  While it may be better to address this particular issue
in the block layer, the very presence of it means that similar problems
may be expected to occur elsewhere.

=46or this reason, remove the WQ_FREEZABLE flag from the runtime PM
workqueue and make device_suspend_late() use the generic variant of
pm_runtime_disable() that will carry out runtime PM of the device
synchronously if there is pending resume work for it.

Also update the comment before the pm_runtime_disable() call in
device_suspend_late() to document the fact that the runtime PM
should not be expected to work for the device until the end of
device_resume_early().

This change may, even though it is not expected to, uncover some
latent issues related to queuing up asynchronous runtime resume
work items during system suspend or hibernation.  However, they
should be limited to the interference between runtime resume and
system-wide PM callbacks in the cases when device drivers start
to handle system-wide PM before disabling runtime PM as described
above.

Link: https://lore.kernel.org/linux-pm/20251126101636.205505-2-yang.yang@vi=
vo.com/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
=2D--
 drivers/base/power/main.c |    7 ++++---
 kernel/power/main.c       |    2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

=2D-- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1647,10 +1647,11 @@ static void device_suspend_late(struct d
 		goto Complete;
=20
 	/*
=2D	 * Disable runtime PM for the device without checking if there is a
=2D	 * pending resume request for it.
+	 * After this point, any runtime PM operations targeting the device
+	 * will fail until the corresponding pm_runtime_enable() call in
+	 * device_resume_early().
 	 */
=2D	__pm_runtime_disable(dev, false);
+	pm_runtime_disable(dev);
=20
 	if (dev->power.syscore)
 		goto Skip;
=2D-- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -1125,7 +1125,7 @@ EXPORT_SYMBOL_GPL(pm_wq);
=20
 static int __init pm_start_workqueues(void)
 {
=2D	pm_wq =3D alloc_workqueue("pm", WQ_FREEZABLE | WQ_UNBOUND, 0);
+	pm_wq =3D alloc_workqueue("pm", WQ_UNBOUND, 0);
 	if (!pm_wq)
 		return -ENOMEM;
=20




