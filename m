Return-Path: <linux-pm+bounces-28010-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4022ACC62F
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 14:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 955473A456F
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 12:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3448722B8CF;
	Tue,  3 Jun 2025 12:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QKjE60on"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB7522CBD9
	for <linux-pm@vger.kernel.org>; Tue,  3 Jun 2025 12:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748952594; cv=none; b=CoJ1+rm9hFS45x+96YVkblsfQeDIs2Kkhi3JVWHYVK172IPT9O9k1z9TyWRp06U3b7gQqiEJV1f2zRhbs27OJAjmce5KOWCe7lw1UYsq1YS6rgQK5PugorrhG5/7R2HWtazui2vsfa2sXcheIDT3GIsM90dPBirJYGMgEZTt6Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748952594; c=relaxed/simple;
	bh=YryBAYYqkusGLWOaZUx/ENPVrzfzihfvA3OAF4RkZyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DjPte7TvQc2wIXsS0ROu8iz7JYxBtoIIuDAywPYsXI71uOjMSE4O0nhanh3KxHVeyvqfj9gLBQu3xqTtXojJ7LztDaAvw5/5vYziWRVGOJqyJajQDvL7sahQEE06zcwYllR6kjvKPdbvmiMFAS9V9hOmGocheuQABem7ou41cjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QKjE60on; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-70df67e1b17so51582097b3.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Jun 2025 05:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748952591; x=1749557391; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wkgkfx1ZHJ5WRXN3wk71OJao3glFFdhvQiWlOBbCHtw=;
        b=QKjE60on8C0B1uf7Wkdr4vd3wZEUNW/3x685xZ2L1Ujg5MCiUKYJVHko1af2IRHuCw
         eiZlimKJqQe561ASjCIvjujo/a63N+xe4UPdANf0Mk+eP172bgz2yHZQ5ZKgItNkps0d
         8bjOdPteDQF4uyTGMcvppPAeOERxrH+gdS1gvmyPh9phN9LCKcbXM7dMEqGStpPMaWd6
         fPzTKrePbM7X2xzNuiOxKfGnErudddrnTJoRo6luOt5ona3WXNTPktOj4HgeFNRsCyB7
         vZCC9fQycUzJqkIMqqatqK6CtGCOD28cecO9XgWuaZypgtdmUSX+VMK9NHfOtxU0YoQU
         xr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748952591; x=1749557391;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wkgkfx1ZHJ5WRXN3wk71OJao3glFFdhvQiWlOBbCHtw=;
        b=lA5WAwXlNQ37pJTu9AduY1OHp7IW5DDVcHukxD3IobSADGvQ2MtW8yS1rDul9xjXry
         kQKN2ehRgtmci5aBMuSbblXKEMWvp9ciufjEyhAnj2gr28wwcX6bqNKNYAaDr3iWfWp4
         DzuS1yUWAPbejh/yoCAJm5CKqG2Ur/IDeuujU9Fil69BToJJrbGiqfUOHDo7GXOaJ7Tr
         y1F7bxI2LmNBr/qbEeukPOnb6ZBEtwxazKW/hZYScgLlYjutOKNmrEOTUcqNuGMmtsQ6
         x2nshPlHKRwJYwqlex+3x1j9OHzoNjImzuZUVxNNT1B12PLLSIj2V9vmftnwif4/W+5Z
         mkow==
X-Forwarded-Encrypted: i=1; AJvYcCU43MYUSeTz555CLK7P7UVLo29hj/edoEOJBuD9b9Vnc0Xxi+qOma3Em3DPgekZIw+uXK4cPkDXrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YywPwNWye1kaLSxhglCeIXxJUSFJBeNm2Ha8VqZoQns3KIPxNVF
	w1sIZ2CNM18YIFuY2NyHx4JN79BC9xfEHbl7JcfPAAj0GgbFM66+t7e07aAcRCFlQ+DZfkGFAvG
	jQeSL72W9RZ8qrxMX+smnG3day5BH/NAWgLwjyfsVwmtjIWS/Uk28OZ0=
X-Gm-Gg: ASbGnct/HmJyECCXNKZ+UxGH/n/67H2xl6qVnPGBwrNpjlb4Cqu08gErf9kz2dh+IvZ
	MtJ9aM/AssmtTBRkrF7VWJLR5LI5iPn6vxoJ1Lvs1vZUNwG8GCsXhH+jKX2PAXCoAPZtd3YiBEy
	D8OLD7SLYFJGmyGey6Js64F52kfQWomuER5GsSIYXDu40=
