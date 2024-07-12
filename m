Return-Path: <linux-pm+bounces-11055-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1890292FF3F
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 19:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82953B246D7
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 17:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F764178367;
	Fri, 12 Jul 2024 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjmjTNaj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9266017799F;
	Fri, 12 Jul 2024 17:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720804259; cv=none; b=iTQm9hQPIAE+M7tc35boUvP4fpIBrzJo+zIVxI565xO0gTHJK/jkUIKCqm6xwkf8fKREXYMH9SsBqFX0FFNtpamNwax4FnlyXNL1r88emqqcTa8/HAw/bgH3JmmH+Q2mRFlrv8l56Ik/erVIT+o8vA2L265ZqhgANWG5HewdvCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720804259; c=relaxed/simple;
	bh=SMOskrIxYKC4O6emQHBW68wMQEv/leiHAjttfBN/gl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tG5Vow9MXosO7fCEt1ARezcuLkA3OZjU9nl1a8vxzWeWYzvGGaKJLYCmsawqdVhcppNGRfl3jjof9rEJUi5cB+e3n3/u8AgkO6Wn6H2OxacwjrlTf7kEB6wTQKbYHlgYDh7C82W0+P6Q6jo8nEG9guvfSzI00LmM0XEzbPeOJOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjmjTNaj; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70b09cb7776so1866220b3a.1;
        Fri, 12 Jul 2024 10:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720804257; x=1721409057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ky0nWnwJmHd6zu8RRtvg8wvKZFzCwLW2MVRtue5Z0Es=;
        b=GjmjTNajcOc96G5ZMYNdJfZO+HX1JlSCXorCoSLfoB+jJz7CaQtrJ/r8dP3FA8SE0i
         bd+765JqGLNRRwpnOcDyXi+aa/jODJ4Cr9N4kLTIGMbhT5fqEbYiuRaDoCiXMrjIGMcq
         D9hB+pQ9N/cIy0l+w4t12jcix/ntX3BKH36pK9Fy1yELFAZo8IbjjDhJMRddqhxSE501
         WEMRdpk04sztJh6P0vVb5ybhLeV6yBxhoeufSPww7pWP77tb3hoM9rIr4ZlOo9DueKes
         6vgbqFhQZvD2jYUsEasJqlCrFBC+7Bklo06JO9ju7Ue8CvT4R9K1PlDFfeeaAw2TlGq6
         0Mow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720804257; x=1721409057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ky0nWnwJmHd6zu8RRtvg8wvKZFzCwLW2MVRtue5Z0Es=;
        b=N3mPkmnW2O4JiSYREtUnEWk6O10xcU8Qi7uDvk4YFklo/HP0fvxhA7wyzDLqVfCYSr
         uMPRlS4gYZnbDCNX3IMpIgb6UFnhqxHPZmko6zNEXWrZ5KKDXnQ240/x5R80ImWoyqtY
         Bd4oM1JFx5jroh+ivTI3F12oRHQDwEzBsFESXs/KtiHNYlIWWDzl13+YSqoGaDqpMYqg
         ENm5H/K3N00USBUSO+wV0eqHM+Y8IZD9Zd1yhehWDunMDpxFLK+6ynfgUiDx65QZaniF
         r2YAvABNCKwaTMDboXzYCKAGzJmUsQnPTF3cdRVk44PJAMjeNgd7Htw4Q4x61k+ClxQ2
         2R3A==
X-Forwarded-Encrypted: i=1; AJvYcCUJn4DHZoU4vzJbq1f+i2H5ksJpuO6q+v6/ixjBl3Zl1Xoh+BTAz2fYyNucjVmcECysMMI9z4aw570cdalemTUkNmTwvTmRUrOxXs+i/GwWWrwpluZ78wMUX90VD/+av2dAnU1o/1g=
X-Gm-Message-State: AOJu0YyKNPWXRbgSc0x21KD/IvXFuuecn3hVAnpDpA/u72WKXkOUC557
	WFAcL+2BmisF4iRgKSIFKs+oe4p8cz9drQluaUV9aAUpHBA/muSk
X-Google-Smtp-Source: AGHT+IHWY0PYRkiaZE96Ze+d5DJRCgHcTNMFPwfFIdu5MuD5uzpo6HG5J+QpX4y0rCmOlsKcUHtxkQ==
X-Received: by 2002:a05:6a00:1142:b0:706:5cd9:655d with SMTP id d2e1a72fcca58-70b435f0138mr15253231b3a.22.1720804256643;
        Fri, 12 Jul 2024 10:10:56 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b438c3910sm7742080b3a.51.2024.07.12.10.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 10:10:56 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 12 Jul 2024 07:10:55 -1000
From: Tejun Heo <tj@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
	void@manifault.com, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, mingo@redhat.com, peterz@infradead.org,
	David Vernet <dvernet@meta.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2 2/2] sched_ext: Add cpuperf support
