Return-Path: <linux-pm+bounces-18310-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD719DF8AA
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 03:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0858316287E
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 02:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB991862A;
	Mon,  2 Dec 2024 02:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRuJyEFN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82940F9E6;
	Mon,  2 Dec 2024 02:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733104987; cv=none; b=SMQo34RSwGeTD66hXjzDx2hGHJVNCEx8BHpREdUYYgA0HRisPEt8enZ/PzPBilVKJXad6LlE1cv58k3s3j8UwBtgQEjmgPdOsysEm4NsLEh30uvK9oU/iRZcnobQ3+j85l5WkKOlDodRcQb36FQyqto7fT8R8roQoJFTV0zZF2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733104987; c=relaxed/simple;
	bh=maCc5D4IZuHzk206sb4zyON9g3KEt5ma5MoKRfyBRZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GESZg5k1b9plySp0yf5pZDjCvMuotlt+o/aXHQy9wUaa9d0/kb6zH4GIFHOEybeNG2iEtqqV439GzoE2j6Qq/h6jd93Hfsv+2YCRgH+ZOKBtFbhJFDuifJySUDXoNQ81yDv8Knts+I/g6Y8pV8t7NR9bO5E6C+51S9ac8JSt7qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRuJyEFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2763BC4AF09;
	Mon,  2 Dec 2024 02:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733104987;
	bh=maCc5D4IZuHzk206sb4zyON9g3KEt5ma5MoKRfyBRZ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gRuJyEFNZDgypUxMQuHdoQ+MsGDkyGthgvv4lWm78hsSAPwdud403aWnQy2oaP2Kh
	 NbeYsl27bGbbb7MjhklsKTGmRHjx7e13pH1mhc/2GGIF9i59b/gFDjJ3DL3U6Wg8hQ
	 F8CDSJaeQeXXcnIVfFYWqtYTg/6jwED15ukgAY/Wve46Yh+ns7REWhKXpxEK0VHEgy
	 LNN5QHxFUwGNROibWg8CfskYvCzcj3nxwrzqZ5DpA6QLPISa/n5zCIv0ziNRfLlWvf
	 s4qisPGdSEOTxKDGr7+U3dbigjnqW0MeHXyw2LPDaiu7pFOEGretBTF2SQ1zQ+uQRg
	 rv8YT7n+sb8MQ==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ffa8092e34so39228891fa.1;
        Sun, 01 Dec 2024 18:03:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUkZeOaq0TTSNjIS9/U+VE6rCKfcmnoP1lRkgTD7dQfVrCEgAvuUTp0wttV2zboO4Yx2/1xChBb7F8=@vger.kernel.org, AJvYcCV37JYFMFodWBuF26cE0wjuy3jWxDBW36mrphf1FpovAm0tu/qyQaYTcdKXsdaOrBF4cdIDbYh2rVqArlRM@vger.kernel.org, AJvYcCX5yW6/eoUBnnMnYOM0TYPuKGQWnxuoG0XOTGazrO4FuWXxUXREA+mIkM5tnqNtCtbCIn48TZaX@vger.kernel.org, AJvYcCXLTr9kxZ5WEYAJ/Ra0B6XO3XgWK+TvRSUO2yiw9w1bHPRBjPkGUahRxc4Wfv4Wgw0m1BhKxf8VXMiuqKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaxV1ldQyRKnHJwExsvlJPts/vpuUFe8gTDA1XZLsFnx2EQgEm
	oJ9vX6nUqd+JHJNWf5KDJTN3EZBrp/5yEuzwk1HR2R9Itt5asgrOUqz/Q47/UTWgIaLBL61Zu1X
	rModpe3NCGMROqHVelWZrRwrghFY=
X-Google-Smtp-Source: AGHT+IHx9xjsynr/l63aLsJxVM7l7US4bOwRAcVoS46Xevv0GpLtiUvTO5j01dpQdv7tyLv/reDF3L8c7WnmJCFOTwI=
X-Received: by 2002:a2e:be25:0:b0:2ff:cf31:262b with SMTP id
 38308e7fff4ca-2ffd5ff565emr86295651fa.7.1733104985771; Sun, 01 Dec 2024
 18:03:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128111844.GE10431@google.com> <87o71xvuf3.ffs@tglx>
 <20241130114549.GI10431@google.com> <87iks3wt2t.ffs@tglx>
In-Reply-To: <87iks3wt2t.ffs@tglx>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 2 Dec 2024 11:02:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNARWpcbVsJFYCDN28vuuLfEibZmT+m5=qMEJcKD9Abzv4Q@mail.gmail.com>
Message-ID: <CAK7LNARWpcbVsJFYCDN28vuuLfEibZmT+m5=qMEJcKD9Abzv4Q@mail.gmail.com>
Subject: Re: [PATCH] modpost: Add .irqentry.text to OTHER_SECTIONS
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 20241015061522.25288-1-rui.zhang@intel.com, 
	Zhang Rui <rui.zhang@intel.com>, hpa@zytor.com, peterz@infradead.org, 
	thorsten.blum@toblux.com, yuntao.wang@linux.dev, tony.luck@intel.com, 
	len.brown@intel.com, srinivas.pandruvada@intel.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, rafael.j.wysocki@intel.com, 
	x86@kernel.org, linux-pm@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 1, 2024 at 8:17=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> The compiler can fully inline the actual handler function of an interrupt
> entry into the .irqentry.text entry point. If such a function contains an
> access which has an exception table entry, modpost complains about a
> section mismatch:
>
>   WARNING: vmlinux.o(__ex_table+0x447c): Section mismatch in reference ..=
.
>
>   The relocation at __ex_table+0x447c references section ".irqentry.text"
>   which is not in the list of authorized sections.
>
> Add .irqentry.text to OTHER_SECTIONS to cure the issue.
>
> Reported-by: Sergey Senozhatsky <senozhatsky@chromium.org>

I found the context in LKML.


Closes: https://lore.kernel.org/all/20241128111844.GE10431@google.com/



However, is this still relevant to the mainline kernel?

In Linux 5.4.y, I agree this because smp_apic_timer_interrupt()
is annotated as __irq_entry:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/arch/=
x86/kernel/apic/apic.c?id=3Dv5.4.286#n1145



In this mainline kernel, DEFINE_IDTENTRY_SYSVEC()
expands to a normal .text function which is explicitly
annotated 'noinline'.





> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org
> ---
>  scripts/mod/modpost.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -785,7 +785,7 @@ static void check_section(const char *mo
>                 ".ltext", ".ltext.*"
>  #define OTHER_TEXT_SECTIONS ".ref.text", ".head.text", ".spinlock.text",=
 \
>                 ".fixup", ".entry.text", ".exception.text", \
> -               ".coldtext", ".softirqentry.text"
> +               ".coldtext", ".softirqentry.text", ".irqentry.text"
>
>  #define ALL_TEXT_SECTIONS  ".init.text", ".exit.text", \
>                 TEXT_SECTIONS, OTHER_TEXT_SECTIONS



--
Best Regards
Masahiro Yamada

