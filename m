Return-Path: <linux-pm+bounces-36744-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44327C024D4
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 18:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61F513A1B29
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 16:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF9526E165;
	Thu, 23 Oct 2025 16:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="h5gBVAcR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DCE2494D8
	for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 16:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235382; cv=none; b=KKWM2tYvDiMta4jPelkacGQWEeAR87FHOsKB/MLWsJmgrCLGwOb0Rd09xh2qjRCQKc00kLLsVLlFbNEOjbzveDNHsHTjKX0qiIrYNKw15ZUZY3PdrxClNwMk+rORnH3/iRZgexHBb27l96ia6raQZBCecJRog28T6eqB0sPgY/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235382; c=relaxed/simple;
	bh=0T40hKL26YolCQLnSKyrMR+Bn6Jtsl61c5TdM8zx1cU=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=bhp4zFHL3bplN9FugUR10vqBYnFyPcZOMhmNFcB8xYY7GP+1XpgphzNYkQou2IpvxCxfKnLElGDUh9T3sgqVOmEuFdfrtz9xc9cUyCR8pCtlWc/wjG691QUUEF7xJVo/7jcE6I2BaBCcJ8ypUDawGfu0AiTPNrbPi33A5aNay54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=h5gBVAcR; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7a27ab05a2dso655031b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 09:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1761235380; x=1761840180; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JH/e1IwTn9e6m+oKiv8OxIW1/g/8aOTw78lb+wUnrjs=;
        b=h5gBVAcRfECI+2e7VzYBsITH7sOL8JUDpVx5uOgTdnG40wXbEblSR8v6v9ICxTCX6r
         hucMxHUrcjaCV9oXVdEZUVC/tbglXsBY/F6aTnAE9XWijToJMXAsf1Yq/v98JCFMWy7w
         Apgwa6jn1Kio5JiX9aVYrFhaMGRcOUMt1wLrl7w9deQqQJ6jagpGU9cqxiDDWztsJf+L
         8bsHdLYiSQqEs+0qDUUC4sLPjfHUm+o9We3iZyI3KV2sestiIFwz7ZAIyT/d8sFtANfk
         SjwXWNjy3Zjt90vCqO4+/K2Fl0KVvNuryxFQ6hRstLQL4etUVKc2Ns1KUZkOgJgTBQT+
         J0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761235380; x=1761840180;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JH/e1IwTn9e6m+oKiv8OxIW1/g/8aOTw78lb+wUnrjs=;
        b=GZvMf9Yr7cJKzYqBNS2s2utGCuwLR+SovtLjOI7Adz7YMGKJMd1X4yicjtlJxvvp1F
         /VWKmMZpD4Kp7ExaqFyBGWKu310wQVTfs/JL1UK22M62cEXq50bio+XXZ2xPKMw1bsRf
         3byDlgkHblF0qcqCNvHggGqbGG158+uOtKARWKNCur2T6uagLlPjaQUWIRyGHO5yFBZq
         VhPmPefmGWA24GhhDge2+/Dz0dskQfhrPSPgG8f7aSApVld0oVwTVaCBhyb9aSxGkoC8
         04l73dZaaQfUViMwPt1WIlCvauaqdUUxa8TDwO2PMcYF5T8be9V+j8vskHX1HeCiR6tC
         EPBA==
X-Forwarded-Encrypted: i=1; AJvYcCU+tlESsOaQJNsiBCBc4sMg1Ep67P3VTFrhIjpRWtSCNPHhAT0TTKpohkUfGPliu/TCzo2f14saWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDIM9Lm+dxjNk7SGDJuiGjwa5q4NKccKMVCf4+opTxlaySTeu/
	A6DKjLssRSBBf21+3OE1EG4QYYLphPSUh3G1uVT08AG8meL+nkiOjF/pQiBKZM4msWnQOexzRWN
	GrJTq
X-Gm-Gg: ASbGncu9/NGPVOSCZVev3dYwfQZBmDS3lkulHFaVNpFeS9px1JUFy7pMMTYJLffmJ/N
	WeixOgLUXgv9i/tS1M0FoL17/Mkrx9raP4JKKZ6uRl5VXhFKnKnpjLCmyQyJwIrvSBTyT7V09U9
	ZkDJ0YeqEiqRLKqVp0/UFusyvW9C58zzLzniSXf5Ytf4HOJ9c1bvI/EuoR24d6pbesVIHrj5Vit
	+cmIeBkm6snxE4+2Po2CdcKBEqdt51ZQ2fKiDY6UXm8BzLDD8Az0fqOZXCMxHPXWrQYW+QYQjHD
	na6H2A/Zm6Sy7lCTnoNSRhMwIkihEhPHQwk9A44PMIWOEhaP7f2jY7IrTUYd3sy0p7r6tcs+3tH
	vDYNsuEm32PsKW+PIfXKmj+RcFm3OtVbWJCoZaDjUVhsgBh80mSlQsfxZ4+8NPblJYdiJqtvI4B
	ZwA0aec+c4YcgJPiW7kpjt3QrmHN1btGOUXxCwrAnrclah
