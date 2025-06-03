Return-Path: <linux-pm+bounces-28030-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D06CACCB29
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 18:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 561507A3BA9
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 16:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CCD23E329;
	Tue,  3 Jun 2025 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="OXv4ec00"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08EF23E334;
	Tue,  3 Jun 2025 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748967744; cv=none; b=r2gk1qsiuFGfraRGs/QwHYFNVjrBaOxPc2HO0aHNGVRp5ESEYQ8L71kq2v3AJYflIlQbKO/mC+DMU5+xiSIQQgXprvXKEdK3ErJaQcxJFanyQq/dTgahk3J0Ba8LiLHvODRXU4dSp5tuDcjtQNlWtmPWq4H2QkbYlJcoPT8oThg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748967744; c=relaxed/simple;
	bh=o5I7PlJZUbrb8Z5gMbcZubvybJd84pVroAir3as0yHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uH8IHLF2RnW0NzP8hq+EE/WHPqmG+3G8otr1jfEpHBjfHJ/CFicRzivmfSfiCJ06mKkRRbMW7esY0bWECXPYvpkzitw7GZ7q2AbWRpWdDBoK0bu+U6BpOvgTl7OdQ5ZiwDG5O8G6bjmBbprq35fFGzD795Y2Tig87S9Jml3XKsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=OXv4ec00; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 963B166BDF3;
	Tue,  3 Jun 2025 18:22:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1748967735;
	bh=o5I7PlJZUbrb8Z5gMbcZubvybJd84pVroAir3as0yHU=;
	h=From:Subject:Date;
	b=OXv4ec00tqTzrJ0kjzz81plutlQzPdtENwW6KA7pqTqSSqsyMwTFrLzwZWiMPzRxm
	 crFQnbE5YTk9Doqe7LVWGgo99dDCE0FN4/hxn9x8UQ+xVIjgVoKprtMhI8WsRNdado
	 WQZjfOjBu/dzRw5PWOY+zR5jv28PwyyCCXN+Kp4I7w8Nur5wsPVJrH4uCxDVM5mEwH
	 W8rIW+SABkRTk/A7o3Jv5pQT6YWWxzHS8JHJMrKZJUEtm4Bw8MNYxy/VSk2S58YDbh
	 uLIUQY11Q1GNTZ2+C921sMSod5K3TV6jVvuIFIrkHqkD+Oo7RnU0H/QXW32Xtt5RRd
	 F0q0IVrBm6Qeg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Chris Bainbridge <chris.bainbridge@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Saravana Kannan <saravanak@google.com>,
 Sudeep Holla <sudeep.holla@arm.com>
Subject:
 [PATCH v1 2/3] PM: sleep: Fix power.is_suspended cleanup for direct-complete
 devices
Date: Tue, 03 Jun 2025 18:19:27 +0200
Message-ID: <4990586.GXAFRqVoOG@rjwysocki.net>
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
X-VADE-SPAMCAUSE: dmFkZTFuZted3QHr/rVwZgdGLcyqu8jkWWOxJF0GFW6Lugmgslew6ZhSn6h88vs1LdILcIVV787TfB6M6b+mRXT06Ij8EuvQrp10ceSLb3/icU7F9n15O3KV4ZWbfWiZyZe7lKp46Kt5G4w0X6iG/QLBydyoV2uRCEgOh90bRqimATdZBJrd4z2/yhBk8j0kFroKeRxFh+++6Pm0zYnNO+67Y9BGSZG8pvisrWIP2dzOYTeG279fZhoGPFisKCoIs30GzEgjHE59fQU50or0qxeX+C1Q5vZyPw5H15xoPkQA8KS8pUUPZfsVou8ma7mTKBCGEr3OAYmA5L+5ao/is7OI/SPCMJPFNbpVH51K4SVwgX1OyPJjmkz/6ilkuSHvYl/eNd5pXwpwjGR0IMW2vPCbScPLVVb7IzR2vmhZA/dL9X3GueGB8XfBLC3QpvLMxKKUXyvf4Q2X9G7OoGYmF/do6cAA+jAd1sqwr2ve5o5/3IdDzo5FEdPuOgbq2HiUQl6fHyoqmLfSjkWMAuT3ncGK2B1ffv5Xo9rfNfWMfP+BQfWJtzGzxMRTB99cLJcpYlpEDy1ZQaBfHON6rHE0+p7HUm4aAiSFOE45miESMchymWGci3S6iYhV5FLQhexEvXl+05TNTOXoF/F3jvX/aDLTncDcW+fqrQgFRC5rpb6IFHeSBA
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 03f1444016b7 ("PM: sleep: Fix handling devices with direct_complete
set on errors") caused power.is_suspended to be set for devices with
power.direct_complete set, but it forgot to ensure the clearing of that
flag for them in device_resume(), so power.is_suspended is still set for
them during the next system suspend-resume cycle.

If that cycle is aborted in dpm_suspend(), the subsequent invocation of
dpm_resume() will trigger a device_resume() call for every device and
because power.is_suspended is set for the devices in question, they will
not be skipped by device_resume() as expected which causes scary error
messages to be logged (as appropriate).

To address this issue, move the clearing of power.is_suspended in
device_resume() immediately after the power.is_suspended check so it
will be always cleared for all devices processed by that function.

Fixes: 03f1444016b7 ("PM: sleep: Fix handling devices with direct_complete set on errors")
Reported-and-tested-by: Chris Bainbridge <chris.bainbridge@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -992,6 +992,8 @@
 	if (!dev->power.is_suspended)
 		goto Complete;
 
+	dev->power.is_suspended = false;
+
 	if (dev->power.direct_complete) {
 		/*
 		 * Allow new children to be added under the device after this
@@ -1054,7 +1056,6 @@
 
  End:
 	error = dpm_run_callback(callback, dev, state, info);
-	dev->power.is_suspended = false;
 
 	device_unlock(dev);
 	dpm_watchdog_clear(&wd);




