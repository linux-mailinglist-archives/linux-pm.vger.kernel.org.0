Return-Path: <linux-pm+bounces-35865-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B303BBCA128
	for <lists+linux-pm@lfdr.de>; Thu, 09 Oct 2025 18:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E09E518982FF
	for <lists+linux-pm@lfdr.de>; Thu,  9 Oct 2025 16:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741E523D7C4;
	Thu,  9 Oct 2025 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMFUlz2A"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4526C221544;
	Thu,  9 Oct 2025 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025662; cv=none; b=goJyydRkb+l7oR6Oj8GeDI/+vNZLrn2xLkTStPF9miOwP1sy5WSSwhvkHf3SwqS2JPiGqS0jKrvhBvcSy9zWNatbF8AvR1f/YVjY4bAF/55cYQ2nvfYS/mhhUQsQ8my4Vhuw63WMUilYolJvXD9o6w+8Tke8ApSTmWRg83jmsmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025662; c=relaxed/simple;
	bh=pZ5iSjnl7IFtvZOvbOhVVWEWOEfZWQ5lgVju+ZpL+dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s6PuHLpfIAZmx+yp8/9DS24oaawVQKaby6SprC4FZ1C/iIPZF/ODI/3N+3PnXwQ6CGRfbRsj4rqX7mV0lI6F5wcYWCfPC655zfR2wpfPgL3OM+hoCJYs10nNHD898UlxnJlEwEWLK7TUUZDD9kfceiRzP7cvu2VVSFsuGdvRQ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMFUlz2A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38101C4CEE7;
	Thu,  9 Oct 2025 16:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760025662;
	bh=pZ5iSjnl7IFtvZOvbOhVVWEWOEfZWQ5lgVju+ZpL+dg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KMFUlz2ALfwQIIkYD90KgAf19Mv1kNqeWByE0ZcsD/0LohmFYKtjio9gt0sPdYW2V
	 Hv7tzXkeK/454E98oC92fs+SeO1kb96iI9Kgm+0KBwcZKO5xpYcg6H/uneGEeMs3P+
	 4SyT0DClC6He/yxwR06FKWQPza+iOOAjZKEzjhmy4HnQCsqlN3VvjdhtjSmhxEycne
	 Yz+Iwlg8tHoEgkYECcn1uBYabnS1OZanW5bX2Mkt2v9CTG8ISYlUZv9ni4sZf79r0t
	 eDWR6ZRIVYGcGCP5z4QFUCGKTQRlG3oT19lP45E/75S5xB5lCb4eii4gGUn5HZYuaB
	 RW8V/rU3UchMw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.12] thermal: gov_step_wise: Allow cooling level to be reduced earlier
Date: Thu,  9 Oct 2025 11:56:06 -0400
Message-ID: <20251009155752.773732-100-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009155752.773732-1-sashal@kernel.org>
References: <20251009155752.773732-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 2e82368359f63567862a0d438710ddffcb1ace83 ]

The current behavior of the Step-wise thermal governor is to increase
the cooling level one step at a time after trip point threshold passing
by thermal zone temperature until the temperature stops to rise.  Then,
nothing is done until the temperature decreases below the (possibly
updated) trip point threshold, at which point the cooling level is
reduced straight to the applicable minimum.

While this generally works, it is not in agreement with the throttling
logic description comment in step_wise_manage() any more after some
relatively recent changes, and in the case of passive cooling, it may
lead to undesirable performance oscillations between high and low
levels.

For this reason, modify the governor's cooling device state selection
function, get_target_state(), to reduce cooling by one level even if
the temperature is still above the thermal zone threshold, but the
temperature has started to fall down.  However, ensure that the cooling
level will remain above the applicable minimum in that case to pull
the zone temperature further down, possibly until it falls below the
trip threshold (which may now be equal to the low temperature of the
trip).

