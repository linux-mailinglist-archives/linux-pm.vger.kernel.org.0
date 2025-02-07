Return-Path: <linux-pm+bounces-21576-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBA8A2D18C
	for <lists+linux-pm@lfdr.de>; Sat,  8 Feb 2025 00:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB23C16BD91
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 23:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAF21D90A5;
	Fri,  7 Feb 2025 23:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="JY53nUFb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B2A198E92
	for <linux-pm@vger.kernel.org>; Fri,  7 Feb 2025 23:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738971634; cv=none; b=BzG1mXNrpjdczdVvwLKvmzt4QwomJ3I0XdxXyGf/gGdy5BCWZZUFymBCYx9NuNSD2zsnamX+AlEHiRRNaeP4cMiMQJQNgDY0Gqd3/vL6QawycjowykFbUBT+NEXWlkRCs2BsW2yZjnTcw7qI02Q3c0ifOQWE8J9U0fX4UxxRVjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738971634; c=relaxed/simple;
	bh=k8zX/BJsd2gvIQvW3S6mUUj4yyBlqmPzoQA4ybErlIg=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=r7nou5o3XFowHOMuWoCRSy1TTLpWccWDXtcAXbwElc3uwuwWruYoNPNW/0CobYoE4ygp19+R2ku9VGL4mASn8yLHM4Bv2DY5GnOYHptKYJYKr91Bl35mvPjsCZqrreZ7/t+bdCTREFCC+7g3SydtuBTSUGh6ePJkoXso0Leo/II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=JY53nUFb; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fa1e25e337so2611255a91.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Feb 2025 15:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1738971631; x=1739576431; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=seEvp+GNhFdvGe8jMoPlpr7+Tkkc7kXjrZ/2tiBBxX0=;
        b=JY53nUFbTB0ZJESnms0rS7GhOLwCw9G+mIRBePiEMGH02mggnHKE87n85GdivXiDoz
         Dc0cpW8Pg/qA3UaSKm3O3Z0UVvxgPWT/4CQnk26+8RWznNy5m4oOUHwh0pPGQ26Pu77V
         zED3OiQgmkhV3toCgbT7xTdsk3Zhzy/9RRafasGNjOrZil6OkCxASxTa9icVun1jHZps
         LQms0WBnU2uMFlDJSQ+sshtWf9hGNugk/V5qHJVmz+xnNUO3abD+jEGSyGaR0BtpBmz9
         I90e42mGwVZMpkm3T3iqA1H0ham/TeEihFq8Fe5Wf/ssiG+SIGjxmpR8hY5R4gayz85F
         c2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738971631; x=1739576431;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=seEvp+GNhFdvGe8jMoPlpr7+Tkkc7kXjrZ/2tiBBxX0=;
        b=HdrdDsx6FAYyy2WY+EDUUqJRXM4t55Je3BD/ATWkhaMDK1yghgTCuNzKCfthjA1Vcd
         rmkal2Wpihwuh8Vp4fWS5bcEFGL9lgocjFgQZ5L50qTu+NF6OPfyQBcCx5ofQXFO4Bpt
         Mp9QH6QcwxnV0aVq9xF67r2dnG3uaAptBF0o6tTJH0+pBTyqftUOYlp2Iz6k4Jlv4m5I
         m1Lj7e7jTRul95KmKVNXLwRo34vXAvyOJY6w/fe/AeIwOU+6+GzXIaZCOtHtPovYatZ9
         8luF0c9eunLoKczuZLuK9oTAGceZI3X6zGfZ3otw8RrCR+COFI5sR/KZGfPjnGISxnLz
         pQhw==
X-Forwarded-Encrypted: i=1; AJvYcCUirgPaPwJjkJgtpKP/a/JOmnyfBnjhyvJcFhR1T2yh/MZMlDqNgiwHY6GvQT4LzXlEzHzrK8n7tg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDORKFi2KEV1y1L2OZw7tGCxHcIrXqqCsA3N3eDmqutPaXduzS
	58/Uv//erKSVK2y8wbHH4uTQqIX7KuiYjC3JYaYbnoiBGfJOObU3LEczZb40Dfs/0uxNsihi1mz
	J
X-Gm-Gg: ASbGnctk0bcy7T7qIDy1sSZFV/AsQY0ceWH1S04QrCHZPbEksJBF7rHrzVrL/QQoI0s
	n8Ul4cN+PcmHDsMpEKp8QrdAiReG03SPfMHvTdgvqad0RycpKB80mTKTb3e0fXtg87gmwTDpL9t
	GETn/EzYVAK7/pN4EJ8YlRDnXmmA6jkkCIQUCa0tHJ0RH1mRd5mUOe9OHC/uabGAVaBjVdOvraM
	xCR2cesVaRPjsWAGcLftSQHy7pNqHORgGm0MBLgi2b9vkuhl8PJGpT/lQzL4yvV3DjSvwMdQ4pF
	Yj+rVwBoEhDL2ipOeDSbKL14fN2Kb8Rg9Ns20SyzSzX3I1sLbVVKHrkz
