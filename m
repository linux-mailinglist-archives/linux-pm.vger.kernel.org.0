Return-Path: <linux-pm+bounces-32204-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF95CB2161B
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 22:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D73F61A23F28
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 20:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6DD26E71F;
	Mon, 11 Aug 2025 20:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yuNQ41UY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD68311C0D
	for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 20:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754942501; cv=none; b=AcQTc+Umo1CX1ipPZCZWYdjMBQgf1nKD7GU7ouaBPy69VP5tcy6c5KhcXheS/d1QEkg1tMIHjjH88IHLBY0sOhry7uC74M6U3omlpNQJ8OZpEVI2tQ4EA9OUwado/+Xpa03NchLamkSTNJ1iRAIjC5UI8h6bjLfuOzqGY8ifDH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754942501; c=relaxed/simple;
	bh=jOX/yi6Sr7HDRcgpvbqyoAghNh0K1oDzjkbmmkbvKD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttjU2DPpB3Tzt7w40xmVSQA47azh128smyZRk8iV7wCYAY+eDENB6HgqJB8wzb2e/Ku7wZxvElSQgMCBkj/XZzveCrSAUB2rsxj6KampCM3Rz26yUrkxZnQ7P8x8CsumSVSgwy4JlJFQYFl5UpsKyzr8XRrKcrDWPFLU8lmfjyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yuNQ41UY; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-242d1e947feso52025ad.0
        for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 13:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754942499; x=1755547299; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Uxu6bAv2s8t/rSMFonYcPqI4bnsiyjgAqz2CcsGMxA4=;
        b=yuNQ41UYJZ0D6vLEbIR+F79840UwLPDbJqWnKpXS0LVclZ5xprRc590TJm8EBBAVYP
         P0Ibebn74eskIImcCpT28kbLsn/C4er2plysCtNG9OFjrfLrH6u06loNFgKpQkhkWVKs
         CtRK0DOS/Hz2uMSbNaIQObbhIyJy3Q590UOAFBu2g7iIScQ2gQNTlNlwt8ttMBveTCWZ
         nuqXpmVSAju5KNVlzvciIlsKiMH8C4P+RhrhSvZckZAt3ZkkUiTOS11/IjubTY+VLLwO
         SrknSdy+2Pi3kPp0P962Bdvy+/67aOVio5EHHKJDoMY+Mq89YA6o4/jN+V8tBZ7Ehslc
         iYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754942499; x=1755547299;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uxu6bAv2s8t/rSMFonYcPqI4bnsiyjgAqz2CcsGMxA4=;
        b=XyWB7K8JACh7CZiPywgTCqDB3YAtv6NNRwfH/aIpY75zl7DKMHpbjDr/GrxXmXuL3F
         9PSs/OBmvvR+tT96beG67IMf7ZdfAN2u4BOa4nlF8ISrd8EyIX0dOvcopB6swcUlwWNa
         icSoGIEvgexAVQjQ+3p+6buqCmTgtFM66I9qmtT9KyvIhkRH7gDSBA2gnC4GeQ9y2WiG
         6PlxoJeZQfoyCJQUXgFyfQbG1OqTPtrIQS86RLBNAE7bIDsM4pLIr/ms9qajudSJCggV
         HtqVte7fZ+8xaHeL6sIA7kfGZciEYXfgj8pmif9FEEroxStaWkkKTwlzUa+qpapzs1xg
         Ytow==
X-Forwarded-Encrypted: i=1; AJvYcCXF7SEy37GjJTT3ot8BqsNjojafEuAF0fzYVB/zrMCi0gHlp9ZgxyGtjiKroZHJZKZPdl/VPYXsTA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Vr8RkkOsERHxli13Sx9P8gIgJHw+ZWymKf0RmzxOATuMrJpa
	HUJxqbiQrgLBLE73v5G+kRvO5RG+l50rIiVKpBxR6dCOvhQmqaLqPraGt4flX2J/AA==
