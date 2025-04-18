Return-Path: <linux-pm+bounces-25704-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92675A93657
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 13:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B13624465E6
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 11:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D55270EAD;
	Fri, 18 Apr 2025 11:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7VCgWXo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2121FF1D1;
	Fri, 18 Apr 2025 11:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744974953; cv=none; b=fy/OF4ncDTpyT0AKDeQQPyIG1Zdz7Rb0eGLHCrOwyFYRU68zIDvQxvbR3LsIs5VfJ/9LA9V1zeB8oL1RyjJUwp3kRWkYgjzfvFtuv7XP8EbS5MeHaxUke0xAt971BSKsT3voQChuhROkI65fdUcpkQkq7VIBR09MHnCaYZBIrcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744974953; c=relaxed/simple;
	bh=M3RsKz1gtS83+ycyuX4V/auzZ+2oiXL7h4148nEYY4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZzZPmVAJtVh2vKZvH0ctBf+KjjpSTs5UzxHdzU9rlANjJh+JR0QCx57iHhYcMNSIJ+hARvWrPoomIac51GsuPqmzPr4VvMGcZZKvsQIv5Cobw7NUN6OvgDj7TkplCRaBhzs8SHKCXQTTrELqLaf6yOsNNrYAOQSduXFE1BU3RQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7VCgWXo; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30bf7d0c15eso16984751fa.0;
        Fri, 18 Apr 2025 04:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744974949; x=1745579749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DuDmX7HFNNg9bdF0GsJtTxnPoXyBhXe51ZRLu7jghTc=;
        b=J7VCgWXogrkVilDr2w+xrBi5NgGa0tUHBy8KrnzwCj9pLCH82E/O/0T5JgAhYBQ78X
         +tDgeoSDzTR/lTTmJrPUbca9zV+1s+AqMIsxtiHO95Qi1xXnKNJdc93tU0yz3aXkHMnM
         lliMB2qsHKowrZwvngTcm4vsFehTHqzog7vvJF4X8tROzc3hzR17J+iqcoEy2mJiCIHY
         5uyj40lzHkh2w5fmtgHKSMDvy3thXoTrqStoXT3tyjYii9Jv1j485g4ahYxVN5CyEqbp
         ESS7w/Dx42SbD4faMtdzi8EDzsiB7FIlO0vYSe79LYJ8glZNfEY6/H/dwvPaWhbCHIDV
         vFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744974949; x=1745579749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DuDmX7HFNNg9bdF0GsJtTxnPoXyBhXe51ZRLu7jghTc=;
        b=Os9AubADgOvvhMBKMMjQQ521lkdgon/8h7qqGu+vejyRaLAA03M5sPaH5/x1LgZT9A
         uN4CYsZ+rEWdhh7dPdZ1vkke6LgiPILT5kcJudbZrvR0C+Bbqua7m+iwpRaowP0aiE0Y
         XzzVgg/8UMbNeax7o9KGgwp2lC2hIJH9EARLZYQh+siTCctFdH9fvWWQrShEbT/ppUu5
         YDaOkCF/zH/sdqrMIZwTYk+qKLapfU/NvHUmiLGgMiWk/1PTGOQFGsstjLhsvcbt9DO/
         A+1Pk3+UE/nZ2zA0/vKprarj+rb6zUuNeY1ICkrQoJfgH2Ner1EINr46rzKXz7MKa2Vn
         VwrA==
X-Forwarded-Encrypted: i=1; AJvYcCUgQG8vVsSCbtUdnWwAMXKjXEv00CDPi3m2/tyUC86jE2U/OhwBimN3jogc8dQkQvaLELrclim1asiXtNE=@vger.kernel.org, AJvYcCXd2uMcOx6c4n8wUcJtNWGQoB8h22Yi/CAK5umxyUyTIOpei/nw9lMlvP5ityDvWI0OPlIw93O9ZZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFHGvyk9gPNFV1f9KlWKw63PVEQz/Zbul7e0PcsJl/j/+RCnU+
	FWxPQDKKlJxZysJ6TE+JjSAFdasjhyyTXkYz3fWpic6W+2KiGpHvhmk4HKODNm0VwI5/rMODer1
	VR2Nuwjn3Yjuxdqb9kiQFcz0F2xM=
X-Gm-Gg: ASbGncvVHv5l46LUBDmFwYvbT0Cj1NfLSFpIhgYSDU2AqR3Zqzkz4OAMW8zNCWvHxQl
	tn6jlEFQWrdaniPRqU+qTsLMS696PjHPDwQmS+ay2u1w73hsM1f1wLPow5lIXy1+gWfbnwGLT6t
	eBYK5WNN/kKRU2wdNfv+ilmg==
X-Google-Smtp-Source: AGHT+IGdOiTGvb/PRQMWHrpFsd0ceVhNOaLkgjWWIXX30ZaT72VDkE5XNIHWYGe7hY+aULnZ8AWGTv31L5H7QDTG2nI=
X-Received: by 2002:a2e:bc88:0:b0:30b:9813:b010 with SMTP id
 38308e7fff4ca-31090554278mr7750231fa.31.1744974949184; Fri, 18 Apr 2025
 04:15:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418071437.4144391-1-ubizjak@gmail.com> <50bf962c-2c9e-46a2-bbac-cba9cf229e79@citrix.com>
In-Reply-To: <50bf962c-2c9e-46a2-bbac-cba9cf229e79@citrix.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 18 Apr 2025 13:15:37 +0200
X-Gm-Features: ATxdqUGD5hIAG3AkM2DfHRBQofsYR7B0lWB7D2bun3Tb_fWb4vOmFg3E0fDFYL4
Message-ID: <CAFULd4ZNiRdARn8O98zROQRWoL1ASQ+iPPTTmLRxjo9SGRHyRg@mail.gmail.com>
Subject: Re: [PATCH -tip v2 1/2] x86/boot: Remove semicolon from "rep" prefixes
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: x86@kernel.org, linux-video@atrey.karlin.mff.cuni.cz, 
	xen-devel@lists.xenproject.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 12:24=E2=80=AFPM Andrew Cooper
<andrew.cooper3@citrix.com> wrote:
>
> On 18/04/2025 8:13 am, Uros Bizjak wrote:
> > diff --git a/arch/x86/boot/video.c b/arch/x86/boot/video.c
> > index f2e96905b3fe..0641c8c46aee 100644
> > --- a/arch/x86/boot/video.c
> > +++ b/arch/x86/boot/video.c
> > @@ -292,7 +292,7 @@ static void restore_screen(void)
> >                            "shrw %%cx ; "
> >                            "jnc 1f ; "
> >                            "stosw \n\t"
> > -                          "1: rep;stosl ; "
> > +                          "1: rep stosl ; "
> >                            "popw %%es"
>
> Doesn't this one still need a separator between STOSL and POPW ?

";" is a separator as well.

Uros.

