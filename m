Return-Path: <linux-pm+bounces-5889-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF62389750B
	for <lists+linux-pm@lfdr.de>; Wed,  3 Apr 2024 18:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18E10B22112
	for <lists+linux-pm@lfdr.de>; Wed,  3 Apr 2024 16:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BEC14EC5B;
	Wed,  3 Apr 2024 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b0AFMhed"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7983DB9B
	for <linux-pm@vger.kernel.org>; Wed,  3 Apr 2024 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712161054; cv=none; b=tS2X26sTeZsmBCzcUP4j73R2K4lbA3VKH8GMAa9YxcW6jdg2RmYI2QmL8OVmFqw1jbn8q0PmjN9ZNbmbf7aBvLZNMAwXArpTgI7IR+l5/gAAtvXYUdm4/nOptyI6iKo0CJT/ipjHeYQUG1EbPSOU9bZVjIq3n5mgh1ouxCMPCh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712161054; c=relaxed/simple;
	bh=/oHz60YmomB8xtLx1SmFXh+ChYzmFb8LPQK3p7ehSUc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D7K3faTDhP0wamg/XoBXQgXH6pzdhqVh6BP6fyk6xwRChoi/q206AHWY+qHtoGuIGOww9xOf3mLPxyQfdNF3N6OmEVFyVb1u/dV7KBDDgBaWiCpBK17Y+4jUlNJU+Vmhgx5uzqW3uDuYCFECLhpOEubg/TWI3Eu+9ppjsd2c0MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b0AFMhed; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712161051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OQm7KJ2wxSLm5O0upddCNpxjqnodHhe0dn1TWqhcwVM=;
	b=b0AFMhedKxFhZ29g//n8fiDhSzNn0DiL5DDEZ+r0C4uVuRqhTC+Kk9HOS2fR38CLqexP75
	rLHTuirUcfrey97QLZ7zg2HuuN7L9a7ovmqOxyrDFHZ0UssD/wdSc+N9JjFcGDUUHp6oUf
	0REMtTek5i2dRWAjf/+AsUhZaPsLRsU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-14KVG30ZMnS6AWdnzj0T_A-1; Wed, 03 Apr 2024 12:17:30 -0400
X-MC-Unique: 14KVG30ZMnS6AWdnzj0T_A-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-78a090f8d45so214105785a.0
        for <linux-pm@vger.kernel.org>; Wed, 03 Apr 2024 09:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712161050; x=1712765850;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQm7KJ2wxSLm5O0upddCNpxjqnodHhe0dn1TWqhcwVM=;
        b=hJf2aTNX2VtbDtmkcd7CVk33IZvBDRoqs6eVoIzHpp4q6vEbeM89sS1+A9G7KJjws1
         OssIuRqXXvRBuyFWximGjvBwmE41myHBU9Fc9faTtwUAymvwsnCz348ZEPkkBSKMPJAO
         lvP5yhCXbeM4LsMGdy7k2y3+U8XD2w785AzIElPj1v4M1riSwfqm1PsXxvDYC3KLdlmi
         HbiVWNwWT1jZ590HHKhTopyg3j8AMy8Lm42q9R8pNzSmqUEmocBGRXKLjk1Ga4850Zki
         TzcWnuLvDTiyvTa/40wI6fpY5FpWqv4ewDJTEro/X7zGgsdjHNTn0hGNUloVaVus0AcH
         ZHMg==
X-Forwarded-Encrypted: i=1; AJvYcCXc2RtXM5bKGwYKBIgi0RfeknPn/zaDCEMVW+SkDwr3aJN6pMrtoCdCabTZbpkF0XnaBznPwYZEOg0ecFl13G0qOO8q9PHQ8Ao=
X-Gm-Message-State: AOJu0Yy2N1wcHLYaHqnMRMC001PUymPrx45n4zG3x/mPAEb6saFwqfnN
	3Zj+kwwLULqHm0s/Jiuo3jDaKP2N+nbmr0ttJy+3SfEhp87iC3TfcIOkQZ94ztkmYxYC44uRzTT
	lddJ1tqY/nhtZXLpOJoQaX5crDU9gZw3q7eOdm1uDhMwzHxz7gIXkY3Ld
