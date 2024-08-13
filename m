Return-Path: <linux-pm+bounces-12146-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A542B95034A
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 13:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6066B2826CA
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 11:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D6D197A9B;
	Tue, 13 Aug 2024 11:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmxcW52n"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CE221345;
	Tue, 13 Aug 2024 11:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723547279; cv=none; b=AlzLHnX8LoLl3nDEKYfKOICCTfABsYSuhcJY4LNyQkE+yRRsg7UWdmTF7VPiwTPp93KC62psElwUdA3GKBrsGYYGdec7DK9Q8p5cvtnSJDUZ5C6o0PKL3wOJVXx/ueH510qhvFkU+0Dn+wIy4DBIhfqlzdEi8ALcnZgMLXh6Yf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723547279; c=relaxed/simple;
	bh=PRSTM/N89x9mHdAa2T3SRVbBz76/xYZx90d+COq+eac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nUa54v9PD+dt404tD3mTQuK4IOZXWDx73UHxeHGiNT07iyfj85RgUaZhnH9sqRl4Tz+hgSR04NWcoTDYpnPcjORI8+PgxqHOv373Zuq8aInFAzI4OQZh0jDDfbFhNoi30oHky/I9Hoio90tJkqGhAoI7db5KgCNcCiVTFhwuuJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmxcW52n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C7BC4AF16;
	Tue, 13 Aug 2024 11:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723547278;
	bh=PRSTM/N89x9mHdAa2T3SRVbBz76/xYZx90d+COq+eac=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TmxcW52nlBwx2KC7h0LWRmqdGRz6pdSvToLshI6QkmobCdRd2wU+545DZqsF/OXXc
	 zt4RFXlve5OXxAkhWHWjINraNwYxHEPU04rxXa0yXT4EgeR9kObMO8LZOI02s8VxYy
	 f5B9Hw+bPy0AmA+Gz4STJo3qifU6cFnfPTcJpRD9E6P+tm2Z+z/kPf45jRm1uyxfY1
	 DXsicbRPR4z8/asdI1Bln9fxKJBx9caXUjkkDMJEDGqpvICc8n+ylilIJRZO3CVtAN
	 EDHiJl26sPBPkC78J4ejIX/8hDZkVCu31l2k1sW0U0CJ4QPTAqWPc//o6kurVkzvi2
	 tqnvZwfK1uzjQ==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-268e0b13471so528956fac.2;
        Tue, 13 Aug 2024 04:07:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWRffnjgmIt68e12FHtzjfbobza2vr5AgXLn/97paA5FJrPfo8Qb6dXLaQtQOpo/yUB30mSiDHObIFaZsRVkBO3aoHVEk+B6qQ6qK77EcaQ+KgrmtXqmMPi0zGlrW1OU/1BAPQDQaA=
X-Gm-Message-State: AOJu0YxABfVCtuu+F4Js+hoLRxuRCOGyV+yfGBCYHmWvTbSmUfleem1f
	4QrWIpuJcw/xNSqphdR1hzRyT/WZvB+O22Q0g4wsdj1KO5yTUVKccZoXUJ3hxw07BLbU/Z5rckt
	+9qLb6Nwbzbr3XHzFJgHKgYeITgQ=
X-Google-Smtp-Source: AGHT+IGvRQQBGVZv0JTADDoQxPdVk4pV/qMYlrtDOH5fp6d6G7BKtu8JD9An29QoSlEQgHZadPAaR1FDTpESGm30+/Y=
X-Received: by 2002:a05:6871:320a:b0:26f:df8d:fc13 with SMTP id
 586e51a60fabf-26fdf8e1496mr151375fac.2.1723547277998; Tue, 13 Aug 2024
 04:07:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4941491.31r3eYUQgx@rjwysocki.net> <13573795.uLZWGnKmhe@rjwysocki.net>
 <ZrqxqCVbw18AP5Ou@chenyu5-mobl2>
In-Reply-To: <ZrqxqCVbw18AP5Ou@chenyu5-mobl2>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 13 Aug 2024 13:07:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j8Dqro_=wcA5RD3+g-0pp9np3HyVQP9VU0De_JJAf6Pg@mail.gmail.com>
Message-ID: <CAJZ5v0j8Dqro_=wcA5RD3+g-0pp9np3HyVQP9VU0De_JJAf6Pg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] x86/sched: Add basic support for CPU capacity scaling
To: Chen Yu <yu.c.chen@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 Maintainers <x86@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ricardo Neri <ricardo.neri@intel.com>, Tim Chen <tim.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 13, 2024 at 3:27=E2=80=AFAM Chen Yu <yu.c.chen@intel.com> wrote=
:
>
> Hi Rafael,
>
> On 2024-08-12 at 14:42:26 +0200, Rafael J. Wysocki wrote:
> > +void arch_set_cpu_capacity(int cpu, unsigned long cap, unsigned long b=
ase_cap,
> > +                        unsigned long max_freq, unsigned long base_fre=
q)
> > +{
> > +     if (static_branch_likely(&arch_hybrid_cap_scale_key)) {
> > +             WRITE_ONCE(per_cpu_ptr(arch_cpu_scale, cpu)->capacity,
> > +                        div_u64(cap << SCHED_CAPACITY_SHIFT, base_cap)=
);
> > +             WRITE_ONCE(per_cpu_ptr(arch_cpu_scale, cpu)->freq_ratio,
> > +                        div_u64(max_freq << SCHED_CAPACITY_SHIFT, base=
_freq));
> >
>
> Would the capacity update be frequently invoked?

I hope not.

> Just wonder if we could
> first READ_ONCE() to check if the value is already the value we want to
> change to, to avoid one write and less cache snoop overhead (in case othe=
r
> CPU reads this CPU's capacity)

Well, I'd rather not complicate the code beyond what is necessary
unless this is demonstrated to make a measurable difference.

Besides, AFAICS the only case in the caller in which the same values
can be passed to arch_set_cpu_capacity() is the CPU offline one and
that should not happen too often.

