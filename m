Return-Path: <linux-pm+bounces-11032-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B1592F8B7
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 12:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC8A62824FD
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 10:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ADA82D93;
	Fri, 12 Jul 2024 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mkcvu8GQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421F414F104
	for <linux-pm@vger.kernel.org>; Fri, 12 Jul 2024 10:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779166; cv=none; b=tbvwqWEynQUacK/nY6+5Gozh2Bs6/UF2NETkGaAxNnPq0DyDwCL9Lc3rMMurj1sTZR/jB1sdjTbCDzMNAu+bGX1td7C63Z5InQibOjaf8HdQIRynw/kPS314DrXEtbyKi0AXGSsXN8wknqtl7SSANHh/qI0MxB+NiKSHGtbe4dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779166; c=relaxed/simple;
	bh=nlytpuyFujRrlPzWhcq758GdHU5aL4sOwIbzsLOmK5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eC070zEFDsMHBT7hVgnv4I/Z5Xg29p3rDDCQ1j9aSjmPVz1ilsnuJ6ael09Q4NAAUMhsu42sWtWPVTAW1dHVx7C8BYUDyxb1GpQuJnNmFwRKhK/VTkeGoUqktwe2bkfxO2jqYTD0Qei9aZKn6xoX63AtRVWwvRhYahOUShigcwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mkcvu8GQ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fb3b7d0d56so11108685ad.1
        for <linux-pm@vger.kernel.org>; Fri, 12 Jul 2024 03:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720779164; x=1721383964; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+BuABMp8rgyV/MnavMDRd0C+518rND6T64IHr1gy1Lk=;
        b=Mkcvu8GQhTepoxiM49fWHAr1Z3mBTx+MLaUQuwFK8oaeFHgY8n6weOxLAyfZWK5U+j
         rDdFi0aVOu9pIxXtfxA6vsp3Lz9fOKDHcW4IzRve7NKoPRpPA3FaSJ2pdk3pIlNZV668
         rZAvu44ay/lTlj5kg9KstjUe1wYdg7vfnq4OpfN7xqb9byBYO+N5fgCQv9seAxKN8GLG
         w+Yrsr+ddYaUSdjv4YuVWPjNIqaSZW5OYIMKQNVg00iUnaMGj2IqoHLwJGHeSachmS0x
         xJO3+0C4c4fcZJRgO3g/AcLhFUUa5kmGDXsRXq0q8oRW8SA47n3HYRMs4n3v7gLAD4Yw
         vQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720779164; x=1721383964;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+BuABMp8rgyV/MnavMDRd0C+518rND6T64IHr1gy1Lk=;
        b=jH1cmqgfT+4dKSEBE/AA9bZ0mVmDcs7gGyumqv/Tsh+szurdKt/67trQA9t7A/Q/UO
         KbF3DGP1v71iVUXuzMNB4gNuDwiePTc38eGGyUFekoPkryYSNHPON0p56MWWUZ3t3s6O
         THu/HVY4Nj8XXZ5oMbciOzeAmInd8dQq3h1pNCrJPZhlRwp/XU2531X5mqc30ZpdZEl8
         pWxpoOmzjX26YQUX8L2++RdR4KicPaDFyZl58LHdrVGm2g1RtWobGBTT4QSQAb/4gk5G
         dYcb7MkXQm8eDa0byD9ZLnO2I8DLE6joMSvpnAYo0RTKvq4IVoOzLuu7JyMlMU7phfBk
         yPvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbvgyg+RbD7estPKOAmePNmhDArlJE9umSBu4tpcIbxAUY5U/l8ZgRsxCoCuBIE95y5djaim+Etupv+YNQw7DHcGJKT+meQuw=
X-Gm-Message-State: AOJu0YyClx5U7qNmSkry0KwHtfSl205HAkLqij0+pZ9WIPFB9zdS6q8O
	VcUkkPanDqEz/m4ZeH8HFJPoKJB5YpHHezLjjn7+BtH9oyOLp3RqzZcLnoXPLttpVEUjiw4gBuZ
	plhDkrpdExT9WR/QxZLHKbIFURr+/au1NCTEA9Q==
X-Google-Smtp-Source: AGHT+IFgDc9ogZl8gPcqfqq/XMvRZvC4Osj8EbOZu7v2aFyhr2ojG6QYOLzLn+WXFU/cHReW3gP+CxtkCi4z3sCKmn8=
X-Received: by 2002:a17:90a:c916:b0:2c8:e1f8:b02 with SMTP id
 98e67ed59e1d1-2ca35bf1409mr9670486a91.9.1720779164425; Fri, 12 Jul 2024
 03:12:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZnM2ywDVRZbrN6OC@slm.duckdns.org> <CAKfTPtBPObGdcaQF5nKqr4042f-+5obTMm_S6S+=3_Ct33ZMyw@mail.gmail.com>
 <Zog5-Yd5wV0-Y76y@slm.duckdns.org> <CAKfTPtDeA4OTPJmEHd-wKToYwDVizcny-_qxEuDUA-OcaVm2Uw@mail.gmail.com>
 <ZonzAdyd6zb2Sm06@slm.duckdns.org> <CAKfTPtDE2rWbRouf8zRyM3UpTfK1k_xrWmvAs-zfoRZqM3zGsw@mail.gmail.com>
 <Zowt7pVWFB-Of-me@slm.duckdns.org> <CAKfTPtB=77c-RsJ23suNZVf7qByeGSjYQJbiEU4JpXU6DezNLQ@mail.gmail.com>
 <ZoxVZPCrWokjfmFY@slm.duckdns.org> <CAKfTPtAjFvOPByPyeAURN3gw0yp8ByVmpa99_dGEZiTGw_Fawg@mail.gmail.com>
 <Zo1omq73-ESGsVVg@slm.duckdns.org>
