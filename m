Return-Path: <linux-pm+bounces-35557-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0EBBA9111
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 13:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 091303B1446
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 11:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E863019C7;
	Mon, 29 Sep 2025 11:38:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3367301714
	for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2025 11:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759145904; cv=none; b=a505rMgMjhsawMObqoFk675ckDvNsogxDaJbUFPZ+m12dn8WVH9fUC1drevbTbZ7AQFat9LcUHG1n7N6xcd9p8/QMJGSQbXsLkYHotgfpfv4t6HtXoiii0xQHL2snDqjRcTr1g4xvPqVGGdU0myLnyPT7DaxS/Rmnuk8gAcSxjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759145904; c=relaxed/simple;
	bh=rQxIntxCaMjAl4ZMKvmJmWmfz83LZmlH0mwttLjRCPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDwsh1+P4EEadInrISskK6Eb19rDFSlTcV2c67VsQiPQtp07A1cJs5M2dXiCQ3XJKUUC1PTp0BKC98AK6UxBoW3/5JVmvctmNsOLQqZQ2gOHudZHV59Do22TvwgC5vJbIdCOZfLMM8RyQynSPnUNyUcGJehTTmREQMJD3Wmfovk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-8d02f793882so2868576241.2
        for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2025 04:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759145902; x=1759750702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L+DvsJXG0G61gRFxkleWdib9RoQxt94Uw42byP7fd3k=;
        b=Kf+k5CQf6VZXsBjAhVtwqCl8ALtlUrPENHBVjmmTmKPxYuX8bOkooy0PResfj5+1PX
         +Mv0I722pRgcBurb2fnlc7zyAbPELaVVuGgegYyShrBnp3MIK5SaQ6+X8EFOwCdWWkxr
         zXbEzURpXM0MCkxi954VcLbcYIv+/u9gvCUU94iPhNT3rVyyGt+5myKXiO+xRGaX62Ta
         QcPjoIf0rcdl0LMEcxD/nKdLFk2tmWLHB91CBBmm6/F4li+hxT0/HL+VU4qLrtJ4UCWO
         rbgs9xhIxTJyS11SzkYFg0IJ0mc4OmKYAq8+zzhSlnUr3SxMd4L4zMHtRMH+RuPDjLZb
         oYOg==
X-Forwarded-Encrypted: i=1; AJvYcCXBkEEzZnI2R30wnQ9FfYazct01JXdKydINhbEy2q/IR/Z1CoWRe35sweBM3dCKkvkGFOAGhODL9A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy80Qt9LJHfIG01CJ6jMtsuHWdvFPMnZyKWriJhYUehZ/0WsjLU
	jPpnA7W9Ct6z9bqWtapH1447qHEb4ND8fFjat1MnWLwd0fvs/jfueRgTBHma2I59
X-Gm-Gg: ASbGnctZYA3lKQNeyeQgT9C1mz4EIU9rkK2EDHTspX/WoS1wQjhoHW1LC3/S6C4i/By
	hGMhGSwCwuh+fujYoP/rg6VZUw1ui4ucQ9QkKDscK2jHDXO4H8HJIRQzW3zbiuqSBhJO2Nv8FxZ
	wh7f+4svc9WhZnbWCslEQm4UCajEfr3PBFs4i0m/6TiB7E2k4lMr3wATrwnsHcskNDXoFP7yP9u
	wyr1hCwVfbmmcSNTSpm6q47TesGr5mF8ZS7cHxjDlRGTQrDNXhl5eKcuupWiABWAYN6VRvDBC+1
	oA11lGeUvl5boTc1lTYuyw43U5xEbs9LPok3ctpkVwFbyPyzQLuXV+sRvRS3TfYj0sFU5pVOq77
	NY/XT4T/gpwWy0LFWbpj8IS0rFq7rRDo/bbuLNLw7UVmYeQYi3wxn6LRfAkvSLBiqMKSr/KM=
X-Google-Smtp-Source: AGHT+IFHkyFVR+pMWshMRiJQGVpxH9UaGITBGbvPXvOMqDdBej4sTBODlUvCLkx+PvzIAORwm5ISjg==
X-Received: by 2002:a05:6102:94d:b0:51a:4916:c5f0 with SMTP id ada2fe7eead31-5c88e58e144mr1316954137.32.1759145901718;
        Mon, 29 Sep 2025 04:38:21 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-916d1518f84sm2397465241.6.2025.09.29.04.38.20
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 04:38:20 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-556f7e21432so3489331137.2
        for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2025 04:38:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW1J75zJ5NIfilbInsKCdQH7j2Y0lN9U8GLR1P4f8ed93j2+WW4ol4wOfvWx+OXOFg6JghbGzb6Gg==@vger.kernel.org
X-Received: by 2002:a05:6102:32cf:b0:519:f3b6:a1ae with SMTP id
 ada2fe7eead31-5acd10ea445mr6745656137.22.1759145900183; Mon, 29 Sep 2025
 04:38:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250810122125.792966-1-claudiu.beznea.uj@bp.renesas.com> <20250810122125.792966-5-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250810122125.792966-5-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Sep 2025 13:38:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXhgGGYAYnR1cgWVtFCdHEQZWmfx_KY3Z3keDHxTp_drA@mail.gmail.com>
X-Gm-Features: AS18NWDeDP8x0wSmUHzwgi3zdRuByvOv6E-OXpBdrFgnvBXmf6gvI4PDDQHxKx0
Message-ID: <CAMuHMdXhgGGYAYnR1cgWVtFCdHEQZWmfx_KY3Z3keDHxTp_drA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] arm64: defconfig: Enable RZ/G3S thermal
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, p.zabel@pengutronix.de, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	niklas.soderlund@ragnatech.se, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 10 Aug 2025 at 15:03, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Enable the CONFIG_RZG3S_THERMAL flag for the RZ/G3S SoC.
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks, will queue in renesas-devel for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