X-Google-Smtp-Source: AGHT+IEBu6kRLR+QihKU16+LErg47sPGw3yJ9MbHWp+STBlEAPmBRdPA2kKSotqf4d+nhihTdrEqxcQCav79Y/SEImk=
X-Received: by 2002:a05:690c:6888:b0:70e:923:2173 with SMTP id
 00721157ae682-71097c2a76fmr158597817b3.5.1748952591135; Tue, 03 Jun 2025
 05:09:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602131906.25751-1-hiagofranco@gmail.com>
In-Reply-To: <20250602131906.25751-1-hiagofranco@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 3 Jun 2025 14:09:14 +0200
X-Gm-Features: AX0GCFuMy0nMLljWiQ8PZlmv65MxrymGJ77Eb8A4CZbrmvODDSNF3Eq2H4oVdUw
Message-ID: <CAPDyKFrUAF5oWkyc3mLf0+R9VAypBotNyR4B5Chr3KQFYJOjbw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] remoteproc: imx_rproc: allow attaching to running
 core kicked by the bootloader
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>, linux-pm@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Hiago De Franco <hiago.franco@toradex.com>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Peng Fan <peng.fan@oss.nxp.com>, daniel.baluta@nxp.com, iuliana.prodan@oss.nxp.com, 
	"Rafael J . Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Jun 2025 at 15:19, Hiago De Franco <hiagofranco@gmail.com> wrote:
>
> From: Hiago De Franco <hiago.franco@toradex.com>
>
> This patch series depends on Ulf's patches that are currently under review,
> "pmdomain: Add generic ->sync_state() support to genpd" [1]. Without them,
> this series is not going to work.
>
> For the i.MX8X and i.MX8 family SoCs, currently when the remotecore is
> started by the bootloader and the M core and A core are in the same
> partition, the driver is not capable to detect the remote core and
> report the correct state of it.
>
> This patch series implement a new function, dev_pm_genpd_is_on(), which
> returns the power status of a given power domain (M core power domains
> IMX_SC_R_M4_0_PID0 and IMX_SC_R_M4_0_MU_1A in this case). If it is already
> powered on, the driver will attach to it.
>
> Finally, the imx_rproc_clk_enable() function was also changed to make it
> return before dev_clk_get() is called, as it currently generates an SCU
> fault reset if the remote core is already running and the kernel tries
> to enable the clock again. These changes are a follow up from a v1 sent
> to imx_rproc [2] and from a reported regression [3].
>
> [1] https://lore.kernel.org/all/20250523134025.75130-1-ulf.hansson@linaro.org/
> [2] https://lore.kernel.org/lkml/20250423155131.101473-1-hiagofranco@gmail.com/
> [3] https://lore.kernel.org/lkml/20250404141713.ac2ntcsjsf7epdfa@hiago-nb/
>
> v4:
> - dev_pm_genpd_is_on() introduced to drivers/pmdomain/core.c
> - imx_rproc.c updated to use the generic power domains instead of the
>   SCU API call, which depends on Ulf's patch series.
>
> v3:
> - https://lore.kernel.org/all/20250519171514.61974-1-hiagofranco@gmail.com/
>
> v2:
> - https://lore.kernel.org/lkml/20250507160056.11876-1-hiagofranco@gmail.com/
>
> v1:
> - https://lore.kernel.org/lkml/20250505154849.64889-1-hiagofranco@gmail.com/
>
> Hiago De Franco (3):
>   pmdomain: core: introduce dev_pm_genpd_is_on
>   remoteproc: imx_rproc: skip clock enable when M-core is managed by the
>     SCU
>   remoteproc: imx_rproc: detect and attach to pre-booted remote cores
>
>  drivers/pmdomain/core.c        | 27 +++++++++++++++++++++++++++
>  drivers/remoteproc/imx_rproc.c | 33 ++++++++++++++++++++++++++-------
>  include/linux/pm_domain.h      |  6 ++++++
>  3 files changed, 59 insertions(+), 7 deletions(-)
>

We are awaiting further feedback on the other series [1]. As you have
tested it, may I add your tested-by tag for it? Or perhaps if you can
send a reply to the cover-letter for it?

Anyway, for $subject series:
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

