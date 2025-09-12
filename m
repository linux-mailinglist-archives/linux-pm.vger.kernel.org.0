Return-Path: <linux-pm+bounces-34558-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D06B553F2
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 17:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C120AE49F8
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 15:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFF53148CD;
	Fri, 12 Sep 2025 15:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loqlrzm7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0AE31355A
	for <linux-pm@vger.kernel.org>; Fri, 12 Sep 2025 15:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691717; cv=none; b=NtPVMFx9Bm//VeYcZk2CRAjwzu3uKegybCmtR98QQlkG3NKJ1eG+kl2M7LBWH1VRt/2In7tvAAmhwc2EcX50BhH7tM1z1yFgpDcOHqybIW8RaSHdRIN4MwyROqMN9uX4JKfzJZo7cDrfVE+N6P3D8ncG/iMsXZzo8ZC9rdQ/i7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691717; c=relaxed/simple;
	bh=xaNxOz8PpRoJsBiwNzq6np5qaZr6fMf29QZLIfRMA9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ATsZVaT11k2vam5nagSWYB3r3NmYfVzsMyi11JSbHgGxRTWKxoEMRlNQjipDtJsQMuYyKmWX8/jeH4mIolhNGjToGNDlGtveJQjoeVdZhI4MvNOIpEUpvjIdTdmitw+mqnnAvTS1ukKjzEiBJ95XPNuHlOXbard/EVbGIcfngMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loqlrzm7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFA8C4CEFC
	for <linux-pm@vger.kernel.org>; Fri, 12 Sep 2025 15:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757691717;
	bh=xaNxOz8PpRoJsBiwNzq6np5qaZr6fMf29QZLIfRMA9c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=loqlrzm7mhX5VLGM1I/V23bIss4NMjxivIM1Pe/KetcE+ZNIGKeM229Am1/KQpKq1
	 +ojvwHnukCi0xNeVNhm8VQzwGy8GV+B5p5uykCzzerOs3JeLGxcu6guGhYP78k86aD
	 FV0sADN9IAMcIYiah6K6/k8CKMTf27P2fDxjxZfHnfq7+gOPbDCccTfN0UEiHc4wMA
	 KWsveaGtIK/MDczqNqCBMKWuKkwvNJXWIMINpMgAcunBd/767UQpOJQh1CWWn35VV2
	 Ov0yV7eynJZ2JFKSjq0SAubtVBUw3a/vnBeCaObpXdzNJEcW/ForOkyoeR29k1viIk
	 sXFE9Bo6T6dFA==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-74526ca7a46so789409a34.2
        for <linux-pm@vger.kernel.org>; Fri, 12 Sep 2025 08:41:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWCPquOmVj5/ZUAqwYldgtAsP7jJVP+g14uqhJowpo+88gqanzDQCE2LVtSjC6ncpBgtyaSXOAoZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWTW2lPicYvxbf/6ffQ3oV6qjuWMuVH81MkYTcdXHWdsthRyo9
	RFd/r569IZNCpyqZQ2jbTfJnVLPnRIDN9+/lErCqJLhBhMDmR4RjfqO5xjEk3wbTNUB8Pp6nPBj
	CETI7vyjoBUTxaXy8bg0hE6FvTPrKuU8=
X-Google-Smtp-Source: AGHT+IFao+0n9VhP1TgaekmXW8hMhWul3FdzoJr8ELpCN+EfQ8mjGZKwxryOG5D/jOAgrq6i8xh9ivqZmhUG7wth9yo=
X-Received: by 2002:a05:6830:6381:b0:745:a41d:22c8 with SMTP id
 46e09a7af769-7535307ff40mr1572194a34.1.1757691716611; Fri, 12 Sep 2025
 08:41:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912143911.445452-1-treapking@chromium.org>
In-Reply-To: <20250912143911.445452-1-treapking@chromium.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 12 Sep 2025 17:41:45 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iPCt6O4QcFC1BDVtH-zP7g53ngiR3fsd9DNQjejkqj8A@mail.gmail.com>
X-Gm-Features: Ac12FXy6DLpkm-g9FjMyqzHl2A9nDoRhhBdeTn1C5Wed2hiV1oEyDtx_hnUtxNw
Message-ID: <CAJZ5v0iPCt6O4QcFC1BDVtH-zP7g53ngiR3fsd9DNQjejkqj8A@mail.gmail.com>
Subject: Re: [PATCH v3] PM: sleep: Don't wait for SYNC_STATE_ONLY device links
To: Pin-yen Lin <treapking@chromium.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, linux-kernel@vger.kernel.org, 
	Chen-Yu Tsai <wenst@chromium.org>, Hsin-Te Yuan <yuanhsinte@chromium.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 4:48=E2=80=AFPM Pin-yen Lin <treapking@chromium.org=
