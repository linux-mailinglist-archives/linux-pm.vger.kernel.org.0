Return-Path: <linux-pm+bounces-40780-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA011D1C8F7
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 06:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61DD630382BC
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 05:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5D236BCC4;
	Wed, 14 Jan 2026 05:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AGWShI5u"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F21C29DB99
	for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 05:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768367785; cv=none; b=WEaQda/nsC4w4ZMcaJcNSWiy++NU431GwhDcEd+8P0PQZwejDiM1V49DZp33TnGHycdf9rGd4Zjm7uF23wDJKs1N/jaItwKKu4OZDo8TlkKCL1JeA/bNZrPLKoAKetMuA2vI9Td/AAnn+rLu0+G8ZifF2dviBCtkjZDBEfhL4nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768367785; c=relaxed/simple;
	bh=iP3S/72fuu/L/exhomw5MypN4Y5Gkqbqe4ilsP/Xh9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QU8uMGoLGnEMm9DeBPnlI1dR/hCzKL6P0D56oxBftFhvLa383+UYDEPBRCkzwDmHX1B3MphBisGHdPi9daCXbF1ZlCul51lUXyXAVrf5VahTa+uL+0Q73gF055lnj17/2YhYBbyntnPTU+Abiv+CmAD9v4w1FOCZZjSv+4EjR0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AGWShI5u; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5013d163e2fso15759921cf.0
        for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 21:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1768367777; x=1768972577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezdkIkld7c/oSBzC35T3zK1WNNmb2BZY9Vgt94zhRnA=;
        b=AGWShI5ukz+MKdxNPLtOwZgyJQTNeY3ny9fKjHl4pdQS6gzBWt1huFwktcRHURgNhV
         eYVcotE8UWAkunY+H9oHpf4+cJfgd7Kfgx/WrWRokfnxhvtVnzC5/U3pbMqWw+XKRBbr
         x1lNlYXNDKPnmMn/h9tHqc0VCWeMHrxqrAT5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768367777; x=1768972577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ezdkIkld7c/oSBzC35T3zK1WNNmb2BZY9Vgt94zhRnA=;
        b=gVUilnFT9nNEqldcUk2XlJv+56zg43VSJU5I3fZCxNAaqZXzNw3wEmrAZUKl0Cv64U
         gpM6LJcu9I9I5V6QdBgg/c3R9H+89c1hBwU+lJg7hk7LM+o1QUR3/j+zcy9CRjXfSCFN
         GcM5k69FbNCUvulv1M95MDNjGyakN35to5gi8/H8jpYaD2QvFOnVa4ohnczA8d2i3ulO
         GeHn0pxmUYv8nn/xZO1nd0V751mtdyhK6KUA+8d6VboSroMM/SarsLB4Y+zWBzckfg5z
         jlBG4G3wPis9p1U/9XpovLuK25ppp71E7BNeP0DTf+mxxn10DhGYUbpoZk0a4tlYus3a
         jEWw==
X-Forwarded-Encrypted: i=1; AJvYcCUQOvqnofQJarMkqtgi+XGRO5I8Rx+7uin4h0GlUm2gkAU83H2p5R/0Gvs9ePB2sQNlt+n4xnnVrg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyWjJPHzJg1Koc5pHiWAqXMn4+Tx3hA6mCfC984n+X4MpxRF17
	UVOdqsiAj3L/PNqFVAbe0FFQw5FqsXWCli+C8ppCzAhxOkeEUA3Y0uYfeTRW/TOepDwTqDwpuoE
	sieryqg==
X-Gm-Gg: AY/fxX4zeDdJSTM+NqFVO+vzdiufpC2KJNvV/VZTthfqOfK6WSPMdKMqi+wn0cFhItx
	+syjSNaLgQ2p1h6LMl42WUpFsI5iXFhFbTb/m0EjGeCnQoVvaGLP8tfuxx/B+Ntex9PXpky7Hlx
	yJgbWTfRnacbhyCuIom4vMXImO5mYQB62f+DT6knzG1Ma0cvNcim0erpbqgDSo2oodPXt5r+G4A
	2dymvEiR+jW2rV4ClwPywQTwV1K1y9VWrxO2SUlxiHg7rH/C3SON8nOZ47ZT7wzX3IqUuRjz9hk
	KIaNlMjz7TqksiJY1BBnxW94HyNS6Qx6pngrwUAi4ktZ46KJfiOed6q5TS1hXrp1qjTEL8OydhY
	4Fc39GiPclAZ5w6dcHwN/rIMUoZnIj8E3qBDVv2SASj48OK0YmgFMKej8mmqapsFsuih790Gd74
	Kdr1Ro5EC9eXHdgnkbkJuYih5YiU7Rwas/wol7Z8g5LjYZeEkQfw==
