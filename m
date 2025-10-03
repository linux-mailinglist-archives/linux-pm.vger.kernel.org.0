Return-Path: <linux-pm+bounces-35708-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE484BB8235
	for <lists+linux-pm@lfdr.de>; Fri, 03 Oct 2025 22:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E274B3A6A33
	for <lists+linux-pm@lfdr.de>; Fri,  3 Oct 2025 20:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C368324DD11;
	Fri,  3 Oct 2025 20:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlKvIP96"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74AD23AB94
	for <linux-pm@vger.kernel.org>; Fri,  3 Oct 2025 20:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759524473; cv=none; b=W7BpQiar7XBppcC/RVHUzKFIwBnT3jDzEkUhyi14Mup9DOK+BZmQU9PpVAV/hO/ViQyMzMmhlqaQZ1zV1OmfAU9QspCH09ojJOcpNcUcNjoXyk1uwUT5HLHRrElrvI5SaXXF0FUMTBQ7DvSIyadoZIbBJNR326jBjqIHfByj04o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759524473; c=relaxed/simple;
	bh=MHoXLWg3HvpW49PRCoLLv1E052ODwx10RLVlPGCpiHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OIHTt6k4wWh25l+CnXgKVKOgU8gKxs/Bj4PGElcSOKpLXqnan6vv56aq5aF7buN57Vb8uA6RAbZQCiU/EFVxoJajv0kRJTBYQPHEtTHiAMM59iKD7tHIzkYK1Su8eO3Hxd8YyL2QHtbtSkeLy9jD+qhyfzpSeSgQu6UyG/WomOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlKvIP96; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6354af028c6so2631313d50.3
        for <linux-pm@vger.kernel.org>; Fri, 03 Oct 2025 13:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759524471; x=1760129271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ec07GK8IeebwUTlhOReO08byQCiI8XurDvMqhbTfpDs=;
        b=hlKvIP96ETlMNTcctkUps4Rp3bu8GayWk1dye8kfWKZeJmZPrn2xu5PWNK7tcDcnca
         8J6QOoYZz/UczJ53iUQ+ODjzYaCL9jCFbfKm5I5zDM/Y0qY8SHgfjS3ANDkQR3I7BV0N
         YTiCQm7+Z0opwMD0G7QvJa1N6+eytVQ5jmmM9pdfY+7uAEARJ1egzvqFrmhpoB+QmYwW
         L+pOCGclpsgtNd3b1VBcf+8oB6iuUAE1kC7KKnm9nXNMHV07GGi+b3wgj0JmqB+Vm2ZZ
         M9/8wI00qisEY3O42//cOu7x4TKc5BgSKtFRDvD63/pV2RGbhLo8fIoflI1ej5TRnpv2
         95dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759524471; x=1760129271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ec07GK8IeebwUTlhOReO08byQCiI8XurDvMqhbTfpDs=;
        b=Q2U4uI/mJfNOrFrRBohXfQy9mQ5JTESFsum0amx1yAIWeqCv6+V9ejgO1OEoKrdjAI
         CKfgpUDp4QcV65oKbMEVh+GOM0reBiGr1VWuIEGxd7cvFjA+Bc6uF2yxg17/YuqyT4Ox
         2AhTWYkUQ+TVe2WNvNv6UDybmpK72hcpjVv7E8wFHYWVBLAl1CDDTVPV14FyPnx7NYP7
         Y49sy+Jzdfh+9JEWdSv7ZE5waqNlZVLE7sTmoGGNQ+0HBrYIz5LUbSMrgCF/TNpIXvDD
         qwl50cGOc9/rkUYWTEpjUR2MGqksK9YWcihYiUzOXh5PEtn4GNha2r7HkEYDnfB6NjJO
         2Y1A==
X-Forwarded-Encrypted: i=1; AJvYcCXDnoeMq6jeVAVlfVcIbjw3HeYOVzRpWYQqVmizzKXFYAuDNksH19uqSW4ew2bc/0iM7KwW69inEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHN9gyMVlSUDe4CkvFTe2Am4ijpIV7LiVAH+GUwHKtA46+j33Q
	wMegdDjo/RX3lgdoSebyoj653aCHI09xN1gy6uLlPtC4Wh4QjiTUROf4THyr7mOJ6myg4Y6oHIM
	/8pWiG9Zhl8jsmiwhD4wIPbrQqjDyCDw=
