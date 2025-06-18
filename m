Return-Path: <linux-pm+bounces-28968-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EF6ADEE13
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 15:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B27AE4A0A6A
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 13:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BC82E9EA6;
	Wed, 18 Jun 2025 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nHEB9hOW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337A32E9730
	for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 13:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750254064; cv=none; b=rk7Mq9jt1diENSdLAK6wgqTA6iK3d/HWX7y5PqZ2a9pJil7a8po4K+eJ4inN6XuhJp0CxevB2c0fOAYZfSwU5BWzet+UD1qX5cfwbtvaHPLhGioRxsLzzvmWevrmR2kBIp9dAyByVMTx7PTZMHgY3pWC3H/wDmVc/rBkhBfVuHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750254064; c=relaxed/simple;
	bh=mF4mVKSNr32bBZcSBmpXcngYOZ/LgBHUibToT5Tssxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+jFAYvwQidXMDHjwgdRg7twKmTe2+h0zarPXH/KSRuhP3rsVBXhrnc4riOqdc2UXtB6vFyE2g67uiIZa64jWoTFYrF0ytflPhjld9ad5LOVpW5y7bThqC7MVaKINxenzlKj52W8z5G5Ylcq4yxH6k0vCjjMRfEaXzV/aZjCwcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=nHEB9hOW; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-553d52cb80dso555821e87.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 06:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1750254061; x=1750858861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrPSIGFdDvH/sqDpr0dCl/uxSDMMDHtGVw2V0lw2wqI=;
        b=nHEB9hOWURE+jc8l40SJEp6hEaoOhX2l3skJoM11cUj6/kG4XFrGh/8ei8bjjfwdrv
         PQEEJ4nKAuaTjH1gPZ2w3Tqrg0NjeoIGZGpXY8muFXJxGpPdmXxsWuRwqSRQ9juuBeOa
         vSc9+fvacB0U2rpK5avxeGI5oCcsNGFXjsyxpdT05bXp1/XhJsIpfMvubZYynpRDiZ49
         APDtdaWnchWXj99KH5kKPCwL789bz5cjCOql9Th405ajbEVJb6c1CL1RtyTBJS1qT2uY
         Qp1mS9ZCbNB7UrwMTm81ttSHL2zH5HdORbDZxW5FHtZTq7zHuYYf6jLJty8hKIYT3y9/
         FFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750254061; x=1750858861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GrPSIGFdDvH/sqDpr0dCl/uxSDMMDHtGVw2V0lw2wqI=;
        b=R9wBONZdzUh3Q07+x5Uh852H9neHNBdjhVm8W/CIjKehgvJ55ZRrcslzoF6VxtH8ES
         K4HCjcIVhF5dAG8XqcqiMV8g05ZqnCEZIdWXVbQZAXYbLkgCwJyTt5FnRD6dQxnuDdNO
         o8g6INhh4Z6dfx653iPc/PK3gUoTI8zan7fqKAlAWpvfZdSTi2Xsssh6chDQj2IdQKZS
         hrQEQjBOXCdmalO1UMwYoEtWznBXDwNrzAmtuOXUynyTN0FZYfDuP/e7La51aYRmmUx5
         J5e/t2VvuPcjC5fRKCS5/2q2dqo9iDIoDMxiCyLJ7LN80eYKPQ5xZsPwqfuF6V0rHmUm
         nNmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh8NRVGFb+WO0M4FNf1lW68x7sGOsNtIBf7xqEwyW3fwIa3LagheA28v+4JmlTlvXLH300oqc3pg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkcs+HY33Yp1TxR8rqSCkQi0wxUVSfYRsq3OV+yBamF9RrNtV1
	1lKmZKc8zB6dhaMs4iJdqVWhggiACtqgTguGtn7f6lQCdTSocy4cjLPriDK0fOmD/ufT85UfGZ1
	/R/EIKzL5CtV8UYzIuCXsoY7Du4Cf7kylbvzHgWEVhQ==
X-Gm-Gg: ASbGncs3IA0LCTlaKEvmeCM3LJjaMsrwJ4YrZBl6pEmOlYwbMfmr0XozJeTZmyPPjeA
	RdiM8pMIYxR+RDoHJxNslY6i3enEaJt7oOom9PjiaC0x80WWNp97xeYbkbYoWUybz/+RrGb4qoB
	JRHdPm6QUfV2Xj6dOxGsAst0pFnVzSxSPxOQiRW9FtNmefWcQmXLr2w22G7fUdv9FLd+hpvf5c/
	w==
X-Google-Smtp-Source: AGHT+IFaBv4NoyscEiYMrPy3nG50l45WGg0pb5gyw3nSvWsy9OTHWeanUensQSBBIwLRpHNCc71NZbTtG782jD+L4SY=
X-Received: by 2002:a05:6512:150b:10b0:553:d884:7933 with SMTP id
 2adb3069b0e04-553d8847a54mr20662e87.6.1750254061265; Wed, 18 Jun 2025
 06:41:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250618102227eucas1p26e8968805092c3ce0ecbe84e9724a6e2@eucas1p2.samsung.com>
 <20250618-apr_14_for_sending-v5-0-27ed33ea5c6f@samsung.com> <20250618-apr_14_for_sending-v5-2-27ed33ea5c6f@samsung.com>
In-Reply-To: <20250618-apr_14_for_sending-v5-2-27ed33ea5c6f@samsung.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 18 Jun 2025 15:40:50 +0200
X-Gm-Features: AX0GCFv9aAVOTlnyOx9_bS0PZ0O5sUFY83rUOThbfDgpmQkEdj-PgI3MnYHtNsE
Message-ID: <CAMRc=Mdv24kKJRKMyp2zpNtumZLV5QN=KvvENr8GXfORAC9Cpw@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] dt-bindings: firmware: thead,th1520: Add resets
 for GPU clkgen
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
> Extend the TH1520 AON to describe the GPU clkgen reset line, required
> for proper GPU clock and reset sequencing.
>
> The T-HEAD TH1520 GPU requires coordinated management of two clocks
> (core and sys) and two resets (GPU core reset and GPU clkgen reset).
> Only the clkgen reset is exposed at the AON level, to support SoC
> specific initialization handled through a dedicated auxiliary power
> sequencing driver. The GPU core reset remains described in the GPU
> device node, as from the GPU driver's perspective, there is only a
> single reset line [1].
>
> This follows upstream maintainers' recommendations [2] to abstract SoC
> specific details into the PM domain layer rather than exposing them to
> drivers directly.
>
> Link: https://lore.kernel.org/all/816db99d-7088-4c1a-af03-b9a825ac09dc@im=
gtec.com/ - [1]
> Link: https://lore.kernel.org/all/38d9650fc11a674c8b689d6bab937acf@kernel=
.org/ - [2]
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml | 7 +++=
++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/firmware/thead,th1520-aon.=
yaml b/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
> index bbc183200400de7aadbb21fea21911f6f4227b09..3365124c7fd4736922717bd31=
caa13272f4a4ea6 100644
> --- a/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
> +++ b/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
> @@ -32,6 +32,13 @@ properties:
>      items:
>        - const: aon
>
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    items:
> +      - const: gpu-clkgen
> +
>    "#power-domain-cells":
>      const: 1
>
>
> --
> 2.34.1
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

