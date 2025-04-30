Return-Path: <linux-pm+bounces-26468-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEB8AA4FE9
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 17:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8E7F17DDCD
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 15:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F601BD9F0;
	Wed, 30 Apr 2025 15:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oOz8cEQI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D842190676
	for <linux-pm@vger.kernel.org>; Wed, 30 Apr 2025 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746025944; cv=none; b=jjiLtKFK+1e0CA6HCvv9JNHAdBBXvBowzhhopXiZQ96kkmlRKClan9EQdeBEt1umyLyCqvB/jDK4mHEOHVW+BUD71UYXvOF7WY87cFhnaTvO1k4HM76HfEBmLXFho2Vaz7kH5nccYvlstPzuPJj8gyCoFYsVmHENvIB7cltp7YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746025944; c=relaxed/simple;
	bh=bNDg6tImETM652KVmW/CB1ckF9nf7Tknc4jYjz+M95Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AsGqxvaPhh6gk8yGt15+CJbJF6+nKG0vE/UMuzMVGuiGvQJSo1dTj6xqfN/YYYCurpXzv478WkAdK8ZdvnD8L+/5ioQ2vW/80XadXfEdB6T3MiIM2wV/L2qbW1hF4daUr7y2oBzaG3lBTRzR8m4qFfEGDPr1RKTDWHYOmMWADk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oOz8cEQI; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c07cd527e4so798808285a.3
        for <linux-pm@vger.kernel.org>; Wed, 30 Apr 2025 08:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746025940; x=1746630740; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TC6Uw6VHl8li0pKtOZq0F1Vqk2LcExMB5Btz+dNIGMU=;
        b=oOz8cEQIH6iKK6nolZKY/KtPFXo0FL37eW++e5LJHRznH1fdFxX5l+1E8Azu2VKuKD
         1G46x0KNwUAKTkWdo328x0b3hCtqLVZrzkxRY4r5FOj+OFwEANNIXPEVTgTBglIfItGm
         f1lALsIzPKK5rfV4/33HJUfdToBP00loZYXkRCiErAg6o/5fL8047fYFgw0J1lO/Psx3
         AA/OOy0QWUzRL3ovjL13LeBTHZBJOu1zoTenvcw8ejwo8PRCjP3CuvQIOzBcHYgJHFkm
         oat77VOmxhL8UtjafCUaFJrlJq52WbQv/SzkCW1pOVRoHmVG7QfDvPiuxyWLz030gxTU
         exlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746025940; x=1746630740;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TC6Uw6VHl8li0pKtOZq0F1Vqk2LcExMB5Btz+dNIGMU=;
        b=nsQsrUmcA+vMHciLRt8NoLgy0ppwX4CvAXMKh+nGKc36+w6Uydy+5Lno6rWTAAw/d2
         dzJC2+4LkpuQ9MyNNAYrUV9MO1hlze90XkxNUnUiE1R5iO9+9xOEe78uATxLv/WOO2fF
         zRooXYwtzplPsGYRSEvrBegqqA3FwZM6FlfkUD9zpjCuG/VcCWgw+JgaFbC56B6pfjXt
         TaDftdbPMYefCiRCMohj0jrtoQY4sj/+NvW2MiEc+cJf9R8QrJkMmd9aPIf3gc7E+HMF
         HFa9XkPAPKoRlCEe4Znn2ODBPFzIs75Ic3GeBEw22HC0m2ST9/bcpSUCRYHeBRfG5yCe
         P2rQ==
X-Forwarded-Encrypted: i=1; AJvYcCUipgNIyOPHoKcO6Ro8fwlKP7SbHDAAyxH/m2P5pZSjIEzAoJhsXQFBwE4VW+uU6GOt4nHYoLvw+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaqrQuasCBRyE+wCkjYXcDNnkFWW7gkWl9PQlVOiepgHhOn5Ww
	QfoYB6Ss/GyNzj20TxnMTf3MyCB7KIzNPmCQEe3FTK2BcdRURzsxhYbjRllR5Qo=
