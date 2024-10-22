Return-Path: <linux-pm+bounces-16224-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AF09AA34F
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 15:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1852841F2
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 13:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B7819D8A8;
	Tue, 22 Oct 2024 13:37:15 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B9219CC08;
	Tue, 22 Oct 2024 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729604235; cv=none; b=taOGGwvAO7ForU/yHUUrFOJJOax2cDZKxACC8R8C2p9imh5THFNrfJLz5SsFeNU2iAFSzvM6YDoYaTbg7AGRH0mUoAISi3qColne4qZ/gTzmvAdpI4jpjdZeYj0et1f8nVp+qJEzZXEGa8vQ0/hXIFzINZ5W9K1gHL7XOf4srqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729604235; c=relaxed/simple;
	bh=jS021KBDHtA4UtpuC4paBAK9ONTM1F/OrzYnjmfKhf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9DZGAPu6tq69gnQ7gKvJR64nr6LXgOpbAFkP7k+jRWUeSmLCiPX0Wen/LIXV4Ns6OUX1rKU7vmqJSy9JU6DOA5N2D7hstl04Mlv/r1Bo60smq8RkCJQiQZnYqy4Z6U5Nti6f9bqGvF5n0/ulGb7wTc+8efe7Pvq8hZc5PQHnoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e2e3e4f65dso61876417b3.3;
        Tue, 22 Oct 2024 06:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729604232; x=1730209032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7fMGLBYZUh1hjtAZF9PX3JxjrqOky9g79+ieIgquWyM=;
        b=p5UCkYLDOhvIIQgmX2AhyLH5T/gypXq8D4o9WZ71ttZ3N640mavj4Uku4QMsDZI3yj
         b0LQJm2uLvcE1P/Us+JzNV1GVocBDGk/uXWp+2w2AnMlim9kUWyurKprdsUJMFXgQqje
         wy37lc/WtGojn839rdE8uJIeXJUsyWh0X4xF3z1ei+tHTQc3OLeRjR82s5xkese2UhJl
         nVQwff8knCYULBuHRQjtw5H7vbcQNV3GRCeHgJHTi/2Z/ky7+Xvtr4A16FjDY/XQSraQ
         9rdkRw4YYbJXkYKUN81EDknhqk3+xhQZmkVmJ0bUikOOx/gYs3oLh/hPF10WrInDqgFO
         TcbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWDqFOp6k2GfEpPUL+mDV+LB4BrvBzNA7Hn5LL27ui+srOLV/x0Xv4PJKbsb798RaEreWFt8LguJU=@vger.kernel.org, AJvYcCWQU3GB4NA7TF/9xX8jEqDuSuXKmtdEzFU0ccs2jbrsBfg/zCj94JqnbLStOF92SrEkhHeGx6hc9af6@vger.kernel.org, AJvYcCXiPKli/Hh6B0VVCVx9RRt6dzT3czimJdapLgJSRpeQxiCnGPJZcUnS14oDJwgmAUTG33HKsk8kdT5IRtZCgCgDXfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8oagSWCd1zJvhmD6nwI1SlCqYsch58mX9kqO+KMY9pJyrI7Xj
	me7TKT0ZBZYpV59I9xm8bP/q3ZLGhTkYKrkTJDd8Q8BV1R0HSU2JiCTa+tNT
X-Google-Smtp-Source: AGHT+IE1+k6M7ePwACV4piOIz4z0K/q06SnxJYYZIMv3hryVSKCX/Q1R8NUVaoblp3Xmw8yw8YGrJg==
X-Received: by 2002:a05:690c:4c0f:b0:6dd:d119:58dd with SMTP id 00721157ae682-6e5bfc3c1bbmr152980637b3.16.1729604231880;
        Tue, 22 Oct 2024 06:37:11 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5ccb6b3sm10822407b3.93.2024.10.22.06.37.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 06:37:11 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e35f08e23eso51878597b3.2;
        Tue, 22 Oct 2024 06:37:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZkQZZuAhZjpCoOVY0myfHtJoFu1keR+sKkbCKVRM/9C5WIZQ8TtvYYNBI9R3WV6QWaUMym5yDSpI=@vger.kernel.org, AJvYcCWTtMNNveRfdGFN9kyGE7iYki/3oMNGiSzFaAx5+eli+ZN3zHUMPzuXqaU4SRGc27ejBY16rWFDW414@vger.kernel.org, AJvYcCWZWXo73dDnTEAyf2nCcxWWf54caQRFQehydB/A5sguXBYqUVSBIEtEkOjm4yE27TQLSYcUyVZKcPQM9pti4mQeDu8=@vger.kernel.org
X-Received: by 2002:a05:690c:f05:b0:6e2:1527:446b with SMTP id
 00721157ae682-6e5bfbed07amr127148667b3.3.1729604231577; Tue, 22 Oct 2024
 06:37:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728377971.git.geert+renesas@glider.be>
In-Reply-To: <cover.1728377971.git.geert+renesas@glider.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 22 Oct 2024 15:36:59 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXsmAqQL+2+D_y+u1z4nn8JO+xF-mq6wWJ0pAH58n5Wiw@mail.gmail.com>
Message-ID: <CAMuHMdXsmAqQL+2+D_y+u1z4nn8JO+xF-mq6wWJ0pAH58n5Wiw@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/2] arm64: dts: renesas: Re-add voltages to OPP tables
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 11:14=E2=80=AFAM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> When CONFIG_ENERGY_MODEL=3Dy, an error is printed on RZ/G2E and R-Car E3:
>
>     cpu cpu0: EM: invalid perf. state: -22
>
> This happens because the Operating Points Parameters tables do not list
> voltages, as they are all identical.  Previously, it was assumed they
> were optional, and unused, when none of the CPU nodes is tied to a
> regulator using the "cpu-supply" property.  This assumption turned out
> to be incorrect, causing the reported error message.
>
> This RFC patch series fixes this by adding the missing voltages.
>
> Note that the Energy Model calculates energy efficiency by dividing the
> (estimated) CPU power consumption by CPU core clock frequency.  When all
> voltages have the same value, the former is proportional to clock
> frequency, and energy efficiency becomes a constant.  Hence all
> operating points are considered to have the same efficiency, and the
> Energy Model always picks the one with the highest clock rate (see also
> [1]).
>
> Alternatively, the Energy Model could be changed to silently ignore OPP
> tables with missing frequencies.  IMHO this is not an unusual case.
>
> Which approach should be taken?
> Thanks for your comments!

Any comments from the Energy Model and PM people?
Thanks!

> [1] "PM: EM: Question Potential Issue with EM and OPP Table in cpufreq
>      ondemand Governor"
>     https://lore.kernel.org/all/a2ca883e-122e-43a1-b377-c43956b5b3be@arm.=
com
>
> Geert Uytterhoeven (2):
>   arm64: dts: renesas: r8a774c0: Re-add voltages to OPP table
>   arm64: dts: renesas: r8a77990: Re-add voltages to OPP table

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

