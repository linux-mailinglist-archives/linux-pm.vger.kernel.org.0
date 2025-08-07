Return-Path: <linux-pm+bounces-32023-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5797BB1CF97
	for <lists+linux-pm@lfdr.de>; Thu,  7 Aug 2025 02:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D6FF18C399E
	for <lists+linux-pm@lfdr.de>; Thu,  7 Aug 2025 00:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29F2625;
	Thu,  7 Aug 2025 00:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vGAdm5yc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBE336D
	for <linux-pm@vger.kernel.org>; Thu,  7 Aug 2025 00:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754524923; cv=none; b=tDaMxgU8OGU+XXdcNif1a2UioYNz1iMudmjM0GGqG7Cqo7P/gAv/Da7EFrGeuNJ0IH4zm5tTCHHsRKHpZhClvGkQWFhrLttX7WDVkxz5b3fgP3oKpAE+sIAiCQqIkll8V2jmRpQqM/DBJtCQMV5GFWOltxnt/ftkFM6pIbL888Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754524923; c=relaxed/simple;
	bh=/HrV78szyJC/26YwUwTLBwcVGTJ2HBbTObkSJMIbXBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lTiiB51QtxDxaX7b6XkDO+WoSWEY40Pyd9uB++QjZK/Q2aa8kGRTiXXTjGL0eEzZJRmXEb5W3IuJW11z1+RCfiTbc37ApxHT0HUTSJXlQz9Rq/2zlyFi/Dnwa45rhapLXuVfo2KiaCRxZ9FRjdq/EtS4YYpcD/oco/dTK7164oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vGAdm5yc; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b07a5e9f9fso172471cf.0
        for <linux-pm@vger.kernel.org>; Wed, 06 Aug 2025 17:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754524921; x=1755129721; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/HrV78szyJC/26YwUwTLBwcVGTJ2HBbTObkSJMIbXBI=;
        b=vGAdm5ycsHoJIGNfJzXC9i9jSXEQbtG3AoPP8j1M5ufWr3TG5MliKXKCCNAvDaSMYH
         NCitO2C8VdKaSgWZwfRRlYptmgdMHFStOuPGQXaKh4ePdID8jTQSCgKaeZm9difBQ8ZV
         dqRl0QItGojrP3ge7HEedlFx/YQP6j+xiUl3jYSAJAaAdWU7jx/e0FM/pkeSTJNj3vMI
         o61DzHzJpjf+PPeTCZv7g/XDRiyopEB7ofeyl4T18GNuIDzPi5j/pjZ/gRj/aHWwFjsk
         yGvWcDxxc9DEmmAKimYNFNjnIOnAvTHUVP0osH91Ym0CpGXGXwIWDD1vBaTagYV76Jz7
         ZVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754524921; x=1755129721;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/HrV78szyJC/26YwUwTLBwcVGTJ2HBbTObkSJMIbXBI=;
        b=COxAX+HfzSC0Xp6/dVf0rtfKhFxJ+R57Ruah0OOUeL7egpLFN+Zus4TXheO+jOngKB
         M7VVKO7PZ+us53CGFka+2XFl0Mkv2gKnvJQEaEGdUTID4B5otTm9CB1vqwhui039JTcE
         zjpM5WUuV+kZnRey89lqS1rpwxcyv1YwTraImHjHpyhmRgAFZKw1JdV4yL2OluW9cbSp
         wEYVBD16m8y1VXX28VAVta+pHdlhdeo4bs+Aa48NTTIaWjkhfsl7BE5KAwHE0GEIk1Dv
         o5JMwM0YewLjPA5k0yyvZQpvVz86lIKzmJC2SIc8tLgL11tHd5tv/WkfkZCUjYCHp7ig
         XfAg==
X-Forwarded-Encrypted: i=1; AJvYcCXBySuleBQK9BHgow4EUCZezuuoyGLaNBwAPuy9aD1B2kKIfjtgOxX/fplQwtTKi1DnUfY5Bci4cw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxegN8vj46FtKRpbXqngkdWvIHRJePzgHRDQJPY9Kygi9H6PV4Q
	FhcRdo0ACzCG3mZKq5pyV6NmrexKYvSypWYuIJrqw6kMPFkir+XV0AqGPVL7S9tlDD8gdmOpZTQ
	wOHk5BbQ0dPjRkxU2e9eLobNv2o9PCEwx50yw8nVo
