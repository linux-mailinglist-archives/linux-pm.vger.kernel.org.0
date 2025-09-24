Return-Path: <linux-pm+bounces-35295-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABD7B9B95B
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 21:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA2AF17B32D
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 19:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D31324728F;
	Wed, 24 Sep 2025 19:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="C6zVS0R8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88804245028;
	Wed, 24 Sep 2025 19:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758740573; cv=none; b=O0Ll2xNpy5UkI3yCiwiXDnuN+JmXAHNevOjv4XpJsyJFFHOr1liFfjVcd0r4UL1TYL1+BjIBEM5OXO5jlPSOEhxFMrZduHBVXnGCYxnwY4bLB8NZ/HyQ2zB1pLI2eIMqD+fYhWc0Fs/Wy/VcllMmBAZLJU1UoAMDI9COXUZT5QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758740573; c=relaxed/simple;
	bh=9fBWK7k1Rf1vLpHtgZBMHqyJT2G839ts4KtXsMJZmyE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=huYHIa1xZZTw2EVCYXQFo8969Lph/RAqxw2IKIWmbdcF73TkJMvlWThbbK4A6tL8xWGTkBZtqRUt2As/t8lT+7HUdJMM3/spSppkz858b/AsJ1CTlpWtZWClWN+znFAYSvRrLuVOZA7hDL1ghXQs6b5xUol8a1EUDI27S866XM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=C6zVS0R8; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 58OJ1ska2121518
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 24 Sep 2025 12:01:54 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 58OJ1ska2121518
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025092201; t=1758740516;
	bh=9fBWK7k1Rf1vLpHtgZBMHqyJT2G839ts4KtXsMJZmyE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=C6zVS0R8YnknObsBTcwa3u6kBokVTdm7XewZv0IPiZ9V3lr2egImqUFtZsyoxGl/A
	 MIqNLNfzj/5YdE//NHgr+D5ApVBs0TnjfTTGEpqQELXZj/ZtRZ7iuUYRGQFsYPsN1p
	 VMNK9xJdIPEDmWBbFu+Nmfm78qvYNUtsJqwlx/qPkUy3W9vhaT4g06W0sWUr1iJuZ9
	 d6I+ix2ynXLs674lK4NJ5oRnqgomf50Psxil13Yug0Zak/jH9HKishugqGkhSB2HiO
	 j8VJFb6m2ZXjUkffZJG5eLDEatrUV3EVURB9S+iH16saPnpyQx/PUe8FWyxt977/0w
	 bHGwcfErPaBZw==
Date: Wed, 24 Sep 2025 12:01:52 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Dave Hansen <dave.hansen@intel.com>, Fam Zheng <fam.zheng@bytedance.com>,
        linux-kernel@vger.kernel.org
CC: Lukasz Luba <lukasz.luba@arm.com>, linyongting@bytedance.com,
        songmuchun@bytedance.com, satish.kumar@bytedance.com,
        Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
        yuanzhu@bytedance.com, Ingo Molnar <mingo@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, fam@euphon.net, x86@kernel.org,
        liangma@bytedance.com, Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, guojinhui.liam@bytedance.com,
        linux-pm@vger.kernel.org, Thom Hughes <thom.hughes@bytedance.com>
Subject: Re: [RFC 0/5] parker: PARtitioned KERnel
User-Agent: K-9 Mail for Android
In-Reply-To: <40419dea-666e-4a8d-97a7-fa571d7122f4@intel.com>
References: <20250923153146.365015-1-fam.zheng@bytedance.com> <40419dea-666e-4a8d-97a7-fa571d7122f4@intel.com>
Message-ID: <AEC34AE1-AEB5-4678-AC9D-39155E97D86C@zytor.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On September 24, 2025 8:22:54 AM PDT, Dave Hansen <dave=2Ehansen@intel=2Eco=
m> wrote:
>On 9/23/25 08:31, Fam Zheng wrote:
>> In terms of fault isolation or security, all kernel instances share
>> the same domain, as there is no supervising mechanism=2E A kernel bug
>> in any partition can cause problems for the whole physical machine=2E
>> This is a tradeoff for low-overhead / low-complexity, but hope in
>> the future we can take advantage of some hardware mechanism to
>> introduce some isolation=2E
>I just don't think this is approach is viable=2E The buck needs to stop
>_somewhere_=2E You can't just have a bunch of different kernels, with
>nothing in charge of the system as a whole=2E
>
>Just think of bus locks=2E They affect the whole system=2E What if one
>kernel turns off split lock detection? Or has a different rate limit
>than the others? What if one kernel is a big fan of WBINVD? How about
>when they use resctrl to partition an L3 cache? How about microcode updat=
es?
>
>I'd just guess that there are a few hundred problems like that=2E Maybe m=
ore=2E
>
>I'm not saying this won't be useful for a handful of folks in a tightly
>controlled environment=2E But I just don't think it has a place in
>mainline where it needs to work for everyone=2E

Again, this comes down to why a partitioning top level hypervisor is The R=
ight Thing[TM]=2E

IBM mainframes are, again, the archetype here, having done it standard sin=
ce VM/370 in 1972=2E This was running on machines with a *maximum* of 4 MB =
memory=2E

This approach works=2E

Nearly every OS on these machines tend to run under a *second* level hyper=
visor, although that isn't required=2E

