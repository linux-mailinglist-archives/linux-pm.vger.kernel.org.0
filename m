Return-Path: <linux-pm+bounces-35303-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA1BB9BD3C
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 22:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D88941B27A94
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 20:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3CA2153E7;
	Wed, 24 Sep 2025 20:16:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56CD1F2B88
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 20:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758744994; cv=pass; b=cGNdwSJA/gUE31rPtOL3k2DUGU0fc1usBLxRAMAgIuFTo0bkWycnABmVNvJH99n+sBjZoNtwqmwHIqLAjsQq40SQXYUzOYcGOtTrX2ulBWxmk6wM3cMvZKPuFo7/02zySaXPQItUvON4UzEcWrai2IHnmMA0sTQaEamzIGeV0Xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758744994; c=relaxed/simple;
	bh=z9Y2IcTYyhS9Y+0b7OFPXI5bO+NtfGTy5FCNaMGTFfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AcmRCfR5aB8YEgNIKIcMEiHHodsW90VtWm/Xg4upsAlDKAjdzOcG0ng09FIRopTcJ7TETRopqvLwFbvVIA5VKN+agDlZH7bm/Xu1DlgqZirRyF87ZtjfRGqScPhifHvua7yvtbcgYA2KH8zYPEXxScRDL8CEKoARrD9O+HAbHfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=euphon.net; spf=pass smtp.mailfrom=euphon.net; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=euphon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=euphon.net
ARC-Seal: i=1; a=rsa-sha256; t=1758744904; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Chhd2malt96fZaLjoEnSspcAYsuh71Ou8vErEojkDAct6s7ByFO5bfz4aKXMD2DwM3SdwvlrQHpNKG0GuNy1rkddwqWyGFjspG6QSvj4JslFnDYCIGTkOmhX7i+l3iqKUaW/AePHr1ZXz1dRAm78So7y/bnZWcyDTcUtRqG3PWI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758744904; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Reply-To:References:Subject:Subject:To:To:Message-Id; 
	bh=z9Y2IcTYyhS9Y+0b7OFPXI5bO+NtfGTy5FCNaMGTFfs=; 
	b=eG05AjKTjQ3pqbKFfXAx+CIATfgTJB2v8+v95mdGwPYxx+9j7JrnTc73CXaXQgyWlYOvLtsrOVBPixJapiID43sxWVNEf9Iwc24tOpW5CEMoZVJvhjQA6T6lwbe5h/XCyfktIBOIVD+4zdbYeNBcatj6iQhDpcsL+lrDP5VNKK0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	spf=pass  smtp.mailfrom=fam@euphon.net;
	dmarc=pass header.from=<fam@euphon.net>
Received: by mx.zohomail.com with SMTPS id 1758744903293298.31353121557265;
	Wed, 24 Sep 2025 13:15:03 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-8eeeeb37cc5so20906939f.0
        for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 13:15:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXo9ZFQWA6mHlYJtqVf7CbVgIt3RkbtcEM8iJr7aJqEPBjPc1pZtCeQ442mg1Fx/M8uP6dqi89l5g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8gdNC9ySPvfpPz2Q69E532nY5wJmE4DM++dYWl9xHYX5lJUAG
	bdsHEesT8iXMeA4xQC72BfnIrv05AlHCCZo2/DsiOutL79A17BhgPcRo1Mt4cV3iMK7Jw7FsYYr
	MGKOsX+Aj64+i4Z9FbuBhRDraqdWkVuc=
X-Google-Smtp-Source: AGHT+IHo3cRD727FoBpTzjSb3ODevUGf7xcwfz+BAxpGUAt0Fib3xEjCeu8N7kSWseIRUw0++Nyg4seYa6KpUPvZ8jk=
X-Received: by 2002:a05:6e02:1d86:b0:424:57d:1a50 with SMTP id
 e9e14a558f8ab-425955ed837mr18175745ab.11.1758744902713; Wed, 24 Sep 2025
 13:15:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923153146.365015-1-fam.zheng@bytedance.com>
 <40419dea-666e-4a8d-97a7-fa571d7122f4@intel.com> <AEC34AE1-AEB5-4678-AC9D-39155E97D86C@zytor.com>
 <CABgc4wTjc9nxmB16LkxiOL5gYO9K8kr46OqM=asyUkX7cT50Sg@mail.gmail.com>