X-Received: by 2002:a05:622a:5585:b0:4ff:cadf:310c with SMTP id d75a77b69052e-5014822e1b5mr22250071cf.36.1768367776988;
        Tue, 13 Jan 2026 21:16:16 -0800 (PST)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50148eba456sm7468371cf.20.2026.01.13.21.16.15
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 21:16:15 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ffbaaafac4so269051cf.0
        for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 21:16:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUGBZ34eAr2JtPq+lZR3siCpYxMeDNHvxUEXuCVK/IHjLlC00ICWbv2UvEYnoXpxjrJBbg5J42IRQ==@vger.kernel.org
X-Received: by 2002:ac8:5e48:0:b0:4f1:a61a:1e8 with SMTP id
 d75a77b69052e-5014825a304mr6273611cf.10.1768367775388; Tue, 13 Jan 2026
 21:16:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d4690be7-9b81-498e-868b-fb4f1d558e08@oracle.com>
 <39c7d882-6711-4178-bce6-c1e4fc909b84@arm.com> <005401dc64a4$75f1d770$61d58650$@telus.net>
 <b36a7037-ca96-49ec-9b39-6e9808d6718c@oracle.com> <6347bf83-545b-4e85-a5af-1d0c7ea24844@arm.com>
 <e1572bc2-08e7-4669-a943-005da4d59775@oracle.com> <CAJZ5v0ja21yONr-F8sfzzV-E4CQ=0NqLPmOeaSiepjS4mKEhog@mail.gmail.com>
 <CAJZ5v0hgFeeXw6UM67Ty9w9HHQYTydFxqEr-j+wHz4B7w-aB1Q@mail.gmail.com>
 <rsqh4kpcyodnmcxcdd3yvysdmnfj34fgjtr4pmfhlg2cqtvlhh@iakffruxcnac> <ndqg2mysdc4bsvokmrqubx6rw3oj3lrflxw3naqiohbg7yablf@ccm3rl36dnai>
In-Reply-To: <ndqg2mysdc4bsvokmrqubx6rw3oj3lrflxw3naqiohbg7yablf@ccm3rl36dnai>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 14 Jan 2026 14:15:58 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DBsd4tMcRuVwD3=csJ=4=DMcJhzah+-CTq31qOZHyJEg@mail.gmail.com>
X-Gm-Features: AZwV_QgaEM5U0dghv7arOEC9sAg-1oiklciKgVxEPDm8-o619IU-2A6jT2MKyE8
Message-ID: <CAAFQd5DBsd4tMcRuVwD3=csJ=4=DMcJhzah+-CTq31qOZHyJEg@mail.gmail.com>
Subject: Re: Performance regressions introduced via Revert "cpuidle: menu:
 Avoid discarding useful information" on 5.15 LTS
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Harshvardhan Jha <harshvardhan.j.jha@oracle.com>, 
	Christian Loehle <christian.loehle@arm.com>, Doug Smythies <dsmythies@telus.net>, 
	Sasha Levin <sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, 
	stable@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, Jan 14, 2026 at 1:49=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Cc-ing Tomasz
>
> On (26/01/14 13:28), Sergey Senozhatsky wrote:
> > Hi,
> >
> > On (26/01/13 15:18), Rafael J. Wysocki wrote:
> > [..]
> > > > > Bumping this as I discovered this issue on 6.12 stable branch als=
o. The
> > > > > reapplication seems inevitable. I shall get back to you with thes=
e
> > > > > details also.
> > > >
> > > > Yes, please, because I have another reason to restore the reverted =
commit.

Is the performance difference the reporter observed an actual
regression, or is it just a return to the level before the
optimization was merged into stable branches? If the latter, shouldn't
avoiding regressions be a priority over further optimizing for other
users?

If there is a really strong desire to reland this optimization, could
it at least be applied selectively to the CPUs that it's known to
help, or alternatively, made configurable?

Best,
Tomasz

> > >
> > > Sergey, did you see a performance regression from 85975daeaa4d
> > > ("cpuidle: menu: Avoid discarding useful information") on any
> > > platforms other than the Jasper Lake it was reported for?
> >
> > Let me try to dig it up.  I think I saw regressions on a number of
> > devices:
> >
> > ---
> > cpu family      : 6
> > model           : 122
> > model name      : Intel(R) Pentium(R) Silver N5000 CPU @ 1.10GHz
> > ---
> > cpu family      : 6
> > model           : 122
> > model name      : Intel(R) Celeron(R) N4100 CPU @ 1.10GHz
> > ---
> > cpu family      : 6
> > model           : 156
> > model name      : Intel(R) Celeron(R) N4500 @ 1.10GHz
> > ---
> > cpu family      : 6
> > model           : 156
> > model name      : Intel(R) Celeron(R) N4500 @ 1.10GHz
> > ---
> > cpu family      : 6
> > model           : 156
> > model name      : Intel(R) Pentium(R) Silver N6000 @ 1.10GHz
> >
> >
> > I guess family 6/model 122 is not Jasper Lake?
> >
> > I also saw some where the patch in question seemed to improve the
> > metrics, but regressions are more important, so the revert simply
> > put all of the boards back to the previous state.

