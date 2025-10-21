Return-Path: <linux-pm+bounces-36581-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DD4BF714D
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 16:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E2B4188D47D
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 14:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E99339B32;
	Tue, 21 Oct 2025 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="F0JvGQcY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C9A339B35
	for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761057020; cv=none; b=pGvComyPKO9gpRLRwOzBmoaJ7lfhT6dqVu7632Bo3j87H8D0LsRSrQZH3BmaBBdpWnTMBZ95UGyf83ebH8L4gLCJhxHM0qHk05iptn5J+rfhTxlQ/+V/eVCKJZpUQhsLgbeAQb0hM2HrnDBuD/XxOGi522aQEBT5IV/3P52KXvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761057020; c=relaxed/simple;
	bh=AMk6Lrxmvf/zuorD22sZx/fHRloh9GVoJWzNxQaEuIE=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=b5hFuB6AlVpkCkveXQRTwHV92YlyUf3vBckkZoN8oHBRNR1e1amDTh8N6Kyo22jYF1r2pibXraNkGb8vtjqgiV8HUI2NSX7W/eXY5ufx+7JAbgdqH0JLZFVLhjo7iP4ItzHkxw+HcObsWevJzMXtVYdMqdC2RDTI16zRuyeQpqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=F0JvGQcY; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7811fa91774so5041472b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 07:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1761057018; x=1761661818; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=72EdVUvWUCeeRDpijDC/64Xkq93xQ0f8jqeBT4LAAk8=;
        b=F0JvGQcYcIE6u7mxUYwOWX/axYMIif+gYF93z84Hj1Bp5mbP29mbZHJkuwxxy4KoZs
         8vJyub5ZV2oqiVswWFh4GIH2yqvZHWhW3zG/yt1kliWbg96yxt/uhA+ladlMrUraK4Fd
         qpSz6rv/J+VZxFSEQAMoxRxk58BzKgYwvAUDnHeYgB/fCiUPPaUZW8tu8pQx5k6WWjpp
         hNEGNpxWWEMjoSJ9a0sYOQmsl1EnKXk+TQ/fRdGmbk0568lnsTjD2aMdMIPtdA89Zv2k
         h9DH5WW2AhJ8MwaO0MhrgZ5WxjZKQDuUgHVopAEqTK1NIhPjrsxAdJI3v2gUl7cO+tE0
         kgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761057018; x=1761661818;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=72EdVUvWUCeeRDpijDC/64Xkq93xQ0f8jqeBT4LAAk8=;
        b=Axt6jEc+f7ZZX0jl/iGeGPuFew3RcnXH+YASaMmaF8ZsEoe/+RkCe++vgdFG/2uOTe
         8CD4YA36BFBi0t+v6RizKVJYefXsS+LSRf3LlTrjgYP877v9bZhBHTJ+TtjZYDRy6sLs
         kl1w/TKvhiOhA4G5mcwexjRMoQM7BwpamedrNHeJytTjNZrZC1bKDoqJZ6njFv3643Gt
         LDWhiKQv3So9dGMYFW5rzXhAjz6/0USl8oA2QDuFfB1lCvfVROxwTimvDvauZX3DeHSF
         LcMGwzljQ3I+575L2+KEtcAU1wimAtMjMGJVmj6z46GVdhqPpYvhpYocj5EdNNQwMZaN
         bWcA==
X-Forwarded-Encrypted: i=1; AJvYcCV+BVeF9ECoeeUrsfyIlVUJxsFn1Z819BxA6km4TY21UKNtxDLfL4EvthnqE64jKCW+CfvYBBZjDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRSkZlJsXziEwwIXTaiIauB4UUhhjPMP7YDBTBb+/7v/Ca0itx
	OW/UCc1e3AHt5yVSDhQYNEJ3bBFCNwcokoU6J+uHx/oKrpym1zwK8s2l1tYyevF6YEs=
X-Gm-Gg: ASbGncvMjGubAjBdjUt6DritwUJbi/WyqveqmtuGEP07eZ0hpCYr0m9SnsgQfIMk34s
	oV4IcAPT3Ov3CFkgWJ4UaNxZPSGDmUkLBqP/76NMGmvBOfWC4Rww5OtGC+k7xBhB7m4QJTGSXv5
	q/DSfX/Li1AHk/k5fUGxFDJSAcJfRf4ZhiXGozD57VWRQYeLG6WC9/c9y//kqu5Mmq1xZAkgpBS
	Va1Q3EoteD5LG3Ozqd6zZPRVi2GMPQdTqCle0RYXnh0txgZ1BRDSLqLrZTDVvqYyWMESpqEOJVZ
	BK5yZnXPNw/CQWTU1kWP1ZpRYfILfu41hSePuWG8M2zPeGB6DP17vkgu8tK5RHBgoht8LcZf1Xb
	r4/8sYtf9V9YibbOJqamXr0coSDnvdCglhFZXXBt3gCycdHwk4fAxIwLO5l+RqqRVTiZvMtNgQW
	GS3mY8+iJgJOP/V7e05azZKRGNLBQO9Mc68K8mOjuRwI+/
