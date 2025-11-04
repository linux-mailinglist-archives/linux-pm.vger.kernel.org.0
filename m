Return-Path: <linux-pm+bounces-37348-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3F0C302CC
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 10:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01206188A5FC
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 09:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEB3303A1E;
	Tue,  4 Nov 2025 09:03:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D801E2BCF41
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 09:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247015; cv=none; b=Ph3F9s7BdnaR/cqcYY7QYgjJ7VdpTiWdalgiYHRnw5SdtSHsUG1rUHczbBScPGdNsrJd2MjKZY2UOsx9Xbqh/JkQZ5Mzm5c8NWw8opbC1BSulXVVsu8nShx631ASBOOmeAjJI4aIqvJD21V0nOZKKqVXChfQM0jwfDHF70xBns0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247015; c=relaxed/simple;
	bh=CpMgZI3tIctxwOsye53T3mLvqMINaG1S4mVML9M95WQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bz4TLGWEe9++Jt8SMBCuPDlrId634NKKWEs9T02rl23A3doHzmrY48L/UXsdGX+P9sAoA/peltPte7RpCt4H2V/cJtJ7OwAKL7mqgZvrTlqFJx5AnwzkC3HIg8eKbgoioHhcY98H9GuMKoqLay7clT0XHBzPruanbaaOUfWrQb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60B921CE0;
	Tue,  4 Nov 2025 01:03:23 -0800 (PST)
Received: from [10.1.38.32] (e127648.arm.com [10.1.38.32])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 322673F63F;
	Tue,  4 Nov 2025 01:03:29 -0800 (PST)
Message-ID: <a50064b2-e6aa-4237-a715-12f21a65e9a6@arm.com>
Date: Tue, 4 Nov 2025 09:03:28 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression in TEO cpuidle governor between 6.6 and 6.12
To: Reka Norman <rekanorman@chromium.org>, rafael@kernel.org
Cc: daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
References: <CAEmPcwsNMNnNXuxgvHTQ93Mx-q3Oz9U57THQsU_qdcCx1m4w5g@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAEmPcwsNMNnNXuxgvHTQ93Mx-q3Oz9U57THQsU_qdcCx1m4w5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/4/25 03:36, Reka Norman wrote:
> Hi,
> 
> I’m seeing a regression in the TEO governor between 6.6 and 6.12. At
> 6.12, when the system is idle it’s spending almost 100% of time in
> WFI, compared to about 6% at 6.6. At mainline it has improved compared
> to 6.12 but is still a lot worse than 6.6, spending about 50% in WFI.
> 
> The system is a ChromeOS device with Mediatek MT8196.
> 
> Bisecting showed the specific commit which caused the regression is:
> 4b20b07ce72f ("cpuidle: teo: Don't count non-existent intercepts")
> 
> I’ve attached sysfs dumps showing the issue. All were taken a couple
> of minutes after boot, with the device having been idle since boot.
> The cases tested are:
> cpuidle_6_6.txt      = 6.6 kernel
> cpuidle_6_12.txt     = 6.6 kernel with teo commits up to 6.12
> cpuidle_mainline.txt = 6.6 kernel with teo commits up to mainline
> 
> Summary of the percentage time spent in each state (averaged across CPUs):
> 
> |            |   6.6 |  6.12 | mainline |
> |------------|------:|------:|---------:|
> | WFI        |  6.02 | 99.94 |    56.84 |
> | cpuoff     | 11.02 |     0 |     0.65 |
> | clusteroff | 82.96 |  0.05 |    42.51 |
> | s2idle     |     0 |     0 |        0 |
> 
> Any help would be much appreciated. Let me know if there's any other
> debugging information I should provide.
> 

That's not good.
If the system is mostly idle (only boot activity but dumps are taken after
~3mins?), what is causing the wakeups? Even in 6.6 There are definitely more
than I would've expected?
I noticed that clusteroff and cpuoff have equal residency, which is
obviously a bit awkward for cpuidle, but shouldn't be relevant to your issue.

I'm a bit puzzled by your bisect results.
4b20b07ce72f ("cpuidle: teo: Don't count non-existent intercepts")
made the intercept logic *less* prone to count (false) intercepts, yet it
seems to count more of them? (resulting in more WFI).
I'll think about it some more, for now of course a trace would be very
helpful. (cpuidle events, ipi_raise, irqs?)
Are there ever any latency constraints set?

FWIW the mainline results look the most reasonable, from a 30000 feet view
anyway:
Cluster	State		above	below	usage	above%	below%
LITTLE	cpuoff-l	~75	~65	~140	23%	20%
LITTLE	clusteroff-l	~800	0	~100	89%	0%
MID	cpuoff-m	~3–4	~15	~20	15%	55%
MID	clusteroff-m	~1300	0	~4000	24%	0%
BIG	cpuoff-b	0	1	1	—	—
BIG	clusteroff-b	~800	0	~1900	30%	0%

(WFI seems mostly the correct choice for little CPUs, that's fine, the energy
savings compared to cpuoff should be marginal anyway.)

Do you mind trying:
13ed5c4a6d9c cpuidle: teo: Skip getting the sleep length if wakeups are very frequent
on 6.12?

I'd also be curious what this looks like without the intercept logic:

Something like:
-----8<-----


--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -348,71 +348,6 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
                goto end;
        }
 
-       /*
-        * If the sum of the intercepts metric for all of the idle states
-        * shallower than the current candidate one (idx) is greater than the
-        * sum of the intercepts and hits metrics for the candidate state and
-        * all of the deeper states, a shallower idle state is likely to be a
-        * better choice.
-        */
-       if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
-               int first_suitable_idx = idx;
-
-               /*
-                * Look for the deepest idle state whose target residency had
-                * not exceeded the idle duration in over a half of the relevant
-                * cases in the past.
-                *
-                * Take the possible duration limitation present if the tick
-                * has been stopped already into account.
-                */
-               intercept_sum = 0;
-
-               for (i = idx - 1; i >= 0; i--) {
-                       struct teo_bin *bin = &cpu_data->state_bins[i];
-
-                       intercept_sum += bin->intercepts;
-
-                       if (2 * intercept_sum > idx_intercept_sum) {
-                               /*
-                                * Use the current state unless it is too
-                                * shallow or disabled, in which case take the
-                                * first enabled state that is deep enough.
-                                */
-                               if (teo_state_ok(i, drv) &&
-                                   !dev->states_usage[i].disable) {
-                                       idx = i;
-                                       break;
-                               }
-                               idx = first_suitable_idx;
-                               break;
-                       }
-
-                       if (dev->states_usage[i].disable)
-                               continue;
-
-                       if (teo_state_ok(i, drv)) {
-                               /*
-                                * The current state is deep enough, but still
-                                * there may be a better one.
-                                */
-                               first_suitable_idx = i;
-                               continue;
-                       }
-
-                       /*
-                        * The current state is too shallow, so if no suitable
-                        * states other than the initial candidate have been
-                        * found, give up (the remaining states to check are
-                        * shallower still), but otherwise the first suitable
-                        * state other than the initial candidate may turn out
-                        * to be preferable.
-                        */
-                       if (first_suitable_idx == idx)
-                               break;
-               }
-       }
-


