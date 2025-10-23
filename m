Return-Path: <linux-pm+bounces-36683-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ED064BFED90
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 03:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C50FF4EF741
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 01:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E28199230;
	Thu, 23 Oct 2025 01:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="LZnGxTaU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AFCEADC;
	Thu, 23 Oct 2025 01:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761182876; cv=none; b=EgnVgi0I+QYuzbpUEu8UgXi0ZpA4efeJdYQfjcY7Xmh4FiJs0t22we+JENk01d/5GMeJhPO5TCtQ9qRgj75GJxH8Rdy5D58cjZ5f6duQT7go9E1qP5uqPgHkgE2mCNbWgaGlWj3naT4Djl4rQhj7EICP3gBfypIHmwNees1RowQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761182876; c=relaxed/simple;
	bh=7uTZuWv2cNlK8eryDymfq5OnX6+sdUDtWolkNanxhw0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=EukPHLw+dElnmiQP66ZSgTBAO5eusS+6P5Fe9tVzT5OiP0oV3gWJD8H+hT8OssOdA514oT4va4TbQ1HlcOEmo83/iKfTT8BJedeF+AOI/XAEJZz5YhniBUA1bHsmEbM0N+Ewscz+3jSjRdo8e6PqvLmzi/Md21McX5dOPSKFmRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=LZnGxTaU; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 59N1QtvK2543238
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 22 Oct 2025 18:26:56 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 59N1QtvK2543238
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025092201; t=1761182818;
	bh=mXHwrAsRkwn/Qu1fpL5w/F9o+mSHAOdEPWFNeYZa7M8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=LZnGxTaURdxwDUo+sDpQhbpg9qH57co5lRtxDB11NnX/Bvzgt/mZuwIjsVzG0mshx
	 z24en1i2UHaziQnmdEWrnl7rWxWwlcxZXKDLlEq9EEfSGfjqq5ThPsLes6Jpee08ee
	 Dmmp7S4Px+72BEoRnVEtu0VuKPza0RioCM5BHvgxnETnflj+8o5WUQzz7FY2h8ZpbX
	 dgMYBpV13LbEweMCv73pqRqQcowN9bXNqFJ1VeApHlww44LmG+Dn2XMYGbXJGrp0cn
	 BKOcKQ6OY3WTco9xlasoaPUN/+YVpNELL/dfpEwaV09232HlrMHgtA+5J2ofmbGuDk
	 F0W+vnb58Sz3A==
Date: Wed, 22 Oct 2025 18:26:55 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Pavel Machek <pavel@ucw.cz>
CC: Dave Hansen <dave.hansen@intel.com>, Fam Zheng <fam.zheng@bytedance.com>,
        linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        linyongting@bytedance.com, songmuchun@bytedance.com,
        satish.kumar@bytedance.com, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>, yuanzhu@bytedance.com,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, fam@euphon.net, x86@kernel.org,
        liangma@bytedance.com, Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, guojinhui.liam@bytedance.com,
        linux-pm@vger.kernel.org, Thom Hughes <thom.hughes@bytedance.com>
Subject: Re: [RFC 0/5] parker: PARtitioned KERnel
User-Agent: K-9 Mail for Android
In-Reply-To: <aPjJ53F8kBV0/wLH@duo.ucw.cz>
References: <20250923153146.365015-1-fam.zheng@bytedance.com> <40419dea-666e-4a8d-97a7-fa571d7122f4@intel.com> <AEC34AE1-AEB5-4678-AC9D-39155E97D86C@zytor.com> <aPjJ53F8kBV0/wLH@duo.ucw.cz>
Message-ID: <8363F839-4A11-4E5D-A34E-CBFCC1588886@zytor.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 22, 2025 5:11:19 AM PDT, Pavel Machek <pavel@ucw=2Ecz> wrote:
>On Wed 2025-09-24 12:01:52, H=2E Peter Anvin wrote:
>> On September 24, 2025 8:22:54 AM PDT, Dave Hansen <dave=2Ehansen@intel=
=2Ecom> wrote:
>> >On 9/23/25 08:31, Fam Zheng wrote:
>> >> In terms of fault isolation or security, all kernel instances share
>> >> the same domain, as there is no supervising mechanism=2E A kernel bu=
g
>> >> in any partition can cause problems for the whole physical machine=
=2E
>> >> This is a tradeoff for low-overhead / low-complexity, but hope in
>> >> the future we can take advantage of some hardware mechanism to
>> >> introduce some isolation=2E
>> >I just don't think this is approach is viable=2E The buck needs to sto=
p
>> >_somewhere_=2E You can't just have a bunch of different kernels, with
>> >nothing in charge of the system as a whole=2E
>> >
>> >Just think of bus locks=2E They affect the whole system=2E What if one
>> >kernel turns off split lock detection? Or has a different rate limit
>> >than the others? What if one kernel is a big fan of WBINVD? How about
>> >when they use resctrl to partition an L3 cache? How about microcode up=
dates?
>> >
>> >I'd just guess that there are a few hundred problems like that=2E Mayb=
e more=2E
>> >
>> >I'm not saying this won't be useful for a handful of folks in a tightl=
y
>> >controlled environment=2E But I just don't think it has a place in
>> >mainline where it needs to work for everyone=2E
>>=20
>> Again, this comes down to why a partitioning top level hypervisor is Th=
e Right Thing[TM]=2E
>>=20
>> IBM mainframes are, again, the archetype here, having done it
>> standard since VM/370 in 1972=2E This was running on machines with a
>> *maximum* of 4 MB memory=2E
>
>Is there a good resource on IBM mainframes, prefferably written in
>language that can be understood by mostly x86 kernel hacker?
>
>BR,
>								Pavel

I don't know=2E=2E=2E perhaps ask the s390 guys?