X-Gm-Gg: ASbGncucsy5zHHonIseWCDR3PgEJTGJ6TTYbTl8AvNY6hXJrdO1SGDg3+E5IUruJ7Xv
	b+QTee3b74Ly6IenAMDgKkL0FEybaeG43xKhy+cJy7B/wnGn9YcjNgEXl/5v3CkBoLpVSZrl0vB
	XK+fg1W0XfgGq9cVGhG22/ghjw8v1AckjKKEFFe0Oifo3OejzSlPqYM8HuoQnQYpq8qBtl4tmLe
	ZkGYBLO4st5Sn+jlXoV8fUMI8D7HETHx6UuULRxBFJkTZ3/KArXTU1GM76Oj2+mr9FRzULCg2P0
	M1HzEckfSV+EMl/2psQ7KkTY8fFGT5DCB/rapq0iVxyINiT7Ya9PW9TDi4N/QHpc1TRjmbfNUrh
	Gy+k85cgJcHBx2Q==
X-Google-Smtp-Source: AGHT+IHejdBgJxFkwA7njESQOPqDseqqXtDwdi5F8ZnCuvJTa7m8szFKeMzP1F7/ak0b3riGu2KuKQ==
X-Received: by 2002:a05:620a:4555:b0:7c5:55c0:db9b with SMTP id af79cd13be357-7cac76a2dcdmr485037085a.58.1746025939914;
        Wed, 30 Apr 2025 08:12:19 -0700 (PDT)
Received: from xanadu (modemcable179.17-162-184.mc.videotron.ca. [184.162.17.179])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958d86d65sm868396085a.86.2025.04.30.08.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 08:12:19 -0700 (PDT)
Date: Wed, 30 Apr 2025 11:12:18 -0400 (EDT)
From: Nicolas Pitre <npitre@baylibre.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
cc: Matthias Brugger <matthias.bgg@gmail.com>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
    linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dts: arm64: mediatek: mt8188: add more thermal trip
 points
In-Reply-To: <2ddff946-9c4c-4fb5-a8e7-b2fc413ae281@collabora.com>
Message-ID: <s8o2npos-6059-3o54-5o31-0488rrqs50s2@onlyvoer.pbz>
References: <s2sp5o57-o534-qso0-2733-o0prs6028por@onlyvoer.pbz> <dcc62684-0579-4d03-a430-d4a276153ca1@collabora.com> <85710oso-p1pp-647q-498p-23583s7nnn45@onlyvoer.pbz> <2ddff946-9c4c-4fb5-a8e7-b2fc413ae281@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463781375-367166324-1746025939=:1712"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463781375-367166324-1746025939=:1712
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 23 Apr 2025, AngeloGioacchino Del Regno wrote:

> Il 13/03/25 19:30, Nicolas Pitre ha scritto:
> > On Thu, 13 Mar 2025, AngeloGioacchino Del Regno wrote:
> > 
> >> Il 13/03/25 16:43, Nicolas Pitre ha scritto:
> >>> Provide the "switch on" thermal trip point to be used by the power
> >>> allocator governor.
> >>>
> >>
> >> As far as I know, the power allocation is not supposed to be
> >> SoC-global, as that does play with sustainable power values...
> >>
> >> Sustainable power depends on multiple factors - besides the power that
> >> is actually sustainable by intrinsic properties of the silicon, this
> >> mostly depends on the PCB that it is soldered to.
> >>
> >> Translated, this depends on the heat capacity of the copper layer(s)
> >> and of the eventual additional passive heatsink, which is a physical
> >> property relative to a board and not to the SoC by itself.
> >>
> >> ....which means.... that those nodes shall go to board specific devicetrees
> >> and
> >> not to the SoC devicetree :-)
> >>
> >> Unless I'm wrong - but if I am, please explain why :-)
> > 
> > I agree with everything you wrote above.
> > 
> > But this patch isn't about power allocation. This is about temperature
> > thresholds. And temperature tolerance is rather SOC specific, no?
> > 
> > 
> 
> Sorry for letting this slip through the cracks - that wasn't intentional.
> 
> Agreed that temperature tolerance is SoC specific, but that's taken care of
> with
> the other trip points, so that's not a concern here.
> 
> On the other hand, it's guaranteed that the SoC can "keep crunching numbers"
> at
> full power when the CPUs are at 68-70°C without entering any actual danger
> zone,
> temperature-speaking.
> 
> Remember that a machine may be designed to keep it at even 70°C for a
> prolonged
> amount of time - depending on the cooling solution.
> 
> If you're doing this for a specific board, I'm happy to accept the addition to
> the specific board (file) that you're doing this for.

Please ignore this patch. This is superseded by the patch posted here:
https://lore.kernel.org/linux-pm/prp38558-r53s-756p-o6n8-795o7q87sssr@onlyvoer.pbz/T/#u
---1463781375-367166324-1746025939=:1712--