X-Received: by 2002:a05:6214:4a5b:b0:696:926e:dfe3 with SMTP id ph27-20020a0562144a5b00b00696926edfe3mr4445017qvb.22.1712161049919;
        Wed, 03 Apr 2024 09:17:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHR3C2HuuS83Z+oeOqPEr+EoDC/KiDUbG8jZaKkAfFo7rb5+8xu5HIXGjsbFTYHuv5C36xqTg==
X-Received: by 2002:a05:6214:4a5b:b0:696:926e:dfe3 with SMTP id ph27-20020a0562144a5b00b00696926edfe3mr4444998qvb.22.1712161049636;
        Wed, 03 Apr 2024 09:17:29 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id oo14-20020a056214450e00b00690c9256676sm6614401qvb.49.2024.04.03.09.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 09:17:29 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Waiman Long <longman@redhat.com>, Michal =?utf-8?Q?Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, Johannes
 Weiner <hannes@cmpxchg.org>, Thomas Gleixner <tglx@linutronix.de>, Peter
 Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Shuah Khan
 <shuah@kernel.org>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org, Frederic
 Weisbecker <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Alex Shi <alexs@kernel.org>, Vincent Guittot
 <vincent.guittot@linaro.org>, Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH 1/2] cgroup/cpuset: Make cpuset hotplug processing
 synchronous
In-Reply-To: <620d1b70-cfbc-4b76-ad04-b3be559afd56@redhat.com>
References: <20240401145858.2656598-1-longman@redhat.com>
 <20240401145858.2656598-2-longman@redhat.com>
 <kce74bx6aafxfuw5yovaschym4ze4kommfk74eq5totojytest@mdxnfvl2kdol>
 <548efd52-e45f-41fa-a477-bc5112d7b00c@redhat.com>
 <u3naomgv34t5rnc7pmyy4zjppgf36skeo45orss2xnqcvtrcez@m74tsl2ws76f>
 <7e62b37d-6c9c-4e55-a01a-175695475cb5@redhat.com>
 <xhsmhedbmbjz5.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <620d1b70-cfbc-4b76-ad04-b3be559afd56@redhat.com>
Date: Wed, 03 Apr 2024 18:17:25 +0200
Message-ID: <xhsmh8r1ubeui.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/04/24 10:47, Waiman Long wrote:
> On 4/3/24 10:26, Valentin Schneider wrote:
>> IIUC that was Thomas' suggestion [1], but I can't tell yet how bad it wo=
uld
>> be to change cgroup_lock() to also do a cpus_read_lock().
>
> Changing the locking order is certainly doable. I have taken a cursory
> look at it and at least the following files need to be changed:
>
>  =C2=A0kernel/bpf/cgroup.c
>  =C2=A0kernel/cgroup/cgroup.c
>  =C2=A0kernel/cgroup/legacy_freezer.c
>  =C2=A0mm/memcontrol.c
>
> That requires a lot more testing to make sure that there won't be a
> regression. Given that the call to cgroup_transfer_tasks() should be
> rare these days as it will only apply in the case of cgroup v1 under
> certain condtion, I am not sure this requirement justifies making such
> extensive changes. So I kind of defer it until we reach a consensus that
> it is the right thing to do.
>

Yeah if we can avoid it initially I'd be up for it.

Just one thing that came to mind - there's no flushing of the
cpuset_migrate_tasks_workfn() work, so the scheduler might move tasks
itself before the cpuset does via:

  balance_push() ->__balance_push_cpu_stop() -> select_fallback_rq()

But, given the current placement of cpuset_wait_for_hotplug(), I believe
that's something we can already have, so we should be good.

> Cheers,
> Longman