In-Reply-To: <CABgc4wTjc9nxmB16LkxiOL5gYO9K8kr46OqM=asyUkX7cT50Sg@mail.gmail.com>
Reply-To: fam@euphon.net
From: Fam Zheng <fam@euphon.net>
Date: Wed, 24 Sep 2025 21:14:26 +0100
X-Gmail-Original-Message-ID: <CABgc4wThvZrxBLb0JRiROCws12qLNUxwcb4cJa_W63qh41apjg@mail.gmail.com>
X-Gm-Features: AS18NWAwzAeqcUbRqM-zteEYsDi9I9ZtA0NHRrjSVKFDmg21-neJ1rSM6NNvPzg
Message-ID: <CABgc4wThvZrxBLb0JRiROCws12qLNUxwcb4cJa_W63qh41apjg@mail.gmail.com>
Subject: Re: [RFC 0/5] parker: PARtitioned KERnel
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Fam Zheng <fam.zheng@bytedance.com>, 
	linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>, 
	linyongting@bytedance.com, songmuchun@bytedance.com, 
	satish.kumar@bytedance.com, Borislav Petkov <bp@alien8.de>, 
	Thomas Gleixner <tglx@linutronix.de>, yuanzhu@bytedance.com, Ingo Molnar <mingo@redhat.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, x86@kernel.org, 
	liangma@bytedance.com, Dave Hansen <dave.hansen@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, guojinhui.liam@bytedance.com, linux-pm@vger.kernel.org, 
	Thom Hughes <thom.hughes@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

On Wed, Sep 24, 2025 at 9:10=E2=80=AFPM Fam Zheng <fam@euphon.net> wrote:
>
>
>
> On Wed, Sep 24, 2025 at 8:02=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wr=
ote:
>>
>> On September 24, 2025 8:22:54 AM PDT, Dave Hansen <dave.hansen@intel.com=
> wrote:
>> >On 9/23/25 08:31, Fam Zheng wrote:
>> >> In terms of fault isolation or security, all kernel instances share
>> >> the same domain, as there is no supervising mechanism. A kernel bug
>> >> in any partition can cause problems for the whole physical machine.
>> >> This is a tradeoff for low-overhead / low-complexity, but hope in
>> >> the future we can take advantage of some hardware mechanism to
>> >> introduce some isolation.
>> >I just don't think this is approach is viable. The buck needs to stop
>> >_somewhere_. You can't just have a bunch of different kernels, with
>> >nothing in charge of the system as a whole.
>> >
>> >Just think of bus locks. They affect the whole system. What if one
>> >kernel turns off split lock detection? Or has a different rate limit
>> >than the others? What if one kernel is a big fan of WBINVD? How about
>> >when they use resctrl to partition an L3 cache? How about microcode upd=
ates?
>> >
>> >I'd just guess that there are a few hundred problems like that. Maybe m=
ore.
>> >
>> >I'm not saying this won't be useful for a handful of folks in a tightly
>> >controlled environment. But I just don't think it has a place in
>> >mainline where it needs to work for everyone.
>>
>> Again, this comes down to why a partitioning top level hypervisor is The=
 Right Thing[TM].
>>
>> IBM mainframes are, again, the archetype here, having done it standard s=
ince VM/370 in 1972. This was running on machines with a *maximum* of 4 MB =
memory.
>>
>> This approach works.
>>
>> Nearly every OS on these machines tend to run under a *second* level hyp=
ervisor, although that isn't required.
>
>
I'm trying to think about the hypervisor approach you mentioned, but
if it doesn't provide memory and I/O isolation, what is the advantage
over this RFC? (if it doesn I think then we're talking about a
specially configured KVM which does 1:1 vcpu pinning etc).


Sorry, forgot to turn off email html mode in my previous message..


Fam

