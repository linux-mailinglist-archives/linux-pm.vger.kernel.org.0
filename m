Return-Path: <linux-pm+bounces-26324-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA96A9F28D
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 15:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7F053AE82A
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 13:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CED26B2C4;
	Mon, 28 Apr 2025 13:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaD2hFnT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEB425EF8E;
	Mon, 28 Apr 2025 13:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745847549; cv=none; b=T46vCPz8iM+pPa6iz6umrUckEIMqS5v5+7H0kQJzN9OgFPAe+/1uhHL65Xlvgx5zFUB1fc+Bd83jlEGYAG5cPWslYEVCnG8U8niBIUtxwdbEyJgdmugUXuJQgLqoGdxIYZLNdgFfru1idyLasm5kFjPV0GHlCDYUPB7/7gBs5og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745847549; c=relaxed/simple;
	bh=dj5RefpECVDBZI7owexGLlmhzK/Ar+sqUa2Oqy0YLd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HkSQqVbNsSyMyM6dsenhBCksNH0Uge1bDQtRL2eR8NQqQZoITK/64/aL7nDM0MXByEIjqYI2mELZuoYWt0TTJksjsEr1B3VQ2cHs3rIzHltNf3tpqzFsW/LB9XB+anYiM1zuQuFHaFMmh25YwhxAF9aOtQXz/hOadHMVEfV8tGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SaD2hFnT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75136C4CEE4;
	Mon, 28 Apr 2025 13:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745847548;
	bh=dj5RefpECVDBZI7owexGLlmhzK/Ar+sqUa2Oqy0YLd8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SaD2hFnThE2JLBYABHXqUadywgIeGw/6wKJi5fyg1tvifpzGkoLorDJkAg+AqoVmp
	 HxDSR9Mi6GK9DEKyjtE0+UWFD3PWCTatoHiLOP5qmQyvkNVvpRoca95thhcI0+ZTRq
	 Ne2XlICsxQf0VCNTCnOHNdRWoM6s7l3Rq2WgdHZ58fgQpHZZJu77V/+zLKAwU1j9rn
	 TUTcZgjMnJx6Mun4Sm6O6OOzwvshvA6GE3IMyQ6whJWN1fWoP8ZwlEMP/Ifw39CxDH
	 0DTU6SfpWuMCaYN/4BeWUcDQAsH5r63WTkJJN16Q8GcEBcTSq73X8G63iXt+b7folz
	 S4l7bxCCytECg==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6049acb776bso2519385eaf.3;
        Mon, 28 Apr 2025 06:39:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUCR2+d48rpqY5r+VFgbQPrFabSDV9RpZd8oh9vFP5xyn3KodipSqzLA/7HqfklSmeW8xwz+IfH0lE=@vger.kernel.org, AJvYcCXQ40q4ZciWDKo1RQzhZ+srbM1vXJvC6srR9/GAXE5ejvwiXfILN1gFMmTmDWIJX6MtOc3m+wLcWWcI7nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPYQ7MvyHvNZ8Eqr9RoSTe1Z5Uobaq+uTYheprjm3kjtY9V+YK
	jbBsALXri6cPYw1Gd5saMOy44g/PkfEDEl8qrHqW6OkHfFTHY1j1CUR+haVXxRxeGHm+02VWrKx
	47ltLyoNgfBVL3pwjHw6lL+HRkSg=
X-Google-Smtp-Source: AGHT+IGkcp/j9FjbRcGSYJNMQ/R+l+8CISytvDs7uysDHP4XWDQeyaAXy9djfuohP33ZKUpFgNEF+8HdT4mg3KXuvwo=
X-Received: by 2002:a05:6870:b14d:b0:2bc:716c:4622 with SMTP id
 586e51a60fabf-2d99de7e298mr6100774fac.38.1745847547775; Mon, 28 Apr 2025
 06:39:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420-fix_power-v2-1-9b938d2283aa@quicinc.com>
