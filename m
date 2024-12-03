Return-Path: <linux-pm+bounces-18493-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0859E2B8C
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 20:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81D47B67BCB
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 16:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349F11F890E;
	Tue,  3 Dec 2024 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z+2ReGAd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JClbkhKx"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BDC1F76D7;
	Tue,  3 Dec 2024 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733242214; cv=none; b=JWDMWCPGEvM8Ycnm7lawalX/r761dWd3sNSoGViQTIc2AEMvAsMoEaoqXWy1bnwg6M+suoSIKYu930RtGJP1eSsn0QXyQrmdMAbEH/vpMNkJxbM7AL6Bg8xF70gFByr3waeLe9+1l5VBS/qor7BFB6DE4hH5dBkqrpJsjAdQSRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733242214; c=relaxed/simple;
	bh=fG2igQkn+4+8e57/uPhJs9Uh52Ls0xvv3KuRt0L7L8g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SMcTEb2cv+J0niaqMJ+sGWZ8LfKYn2FCL6MKRIoe9j1rMD3TK+0xqFR2dYF+SR0j7Q97TWuE/mYZHXAWWnnYVFeW3MxygiUga1kt9bjcsEkfiyDZSaHNrr9WObl0zmq/1h0TjOKR7317kQ9kOFLzY81dKL76yQPQHHILgeGyaHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z+2ReGAd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JClbkhKx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733242210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ddk6G81ViUFgr4R1ETgTtudIxbjBUqRlwB5igRmXu4g=;
	b=Z+2ReGAdXtDLEPMXg5raBwXetTEwjAfMflPPAVrOEfwrcGysNtb8Ptm4XzSqdf4ddJMGIq
	ZZBqiBOgCOuNuIq7DGHEpXVU5Xu4jv5Ii0TG4PGQvsseXUozaeu5T5eRpVLSIubrfSBUZY
	lFZrJk3uf2apYr8jS5FoEhfHHkKwHL1pNg0eQKunI6+PHruC3fqVPA0XwdV0EArk+NSne1
	qRUQSW5+Hn6udBK6/6UYU3VD1Qvh1dzaS5h0bDf2GWTmtVuK2vdUqgTz4h/DjFGF7xoGyx
	74YrDneOpK3BgwfyF7vv7CsmkugBesXXEbSgxcas7HUjervqVsUTsLXvAgoZEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733242210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ddk6G81ViUFgr4R1ETgTtudIxbjBUqRlwB5igRmXu4g=;
	b=JClbkhKx8PC6kkrMhZFXxilt17KHhS6wyGx8qQN8eby8jwpBXi3PGasAee6M7LJ+MvpgRm
	h+JYswnTZp71zZAw==
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
 20241015061522.25288-1-rui.zhang@intel.com, Zhang Rui
 <rui.zhang@intel.com>, hpa@zytor.com, peterz@infradead.org,
 thorsten.blum@toblux.com, yuntao.wang@linux.dev, tony.luck@intel.com,
 len.brown@intel.com, srinivas.pandruvada@intel.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, rafael.j.wysocki@intel.com,
 x86@kernel.org, linux-pm@vger.kernel.org, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>,
 linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] modpost: Add .irqentry.text to OTHER_SECTIONS
In-Reply-To: <CAK7LNARufW5wc=qBt5R=RJ9BkFirLKAgRgg_t=OmTTGbjLfsAg@mail.gmail.com>
References: <20241128111844.GE10431@google.com> <87o71xvuf3.ffs@tglx>
 <20241130114549.GI10431@google.com> <87iks3wt2t.ffs@tglx>
 <CAK7LNARWpcbVsJFYCDN28vuuLfEibZmT+m5=qMEJcKD9Abzv4Q@mail.gmail.com>
 <87iks1vlu5.ffs@tglx>
 <CAK7LNARufW5wc=qBt5R=RJ9BkFirLKAgRgg_t=OmTTGbjLfsAg@mail.gmail.com>
Date: Tue, 03 Dec 2024 17:10:09 +0100
Message-ID: <87h67ku4ri.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 04 2024 at 00:27, Masahiro Yamada wrote:
> On Tue, Dec 3, 2024 at 6:03=E2=80=AFAM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>> > In this mainline kernel, DEFINE_IDTENTRY_SYSVEC()
>> > expands to a normal .text function which is explicitly
>> > annotated 'noinline'.
>>
>> It's not annotated noinline, it's annotated 'noinstr', which puts the
>> code into the .noinstr.text section. That one is indeed covered.
>
> The callsite of local_apic_timer_interrupt() is annotated 'noinline'
> if I correctly understand this line:
>   https://github.com/torvalds/linux/blob/v6.13-rc1/arch/x86/include/asm/i=
dtentry.h#L272

You're right. I got lost in the macro maze and looked at the actual
sysvec_...() part.

>> So yes, the fix is only required for pre 5.8 kernels.
>
> This never occurs on x86 after commit f0178fc01fe46,
> but theoretically this may occur for other architectures.

Correct.

Thanks,

        tglx

