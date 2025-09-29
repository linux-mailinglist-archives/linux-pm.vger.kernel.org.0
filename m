Return-Path: <linux-pm+bounces-35554-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07288BA908A
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 13:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB5C73A2BB5
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 11:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1090D3002A2;
	Mon, 29 Sep 2025 11:35:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835D13002A1
	for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2025 11:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759145707; cv=none; b=cAb9LY8XtiLcv/RfuO19LbaQuC/3mZE19iwMGdyWU+n0GMqyQvWc+eSjP/mZMNB7wEizAKPCCW8raUg9BGYx+FrLKYjcI8QS6g1jHI80zbfaCGuoLZUnhaHMVFgCFRlSaGVk0OICdZXtmrPIZgCXCC7MxUkQzyvuwxHjILO+Nbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759145707; c=relaxed/simple;
	bh=ch7c0GMzEBmON//ATPEGlDV9ckg4jFVTkG+ER5Pa/oU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DU8NIHC9q0kxkiZTd0Iy3/4KyPl7gqTeO38KXyoh9ztwvpYwouX/0y9kwbDKukg3eidTez2Q25stSzLnjXL8Aj7EPwuK4G+VpXcm3nZBwliJ6+PTKwho4tcsqL1F3HlwrSDisfXO15f581qVcPgBKhQVS0Ag3++e9xx2/jFK0F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-890190a3579so772133241.2
        for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2025 04:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759145704; x=1759750504;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zscJNsz9LWE1JCbi4f4RqWFcZGer3C+FRtSw/qqEOSE=;
        b=vqzcJ7lIXLCFaXkPhZqzC1psuyOtuu+IGR5WLYzJxTU1SD9HBcogrONYYIIa4EKDaP
         PPvhjmp0svSVfO7IFUsodQlCRJL7gjc9UyTPKHMI4VQwUmq51RcQ5UMFMHUzHB4wvg0Z
         Nhzv/EzmYh2wofGf0mKZFVOoZmjkOvsA/R23/3bnpNgHIegdYEV+EBTuZpOrkp3d4Vxx
         5htPfaOUA66cucuqnCJm0TlZePJne5b3h09Bbsjqi9jOu1JyFeE4zT2MqEIH+sxZmpXY
         kKmECRHbQcemJWVbw+f5ck0ViVD2HvN0q3IGOhXBh2eWO7MJsqYsYSgxna63rtS4/6r5
         Hwfg==
X-Forwarded-Encrypted: i=1; AJvYcCUaNP4w9tpC3ZglCpvLtOg0V+TdxqM8JvNdzDn10VTcRXt4Cwyg/CIg4U8T+4II9R9qsw84GgKn8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbJwdhm3qslAegDmeabVqPeE3DwM6qothiSLYSFkY8Jsb3Nc3U
	CPpV4xTbPB102Qa/dmQFtgovOtQoihP7EWYVuaKEqU0OIBDCf7R4ECncJ3hbyNZq
X-Gm-Gg: ASbGncvWrv7xtr3q+a4BKsnY+uY4CXvQAmpAcRmiAZ07ZShR2h9ziy96awkKVcjFkc1
	h4LdXG1accxW76pKOgqxambuFTLL7s9la1ncHSgf+F9+oQLPvPn2LJUf7QKJ33UOCCZzRpbkDFc
	D6O/JELRes33DOMnVmm1S8s6Ae64glb5rWXqkvuCLYot+6qlxnKGzJA3W6fVMkB5rauGXi/cIhR
	ZswksXzNWhRmppmAu/N6ITPamrL2O+ilhRnnWTM/eLaAeYQQCepdkVk/1rT7day67LmG1NJZL3T
	FaHSnykD7SdrHT0xrDlEqJFLtRda0F1MPIFLRYKeNcNdPJt8HWtEl0Db3B9aPwBO4lnA96V9tma
	UJe1WpH61xts3kZw7sWFh7b5zI+pUS8sbQRWsmPRDGk8/kCbQ0NqVwaYO2kEpJ4PdvbZ1Woc=
X-Google-Smtp-Source: AGHT+IFR/rNAREtwmYQRJUhvX/6beZEwlKIU2kl66zESh8IbpW9g3WrY/fDBHqbfEjKldkkOMKOoDg==
X-Received: by 2002:a05:6102:316f:b0:5c8:c906:68d6 with SMTP id ada2fe7eead31-5c8c9067376mr733681137.25.1759145704440;
        Mon, 29 Sep 2025 04:35:04 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-916db3be313sm2329420241.20.2025.09.29.04.35.04
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 04:35:04 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-905b08b09f5so1181352241.3
        for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2025 04:35:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVrB+MdCKBSuglleS7ZRIEuXzRnMrOimYe7U6GWQgQHow1WkgbpSYkgK0T1sneZzLykLv1HNaHkXA==@vger.kernel.org
X-Received: by 2002:a05:6102:292c:b0:5a1:ea0:f56d with SMTP id
 ada2fe7eead31-5acd0efb09dmr5673188137.32.1759145704110; Mon, 29 Sep 2025
 04:35:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917170202.197929-1-john.madieu.xa@bp.renesas.com>
 <20250917170202.197929-4-john.madieu.xa@bp.renesas.com> <CAMuHMdUw+cVtMkfnWjuO6BUNPRd=gZHhiD=KqPxugrJVLOe+Wg@mail.gmail.com>
In-Reply-To: <CAMuHMdUw+cVtMkfnWjuO6BUNPRd=gZHhiD=KqPxugrJVLOe+Wg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Sep 2025 13:34:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVazggwwtD2pvtzwTwX5XWf=UWsuezTU4vJnU5gtT09yQ@mail.gmail.com>
X-Gm-Features: AS18NWCxvZMcs4IKeRIKmjN1qwZhpwGWh6ZDTAZia6k6h8LSwaxFUr6lA65qWRI
Message-ID: <CAMuHMdVazggwwtD2pvtzwTwX5XWf=UWsuezTU4vJnU5gtT09yQ@mail.gmail.com>
Subject: Re: [PATCH v9 3/4] arm64: dts: renesas: r9a09g047: Add TSU node
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: conor+dt@kernel.org, daniel.lezcano@linaro.org, krzk+dt@kernel.org, 
	lukasz.luba@arm.com, magnus.damm@gmail.com, mturquette@baylibre.com, 
	robh@kernel.org, rui.zhang@intel.com, sboyd@kernel.org, will@kernel.org, 
	biju.das.jz@bp.renesas.com, catalin.marinas@arm.com, 
	devicetree@vger.kernel.org, john.madieu@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	p.zabel@pengutronix.de, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Sept 2025 at 16:07, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, 17 Sept 2025 at 19:03, John Madieu
> <john.madieu.xa@bp.renesas.com> wrote:
> > Add TSU node along with thermal zones and keep it enabled in the SoC DTSI.
> >
> > Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
>
> LGTM, so
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, will queue in renesas-devel for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