In-Reply-To: <20250420-fix_power-v2-1-9b938d2283aa@quicinc.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 28 Apr 2025 15:38:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jjCt-rDUVbHh1=Ngg_f_RZnNCUFGixLEe2ScRx1CtF2w@mail.gmail.com>
X-Gm-Features: ATxdqUHhk1lXOtwe5dQ_gfcv_FNxe3TG8JBqHxH2vOdCQJgkJ6FY-b-hm9DOR6Y
Message-ID: <CAJZ5v0jjCt-rDUVbHh1=Ngg_f_RZnNCUFGixLEe2ScRx1CtF2w@mail.gmail.com>
Subject: Re: [PATCH v2] PM: wakeup: Do not expose 4 device wakeup source APIs
To: Zijun Hu <zijun_hu@icloud.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 20, 2025 at 6:19=E2=80=AFAM Zijun Hu <zijun_hu@icloud.com> wrot=
e:
>
> From: Zijun Hu <quic_zijuhu@quicinc.com>
>
> The following 4 APIs are only used by drivers/base/power/wakeup.c
> internally.
>
> - wakeup_source_create()
> - wakeup_source_destroy()
> - wakeup_source_add()
> - wakeup_source_remove()
>
> Do not expose them by making them as static functions.
>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
> Changes in v2:
> - Remove 3 more APIs, correct tile and commit message.
> - Link to v1: https://lore.kernel.org/r/20250420-fix_power-v1-1-1454cf1dc=
534@quicinc.com
> ---
>  drivers/base/power/wakeup.c | 12 ++++--------
>  include/linux/pm_wakeup.h   | 15 ---------------
>  2 files changed, 4 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index 63bf914a4d4467dcf6c42e50951b91677fb9c46d..27505dea7c1b454e7f124637a=
f1834f558e0d022 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -77,7 +77,7 @@ static DEFINE_IDA(wakeup_ida);
>   * wakeup_source_create - Create a struct wakeup_source object.
>   * @name: Name of the new wakeup source.
>   */
> -struct wakeup_source *wakeup_source_create(const char *name)
> +static struct wakeup_source *wakeup_source_create(const char *name)
>  {
>         struct wakeup_source *ws;
>         const char *ws_name;
> @@ -106,7 +106,6 @@ struct wakeup_source *wakeup_source_create(const char=
 *name)
>  err_ws:
>         return NULL;
>  }
> -EXPORT_SYMBOL_GPL(wakeup_source_create);
>
>  /*
>   * Record wakeup_source statistics being deleted into a dummy wakeup_sou=
rce.
> @@ -149,7 +148,7 @@ static void wakeup_source_free(struct wakeup_source *=
ws)
>   *
>   * Use only for wakeup source objects created with wakeup_source_create(=
).
>   */
> -void wakeup_source_destroy(struct wakeup_source *ws)
> +static void wakeup_source_destroy(struct wakeup_source *ws)
>  {
>         if (!ws)
>                 return;
> @@ -158,13 +157,12 @@ void wakeup_source_destroy(struct wakeup_source *ws=
)
>         wakeup_source_record(ws);
>         wakeup_source_free(ws);
>  }
> -EXPORT_SYMBOL_GPL(wakeup_source_destroy);
>
>  /**
>   * wakeup_source_add - Add given object to the list of wakeup sources.
>   * @ws: Wakeup source object to add to the list.
>   */
> -void wakeup_source_add(struct wakeup_source *ws)
> +static void wakeup_source_add(struct wakeup_source *ws)
>  {
>         unsigned long flags;
>
> @@ -179,13 +177,12 @@ void wakeup_source_add(struct wakeup_source *ws)
>         list_add_rcu(&ws->entry, &wakeup_sources);
>         raw_spin_unlock_irqrestore(&events_lock, flags);
>  }
> -EXPORT_SYMBOL_GPL(wakeup_source_add);
>
>  /**
>   * wakeup_source_remove - Remove given object from the wakeup sources li=
st.
>   * @ws: Wakeup source object to remove from the list.
>   */
> -void wakeup_source_remove(struct wakeup_source *ws)
> +static void wakeup_source_remove(struct wakeup_source *ws)
>  {
>         unsigned long flags;
>
> @@ -204,7 +201,6 @@ void wakeup_source_remove(struct wakeup_source *ws)
>          */
>         ws->timer.function =3D NULL;
>  }
> -EXPORT_SYMBOL_GPL(wakeup_source_remove);
>
>  /**
>   * wakeup_source_register - Create wakeup source and add it to the list.
> diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
> index 51e0e8dd5f9e50d928db6efa2e3232a117d7e012..c838b4a30f876ef5a66972d16=
f461cfba9ff2814 100644
> --- a/include/linux/pm_wakeup.h
> +++ b/include/linux/pm_wakeup.h
> @@ -95,10 +95,6 @@ static inline void device_set_wakeup_path(struct devic=
e *dev)
>  }
>
>  /* drivers/base/power/wakeup.c */
> -extern struct wakeup_source *wakeup_source_create(const char *name);
> -extern void wakeup_source_destroy(struct wakeup_source *ws);
> -extern void wakeup_source_add(struct wakeup_source *ws);
> -extern void wakeup_source_remove(struct wakeup_source *ws);
>  extern struct wakeup_source *wakeup_source_register(struct device *dev,
>                                                     const char *name);
>  extern void wakeup_source_unregister(struct wakeup_source *ws);
> @@ -129,17 +125,6 @@ static inline bool device_can_wakeup(struct device *=
dev)
>         return dev->power.can_wakeup;
>  }
>
> -static inline struct wakeup_source *wakeup_source_create(const char *nam=
e)
> -{
> -       return NULL;
> -}
> -
> -static inline void wakeup_source_destroy(struct wakeup_source *ws) {}
> -
> -static inline void wakeup_source_add(struct wakeup_source *ws) {}
> -
> -static inline void wakeup_source_remove(struct wakeup_source *ws) {}
> -
>  static inline struct wakeup_source *wakeup_source_register(struct device=
 *dev,
>                                                            const char *na=
me)
>  {
>
> ---

Applied as 6.16 material with some edits in the subject and changelog, than=
ks!