> wrote:
>
> Device links with DL_FLAG_SYNC_STATE_ONLY should not affect suspend
> and resume, and functions like device_reorder_to_tail() and
> device_link_add() doesn't try to reorder the consumers with such flag.
>
> However, dpm_wait_for_consumers() and dpm_wait_for_suppliers() doesn't
> check this flag before triggering dpm_wait, leading to potential hang
> during suspend/resume.
>
> This can be reproduced on MT8186 Corsola Chromebook with devicetree like:
>
> usb-a-connector {
>         compatible =3D "usb-a-connector";
>         port {
>                 usb_a_con: endpoint {
>                         remote-endpoint =3D <&usb_hs>;
>                 };
>         };
> };
>
> usb_host {
>         compatible =3D "mediatek,mt8186-xhci", "mediatek,mtk-xhci";
>         port {
>                 usb_hs: endpoint {
>                         remote-endpoint =3D <&usb_a_con>;
>                 };
>         };
> };
>
> In this case, the two nodes form a cycle and a SYNC_STATE_ONLY devlink
> between usb_host (supplier) and usb-a-connector (consumer) is created.
>
> Export device_link_flag_is_sync_state_only() and use it to check this in
> dpm_wait_for_consumers() and dpm_wait_for_suppliers() to fix this.
>
> Fixes: 05ef983e0d65a ("driver core: Add device link support for SYNC_STAT=
E_ONLY flag")
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> ---
>
> Changes in v3:
> - Squash to one patch and fix the export approach
>
> Changes in v2:
> - Update commit message
> - Use device_link_flag_is_sync_state_only()
>
>  drivers/base/base.h       | 1 +
>  drivers/base/core.c       | 2 +-
>  drivers/base/power/main.c | 6 ++++--
>  3 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 123031a757d9..80415b140ce7 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -248,6 +248,7 @@ void device_links_driver_cleanup(struct device *dev);
>  void device_links_no_driver(struct device *dev);
>  bool device_links_busy(struct device *dev);
>  void device_links_unbind_consumers(struct device *dev);
> +bool device_link_flag_is_sync_state_only(u32 flags);
>  void fw_devlink_drivers_done(void);
>  void fw_devlink_probing_done(void);
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index d22d6b23e758..741aa0571fc7 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -287,7 +287,7 @@ static bool device_is_ancestor(struct device *dev, st=
ruct device *target)
>  #define DL_MARKER_FLAGS                (DL_FLAG_INFERRED | \
>                                  DL_FLAG_CYCLE | \
>                                  DL_FLAG_MANAGED)
> -static inline bool device_link_flag_is_sync_state_only(u32 flags)
> +inline bool device_link_flag_is_sync_state_only(u32 flags)

We generally don't use inline without static.  Let the compiler decide
what to do with it.

>  {
>         return (flags & ~DL_MARKER_FLAGS) =3D=3D DL_FLAG_SYNC_STATE_ONLY;
>  }
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 2ea6e05e6ec9..73a1916170ae 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -282,7 +282,8 @@ static void dpm_wait_for_suppliers(struct device *dev=
, bool async)
>          * walking.
>          */
>         list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_nod=
e)
> -               if (READ_ONCE(link->status) !=3D DL_STATE_DORMANT)
> +               if (READ_ONCE(link->status) !=3D DL_STATE_DORMANT &&
> +                   !device_link_flag_is_sync_state_only(link->flags))
>                         dpm_wait(link->supplier, async);
>
>         device_links_read_unlock(idx);
> @@ -339,7 +340,8 @@ static void dpm_wait_for_consumers(struct device *dev=
, bool async)
>          * unregistration).
>          */
>         list_for_each_entry_rcu_locked(link, &dev->links.consumers, s_nod=
e)
> -               if (READ_ONCE(link->status) !=3D DL_STATE_DORMANT)
> +               if (READ_ONCE(link->status) !=3D DL_STATE_DORMANT &&
> +                   !device_link_flag_is_sync_state_only(link->flags))
>                         dpm_wait(link->consumer, async);
>
>         device_links_read_unlock(idx);
> --

