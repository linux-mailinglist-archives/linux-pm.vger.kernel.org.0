Return-Path: <linux-pm+bounces-34584-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E623B559BE
	for <lists+linux-pm@lfdr.de>; Sat, 13 Sep 2025 00:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2EA25C2BDB
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 22:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EA126FA6C;
	Fri, 12 Sep 2025 22:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PutVraYs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C017267B89
	for <linux-pm@vger.kernel.org>; Fri, 12 Sep 2025 22:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757717645; cv=none; b=ZN85hxjaxo2HrIIrlVscWEEmWB5AAgvSbdgTCzyFfWEx3Vo691kZ6+9munbEK2HLcetdHEE6xtUkDgQGCSZtMtbSPcNcJOwaMk5y2JqOmKuu0c4wWVfv0DDCjU7SHinG5Ul5fGiRfgUdbXX0ykJ0O9g9xASqgn2BhLOEWHtvT4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757717645; c=relaxed/simple;
	bh=MHrpa4Jwxgc+dQNTjUuLs2EeQFU4pffDsIDMZKMLqmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lhdaks1b/KJk9nzanLR7fSoZ1Jr4lqz+DyNK1hOF4Tz6WePWeDzufoNlffYbN3KAUuOdz4l/crWbDXTjhQfB9CiuFtK0cfMaXKqWDH/6TpyTDTOidgDk1BCWB6FHA0wtFf2MGpSFURM+Wz7X2sqL6rmstHx9buQe7UTwQgkbSMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PutVraYs; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-62bb2e28ba9so78944d50.1
        for <linux-pm@vger.kernel.org>; Fri, 12 Sep 2025 15:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757717641; x=1758322441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/ALLDcBZ6nZwBY7ZN6L7gT+4ClMkunGI751uMEjico=;
        b=PutVraYsoT8gxPT4xt/376mhNjsh17LrtcO0pcCNQRGNVS5m5Q1WliSxIPEbFrayGu
         TgXJ+7M10CMLpAz64f/+YyNtvHzJCxwNO6iRD32fjXNIrDKaW68n9zp4tOd0v9ZV/z1Z
         kzJdu620IzX7snuNghL/mL/EfriWSy8vJWiIzX+zbh95ncUBEY4OwELqMl3pcNP55JL1
         KTfBuBP6o7eCrCzGduUf6nuAmTuYtmEKSL/Tt9eg8OaSlJisZ359ZY4oZzNkOeCVgdcz
         cS87zXcu8yKWLUybiIlpq14j58AgjUOauJq0jvcdh7AUSKuWwDrt16zeBjmGcMb65yZh
         ojMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757717641; x=1758322441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/ALLDcBZ6nZwBY7ZN6L7gT+4ClMkunGI751uMEjico=;
        b=q1qGcFJez3JgLEkl9FsM5xWfgOzz/dJdE5v1Obxsw2HN/2NZW/R1mQod5Lp0whVTkg
         mrpYhnWsHZ+HUoQTjOA3MQHFWkFIvRNiRypyFMKI7W3uUHl3Komr/JcU0xNTVNv5X+ZJ
         30rXnipWQjQtEUOvwSy/UcwMa3uJmThdq82Yvo2d1Mf1SJkzWgdJcgh03qCtJxWhneIB
         j2BmDcHB9elvcitRkC2QHRSd3aztoyaIFR0P4buOPIZL9UjfY+j4aSm4rehrL/+awg0O
         JHDPrQEIoEDiPpi9J7YiaBkD17TNhMqleWg3sLRSlpWizGaFh6k+p09cy+1zHxmwWgof
         4CCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrBLbGb4tC1SHeO/QWdtyeNbiz/6yGdv6FOltvn4JI5t+jPI3GFuoR8t9WSbuD+TUVEA7R3m/jgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzSMNOmJNYmI+JkqlXyb9tr1DIuhodsCvxfR/xfGbjIF3jsOSx
	E/kn55SIfo5SzsnuvZQVqrKGuCG3DNtjWZIGQjePZyqco4mbhqwZGF46GHuVrDc1eEQe74tVffo
	kkvaYZvsh/PVahzqRP4BdpxfhxoqgozE=
