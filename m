Return-Path: <linux-pm+bounces-25769-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A547A94C49
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 07:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 109923A76B0
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 05:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA992580C0;
	Mon, 21 Apr 2025 05:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5lK07Nn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DCA14F98;
	Mon, 21 Apr 2025 05:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745214958; cv=none; b=tBYMesJ86ufZDVzbZsRFMQv4V7kjFxwzvwXu2vOunLHzFxXjkHXaqBdUeMMgmAvXpQnI8Iw2gtZ1/dYw9YT3stlI59wbTe0QCJzItgrD6GDz507Jfk+3kN/DRrEvGnIitK+FXDuOp34/HGLP+Y8x5IN0w2n5Mta3Wdmde9eWRYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745214958; c=relaxed/simple;
	bh=zAIRtDtNWBBb+6kHdyBK7loahkQe6cK+lkj/GDNLuFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fakvm9AA5AYEtnvNUhj4SuiwpUQkP9BmT/USCD9QgYGoh36plx80gT20bPtEVm47LANLkVJei/488yO5tK/VzrMo2xOBco2cryFYrYfjV1KExh44RUXPrGPIJxgUIFS/AEy3devUWVBkJKFCGUwQh6NlG0/XPJfpBJ7ujXulJkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5lK07Nn; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30f30200b51so40275271fa.3;
        Sun, 20 Apr 2025 22:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745214955; x=1745819755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWMNqVRucVBjFzFbK455CUrmSyJoU3JojByWskBk3A4=;
        b=P5lK07NnBRLctF3uKx66nqxNaUljw8g+cGL9TENETcnL6H6V5sV/BCMTbti/SCX4rK
         aOnPi7HrJ1fq1w8mgjTYzhQbpRJTMNywkAMSpFbQnH4HpYU7Gc8uNFv0XtK+2hn2VzfC
         L6TJ1lhP8+uFZf93C3b9LC+7C6QKOmepJYTaNYtenZAdVzDfhEjSlRTa75AFDv1ude1p
         UgdoyxgRkkbGvGJTGxSqQ1Bt48Nsv1CpooOoCVt2q5xIuToBsYP3LlCW2q1aIkidY2ss
         LPIrxzvx73DsP9NkmQkdRTMltj6/Plh9lrtakyaXT1+0/OLFGsWBobm2X6yuS3btG2fA
         lymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745214955; x=1745819755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWMNqVRucVBjFzFbK455CUrmSyJoU3JojByWskBk3A4=;
        b=Q3vyhAEL4xEybqBl2qPyhbEtL5vOBOshKGI+hK+C/uDznZIPktqU8QMR0Dj33zA+/b
         /jJxZka6EyIApHbCYJaxVDfSdciM8v9TLgU99MSv6oIujzUB4bjGEVKORvNCOTCuhcqy
         ELWlEpEsKnt4zpqHlJVT748YbPJVkdxFKrgjccyDVz4k33sjeMtShNf19bcHu9pEBBk2
         V40GUp+60cfSc5vEJF/NatBfNMNSneBnJ0Vb63d2+cSNHE3upgjHWGF2VX95PTT6XLoi
         tNUkAfjRCjfvqL2uiTXKeG26rjJGrXy2N564TglI+/KZkRezEECz2q2OvW3juuInOBYE
         HLSw==
X-Forwarded-Encrypted: i=1; AJvYcCV+hOmHX1ukoQtcfGWi6LtD6puI0nIIFHIHiXfxZ7DDXsd/Bw6yPdu05qAi4cE9OtLm4fUl98bI0/5+/js=@vger.kernel.org, AJvYcCVcvQYAMg7tswN4qxW3fvkd5xg9ljlg7ZvQlsvHsud8tOg8OwsWrS+6ZydQQ3RR98qJ0HoX6pralAg=@vger.kernel.org, AJvYcCWluQhQ7RfmSJ5LfNzDwQvBOw0cKK4EUYyc9SVwznbNefmH/7TXE4OQpxlydD6PbOCXh0W4qqd+7/Frbok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyui+scn2ROE458lHZ9YEL2qpGzU7VQxxktU2xHCRiAaQuhNk+x
	705u3Yu3nAXHKV4pwyd3ciiOn6kFJZPh5sgunp+xtX2zbJSmk5UqGSr3+LZvfn0KC8x4oaREY30
	vyKo85evYgAwemDpnDlRHKXqfJVSvX8QmlFg=
X-Gm-Gg: ASbGncsV46ItbTnGg5Q8LPALp1IhB16hYhoV3vJRFvLuTlj/kkbYxpZw7rzGfEG9Uj4
	XMVynmcer2/HMoOeN1gDQJZM7GfQconBIY6cmxmBLjFIqOfDrN4931oV0UBWNIn1l58T539D8az
	Kc2OmrV4+bLQC064wfMc3DXg==
X-Google-Smtp-Source: AGHT+IF6m2vPDw1MaEk0kNHKOTOJMTJ6aIpnQ3T6jpW27oKEuKu32Jvt1k/P1huP9m/Yz7k23p33ulHPCxB7OJot1uQ=
X-Received: by 2002:a05:651c:158b:b0:30b:ee78:79d2 with SMTP id
 38308e7fff4ca-31090554086mr36700331fa.36.1745214954874; Sun, 20 Apr 2025
 22:55:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420-tegra124-cpufreq-v1-0-0a47fe126091@gmail.com>
 <20250420-tegra124-cpufreq-v1-1-0a47fe126091@gmail.com> <20250421054452.fdlrrhtsimyucbup@vireshk-i7>
In-Reply-To: <20250421054452.fdlrrhtsimyucbup@vireshk-i7>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 21 Apr 2025 00:55:42 -0500
X-Gm-Features: ATxdqUG__nweLWLyEpRP_7suql-m7xHIMUlpHRMtsaDIh8gHn1xspZTrd73qVqo
Message-ID: <CALHNRZ9Yr4KJAz8NtfA_jjYyfUSNC1M=H57iCJXgX+dKJsr5eA@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpufreq: Export disable_cpufreq()
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 12:44=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> On 20-04-25, 15:42, Aaron Kling via B4 Relay wrote:
> > From: Aaron Kling <webgeek1234@gmail.com>
> >
> > This is used by the tegra124-cpufreq driver.
> >
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> >  drivers/cpufreq/cpufreq.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 0cf5a320bb5e864709b259249fb1af8bfbc0b04b..78cddc78ee98630f99ccc33=
2c64c94f437297177 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -109,6 +109,7 @@ void disable_cpufreq(void)
> >  {
> >       off =3D 1;
> >  }
> > +EXPORT_SYMBOL_GPL(disable_cpufreq);
> >  static DEFINE_MUTEX(cpufreq_governor_mutex);
> >
> >  bool have_governor_per_policy(void)
>
> I didn't realize earlier that tegra124 uses this call directly. I
> think this call was rather meant for other parts of the kernel
> (non-cpufreq drivers) to disable the frequency switching. It may not
> fit really well here.
>
> Instead what Tegra's driver could do is remove cpufreq_dt_pdev, which
> shall lead to unregistering the cpufreq driver completely.
This makes a lot more sense. I will look into that and upload a v2
swapping this patch for that once I verify it.

Sincerely,
Aaron