X-Google-Smtp-Source: AGHT+IHa6CnmrO8xJXDnGny1Z43wB3uTWDalpzMKHlkKpTQZZnEYpOXUYPsP9QurSz3gT7q6oOes7g==
X-Received: by 2002:a05:6a00:93d7:b0:7a2:6db4:4c81 with SMTP id d2e1a72fcca58-7a26db44de0mr4051337b3a.3.1761235378739;
        Thu, 23 Oct 2025 09:02:58 -0700 (PDT)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274a9cec5sm2992577b3a.20.2025.10.23.09.02.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Oct 2025 09:02:58 -0700 (PDT)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: "'Frederic Weisbecker'" <frederic@kernel.org>,
	"'LKML'" <linux-kernel@vger.kernel.org>,
	"'Peter Zijlstra'" <peterz@infradead.org>,
	"'Christian Loehle'" <christian.loehle@arm.com>,
	"'Linux PM'" <linux-pm@vger.kernel.org>,
	"Doug Smythies" <dsmythies@telus.net>
References: <2804546.mvXUDI8C0e@rafael.j.wysocki> <5043159.31r3eYUQgx@rafael.j.wysocki> <004501dc43c9$ec8aa930$c59ffb90$@telus.net> <5040239.GXAFRqVoOG@rafael.j.wysocki>
In-Reply-To: <5040239.GXAFRqVoOG@rafael.j.wysocki>
Subject: RE: [PATCH v1 1/3] cpuidle: governors: menu: Avoid selecting states with too much latency
Date: Thu, 23 Oct 2025 09:02:57 -0700
Message-ID: <001a01dc4436$80b80aa0$82281fe0$@telus.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFe4hIXA7yjTyFTeu7yKR6UgyMZTANsg+YRAdzC7nACxm/pQLWKKQyg

On 2025.10.23 07:51 Rafael wrote:

> Hi Doug,
>
> On Thursday, October 23, 2025 5:05:44 AM CEST Doug Smythies wrote:
>> Hi Rafael,
>> 
>> Recent email communications about other patches had me
>> looking at this one again. 
>> 
>> On 2025.08.13 03:26 Rafael wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>> ... snip...
>> 
>>> However, after the above change, latency_req cannot take the predicted_ns
>>> value any more, which takes place after commit 38f83090f515 ("cpuidle:
>>> menu: Remove iowait influence"), because it may cause a polling state
>>> to be returned prematurely.
>>>
>>> In the context of the previous example say that predicted_ns is 3000 and
>>> the PM QoS latency limit is still 20 us.  Additionally, say that idle
>>> state 0 is a polling one.  Moving the exit_latency_ns check before the
>>> target_residency_ns one causes the loop to terminate in the second
>>> iteration, before the target_residency_ns check, so idle state 0 will be
>>> returned even though previously state 1 would be returned if there were
>>> no imminent timers.
>>>
>>> For this reason, remove the assignment of the predicted_ns value to
>>> latency_req from the code.
>> 
>> Which is okay for timer-based workflow,
>> but what about non-timer based, or interrupt driven, workflow?
>> 
>> Under conditions where idle state 0, or Polling, would be used a lot,
>> I am observing about a 11 % throughput regression with this patch
>> And idle state 0, polling, usage going from 20% to 0%. 
>> 
>> From my testing of kernels 6.17-rc1, rc2,rc3 in August and September
>> and again now. I missed this in August/September:
>> 
>> 779b1a1cb13a cpuidle: governors: menu: Avoid selecting states with too much latency - v6.17-rc3
>> fa3fa55de0d6 cpuidle: governors: menu: Avoid using invalid recent intervals data - v6.17-rc2
>> baseline reference: v6.17-rc1
>> 
>> teo was included also. As far as I can recall its response has always been similar to rc3. At least, recently.
>> 
>> Three graphs are attached:
>> Sampling data once per 20 seconds, the test is started after the first idle sample,
>> and at least one sample is taken after the system returns to idle after the test.
>> The faster the test runs the better.
>> 
>> Test computer:
>> Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz
>> Distro: Ubuntu 24.04.3, server, no desktop GUI.
>> CPU frequency scaling driver: intel_pstate
>> HWP: disabled.
>> CPU frequency scaling governor: performance
>> Ilde driver: intel_idle
>> Idle governor: menu (except teo for one compare test run)
>> Idle states: 4: name : description:
>>   state0/name:POLL                desc:CPUIDLE CORE POLL IDLE
>>   state1/name:C1_ACPI          desc:ACPI FFH MWAIT 0x0
>>   state2/name:C2_ACPI          desc:ACPI FFH MWAIT 0x30
>>   state3/name:C3_ACPI          desc:ACPI FFH MWAIT 0x60
>
> OK, so since the exit residency of an idle state cannot exceed its target
> residency, the appended change (on top of 6.18-rc2) should make the throughput
> regression go away.

Indeed, the patch you appended below did make the
throughput regression go away.

Thank you.

>
> ---
> drivers/cpuidle/governors/menu.c |    7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
>
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -321,10 +321,13 @@ static int menu_select(struct cpuidle_dr
> 
> 		/*
> 		 * Use a physical idle state, not busy polling, unless a timer
> -		 * is going to trigger soon enough.
> +		 * is going to trigger soon enough or the exit latency of the
> +		 * idle state in question is greater than the predicted idle
> +		 * duration.
> 		 */
> 		if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
> -		    s->target_residency_ns <= data->next_timer_ns) {
> +		    s->target_residency_ns <= data->next_timer_ns &&
> +		    s->exit_latency_ns <= predicted_ns) {
> 			predicted_ns = s->target_residency_ns;
> 			idx = i;
> 			break;



