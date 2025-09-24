Return-Path: <linux-pm+bounces-35310-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3DFB9C5F6
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 00:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A50FD7A81BD
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 22:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD68296BAB;
	Wed, 24 Sep 2025 22:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="PFjenPcY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1182335957;
	Wed, 24 Sep 2025 22:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758753569; cv=none; b=OyDWk+54EsgW9fYrq/JOryeoFM90OyeM1gPNOvkZ0rBpdp2Otxf4LXaPP739j5rF0EwXpVpu3Zlm0tyqSr9z7CMGuTTJJuCHY6ogmXV5jvKibtDzQ6L3HqZpuaqAdy5GWA0g0cxTdf4GQUax5ot8YdIIvPCpeaoQ6Mx+A3rEC9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758753569; c=relaxed/simple;
	bh=1qHIe3pq9uBAbyYqTSY1hH3nK4OiqvJ7aJO8/VNUB8M=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=oJXP/GrklHjVIhIhRsxdkhm79Pz3lsYmfahEfim4G97NkMBlAe0Ym2URXnxAT8KGnbaHgIAbm1RGN4DYirIfRxW77OGquoIk6z0vqTb5INJA2iy3FvIVFp139HFQjdTiOvXs3yD4dIO69kWRLFjJuae/YrBxiRAeHzMv87zlGEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=PFjenPcY; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net ([172.56.209.143])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 58OMcDMu2177068
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 24 Sep 2025 15:38:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 58OMcDMu2177068
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025092201; t=1758753497;
	bh=1qHIe3pq9uBAbyYqTSY1hH3nK4OiqvJ7aJO8/VNUB8M=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=PFjenPcYivaESy1EO/JreI4D6a3rWQg+IqOPVFAPahEfNjSrXn7yvQkLZdlesr7Sf
	 KVbZGC/mloRiUKOGY8QWPwWEAH0840p4Dg9DF06JGb9FuqqJqRS6SfQ7kx+O9jzEiD
	 wuNkhXPr/xOz7Z7a0QJ0L7WFmXLEfKtER1DjQWF9CUYRYg6yttCTpRE5ikq9rPaFa5
	 jUP+gC+gyMF4gZU+AOm6pQIMYvakg1sHmsbKI01oSF2iozmocXFVeLYZZzOP2vQWJS
	 FkUCMpR/SUXUo6oNb1BLnxjDCopUtpfbuyIsDGbvT3qWLFiLSagqQ3A4euWjOQGe+K
	 nb69AYHAWDJNg==
Date: Wed, 24 Sep 2025 15:13:37 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: fam@euphon.net, Fam Zheng <fam@euphon.net>
CC: Dave Hansen <dave.hansen@intel.com>, Fam Zheng <fam.zheng@bytedance.com>,
        linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        linyongting@bytedance.com, songmuchun@bytedance.com,
        satish.kumar@bytedance.com, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>, yuanzhu@bytedance.com,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, x86@kernel.org, liangma@bytedance.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, guojinhui.liam@bytedance.com,
        linux-pm@vger.kernel.org, Thom Hughes <thom.hughes@bytedance.com>
Subject: Re: [RFC 0/5] parker: PARtitioned KERnel
User-Agent: K-9 Mail for Android
In-Reply-To: <CABgc4wThvZrxBLb0JRiROCws12qLNUxwcb4cJa_W63qh41apjg@mail.gmail.com>
References: <20250923153146.365015-1-fam.zheng@bytedance.com> <40419dea-666e-4a8d-97a7-fa571d7122f4@intel.com> <AEC34AE1-AEB5-4678-AC9D-39155E97D86C@zytor.com> <CABgc4wTjc9nxmB16LkxiOL5gYO9K8kr46OqM=asyUkX7cT50Sg@mail.gmail.com> <CABgc4wThvZrxBLb0JRiROCws12qLNUxwcb4cJa_W63qh41apjg@mail.gmail.com>
Message-ID: <585D086B-733C-4274-B274-794F360E8E33@zytor.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On September 24, 2025 1:14:26 PM PDT, Fam Zheng <fam@euphon=2Enet> wrote:
>On Wed, Sep 24, 2025 at 9:10=E2=80=AFPM Fam Zheng <fam@euphon=2Enet> wrot=
e:
>>
>>
>>
>> On Wed, Sep 24, 2025 at 8:02=E2=80=AFPM H=2E Peter Anvin <hpa@zytor=2Ec=
om> wrote:
>>>
>>> On September 24, 2025 8:22:54 AM PDT, Dave Hansen <dave=2Ehansen@intel=
=2Ecom> wrote:
>>> >On 9/23/25 08:31, Fam Zheng wrote:
>>> >> In terms of fault isolation or security, all kernel instances share
>>> >> the same domain, as there is no supervising mechanism=2E A kernel b=
ug
>>> >> in any partition can cause problems for the whole physical machine=
=2E
>>> >> This is a tradeoff for low-overhead / low-complexity, but hope in
>>> >> the future we can take advantage of some hardware mechanism to
>>> >> introduce some isolation=2E
>>> >I just don't think this is approach is viable=2E The buck needs to st=
op
>>> >_somewhere_=2E You can't just have a bunch of different kernels, with
>>> >nothing in charge of the system as a whole=2E
>>> >
>>> >Just think of bus locks=2E They affect the whole system=2E What if on=
e
>>> >kernel turns off split lock detection? Or has a different rate limit
>>> >than the others? What if one kernel is a big fan of WBINVD? How about
>>> >when they use resctrl to partition an L3 cache? How about microcode u=
pdates?
>>> >
>>> >I'd just guess that there are a few hundred problems like that=2E May=
be more=2E
>>> >
>>> >I'm not saying this won't be useful for a handful of folks in a tight=
ly
>>> >controlled environment=2E But I just don't think it has a place in
>>> >mainline where it needs to work for everyone=2E
>>>
>>> Again, this comes down to why a partitioning top level hypervisor is T=
he Right Thing[TM]=2E
>>>
>>> IBM mainframes are, again, the archetype here, having done it standard=
 since VM/370 in 1972=2E This was running on machines with a *maximum* of 4=
 MB memory=2E
>>>
>>> This approach works=2E
>>>
>>> Nearly every OS on these machines tend to run under a *second* level h=
ypervisor, although that isn't required=2E
>>
>>
>I'm trying to think about the hypervisor approach you mentioned, but
>if it doesn't provide memory and I/O isolation, what is the advantage
>over this RFC? (if it doesn I think then we're talking about a
>specially configured KVM which does 1:1 vcpu pinning etc)=2E
>
>
>Sorry, forgot to turn off email html mode in my previous message=2E=2E
>
>
>Fam
>

The difference is that this is highly invasive to the OS, which affects de=
velopers and users not wanting this feature=2E

