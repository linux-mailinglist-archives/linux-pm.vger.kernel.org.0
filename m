Return-Path: <linux-pm+bounces-37956-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D718C57CCB
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 14:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A27B34A4E45
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 13:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944EB351FBA;
	Thu, 13 Nov 2025 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDUmRthq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDB43446AA;
	Thu, 13 Nov 2025 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040276; cv=none; b=C27PrbZYVc2BxlcSyB+twEc20BvWeed9ozUqO4kOtJpS2O899bpqXxXN2ZahnFfBp5qbjzevpWKpxwYhA/Z3xVaLtb7qi9gECipZruZssCcFAWVMT2PqtF9hpnU1xkczmdwYX1aZbI/s1DM2X8ljuvX1oXHXP4oZa/prBkDRI4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040276; c=relaxed/simple;
	bh=OVlfDob210xkBYPcrnR/Kfy4T4yeohtxEqflJ1gh0rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eE+zk8glJ7vsUDqPFKj7GmFZMhjV43j75YN5w/wBVyLYWhvML5Ec0hRmUk9mVRa+KF7vkHIMrTxDcjmvW9lAA+67cCvU0XXE1V0JC9kz1do/COaKJrxeCAoeiVwwEP0+Y6eJrKEgFRTJJBfxzNOFvRe+DIGfVwBZq44zBd7cnYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDUmRthq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A165C4CEFB;
	Thu, 13 Nov 2025 13:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763040275;
	bh=OVlfDob210xkBYPcrnR/Kfy4T4yeohtxEqflJ1gh0rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EDUmRthqMCW49fs/aqdy1TYnjLXr/3cQveQtaZ637a6Zb8064y0oOc75Mf5clyBkK
	 H2Flzt99PQ+qAeY+3xms3zdc209/qgd4XjBaoIlmoDSB8tIvOHa57UHrg600S3gOJM
	 wDKmzGadGGbz6KSnXQXNHSoh8cE1uPuCGsMY489O5JWRiJzFuQq/U0nQ7tHYvjpUyX
	 0tUNPI8KIllS+UQ0E/wRJT0lwOO6frDo/GMFGIBNLauCslZ6Wis4L3UwFs9x6YWQUR
	 CPdyspYkATs2jPzC/AnsamcJfnTc7UWVsVkcrRdSeinWTxsAreC3hlBebntGxzZXEm
	 qUDtii7kf62sQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>,
 Christian Loehle <christian.loehle@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Reka Norman <rekanorman@chromium.org>
Subject:
 [PATCH v2 1/4] cpuidle: governors: teo: Drop misguided target residency check
Date: Thu, 13 Nov 2025 14:24:31 +0100
Message-ID: <5955081.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5035693.GXAFRqVoOG@rafael.j.wysocki>
References:
 <4701737.LvFx2qVVIh@rafael.j.wysocki> <5035693.GXAFRqVoOG@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

When the target residency of the current candidate idle state is
greater than the expected time till the closest timer (the sleep
length), it does not matter whether or not the tick has already been
stopped or if it is going to be stopped.  The closest timer will
trigger anyway at its due time, so if an idle state with target
residency above the sleep length is selected, energy will be wasted
and there may be excess latency.

Of course, if the closest timer were canceled before it could trigger,
a deeper idle state would be more suitable, but this is not expected
to happen (generally speaking, hrtimers are not expected to be
canceled as a rule).

Accordingly, the teo_state_ok() check done in that case causes energy to
be wasted more often than it allows any energy to be saved (if it allows
any energy to be saved at all), so drop it and let the governor use the
teo_find_shallower_state() return value as the new candidate idle state
index.

Fixes: 21d28cd2fa5f ("cpuidle: teo: Do not call tick_nohz_get_sleep_length() upfront")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Subject and changelog modifications

---
 drivers/cpuidle/governors/teo.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -458,11 +458,8 @@ static int teo_select(struct cpuidle_dri
 	 * If the closest expected timer is before the target residency of the
 	 * candidate state, a shallower one needs to be found.
 	 */
-	if (drv->states[idx].target_residency_ns > duration_ns) {
-		i = teo_find_shallower_state(drv, dev, idx, duration_ns, false);
-		if (teo_state_ok(i, drv))
-			idx = i;
-	}
+	if (drv->states[idx].target_residency_ns > duration_ns)
+		idx = teo_find_shallower_state(drv, dev, idx, duration_ns, false);
 
 	/*
 	 * If the selected state's target residency is below the tick length




