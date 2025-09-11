Return-Path: <linux-pm+bounces-34465-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C73B532C2
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 14:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06609585AB9
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 12:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B58E322A08;
	Thu, 11 Sep 2025 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNlaDRcg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C7C32252A
	for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 12:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757595049; cv=none; b=bfxtAvbxm2/CKf4WWbQHO0vucQx1mOOR8Mzms6VOJrkIpfubjqWSAADXv0kGUlRJ6hYbQcyA7baVpqVkt0+YXa/E1DCvLtZScHETzQT/IYz9rOrlmXMtdW6Qvj5u3zsjecOjjbJ6Fh8z3vXoeOTGKXndNK8kQCsPCl7bg15zemw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757595049; c=relaxed/simple;
	bh=tJGoCAXqOzuddBjl4jN3Sc3VycflEXLnDPekZVtOt+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gLTEPO85S/OgjdZnxOsW6MvmBscdI/LlR2xGmUfStxwQ03H0a5r63AYh2W1Kyr9fAnQGLyn9YWIUbty3tcZcVs9unHXCg0PqAduJqwHsmQ4q8H1XqVesobnTyATe3eIhGop7WPGkyjJB2CSdPdXy9A/IHFRyDVV6Yx9nJTlRzFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNlaDRcg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8D1C4AF0B
	for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 12:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757595048;
	bh=tJGoCAXqOzuddBjl4jN3Sc3VycflEXLnDPekZVtOt+4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cNlaDRcgWbChNThLzsHJ0nSPSPwbSBoZs1iK1fDrhnZ/mROkqzmdcUkZdn5wTfWho
	 jpg0Nps06leWAHtJ1leacWlB9HcLbNgMvG9D1C7USUjSLyzbj2KoQi6PVyDGZ2mrHJ
	 a6DtEJzpmP+EfBr6ToU+qmYUcUelwjqg9fFXRRvNzGdkNydus1PLdDfpisQQu0X4LP
	 g5KXJQ5VNCfIrx14LcF8hBlXKHOlklrIpUD6n39Fzn7/Lm506FQ+Z3o5yMf3HiZW0u
	 YQT7UOTWycWQfWnSRiQheq1eUc2eW3r1gPPmHIvW1mec2dtAACms3tZgVETOiTsMiW
	 ouqN+ObMLMgBA==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-61e6ee53d2dso141249eaf.3
        for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 05:50:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVEfi4F4mSeKnZgQE2Ai8EYqkPVx7XW7Sj4URXT9/Mcdya7D3csN7biYwYb4xCyU/rNGja0MGUnww==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7UgydMlQ3wXq7e+B96VcBwmDV1D6pUXen235SIXupFKCRGfI8
	qcZfsOJNXqjFwQ5AP5B5epwxf+cIuWk4bSSdJJR38WAl4G5H4zwNHMX+F2/vsN+OYbKI/sTXHdh
	jE8HosOZmbgXEU9GMfUirlOElL8kulmo=
X-Google-Smtp-Source: AGHT+IHxJsKUfu0kNJmQcWf2p4gCIbzxH4/zmcLfjneUPJkQ11l+6BwO9/YIzjCoKy5wdYDt3DB/P7BJc9MXRsm29dE=
X-Received: by 2002:a05:6820:168d:b0:621:a8cc:3a6d with SMTP id
 006d021491bc7-621a8cc3fafmr2679459eaf.3.1757595048159; Thu, 11 Sep 2025
 05:50:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911112058.3610201-1-treapking@chromium.org>
In-Reply-To: <20250911112058.3610201-1-treapking@chromium.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 11 Sep 2025 14:50:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jMXzka7XgG7eXHOFntbSupHrhYvUsLP_YvDz10HpbMcQ@mail.gmail.com>
X-Gm-Features: Ac12FXy1al6eSJJVOZe39AB-nzoBqzW7cKPlPDQxDvKD9wP_zx2hUDROhAJfMXY
Message-ID: <CAJZ5v0jMXzka7XgG7eXHOFntbSupHrhYvUsLP_YvDz10HpbMcQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] driver core: Export device_link_flag_is_sync_state_only()
To: Pin-yen Lin <treapking@chromium.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Hsin-Te Yuan <yuanhsinte@chromium.org>, linux-pm@vger.kernel.org, 
	Chen-Yu Tsai <wenst@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 1:21=E2=80=AFPM Pin-yen Lin <treapking@chromium.org=
> wrote:
>
> Export device_link_flag_is_sync_state_only() for future patches.
>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
>
> ---
>
> Changes in v2:
> - New in v2
>
>  drivers/base/core.c    | 3 ++-
>  include/linux/device.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index d22d6b23e758..cc6af9b0d59d 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -287,10 +287,11 @@ static bool device_is_ancestor(struct device *dev, =
struct device *target)
>  #define DL_MARKER_FLAGS                (DL_FLAG_INFERRED | \
>                                  DL_FLAG_CYCLE | \
>                                  DL_FLAG_MANAGED)
> -static inline bool device_link_flag_is_sync_state_only(u32 flags)
> +bool device_link_flag_is_sync_state_only(u32 flags)
>  {
>         return (flags & ~DL_MARKER_FLAGS) =3D=3D DL_FLAG_SYNC_STATE_ONLY;
>  }
> +EXPORT_SYMBOL_GPL(device_link_flag_is_sync_state_only);

As Greg said, this isn't necessary.

>
>  /**
>   * device_is_dependent - Check if one device depends on another one
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 0470d19da7f2..e27d0bf7c43d 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1197,6 +1197,7 @@ const char *dev_driver_string(const struct device *=
dev);
>  struct device_link *device_link_add(struct device *consumer,
>                                     struct device *supplier, u32 flags);
>  void device_link_del(struct device_link *link);
> +bool device_link_flag_is_sync_state_only(u32 flags);

No, you only need it in drivers/base/base.h

>  void device_link_remove(void *consumer, struct device *supplier);
>  void device_links_supplier_sync_state_pause(void);
>  void device_links_supplier_sync_state_resume(void);
> --

