Return-Path: <linux-pm+bounces-28972-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36972ADEE2A
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 15:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 797471BC1444
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 13:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3762E9ECE;
	Wed, 18 Jun 2025 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xS6FK0x2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAA82E9EC6
	for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 13:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750254197; cv=none; b=CAG/QGvWduUvSVJCISZydkwXOlyKcvzXgmL+lxiVNFaBHwoHTWkAmwc10QBPcseiNdgmAwWCZlHG8AqM6ykUOVOaoQz3nb8EsQCS0idv2MWy1AKvWVIRcGnnurP9OadeLvdMlif/fipGyaMSZ13Z9iVyVKoeS1d1TmNRocX3Rbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750254197; c=relaxed/simple;
	bh=lHq8LwJCpZsYnYoF7lpMvKsBXva+7QpieDXG+mexd9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kcoUVSl2+V4agQ/WRCKIXsOog0oRgKM6/f2GVUd9xbW0Ex//Vo5EwbJm4e3u64QMXSxd83oc8fuONiJnUEchpjrmMvsmxkn1ODafHJvvKHdXdtCcYFhy3ih8iDEZJvKztA+mNLP7tVeDSuKt/l/qWLAP9V0SssWBsmC1aFC5oXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=xS6FK0x2; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-553bcf41440so4359978e87.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 06:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1750254194; x=1750858994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XesD6Pa6NIjfeeecwOLBDGIW61X59xU1PHMFDOzpvY=;
        b=xS6FK0x2ckjJRDCOfYEqAjbObtuf7BegqO73WTslIpKQ4g2eYqv8ZhDYliLd466ZSc
         o39UBW+sczuzV42sNtiXn7balALacAz9Lc5Eu2hSo7zDC90FVasK6S5Emck63GNORAai
         UBbAOV4jt+ZzGCgtYBRgEGrQNDgYkl97ipxpK9vss5Ky0IqWkt2IZ4wSqNpAkP3aXoD/
         /APpDjU43hxKKFb2Z7HTJDX13f3lqxOCUvQSmoZAFDWzMArLBxDAKbDR01tLJEgJmck0
         XLDZ+u5UtcsdQtVKXSwMbHjPr+Z3DCG4GJmobsJYd4TgEZSEKGsR+8FRpACsTIusO3c4
         cw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750254194; x=1750858994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9XesD6Pa6NIjfeeecwOLBDGIW61X59xU1PHMFDOzpvY=;
        b=UaHKNv5aOrZvqmR70NtzwCQR1gJZQKrM0W3+Bz+CrRCniTFl29rrewJ2BgJMa5i0YL
         uhX3syWwJahh0K1Wvh0+5qieRPla+35ANXTmxr+XxGdKmbjxOy7s2hN9l8E9q7riASIi
         Aq8IOvK/ekRRDZ88eoXStgvS4RN5axLEuc2RSXK43lGdBOfQtxg2/IgODV9DeYuY3xlW
         hb8eUwhzYdyYnl8snHBcZpQk1B0wt+VWJgoyu4UWyRL15lSrSoKWM3FyOk5Ga0lZnn30
         vN6tc2HpiTokKJoHOZ0gXrocXpa7/RzQncq3xsgX6rf4Sl0Qy+UcQ0ZDDWcid3dhvsVr
         RJIA==
X-Forwarded-Encrypted: i=1; AJvYcCW/RsrB/WehUTZFfqgGeAHGa2JTwrOQcCs35wqsTo5IjQIB1xoplr724Dig1Jdd8wt7MJNDXU3JRA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwoBjSAlCLumyZH0oUEVVbrGkVDEzXO+mjnC+t4d/1CyXIHdAC3
	UHvdauTpvYG48SP5Axm9bIlozEILIESwBGwcHauqPkE5zMq5MoL9v1C5HoMrJcBZPUygUxdg9lS
	GhQ9D8wC1X9zmp/VCNKS3pKtp5ACQW1IJnNxLWHDFaw==
X-Gm-Gg: ASbGncvfcalRuomQES5Wlmk/H58YO5Fvk+Hgx6CX+otsRFszICuNEFX5EPMnZTi6QDf
	3al0aG6Y2SUDcV55rbgi0LPyi9n1cJKJbpwMQTvzgpcJ7r2yIPmWv0+l0MteD94nBIZQekYpKNu
	Rzt0ZCdWDhcA80pXPziEsFZWbpjSZa+3D+Z3FfupBaOMTewic/oPRd7HIogxC6Tracyib9wj9tE
	Q==
X-Google-Smtp-Source: AGHT+IEECYD65Et/LmSBnvEiKApYIkAD1brUDvo7BBfhvnXlFl9/WYj3FARtHuaHKB5NARXPoTCzd7KIs42A0Z1Qt14=
X-Received: by 2002:a05:6512:2351:b0:553:24b7:2f61 with SMTP id
 2adb3069b0e04-553b6f5a056mr4801515e87.57.1750254193987; Wed, 18 Jun 2025
 06:43:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250618102231eucas1p1ec99058179825cb1250a1f189313b3eb@eucas1p1.samsung.com>
 <20250618-apr_14_for_sending-v5-0-27ed33ea5c6f@samsung.com> <20250618-apr_14_for_sending-v5-6-27ed33ea5c6f@samsung.com>
In-Reply-To: <20250618-apr_14_for_sending-v5-6-27ed33ea5c6f@samsung.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 18 Jun 2025 15:43:02 +0200
X-Gm-Features: AX0GCFv-psDNb6_Ffk6XjHdwrMsid_b9idm2knOXcGXYQtnqAYke8L-CxfsFZ0k
Message-ID: <CAMRc=MeiCT2f902h4viFbue1tejv7EGBvEjdQhOTuqDqEViwRg@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] riscv: dts: thead: th1520: Add GPU clkgen reset to
 AON node
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Binns <frank.binns@imgtec.com>, 
	Matt Coster <matt.coster@imgtec.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 12:22=E2=80=AFPM Michal Wilczynski
<m.wilczynski@samsung.com> wrote:
>
> Add the "gpu-clkgen" reset property to the AON device tree node. This
> allows the AON power domain driver to detect the capability to power
> sequence the GPU and spawn the necessary pwrseq-thead-gpu auxiliary
> driver for managing the GPU's complex power sequence.
>
> This commit also adds the prerequisite
> dt-bindings/reset/thead,th1520-reset.h include to make the
> TH1520_RESET_ID_GPU_CLKGEN available. This include was previously
> dropped during a conflict resolution [1].
>
> Link: https://lore.kernel.org/all/aAvfn2mq0Ksi8DF2@x1/ [1]
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  arch/riscv/boot/dts/thead/th1520.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/=
thead/th1520.dtsi
> index 1db0054c4e093400e9dbebcee5fcfa5b5cae6e32..f3f5db0201ab8c0306d4d6307=
2a1573431e51893 100644
> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> @@ -7,6 +7,7 @@
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/clock/thead,th1520-clk-ap.h>
>  #include <dt-bindings/power/thead,th1520-power.h>
> +#include <dt-bindings/reset/thead,th1520-reset.h>
>
>  / {
>         compatible =3D "thead,th1520";
> @@ -234,6 +235,8 @@ aon: aon {
>                 compatible =3D "thead,th1520-aon";
>                 mboxes =3D <&mbox_910t 1>;
>                 mbox-names =3D "aon";
> +               resets =3D <&rst TH1520_RESET_ID_GPU_CLKGEN>;
> +               reset-names =3D "gpu-clkgen";
>                 #power-domain-cells =3D <1>;
>         };
>
>
> --
> 2.34.1
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

