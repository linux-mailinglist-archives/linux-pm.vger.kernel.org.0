Return-Path: <linux-pm+bounces-20235-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E93AEA09340
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 15:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDFD73A8986
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 14:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A51210F4D;
	Fri, 10 Jan 2025 14:17:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD8020E70F;
	Fri, 10 Jan 2025 14:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736518626; cv=none; b=ZKNlwk84js0E8X8oxwp28As7JS0DpKZ6WOYimFjRvkQylHU/nOVvaIg/bPYwSdXFtzPNOdfHQTXleG8aqPXmQVqD/ZKgK6mR0CHseCsJ75fK5g40cJSseAYSbhjmgnDI0KUSRS6bSqBv7iXfxxlX5hClOPF4SJqNd0+eI0xs+WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736518626; c=relaxed/simple;
	bh=G8V2jhFGtgWlOHG4Qtq684e7x4Mx+F2Tmo67ZfatLO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M96Y4aJuOad+E+NfAU6oLGXUiPHnSfCenSPmJyrSWI8wYl36Lk7GrZaPfeuMYFw2G9XtT5C4qJYpSp1oaE5QqwlnNxQgZCg1DaT6DV23ZpwU78QFpfYYASV95UQwxTxHhwlqCKawEOWqRUkTSg4Y0z1fz1TEL2B+QQQBsqp24yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b6e8fe401eso173287185a.2;
        Fri, 10 Jan 2025 06:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736518621; x=1737123421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/NJ/3l/9PI4oWXepQOlqsgt9YAjfDzU4Qje7tYA2ecQ=;
        b=LJGGfhdQg+PiH6gerAHVg+vUI4TnpZS+myULE177c+TMQ2JO1N1LJTffeyJg3nPyTE
         PKFTkDjKRKN/Mtd7GBIAjnM8DUTE864GLVkXSiHZMgXhDs0mDxx1HWdLUHrFL9LNgT2n
         YeSeQH/hmThMwXqCJo6NiUWoS+2w425+aVtIsd0QI+bzXkrxfl3NpIrdwY2ISuwZqJkK
         x5hN8IXE/WfPq+T/qCUtB6bbRYrX9NZwSXgUdROexbdxNVVU5B6W9IRNhjj6NDspshPy
         g5fL+R8HsmddauSH3hoBdUM7k5HmlcAcIc+aBZYoDSkLcomiuW73iN84maXZFm1uB422
         SUmA==
X-Forwarded-Encrypted: i=1; AJvYcCV9uXbY9ZGybeMRxIbwSRRZBsYEiddDhaKhwb7k1AcAxLOxCPpmN4ZanrXOQppkx0oCe1+5EK9JGxqq@vger.kernel.org, AJvYcCVetb7W3jsQ+6Ds7BgddVxv0jBs46Q1gwY+xSdaza2XUOzmwPX894TbgLCMJFplpJvTdmYqpWxyGKA=@vger.kernel.org, AJvYcCWoix0ULFuPxnCzkhTX6n3zZRYq5+Op8lEXcDek6wKHiwPvRDoHtJPLQ5CnmhbpeETYUc5gwwS1DZMNIIF6@vger.kernel.org, AJvYcCWwEJuUbxnVeeNzIM/myLHPcg1VrYGQPT9cNAhxd5C7sBK1k/oeVHZzMRTAeCg6UMPQ1w1y+6XkQphckcFbK8i/W+A=@vger.kernel.org, AJvYcCXeu7WEr4C/jMS9PfmOoQVkdN1Ke6HKcutD2ViW6STASFt8iuIBdCMuvKkhL3qOmTfhgXG05k5V80em@vger.kernel.org
X-Gm-Message-State: AOJu0YyCDxTn+2LzISzSnJ+el1zlF/mK2P5+X3Y0KbZmBfaccokB/ok+
	5INBkpRBRnKW8gSoytn1Pz+nToBbTaDUVCbLt7YRMKQWY/ZkB1EZOWe2uGat
