Return-Path: <linux-pm+bounces-37361-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F7EC313EC
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 14:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 786D01898B52
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 13:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D103271E3;
	Tue,  4 Nov 2025 13:34:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DA4328606
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 13:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762263259; cv=none; b=Jf01kKRv+gz8iFWxX9wYt5iEM5B5pm/wWQeG4RH2MklNZDmO3tBHB24ilJIrcUeFoZtoWESWKLjyHvHKvrGtjzUzAsnAC7/AlMbmsCilgOg7wRF7ytcxMTChNjCJBnbJ3Mi5BYA+TJBt/NepGLyUdYXj8gxZcembUQlsq+nnDdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762263259; c=relaxed/simple;
	bh=jz4XbMEhT14ABokNLSyNocUWmIjvQFrqSNdxYOhl118=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RXsEeacyF9GVibz6XlEZZz9qzk1gaqaOz2gtGyZLdCWFi1MBHCk+hGBGTpgys3KWZp39wtdcvqaoKQRs/amGy3aOIa6uHnxx5FNwQ31TOt6Cp9ZR7t/+0syotvPi8awaGBrObD/nEJw79wZZG79kNZrC6hpeyA2743O+dBfmVYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4eba0adfa04so72314271cf.3
        for <linux-pm@vger.kernel.org>; Tue, 04 Nov 2025 05:34:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762263255; x=1762868055;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lYDUlHzikfVS+CmiS/PszA+brPtjo5Wdl3Z2oI+5wg4=;
        b=mLY/mZMNA5U6c+NFUlV+WZlni3kF/TmibMQSoifxceXbAcPhEGvU1T3MRVvHmlktjK
         sXsemIiG1JGU1nyIXtWRCba/NlDl4zlOUdv1OnSMNCwiGpNIAyezXcGOV4YbgQNPA+JE
         7+iwsdf+P/AFhcBQBgld5EANr2u/Rv/QnuSSscrNoDQnyOlgryNVhL78V5wyE/1S4ZY3
         Ik+5f+3l+CoUOea0EgKBJ3RjFKf8FWE4rxJF9vzztC245Ahq5dDk/KFDRWcLYTCKvLOD
         xVoX8EFnJh0jMZXxff2Ks5mBHIUTGmziGZ5D2g6+mOaPv3F0Pi6ihiNFaNxWDMudfZLb
         Kegg==
X-Forwarded-Encrypted: i=1; AJvYcCXclCOYtu9ZM4Yn3SvwRViwzdDFW/rB23RCqnAFiKa4+1aVuv6fBKYXeOEbYNdTIWM/SsQKmY8RZg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp8ejh/xx00Ev6HXaa14DXFUTYQl/5kiaWdGyQ0YfFy3GZCpK4
	IYDcbHvRVQHiAAV+J+vc+6es3+dyk0+4+Jci5vFxKwCUSraCjmRY1/UuvOLyUlA2
X-Gm-Gg: ASbGncueQadqtwSpEJJB9Cdzhghq2KAJ+f9ioTijiJBGuVurjZhZ+A62Uco1VtLB/fk
	Jor4ItY4p+F1FXEaJ7/Nn3fpm+ptukZviBUTEMYmz7luFuFjVljLmAx6OArXLN7Y2HOsNprNAUA
	3jhDPcr7RVqECipFG6c5WD/0ortViZhjPl/js4UqDN0wdNsqQUayzjCcWKhqQZcCX3IZABuU8eJ
	5QCtKvCuNtoV/hT6PemZEi1q5JeR5jYgoNrZyceCumRjYu2IGS7jPLsqPI3eJSDU5UA1GeIZIRv
	9/6zs5AMYYkt48EXg38601sfONdHPbD+dtiC3LYcXpY6tXdTBLeJMi8ZN6U/G8j4wmLBGKgtP+0
	L0Fkqxy3AMKp5KI95UDBB0SEXCxaxz8B2wCANiz/CEwA6WvbfVJmfNtdk2OowqnKO6lJ/HZ/8Zr
	RzEhGf/HbIjHQfhm+OaKhfy1PfXUGyD/FCCrmBkD3zm+P8398B3RMkDUxe9kacitI=
X-Google-Smtp-Source: AGHT+IFBsF4OdrXzw2544sekctL8IQiF9rBM4NMFbupVJfFaNKb1Q1qSeUan7qe7jTqBfVl3ZhVGIg==
X-Received: by 2002:ac8:5ac3:0:b0:4ec:f31a:1496 with SMTP id d75a77b69052e-4ed31001a78mr217093601cf.56.1762263254832;
        Tue, 04 Nov 2025 05:34:14 -0800 (PST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com. [209.85.222.180])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed62334f52sm12844671cf.20.2025.11.04.05.34.14
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 05:34:14 -0800 (PST)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-89ed2ee35bbso849204485a.3
        for <linux-pm@vger.kernel.org>; Tue, 04 Nov 2025 05:34:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUb0Me/fWAaO4+3CnVyd9ktmzHewKXkUgBm1Gd/fzBBD7yqXA/qarOKhX4mUWA0PX7dY1DdzeRZZQ==@vger.kernel.org
X-Received: by 2002:a05:6102:4409:b0:5db:ecdd:1819 with SMTP id
 ada2fe7eead31-5dbecdd1f41mr1520007137.4.1762262945679; Tue, 04 Nov 2025
 05:29:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104-aheev-checkpatch-uninitialized-free-v3-1-d94ccef4917a@gmail.com>
In-Reply-To: <20251104-aheev-checkpatch-uninitialized-free-v3-1-d94ccef4917a@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 4 Nov 2025 14:28:54 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV+12MoAGNHC9kf==Bt0cLuJ39Fs+W61DN67sE_p-u=og@mail.gmail.com>
X-Gm-Features: AWmQ_blcNEGb9JhXjFZhCY93PMFoseFIULDniUnWfKSfhj8iZuZ5UaoNxtqoLrc
Message-ID: <CAMuHMdV+12MoAGNHC9kf==Bt0cLuJ39Fs+W61DN67sE_p-u=og@mail.gmail.com>
Subject: Re: [PATCH RESEND v3] checkpatch: add uninitialized pointer with
 __free attribute check
To: Ally Heev <allyheev@gmail.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
	David Hunter <david.hunter.linux@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	linux-pm <linux-pm@vger.kernel.org>, dan.j.williams@intel.com
Content-Type: text/plain; charset="UTF-8"

Hi Ally,

On Tue, 4 Nov 2025 at 10:58, Ally Heev <allyheev@gmail.com> wrote:
> uninitialized pointers with __free attribute can cause undefined
> behaviour as the memory allocated to the pointer is freed
> automatically when the pointer goes out of scope.
> add check in checkpatch to detect such issues
>
> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/all/8a4c0b43-cf63-400d-b33d-d9c447b7e0b9@suswa.mountain/
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ally Heev <allyheev@gmail.com>

Thanks for your patch!

> --- a/Documentation/dev-tools/checkpatch.rst
> +++ b/Documentation/dev-tools/checkpatch.rst
> @@ -1009,6 +1009,11 @@ Functions and Variables
>
>        return bar;
>
> +  **UNINITIALIZED_PTR_WITH_FREE**
> +    Pointers with __free attribute should be initialized. Not doing so
> +    may lead to undefined behavior as the memory allocated (garbage,
> +    in case not initialized) to the pointer is freed automatically
> +    when the pointer goes out of scope.

I think this is misleading, and can be improved: if the pointer is
uninitialized, no memory was allocated?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