X-Google-Smtp-Source: AGHT+IEqyxsWbC/jVX5CbA9miNQ3uKmcnqiXwB8tEcbEEj4Zq2w3qQ5vOuYWSkkg5NxKrD2+uN5BRg==
X-Received: by 2002:a05:6a20:431a:b0:334:a327:b0df with SMTP id adf61e73a8af0-334a85d88c3mr20566089637.29.1761057017712;
        Tue, 21 Oct 2025 07:30:17 -0700 (PDT)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010e24fsm11510899b3a.57.2025.10.21.07.30.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2025 07:30:17 -0700 (PDT)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Sergey Senozhatsky'" <senozhatsky@chromium.org>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>,
	"'Christian Loehle'" <christian.loehle@arm.com>,
	"'Linux PM'" <linux-pm@vger.kernel.org>,
	"'LKML'" <linux-kernel@vger.kernel.org>,
	"'Artem Bityutskiy'" <artem.bityutskiy@linux.intel.com>,
	"'Tomasz Figa'" <tfiga@chromium.org>,
	"Doug Smythies" <dsmythies@telus.net>
References: <4687373.LvFx2qVVIh@rafael.j.wysocki> <5f0aa630-b30a-44c4-a52c-e08179cd3bf9@arm.com> <CAJZ5v0gBtv0bpK2swkc6D0AmanpKAvqO53dgRp2e7p9cWAM3TA@mail.gmail.com> <28ecb23b-ecee-409a-9771-24f801081d07@arm.com> <CAJZ5v0jMoEVUaYYPx6EtHFxsg6TF-QtDWJGrasGK7C2C+JxOFw@mail.gmail.com> <001801dc4041$607c19f0$21744dd0$@telus.net> <x4qvjfwxzatm6wnrtqgue7y673oqzo74i6ysmxalvnts5olkot@ekaee62fjg5l>
In-Reply-To: <x4qvjfwxzatm6wnrtqgue7y673oqzo74i6ysmxalvnts5olkot@ekaee62fjg5l>
Subject: RE: [PATCH v1] cpuidle: governors: menu: Predict longer idle time when in doubt
Date: Tue, 21 Oct 2025 07:30:17 -0700
Message-ID: <001201dc4297$3903af70$ab0b0e50$@telus.net>
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
Thread-Index: AQEHjVQKCrlPynWgLAaVpIarC+pGJQGZtDQKAi3SGCUCWYi7hgLZuqUGAZPsdfIBj3Y3ebYVH1IA
Content-Language: en-ca

On 2025.10.20 20:43 Sergey Senozhatsky wrote:
> On (25/10/18 08:10), Doug Smythies wrote:
>> On 2025.10.18 04:47 Rafael wrote:
>>> On Fri, Oct 17, 2025 at 8:37=E2=80=AFPM Christian Loehle wrote:
>>>> On 10/17/25 10:39, Rafael J. Wysocki wrote:
>>>>> On Fri, Oct 17, 2025 at 10:22=E2=80=AFAM Christian Loehle wrote:
>>>>>> On 10/16/25 17:25, Rafael J. Wysocki wrote:
>>>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>>>
>>>>>>> It is reported that commit 85975daeaa4d ("cpuidle: menu: Avoid =
discarding
>>>>>>> useful information") led to a performance regression on Intel =
Jasper Lake
>>>>>>> systems because it reduced the time spent by CPUs in idle state =
C7 which
>>>>>>> is correlated to the maximum frequency the CPUs can get to =
because of an
>>>>>>> average running power limit [1].
>>=20
>> I would like to understand Sergey's benchmark test better, and even =
try
>> to repeat the results on my test system. I would also like to try to=20
>> separate the variables in an attempt to isolate potential =
contributors.
>>=20
>> To eliminate the PL1 effect, limit the CPU frequency to 2300 MHz and =
repeat
>> the test. To eliminate potential CPU frequency scaling contributions, =
use the
>> performance CPU frequency scaling governor. Both changes at once =
would
>> be an acceptable first step.
>>=20
>> Sergey: Would you be willing to do that test?
>
> Apologies for the delay.
>
> Sure, I can give it a try sometime this week, am dealing with a bunch
> of other stable regressions right now (will report separately).
>
> Can you please help me with the configuration steps?  CPU freq =
limiting,
> etc.

For your system booted with "base" and "revert" do:

echo performance | sudo tee =
/sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
echo 2300000 | sudo tee =
/sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq

then do your test.

>
>> Sergey: Could you provide more details about your test?
>
> We track regressions in a number of tests.  The one I'm running more
> often than others is a Google Docs test (our tests replicate real use
> cases).  The test in question creates new google docs (in chrome, of
> course) and inputs some text in them (with various words-per-minute
> settings - 60, 90, 120 wpm) in English, Japanese, Korean and other
> languages; different font faces, different styles (bold, italic),
> text highlighting/selection, windows switching, and so on.  The test
> measures input latency, the number of dropped frames during scrolling,
> CPU usage, power consumption, etc.

Okay, Thanks. So not a test I can repeat on my test computer.

... Doug



