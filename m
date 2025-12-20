Return-Path: <linux-pm+bounces-39716-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EAADBCD2473
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 01:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 369B23001BFA
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 00:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902B822B5A3;
	Sat, 20 Dec 2025 00:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5EgBJmx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C725F18A94C
	for <linux-pm@vger.kernel.org>; Sat, 20 Dec 2025 00:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766191530; cv=none; b=O/OpnzGaXWsQRwqXx9i9819dcdBBM4UsAw3wv/0fdhG4wtqEoy/G75DixjhysbegttJ3PTKvQRX3muZyAzM7InTTCoNWKe6C6p4Axp2/m4bIDhW0KIg1lxCaPT5SGqWQbz1kQk1cjpTh1oQzcuLdAee0x7OPajBlgSWsdEVvwy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766191530; c=relaxed/simple;
	bh=2+jsEPyEAEVhUZ/L5Brcilwc6Iq77Bzzimns5lkwAlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UGfVKjc7JuXUHy1Pk3OZ136faSuF3h9HF25UF+ZSOrSf+3yP7pGgkyX0rio6B+W9EZ/iJIg3bV5r8dskkUs7YVd9qvAAIuJf4mU3DvcDVABO493oTZJuWRDNIFeEzaDXFkCb4qhLV4rqkRNQY+bWy/AAKrsrjZ0q37UL1veJRs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5EgBJmx; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-78c38149f9fso16333077b3.2
        for <linux-pm@vger.kernel.org>; Fri, 19 Dec 2025 16:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766191528; x=1766796328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLPI+6y1Cd274pWyRLM4LL7VX9uNyq+alqBEtAEYrvI=;
        b=C5EgBJmxuPpRx9IWXn1ISz5/gr+hkUobXADGH1jKXl5GNX19qHkc7fSAR9mNSkU64j
         HXWaeNPYktQTFdupSnMpym/JYsSdeFtx8l+CPLBClkTgbD2wqrWeJgRxXCiNJvX6O+v0
         D9JS2jkCkTe/P2MjeMRNKHo1H8Ki4EjlO4dpQW3P2sFp+mErSWlHttlnJmaKPR/Gibx0
         fVlER++wBQX9RlKowNW5gJqCUP7+J+SQk6h52wcWWH5zhaEkWXag0oDAQk1+r1BUsASF
         NFzU4inBDJIwoXSaH+b5CWO99iDv101aOdwxBQnr2MV+hRB0DeF5KhaxOYUp6+8aojj7
         Jf5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766191528; x=1766796328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DLPI+6y1Cd274pWyRLM4LL7VX9uNyq+alqBEtAEYrvI=;
        b=IGdHY/XOvCEy3VS2ZPu+reaZ53oX77FQJi7+S78en8vh8EI0eF16Hli03RcBjzLUm7
         9sHyb90c89xmSiUBXbNdZsAySVCNq94GnNvgdh5b0ds54c9FY/MV8QAjtg3TKxtl1VF2
         b6cHt0kGhK7vpaHN4Bm/DUIGlYv5RBy3FoGDzGCtFNUCbix5cHVl34sMhKSgG5k5Oy+N
         ED49m5dd8NvSafgBp5rWTYL0jtWDmcaX4mf9NwHTqKUqpTmLHnahP+H9lo59ajgbkf6E
         wiSoSRPgFcRfmoE+N8+sTJ+/gGbCwRyQCkLGN0QTmxsUET+HeJFSQ07MAsxWK8krW7wi
         Sxlw==
X-Forwarded-Encrypted: i=1; AJvYcCVY4D0KMGP5kIhWH5tV3+pbUOaNUwCKmh2/DHbE3xVuCmOFcTGD5iOAuQsuFXKgFSNwRmgKtnl0NA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmPxuLt6YwX6SyZaufFZlXqb36XCh1K2eECwzGWDbLOeead+1D
	lOkIfZUUnrHEQ5NbCsJT+Lo7+2pjWDqB2HZv2akP6y9KQDg7q5hFoHY1Z/7buWkgRueZoeIEcjU
	koZpaev6VPv2cq3dc0VWrHNaRmn5ZHcI=
