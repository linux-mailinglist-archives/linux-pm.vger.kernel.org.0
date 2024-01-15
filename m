Return-Path: <linux-pm+bounces-2189-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA7082D5EE
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jan 2024 10:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6209282C03
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jan 2024 09:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BF8EAF8;
	Mon, 15 Jan 2024 09:28:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013C1EAD1;
	Mon, 15 Jan 2024 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5fa52e173f7so51302737b3.3;
        Mon, 15 Jan 2024 01:28:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705310884; x=1705915684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqlO20vL7TNKjRLp8iivk1MVILmtsEuTqgkIeOZu3lk=;
        b=RI9cm3UrnWEydaXH6VUOL2AHRmaBkp4Jo/t4WcT5ctQA/DOsgjsd0l81t7yp1HvMbk
         L/Z2HDqOFiJqCII5V0z3XfVYvTMtOYG5gz/45BqrthTMd8ojoTjEllUdhSA9wu7N8kxN
         /qC1q0YbZr5pwbdXAnxZwd1Al7EabzsI9BtpK3CkOwd+N41IL0GZ4cfwebWMyrdYV1f5
         GDr8a3TLA+XxvDvCCxspB372ppHnLvQLkviIePPcdWfxRMTSVxfTWwsbXQKnVAYBFcNO
         cvn965XQ64Nbi4OYTIbj12pQ2vh+88l9uTLL8/9JExLjBOzsVXLDz+n/aOyCE4I2ziyu
         6M9Q==
X-Gm-Message-State: AOJu0YxO9ggrUavZtMHtU3jz+pPuauk4oDBgwOYwuVSdTVq5wkja4O1w
	Fkf20S0RMURXkYp0OM/jUPf4Z+//NvIg0Q==
X-Google-Smtp-Source: AGHT+IHMmD6SpJDKvdr3Bjm1O3GOgrEBUqC4FCfBlIPabJGGBXwNMoCHwaF33tAwgMEP+HRtUJFuBg==
X-Received: by 2002:a0d:eb41:0:b0:5d7:1941:2c3c with SMTP id u62-20020a0deb41000000b005d719412c3cmr3135593ywe.105.1705310883690;
        Mon, 15 Jan 2024 01:28:03 -0800 (PST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id w16-20020a81a210000000b005e5e15f07dfsm3770331ywg.51.2024.01.15.01.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 01:28:03 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5e7409797a1so80747157b3.0;
        Mon, 15 Jan 2024 01:28:03 -0800 (PST)
X-Received: by 2002:a81:af63:0:b0:5ec:91e:9d68 with SMTP id
 x35-20020a81af63000000b005ec091e9d68mr3225085ywj.18.1705310883351; Mon, 15
 Jan 2024 01:28:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704726960.git.geert+renesas@glider.be> <2e083461752c9d52fdb251ad9071f6111f13c3c5.1704726960.git.geert+renesas@glider.be>
 <ca0cb671-43ce-4bda-aad5-da38bace4132@linaro.org>
In-Reply-To: <ca0cb671-43ce-4bda-aad5-da38bace4132@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Jan 2024 10:27:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUJYH7YhQ65Bh1K8F2earTM60VwBd2=LH2vnGbaGPU53w@mail.gmail.com>
Message-ID: <CAMuHMdUJYH7YhQ65Bh1K8F2earTM60VwBd2=LH2vnGbaGPU53w@mail.gmail.com>
Subject: Re: [PATCH 02/15] dt-bindings: clock: Add R8A779H0 V4M CPG Core Clock Definitions
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Magnus Damm <magnus.damm@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Cong Dang <cong.dang.xn@renesas.com>, 
	Duy Nguyen <duy.nguyen.rh@renesas.com>, Hai Pham <hai.pham.ud@renesas.com>, 
	Linh Phung <linh.phung.jy@renesas.com>, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Tue, Jan 9, 2024 at 8:21=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 08/01/2024 16:33, Geert Uytterhoeven wrote:
> > From: Duy Nguyen <duy.nguyen.rh@renesas.com>
> >
> > Add all Clock Pulse Generator Core Clock Outputs for the Renesas R-Car
> > V4M (R8A779H0) SoC.
> >
> > Signed-off-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
> > Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Changes compared to the BSP:
> >   - Drop POST* clocks, as they are internal clocks.
> > ---
> >  include/dt-bindings/clock/r8a779h0-cpg-mssr.h | 96 +++++++++++++++++++
>
> Mediatek was able to switch to vendor,device naming scheme, so Renesas
> should follow as well.

For new bindings, or also for existing ones?
Doing the former means there are inconsistencies among different SoCs
in the same family.
Doing the latter requires keeping the existing header files as wrappers
including the new header files, because the binding definitions are
part of the stable DT API.

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

