Return-Path: <linux-pm+bounces-39174-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9005ECA1D39
	for <lists+linux-pm@lfdr.de>; Wed, 03 Dec 2025 23:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5984C30024BC
	for <lists+linux-pm@lfdr.de>; Wed,  3 Dec 2025 22:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA492C237E;
	Wed,  3 Dec 2025 22:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="E7f0ghBN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BBC2FD1A1
	for <linux-pm@vger.kernel.org>; Wed,  3 Dec 2025 22:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764801044; cv=none; b=Qmdypw5p59wZyH6MiMBfhkwGJXyincgI0RHlyf7BTmyoMGL8MhaPzQIQJJZa3+vDnjx5M4Bu1Hm9UZ7196BXQk7/Zu3rjqm+l48SA6zWevlNf+bFfCZCUzOBimdoj8RFeriDagoGJmj7SwI0/vMY76gROWFmLlwN0NuSMHtNAcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764801044; c=relaxed/simple;
	bh=VEvcVh3+sb4Ck1QlQLV8bo9FkNb6m2A9Trp83cxLXLc=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=NE/fCiZRXy3oWd4DWMaEf1AL7gnQR0LK5T7IbOncz3tovga4f6rVk3ZpkaLjbaUZe3xantcV2T1Quosx6uVTQv2c8B/cJYEdv8A8SKLAeEWzdVOcnB9K/zd3xju2T8G4yzG7mgRye4aw57hWrkH5BM1YSiK0nNwacYGMEVy+lCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=E7f0ghBN; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7b8e49d8b35so269131b3a.3
        for <linux-pm@vger.kernel.org>; Wed, 03 Dec 2025 14:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1764801042; x=1765405842; darn=vger.kernel.org;
        h=thread-index:content-language:mime-version:message-id:date:subject
         :in-reply-to:references:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJtKp1xB3jGidkc0yL16L6FuRv5+09/4k1kUg8jvXiE=;
        b=E7f0ghBNdZEjcqPkkhiQbD5yYw5fCY0lmnKaHBQV6CQrNK023uO95LP1hAP9qRVXBM
         3mEzvY/BtUFWCIVn0Ngjr29KQJh/KpGyxuyF3AkujYsdRc1NzhO1K/jgbTaL+P32xa7M
         MuQdXZnmySoJjiGjcz1q05zkI1xjIN4JT/denvZrhDKXrHOMj4VFkQroILkvcEDEiyBT
         QgtgPj2WyUenLWOG+0unbaxooT4z6yg61Cvjgkeg0bds3cw//AqIyWGPvX6CY9C7g0tv
         t2Jh6iYTaDAuXtIitAgHdYCPdLSDIvUElOMX7ySkcjddDDLXAW5Bwyp4YgIdTF/yvl0j
         r0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764801042; x=1765405842;
        h=thread-index:content-language:mime-version:message-id:date:subject
         :in-reply-to:references:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fJtKp1xB3jGidkc0yL16L6FuRv5+09/4k1kUg8jvXiE=;
        b=qMnEH85Vhdacg1UKLlCViuXZIlqSYrEFdCzgmxRNWtqX3zLW8Fd5dFYkMYNGd2SCFf
         AigJeMD9xwpYsgCKfGW73ioVc77ch2A9cpQbkBXhVyeA9LSm/3ImJ1ail5dYpH5KzhAQ
         DQfs53HSCXx+ruxISquAPvYNOrcOr9HrPvas5PJ4adaJRIt1+a0PLU+wcu+IWJqt6rIl
         kztphjEHA9MrGftU6JNzaMtm5D2FhvX0dwWPpwIhka3bMQeE4LD2Uk/FwNBTOjlMVTTX
         EvttJ0HcFqb8/26DG/Hf3L1os8B7gLN/MQp5P2w67Y8Yg67qatuwxHO9kHRC1n0jH/53
         XxEg==
