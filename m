Return-Path: <linux-pm+bounces-3062-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF46843F67
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jan 2024 13:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8792B2677B
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jan 2024 12:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB7F78B7F;
	Wed, 31 Jan 2024 12:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gsgPwjvN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF067869B
	for <linux-pm@vger.kernel.org>; Wed, 31 Jan 2024 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706704022; cv=none; b=B+3GS8hto6zBtwdHVlQTfkMVBXOlJM8blH9lxe40IZ51MdAlCU4RlwygFEGAy4aiE2ZmViLjHAHSY6SS4lHhaVD3qVBIvP4aCJS3cogegEYSmPVzEpmDO/n5m/FbVUYRHQunr6/1C5AdyTwXQEx7VkUVxe9s/SQjrqLyA6oClkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706704022; c=relaxed/simple;
	bh=hoRPS/CFTxqilSN/EifpmGCTsMtOu0/5zOuX6Y/BVoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YdKRuwOY+Ysa3gz52/lc4edSm21FR6Oi8NzZXgIvy9vJZOz5p/5hsTOprkHH5HIJfT/03Scf1cAVjp2VyHVGjEzXfezGSlTajqxqqK2mFGolIroPH2bfxIOpxRApuJw+BL5A2MGutU26rOxXQs9FF0+2qAHNCJXgizxgd0bjhCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gsgPwjvN; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6040fe8ba39so4412467b3.2
        for <linux-pm@vger.kernel.org>; Wed, 31 Jan 2024 04:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706704019; x=1707308819; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qlGNCjse7g8LCZD9qtXQK2gNaCE3H5gYqdGBEI7Qruo=;
        b=gsgPwjvNoq504+OMEIruXOIVqLWkox06dWk3qYBRQ7SM3BwwXubz/5wLP4tVJwgi0O
         VubcirP2HLpadPXshiokyNDIMEN3OR0lWJ6Tt4vZN4CS0kp1C0HaDb2L84z3z28G9+y7
         E5wSBY1VZF22ezP9e0LfhaPQqbKlNnkiKz62yZaS7lD0uioEMWNSTmMMvNNmg4waSYX3
         sv6BzyO0mkVGSGWEUfeXpW+Q8VNmy64+NA2jOFLgRo4PwzWkMw4ONxBLtHfVDCzLdglS
         cnpAaBqXJmf5rsEfFJr0SSjqjn0UUhJTFLJyHNaDgFK7srYpmx4PximRs4NlqeuG9yrK
         ggWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706704019; x=1707308819;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qlGNCjse7g8LCZD9qtXQK2gNaCE3H5gYqdGBEI7Qruo=;
        b=aeSfq5f4UHJma7HQkmfNLA/qctaiA9fMcn0REr1r4Dw2IAG+6knlxlUggF9j1WX7mo
         NK2JYwFqLqZAi5w7Bon/KYNq7MDkTq0n51lJpSAFOVIEECsLKQnnyWqUHDSwbDBS4Ita
         LXK1z0wRQHvNssjornUM2APULNgaOlWtxuXBRMHDYLyOfHyE2tWCI73izmgY5UpSDdsE
         i8ETo1EUs9GHSNxYrDWttjbJSsRXpcrP9jhQchpXftGNVSGGE+8ocg8y7K0/kkHRC0zV
         aZnXPFbX+3WGQ5GBlMaUA2f/rgHRyQE5ByV9nEvtZmYbsYjvdXubFoSXOFEyfSrjxFT/
         Uc1g==
X-Gm-Message-State: AOJu0YyKdMcMBFshftQv/bo4czT6qtI8UvFTSI3h1ENwU6J12rOmbTcZ
	8bPgR1r9XXR89weXvqGvCMyiIgQcNvK+pdT9mHOffNkaOaJlI9CNoec6mCF1yu0xsMJY9X54PFN
	zCN9N7xohWhar/7Ai9RSQnrM8qRFwIoAzEzLTRVnaTtNxfm/Fqdw=
