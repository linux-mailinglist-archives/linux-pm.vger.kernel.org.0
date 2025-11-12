Return-Path: <linux-pm+bounces-37854-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAF6C5382B
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 17:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0609B5058D8
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 16:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D54E341AD8;
	Wed, 12 Nov 2025 16:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mB1mQh+t"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39D2341AC6;
	Wed, 12 Nov 2025 16:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762964781; cv=none; b=reDt0kiU5NLs3ysIHyduc1bXLcSqT14M36PbwoVHPJBfPVk4Hb3CF0H+Sx3cTaocVE+ZhdqVjNdEYUphUbqvNqhIgJukXLyB7kKm4TbJKm18VIGIduRPCEknMR9DafJZ7AcqV1kyafTScMqCuwB3JmxuYgs9Dhr3h8WhU6H39zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762964781; c=relaxed/simple;
	bh=O2u1JkKSRWyTtHiZkB6M/me8YBPi6rG9qMh6BMXmUr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rv7aR/LuCVX4YeimSLCsrB47jcT3X9EZyVyDj1Slax+x8WQQKrPcwqk8JUkXM/WalHNrVXB5NoBi+WsEPr3kW+/IZfRFP3PA+EVdKkj0rlJHH3ES1L9aVLTyzX/h0uzhralWHtARGxJmwA+AUMYr29eQI9Wer/EhxpyvRoNUsOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mB1mQh+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A575C19421;
	Wed, 12 Nov 2025 16:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762964781;
	bh=O2u1JkKSRWyTtHiZkB6M/me8YBPi6rG9qMh6BMXmUr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mB1mQh+t5asl6pwzNwUjGfdqeY7ZWBtsbbFNd0zEAxBHS0mFXnFHZBzlfuoSHm0on
	 3LIhridCUm2uXDwD8FAoxZ9lfm7GkjrW8n8LOvDnxZLeX4gILFGH0lBOGYL9igSsWa
	 J57XCfKiOp92+5TNMZw/cqk6lzhs/3F0q7lI9VHlALPOevq2lIodt1YYPvNbiGsGm8
	 kMUMi4hk/+A2SlGkJoEqg3iERudNqyvJ4lAovFjKh5eCi2SvH2inm78ZbDHemfssTY
	 7eLoyFKzP1u7SQbrXg+y3K84UvT7TnUBtEDmojGdfza7lSx2rZhCZNgaVMQq6ednJp
	 v+FFbdti9AOZg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>,
 Christian Loehle <christian.loehle@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Reka Norman <rekanorman@chromium.org>
Subject:
 [PATCH v1 1/4] cpuidle: governors: teo: Drop incorrect target residency check
Date: Wed, 12 Nov 2025 17:22:30 +0100
Message-ID: <5035693.GXAFRqVoOG@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <4701737.LvFx2qVVIh@rafael.j.wysocki>
References: <4701737.LvFx2qVVIh@rafael.j.wysocki>
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
length), it does not matter whether or not the tick has already
been stopped or if it is going to be stopped.  The closest timer
will trigger anyway at its due time, so it does not make sense to
select an idle state with target residency above the sleep length.

Accordingly, drop the teo_state_ok() check done in that case and
let the governor use the teo_find_shallower_state() return value
as the new candidate idle state index.

Fixes: 21d28cd2fa5f ("cpuidle: teo: Do not call tick_nohz_get_sleep_length() upfront")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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