Message-ID: <ZpFjn4GXNXvSnWnK@slm.duckdns.org>
References: <Zog5-Yd5wV0-Y76y@slm.duckdns.org>
 <CAKfTPtDeA4OTPJmEHd-wKToYwDVizcny-_qxEuDUA-OcaVm2Uw@mail.gmail.com>
 <ZonzAdyd6zb2Sm06@slm.duckdns.org>
 <CAKfTPtDE2rWbRouf8zRyM3UpTfK1k_xrWmvAs-zfoRZqM3zGsw@mail.gmail.com>
 <Zowt7pVWFB-Of-me@slm.duckdns.org>
 <CAKfTPtB=77c-RsJ23suNZVf7qByeGSjYQJbiEU4JpXU6DezNLQ@mail.gmail.com>
 <ZoxVZPCrWokjfmFY@slm.duckdns.org>
 <CAKfTPtAjFvOPByPyeAURN3gw0yp8ByVmpa99_dGEZiTGw_Fawg@mail.gmail.com>
 <Zo1omq73-ESGsVVg@slm.duckdns.org>
 <CAKfTPtDdG+fhZjG0JEtXm+rq3w_v3iSrYxDLe0XXurOLEcOuNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDdG+fhZjG0JEtXm+rq3w_v3iSrYxDLe0XXurOLEcOuNw@mail.gmail.com>

Hello,

On Fri, Jul 12, 2024 at 12:12:32PM +0200, Vincent Guittot wrote:
...
> II failed to setup my dev system for reproducing your use case in time
> and I'm going to be away for the coming weeks so I suppose that you
> should move forward and I will look at that when back to my dev system

Thankfully, this should be pretty easy to fix up however we want afterwards.

> It seems that "make -C tools/sched_ext ARCH=arm64 LLVM=-16" doesn't
> use clang-16 everywhere like the rest of the kernel which triggers
> error on my system:

Hmm... there is llvm prefix/suffix handling in the Makefile. I wonder what's
broken.

> make -C <path-to-linux>/linux/tools/sched_ext ARCH=arm64
> LOCALVERSION=+ LLVM=-16
> O=<path-to-linux>/out/kernel/arm64-llvm/tools/sched_ext
> ...
> clang-16 -g -O0 -fPIC -std=gnu89 -Wbad-function-cast
> -Wdeclaration-after-statement -Wformat-security -Wformat-y2k
> -Winit-self -Wmissing-declarations -Wmissing-prototypes
> -Wnested-externs -Wno-system-headers -Wold-style-definition -Wpacked
> -Wredundant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enum
> -Wundef -Wwrite-strings -Wformat -Wno-type-limits -Wshadow
> -Wno-switch-enum -Werror -Wall
> -I<path-to-linux>/out/kernel/arm64-llvm/tools/sched_ext/build/obj/libbpf/
> -I<path-to-linux>/linux/tools/include
> -I<path-to-linux>/linux/tools/include/uapi -fvisibility=hidden
> -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64  \
> --shared -Wl,-soname,libbpf.so.1 \
> -Wl,--version-script=libbpf.map
> <path-to-linux>/out/kernel/arm64-llvm/tools/sched_ext/build/obj/libbpf/sharedobjs/libbpf-in.o
> -lelf -lz -o <path-to-linux>/out/kernel/arm64-llvm/tools/sched_ext/build/obj/libbpf/libbpf.so.1.5.0

So, thi sis regular arm target buliding.

> clang -g -D__TARGET_ARCH_arm64 -mlittle-endian
> -I<path-to-linux>/linux/tools/sched_ext/include
> -I<path-to-linux>/linux/tools/sched_ext/include/bpf-compat
> -I<path-to-linux>/out/kernel/arm64-llvm/tools/sched_ext/build/include
> -I<path-to-linux>/linux/tools/include/uapi -I../../include -idirafter
> /usr/lib/llvm-14/lib/clang/14.0.0/include -idirafter
> /usr/local/include -idirafter /usr/include/x86_64-linux-gnu -idirafter
> /usr/include  -Wall -Wno-compare-distinct-pointer-types -O2 -mcpu=v3
> -target bpf -c scx_simple.bpf.c -o
> <path-to-linux>/out/kernel/arm64-llvm/tools/sched_ext/build/obj/sched_ext/scx_simple.bpf.o
> In file included from scx_simple.bpf.c:23:
> <path-to-linux>/linux/tools/sched_ext/include/scx/common.bpf.h:27:17:
> error: use of undeclared identifier 'SCX_DSQ_FLAG_BUILTIN'
>         _Static_assert(SCX_DSQ_FLAG_BUILTIN,
>                        ^
> fatal error: too many errors emitted, stopping now [-ferror-limit=]
> 5 warnings and 20 errors generated.

This is BPF.

The Makefile is mostly copied from other existing BPF Makefiles under tools,
so I don't quite understand why things are set up this way but

  CC := $(LLVM_PREFIX)clang$(LLVM_SUFFIX) $(CLANG_FLAGS) -fintegrated-as

is what's used to build regular targets, while

  $(CLANG) $(BPF_CFLAGS) -target bpf -c $< -o $@

is what's used to build BPF targets. It's not too out there to use a
different compiler for BPF targtes, so maybe that's why? I'll ask BPF folks.

Thanks.

-- 
tejun