X-Google-Smtp-Source: AGHT+IG8GAUmPm4cCJsW4vSGX75K9GpjpKbACWw1+U8zlSGHNIMBmjmLt9XFppsq9xRjjRDcSkb14a8xJbUFy6QTUuA=
X-Received: by 2002:a0d:e857:0:b0:5f6:4f5a:8bd2 with SMTP id
 r84-20020a0de857000000b005f64f5a8bd2mr936824ywe.0.1706704019025; Wed, 31 Jan
 2024 04:26:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125191756.868860-1-cristian.marussi@arm.com>
 <CAPDyKFpqZf15DFWa8K6RRzSTX70chEVTV8zRgnJ3VStSq_d9UQ@mail.gmail.com>
 <ZblW5rt4UtK6KMJD@pluto> <CAPDyKFo_Hg1-hN4Mw0UZSMX2iHRpyKyzyd+Gh5xWn-+2x3Jskg@mail.gmail.com>
 <20240131115304.35hmjgq2xbmzw2v4@bogus>
In-Reply-To: <20240131115304.35hmjgq2xbmzw2v4@bogus>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 31 Jan 2024 13:26:22 +0100
Message-ID: <CAPDyKFoYJH4GLpFb6i1HsQSTpfxhHea16o0fwVReP7nfYftNeQ@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: arm: Fix NULL dereference on scmi_perf_domain removal
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 31 Jan 2024 at 12:53, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Jan 31, 2024 at 12:35:56PM +0100, Ulf Hansson wrote:
> > On Tue, 30 Jan 2024 at 21:07, Cristian Marussi <cristian.marussi@arm.com> wrote:
> > >
> > > On Tue, Jan 30, 2024 at 02:09:20PM +0100, Ulf Hansson wrote:
> > > > On Thu, 25 Jan 2024 at 20:18, Cristian Marussi <cristian.marussi@arm.com> wrote:
> > > > >
> > > > > On unloading of the scmi_perf_domain module got the below splat, when in
> > > > > the DT provided to the system under test the '#power-domain-cells' property
> > > > > was missing.
> > > > > Indeed, this particular setup causes the probe to bail out early without
> > > > > giving any error, so that, then, the removal code is run on unload, but
> > > > > without all the expected initialized structures in place.
> > > > >
> > > > > Add a check and bail out early on remove too.
> > > >
> > > > Thanks for spotting this!
> > > >
> > > > >
> > > > > Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
> > > > > Mem abort info:
> > > > >    ESR = 0x0000000096000004
> > > > >    EC = 0x25: DABT (current EL), IL = 32 bits
> > > > >    SET = 0, FnV = 0
> > > > >    EA = 0, S1PTW = 0
> > > > >    FSC = 0x04: level 0 translation fault
> > > > >  Data abort info:
> > > > >    ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> > > > >    CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> > > > >    GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > > > >  user pgtable: 4k pages, 48-bit VAs, pgdp=00000001076e5000
> > > > >  [0000000000000008] pgd=0000000000000000, p4d=0000000000000000
> > > > >  Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> > > > >  Modules linked in: scmi_perf_domain(-) scmi_module scmi_core
> > > > >  CPU: 0 PID: 231 Comm: rmmod Not tainted 6.7.0-00084-gb4b1f27d3b83-dirty #15
> > > > >  Hardware name: linux,dummy-virt (DT)
> > > > >  pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> > > > >  pc : scmi_perf_domain_remove+0x28/0x70 [scmi_perf_domain]
> > > > >  lr : scmi_perf_domain_remove+0x28/0x70 [scmi_perf_domain]
> > > > >  sp : ffff80008393bc10
> > > > >  x29: ffff80008393bc10 x28: ffff0000875a8000 x27: 0000000000000000
> > > > >  x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
> > > > >  x23: ffff00008030c090 x22: ffff00008032d490 x21: ffff80007b287050
> > > > >  x20: 0000000000000000 x19: ffff00008032d410 x18: 0000000000000000
> > > > >  x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> > > > >  x14: 8ba0696d05013a2f x13: 0000000000000000 x12: 0000000000000002
> > > > >  x11: 0101010101010101 x10: ffff00008510cff8 x9 : ffff800080a6797c
> > > > >  x8 : 0101010101010101 x7 : 7f7f7f7f7f7f7f7f x6 : fefefeff6364626d
> > > > >  x5 : 8080808000000000 x4 : 0000000000000020 x3 : 00000000553a3dc1
> > > > >  x2 : ffff0000875a8000 x1 : ffff0000875a8000 x0 : ffff800082ffa048
> > > > >  Call trace:
> > > > >   scmi_perf_domain_remove+0x28/0x70 [scmi_perf_domain]
> > > > >   scmi_dev_remove+0x28/0x40 [scmi_core]
> > > > >   device_remove+0x54/0x90
> > > > >   device_release_driver_internal+0x1dc/0x240
> > > > >   driver_detach+0x58/0xa8
> > > > >   bus_remove_driver+0x78/0x108
> > > > >   driver_unregister+0x38/0x70
> > > > >   scmi_driver_unregister+0x28/0x180 [scmi_core]
> > > > >   scmi_perf_domain_driver_exit+0x18/0xb78 [scmi_perf_domain]
> > > > >   __arm64_sys_delete_module+0x1a8/0x2c0
> > > > >   invoke_syscall+0x50/0x128
> > > > >   el0_svc_common.constprop.0+0x48/0xf0
> > > > >   do_el0_svc+0x24/0x38
> > > > >   el0_svc+0x34/0xb8
> > > > >   el0t_64_sync_handler+0x100/0x130
> > > > >   el0t_64_sync+0x190/0x198
> > > > >  Code: a90153f3 f9403c14 f9414800 955f8a05 (b9400a80)
> > > > >  ---[ end trace 0000000000000000 ]---
> > > > >
> > > > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > > > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > Fixes: 2af23ceb8624 ("pmdomain: arm: Add the SCMI performance domain")
> > > > > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > > > > ---
> > > > > I suppose the probe does NOT bail out with an error because this DT config has
> > > > > to be supported, right ?
> > > >
> > > > Actually, no. It's a mistake by me, the probe should bail out with an
> > > > error code.
> > > >
> > >
> > > Ok. I suppose any old platform like JUNO that missed this will have to
> > > update their DT to use the new scmi_perf_domain...well it should have
> > > anyway really, it is just that now it is silently failing.
> >
> > I don't think it's failing. The old binding for SCMI perf (using
> > clock-cells) is still supported the way they were before, which is
> > only for cpufreq.
> >
> > But, yes you are right, both the DT and the consumer driver would need
> > to be updated to support SCMI perf.
> >
>
> Not sure if you want to flag an error on platforms that doesn't use this.
> IMO probe succeeding doing nothing seems right. Won't returning the error
> from probe gets flagged as error during boot or module loading though
> it is harmless on the platform since it doesn't use it.
>
> > In fact, there is also one additional similar problem in probe, when
> > the number of perf-domains are zero. In that case, we should also
> > return an error code, rather than returning 0.
> >
> > >
> > > > In fact, there is also one additional similar problem in probe, when
> > > > the number of perf-domains are zero. In that case, we should also
> > > > return an error code, rather than returning 0.
> > > >
> > > > Would you mind updating the patch to cover both problems - or if you
> > > > are too busy, just let me know and I can help out.
> > >
> > > No problem, I can do it next week, but regarding the zero domain case,
> > > I remember I used to do the same on regulator/voltage driver and bail out
> > > when no domains were found, but we were asked by some customer to support
> > > instead the very useless and funny case of zero domains for some of their
> > > testing setup scenarios .. i.e. allowing the driver to load with zero domains
> > > (and do nothing) and then unload cleanly avoiding harms while unloading ...)
> > >
> > > Thoughts about this ? Can fix as you prefer .
> >
> > In my opinion, there is no point having a module/driver loaded to do
> > nothing. I would prefer to just return an error code.
> >
>
> IIRC we had this in one of the driver but there was a request to keep it
> this way as it is useful in SCMI f/w bringup/testing. Not all info/features
> need to be ready. That said I am fine if pmdomain prefers to flag 0 domains
> as error.

Well, I don't have a strong opinion around this particular case. My
opinion is more generic, keeping modules loaded wastes memory for no
good reason.

On the other hand, it may not be a problem in this case, as you suggested above.

Perhaps a consistent behaviour is better?

Kind regards
Uffe

