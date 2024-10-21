Return-Path: <linux-pm+bounces-16065-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D289A5EF9
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 10:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D17082816B9
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 08:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11A11E22F5;
	Mon, 21 Oct 2024 08:43:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CB11D2707;
	Mon, 21 Oct 2024 08:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500227; cv=none; b=t5nL/XkCdRygwgmTwOUPv8gSoAhaHHZg3qln1QBgAxe3ixFei9kHg2OtkHscr97y/lhA1N1J+NhkfkGeqbgieFBLwwz54SrTH3PdIJsPkvzG0iNmQGBj5u/wa3uQ3Ou89wwWabsqamAtJHVtQVXwCDXQZ+IGwNgSYAuuvQ2Kme8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500227; c=relaxed/simple;
	bh=77ILEaMMwbIZsITnawXNVRMUCjGHehhWgVYdsenRkt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A5IG6sPIhbLXrNItKng/AANTG2PHD+dY4natT1IgjKDLSZ6J2gtUJSc8HuxV7soRW1Ql8hkEdGdClG9PTOBJ8TI7AnFxc2I0jpH66oA/4ap+26rAm81VIQfvGjmEFGOgni44U7loIKFhczUsGS/C/9/CO0XCd9QW5GkwotPQNEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0F63DA7;
	Mon, 21 Oct 2024 01:44:13 -0700 (PDT)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 935F23F528;
	Mon, 21 Oct 2024 01:43:42 -0700 (PDT)
Message-ID: <6df6b42a-6e33-449c-8e57-c07e897142e8@arm.com>
Date: Mon, 21 Oct 2024 09:43:42 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] cpuidle/menu: Address performance drop from favoring
 physical over polling cpuidle state
To: Aboorva Devarajan <aboorvad@linux.ibm.com>, rafael@kernel.org,
 daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: gautam@linux.ibm.com
References: <20240809073120.250974-1-aboorvad@linux.ibm.com>
 <93d9ffb2-482d-49e0-8c67-b795256d961a@arm.com>
 <9e5ef8ab0f0f3e7cb128291cd60591e3d07b33e4.camel@linux.ibm.com>
 <4c897ab4-d592-427b-9a97-79c2b14d5c46@arm.com>
 <6371848e9c260743f381be6e0114743ffab5e5bb.camel@linux.ibm.com>
 <6ae997ca-9712-4497-b666-11b976b1816d@arm.com>
 <20f31d99374ef1ffa7dc7fc1a609074009742e00.camel@linux.ibm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20f31d99374ef1ffa7dc7fc1a609074009742e00.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Aboorva,

On 10/21/24 06:27, Aboorva Devarajan wrote:
> [...] 
> I ran the benchmark again and collected the idle statistics on a different
> system since I no longer have access to the previous one.
> 
> Here are the stats I gathered, including data for the menu, teo, and ladder governors:
> 
> Metric                        | Ladder        | Teo           | Menu          | Menu Patched
> --------------------------------------------------------------------------------------------
> Transactions Processed        | 42,902,188    | 48,499,709    | 42,653,477    | 48,648,867   
> Latency (ms)                  | 0.313         | 0.277         | 0.315         | 0.276        
> TPS                           | 715,340.96    | 808,672.59    | 711,123.13    | 811,137.40  
> --------------------------------------------------------------------------------------------
> Total Usage Difference        | 46,680,184    | 66,348,992    | 47,892,509    | 62,366,337
> Usage Diff (CEDE)             | 46,680,184    | 7,612,960     | 45,421,436    | 19,237,430
> Usage Diff (Snooze)           | 0             | 58,736,032    | 2,471,073     | 43,128,907
> --------------------------------------------------------------------------------------------
> Total Time Difference (s)     | 5,552.20      | 5,242.75      | 5,534.62      | 5,238.46     
> Time Diff (CEDE)              | 5,552.20      | 2,497.89      | 5,431.91      | 3,324.99
> Time Diff (Snooze)            | 0.00          | 2,744.86      | 102.71        | 1,913.47
> --------------------------------------------------------------------------------------------
> Total Above Diff              | 40,381,398    | 4,520,998     | 38,942,725    | 15,072,345
> Above Diff (CEDE)             | 40,381,398    | 4,520,998     | 38,942,725    | 15,072,345
> Above Diff (Snooze)           | 0             | 0             | 0             | 0
> --------------------------------------------------------------------------------------------
> Total Below Diff              | 0             | 12,362,392    | 405,357       | 8,172,845
> Below Diff (CEDE)             | 0             | 0             | 0             | 0
> Below Diff (Snooze)           | 0             | 12,362,392    | 405,357       | 8,172,845
> --------------------------------------------------------------------------------------------
> % Above w.r.t. Usage          | 86.51%        | 6.82%         | 81.30%        | 24.17%
> --------------------------------------------------------------------------------------------
> % Below w.r.t. Usage          | 0%            | 18.64%        | 0.85%         | 13.10%
> --------------------------------------------------------------------------------------------
> 
> --------------------------------------------------------------------------------------------
> 
> Note:
> 
> % Above w.r.t Usage = (Total Above Difference / Total Usage Difference) * 100
> % Below w.r.t Usage = (Total Below Difference / Total Usage Difference) * 100
> 
> 
> Menu, Teo, Ladder: This is with menu, teo and ladder governor enabled respectively on v6.12-rc1.
> 
> Menu Patched: This is with menu governor enabled on v6.12-rc + 
>               https://lore.kernel.org/all/20240809073120.250974-2-aboorvad@linux.ibm.com/
> --------------------------------------------------------------------------------------------
> 
> --------------------------------------------------------------------------------------------
> Inference:
> --------------------------------------------------------------------------------------------
> 
> Transactions Processed: The number of transactions processed in Menu Patched is
> 14.06% higher compared to Menu.
> 
> Latency: There is a 12.38% reduction in latency in Menu Patched compared to Menu.
> 
> TPS (Transactions Per Second): The TPS in Menu Patched is 14.06% higher than in
> Menu.
> --------------------------------------------------------------------------------------------
> 
> While this patch hasn't completely eliminated the cpuidle miss ratio, but it
> has improved see Above w.r.t Usage, Below w.r.t Usage.
> 
> I'll keep investigating why there's still a 24% miss rate in the "above" and
> 13% in the "below" stats after the patch. This could be a different issue.
> Additionally, I've seen good performance improvements using the teo governor
> with the pgbench benchmark, although it didn't provide the same benefit in the
> original test.

