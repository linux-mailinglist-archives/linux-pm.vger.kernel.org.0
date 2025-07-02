Return-Path: <linux-pm+bounces-29956-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A66EAF0C15
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 08:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6294D4A76EB
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 06:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7223E221F37;
	Wed,  2 Jul 2025 06:58:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEB01885B8;
	Wed,  2 Jul 2025 06:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751439515; cv=none; b=MNSt2v1xz5EIOsa2kNwvOpHjF8fLY1z0OMcTRnzO8sBdgXLxLpfOmFaR0O00xmYkjLevQi2mLslPG0L6QK5AIWNEFuT/WmRgy1E6WqerkcdB3a3aDTaB5jeN1Nmlp7kn0hl3Jgz+We4lkxChq64cxS6nTZRfDHBHhDTfdt1W+cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751439515; c=relaxed/simple;
	bh=6R4yyFMX/5iFCdLslkgrvlcRr+rsZA2fnb0Cwb1tTkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dryOQxUb1ksglk6veq/FOAKrHcfWlDDH1H6j5tk0QRT3AvhstxIOdAxylpmmi3WKHqiW4l6xmPyO2VJ1ElgNbf8uExOrZJrmpZGkW4Q+dohRdZciS0BqHeBqdKQIengCDDSfBspI40Y+jEwzlhH3hgfL6J1hd+c7rybbf9uwkBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4e9a109035bso2857105137.1;
        Tue, 01 Jul 2025 23:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751439510; x=1752044310;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DLsWLIJlGGWKZ0waZhVddmIAs54RW9FUXBL9VCP+TSg=;
        b=Gz8CsUHHslhPMadujR+C6CULGy4NeJ0K1XvmDJpPFMF/7EsR2kyIFIK+/YV9nH1rs9
         dsJfs2J8uU38V7QOdzkpx1Xx/w4kt35GeNI4JN3LeR8WJWfxu7jhDSaGrvcyFnVtc6qZ
         t5KTuOLPaN109KBj1sn10B2qVkHfmWPk9BLZvPC9cAIQXd7Suvd7sIGZA38MeOZ6RCIk
         5oka/YkEBGN6izAxvQjD4/7La/5tbj4K/8G9ofN6xlZhhQqdsPm2fbX/HiQYp+onKdR1
         nILfIMTfJbg62yrqZ6x9axhajS3+sD2KO0K+YlYwYpiaCuKhLmmoLfAxNXnLazBA9vfJ
         voGg==
X-Forwarded-Encrypted: i=1; AJvYcCUJDA/7VhJoVfsS+y64+/Cm0VpwTxUc+leS/INYeCgtcCqK2pWqtI643X6/IkO1GAnzkK9adzUpk925cIMqqQdxkww=@vger.kernel.org, AJvYcCUrNSrAocZumn18RiwfcWZSQ6Omcq2Y++x3UDHx+gP9292jYb3toWCnW2Q4wXyWwZTVxEiedfbF8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFGuf1CWXCl2OrXUHk/6LB14yHWZXv9vHHjfM98DGok7tGtm7b
	g6znu8iGUrV3eo00LM9FDTZ1ZeY9CPtIkkSp6KMqadGTwE7Xz9wnh0cbLQ7WAzTs
X-Gm-Gg: ASbGncvEvHcvDOzbfdBvAc8WwIFLLx+gkLyeW8bK0gSTGjPnRXuvAVL/oBxkZHINXro
	nbm6duybervWaun3G0QHjaA0kBo3WzJfsJ+mgnwWsVFoQXyIPpnhhX7dY6zmAQhGe5CiJQ3IhQ1
	S9Z7AlXs1qOdPXdDeICWtpPmRjCP2QDS2XlOa8d7B2wCe1HplVtCv9bKDVxXGVhnI2wBN1pENOv
	CV/1eaLrpKLUg2OG3ABf4fTF5GTMmgSm6X0NB/Ir9FGfbNBqdhNvomMgzJRHsQl4rk3JwSge+s1
	UXgBc9CLDKMQsqtaMp0FsWMaqz806bkC5W4TkhtORoWWRn6mhoE1fmKMPjR3TX158mxZSoxJh/S
	slFVwx0w6q1j6Z+pLXlMpHySQ
X-Google-Smtp-Source: AGHT+IFg4aoCYApiokQBLkUFKA6FdmorcRANagzX5cKM/UXRtjRpmAJzNoKXGgcdx7rnBTQg1oOzKQ==
X-Received: by 2002:a05:6102:3f0a:b0:4df:9e8b:8cad with SMTP id ada2fe7eead31-4f16143e23dmr740333137.22.1751439510483;
        Tue, 01 Jul 2025 23:58:30 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-884d1da07f0sm2383120241.24.2025.07.01.23.58.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 23:58:30 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4e7feaae0e1so2678638137.2;
        Tue, 01 Jul 2025 23:58:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU/w/TRv2DRYQV7yP2/UFh0ikIGSllqRKDVAJtrA6oazGtpIgI8fP9vkb2LqiYk+T+DER22/NDz1Q==@vger.kernel.org, AJvYcCU3bcB+S/v9i5dZp4Q7pofNMyrIpNTHyTLVSx0T982V0ftcBdRVHXd9x/nUk058N4E3T4k9PQ0tdvxmyVXPIir5OJQ=@vger.kernel.org
X-Received: by 2002:a05:6102:8087:b0:4e6:f7e9:c481 with SMTP id
 ada2fe7eead31-4f161108ae6mr746060137.7.1751439509960; Tue, 01 Jul 2025
 23:58:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <878qlagmrq.wl-kuninori.morimoto.gx@renesas.com>
 <CAMuHMdVqqCX1=2j740xnU6C=C8x=K-ayQ-uSbmafPVaa-nGtMA@mail.gmail.com> <87cyajzdij.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87cyajzdij.wl-kuninori.morimoto.gx@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 2 Jul 2025 08:58:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVwN9UBso4dx9hTwrBbf84JWkvHUJqg_ZR9aVp8zk=7rQ@mail.gmail.com>
X-Gm-Features: Ac12FXzD02bK9ILhQkP5B5oL9swxU-k_6WQ5SOxFCZgotheZg5EW2S2MoUBgNuQ
Message-ID: <CAMuHMdVwN9UBso4dx9hTwrBbf84JWkvHUJqg_ZR9aVp8zk=7rQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] pmdomain: renesas: sort Renesas Kconfig configs
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Morimoto-san,

On Wed, 2 Jul 2025 at 01:40, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> > > +# SoC Type
> >
> > "# Family"?
> (snip)
> > > -config SYSC_R8A779F0
> > > -       bool "System Controller support for R-Car S4-8" if COMPILE_TEST
> > > -       select SYSC_RCAR_GEN4
> > > +config SYSC_R8A7791
> > > +       bool "System Controller support for R8A7791 (R-Car M2-W/N)" if COMPILE_TEST
> >
> > "R8A7791/R8A7793"?
> (snip)
> > The rest LGTM, so
>
> Should I post v2 patch ? Or can you adjust/fixup when you applying ?

That is up to the PM Domain maintainer (Ulf).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