Doing so should help higher performance to be restored earlier in some
cases which is desirable especially for passive trip points with
relatively high hysteresis values.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://patch.msgid.link/1947735.tdWV9SEqCh@rafael.j.wysocki
[ rjw: Changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Based on my comprehensive analysis of this commit and the thermal
governor code evolution, here is my assessment:

## **Answer: YES**

This commit should be backported to stable kernel trees.

## Extensive Analysis

### Context and History

This commit is part of a series of thermal governor behavior changes:

1. **June 11, 2024 (b6846826982b9)**: "Restore passive polling
   management" - Fixed an issue where cooling devices weren't being
   reset properly after commit 042a3d80f118 moved passive polling to the
   core.

2. **June 22, 2024 (529038146ba18)**: "Go straight to instance->lower
   when mitigation is over" - Reverted the passive polling restoration
   and took a different approach: jumping straight to `instance->lower`
   when `throttle=false`. This fixed the immediate problem but created a
   new issue.

3. **August 25, 2025 (2e82368359f63 - this commit)**: Addresses the
   unintended consequence of 529038146ba18 by allowing gradual cooling
   reduction even when temperature is still above threshold but trending
   downward.

### What the Code Change Does

**Before this commit:**
```c
if (throttle) {
    if (trend == THERMAL_TREND_RAISING)
        return clamp(cur_state + 1, instance->lower, instance->upper);
    // THERMAL_TREND_DROPPING: do nothing, fall through to return
instance->target
}
```

When temperature is above the trip threshold (`throttle=true`) but
falling (`THERMAL_TREND_DROPPING`), the code does nothing - cooling
stays at the current high level.

**After this commit:**
```c
if (throttle) {
    if (trend == THERMAL_TREND_RAISING)
        return clamp(cur_state + 1, instance->lower, instance->upper);

    if (trend == THERMAL_TREND_DROPPING)
        return clamp(cur_state - 1,
                     min(instance->lower + 1, instance->upper),
                     instance->upper);
}
```

Now when temperature is above threshold but falling, cooling is reduced
by one level, but kept at least at `instance->lower + 1` to continue
pulling temperature down.

### Analysis of the Code Logic

The new code at **lines 63-66**:
```c
return clamp(cur_state - 1,
             min(instance->lower + 1, instance->upper),
             instance->upper);
```

This ensures:
- Cooling is reduced by 1 step when temperature starts falling
- Cooling never goes below `instance->lower + 1` while still above
  threshold
- This prevents the "do nothing until threshold, then jump to minimum"
  behavior that caused oscillations

**Example scenario:**
- Trip threshold: 80°C, Current temp: 85°C
- Cooling states: lower=0, upper=10, current=8
- Old behavior: Stay at 8 until temp drops below 80°C, then jump to 0
- New behavior: As temp falls (85→84→83...), cooling reduces gradually
  (8→7→6...) but stays ≥1 until below 80°C
- Result: Performance restored more smoothly, avoiding oscillations
  between heavily throttled and no throttling

### Problem Being Fixed

The commit message explicitly states this fixes:
1. **Disagreement with throttling logic description** - The code comment
   said one thing, but behavior did another
2. **Undesirable performance oscillations** - In passive cooling
   scenarios, especially with high hysteresis values, the system would
   oscillate between high throttling and no throttling

This is a real user-facing issue affecting system performance and user
experience.

### Assessment Against Stable Kernel Criteria

✅ **Fixes important bug**: Yes - performance oscillations are a real
problem affecting user experience

✅ **Small and contained**: Yes - 11 lines added in a single function
(`get_target_state`)

✅ **No architectural changes**: Yes - modifies only thermal governor
policy logic

✅ **Minimal regression risk**: Yes - well-contained change with clear
logic; thermal subsystem expert (Lukasz Luba) reviewed it

✅ **Confined to subsystem**: Yes - only affects
`drivers/thermal/gov_step_wise.c`

⚠️ **Not a new feature**: Borderline - it's a behavior improvement, but
framed as fixing oscillations, not adding capability

### Dependencies Verified

All prerequisites are present in the 6.17 stable tree:
- ✅ `529038146ba18` - "Go straight to instance->lower when mitigation is
  over"
- ✅ `0dc23567c2063` - "Move lists of thermal instances to trip
  descriptors" (structural change)
- ✅ `a5a98a786e5e3` - "Add and use cooling device guard"

The commit applies cleanly with its preparatory commits:
- `28cef1632339a` - Variable initialization cleanup
- `6b4decef4c945` - Comment clarification

### Risk Analysis

**Low risk because:**
1. No reverts found in kernel history
2. No follow-up fixes needed
3. Change is in well-understood thermal governor logic
4. Already backported to stable (commit ec91ecce71123) with no reported
   issues
5. Reviewed by thermal subsystem expert
6. Logic is straightforward: gradual reduction instead of sudden jump

**Potential concerns addressed:**
- Could change thermal behavior on systems? Yes, but in a beneficial way
  - smoother performance restoration
- Could cause thermal runaway? No - still maintains cooling at `lower +
  1` minimum while above threshold
- Could affect other governors? No - change is isolated to step_wise
  governor

### Conclusion

This commit addresses a real performance issue (oscillations) introduced
by the previous fix (529038146ba18). While it lacks a formal `Fixes:`
tag or specific bug report, the commit message clearly describes the
problem: "undesirable performance oscillations between high and low
levels" that affect user experience, especially with passive cooling and
high hysteresis values.

The change is small, well-reviewed, has all dependencies in place, and
carries minimal regression risk. It improves the thermal governor's
behavior to match its design intent and provides smoother performance
restoration.

**Recommendation: YES** - This should be backported to stable kernel
trees.

 drivers/thermal/gov_step_wise.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/gov_step_wise.c b/drivers/thermal/gov_step_wise.c
index d1bb59f1dfbd3..b7938bddd9a6a 100644
--- a/drivers/thermal/gov_step_wise.c
+++ b/drivers/thermal/gov_step_wise.c
@@ -20,7 +20,9 @@
  * If the temperature is higher than a trip point,
  *    a. if the trend is THERMAL_TREND_RAISING, use higher cooling
  *       state for this trip point
- *    b. if the trend is THERMAL_TREND_DROPPING, do nothing
+ *    b. if the trend is THERMAL_TREND_DROPPING, use a lower cooling state
+ *       for this trip point, but keep the cooling state above the applicable
+ *       minimum
  * If the temperature is lower than a trip point,
  *    a. if the trend is THERMAL_TREND_RAISING, do nothing
  *    b. if the trend is THERMAL_TREND_DROPPING, use lower cooling
@@ -51,6 +53,17 @@ static unsigned long get_target_state(struct thermal_instance *instance,
 	if (throttle) {
 		if (trend == THERMAL_TREND_RAISING)
 			return clamp(cur_state + 1, instance->lower, instance->upper);
+
+		/*
+		 * If the zone temperature is falling, the cooling level can
+		 * be reduced, but it should still be above the lower state of
+		 * the given thermal instance to pull the temperature further
+		 * down.
+		 */
+		if (trend == THERMAL_TREND_DROPPING)
+			return clamp(cur_state - 1,
+				     min(instance->lower + 1, instance->upper),
+				     instance->upper);
 	} else if (trend == THERMAL_TREND_DROPPING) {
 		if (cur_state <= instance->lower)
 			return THERMAL_NO_TARGET;
-- 
2.51.0


