Return-Path: <linux-pm+bounces-18384-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0486A9E0DDE
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 22:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89AACB29E21
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 21:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3CE1DF249;
	Mon,  2 Dec 2024 21:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IH3XR5Oq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VLKUAJA/"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17AFA94A;
	Mon,  2 Dec 2024 21:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733173430; cv=none; b=QM22D1TL65B0rzxhN7dM4SIyQP5EZoG5a8OGXFGxuMF848DQTXd3EuYkkqWBw1uqPz49T3TInGMXxBCMIe0dFSPmHDuPBSWavVA5OV5E/Cok/SFIrwzJz3/61NBF0zKa6rMmOEaMfJH5jOh40vKKFx/QBWg809ixoIEfbjnr0m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733173430; c=relaxed/simple;
	bh=vLUZ5k+c0qQj50mqVkJ/qwvhEf2wa3vsjB0XW38D4rE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rvXKMKalHu+k+oPes+NZCB6khQx6dKyzshh7oVeU78K4rmwLVzVg6+cdNiMmlb3hTulQvDi5/EIwcNxtpvLHBNG30yzvXd4LlSs3P7RTviz7iw/UXqx5CZ/enTX8PH76ZgA22irCJmR7TElK4y7UmkCDMXlth+ZVjmX6ZTDFa68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IH3XR5Oq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VLKUAJA/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733173426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JAbKsbnsziIXiGhjcBxtSdueB/xYO7LsnWwodvNhQE0=;
	b=IH3XR5Oq5J30CrhyMejMAMCWFzEMywOB8oA1KABYd32vlyPtoy2Wr5NyRAGLe/w6yyfoWn
	4cwBFUby+yeCKl1vigIvvmwQypIksVnJPBv0c2j+GzBv+wpimOO98YMmizuZBJhb63RItn
	AGnPEzDBYCx4kLXUStcGjApJA8KzUXlfTyhqMEH6oUyjdIFv7d4uUfn5kGSubMGyVQ9pRm
	gcyvX/u0PD1pNp3PqaFrr4P1yya5j/kdaxkwkaNwHl5Bbewrdo2ccaOnzjYoO81uz6IcRl
	NdB4qToq7Dr7InMmMztyQ1Qs0VLXe3uvZB0sunVPPIkeF0xhP/cWOt7aJXEsSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733173426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JAbKsbnsziIXiGhjcBxtSdueB/xYO7LsnWwodvNhQE0=;
	b=VLKUAJA/sfuoNOZCdIc4gMvY9VsnZnsNqbDpRSVJhOcNAgsSb+eAmhoYkfwO/BWpXThDzL
	a9JCwCaNBqbQdTBw==
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
In-Reply-To: <CAK7LNARWpcbVsJFYCDN28vuuLfEibZmT+m5=qMEJcKD9Abzv4Q@mail.gmail.com>
References: <20241128111844.GE10431@google.com> <87o71xvuf3.ffs@tglx>
 <20241130114549.GI10431@google.com> <87iks3wt2t.ffs@tglx>
 <CAK7LNARWpcbVsJFYCDN28vuuLfEibZmT+m5=qMEJcKD9Abzv4Q@mail.gmail.com>
Date: Mon, 02 Dec 2024 22:03:46 +0100
Message-ID: <87iks1vlu5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 02 2024 at 11:02, Masahiro Yamada wrote:
> On Sun, Dec 1, 2024 at 8:17=E2=80=AFPM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>>
>> The compiler can fully inline the actual handler function of an interrupt
>> entry into the .irqentry.text entry point. If such a function contains an
>> access which has an exception table entry, modpost complains about a
>> section mismatch:
>>
>>   WARNING: vmlinux.o(__ex_table+0x447c): Section mismatch in reference .=
..
>>
>>   The relocation at __ex_table+0x447c references section ".irqentry.text"
>>   which is not in the list of authorized sections.
>>
>> Add .irqentry.text to OTHER_SECTIONS to cure the issue.
>>
>> Reported-by: Sergey Senozhatsky <senozhatsky@chromium.org>
>
> I found the context in LKML.
> Closes: https://lore.kernel.org/all/20241128111844.GE10431@google.com/
>
> However, is this still relevant to the mainline kernel?
>
> In Linux 5.4.y, I agree this because smp_apic_timer_interrupt()
> is annotated as __irq_entry:

Correct.

> In this mainline kernel, DEFINE_IDTENTRY_SYSVEC()
> expands to a normal .text function which is explicitly
> annotated 'noinline'.

It's not annotated noinline, it's annotated 'noinstr', which puts the
code into the .noinstr.text section. That one is indeed covered.

So yes, the fix is only required for pre 5.8 kernels.

Thanks,

        tglx