X-Google-Smtp-Source: AGHT+IGd/aH8cZtY2w6U1R+ABgYZBDXNUWIDkmN/brsK896wGEYTV7m/771TCsqR7M9rL9p4q3r7Kw==
X-Received: by 2002:a17:90b:2317:b0:2fa:1029:f16a with SMTP id 98e67ed59e1d1-2fa243ee38cmr6982476a91.35.1738971631549;
        Fri, 07 Feb 2025 15:40:31 -0800 (PST)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09a72292sm3992338a91.27.2025.02.07.15.40.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Feb 2025 15:40:31 -0800 (PST)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: "'LKML'" <linux-kernel@vger.kernel.org>,
	"'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
	"'Christian Loehle'" <christian.loehle@arm.com>,
	"'Artem Bityutskiy'" <artem.bityutskiy@linux.intel.com>,
	"'Aboorva Devarajan'" <aboorvad@linux.ibm.com>,
	"Doug Smythies" <dsmythies@telus.net>,
	"'Linux PM'" <linux-pm@vger.kernel.org>
References: <12630185.O9o76ZdvQC@rjwysocki.net>
In-Reply-To: <12630185.O9o76ZdvQC@rjwysocki.net>
Subject: RE: [RFT][PATCH v1] cpuidle: teo: Avoid selecting deepest idle state over-eagerly
Date: Fri, 7 Feb 2025 15:40:33 -0800
Message-ID: <009d01db79b9$aecd1c70$0c675550$@telus.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQLC2T+pvcOY0U2G0e8FLXneTSytVLFtfD6A

Hi Rafael,

On 2025.02.04 12:58 Rafael J. Wysocki wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> It has been observed that the recent teo governor update which =
concluded
> with commit 16c8d7586c19 ("cpuidle: teo: Skip sleep length computation
> for low latency constraints") caused the max-jOPS score of the SPECjbb
> 2015 benchmark [1] on Intel Granite Rapids to decrease by around 1.4%.
> While it may be argued that this is not a significant increase, the
> previous score can be restored by tweaking the inequality used by teo
> to decide whether or not to preselect the deepest enabled idle state.
> That change also causes the critical-jOPS score of SPECjbb to increase
> by around 2%.
>
> Namely, the likelihood of selecting the deepest enabled idle state in
> teo on the platform in question has increased after commit =
13ed5c4a6d9c
> ("cpuidle: teo: Skip getting the sleep length if wakeups are very
> frequent") because some timer wakeups were previously counted as non-
> timer ones and they were effectively added to the left-hand side of =
the
> inequality deciding whether or not to preselect the deepest idle =
state.
>
> Many of them are now (accurately) counted as timer wakeups, so the =
left-
> hand side of that inequality is now effectively smaller in some cases,
> especially when timer wakeups often occur in the range below the =
target
> residency of the deepest enabled idle state and idle states with =
target
> residencies below CPUIDLE_FLAG_POLLING are often selected, but the
> majority of recent idle intervals are still above that value most of
> the time.  As a result, the deepest enabled idle state may be selected
> more often than it used to be selected in some cases.
>
> To counter that effect, add the sum of the hits metric for all of the
> idle states below the candidate one (which is the deepest enabled idle
> state at that point) to the left-hand side of the inequality mentioned
> above.  This will cause it to be more balanced because, in principle,
> putting both timer and non-timer wakeups on both sides of it is more
> consistent than only taking into account the timer wakeups in the =
range
> above the target residency of the deepest enabled idle state.
>
> Link: https://www.spec.org/jbb2015/
> Tested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/governors/teo.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -349,13 +349,13 @@
>         }
>
>         /*
> -        * If the sum of the intercepts metric for all of the idle =
states
> -        * shallower than the current candidate one (idx) is greater =
than the
> +        * If the sum of the intercepts and hits metric for all of the =
idle
> +        * states below the current candidate one (idx) is greater =
than the
>          * sum of the intercepts and hits metrics for the candidate =
state and
>          * all of the deeper states, a shallower idle state is likely =
to be a
>          * better choice.
>          */
> -       if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
> +       if (2 * (idx_intercept_sum + idx_hit_sum) > cpu_data->total) {
>                 int first_suitable_idx =3D idx;
>
>                 /*

I have only just started testing the recent idle governor changes,
and have not gotten very far yet.

There is a significant increase in processor package power during idle
with this patch, about 5 times increase (400%).

My processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz
Distro: Ubuntu 24.04.1, server, no desktop GUI.
CPU frequency scaling driver: intel_pstate
HWP: disabled.
CPU frequency scaling governor: performance

Idle states:
$ grep . /sys/devices/system/cpu/cpu0/cpuidle/state*/name
/sys/devices/system/cpu/cpu0/cpuidle/state0/name:POLL
/sys/devices/system/cpu/cpu0/cpuidle/state1/name:C1_ACPI
/sys/devices/system/cpu/cpu0/cpuidle/state2/name:C2_ACPI
/sys/devices/system/cpu/cpu0/cpuidle/state3/name:C3_ACPI

Test durations were >=3D 45 minutes each.

Kernel 6.14-rc1: Includes cpuidle: teo: Cleanups and very frequent =
wakeups handling update
Average Idle Power: teo governor: 2.199 watts (+25.51%)
Average Idle power: menu governor: 1.873 watts (+6.91%)

Kernel 6.14-rc1-p: Added this patch for teo and "cpuidle: menu: Avoid =
discarding useful information when processing recent idle intervals" for =
menu
Average Idle Power: teo governor: 9.401 watts (+436.6%)
Only 69.61% idle is in the deepest idle state. More typically it would =
be 98% to 99%.
28.6531% idle time is in state 1. More typically it would be 0.03%
Average Idle Power: menu governor: 1.820 watts (+3.9%)

Kernel 6.13: before "cpuidle: teo: Cleanups and very frequent wakeups =
handling update"
Average Idle Power: teo governor: 1.752 watts (reference: 0.0%)
Average Idle power: menu governor: 1.909 watts (+9.0%)

... Doug