X-Gm-Gg: ASbGncta9kZEjn+/ycd4Ii1Q8NiPytJNi0cihSJZIJwM+Zlm6s0ivTrkAzON3GdfZrS
	lBOMJVAHq/tRe0sLLkQXNV0SUXrC27WcfkCxBk6ZNArQVjaAil9v5vpO/pp9IFObgW2fpD++w4J
	VxoMQfZBf6scN2us1XVXGVoyng4BXeF2I45w16lvZdh06mdw9jf3KpVqvrofCtt4xhtQXUIfZSe
	GTXxokbxvA7Layl
X-Google-Smtp-Source: AGHT+IHcUR3vA9pdpN9/X6yrIqMGJ68GXiy2tA+ThWcjXUi4yzjZQeHsRHgmfD2xclt8bjqt/sTnCjR0kdgqy69KW2g=
X-Received: by 2002:a05:622a:607:b0:4ae:d28f:b259 with SMTP id
 d75a77b69052e-4b0a35ea991mr1115451cf.1.1754524920629; Wed, 06 Aug 2025
 17:02:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0irG16e2cM_tX_UeEJVmB_EdUvk-4Nv36dXoUS=Ud3U5A@mail.gmail.com>
 <CAFivqmLoDv_pWdmBG8ws-CMUBXcb9bS1TgMaxW9YZMqqHpRSyA@mail.gmail.com>
 <20250722032727.zmdwj6ztitkmr4pf@vireshk-i7> <CAFivqmLG0LriipbmM8qXZMKRRpH3_D02dNipnzj2aWRf9mSdCA@mail.gmail.com>
 <CAFivqmJ4nf_WnCZTNGke+9taaiJ9tZLvLL4Mx_B7uR-1DR_ajA@mail.gmail.com>
 <aIso4kLtChiQkBjH@arm.com> <CAFivqm+kbRbJsJ_Obb4bV6fgxbqAwOndLUCDwHvWWnpMYoNoNw@mail.gmail.com>
 <aIvSe9VtZ-zlYfbQ@arm.com> <CAFivqmKR1dqVqTsoznH2-n8cyAM1=5zEGcEvmESU8RNGac-0sA@mail.gmail.com>
 <CAFivqmKgiVEWMQ90Lh6T+Y44E6m4jmdF5sUFfVNTmgVHOMtZsw@mail.gmail.com> <aJMCgGt5zu5Dhrd5@arm.com>
In-Reply-To: <aJMCgGt5zu5Dhrd5@arm.com>
From: Prashant Malani <pmalani@google.com>
Date: Wed, 6 Aug 2025 17:01:48 -0700
X-Gm-Features: Ac12FXzzj2kdgdXaFQbFtMvgX-wUHAziXBQqeV-STmRzK7yIWcA71NU6wzyXn_o
Message-ID: <CAFivqmLSp6RwfsPBK0d=zvRd6M_5GoeU4jHb-0OM9BpaDeSrzA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
To: Beata Michalska <beata.michalska@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Jie Zhan <zhanjie9@hisilicon.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Ben Segall <bsegall@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, Mel Gorman <mgorman@suse.de>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	z00813676 <zhenglifeng1@huawei.com>, sudeep.holla@arm.com
Content-Type: text/plain; charset="UTF-8"

Hi Beata,

On Wed, 6 Aug 2025 at 00:22, Beata Michalska <beata.michalska@arm.com> wrote:
> Would you mind giving it a go and see whether that improves things on your end ?
> Note that this is a quick and semi-dirty hack though.
>

Sure.
The provided patch doesn't appear to work as expected.
With all cores loaded (stress_ng --cpu N), it's returning the same
counter values
across samples. Here are readings from multiple CPUs:

t0: del:18446603338626579088, ref:192
t1: del:18446603338626579088, ref:192
ref_perf:10
delivered_perf:0


t0: del:18446603338627594896, ref:192
t1: del:18446603338627594896, ref:192
ref_perf:10
delivered_perf:0

t0: del:18446603338627627664, ref:192
t1: del:18446603338627627664, ref:192
ref_perf:10
delivered_perf:0

I verified separately that the "burst_read" path is being used by the platform
I am testing on.

BR,

-Prashant

