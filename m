Return-Path: <linux-pm+bounces-1066-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3060D81114B
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 13:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA65B1F2126E
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 12:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A62228E2D;
	Wed, 13 Dec 2023 12:46:20 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05174D5;
	Wed, 13 Dec 2023 04:46:17 -0800 (PST)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-58dd5193db4so346352eaf.1;
        Wed, 13 Dec 2023 04:46:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702471576; x=1703076376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zD8byS1JULjmdSbCzkHqrAIpOJ6RD2E9VW7j6VSKX6g=;
        b=RNlxx8ey3UeQDnpPUz5ScDB5ghImVO2eLc4s620rSrKIXseGI0aZZL+j2HBzArMgPg
         MlZSmr9UTRbFi6/kHLst8tF+S0fucaHaeNpvIUIOt9p56Fg9VOCeAnM7OaKVCL83595a
         xxPJDifqopg4QF58hTmf/t2hFHXbyab687prb+BwzDQYjUMSMiAB6k5VS0YlWfZGdUE+
         jOLiYnUkidk+HjqPUChSrkv2czYrOORo2gjOyZGTmGVsXWNFk3RQ69G9V1mIdbXw8dnn
         KwdsEMv51V8T8hk0PxoO3jA7iH4sB2BNCMmDmPLDaFX0llHcQJiqe2094iqhBbM9uhDg
         Xa/g==
X-Gm-Message-State: AOJu0Yzyeofj4XuHAZb7GSmdOCvQ97VTfc4m3gleY2mTR7dr2fMYKAEj
	OYyuvD/3DznX2iVPyzJmjrllhk30NqSzaU4ZZGw=
X-Google-Smtp-Source: AGHT+IGqGtz3Jerh1T6ksy3Gv7YxPgmwyPCpLZH5x2imrIO71zFVIKKYfZpZRXccRHbVMHhL65ezIAbsSWWyUkh21SE=
X-Received: by 2002:a05:6871:3749:b0:1fb:9b:3d4c with SMTP id
 np9-20020a056871374900b001fb009b3d4cmr14098480oac.0.1702471576170; Wed, 13
 Dec 2023 04:46:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213121322.2486967-1-daniel.lezcano@linaro.org>
In-Reply-To: <20231213121322.2486967-1-daniel.lezcano@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 13 Dec 2023 13:46:05 +0100
Message-ID: <CAJZ5v0gjeiCb9wBjdG+yWp5E_g2SPUMNNf-Stm_xkGau0Cbr2g@mail.gmail.com>
Subject: Re: [PATCH] thermal/core: Check get_temp ops is present when
 registering a tz
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rafael@kernel.org, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 1:13=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Initially the check against the get_temp ops in the
> thermal_zone_device_update() was put in there in order to catch
> drivers not providing this method.
>
> Instead of checking again and again the function if the ops exists in
> the update function, let's do the check at registration time, so it is
> checked one time and for all.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Looks good.  Do you want me to pick it up?

> ---
>  drivers/thermal/thermal_core.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 625ba07cbe2f..964f26e517f4 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -437,11 +437,6 @@ void __thermal_zone_device_update(struct thermal_zon=
e_device *tz,
>         if (atomic_read(&in_suspend))
>                 return;
>
> -       if (WARN_ONCE(!tz->ops->get_temp,
> -                     "'%s' must not be called without 'get_temp' ops set=
\n",
> -                     __func__))
> -               return;
> -
>         if (!thermal_zone_device_is_enabled(tz))
>                 return;
>
> @@ -1289,7 +1284,7 @@ thermal_zone_device_register_with_trips(const char =
*type, struct thermal_trip *t
>                 return ERR_PTR(-EINVAL);
>         }
>
> -       if (!ops) {
> +       if (!ops || !ops->get_temp) {
>                 pr_err("Thermal zone device ops not defined\n");
>                 return ERR_PTR(-EINVAL);
>         }
> --
> 2.34.1
>