X-Gm-Gg: ASbGncuKKaC6ZN8ooCHzshv+vf98dUpObFX7jrNeWjuPN7YSeCTsIwOjhduo5W+hsKK
	2g+dbs6275MLV0Drt8IIMFd7xB8SNiyqweXd6/azWcS5HB5suz1kQIDTsGrbwoYE0ZMw2N67+bc
	eLXbQovOPyRvuJrwFndC8LANW8cwkUZ/tJ3Abgo92udymXOjiBN7xRS2M2xICWtVpTOwjb8vLiy
	9Ycm3BmIu+x0qdrhuGq6ciMP9sm3u0YY51Q9MuYXIpYID972THXAhoVdwATtMEb6Nn0Mc9oZHWb
	OBBjjVizEofGXdlZs+CL9w==
X-Google-Smtp-Source: AGHT+IGbRtPbh98BClkNFwaUaMJb45w8kt4Jk0KxRGScag36Tw0xGWcnBknxDwxYEhQPRsDsxQjX2aqyBPDcA2KuG7Q=
X-Received: by 2002:a53:8550:0:b0:638:53e9:bab0 with SMTP id
 956f58d0204a3-63b9a0ee753mr3639824d50.24.1759524470895; Fri, 03 Oct 2025
 13:47:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003-mt8196-gpufreq-v6-0-76498ad61d9e@collabora.com> <20251003-mt8196-gpufreq-v6-6-76498ad61d9e@collabora.com>
In-Reply-To: <20251003-mt8196-gpufreq-v6-6-76498ad61d9e@collabora.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Fri, 3 Oct 2025 13:47:39 -0700
X-Gm-Features: AS18NWBGD0pXXLOymrZv-_f8nOh4HIhBGy-SAER5xKOoIW_DOui92j81TfsOhUs
Message-ID: <CAPaKu7Q==RvuZR-pgJekF++Y4HOdkryEvYV8QGJd_os0_if_vQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] drm/panthor: Use existing OPP table if present
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Chen-Yu Tsai <wenst@chromium.org>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 1:16=E2=80=AFPM Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
>
> On SoCs where the GPU's power-domain is in charge of setting performance
> levels, the OPP table of the GPU node will have already been populated
> during said power-domain's attach_dev operation.
>
> To avoid initialising an OPP table twice, only set the OPP regulator and
> the OPPs from DT if there's no OPP table present.
>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_devfreq.c | 26 ++++++++++++++++---------=
-
>  1 file changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/=
panthor/panthor_devfreq.c
> index 978f193a2aee561fadd9a976e9b1417118260889..6beb6170d6eea3dd65880dfe6=
4a61abbdd5f08da 100644
> --- a/drivers/gpu/drm/panthor/panthor_devfreq.c
> +++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
> @@ -143,6 +143,7 @@ int panthor_devfreq_init(struct panthor_device *ptdev=
)
>         struct panthor_devfreq *pdevfreq;
>         struct dev_pm_opp *opp;
>         unsigned long cur_freq;
> +       struct opp_table *t;
>         unsigned long freq =3D ULONG_MAX;
>         int ret;
>
> @@ -152,18 +153,23 @@ int panthor_devfreq_init(struct panthor_device *ptd=
ev)
>
>         ptdev->devfreq =3D pdevfreq;
>
> -       ret =3D devm_pm_opp_set_regulators(dev, reg_names);
> -       if (ret) {
> -               if (ret !=3D -EPROBE_DEFER)
> -                       DRM_DEV_ERROR(dev, "Couldn't set OPP regulators\n=
");
> -
> -               return ret;
> +       t =3D dev_pm_opp_get_opp_table(dev);
"t" is too short for a long function like this one. We should either
rename it to "opp_table" or refactor this out to a shorter function.

dev_pm_domain_set_performance_state is new to me. It might just be me,
but a short comment explaining that the opp table might have been set
up by the pmdomain can be helpful.

With that, Reviewed-by: Chia-I Wu <olvaffe@gmail.com>.

> +       if (IS_ERR_OR_NULL(t)) {
> +               ret =3D devm_pm_opp_set_regulators(dev, reg_names);
> +               if (ret) {
> +                       if (ret !=3D -EPROBE_DEFER)
> +                               DRM_DEV_ERROR(dev, "Couldn't set OPP regu=
lators\n");
> +
> +                       return ret;
> +               }
> +
> +               ret =3D devm_pm_opp_of_add_table(dev);
> +               if (ret)
> +                       return ret;
> +       } else {
> +               dev_pm_opp_put_opp_table(t);
>         }
>
> -       ret =3D devm_pm_opp_of_add_table(dev);
> -       if (ret)
> -               return ret;
> -
>         spin_lock_init(&pdevfreq->lock);
>
>         panthor_devfreq_reset(pdevfreq);
>
> --
> 2.51.0
>

