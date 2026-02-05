Return-Path: <linux-pm+bounces-42115-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNo2IR0ohGlU0AMAu9opvQ
	(envelope-from <linux-pm+bounces-42115-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 06:18:21 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E46EEAB9
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 06:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ECE6E3006461
	for <lists+linux-pm@lfdr.de>; Thu,  5 Feb 2026 05:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A392931A7EE;
	Thu,  5 Feb 2026 05:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="byOnT5XJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA3E21FF33
	for <linux-pm@vger.kernel.org>; Thu,  5 Feb 2026 05:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770268698; cv=none; b=UELUw7tk3KqyMZnNy45ZojgSPNiWi5nuk1VAiAnc2Isn/+6H/VU7+KPoLY6GIbCfqVu4RuoPjf8Hh6a/p0xXr8PG5GsM+odEKINp2t2YQhrPiwWQcEKlS9k46he8J5c95WEF3EoQ+tRP/C+3hd2Bo9Jod+xVZkh7pWZU0iGyZ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770268698; c=relaxed/simple;
	bh=cEXuLehvBn+2pImWf1+z9xzVNDyIU3cr+ZH8w6I8KMg=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=aU8/ckaYMpppW7r0xp2z+6zebH164Kl++dS/8JhXsLT/UytQ35m8X5ZRKOmP+oprWONbuAq8uvQtovBsouH3THZb1TtPfXNei5ho/EzJZVXvHhW0pH7t59n/dvp9i7X55XSXGCDRqruAAdRq5cKl/bizvZud8nofdC1pOE1kksk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=byOnT5XJ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a102494058so8085615ad.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Feb 2026 21:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1770268698; x=1770873498; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wFEsJmFyloDZYoxGCsVExINbvwTfq3ZujsW3cyOFjqk=;
        b=byOnT5XJGDXYkRHlySnP1FlCP+09+TFSHVxj1glxMEqYm123O+wuhOHLEWrEvK1f0O
         GJ38GAaXIqqtm5qSzFdwUQrhuOG4RJwrnKVCtLy1cMIbn0fbu4UhmS7m3w0ric95g0/I
         AlDMYfBuWKPMr9mAH55AQwBN5z9QShlv6utcB9xOgmqoDcqYmMqYAbgQHeltXje2MCRw
         9GY5mg/MBnoVEWnvUxx9JzEgOVdidNgQXpWgIYf7ZkEHTqsEwlSnhPPT6eAQyQlXlSbk
         2aIRD5F9ze6BNI+82BgpfgufLS2YI3NaXHLBzJmxEcyW8McJdsnyMT/TWpLgPMJaCt0d
         qzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770268698; x=1770873498;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wFEsJmFyloDZYoxGCsVExINbvwTfq3ZujsW3cyOFjqk=;
        b=t6mE1ADdaCkTMQyPyoiueR/byIDFGKwYuTmfUYHVwXlEfFQusTCbrBj5+75OsvWwvy
         hEr6FA4yANUtX7kGmVqyu9xQdaaxjyI9FTG8cKNeTEMSvjnyoUzFTqWyRZniBMOUNCvH
         l0uc+L7mM0VjajRH6OgmKLpnRRZ56PPZSLibCIof6dvsZtGu0jijh0VKtmWKPRmTYG2M
         TNRwsOidxxP6jyt63H5w275FeFu/GAfMUZFGKVyvk+V/DMXJeVoNBou+OjSGA3fdVEcM
         QmTfLolRO3azqsQ9BYZJpkha1MovDNDXIEuJ12bVUjMJ2zI+v45MfX/xVkoy9db7RcAI
         SrFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV31sks782pffxCbISGj1sMkOSLpwH5Yx5gkkUIt3BEiK5zqgexOVCkvXmy7C3rAOitKtVFFgztPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVN7sbCdUmLMhR9oL2Inj3cesl0GXwvOvjFNWdK0UqQYAbNa5Q
	PdqcEfgylpxwB1HpH/62otzjl1H8h3h6ohgeIU+U4u2TQiKYq11QMXGYbdq2mI+OJrM=
X-Gm-Gg: AZuq6aJBuEwQE81yx0TS8/i6E/aAhKuI40bE6yZKVBv8Je11sqKRzuK90lOFHYCOJNg
	TGJpvaFDZJrQpHyejoLYAA9uUPYhBAPOkUTGnPMH8OrUZ4w8Q2Vn3Yfii2FjVExuxrh4XKGsscG
	EcaAFd7T/EHCKrCZBCG+Zs3uRis+24Wc8rHyaffZhgHAvxE9m/xtBe8dJWAG/wGOjeNmI0fgL5P
	bRh6bYZCXtpwpmBYX7SOqfQUQqWyx5w1emEtlFab1j/FwunI5tSFjg040AvDR0ki50uZPz429Ba
	79tFzYGPnq8aMRxeKdrwETgFQardaB5atNGVrBvDkN0N8ZIOif8NxhwgcheKpmcvHvgtGR78jIo
	g3i9rmpr4tBjtbYKZM2vo/MDztf8aXoapNoHRdMciAbNZQ65o9l7fpKfh5vVgP9FrM/RffZY9Vm
	lE9tUab7wvNHbZmjGomdnrYWTiGWi1aVXm4dW2m258o+I17CtYoXoLIvs=
X-Received: by 2002:a17:902:f650:b0:2a7:a1f3:f327 with SMTP id d9443c01a7336-2a9411991dfmr12853985ad.20.1770268697835;
        Wed, 04 Feb 2026 21:18:17 -0800 (PST)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a933965c49sm37561315ad.72.2026.02.04.21.18.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Feb 2026 21:18:17 -0800 (PST)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Sergey Senozhatsky'" <senozhatsky@chromium.org>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>,
	"'Christian Loehle'" <christian.loehle@arm.com>,
	"'Harshvardhan Jha'" <harshvardhan.j.jha@oracle.com>,
	"'Sasha Levin'" <sashal@kernel.org>,
	"'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
	<linux-pm@vger.kernel.org>,
	<stable@vger.kernel.org>,
	"'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
	"Doug Smythies" <dsmythies@telus.net>
References: <004e01dc90b1$4b28f9e0$e17aeda0$@telus.net> <002601dc916e$6acbe650$4063b2f0$@telus.net> <CAJZ5v0gcSb_6QPMfHkjSMJ6OOF+PaCZrUKOafYQ++tHE2jBB4w@mail.gmail.com> <3b0720d2-9b72-48d0-998a-1fd091cec44f@arm.com> <5d4b624c-f993-49aa-95ab-5f279f7f6599@oracle.com> <8fd5a9d4-e555-4db1-aa02-8fe5b8a2962c@arm.com> <3395ad0b-425e-40f5-844c-627cff471353@oracle.com> <3f0cfac2-b753-413c-9a7e-0892c23cdbf4@arm.com> <CAJZ5v0j+jfTHog+rVO0816mofk7nSSKCt7dbwSa2QCpYSN013Q@mail.gmail.com> <005401dc9638$b3e2ea40$1ba8bec0$@telus.net> <m7pzdjfjcm2gr4gpru3rk26o2wn5iarihff6kz3o7n3slsvonx@k6jkyemuywgk>
In-Reply-To: <m7pzdjfjcm2gr4gpru3rk26o2wn5iarihff6kz3o7n3slsvonx@k6jkyemuywgk>
Subject: RE: Performance regressions introduced via Revert "cpuidle: menu: Avoid discarding useful information" on 5.15 LTS
Date: Wed, 4 Feb 2026 21:18:20 -0800
Message-ID: <006e01dc965e$d82c33e0$88849ba0$@telus.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFHdCyGI9ZGDCiLCETmSGOiCXX2eAI+s1WmAgYl0xoAoGj4UAIEsRd0AnUSn+MA+swQZwLLiiWuAOVzse4CJZtTtgJFWskbtgokIIA=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[telus.net,none];
	R_DKIM_ALLOW(-0.20)[telus.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[telus.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42115-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsmythies@telus.net,linux-pm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E5E46EEAB9
X-Rspamd-Action: no action

On 2026.02.04 18:37 Sergey Senozhatsky wrote:
> On (26/02/04 16:45), Doug Smythies wrote:
>>>> What is "established" and "newer" for a stable kernel is quite handwavy
>>>> IMO but even here Sergey's regression report is a clear data point...
>>>
>>> Which wasn't known at the time commit 85975daeaa4d went in.
>>>
>>>> Your report is only restoring 5.15 (and others) performance to 5.15
>>>> upstream-ish levels which is within the expectations of running a stable
>>>> kernel. No doubt it's frustrating either way!
>>>
>>> That is a consequence of the time it takes for mainline changes to
>>> propagate to distributions (Chrome OS in this particular case) at
>>> which point they get tested on a wider range of systems.  Until that
>>> happens, it is not really guaranteed that the given change will stay
>>> in.
>>>
>>> In this particular case, restoring commit 85975daeaa4d would cause the
>>> same problems on the systems adversely affected by it to become
>>> visible again and I don't think it would be fair to say "Too bad" to
>>> the users of those systems.  IMV, it cannot be restored without a way
>>> to at least limit the adverse effect on performance.
>> 
>> I have been going over the old emails and the turbostat data again and again
>> and again.
>> 
>> I still do not understand how to breakdown Sergey's results into its
>> component contributions. I am certain there is power limit throttling
>> during the test, but have no idea to much or how little it contributes to the
>> differing results.
>> 
>> I think more work is needed to fully understand Sergey's test results from October.
>> I struggle with the dramatic test results difference of base=84.5 and revert=59.5
>> as being due to only the idle code changes.
>> 
>> That is why I keep asking for a test to be done with the CPU clock frequency limited
>> such that power limit throttling can not occur. I don't know what limit to use, but suggest
>> 2.2 GHZ to start with. Capture turbostat data with the tests. And record the test results.
>
>> @Sergey: are you willing to do the test?
>
> I can run tests, not immediately, though, but within some reasonable
> time frame.

Thanks.

> (I'll need some help with instructions/etc.)

From your turbostat data from October you are using the intel_pstate
CPU frequency scaling driver and the powersave CPU frequency scaling governor
and HWP enabled. Also your maximum CPU frequency is 3,300 MHz.

To limit the maximum CPU frequency to around 2,200 MHz do:

echo 67 |sudo tee /sys/devices/system/cpu/intel_pstate/max_perf_pct

Then run the tests acquiring turbostat logs the same way you did in October.

To restore the maximum CPU frequency afterwards do:

echo 100 |sudo tee /sys/devices/system/cpu/intel_pstate/max_perf_pct