X-Gm-Gg: ASbGncvQ6eNSsirCPamx2X3D9PLDTfv7brsNbyaV9ElnE83eJl6uZPclGIlDOWo6VvY
	+2JtYAAYEBrZVDzrANu43DKaO6gjvWjvPxydQCto4QDno1UjZj9U0FWnpgJbi4qFbpTIRb+mOJz
	YFjXyZDxIyxs5AtOGfBnD5HEPZExLFN6tYXYUrJEDRNsobSVbLyPtsqEt2nSq/eW9zLjj8LegjV
	3hYDvFr+xQqigaO+NS+OrzHqAU0HFt4q7mfx4RI1F1HeRQ2wCEc7GY7q3YJNkQrjPTEqcrmnToN
	bEnl+wA=
X-Google-Smtp-Source: AGHT+IGmrPKfHKqLuLVsedBSU1D7fMJ0SPSt1pUu9IK0SCtyHO6OiaCBaQyBDxty6OWXlqg3nf3oT3Kb2tAQnhUAUk8=
X-Received: by 2002:a53:7101:0:b0:626:842f:818c with SMTP id
 956f58d0204a3-6272297979cmr3570059d50.24.1757717641302; Fri, 12 Sep 2025
 15:54:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912-mt8196-gpufreq-v2-0-779a8a3729d9@collabora.com> <20250912-mt8196-gpufreq-v2-9-779a8a3729d9@collabora.com>
In-Reply-To: <20250912-mt8196-gpufreq-v2-9-779a8a3729d9@collabora.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Fri, 12 Sep 2025 15:53:50 -0700
X-Gm-Features: AS18NWAVsbHM7asbGyyRZapaZP5ufrQUasUcMY0V45b2pm9dui9MQp5I0XZOq0k
Message-ID: <CAPaKu7TEN++z8r68k_4-iCyMLMthqJBUX35pgXupAHPdfttrYg@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] drm/panthor: devfreq: add pluggable devfreq providers
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 11:38=E2=80=AFAM Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
<snipped>
> diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.h b/drivers/gpu/drm/=
panthor/panthor_devfreq.h
> index a891cb5fdc34636444f141e10f5d45828fc35b51..94c9768d5d038c4ba8516929e=
db565a1f13443fb 100644
> --- a/drivers/gpu/drm/panthor/panthor_devfreq.h
> +++ b/drivers/gpu/drm/panthor/panthor_devfreq.h
> @@ -8,6 +8,7 @@
>
>  struct devfreq;
>  struct thermal_cooling_device;
> +struct platform_device;
>
>  struct panthor_device;
>
> @@ -43,6 +44,19 @@ struct panthor_devfreq {
>         spinlock_t lock;
>  };
>
> +struct panthor_devfreq_provider {
> +       /** @dev: device pointer to the provider device */
> +       struct device *dev;
> +       /**
> +        * @init: the provider's init callback that allocates a
> +        * &struct panthor_devfreq, adds it to panthor, and adds a devfre=
q
> +        * device to panthor. Will be called during panthor's probe.
> +        */
> +       int (*init)(struct panthor_device *ptdev, struct device *dev);
> +
> +       struct list_head node;
> +};
On mt8196, we have performance-domains to replace several other
properties: clocks, *-supply, power-domains, operating-points-v2.
There are also quirks, such as GPU_SHADER_PRESENT should be masked by
GF_REG_SHADER_PRESENT. It feels like that the scope of
panthor_devfreq_provider is more broader, and at least the naming is
not right.

Another issue is I am not sure if we need to expose panthor_device
internals to the provider. mtk_mfg accesses very few fields of
panthor_device. It seems we can make the two less coupled.

I might change my view as mtk_mfg evolves and requires tigher
integration with panthor. But as is, I might prefer for mtk_mfg to
live under drivers/soc/mediatek and provide a header for panthor to
use in soc-specific path.


> +
>
>  int panthor_devfreq_init(struct panthor_device *ptdev);
>
> @@ -57,4 +71,6 @@ int panthor_devfreq_get_dev_status(struct device *dev,
>
>  unsigned long panthor_devfreq_get_freq(struct panthor_device *ptdev);
>
> +int panthor_devfreq_register_provider(struct panthor_devfreq_provider *p=
rov);
> +
>  #endif /* __PANTHOR_DEVFREQ_H__ */
>
> --
> 2.51.0
>