X-Gm-Gg: ASbGncsh3FmpzQJC/3ZXZ2z2XoLS7LknJdKzooyrV1BFuYknvSmpgX1RIQ3RjXIcotZ
	XsKNiOFLvh2ch6YgH2moHIa/IygIaXs4eQ7V9XBxlycxOfkQQ8r/zC+/6eRkSb5jsVHlSkgOjlH
	esO7qUbbjglLP6y0eYldZrdy1wKDfKX+RSFE1Yp8ebujdlx+Hsrmg3hdruiHDc3hzr7cnKHC40G
	bx+D4D7k8EFZ/bmR5DdneW2d3HX24o4y99PA3kmdnL0g5Gfu0osXMFOIVlXQsVe5GuwdDHs48dc
	tO2rh8sOGTNE+yoW3ESU8FA=
X-Google-Smtp-Source: AGHT+IE5tNwrA25wnZ0jYbpj8xbYwxXFJ94FzLv+CS2Q+NK/ocjsTyOokiI6E0irfOtnsiOrnKXoMw==
X-Received: by 2002:a05:620a:1903:b0:7b6:c6f8:1d25 with SMTP id af79cd13be357-7bcd97ce10emr1767249385a.55.1736518621170;
        Fri, 10 Jan 2025 06:17:01 -0800 (PST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com. [209.85.222.175])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3503185sm175978785a.95.2025.01.10.06.16.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 06:17:00 -0800 (PST)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b6f19a6c04so176124085a.0;
        Fri, 10 Jan 2025 06:16:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVsG1B1D3oXkQbwcnU4kMo5FVthNQ8h3RAGrMFe6UpbcNjg8dTcc65LHOoGtmXySXUbHDfO5aOI8pY=@vger.kernel.org, AJvYcCWovhDXgMXmuREcSHqsTdqmfafqKnr45Z/v9syX4jH2+LYcRs12OI4OwBxcCgggfebcaTlG3KnRg+6Fgwoo@vger.kernel.org, AJvYcCWtYpVkRbeH98IluxRjzOkHjoiD1jKqdjxH3BdC/KCG93Q3xOypB/z34Yu8kLcaLfW3SluIxF/oJVyr@vger.kernel.org, AJvYcCWzCnTGjz726iQFoxViQ/3hfbXQj0M+mmqkdZb0qeqtb7bNmwrc5Ke828BV6oklfy1Cw9E0LAE6H+7n@vger.kernel.org, AJvYcCXn4cKnGIP4PHFvygK6ljQxaYUMoDiMeTJJ0qFWEs9lW5huo/z0sj58arXByQL4gnDQxdT3sTt1bPGoYsMy1e9Z8Gg=@vger.kernel.org
X-Received: by 2002:a05:620a:2a08:b0:7b7:5d6:3976 with SMTP id
 af79cd13be357-7bcd97d6489mr1484170685a.58.1736518619196; Fri, 10 Jan 2025
 06:16:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103163805.1775705-1-claudiu.beznea.uj@bp.renesas.com> <20250103163805.1775705-2-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250103163805.1775705-2-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 10 Jan 2025 15:16:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX1y7szsqRqE3iCGOV2gWX2Vq37KheZZbk+cEkwXgV6+Q@mail.gmail.com>
X-Gm-Features: AbW1kvbRaFn4g_AO_oKMfA_tFxNUhSMjIGVqHRYJogvxNkj5hs0eIT7UrCBBWSw
Message-ID: <CAMuHMdX1y7szsqRqE3iCGOV2gWX2Vq37KheZZbk+cEkwXgV6+Q@mail.gmail.com>
Subject: Re: [PATCH 1/6] clk: renesas: r9a08g045: Add clocks, resets and power
 domain support for the TSU IP
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org, 
	p.zabel@pengutronix.de, ulf.hansson@linaro.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 5:38=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add clocks, resets and power domains for the TSU IP available on the
> Renesas RZ/G3S SoC.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk for v6.15.

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