X-Gm-Gg: ASbGnctxlzZw9KIYrWbppU8Om3AcU8gPHZbfNSgL6aEIFq+73SH8stfx+sCYMOgXP+g
	Uto/tcDj/NDHIqJHDJA1SCIY1jKVfBKT98EnFca+ZjmmUuxb/bCKpVCTeyTKTSG232h3INhliaA
	OZ28/W9MkGFiKmSSnJiX02tBPZIMbwI/hmPy7LuV3iqf/uTCY4T6AOqzGUIikXAa2cDze5/vzHs
	8guTZKBE7y7fwzsWaxIJvYKAJfv8GLyUDtV/iRjOK2pLXI7wGJ8u7rR8y/QC7E3BopJZkkLE8AP
	dAvdwm4KdcW7Lh3LW/BI+0muawZJETswIap7vip2qfVEI6Ex7GTjIHF+s95c3Jv3iwS7aUxzgf4
	GQemSq59/dv2HlDJofqA9DVPOF//KLj/k/u9XNC89LQ//a4MXesAw1I2cvefXFg==
X-Google-Smtp-Source: AGHT+IHWVG7hRlBUUjOqMUzLmXjVMwuf4DXMXom2zlwHcibkKbddyA0lvszzB+bNunnpUz4zMDVEPQ==
X-Received: by 2002:a17:903:234d:b0:23d:eb0f:f49 with SMTP id d9443c01a7336-242fd374f19mr683595ad.14.1754942499222;
        Mon, 11 Aug 2025 13:01:39 -0700 (PDT)
Received: from google.com (167.212.233.35.bc.googleusercontent.com. [35.233.212.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8f911sm27711067b3a.47.2025.08.11.13.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 13:01:38 -0700 (PDT)
Date: Mon, 11 Aug 2025 20:01:34 +0000
From: Prashant Malani <pmalani@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Beata Michalska <beata.michalska@arm.com>,
	Jie Zhan <zhanjie9@hisilicon.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	z00813676 <zhenglifeng1@huawei.com>, sudeep.holla@arm.com
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
Message-ID: <aJpMHkrWJIyHtHL5@google.com>
References: <CAFivqmLG0LriipbmM8qXZMKRRpH3_D02dNipnzj2aWRf9mSdCA@mail.gmail.com>
 <CAFivqmJ4nf_WnCZTNGke+9taaiJ9tZLvLL4Mx_B7uR-1DR_ajA@mail.gmail.com>
 <aIso4kLtChiQkBjH@arm.com>
 <20250731111324.vv6vsh35enk3gg4h@vireshk-i7>
 <aIvQvLL34br6haQi@arm.com>
 <20250801044340.6ycskhhkzenkzt7a@vireshk-i7>
 <CAFivqm+gBBSCoVUxmeatu8TjwunzBtfjeDMNBL0JCsPhkFEg5A@mail.gmail.com>
 <20250811060551.ylc6uutni4x6jqtg@vireshk-i7>
 <aJo5vP_mfBn_vxSF@google.com>
 <CAJZ5v0jvYBUPjSmXas+S8rOG2WAb5u7rk92Gbu1s7A=tJr4VPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jvYBUPjSmXas+S8rOG2WAb5u7rk92Gbu1s7A=tJr4VPA@mail.gmail.com>

On Aug 11 21:19, Rafael J. Wysocki wrote:
> On Mon, Aug 11, 2025 at 8:43 PM Prashant Malani <pmalani@google.com> wrote:
> >
> > On Aug 11 11:35, Viresh Kumar wrote:
> > > On 06-08-25, 17:19, Prashant Malani wrote:
> > > > So, do we have consensus that the idle check is acceptable as proposed?
> > > > (Just want to make sure this thread doesn't get lost given another thread
> > > > has forked off in this conversation).
> > >
> > > I don't have any objections to this or a better solution to this.
> >
> > Thanks Viresh! Beata, can we kindly move ahead with the idle
> > optimization (which is this series), while we continue discussions for
> > the "under load" scenarios on the other thread?
> 
> I need some more time, please?
> 
> This problem is similar (if not analogous) to what happens on x86 and
> that is not handled in the cpuidle core.

My apologies! Didn't mean to rush.

Will stand by for updates.

BR,

-Prashant

