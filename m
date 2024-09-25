Return-Path: <linux-pm+bounces-14723-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD4B986529
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 18:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB781F2782E
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 16:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18174644E;
	Wed, 25 Sep 2024 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LHF6aAqO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C581117547
	for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2024 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727282841; cv=none; b=rV4tGmwLxFFNgLEV2TiW78IGnROdI1OEUTBcaU9ZeEqg7qKNDDoJXgtCk5yPzUwLSa0wLRE+FINCJ7qDQLL6U2H9kLO8OvKp4KnfFk7oElHw3GrIFSyvsIsfMmytj1oVDMKnrwF5WdbZe66wvOgkOBwuGN2NPjA6OdFEUi+YFlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727282841; c=relaxed/simple;
	bh=/t+YSp2gvbsBW9hsAIIEsn2fOHY2XQVupxHXFI22op4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C4qE4GJnP8A9b62x6eU16jVEc8r8SbbKjEhS/BByyZ++m8NXMSWdcGopo1qKW1SFiuPftZ7Hn1EqmA4h05WsIrv47qLFG4k9O+tAalsuzWq8/zaLE8RWZEwj3OpGG+XX4SFpT6kfJMoGKcT/t0bVrIpaJOIXYBI6iDK1NvvMO3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LHF6aAqO; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d60e23b33so8514866b.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2024 09:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727282838; x=1727887638; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nj8+qG2S/Bk0hHBrSluJoVQqRkgSfLVqxLrwhmmQqfQ=;
        b=LHF6aAqOcAmrEbPN9CQFazK6DXmCZSiAwf51au+AQbIwgTx5WJHVbSVCt5ybHt+O8i
         Hr7is4w25JX+hiNJOp6w7Xt97OsQnkuBzhdeZ6+CS7adP8GJHgTwlDzVc1BXXbprliGV
         AGofM4ivEjkSQLZa8qHPkE5gMsQIuTQkAmFco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727282838; x=1727887638;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nj8+qG2S/Bk0hHBrSluJoVQqRkgSfLVqxLrwhmmQqfQ=;
        b=DfcilAJsVQ6O3NxrayEVnG1Pnb4RzslVDvxt+plmSs4eWq1zE7rG8RR9olkOlHoAiW
         KLVnNvafy9fXan42Fmdkt/4Stn4v3+uMwuPGRE0ii32cWTPzaeqLYP3ZK9tVi6og+LVn
         j/OmNn/QQgPfRART1l7nlO4jXYd1SSszOJJQ6iQV/FPM4RBzwqIT3jhY3jDqhYffr8dR
         gbFC/2ZxJa5p0/f5fEbdGjoWbGO2W6/Wjvf3pc2/UUquTVyGm2GYnWowXQ209XAYANuQ
         2P/xZuEzd9TAxbnNa+XqJYqnZQXb8uwPK3Ih81qsKfWbdZ22vOlk1O2QYOIB7+R+DD73
         Qeaw==
X-Forwarded-Encrypted: i=1; AJvYcCU+mI/ojHT7C1PHMlTjbdFhnY4e2sKqZSMME+0eGJq3bohYr04sZlZ0t6iaJ6Yow9hm4CouJbmL1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+HgnX4giR94X41VHZnoMHx4xBbKyO+4UUG6N0Xca6k8Zq9QEW
	ivSUM6FP4clmMEFzfbt6a3kzL1K7uu+xkkgjf3fkQeyTz2k+cLS9jekRFPqoMMoOgpZZQaofIET
	Bj2J3lg==
X-Google-Smtp-Source: AGHT+IE8YD12soQuBHYuNlMlyAyRHmOciX1V4YOxsRBm4fy08h9O6A+h+K2EvPke+KmTcHihDKn2VQ==
X-Received: by 2002:a17:907:7ea8:b0:a8d:6921:e179 with SMTP id a640c23a62f3a-a93a051c3c9mr268700266b.39.1727282837701;
        Wed, 25 Sep 2024 09:47:17 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f34976sm226383266b.45.2024.09.25.09.47.17
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 09:47:17 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cb8dac900so68416655e9.3
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2024 09:47:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUBMIblTjMAnQnztA/cx5CPc/m8HPI0dI9HyYoFJNc387jfrdzXeOrT+w/HZvgsZwHIlRbdTbiyIw==@vger.kernel.org
X-Received: by 2002:a17:906:f5a9:b0:a86:9d39:a2a with SMTP id
 a640c23a62f3a-a93a0330c37mr309689066b.8.1727282382886; Wed, 25 Sep 2024
 09:39:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com> <20240925150059.3955569-44-ardb+git@google.com>
In-Reply-To: <20240925150059.3955569-44-ardb+git@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 25 Sep 2024 09:39:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiLYCoGSnqqPq+7fHWgmyf5DpO4SLDJ4kF=EGZVVZOX4A@mail.gmail.com>
Message-ID: <CAHk-=wiLYCoGSnqqPq+7fHWgmyf5DpO4SLDJ4kF=EGZVVZOX4A@mail.gmail.com>
Subject: Re: [RFC PATCH 14/28] x86/rethook: Use RIP-relative reference for
 return address
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
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

On Wed, 25 Sept 2024 at 08:16, Ard Biesheuvel <ardb+git@google.com> wrote:
>
> Instead of pushing an immediate absolute address, which is incompatible
> with PIE codegen or linking, use a LEA instruction to take the address
> into a register.

I don't think you can do this - it corrupts %rdi.

Yes, the code uses  %rdi later, but that's inside the SAVE_REGS_STRING
/ RESTORE_REGS_STRING area.

And we do have special calling conventions that aren't the regular
ones, so %rdi might actually be used elsewhere. For example,
__get_user_X and __put_user_X all have magical calling conventions:
they don't actually use %rdi, but part of the calling convention is
that the unused registers aren't modified.

Of course, I'm not actually sure you can probe those and trigger this
issue, but it all makes me think it's broken.

And it's entirely possible that I'm wrong for some reason, but this
just _looks_ very very wrong to me.

I think you can do this with a "pushq mem" instead, and put the
relocation into the memory location.

                 Linus

