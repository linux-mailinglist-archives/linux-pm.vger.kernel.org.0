Return-Path: <linux-pm+bounces-40476-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A129D0427F
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 17:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6BEA315C224
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 15:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9D92236FC;
	Thu,  8 Jan 2026 15:41:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9751D32C8B
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 15:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767886900; cv=none; b=HsmYWmsEIK61S/hk8jLk8dNUgMvRs5sPV9lDX+jTqKki0SE+Ijy9Q8WLCZSDewpbDmccbF0wZ7oEgje5y8UnZYzJVXHAe8O5+TkhSi7bHcTLmdp4lxDesWRexXqpLfAKmnvA9kRJa0HkVmOWEUaazQ4SQs/nNZ5Z42tyOy50Mhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767886900; c=relaxed/simple;
	bh=nOXI+klEGl26fnDx+EjZGGsuvBdNo6RtFb/zBiHZmGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LcveqUGJeV8W2zd5zbMGQVwejMQ5hLPZpb+pX92wS7Jp/2EvSzWipxncEXoJQA5oHmvssKy2bIFtmeXunty9yRmAruAxkCEPlaY4o09jrdZ613O+7XIFnGLecWpuLBYPZ9Gcc8o4F/5T+iatbk3fjbVF8plR4h4u2M3x6DCJP8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56021f047d6so1056426e0c.0
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 07:41:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767886897; x=1768491697;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDBqyQMP/mzqkMYSw6gEE+uyIajrqLvoQIBVBvwesYg=;
        b=cF0UFB6e2TwgSUuEbtI1ABuvf7YtJPVCqmVpD73gv6FKOXBrEkdkjeVT+alar9bBT9
         ruMDK9wMEDHyYvGYgyxU3tKiy3E9VmcNnTGw8azQkukMvQihX3OCdn3X7yUOn7XcUqsH
         LHCYfarH/1Hle4o73Sn0Tdn22uMYmjN/ZuIFD0lAFBxdhPWLkLpusJYpAUPWO4R7y/Xw
         BOS/mYxFLJfQpDhWe63P0H2Jjovjat3ZW1OuwUh4ClU+f6AxZcLKynH6swjFpVboqRx+
         fKd+Zdqn/hVZn6c9ZDGThxId/3XDsXMeO5KfnTG0jzksrLhdzqFRMr9JbB9asAc/bTrF
         0jzg==
X-Forwarded-Encrypted: i=1; AJvYcCVII+GF9D0HMLXZaAJEEVvbjwhmXh0hdbvEICd/X9e+j0WNdsTm66wpdOysPs8i6QCaZCNBuqQGLg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwv5LsqDplAkXRRxtnqM/f2p6Xqek+33hS5OyAmdOdyz7jcyln
	oR/D+072A3Fpddbq6ZB2vGy69SHgap3ubrlE5ObzDrhgWZlYtJwi9RgSgyGscwd9
X-Gm-Gg: AY/fxX71VF2Bls/NYKHwne10fesDjPybF+tIfIwjCMzm5L0DOiN1vLXkQ3DqQzod6P7
	Zr+Y/ZFkUJd80Zh5G0ypoQFGRCaRh+K/pk6TqJqVkVT3Hbx5yLSKTOGN0Y9z0k1o+wf+nsR2g+9
	0dfkJMNnq0xGo4p7fgFsMrnQZJ3NPuzIX4sYkWlKHjtK1Xt+QtiAT6gJBOkUC0swffjFbDXRSxq
	pY2OSEugBnts8vHuw4FJt6T3xfFHeIeTThrSd1yjwvBFMJj2kc5F4EPjZJBQxdJBbAi/sAtfx/j
	KYFMvDN22nNC28uHawwDLXUCfWUZce5dQiLHg5tyHfzA20v5nhot6MF2V/r9oCLJz0Sl3Am6/uV
	/UJQUO2pEWJ2SFJBYpOmoSpA5Ppa/vrCBjTykvs8bcmJ1RfB29itImSEjeAf9UPio6JRJj/4Dpb
	PIPXbhI90GI0QpOVEt8kd4ZowY32WpDN3FKtGKZqe00ev9Haer
X-Google-Smtp-Source: AGHT+IHzX33Gu1se8FH2q9vkUF2yjv9wdFa3ERJdqvf4LWb1OqCjM+y8qrntoxLRy06G+P8FFIvXpw==
X-Received: by 2002:a05:6122:46aa:b0:55b:305b:488d with SMTP id 71dfb90a1353d-56348007493mr2547674e0c.19.1767886897383;
        Thu, 08 Jan 2026 07:41:37 -0800 (PST)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5635f13471esm1016951e0c.14.2026.01.08.07.41.36
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 07:41:36 -0800 (PST)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5ed09471ab9so587592137.0
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 07:41:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUGo5RU+RtXTGOk8Ap1V8mu0IHwxRDM8r9IPgktw1ZFLNN6fl2leo+eg32ht/Jn4/zvqfrrlxc07A==@vger.kernel.org
X-Received: by 2002:a05:6102:3f09:b0:5db:f573:a2c with SMTP id
 ada2fe7eead31-5ecb6875d0fmr1951115137.13.1767886896018; Thu, 08 Jan 2026
 07:41:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126130356.2768625-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251126130356.2768625-7-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251126130356.2768625-7-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 8 Jan 2026 16:41:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU+UOdNjUPWiXbJTv4MYjPwuxLtgXJ2AL0+XVHatJW=6g@mail.gmail.com>
X-Gm-Features: AQt7F2oXVcr96RqhW7ksn9tJ0uMEbuupTQNMcjQNZoyMUd0wuPKdl5AUIme_0eo
Message-ID: <CAMuHMdU+UOdNjUPWiXbJTv4MYjPwuxLtgXJ2AL0+XVHatJW=6g@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] arm64: dts: renesas: r9a09g077: add OPP table
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: John Madieu <john.madieu.xa@bp.renesas.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Nov 2025 at 14:05, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> Add OPP table for RZ/T2H SoC.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.20.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

