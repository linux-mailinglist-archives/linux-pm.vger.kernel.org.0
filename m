Return-Path: <linux-pm+bounces-41593-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Bp/HG6ZeWkNxwEAu9opvQ
	(envelope-from <linux-pm+bounces-41593-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 06:06:54 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2D89D23D
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 06:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E4CD3009B0B
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 05:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DB8331A71;
	Wed, 28 Jan 2026 05:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="buAZ+NrQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B00F1D86DC
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 05:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769576801; cv=none; b=Rh8ZdeR5gpCLBZLAMHF8o9VEuQZ/ytgEYVZxhrxMQGW+jrjveCBdclop3kz3mk4XZglI4v/SwXPd3Ra6H19hiz8lLuJakHfoddz6AJ5lR1PV3T/2MH72FPvR/0P70ZaQBkdNtvcSkjhT0QRN3AY/2usPN0iLF+XYa1IaoqQHXIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769576801; c=relaxed/simple;
	bh=4A26ZukGVrn5+xZBHfJY5/S2saT44sdTfJN/GbOhd8o=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=tyIN0+oqXFHu1bqwbDcMUqxcbPSshL3OUxI4A9c7Vl+2BRaoH7DgNpntxUiEqCoK7KxvjjfR083tumsUS0zh6K0jB2usWwDqm+pLyRBbHMQ73Lk8aqKOahqAuRQngZhBGML1QSMvXihDAUQ8INLjPXR7cu8eqmyw2myxXceC6p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=buAZ+NrQ; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-823075fed75so265074b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 21:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1769576799; x=1770181599; darn=vger.kernel.org;
        h=content-language:thread-index:mime-version:message-id:date:subject
         :in-reply-to:references:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHbHiL3dBiwX5zDvFkXr4CXFC/PKze+aP8DzhP1TMQY=;
        b=buAZ+NrQEnjLEPzxyA6v6gN9NUabnMJR9gRvGn4Zzm2VaYt2GQaAG3NDmBvjkam1xS
         FvqIWPevrLS/7hucEcHPQgjdRW0khhUt5XrUcW1oySgNLKnyTpV2/H+NrN3ms1J5w2AC
         jP6vEFm3vy8tmyzalaxOoDogoekOvkTi5ElUfrUJ/dBD0C8YX6W7GWKDTh/eF643qMCH
         mqY2OND0G48SvFhXxCYocB39CSNpwy8U0kOdWipLZmuvC3FZQbyfT15DoG+9+F1GzGOY
         xHYyJ0FhWkyr333gh0mEzVi1C0lFX2OoMcdZS2ILOGzhwbDwKkdTFQsFYTTfZG7BZ5v7
         hRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769576799; x=1770181599;
        h=content-language:thread-index:mime-version:message-id:date:subject
         :in-reply-to:references:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cHbHiL3dBiwX5zDvFkXr4CXFC/PKze+aP8DzhP1TMQY=;
        b=A0rGSjzD5bT7upNYLMQRL/FSvkn6INpAuM5QcnvRxXYUq481kNqkUF3MSXMtSkgLFn
         UV2lD/cHZ24sGm1ukcIK1x0O0/GlRFEv8EhteinCTrk5NRMTAE9cruGR1v37BYQeqTdN
         nd79WOsjtQGQGdo00AbUIvevmhzRfwL2VTnK2gFd8ZlOzVr/Iko7IEiY0DDTKV74OqWE
         i7asob5X2EnoE2vWQv4Iu837o+QA4jj5nWor/xDug3eF8BsJRHfSDsJdcnTc7+iUqqkn
         5hurLqwX4L5GwC0qfgr5e5uXS3lE8DvxbDL5zlml66pisyCwskNCcJtpfE05ankvpA95
         ybnw==
X-Forwarded-Encrypted: i=1; AJvYcCUZYu8d4vVptEmAxHmV2rFZ82p2BwvU5fw1faskfWbVQfY/SJItyd0iX2AJQDNCzRhEmVE7cPc9hw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw25jl08W4ND3Gqiml8v+DCPugl1Kl8r4WWRQO8h65vVRm2WpD
	xc/pInnZnOY0Uyu0lpbAMp6Fp7QCeys95Nfy7Litw/N8JytnDkqe+sUs+pe5MWRY7Fk=
X-Gm-Gg: AZuq6aJVswJQxkbFd2wA4eAMaK/dWRZ2xQIppvnVhSizeILNnaCFu3g9tGr12ai1mav
	BROYWFa2C7/XSAztCSsNf+hJKYFBCsggbuxD5gdjb0vj59eZ09o8ADv+3tpiYF/JYde/Rd3tHE5
	d3by4mC4VIhZ6OIj2/kzYftx4VkyR7+9BJPlT6ixXgXOtBTnvIjPx8B3h6nOo5sB4K7eExNZjrT
	xZyEK9v3syrskiu1eQ7MRuRxRDn/Z8whdcuKpb6cEiE9fZ2NU92+HJta6wc5UmKruJgVLheKzEH
	znRjuS1wa7ntdJ488vI2gs0NI5uXvJP04szvDStb60ogI1srLE50Q6GfelLQNcmk6ooI8Eg2Pg9
	4sLPFU9OpGsSzffajRYTj3KuVDGXDL8D8HtdayG2rJ7U3WPn9HIEjL//6H113Nl1KabmC6oHTph
	fhbRCW3efCCe2rZdyMWB3nimEtKqYVwFshSPbXFsYglbBPtJROl4hQoHo=
X-Received: by 2002:a05:6a00:188c:b0:822:69b2:7ed0 with SMTP id d2e1a72fcca58-8236a14bb25mr3783122b3a.6.1769576798688;
        Tue, 27 Jan 2026 21:06:38 -0800 (PST)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b1f45dsm1136278b3a.5.2026.01.27.21.06.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jan 2026 21:06:37 -0800 (PST)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Harshvardhan Jha'" <harshvardhan.j.jha@oracle.com>,
	"'Christian Loehle'" <christian.loehle@arm.com>
Cc: "'Sasha Levin'" <sashal@kernel.org>,
	"'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
	<linux-pm@vger.kernel.org>,
	<stable@vger.kernel.org>,
	"'Rafael J. Wysocki'" <rafael@kernel.org>,
	"'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
	"Doug Smythies" <dsmythies@telus.net>
References: <d4690be7-9b81-498e-868b-fb4f1d558e08@oracle.com> <39c7d882-6711-4178-bce6-c1e4fc909b84@arm.com> <005401dc64a4$75f1d770$61d58650$@telus.net> <b36a7037-ca96-49ec-9b39-6e9808d6718c@oracle.com> <6347bf83-545b-4e85-a5af-1d0c7ea24844@arm.com> <849ee0ff-e15b-4b69-84de-6503e3b3168d@oracle.com>
In-Reply-To: <849ee0ff-e15b-4b69-84de-6503e3b3168d@oracle.com>
Subject: RE: Performance regressions introduced via Revert "cpuidle: menu: Avoid discarding useful information" on 5.15 LTS
Date: Tue, 27 Jan 2026 21:06:40 -0800
Message-ID: <003e01dc9013$e3bc5060$ab34f120$@telus.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_003F_01DC8FD0.D59A9700"
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHo/NwLGJZTeO77XmxNlnPhSwOGkAKJCFtJAex1orYBu9KCwgGuBEkcAe/o8FK0/6is4A==
Content-Language: en-ca
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[telus.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[telus.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[telus.net:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41593-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REDIRECTOR_URL(0.00)[urldefense.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsmythies@telus.net,linux-pm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,urldefense.com:url]
X-Rspamd-Queue-Id: AB2D89D23D
X-Rspamd-Action: no action

This is a multipart message in MIME format.

------=_NextPart_000_003F_01DC8FD0.D59A9700
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 2026.01.27 07:45 Harshvardhan Jha wrote:
>On 08/12/25 6:17 PM, Christian Loehle wrote:
>> On 12/8/25 11:33, Harshvardhan Jha wrote:
>>> On 04/12/25 4:00 AM, Doug Smythies wrote:
>>>> On 2025.12.03 08:45 Christian Loehle wrote:
>>>>> On 12/3/25 16:18, Harshvardhan Jha wrote:
>>>>>>
>>>>>> While running performance benchmarks for the 5.15.196 LTS tags , =
it was
>>>>>> observed that several regressions across different benchmarks is =
being
>>>>>> introduced when compared to the previous 5.15.193 kernel tag. =
Running an
>>>>>> automated bisect on both of them narrowed down the culprit commit =
to:
>>>>>> - 5666bcc3c00f7 Revert "cpuidle: menu: Avoid discarding useful
>>>>>> information" for 5.15
>>>>>>
>>>>>> Regressions on 5.15.196 include:
>>>>>> -9.3% : Phoronix pts/sqlite using 2 processes on OnPrem X6-2
>>>>>> -6.3% : Phoronix system/sqlite on OnPrem X6-2
>>>>>> -18%  : rds-stress -M 1 (readonly rdma-mode) metrics with 1 depth =
& 1
>>>>>> thread & 1M buffer size on OnPrem X6-2
>>>>>> -4 -> -8% : rds-stress -M 2 (writeonly rdma-mode) metrics with 1 =
depth &
>>>>>> 1 thread & 1M buffer size on OnPrem X6-2
>>>>>> Up to -30% : Some Netpipe metrics on OnPrem X5-2
>>>>>>
>>>>>> The culprit commits' messages mention that these reverts were =
done due
>>>>>> to performance regressions introduced in Intel Jasper Lake =
systems but
>>>>>> this revert is causing issues in other systems unfortunately. I =
wanted
>>>>>> to know the maintainers' opinion on how we should proceed in =
order to
>>>>>> fix this. If we reapply it'll bring back the previous regressions =
on
>>>>>> Jasper Lake systems and if we don't revert it then it's stuck =
with
>>>>>> current regressions. If this problem has been reported before and =
a fix
>>>>>> is in the works then please let me know I shall follow =
developments to
>>>>>> that mail thread.
>>>>> The discussion regarding this can be found here:
>>>>> =
https://urldefense.com/v3/__https://lore.kernel.org/lkml/36iykr223vmcfsoy=
sexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7/__;!!ACWV5N9M2RV99hQ!MWXE=
z_wRbaLyJxDign2EXci2qNzAPpCyhi8qIORMdReh0g_yIVIt-Oqov23KT23A_rGBRRxJ4bHb_=
e6UQA-b9PW7hw$=20
>>>>> we explored an alternative to the full revert here:
>>>>> =
https://urldefense.com/v3/__https://lore.kernel.org/lkml/4687373.LvFx2qVV=
Ih@rafael.j.wysocki/__;!!ACWV5N9M2RV99hQ!MWXEz_wRbaLyJxDign2EXci2qNzAPpCy=
hi8qIORMdReh0g_yIVIt-Oqov23KT23A_rGBRRxJ4bHb_e6UQA9PSf_uMQ$=20
>>>>> unfortunately that didn't lead anywhere useful, so Rafael went =
with the
>>>>> full revert you're seeing now.
>>>>>
>>>>> Ultimately it seems to me that this "aggressiveness" on deep idle =
tradeoffs
>>>>> will highly depend on your platform, but also your workload, =
Jasper Lake
>>>>> in particular seems to favor deep idle states even when they don't =
seem
>>>>> to be a 'good' choice from a purely cpuidle (governor) =
perspective, so
>>>>> we're kind of stuck with that.
>>>>>
>>>>> For teo we've discussed a tunable knob in the past, which comes =
naturally with
>>>>> the logic, for menu there's nothing obvious that would be =
comparable.
>>>>> But for teo such a knob didn't generate any further interest (so =
far).
>>>>>
>>>>> That's the status, unless I missed anything?
>>>> By reading everything in the links Chrsitian provided, you can see
>>>> that we had difficulties repeating test results on other platforms.
>>>>
>>>> Of the tests listed herein, the only one that was easy to repeat on =
my
>>>> test server, was the " Phoronix pts/sqlite" one. I got (summary: no =
difference):
>>>>
>>>> Kernel 6.18									Reverted		=09
>>>> pts/sqlite-2.3.0			menu rc4		menu rc1		menu rc1		menu rc3=09
>>>> 				performance		performance		performance		performance=09
>>>> test	what			ave			ave			ave			ave=09
>>>> 1	T/C 1			2.147	-0.2%		2.143	0.0%		2.16	-0.8%		2.156	-0.6%
>>>> 2	T/C 2			3.468	0.1%		3.473	0.0%		3.486	-0.4%		3.478	-0.1%
>>>> 3	T/C 4			4.336	0.3%		4.35	0.0%		4.355	-0.1%		4.354	-0.1%
>>>> 4	T/C 8			5.438	-0.1%		5.434	0.0%		5.456	-0.4%		5.45	-0.3%
>>>> 5	T/C 12			6.314	-0.2%		6.299	0.0%		6.307	-0.1%		6.29	0.1%
>>>>
>>>> Where:
>>>> T/C means: Threads / Copies
>>>> performance means: intel_pstate CPU frequency scaling driver and =
the performance CPU frequencay scaling governor.
>>>> Data points are in Seconds.
>>>> Ave means the average test result. The number of runs per test was =
increased from the default of 3 to 10.
>>>> The reversion was manually applied to kernel 6.18-rc1 for that =
test.
>>>> The reversion was included in kernel 6.18-rc3.
>>>> Kernel 6.18-rc4 had another code change to menu.c
>>>>
>>>> In case the formatting gets messed up, the table is also attached.
>>>>
>>>> Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz, 6 cores 12 =
CPUs.
>>>> HWP: Enabled.
>>> I was able to recover performance on 5.15 and 5.4 LTS based kernels
>>> after reapplying the revert on X6-2 systems.
>>>
>>> Architecture:                x86_64
>>>   CPU op-mode(s):            32-bit, 64-bit
>>>   Address sizes:             46 bits physical, 48 bits virtual
>>>   Byte Order:                Little Endian
>>> CPU(s):                      56
>>>   On-line CPU(s) list:       0-55
>>> Vendor ID:                   GenuineIntel
>>>   Model name:                Intel(R) Xeon(R) CPU E5-2690 v4 @ =
2.60GHz
>>>    CPU family:              6
>>>     Model:                   79
>>>     Thread(s) per core:      2
>>>     Core(s) per socket:      14
>>>     Socket(s):               2
>>>     Stepping:                1
>>>     CPU(s) scaling MHz:      98%
>>>     CPU max MHz:             2600.0000
>>>     CPU min MHz:             1200.0000
>>>     BogoMIPS:                5188.26
... snip ...
>> It would be nice to get the idle states here, ideally how the states' =
usage changed
>> from base to revert.
>> The mentioned thread did this and should show how it can be done, but =
a dump of
>> cat /sys/devices/system/cpu/cpu*/cpuidle/state*/*
>> before and after the workload is usually fine to work with:
>> =
https://urldefense.com/v3/__https://lore.kernel.org/linux-pm/8da42386-282=
e-4f97-af93-4715ae206361@arm.com/__;!!ACWV5N9M2RV99hQ!PEhkFcO7emFLMaNxWEo=
E2Gtnw3zSkpghP17iuEvZM3W6KUpmkbgKw_tr91FwGfpzm4oA5f7c5sz8PkYvKiEVwI_iLIPp=
Mt53$=20
> Apologies for the late reply, I'm attaching a tar ball which has the =
cpu
> states for the test suites before and after tests. The folders with =
the
> name of the test contain two folders good-kernel and bad-kernel
> containing two files having the before and after states. Please note
> that different machines were used for different test suites due to
> compatibility reasons. The jbb test was run using containers.

It is a considerable amount of work to manually extract and summarize =
the data.
I have only done it for the phoronix-sqlite data.
There seems to be 40 CPUs, 5 idle states, with idle state 3 defaulting =
to disabled.
I remember seeing a Linux-pm email about why but couldn't find it just =
now.
Summary (also attached as a PNG file, in case the formatting gets messed =
up):
The total idle entries (usage)  and time seem low to me, which is why =
the ???.

phoronix-sqlite					=09
	Good Kernel: Time between samples 4 seconds (estimated and ???)				=09
	Usage	Above	Below	Above	Below=09
state 0	220	0	218	0.00%	99.09%=09
state 1	70212	5213	34602	7.42%	49.28%=09
state 2	30273	5237	1806	17.30%	5.97%=09
state 3	0	0	0	0.00%	0.00%=09
state 4	11824	2120	0	17.93%	0.00%=09
					=09
total	112529	12570	36626	43.72%	 <<< Misses %=09
					=09
	Bad Kernel: Time between samples 3.8 seconds (estimated and ???)				=09
	Usage	Above	Below	Above	Below=09
state 0	262	0	260	0.00%	99.24%=09
state 1	62751	3985	35588	6.35%	56.71%=09
state 2	24941	7896	1433	31.66%	5.75%=09
state 3	0	0	0	0.00%	0.00%=09
state 4	24489	11543	0	47.14%	0.00%=09
					=09
total	112443	23424	37281	53.99%	 <<< Misses %

Observe 2X use of idle state 4 for the "Bad Kernel"

I have a template now, and can summarize the other 40 CPU data
faster, but I would have to rework the template for the 56 CPU data,
and is it a 64 CPU data set at 4 idle states per CPU?

... Doug


------=_NextPart_000_003F_01DC8FD0.D59A9700
Content-Type: image/png;
	name="sqlite-summary.png"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="sqlite-summary.png"

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
RU5ErkJggg==

------=_NextPart_000_003F_01DC8FD0.D59A9700--