X-Forwarded-Encrypted: i=1; AJvYcCWWgE//3w74AU8zPtFhmpWFyHIFALPXY3Qsf8TOdSQznTABPGA/9EFIMf2TK3ZKOCTkwCQdv7XatA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh7hFhuPryk9H2KW8RclG0tfuSxT6zuYcO3W48Q498t96vpE/v
	m2t3HF1ahKKaWRnTKUTZYvZ5M/ZeIk9fTtDrWmknrKkmF53jesN1ZuaLAjIMxyJZEl0=
X-Gm-Gg: ASbGncu3yfBOcuyfumoR1jMSd6E+PWDTizqXLOfofmkmZPLHjIofEE4eX5JPOTDSiQd
	xeSpYelX4vIe/+xPceO4UT9WVm4NFZSgPH2fvqUhHGxnTtan2eoKXQYhKCeirzm//BB6qzk15SP
	Bz52mRTLtuUKIxuA4LgXytmRISiy4Dy8HLED4nSVu8/74oHLnMiDSWUkQP/kvlFVuD9cRVuY+ND
	X3QIK5i+U10ofWqXay25EVRNCMUpGoJTluMgehKjxZk3ltiQohE1bIm8TAQh20H9snm0x5HpSHy
	1qWpA7ov/iCj4wwy3QvBt16ThS4CnScfByEwbZjiN3IEQWoWEvPaff5DQtmUqahAOomhhl9iWzw
	SNnY9JAlMSSGOmnDCtXRnsPgv4Aw/h18apnLxc1qOJjYOj8ElOftyVpp9MbhUtaW1wWxE1AS9H8
	eOZdFPixBi2LbS
X-Google-Smtp-Source: AGHT+IEu/gCkekmG2E8+9bcI02e3OFHzSdfR2vLy8xyVVu5lEo+HfBuOTasbG2dTKNhUdOTzH0/bmw==
X-Received: by 2002:a05:6a21:3299:b0:35f:6586:5df6 with SMTP id adf61e73a8af0-363f5d3eb66mr5063801637.11.1764801041544;
        Wed, 03 Dec 2025 14:30:41 -0800 (PST)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15fc08bd1sm21223645b3a.63.2025.12.03.14.30.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Dec 2025 14:30:40 -0800 (PST)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Harshvardhan Jha'" <harshvardhan.j.jha@oracle.com>
Cc: "'Sasha Levin'" <sashal@kernel.org>,
	"'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
	<linux-pm@vger.kernel.org>,
	<stable@vger.kernel.org>,
	"Doug Smythies" <dsmythies@telus.net>,
	"'Christian Loehle'" <christian.loehle@arm.com>,
	"'Rafael J. Wysocki'" <rafael@kernel.org>,
	"'Daniel Lezcano'" <daniel.lezcano@linaro.org>
References: <d4690be7-9b81-498e-868b-fb4f1d558e08@oracle.com> <39c7d882-6711-4178-bce6-c1e4fc909b84@arm.com>
In-Reply-To: <39c7d882-6711-4178-bce6-c1e4fc909b84@arm.com>
Subject: RE: Performance regressions introduced via Revert "cpuidle: menu: Avoid discarding useful information" on 5.15 LTS
Date: Wed, 3 Dec 2025 14:30:42 -0800
Message-ID: <005401dc64a4$75f1d770$61d58650$@telus.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0055_01DC6461.67CE9770"
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHo/NwLGJZTeO77XmxNlnPhSwOGkAKJCFtJtOMAXGA=

This is a multipart message in MIME format.

------=_NextPart_000_0055_01DC6461.67CE9770
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit

On 2025.12.03 08:45 Christian Loehle wrote:
> On 12/3/25 16:18, Harshvardhan Jha wrote:
>> Hi there,
>> 
>> While running performance benchmarks for the 5.15.196 LTS tags , it was
>> observed that several regressions across different benchmarks is being
>> introduced when compared to the previous 5.15.193 kernel tag. Running an
>> automated bisect on both of them narrowed down the culprit commit to:
>> - 5666bcc3c00f7 Revert "cpuidle: menu: Avoid discarding useful
>> information" for 5.15
>> 
>> Regressions on 5.15.196 include:
>> -9.3% : Phoronix pts/sqlite using 2 processes on OnPrem X6-2
>> -6.3% : Phoronix system/sqlite on OnPrem X6-2
>> -18%  : rds-stress -M 1 (readonly rdma-mode) metrics with 1 depth & 1
>> thread & 1M buffer size on OnPrem X6-2
>> -4 -> -8% : rds-stress -M 2 (writeonly rdma-mode) metrics with 1 depth &
>> 1 thread & 1M buffer size on OnPrem X6-2
>> Up to -30% : Some Netpipe metrics on OnPrem X5-2
>> 
>> The culprit commits' messages mention that these reverts were done due
>> to performance regressions introduced in Intel Jasper Lake systems but
>> this revert is causing issues in other systems unfortunately. I wanted
>> to know the maintainers' opinion on how we should proceed in order to
>> fix this. If we reapply it'll bring back the previous regressions on
>> Jasper Lake systems and if we don't revert it then it's stuck with
>> current regressions. If this problem has been reported before and a fix
>> is in the works then please let me know I shall follow developments to
>> that mail thread.
>
> The discussion regarding this can be found here:
> https://lore.kernel.org/lkml/36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7/
> we explored an alternative to the full revert here:
> https://lore.kernel.org/lkml/4687373.LvFx2qVVIh@rafael.j.wysocki/
> unfortunately that didn't lead anywhere useful, so Rafael went with the
> full revert you're seeing now.
>
> Ultimately it seems to me that this "aggressiveness" on deep idle tradeoffs
> will highly depend on your platform, but also your workload, Jasper Lake
> in particular seems to favor deep idle states even when they don't seem
> to be a 'good' choice from a purely cpuidle (governor) perspective, so
> we're kind of stuck with that.
>
> For teo we've discussed a tunable knob in the past, which comes naturally with
> the logic, for menu there's nothing obvious that would be comparable.
> But for teo such a knob didn't generate any further interest (so far).
>
> That's the status, unless I missed anything?

By reading everything in the links Chrsitian provided, you can see
that we had difficulties repeating test results on other platforms.

Of the tests listed herein, the only one that was easy to repeat on my
test server, was the " Phoronix pts/sqlite" one. I got (summary: no difference):

Kernel 6.18									Reverted			
pts/sqlite-2.3.0			menu rc4		menu rc1		menu rc1		menu rc3	
				performance		performance		performance		performance	
test	what			ave			ave			ave			ave	
1	T/C 1			2.147	-0.2%		2.143	0.0%		2.16	-0.8%		2.156	-0.6%
2	T/C 2			3.468	0.1%		3.473	0.0%		3.486	-0.4%		3.478	-0.1%
3	T/C 4			4.336	0.3%		4.35	0.0%		4.355	-0.1%		4.354	-0.1%
4	T/C 8			5.438	-0.1%		5.434	0.0%		5.456	-0.4%		5.45	-0.3%
5	T/C 12			6.314	-0.2%		6.299	0.0%		6.307	-0.1%		6.29	0.1%

Where:
T/C means: Threads / Copies
performance means: intel_pstate CPU frequency scaling driver and the performance CPU frequencay scaling governor.
Data points are in Seconds.
Ave means the average test result. The number of runs per test was increased from the default of 3 to 10.
The reversion was manually applied to kernel 6.18-rc1 for that test.
The reversion was included in kernel 6.18-rc3.
Kernel 6.18-rc4 had another code change to menu.c

In case the formatting gets messed up, the table is also attached.

Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz, 6 cores 12 CPUs.
HWP: Enabled.
 
... Doug


------=_NextPart_000_0055_01DC6461.67CE9770
Content-Type: image/png;
	name="sqlite-test-table.png"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="sqlite-test-table.png"

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

------=_NextPart_000_0055_01DC6461.67CE9770--