Good to hear and thank you for testing.
Indeed the menu idle misses sound somewhat high, given that teo scores fewer.
I'd be very curious about the workload where menu patched significantly outperforms
teo if you ever come across that again.


> [...] 
> 
> I ran a similar benchmark using teo cpuidle governor, presented the averaged out
> values across 10 runs (has low standard deviation). Below are the results for a
> pipe-based wakeup with an approximate 50 microsecond sleep interval:
> 
> 
> Pipe based wakeup with approx 50 us as sleep interval:
> 
> Metric                    Ladder           Menu            Teo              Menu Patched
> ----------------------------------------------------------------------------------------
> Wakeups                   579,690          579,951         578,328          578,363
> Avg wakeup latency (us)   7.456            7.112           4.46067          4.48733
> ========================================================================================
> Sleep interval (us)       51.7333          51.7097         51.8533          51.8477
> ========================================================================================
> State 0 Usage diff        0                7,324           578,361          578,407
> State 0 Time diff (ns)    0                340,115         2.75953e+07      2.75696e+07
> State 0 Above diff        0                0               0                0
> State 0 Below diff        0                0               0.333333         0.666667
> ========================================================================================
> State 1 Usage diff        580,114          572,644         0.666667         9.33333
> State 1 Time diff (ns)    2.74189e+07      2.73901e+07     20.6667          445.333
> State 1 Above diff        579,993          572,535         0.666667         9.33333
> State 1 Below diff        0                0               0                0
> Total Above               579,993          572,535         0.666667         9.33333
> Total Below               0                0               0.333333         0.666667
> ========================================================================================
> Total Above Percent       99.98%           98.7167%        0%               0%             --> [1]
> Total Below Percent       0%               0%              0%               0%
> ========================================================================================
> 
> Timer based wakeup with approx 50 us as sleep interval:
> 
> Metric                    Ladder           Menu            Teo              Menu Patched
> ----------------------------------------------------------------------------------------
> Sleep interval (us)        53.775           52.3687         52.746           52.327
> ========================================================================================
> State 0 Usage diff         0                572,575         568,419          573,109
> State 0 Time diff (ns)     0                2.84142e+07     2.81956e+07      2.84548e+07
> State 0 Above diff         0                0               0                0
> State 0 Below diff         0                0.333333        1                0.333333
> ========================================================================================
> State 1 Usage diff         558,285          0.333333        0                0
> State 1 Time diff (ns)     2.80965e+07      17              0                0
> State 1 Above diff         558,215          0.333333        0                0
> State 1 Below diff         0                0               0                0
> ========================================================================================
> Total Above                558,215          0.333333        0                0
> Total Below                0                0.333333        1                0.333333
> ========================================================================================
> Total Above Percent        99.99%           0%              0%               0%
> Total Below Percent        0%               0%              0%               0%
> ========================================================================================
> 
> 
> [1] The results does show that the teo governor doesn't have this issue.

Glad to see that confirmed, thank you.

Regards,
Christian

