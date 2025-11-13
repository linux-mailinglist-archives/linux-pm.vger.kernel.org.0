Return-Path: <linux-pm+bounces-37960-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F31AC57F61
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 15:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90EBF4EDD1C
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 14:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADCF2C21D4;
	Thu, 13 Nov 2025 14:28:46 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993E029BD95
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 14:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763044126; cv=none; b=GsAzquajFUEKamTFUbTKX7RSu5/fIC8Nv8MRMtKi1gLgmbN9iJCb0E2qV2E8aQBrnEmAFzxRE6I+5V3YY0JSHY7vGIuOAAeN10hCnrQaJZtrWRU+X0Z5Z7+bAzV/8A5onSj2Myz738yLln7AywKEcdieSzCvyRRDGA5/i9P2Dsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763044126; c=relaxed/simple;
	bh=A55pVaLB1a5M/183qzOCCCtVLqILltVvYYcujE/3gBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pd+uKlOI8r245HyhSPLw7F2SfbE2QMoNsXtDVp5Czbk0xdM0xzuj302/OMGgXaLlFqWtTvB77UFCWKBefvD25JryTF6YpPSjwZdmihkeTwkXH+9dVw4pW3UFkmgYOFxEZms1WteOwjOyY9GZAI6xElvA/rXSVzGQhv/5rP6xx2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-9371aca0a4dso550467241.1
        for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 06:28:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763044123; x=1763648923;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPVdv+Cr3ZbcMU8t075Et/PpRUdOj7rpDshXN3z13xs=;
        b=GsRMKem7DeQBb6MxfHjz5Swa4yygCUmFHjzvoz6tI5b6YKkn++bjZpXK0zBL0RKTBv
         H/qDHB5exPIPORRoV6pWauoaPWU6qy1RYbTCiC4mUaB5eQk6TBaGlNzRDKXLRdgSch6H
         510cbjtaSYgWdhwXZ1SYZLlX5UqApfrxbcKm5vRpEXeR9Aw6ZilC0vOdsBzc6GNCbkTX
         KccpZno8rCuL1OWi2RCOItyielf/0aY8aCwt+DArstA29LckSsm0ZQklE03sJOcIwP7F
         oLiAY730EOhdyaieYOBvSC8erJfL/YTdJLTxo5xpI7JtiGtcakmMDJXtbmTxxkd65GMv
         Jq2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHMvS3I8DEBmMBXV670cvAC0HSVY5RRewDBrlqjR5E5a5GCwVvZbToYunPxQnIzBEbuMFM4yfAEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfcFy0r1GCEJlo3AM7Osiq7SPNNF+k+LRzSNSCf13qPfsZm+C4
	i40FfeHYyMZhCkcPBY6k80RdSwt1B6FOhsiFSycu8Q2+I+VqHJCo61L7tbqwTtSSQ6I=
X-Gm-Gg: ASbGncvkv2SdfFnHGg2OMa436QDMgPgJMxOgnvTbz4z8ki7cn69NnpHjgVVJkxxI86X
	3VQXGHqMNaBXfdVX08Kh4KQiTGm6UNsf1309YkgrWCtgXGzLeaMBXo5FO3DV2jn8PM06AzSnaZ8
	rcPvRsruJym93b8V3dCkkVP45XsDZzD0pCCa07N1muztRwYqc9MLDLkrIvmlbtipOlJv4zBC9Bz
	GxNzATHWYmJAf0nuJU3D3OUD3x5XeT0dvGYIGZ4tC3NaQ7ZhsLRb9YglSCuzDrmfZZ1RwCnD4jp
	Ji0VmF3gKHDG4gxogOImVJpKZlfmsyCOeE3EkkDMLLs0a2dBMJ15eB9B3iJj1EDkMqUjVgvL2fN
	JdS+jJh9kLU0o3KjhW8ALtJbepZ550N6vx83CnbUIZvptiR0eeMss2PPr+nFLXxStwrAAi8bcoO
	BY6IQzDMbIisjscwCiDzvnj6C0D46CsaDl6UPmGw==
X-Google-Smtp-Source: AGHT+IFXnTYoZMP8yMaXoKjRdkK6q+vZdTkX+e52rZ1uqONCYs92uPjZjLYt5/65PY5BRtFmofzIfw==
X-Received: by 2002:a05:6102:f11:b0:5db:27e9:933f with SMTP id ada2fe7eead31-5de07ee2f47mr2545510137.40.1763044122781;
        Thu, 13 Nov 2025 06:28:42 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b0f32f178sm718180e0c.5.2025.11.13.06.28.41
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 06:28:41 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5dd8a02e808so679271137.0
        for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 06:28:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVsmZd6GsyL5HAKIq68vGUkxJfBB9EUj+MYxj8jHwvQeS4a43T3mFOkgcSpbZioKzjZlVd11X4Liw==@vger.kernel.org
X-Received: by 2002:a05:6102:4b85:b0:5df:af0f:308c with SMTP id
 ada2fe7eead31-5dfaf0f34c8mr2015901137.38.1763044121413; Thu, 13 Nov 2025
 06:28:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020143107.13974-1-ovidiu.panait.rb@renesas.com> <20251020143107.13974-4-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20251020143107.13974-4-ovidiu.panait.rb@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Nov 2025 15:28:30 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUz=f5ArCV-w7dcyEdqhsZJrKyf=KwY18mwOgVdt5TQDw@mail.gmail.com>
X-Gm-Features: AWmQ_bnUzqLPji7mNY2mLpWw72wOSZDLLWSl0uz9lB3HUP0ZZ52peqFQbz3UfMc
Message-ID: <CAMuHMdUz=f5ArCV-w7dcyEdqhsZJrKyf=KwY18mwOgVdt5TQDw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: renesas: r9a09g057: Add TSU nodes
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: john.madieu.xa@bp.renesas.com, rafael@kernel.org, 
	daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Oct 2025 at 16:31, Ovidiu Panait
<ovidiu.panait.rb@renesas.com> wrote:
> The Renesas RZ/V2H SoC includes a Thermal Sensor Unit (TSU) block designed
> to measure the junction temperature. The device provides real-time
> temperature measurements for thermal management, utilizing two dedicated
> channels for temperature sensing:
> - TSU0, which is located near the DRP-AI block
> - TSU1, which is located near the CPU and DRP-AI block
>
> Since TSU1 is physically closer the CPU and the highest temperature
> spot, it is used for CPU throttling through a passive trip and cooling
> map. TSU0 is configured only with a critical trip.
>
> Add TSU nodes along with thermal zones and keep them enabled in the SoC
> DTSI.
>
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