X-Gm-Gg: AY/fxX5KTsyf8qFNMDQf8clMC7CFT2Grh8uDfeLnpzTGH+kcu4i5GPYp+4Ce35D/imA
	Wv7K6PznrRRvyP74jFfgepQMBYD7cVNYD7ftSkrk5/NqxUofWUXiZzgZk02JXwlQHIsp8GOT5TF
	oERLEzafowiNCKmzAPL6+cnkGvVmh6/6FON8lieYHv6PI6vbgXWvy5ungKVXGjTZCdIpDKurxaD
	EiRV3DjlQGiVIw8sxtmzTCigYSBldZ89WBXz75X/TLDHjTuSlluYBKNcAJ1PHVcPHUuZi0ujt88
	d8wk8Z459yYycHJ2Rv9j9n7IxG45l+DMEmE675w=
X-Google-Smtp-Source: AGHT+IGxV5Pk9FDKr/Lj9KKxcmNH7Vilqojhd5iNKpIgV73bbfC+PbBJ47gDiQQYvtv+vvVB4r13+qOWvY++J5PPenk=
X-Received: by 2002:a53:6912:0:b0:645:5d62:dd8 with SMTP id
 956f58d0204a3-6466a8f31a3mr2853787d50.50.1766191527647; Fri, 19 Dec 2025
 16:45:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217-mt8196-shader-present-v1-0-f6f8f3aa1e93@collabora.com>
 <20251217-mt8196-shader-present-v1-3-f6f8f3aa1e93@collabora.com> <bdf5b4f9-d6f5-419d-9465-4f722bac06ef@arm.com>
In-Reply-To: <bdf5b4f9-d6f5-419d-9465-4f722bac06ef@arm.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Fri, 19 Dec 2025 16:45:16 -0800
X-Gm-Features: AQt7F2qLOWDeNcNuYDcamhHFDHG6i6Fg_mD7kZv-_AbDieajS4u9bPacZVvQHto
Message-ID: <CAPaKu7So4BeEyUGSS3ZAHi+Z=Sh6Kpy_W8eEtX4UQs=__MpPEA@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm/panthor: Implement reading shader_present from nvmem
To: Steven Price <steven.price@arm.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Chen-Yu Tsai <wenst@chromium.org>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 7:31=E2=80=AFAM Steven Price <steven.price@arm.com>=
 wrote:
>
> On 17/12/2025 17:03, Nicolas Frattaroli wrote:
> > On some platforms, notably MediaTek MT8196, the shader_present bitmask
> > in the Mali GPU register for it has cores enabled that may be faulty.
> > The true shader_present bitmask is found in an efuse instead.
> >
> > Implement reading shader_present from an nvmem cell if one is present,
> > falling back to the Mali register if it's absent. The error codes are
> > trickled up through to the probe function so that probe deferral works.
> >
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
>
> Reviewed-by: Steven Price <steven.price@arm.com>
>
> [Although I really hope other vendors don't do this - the hardware is
> broken!]
>
> Although one NIT below if you respin for other reasons...
>
> > ---
> >  drivers/gpu/drm/panthor/panthor_hw.c | 63 ++++++++++++++++++++++++++++=
++++----
> >  1 file changed, 57 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/pan=
thor/panthor_hw.c
> > index 87ebb7ae42c4..eb44c8b108aa 100644
> > --- a/drivers/gpu/drm/panthor/panthor_hw.c
> > +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0 or MIT
> >  /* Copyright 2025 ARM Limited. All rights reserved. */
> >
> > +#include <linux/nvmem-consumer.h>
> >  #include <drm/drm_print.h>
> >
> >  #include "panthor_device.h"
> > @@ -109,7 +110,52 @@ static char *get_gpu_model_name(struct panthor_dev=
ice *ptdev)
> >       return "(Unknown Mali GPU)";
> >  }
> >
> > -static void panthor_gpu_info_init(struct panthor_device *ptdev)
> > +static int overload_shader_present(struct panthor_device *ptdev)
> > +{
> > +     struct device *dev =3D ptdev->base.dev;
> > +     struct nvmem_cell *cell =3D nvmem_cell_get(dev, "shader-present")=
;
> > +     ssize_t len;
> > +     void *buf;
> > +     int ret;
> > +
> > +     if (IS_ERR(cell)) {
> > +             /* On platforms without this cell, use the Mali register =
*/
> > +             if (PTR_ERR(cell) =3D=3D -ENOENT)
> > +                     return 0;
> > +
> > +             return dev_err_probe(dev, PTR_ERR(cell),
> > +                                  "Failed to get shader-present nvmem =
cell\n");
> > +     }
> > +
> > +     buf =3D nvmem_cell_read(cell, &len);
> > +     if (IS_ERR(buf)) {
> > +             ret =3D dev_err_probe(dev, PTR_ERR(buf),
> > +                                 "Failed to read shader-present nvmem =
cell\n");
> > +             goto err_put_cell;
> > +     }
> > +
> > +     if (!len || len > 8) {
> > +             ret =3D dev_err_probe(dev, -EINVAL, "shader-present cell =
can't be length %ld\n",
> > +                                 len);
> > +             goto err_free;
> > +     }
> > +
> > +     memcpy(&ptdev->gpu_info.shader_present, buf, len);
When len is 4, this is neither overriding nor masking. I might suggest
switching to nvmem_cell_read_variable_le_u64 for simplicity.

Either way, Reviewed-by: Chia-I Wu <olvaffe@gmail.com>


> > +
> > +     kfree(buf);
> > +     nvmem_cell_put(cell);
> > +
> > +     return 0;
> > +
> > +err_free:
> > +     kfree(buf);
> > +err_put_cell:
> > +     nvmem_cell_put(cell);
> > +
> > +     return ret;
> > +}
>
> Rather than repeating the clean up, you can do something like:
>
> {
>         void *buf =3D NULL;
>         int ret =3D 0
>
>         if (IS_ERR(cell)) {
>                 ret =3D dev_err_probe(...);
>                 goto out;
>         }
>
>         buf =3D nvmem_cell_read();
>         if (IS_ERR(buf)) {
>                 ret =3D dev_err_probe(...);
>                 goto out;
>         }
>
>         if (!len || len > 8) {
>                 ret =3D dev_err_probe(...);
>                 goto out;
>         }
>
>         memcpy();
>
> out:
>         if (!IS_ERR(buf))
>                 kfree(buf);
>         if (!IS_ERR(cell))
>                 nvmem_cell_put(cell);
>
>         return ret;
> }
>
> That avoids mistakes when adding a new operation into the sequence. Or
> you can use the fancy new cleanup helpers, but that feels overkill here.
> But equally I'm ok if you leave the code as is - it's simple enough and
> the conversation can be done later if we need it.
>
> Thanks,
> Steve
>
> > +
> > +static int panthor_gpu_info_init(struct panthor_device *ptdev)
> >  {
> >       unsigned int i;
> >
> > @@ -143,13 +189,18 @@ static void panthor_gpu_info_init(struct panthor_=
device *ptdev)
> >               ptdev->gpu_info.tiler_present =3D gpu_read64(ptdev, GPU_T=
ILER_PRESENT);
> >               ptdev->gpu_info.l2_present =3D gpu_read64(ptdev, GPU_L2_P=
RESENT);
> >       }
> > +
> > +     return overload_shader_present(ptdev);
> >  }
> >
> > -static void panthor_hw_info_init(struct panthor_device *ptdev)
> > +static int panthor_hw_info_init(struct panthor_device *ptdev)
> >  {
> >       u32 major, minor, status;
> > +     int ret;
> >
> > -     panthor_gpu_info_init(ptdev);
> > +     ret =3D panthor_gpu_info_init(ptdev);
> > +     if (ret)
> > +             return ret;
> >
> >       major =3D GPU_VER_MAJOR(ptdev->gpu_info.gpu_id);
> >       minor =3D GPU_VER_MINOR(ptdev->gpu_info.gpu_id);
> > @@ -172,6 +223,8 @@ static void panthor_hw_info_init(struct panthor_dev=
ice *ptdev)
> >                "shader_present=3D0x%0llx l2_present=3D0x%0llx tiler_pre=
sent=3D0x%0llx",
> >                ptdev->gpu_info.shader_present, ptdev->gpu_info.l2_prese=
nt,
> >                ptdev->gpu_info.tiler_present);
> > +
> > +     return 0;
> >  }
> >
> >  static int panthor_hw_bind_device(struct panthor_device *ptdev)
> > @@ -218,7 +271,5 @@ int panthor_hw_init(struct panthor_device *ptdev)
> >       if (ret)
> >               return ret;
> >
> > -     panthor_hw_info_init(ptdev);
> > -
> > -     return 0;
> > +     return panthor_hw_info_init(ptdev);
> >  }
> >
>

