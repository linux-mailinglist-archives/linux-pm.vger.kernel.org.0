Return-Path: <linux-pm+bounces-16354-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0FB9AE208
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 12:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B7EFB22C6F
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 10:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7B11C07F3;
	Thu, 24 Oct 2024 10:03:54 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28001C07E8;
	Thu, 24 Oct 2024 10:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729764234; cv=none; b=tLH3XPUU+9WWi1QxHtDIo6sjBGjQOHmaDYgDmNNdyz422h7xPUkG7SU5+q3Mfum6tyHd754Jf8r//LbrxPyIhOx2kveujn/olUCFZPr9f1HrrJPzyFJ0D1G3JUa2yhQqyCwIaqatQ4VOQSHeStZftYTyQKm6Z3QRLEEB8hQg3gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729764234; c=relaxed/simple;
	bh=Bm0t+UbS6/N6Y1136yIFyLmb5F/KydJo4Y9Kvz6oqyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MC5fTDTp238X7URgETKFKL1qa84WhGIgL7JE2fCVuFnKEdENSM3s/1nS3sdZvrTi5fdkf40ek/5D0sZVpp0Yze+8mrzFPmXumj+XJD2Zsu352eoOi64BaF6D2VblFAzYstBE7YZqdsBxZbiCGYFNqUpCr699w5AaxbWIDy8SlLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e34339d41bso7535117b3.0;
        Thu, 24 Oct 2024 03:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729764231; x=1730369031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kBNib9fI7OsKe0S0XoMgI5p0KxqmwSJ7TbyOIgCT61I=;
        b=n+5Q8L8MP1cruHBT8h99oTScSQyNsfw7GVKV5bgN+TI/k6wcsHCkgqG26mEiiJz0xS
         DtwaTmi3gpjyyv5WRMsxczCkCU90Y3JQrD/0lwfxZ7lFeAq6DaG40iCzqp535xDGS5oK
         E9+bGIaYid3IKJovZwRAnorzZ+gdfa++SFVbLe9CPa9uCMCH9x9X6JqWHIW9Sc2lXmeR
         V0rTvOFra9POO87JAQzWL/HnQVBWKTXz86eNNCDyuTR1BnG3e3Pu+UL3mQZxYcM8N5+A
         f/2z5+p5OANmmfgH2ad8QT3fjUJY7WufMG9rFCUAKpP4u0Huwi2KP4OV8CLxpvUmkl7D
         wJdA==
X-Forwarded-Encrypted: i=1; AJvYcCU0BZqbGR1jpZg319I48eJF1iDSQet2KiWdQy9xqG/Kp45ucWO/qQHu6M5OTo10XEXiqv/z5Tk8AeI=@vger.kernel.org, AJvYcCV7whR5rlzAL+0eKIm9PvETEIVd6OSWB6HR8M/rEMw+aqfp0e/71B+8h0hC/bP47XeOSch7Jk+HN0AIRC6z6h8=@vger.kernel.org, AJvYcCW4WnjD5NDPH8XH66B9C0QoSYncVtloAeyFlcxJcpxSr/+M/oIxYljy3IHSah8KJ40x2axyQloWAR4=@vger.kernel.org, AJvYcCWB5B7MDhT8cFpods6F2g5hO/c/1u8DEo3dKE8Oh/E/YeIxQVCKZv+MEdgQ5ghbVCROEKNML61W0M30SY2J/CJmiuc=@vger.kernel.org, AJvYcCWKM64QBXT0FeyNdpiHLeRO9Kajccn65ZfFNMNC8QMMXqqCABj7foXZGIrhYhvovkQCv9rcOzOfwQssYWt1@vger.kernel.org
X-Gm-Message-State: AOJu0YzeF5emDR7q968TqeBdEQSv2h74DkoMc9pyurs31jmLAESqS4fE
	O+R1lAnrOL4109kfcrUhxIf6n3/kluLuBnGEpZ03jzLrpXmXzRQ1INamWnhA
X-Google-Smtp-Source: AGHT+IGhu7YOMVfWbv6QUP3X9d6DUjcNCObmVuumXVoXb/CekxesvT/qehzsFkgjGqdP957Bs8QhbQ==
X-Received: by 2002:a05:690c:6b09:b0:6e3:31ee:23ab with SMTP id 00721157ae682-6e8581aed96mr15670177b3.25.1729764230767;
        Thu, 24 Oct 2024 03:03:50 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5ccb641sm19144537b3.83.2024.10.24.03.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 03:03:50 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e33c65d104so6507987b3.3;
        Thu, 24 Oct 2024 03:03:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUplpB7SxUzgyiMwgBxEzyZ85tlH4v0YX3lf+8oU4U3zPz+L4r0ykzLhhreppv1LDEf2n0BreJWeudBxXOmvlq2kLY=@vger.kernel.org, AJvYcCVrQLaG4oAAws5a2dYoSRboBn16pObJkWBH1EFd/GJtgZ5Lco/aSwj6y9f6bzm+QmI4vWBn9rPj/BZ/oVHg@vger.kernel.org, AJvYcCW2PNI67yA85CSeKF33/CpTTfrtaziQTzUJMa+cOH1bjj2Qavt/7ZF3A+mp85cqPSsddYZBjb5cl3I=@vger.kernel.org, AJvYcCWy1ttWdU/y3+kbQE9NNKUXRStjeXqPb6pJlsUp4IuTzkhZcafCAgzWHqdxFTlo6aLjKRjLNWQMFfo=@vger.kernel.org, AJvYcCX7dixJdPZrZLkWGTPr3750lhj+1clDP6igiY3qls2QzcauF/n67C7bQW5PU1vdm2ZQKzq6uj9fLwON7JNXBDQ=@vger.kernel.org
X-Received: by 2002:a05:690c:6610:b0:6b1:2825:a3cd with SMTP id
 00721157ae682-6e866319e02mr13432837b3.35.1729764230288; Thu, 24 Oct 2024
 03:03:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015164732.4085249-1-claudiu.beznea.uj@bp.renesas.com> <20241015164732.4085249-4-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20241015164732.4085249-4-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 24 Oct 2024 12:03:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWCDBrivxN0pzbrH=fiwMWM3sj3BTsgHOjeOAT4dr3DEA@mail.gmail.com>
Message-ID: <CAMuHMdWCDBrivxN0pzbrH=fiwMWM3sj3BTsgHOjeOAT4dr3DEA@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] clk: renesas: r9a08g045: Mark the watchdog and
 always-on PM domains as IRQ safe
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: mturquette@baylibre.com, sboyd@kernel.org, wim@linux-watchdog.org, 
	linux@roeck-us.net, ulf.hansson@linaro.org, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 6:48=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> If the watchdog is part of a dedicated power domain (as it may be on
> RZ/G3S) the watchdog PM domain need to be powered on in the watchdog
> restart handler. Currently, only the clocks are enabled in the watchdog
> restart handler. To be able to also power on the PM domain we need to
> call pm_runtime_resume_and_get() on the watchdog restart handler, mark
> the watchdog device as IRQ safe and register the watchdog PM domain
> with GENPD_FLAG_IRQ_SAFE.
>
> Register watchdog PM domain as IRQ safe. Along with it the always-on
> PM domain (parent of the watchdog domain) was marked as IRQ safe.
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v4:
> - collected tags

Thanks, will queue in renesas-clk for v6.13.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

