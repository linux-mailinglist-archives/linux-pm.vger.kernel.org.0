Return-Path: <linux-pm+bounces-37166-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7736DC23E04
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 09:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 769CC188C970
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 08:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7602ED87C;
	Fri, 31 Oct 2025 08:43:15 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D992E9EA1
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 08:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761900195; cv=none; b=bPHPe+lhzpgCMoZwEq2n/QL57BrRmw/+tgCiyYJZDJh1UA7Gnb6huH9pUwNEjFPO5YSJN67RoQRQs4PtWnvEjum07vfvFVcy4dlww+GmLW0rLCieecfUOzbrVtM5bKDyHXXo0IjAMSGylX7ucTiPijzPWpC0CwwmGlBXPg/v4aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761900195; c=relaxed/simple;
	bh=WJEG5aSHGx/vf+vzxryZjx84TMeZQxoBKx135ESeS9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fbocrcnfw6cIMEgG8eczqoNCmVmzitkDQT+MVWBuZ80rAop4FeobW827kHZytfnlge/r5tMcXRhzargf27dQiIvhVqLcbpXCDpOIAtO9lPfsUkxSWtC1fJcEKSb7B/39h9l+7rCkHjHExblUsNPtwzEli/cc8mLwBA1Vue3japA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-935194112f4so20269241.3
        for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 01:43:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761900192; x=1762504992;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=srKuvBcN8qwhEwMAzIP9jvMl8T/5K7+6w69VAb/dJjw=;
        b=SAanC4qStgybJqLaLvoun6Lh3Sfvo2esIkyfyCini3qocQAyQpyV1bWaA1pWESexIb
         YVkVsk4PD3xyTMjs766ZaspE/aO/zt1L9Nkysz6N86ROLr5Rz+9+jzlL+o1gQnh3gcDe
         zfhTB/TEocwHIW2wbECbylAIWRsDFD/h9UKxQaPCgwUz9OWEFQeSMtYsTeUT33/buG8g
         tHelrzaOFvz5mF7sK+PtUHHGkHS4cmBexSPTzV7Cf+mvfC7nUkDtmwVFf/piq+B/edBN
         qDe5mXFbrtSYslwCgoFOod+fvj8pRmpoNQlfqrIp5JChwZCgK+Jy4BvkvLaXNKBsJBPn
         jyJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP5DCMGvRVzT8zbhiUpOtQ0Pu/9zcPRFS2+KFWGd4wk4gsqmxLr3eKraL93FbYrvchhdy8FgVZqA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu63LA4spxpCw3H9A8DxHhGX7iU5UXI/CwhwZKpEiPg+jYtb4W
	sKYYTjR8dFE/jUOxjF6w2UeVb+cPoh7W+q7KsMU8vZA/wmUIjRrEvl5QqYAFlTz7
X-Gm-Gg: ASbGnctF8qeiE0AzxG3AKN6UVCoWUALi8I6oklFgiXpaF18RxJr9EiXvB36UpDkcWVS
	yl8pqvdXjWzrHeZZ/Z85H6fq1pZgLjt6pgWZ+4XjIEYRWiBI/bKr5nXxzClSDSR/CjYuU+pbqSD
	CwvMuLntJjNDSMjnRNK48N/mIH86CghrxLHucoIbL/G1XffL5ehSzmFei0RMo4C3rEgHZAHz3//
	mvFeZInNrxxPyX9xInAKJ1FJzVyc1iXLBomRnuUHvi5Xb+vThEut1lPSEkEITScNl6E7j49+HX4
	zk0DcKF8XkiNPv4lrBPGIOX35Wwuo2Yy7tTQAZNdssw1dG9M1CejmEqtWkT7l3sv0rydN0St4/h
	3CtenkDPKwLzLyFEW4kZUgblgzqamfezuD4LY5uU+rfVAkQQnExr3BPrzu60m9UUv45c75fVxHl
	uDqm+QgFPND8vntrlI78kHqT7PDHG6RQR4jofF2vy37+IT5X8l
X-Google-Smtp-Source: AGHT+IGmkODTs/EjnDFkNiFSF2GsV2ctaQsmhogeTxCuPiY13hfUvU5QLJR3qSEpPFd7asVtaUNu+g==
X-Received: by 2002:a05:6122:3d05:b0:559:3b8a:70ce with SMTP id 71dfb90a1353d-5593e2fbc4cmr901159e0c.7.1761900191879;
        Fri, 31 Oct 2025 01:43:11 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55944963708sm431945e0c.5.2025.10.31.01.43.11
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 01:43:11 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-935194112f4so20261241.3
        for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 01:43:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZFEPBnwwCzasSUllebnmgFBN7WRqmczKktp4WiCFwHSROnZi2HWtiEqt9pIwk3Yg0nvCyfMRuAA==@vger.kernel.org
X-Received: by 2002:a05:6102:26d2:b0:5d5:f544:a88e with SMTP id
 ada2fe7eead31-5dbb133e6acmr609871137.35.1761900191030; Fri, 31 Oct 2025
 01:43:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMuHMdWapT40hV3c+CSBqFOW05aWcV1a6v_NiJYgoYi0i9_PDQ@mail.gmail.com>
 <6854ea2b-b316-4711-b849-038d532f00c1@imgtec.com>
In-Reply-To: <6854ea2b-b316-4711-b849-038d532f00c1@imgtec.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 31 Oct 2025 09:43:00 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUdYidx7u2FOFUmiijp-YeYaQQw_Lrj_E-BoUubuxxR_A@mail.gmail.com>
X-Gm-Features: AWmQ_bl5-OwN-KWDVvu4tvr704LIaV03yTPqbwFu_WpQDxzklRlUNeQBSF_vnQU
Message-ID: <CAMuHMdUdYidx7u2FOFUmiijp-YeYaQQw_Lrj_E-BoUubuxxR_A@mail.gmail.com>
Subject: Re: drm/imagination: genpd_runtime_suspend() crash
To: Matt Coster <Matt.Coster@imgtec.com>
Cc: Frank Binns <Frank.Binns@imgtec.com>, Alessio Belle <Alessio.Belle@imgtec.com>, 
	Alexandru Dadu <Alexandru.Dadu@imgtec.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Matt,

On Thu, 30 Oct 2025 at 13:18, Matt Coster <Matt.Coster@imgtec.com> wrote:
> On 29/10/2025 14:08, Geert Uytterhoeven wrote:
> > While playing with the PowerVR driver on various R-Car SoCs, I ran into
> > a crash/race condition on Gray Hawk Single (R-Car V4M).  After adding
> > the GPU device node to DTS, the driver fails to probe due to lack of
> > suitable firmware, as expected:
>
> Thanks for the detailed report! I'll make time to look into this. Do you
> encounter a similar issue on other R-Car platforms, or is this exclusive
> to the V4M?

Yes, I managed to trigger it on Salvator-X with R-Car M3-W, too.
Reproduction steps at:
https://lore.kernel.org/linux-renesas-soc/CAMuHMdWyKeQq31GEK+-y4BoaZFcCxJNac63S7NoocMj1cYKniw@mail.gmail.com

renesas-drivers-2025-10-28 is available at
https://web.git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/tag/?h=renesas-drivers-2025-10-28-v6.18-rc3
My aarch64-linux-gnu-gcc is gcc version 13.3.0 (Ubuntu 13.3.0-6ubuntu2~24.04)

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

