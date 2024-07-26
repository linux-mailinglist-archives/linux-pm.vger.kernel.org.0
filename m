Return-Path: <linux-pm+bounces-11440-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B336593D863
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 20:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74634283A15
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 18:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41773F9F9;
	Fri, 26 Jul 2024 18:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eGDMozfY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A775118AEA
	for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2024 18:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722018728; cv=none; b=mbdocQMqvNPHsfm11VlsCcqQWfg/L3/sdQenU8j0oHs/m/NgCHlbnSmOTMpJICTIPJezDaeW/ZJfEHKupss/MFwQxJwlKddAUF5yluZapyyISNS/6+lp/YZmr/puik+qwH1nxOvYt8enQPTRXJv1gBu0TGbR06dPEdxl2Vps49Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722018728; c=relaxed/simple;
	bh=LcqkSuMuNnl7/EFnEDUzZFYLInqU1aN6PbEOOfIXya4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oMlVwYX7Qv3GKgxg+7M6T/wad05A0PYEOvXDo0uuevJU5s767uEMav1p5xpDI5F1NjdGQQ0H6uGRPNbo80AGWXY0Crl66QXyUtYcL0WSBsGVkQmFZiGvVyogjfxPnZ88ENvJtDVvUOxxEgVN3EH/6O4C6U44fbbfI/uXsx7Oc9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eGDMozfY; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6678a45eaa3so24809327b3.2
        for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2024 11:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722018726; x=1722623526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvU4GKCCA3VC4F0Qd0CpFcI4FShvIv+cMmwAVX3v5RQ=;
        b=eGDMozfYB8gEAmLJs5f2osYiaiPav1IliQSQKwQtBH36sjlH0l7oWv4T6us+2GwulT
         MuVElySTcarVNjtLNP7w6lW0hRUtG7/98qZUillPRIbRgHoRYXZrASlWgP/681Ynj2yy
         3aY5eZoVFD7n25rvDMMAPQxjCUnOKnCYFRWWT0aLzXX8VUqEoBCgg5KuZ0QrIUYDSff2
         FkN7ptOEvcdKLXri2Nk2SS2i1TNqWLEPoFq1PbdHMr9oCFhGfH9MqiSltWNpr6xo0IGh
         gY8Gq/W981aYD5NW9YrV8n9HB5sS/YbdI4dKpB6FFrlCTSjaP/vv4a1s7jLrfl7gqWm5
         Q28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722018726; x=1722623526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvU4GKCCA3VC4F0Qd0CpFcI4FShvIv+cMmwAVX3v5RQ=;
        b=kW65cKOIHUT25MoutYlG3Jq6ZBXR4YRnfMe2BJH4JjUEpHM3QHFEJX5iFDoYN86i2A
         fzueCXXa3LTbPRwGPlrd3JLpLkXUEYTXWntua76jWvxVxiDumhUpHeF4zR3DWXKdU4NZ
         oIdfNBIWDKYnyqFfM7RVyFbEDSfLSZMMF5v9Z++3KkjjciPcUOPDgOfarBO61EyywYyJ
         sN/jOUFY74M9rK8q67m9HbnrIb6/Q/Lbz4XHU6eAw9BVvccDor6wxokNQLg5gzjcakAT
         GphJgaYR6IX5OwGmjM6ZRbohl5n/SIKsm8Xmf6Or3/9v2X7SHKzPLIPpE4zuWmpj6LJI
         PKKQ==
X-Gm-Message-State: AOJu0YyynrrvzkTJsorxp2IIqn9oT3qyNf5zSFVU1OPyBaZO+TciFHEs
	W93ZU76QshNJTlXyNFBF0ZJd2gfGYdOam3dOc4QRvAMGdHagS6zMywUvCVX/rwTcwVW8sAvbvS+
	8zIE8+pczCGphv808M6zlnGwjLQOvDTW27J3DzQ==
X-Google-Smtp-Source: AGHT+IE4wP0yM1DlRgLAIm5ti9a4WsMp4eaJ8CYbOpEzOgzqand4B0+L/HFmtEMuilCr8eOCv90No9Xi12wmTjZOZHs=
X-Received: by 2002:a0d:f3c2:0:b0:627:d23a:4505 with SMTP id
 00721157ae682-67a053e06f5mr8508687b3.3.1722018725753; Fri, 26 Jul 2024
 11:32:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240726110142eucas1p29f261e5e81c177456fd5bb5546871eb4@eucas1p2.samsung.com>
 <20240726110114.1509733-1-m.majewski2@samsung.com> <20240726110114.1509733-7-m.majewski2@samsung.com>
In-Reply-To: <20240726110114.1509733-7-m.majewski2@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 26 Jul 2024 13:31:55 -0500
Message-ID: <CAPLW+4k3d+x1V4cPcfbHX=mJ2jM10mDORcuY_Kw4-qr4LND=SQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] dt-bindings: thermal: samsung,exynos: remove
 outdated information on trip point count
To: Mateusz Majewski <m.majewski2@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Anand Moon <linux.amoon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 6:01=E2=80=AFAM Mateusz Majewski
<m.majewski2@samsung.com> wrote:
>
> This is not true as of commit 5314b1543787 ("thermal/drivers/exynos: Use
> set_trips ops").
>
> Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

> v1 -> v2: remove an unnecessary sentence.
>
>  .../devicetree/bindings/thermal/samsung,exynos-thermal.yaml | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/thermal/samsung,exynos-the=
rmal.yaml b/Documentation/devicetree/bindings/thermal/samsung,exynos-therma=
l.yaml
> index b8c0bb7f4263..b85b4c420cd3 100644
> --- a/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.ya=
ml
> +++ b/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.ya=
ml
> @@ -40,11 +40,7 @@ properties:
>    interrupts:
>      description: |
>        The Exynos TMU supports generating interrupts when reaching given
> -      temperature thresholds. Number of supported thermal trip points de=
pends
> -      on the SoC (only first trip points defined in DT will be configure=
d)::
> -       - most of SoC: 4
> -       - samsung,exynos5433-tmu: 8
> -       - samsung,exynos7-tmu: 8
> +      temperature thresholds.
>      maxItems: 1
>
>    reg:
> --
> 2.45.1
>