In-Reply-To: <Zo1omq73-ESGsVVg@slm.duckdns.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 12 Jul 2024 12:12:32 +0200
Message-ID: <CAKfTPtDdG+fhZjG0JEtXm+rq3w_v3iSrYxDLe0XXurOLEcOuNw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sched_ext: Add cpuperf support
To: Tejun Heo <tj@kernel.org>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	void@manifault.com, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	mingo@redhat.com, peterz@infradead.org, David Vernet <dvernet@meta.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jul 2024 at 18:43, Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, Jul 09, 2024 at 03:36:34PM +0200, Vincent Guittot wrote:
> > > I tried this and it's a bit problematic. Migrating out all the tasks do
> > > bring the numbers pretty close to zero but the math doesn't work out exactly
> > > and it often leaves 1 in the averages. While the fair class is in use, they
> >
> > hmm interesting, such remaining small value could be expected for
> > load_avg but not with util_avg which is normally a direct propagation.
> > Do you have a sequence in particular ?
>
> Oh, I thought it was a byproduct of decay calculations not exactly matching
> up between the sum and the components but I haven't really checked. It's
> really easy to reproduce. Just boot a kernel with sched_ext enabled (with
> some instrumentations added to monitor the util calculation), run some
> stress workload to be sure and run a sched_ext scheduler (make -C
> tools/sched_ext && tools/sched_ext/build/bin/scx_simple).

II failed to setup my dev system for reproducing your use case in time
and I'm going to be away for the coming weeks so I suppose that you
should move forward and I will look at that when back to my dev system

It seems that "make -C tools/sched_ext ARCH=arm64 LLVM=-16" doesn't
use clang-16 everywhere like the rest of the kernel which triggers
error on my system:

make -C <path-to-linux>/linux/tools/sched_ext ARCH=arm64
LOCALVERSION=+ LLVM=-16
O=<path-to-linux>/out/kernel/arm64-llvm/tools/sched_ext
...
clang-16 -g -O0 -fPIC -std=gnu89 -Wbad-function-cast
-Wdeclaration-after-statement -Wformat-security -Wformat-y2k
-Winit-self -Wmissing-declarations -Wmissing-prototypes
-Wnested-externs -Wno-system-headers -Wold-style-definition -Wpacked
-Wredundant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enum
-Wundef -Wwrite-strings -Wformat -Wno-type-limits -Wshadow
-Wno-switch-enum -Werror -Wall
-I<path-to-linux>/out/kernel/arm64-llvm/tools/sched_ext/build/obj/libbpf/
-I<path-to-linux>/linux/tools/include
-I<path-to-linux>/linux/tools/include/uapi -fvisibility=hidden
-D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64  \
--shared -Wl,-soname,libbpf.so.1 \
-Wl,--version-script=libbpf.map
<path-to-linux>/out/kernel/arm64-llvm/tools/sched_ext/build/obj/libbpf/sharedobjs/libbpf-in.o
-lelf -lz -o <path-to-linux>/out/kernel/arm64-llvm/tools/sched_ext/build/obj/libbpf/libbpf.so.1.5.0
...
clang -g -D__TARGET_ARCH_arm64 -mlittle-endian
-I<path-to-linux>/linux/tools/sched_ext/include
-I<path-to-linux>/linux/tools/sched_ext/include/bpf-compat
-I<path-to-linux>/out/kernel/arm64-llvm/tools/sched_ext/build/include
-I<path-to-linux>/linux/tools/include/uapi -I../../include -idirafter
/usr/lib/llvm-14/lib/clang/14.0.0/include -idirafter
/usr/local/include -idirafter /usr/include/x86_64-linux-gnu -idirafter
/usr/include  -Wall -Wno-compare-distinct-pointer-types -O2 -mcpu=v3
-target bpf -c scx_simple.bpf.c -o
<path-to-linux>/out/kernel/arm64-llvm/tools/sched_ext/build/obj/sched_ext/scx_simple.bpf.o
In file included from scx_simple.bpf.c:23:
<path-to-linux>/linux/tools/sched_ext/include/scx/common.bpf.h:27:17:
error: use of undeclared identifier 'SCX_DSQ_FLAG_BUILTIN'
        _Static_assert(SCX_DSQ_FLAG_BUILTIN,
                       ^
...
fatal error: too many errors emitted, stopping now [-ferror-limit=]
5 warnings and 20 errors generated.

Vincent

>
> Thanks.
>
> --
> tejun

