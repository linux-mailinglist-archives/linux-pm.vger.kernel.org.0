Return-Path: <linux-pm+bounces-37853-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 44874C539B9
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 18:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 687CE5073BA
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 16:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A63F33F39C;
	Wed, 12 Nov 2025 16:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qv45QM+K"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E6A311C3F;
	Wed, 12 Nov 2025 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762964778; cv=none; b=nvuHvNZ/hk/ceZx+mkDkjeF/E2GpI92v7iISe6Anf6EElREbh4zs8da7ROd8gchErpiODRG/GDBtrRwEGdiJWF/R5OgGDmKZ0VeVwhwaDCLpUmFXN9yw4GLezKmCHhjTTUgYTRdn0qtyBT+ljFmm4lw/wPU1wezKjTHxLJ+jI8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762964778; c=relaxed/simple;
	bh=+KJcaKn+U/rc32JmaM7bPoC8OfLHNM6eSE1qVL1tFpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ee1S3en4ZSaJMl5hqq8DaYp9lB3TZ+dh/jWX5ODpAQWKTVvcp9Ff4mkK8170kKY2V7WkVOhizF/jUIccogOAreZqdES7BIKj+lnMxOHYi6dUihTXpgorxJsytukxFe7vbKKgWNfmQHvPE2p2zSYxvEeutT5rYR7fWcQU6sfoYZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qv45QM+K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75323C113D0;
	Wed, 12 Nov 2025 16:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762964777;
	bh=+KJcaKn+U/rc32JmaM7bPoC8OfLHNM6eSE1qVL1tFpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qv45QM+KTf5sq3AKpE8a+TSBz8pIiHwCy1apOJm0n0fx5w7wBpvg66grwmEHF3Gwi
	 PiBca9RnMb3fX/T8OMFWrUrzcg26o/Kbz4SaZtAw031puwrru8TvhI2BD8LA8z+88L
	 EJuLjikldiHIQRIgAJ+xWJ/P3w7GICUEtCP8gyIa2UMCyeQumJDAqiDiM0PAcnhlMF
	 ExM9rsnUYTBDnIFJKdNi310E8d7xXZn8/oPmfwzH6Xq932tv4aB6XDWMw1b9xCRaq/
	 IXSym+gekIz8qYHpGby5rNMvCoGVx0/RIUv2KzXkMvghnicV/mglSmlYM5ZAlm/NNj
	 ah/TbjBsJXh3A==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>,
 Christian Loehle <christian.loehle@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Reka Norman <rekanorman@chromium.org>
Subject:
 [PATCH v1 2/4] cpuidle: governors: teo: Drop redundant function parameter
Date: Wed, 12 Nov 2025 17:23:24 +0100
Message-ID: <2253109.irdbgypaU6@rafael.j.wysocki>
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

The last no_poll parameter of teo_find_shallower_state() is always
false, so drop it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -239,17 +239,15 @@ static bool teo_state_ok(int i, struct c
  * @dev: Target CPU.
  * @state_idx: Index of the capping idle state.
  * @duration_ns: Idle duration value to match.
- * @no_poll: Don't consider polling states.
  */
 static int teo_find_shallower_state(struct cpuidle_driver *drv,
 				    struct cpuidle_device *dev, int state_idx,
-				    s64 duration_ns, bool no_poll)
+				    s64 duration_ns)
 {
 	int i;
 
 	for (i = state_idx - 1; i >= 0; i--) {
-		if (dev->states_usage[i].disable ||
-				(no_poll && drv->states[i].flags & CPUIDLE_FLAG_POLLING))
+		if (dev->states_usage[i].disable)
 			continue;
 
 		state_idx = i;
@@ -459,7 +457,7 @@ static int teo_select(struct cpuidle_dri
 	 * candidate state, a shallower one needs to be found.
 	 */
 	if (drv->states[idx].target_residency_ns > duration_ns)
-		idx = teo_find_shallower_state(drv, dev, idx, duration_ns, false);
+		idx = teo_find_shallower_state(drv, dev, idx, duration_ns);
 
 	/*
 	 * If the selected state's target residency is below the tick length
@@ -487,7 +485,7 @@ end:
 	 */
 	if (idx > idx0 &&
 	    drv->states[idx].target_residency_ns > delta_tick)
-		idx = teo_find_shallower_state(drv, dev, idx, delta_tick, false);
+		idx = teo_find_shallower_state(drv, dev, idx, delta_tick);
 
 out_tick:
 	*stop_tick = false;




