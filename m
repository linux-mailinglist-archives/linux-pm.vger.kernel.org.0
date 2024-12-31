Return-Path: <linux-pm+bounces-19869-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 223859FEEF2
	for <lists+linux-pm@lfdr.de>; Tue, 31 Dec 2024 11:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCF9816059B
	for <lists+linux-pm@lfdr.de>; Tue, 31 Dec 2024 10:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696CD18B47C;
	Tue, 31 Dec 2024 10:45:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CBD17ADE8
	for <linux-pm@vger.kernel.org>; Tue, 31 Dec 2024 10:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735641938; cv=none; b=trCCvPC6PJZPtpuRMhT6WZZH+av93Esqqv2ulUUoVXYf4OWTEGorgkwgER46HuXo+ZW0vJo5SN6giCwhtLfO8ZMOOMZRwZ4gWRaG3wyLyHk5H5gMf1AwkGYQaNYcS7PfWS9K8dDfIaj+uim+r/ueMOW2nFq7ZCiX0LJLnpaVkyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735641938; c=relaxed/simple;
	bh=8UKnqgFbtmnqOMWwTh8mIDlxrLjT27uUCtFxXXb6qEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8BiCY6eNz8up7pIObCX9hSueCDlTJsJ7gRUTTjlBdgN/6a2Iu1PJY2bWzRcUx+MEbsVqnT4Hlv6S7i2uohxSzFxAQwaSi51M5w0N6rQCprHN2gzlwIH12a/DeJCEtHm86QL8GtXnkg47QE4M79ApwU3TBYFHgAxGhe7TLMWraQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-51873bc7377so3057366e0c.1
        for <linux-pm@vger.kernel.org>; Tue, 31 Dec 2024 02:45:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735641935; x=1736246735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GrDuQ3FjiFrBA5fOntPAq/gqtlIWTr9yZ5HRre/PJg0=;
        b=nOsBk0WPOE2Keucip4ovIHSxI3H58EngVp7lvUmlCPYTto5CRmwxyFKet2dYuPeJt9
         zENnxTTJvhOkl5Tl06LGJq9g02PtlcFxQDFIw5+8y/su2WsU+WcXVaEtbGnzVb93J7FS
         G6BmK4j0SGt4YH1G0QFjlTDFywfvWico8NgxjZVBTxm+a0TRT5V+LXNPdVNigKdq3YTg
         WbIY18AV8bYWMGZ1pSHmf8KHH9xHAmCtNNnE1fLrThpiTOTtSSma/6SzpCSwC5hUbyJt
         V1hEvLfxhiUjspWL5exXj8tHQnqARzHhOM9TkV8H3u9n41UpMZljaGLa7BLkIUvLRVWb
         mCdA==
X-Forwarded-Encrypted: i=1; AJvYcCXwjkOQlRqj8JRju4W3+tt9bajOunZ1VQfKl1xkfLflvl5eUOOUGWCe8y4arsFyNG1WJVPjmeqplQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEfvseazue/fCvJUziNDYwReASEtqopwRNqBZ8o/UtHQ9b5MiI
	tsL12Cu9P1Lfu/NKOOv6TCeZy0zTxcEO5aRJFQCyxAb6+195J+1IXjMbLrmM
X-Gm-Gg: ASbGncs3LiCmNjBr/+kPhKcidpQ8E1gb1Rdj+h2pndVY/B7TBgXY9IJRk1VPbHvLTE3
	jpPVwdOz6gPUbivd11AfjrWH1KJHVlrxtm/KIq8gkgxXiN8EfXvL9DVP3bobMYUwxJ7eI2AViVz
	7t1KYWgYgPLLU0+k5HWw+bXDqJfe2nDfc6rf9/dNiz4IvZgofei4NokQuHrawhiHCu9iuZW5lY0
	1UvByh43WuqsrEcqih3ySyZPqcTsethsRYwAmvM/Mj5byMtqR0kGx/XvRrRv6ei0jPs/4Dwz3P0
	l+JRGLPotqkw+a6pnEA=
X-Google-Smtp-Source: AGHT+IFLWSvxbmOQTwdtLHokLs0Y3XMh9oOcDBvXe4M4qzp8fUlkMqcCC1pHEa+QNx0eXyDRKvHw7Q==
X-Received: by 2002:a05:6122:1999:b0:517:4e40:6838 with SMTP id 71dfb90a1353d-51b75c65272mr28269779e0c.6.1735641934977;
        Tue, 31 Dec 2024 02:45:34 -0800 (PST)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51b68cd9a0asm2471746e0c.36.2024.12.31.02.45.34
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Dec 2024 02:45:34 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4b11a11a4f0so2491853137.3
        for <linux-pm@vger.kernel.org>; Tue, 31 Dec 2024 02:45:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqizU3ZM8nmmmeP7q+H0bW5KMjWTXddWPsauIDs8eh/rvHQUHHAFuJn1OQCcoXCY1ODeDbAIAKnQ==@vger.kernel.org
X-Received: by 2002:a05:6102:3913:b0:4b1:ed1:56ac with SMTP id
 ada2fe7eead31-4b2cc37e0b8mr33837931137.12.1735641934570; Tue, 31 Dec 2024
 02:45:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218184433.1930532-1-l.stach@pengutronix.de>
 <CAPDyKFoeebzUkmeya4WEcdc+px-=8rwSGdmF_-1giiwkHvWo5Q@mail.gmail.com> <CAPDyKFp8jvEDGfkuMzzSVSo2gDtf+naC3QwXrCJD7t1e8wPJFQ@mail.gmail.com>
In-Reply-To: <CAPDyKFp8jvEDGfkuMzzSVSo2gDtf+naC3QwXrCJD7t1e8wPJFQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 31 Dec 2024 11:45:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU=Kyu7n-Wn85mPpJFKKxRDqNAVv+RBJsN7Xauma-jpHQ@mail.gmail.com>
Message-ID: <CAMuHMdU=Kyu7n-Wn85mPpJFKKxRDqNAVv+RBJsN7Xauma-jpHQ@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: core: add dummy release function to genpd device
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Lucas Stach <l.stach@pengutronix.de>, linux-pm@vger.kernel.org, kernel@pengutronix.de, 
	patchwork-lst@pengutronix.de, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

On Thu, Dec 19, 2024 at 3:49=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
> Applied for fixes and by adding a stable tag.

commit f64f610ec6ab59dd0391b03842cea3a4cd8ee34f
Author: Lucas Stach <l.stach@pengutronix.de>
Date:   Wed Dec 18 19:44:33 2024 +0100

    pmdomain: core: add dummy release function to genpd device

    The genpd device, which is really only used as a handle to lookup
    OPP, but not even registered to the device core otherwise and thus
    lifetime linked to the genpd struct it is contained in, is missing
    a release function. After b8f7bbd1f4ec ("pmdomain: core: Add
    missing put_device()") the device will be cleaned up going through
    the driver core device_release() function, which will warn when no
    release callback is present for the device. Add a dummy release
    function to shut up the warning.

    Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
    Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
    Fixes: b8f7bbd1f4ec ("pmdomain: core: Add missing put_device()")
    Cc: stable@vger.kernel.org
    Message-ID: <20241218184433.1930532-1-l.stach@pengutronix.de>
    Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Can you please use Link:-tags pointing to lore instead of non-standard
Message-ID:-tags, so we can easily go to preceding discussions?

Thanks!

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

