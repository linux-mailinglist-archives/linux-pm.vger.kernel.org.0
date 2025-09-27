Return-Path: <linux-pm+bounces-35504-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA83BA5EAB
	for <lists+linux-pm@lfdr.de>; Sat, 27 Sep 2025 14:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CB27189CF34
	for <lists+linux-pm@lfdr.de>; Sat, 27 Sep 2025 12:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80732DF703;
	Sat, 27 Sep 2025 12:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzWCTtg6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934302DF6E6
	for <linux-pm@vger.kernel.org>; Sat, 27 Sep 2025 12:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758975185; cv=none; b=j+xSi1rjEufyEeeiZUalkgyljZbuBpKDqRiztVV28IyqbR1+mvNkqdMdfIxzprrrKs1JzSoDyTuPxbi61TqRInOdH0mDZMHPAm5UyIUfkMK6lUID+Oi98cq7rLopHe7aJbONk5dr4vmSLfH/1Z3GUe2c9erDJMpHag2w3JNgBJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758975185; c=relaxed/simple;
	bh=TwUpSH1ghbN4SooWUY3F97DHQwyPglI2P8bUTlUvZ8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJsbLn/8GazABao/ZuBZN9QT2TdrKIJCzyC++org0UzHrn2J0XHArZnD/k+EN6C3gzK+oaSsNkvo+dRKFL+Pov3/2StIpGA9VV36vpa6xfWejXDMMYSZ2Tl3/ENar8uA0aeywg+fogm1HluB7VatuuLpnWoq2ds9RsUdGaIyvIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzWCTtg6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AEC3C116D0
	for <linux-pm@vger.kernel.org>; Sat, 27 Sep 2025 12:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758975185;
	bh=TwUpSH1ghbN4SooWUY3F97DHQwyPglI2P8bUTlUvZ8c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LzWCTtg6SrncrQJJ/dO2n8mWZnIp2ge5bWfU6wm3Kjvaa5gu/ZOHdu2/hRqqsWPtm
	 w2YpixIF6bh9vrfTH8BZ3oLWvdNt5kJ3yAJB1L+bNDQXzBuW3GWZDszwAuPyYX4JXc
	 xL4oM7xU7wwPkvwdr10F0GEGl3HdSeCMb5I9xAIG79rjQHUETdWTWjE749xcpI4DYU
	 Ho5KbjC5GZzNN0LTAVG9HEWpdXI/DgzNWEdNGGGSjPrEZhTs7Gurmq++1jIM/93gdP
	 HcTGRrhGDzxOgnlE1dTQaxfXbBAcK6nCUHfT1bep4l2WWLQbIFXkmnXz/EZ6nWN0Lt
	 9Wbj//Lse+MPA==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-30ccec59b4bso3002141fac.3
        for <linux-pm@vger.kernel.org>; Sat, 27 Sep 2025 05:13:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVcc3O00MBRr2webJGDbFRBJeviNDoAPVO1n/s0FQiwjSS++sOjdOF6SfRm/hnAw1GgOyL7Qq3ZTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQV/dKJ+cbJrfNmdelGRZGbf4U5KhNcjtbuu0fTMpGWzE1rB2Z
	dY/qogwP/K589GGz1iEeBfKDLu3qgNiqjtGw7U8Q5wt+lt7gmUJGiHIRuqk/OApyKnDJ+ZIjsVH
	tKdQ2jQPxKFslMBZ9gM8ftWAKjAhHL3M=
X-Google-Smtp-Source: AGHT+IHoRKUqke8mSmvJOXv9uDQLt0pk9IzOzuSpzXFsfE/+P4NaWq3F/DDodzLSz0UCqlVPTleKEaiS4Ix70Ff81/o=
X-Received: by 2002:a05:6871:ea8b:b0:372:b8a4:791a with SMTP id
 586e51a60fabf-372b8a47a83mr2670184fac.21.1758975184446; Sat, 27 Sep 2025
 05:13:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926102320.4053167-1-treapking@chromium.org>
In-Reply-To: <20250926102320.4053167-1-treapking@chromium.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 27 Sep 2025 14:12:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i-iT-3nEjX7Nm2s91GSm0OTXQ3yZSf2Q3VRNTOseREHw@mail.gmail.com>
X-Gm-Features: AS18NWB34zB3BLqh9BZedb-rR5nsbi_3-vkJmooiDwdwhYQb4UqYJVwDBhe2Ypo
Message-ID: <CAJZ5v0i-iT-3nEjX7Nm2s91GSm0OTXQ3yZSf2Q3VRNTOseREHw@mail.gmail.com>
Subject: Re: [PATCH v4] PM: sleep: Don't wait for SYNC_STATE_ONLY device links
To: Pin-yen Lin <treapking@chromium.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, linux-kernel@vger.kernel.org, 
	Hsin-Te Yuan <yuanhsinte@chromium.org>, Chen-Yu Tsai <wenst@chromium.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 12:23=E2=80=AFPM Pin-yen Lin <treapking@chromium.or=
g> wrote:
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
> Changes in v4:
> - Remove inline for device_link_flag_is_sync_state_only()
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
> index d22d6b23e758..a54ec6df1058 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -287,7 +287,7 @@ static bool device_is_ancestor(struct device *dev, st=
ruct device *target)
>  #define DL_MARKER_FLAGS                (DL_FLAG_INFERRED | \
>                                  DL_FLAG_CYCLE | \
>                                  DL_FLAG_MANAGED)
> -static inline bool device_link_flag_is_sync_state_only(u32 flags)
> +bool device_link_flag_is_sync_state_only(u32 flags)
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

Rebased on top of linux-pm.git/linux-next and applied as 6.18 material
with some minor edits in the subject and changelog.

Thanks!

