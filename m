Return-Path: <linux-pm+bounces-15076-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D266D98E3D4
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 22:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96971281976
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 20:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F9D216A3D;
	Wed,  2 Oct 2024 20:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D4dVFbuN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1E21946A0
	for <linux-pm@vger.kernel.org>; Wed,  2 Oct 2024 20:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727899340; cv=none; b=AduaygE4oUBzh5SzsgLW4qsioEKAUiEDMacJq+CaIEqvdLQQia4RuGKz/D1tNxH5JkmXkhQbXx1OxVsvAX6sa0l4X2pFz4pwZDQwGKhqg7b8/YPBLDXjUYtoLIQ6HDMuekUUASl5oAqM7mvaeWvHx2E2bLTAJfoe0/O2LmkWQAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727899340; c=relaxed/simple;
	bh=26ch3VLdZlgASzApmc+sdmN42sQrSbzi8ri/yXB2hcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BcnZBOOYGexozjKATiTAe3wm5Mb4OdBWzyx1BEJXXxsK1YdEa31Wqre4ckyKE8iBU5B74flGiwsG3TPH8qlCj5l3pFGtvuYG+lzn7u0v3Gff87TxFBqEhNCzhRs/XgHcr6/H5cI4wYPfpImZ93CqgYxtVZTlqW/0G+Gdo3+9sPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=D4dVFbuN; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5398f3be400so187936e87.0
        for <linux-pm@vger.kernel.org>; Wed, 02 Oct 2024 13:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727899336; x=1728504136; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=felyUMZ1epn3qYN0qQZjWDzIrXK7nsXRUmOCiXehfgQ=;
        b=D4dVFbuNGSK8Ce8wixVtY204SE1uZIujceMLhVjajbWr4DJJj6h+ftYpfMuJuaF/Bg
         B+2FxeLwtuHiSJ/a+gzTd0SbvzWWRjf9VFkV9bBCC9ki6mfDT/W1hvEYZgjsuZ3uEhFl
         yNOEluAi8XoLbhZOBVMLy6rx1JPiqGVP5Lx2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727899336; x=1728504136;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=felyUMZ1epn3qYN0qQZjWDzIrXK7nsXRUmOCiXehfgQ=;
        b=iZvbp/qoo+ejxFQy4qlafVnlJJlpuIlDd6nml/kH/O5RHoRf4JnhSK7LDXDDEJH8Bv
         5ZYK5oUytiMe2zodfIT6kCyiW330grWBJBo4jAT7m7EM5cx0keBMWxlbE/iet8bdPW/T
         wdL7qjkgC35LhdbMvGRDX9yCRM38Bt5q3X9KnyvT77PnsnpKJ9LGqL+q/YkC6zFIm4IK
         02kf6hzId+XdTkVYO63IHbtiBZMo4eVJ9ErsnwMZb9BQ9d09/28YP3rK0DBvReGSra4g
         nmAIy3ZupMuR8RVNZhsonamb56wTw5prDR4nF0DVMWCEbHH104/NGdJAjCWjIMV+vhUI
         oT2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVI2IGR18yNqbhHtlckROhJe9pSpdgxlPUrjVzkKk6ve+Q1p9gng8qSgkUa5rFSGQcq9jGPWN423w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHTUYFFb7teReS8GBvgsu1y7xkelyp1KUn6qM6wH6pwmXpVIdC
	kNZ9DEa1lU3DrWiblZgtGoq6S35z5P1vq3TdFLAlr2mS1SOJDcwOQvJUwV7U8h6w5HhFn74lAF0
	wHWFQXA==
X-Google-Smtp-Source: AGHT+IF+0wTAEAhd4qNeHhYZYUCVltlEaDgopAZchqXAHWJFGpFeEG+WGeH2u62PK0y6V4I2S1fkLQ==
X-Received: by 2002:a05:6512:224b:b0:52c:99c9:bef6 with SMTP id 2adb3069b0e04-539a065ec21mr2861218e87.7.1727899335838;
        Wed, 02 Oct 2024 13:02:15 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5399f6221c6sm442133e87.79.2024.10.02.13.02.09
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 13:02:13 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53992157528so161957e87.2
        for <linux-pm@vger.kernel.org>; Wed, 02 Oct 2024 13:02:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWxF//0XTRq8DQlDQR96crZflpNj7C1p4TrK605wC5WuBqO1M2ECp1qZQWKlgHnpO+r3KDk6JhVuw==@vger.kernel.org
X-Received: by 2002:a05:6512:e9e:b0:535:6795:301a with SMTP id
 2adb3069b0e04-539a079eb59mr2506573e87.47.1727899328912; Wed, 02 Oct 2024
 13:02:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-55-ardb+git@google.com> <99446363-152f-43a8-8b74-26f0d883a364@zytor.com>
 <CAMj1kXG7ZELM8D7Ft3H+dD5BHqENjY9eQ9kzsq2FzTgP5+2W3A@mail.gmail.com>
In-Reply-To: <CAMj1kXG7ZELM8D7Ft3H+dD5BHqENjY9eQ9kzsq2FzTgP5+2W3A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 2 Oct 2024 13:01:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj0HG2M1JgoN-zdCwFSW=N7j5iMB0RR90aftTS3oqwKTg@mail.gmail.com>
Message-ID: <CAHk-=wj0HG2M1JgoN-zdCwFSW=N7j5iMB0RR90aftTS3oqwKTg@mail.gmail.com>
Subject: Re: [RFC PATCH 25/28] x86: Use PIE codegen for the core kernel
To: Ard Biesheuvel <ardb@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Uros Bizjak <ubizjak@gmail.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Keith Packard <keithp@keithp.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-efi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Oct 2024 at 08:31, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> I guess you are referring to the use of a GOT? That is a valid
> concern, but it does not apply here. With hidden visibility and
> compiler command line options like -mdirect-access-extern, all emitted
> symbol references are direct.

I absolutely hate GOT entries. We definitely shouldn't ever do
anything that causes them on x86-64.

I'd much rather just do boot-time relocation, and I don't think the
"we run code at a different location than we told the linker" is an
arghument against it.

Please, let's make sure we never have any of the global offset table horror.

Yes, yes, you can't avoid them on other architectures.

That said, doing changes like changing "mov $sym" to "lea sym(%rip)" I
feel are a complete no-brainer and should be done regardless of any
other code generation issues.

Let's not do relocation for no good reason.

             Linus

