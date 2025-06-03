Return-Path: <linux-pm+bounces-28029-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96355ACCB28
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 18:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60A3E176E1E
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 16:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED2223E33D;
	Tue,  3 Jun 2025 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="hU0+rwnH"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9A423C51B;
	Tue,  3 Jun 2025 16:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748967744; cv=none; b=RykfhM6Ccze959QrEJco72XthLuGBsrQcHIz+mc+2MVe5kQ/1U+7Q0tfME/TKYJLtbFuusbazqTsp/lcT3iyqyxy4xhmfEmWL9sIG9bP5aKoqWFQHQtPLicyys8K+ClujisbiLzL3Vm1hqN+dofdNTvsPh+fVMHrpmibbs46D8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748967744; c=relaxed/simple;
	bh=Fdok7Br/KDs6NeJ/Y7SQFQQ/Cag227mQAiEgw2APNW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FhB5ILsM1zkjQ3gl4BUlSaGf1cHAZWVNmrDj0UBAouVX+hc21DdWlptqFDwpTZxFAjrjglyVAo06fOLH+zMOFn5zvJnMvMDi8YHZk1uPA4ZOKXirXvcg8HU3XeaAMHwVDxNu5lX+LC0mRSCjUI0fbeymzqKdfUC3hrWu0dioOsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=hU0+rwnH; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id A438D66BCC9;
	Tue,  3 Jun 2025 18:22:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1748967734;
	bh=Fdok7Br/KDs6NeJ/Y7SQFQQ/Cag227mQAiEgw2APNW0=;
	h=From:Subject:Date;
	b=hU0+rwnHak3id2gyt6DWN/090L6zwPKbz4PbpEes8sM5DBlaxxDB2ZFJHW6CHOWjY
	 ed892S0Ou02xoDPJdhnpi06wQHkiDF9gLiT7DWJO675ufGcWBwatZcJ2nX4vvvBefR
	 J2HsFYN+YVHKmZOS6clU6xoIv3NtN9nDMak38Y7sr3oJ7LhyvHBfT20gl0WP0E2sgR
	 tvQCYQmNmNLbHlnj8wDuyrfML5KOx1btby3G5hErJRsrxSw8Esd8QXXcyGn+LBsZSs
	 9E+kqPiBjiDJ1xGgM787Ybj9Cp6YGo9pKdmNzWHDVTCs9WV1QqldcqIe7JLBECMbrV
	 gt29yz3wmFbwg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Chris Bainbridge <chris.bainbridge@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Saravana Kannan <saravanak@google.com>,
 Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v1 3/3] PM: sleep: Add locking to dpm_async_resume_children()
Date: Tue, 03 Jun 2025 18:21:57 +0200
Message-ID: <13779172.uLZWGnKmhe@rjwysocki.net>
In-Reply-To: <6166108.lOV4Wx5bFT@rjwysocki.net>
References: <6166108.lOV4Wx5bFT@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 5.63.189.50
X-CLIENT-HOSTNAME: 5.63.189.50
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: dmFkZTEfh61c7A06WGUkHT7vFJj3USfNCX9d7R2R4WDorhZXrTp+60oyaNLi8kxofXKZvVyiSPeh1eRKP6GGLnApa9zR/OniJAvvEMQ1432r7ddp+szjuOZLmmEDeQ462kYyym/es++QedRbmJpAqZk4JpzfKTE9dwUKY/LAM+xuYz1xsKm5lY/u1Ps2tx+OrHuE44Y42UBvmONU1b9DBIFv9Kn4cWCY2VY9PFdAK+mdu+es0kVGbUtXVZPu2aniTr+6zPi4tYOzPR9rWA2/vfEf7ZgVIBisrWHBBrP1xK9dTKvY8hqHr3gwpkh++zOsshp9kf81spISYgx0MUNxjbhqnYnPsznmf6PtqvqTsuFMbwCXEoxV82wakrZzC8W15DTOfP5sINw+MlDfGvHswhAbP2BiV0iMoEc3ugoVygxh9qxLx1Zuz84+63WhbWqLO5g5wrzRXAkIjQXznjv0MsVepaz1b1yzdBZggSARr5dtZsM85w/TFLW5cbX0fGuNWgnCagYZaXThE7lQjXO/gc6M06VFa8s+Q4x6UVb0U1/wfO1OoTg0/54MVikzjyXL3krJX2y7ITsWwC8GCyppcsa9FUd+QX6dHLMO8ERb9zsW+qvJFoCIMC/5OXDzOWzXEAl7qx1nNe9ttxdP6OAz2rPKwcNs6zVfC/PRvdKt5Ve8NBwkDA
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 0cbef962ce1f ("PM: sleep: Resume children after resuming the
parent") introduced a subtle concurrency issue that may lead to a kernel
crash if system suspend is aborted and may also slow down asynchronous
device resume otherwise.

Namely, the initial list walks in dpm_noirq_resume_devices(),
dpm_resume_early(), and dpm_resume() call dpm_clear_async_state() for
every device and attepmt to asynchronously resume it if it has no
children (so it is a "root" device).  The asynchronous resume of a
root device triggers an attempt to asynchronously resume its children
which may take place before calling dpm_clear_async_state() for them
due to the lack of synchronization between dpm_async_resume_children()
and the code calling dpm_clear_async_state().  If this happens, the
dpm_clear_async_state() that comes in late, will clear
power.work_in_progress for the given device after it has been set by
__dpm_async(), so the suspend callback will be allowed to run once
again for the same device during the same transition.  This leads to
a whole range of interesting breakage.

Fortunately, if the suspend transition is not aborted, power.work_in_progress
is set by it for all devices, so dpm_async_resume_children() will not
schedule asynchronous resume for them until dpm_clear_async_state()
clears that flag, but this means missing an opportunity to start the
resume of those devices earlier.

Address the above issue by adding dpm_list_mtx locking to
dpm_async_resume_children(), so it will wait for the entire initial
list walk and the invocation of dpm_clear_async_state() for all devices
to be completed before scheduling any new asynchronous resume callbacks.

Fixes: 0cbef962ce1f ("PM: sleep: Resume children after resuming the parent")
Reported-and-tested-by: Chris Bainbridge <chris.bainbridge@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -638,6 +638,13 @@
 static void dpm_async_resume_children(struct device *dev, async_func_t func)
 {
 	/*
+	 * Prevent racing with dpm_clear_async_state() during initial list
+	 * walks in dpm_noirq_resume_devices(), dpm_resume_early(), and
+	 * dpm_resume().
+	 */
+	guard(mutex)(&dpm_list_mtx);
+
+	/*
 	 * Start processing "async" children of the device unless it's been
 	 * started already for them.
 	 *




