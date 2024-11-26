Return-Path: <linux-pm+bounces-18131-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8D99D98AB
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 14:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8CC282CF9
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 13:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218B7C8EB;
	Tue, 26 Nov 2024 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFAx0j8G"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD04DF49;
	Tue, 26 Nov 2024 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732628329; cv=none; b=WDxBsRi7Z024Y1X3x7wJCI0qq4u4r7AtKFkcHgUJG03oo71uSyPl71USqt1QESfzrYq7/1MZJIekep6tvemMC0MpcHqaTkqQHlyRuNZ5YFWNxxc+qG+AJmskMuqtznVt3Ss6vcF1J+FdlfXc4ZrAKmoubcKaNzkvdXSnIeAUTUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732628329; c=relaxed/simple;
	bh=touT8z8p3S9/mxKICugSQjhxj2tpuIzKkQGJAkiR0gY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LUg9TlSjmpzvtYeg/hbUGRYWx7lDzoAaykZEC0mkwfe3CZYf7GOxfZZRFYOrP43+dNaVUMFDwvPW2fREIGCANVe58sd4nP730fLue1n5ikpdkKuEz9nvrpjt/bp6to1ubTT2Z7omwxBFdXGgUbNVbMO00916f1em1mbLrPvTKbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFAx0j8G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1C3C4AF0B;
	Tue, 26 Nov 2024 13:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732628328;
	bh=touT8z8p3S9/mxKICugSQjhxj2tpuIzKkQGJAkiR0gY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lFAx0j8GGys3A+x90j7upvkksAVYIiTHFRbXDggf0Z3IVOueI23C1SdqHeaBZfi/a
	 Nsl1bT3jFMgUtAM5yBbwoZpdx+BhkPxMzg0bjLKuSvg/fvAsH02BpVIHge9Jqu7wzK
	 DbtD0XJFuH6r12VkPU8MGlF8l8ziyfD4Ogffwg6ncN/3twsffurWKmOnHjD4BvYOex
	 lGu/KtMRRb+GoTRLQFUNrAxcp2MBtDFu1+GSs8PadYTa6CHcewa58fMq2Cx6yaTz/w
	 r2FtItLf0UTrXSCphRc4vKHmVQ+l/fLrWVaANX/ld1nt/AWleEL5u3EsLtVQarkTy4
	 9kwC6HFL9ROyw==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2964645d2b7so3285722fac.2;
        Tue, 26 Nov 2024 05:38:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUSREB4UY6mDnnkn9guKQsJjluLiDH6phC18cYCBpjIodaDH1Klohjyf/srAVponnMRnsId9HDi/+0=@vger.kernel.org, AJvYcCXzS3M08u5NGW2yxLG648ZDASuRPBz/xV+WRc3EuvibHO5w6OYqtHUA9kVSWSwMXuWYKW8xSVNgasNfeYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHHmFWU4qE/aUnFucHQyTmY6IXXrgTAef4QCzdDpGSi0B+N9Hn
	vDAZ9wim2s3hVr5U876SfpQudcvoly/ppOZU4VPDIQVsgY+eDAEJRAoHN5gZqNgmyG3aS3qv67h
	t+7gGeDj5e0VQhjxqehRtjRY1krw=
X-Google-Smtp-Source: AGHT+IF0lVvSotCIYasXWA7nKkHlZh1zojmHVnpTTi/0sIoFfoe6ka8JGuaxIVMbklysAwWfpj0bdZbIU7hohDehKBM=
X-Received: by 2002:a05:6870:2249:b0:288:18a0:e169 with SMTP id
 586e51a60fabf-29720c59d04mr14620782fac.19.1732628327689; Tue, 26 Nov 2024
 05:38:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com>
 <20241125132029.7241-6-patryk.wlazlyn@linux.intel.com> <CAJZ5v0iJ7hca68Pk1g1m=FNX6Psr3Ow-K7fvXZCcRM8PFM7EjQ@mail.gmail.com>
 <883447da-aeca-41ba-99ef-038dd8ddc6b3@linux.intel.com> <CAJZ5v0hZ8ajccb=B7P5g1+KJ+tsw5vP-e9ix7j_65WgT34H1XQ@mail.gmail.com>
 <a8d53d86-d658-4e18-bfd6-b37a2656b180@linux.intel.com> <CAJZ5v0iA==dmnPbs6BNV_taDD9hRWbwOhiCWsi0BjKzVVdihdg@mail.gmail.com>
 <706408b6-fd2c-475a-bde6-c95d0cab7360@linux.intel.com>
In-Reply-To: <706408b6-fd2c-475a-bde6-c95d0cab7360@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 Nov 2024 14:38:36 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ho0=7naGEtEv_jO0dK3ESexL+4B7_D0dRXNhr7fn+ORQ@mail.gmail.com>
Message-ID: <CAJZ5v0ho0=7naGEtEv_jO0dK3ESexL+4B7_D0dRXNhr7fn+ORQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 5/8] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, len.brown@intel.com, 
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com, 
	peterz@infradead.org, tglx@linutronix.de, gautham.shenoy@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 2:10=E2=80=AFPM Patryk Wlazlyn
<patryk.wlazlyn@linux.intel.com> wrote:
>
> >>>>> If you first make intel_idle provide :enter_dead() for all CPUs on =
all
> >>>>> platforms and implement it by calling mwait_play_dead_with_hint(), =
you
> >>>>> won't need mwait_play_dead() any more.
> >>>> Crossed my mind, but because mwait_play_dead doesn't filter on Intel
> >>>> vendor specifically,
> >>>
> >>> In practice, it does.
> >>>
> >>> The vendor check in it is equivalent to "if Intel".
> >>
> >> Actually, what about INTEL_IDLE=3Dn?
> >> We might hit acpi_idle, which would call mwait_play_dead_with_hint() n=
ow, but
> >> if we don't, don't we want to try mwait_play_dead before hlt or is it =
too
> >> unrealistic to happen?
> >
> > In that case the hint to use would not be known anyway, so
> > hlt_play_dead() is the right choice IMV.
>
> Fair, it's not known, but we could fallback to the old, cpuid leaf 0x5 ba=
sed
> algorithm, which works on a lot of hardware.
>
> That being said, I think it's cleaner to get rid of the old algorithm ent=
irely
> and rely on idle drivers to do the right thing from this point forward.
>
> If we could bring the CPU out of the mwait loop into the hlt loop somehow=
 (via
> interrupt for example) we could remove the old kexec hack altogether.

Well, the problem is that CPUs may be woken up from MWAIT waits for
various reasons and the reason for a given wakeup is not known a
priori.

