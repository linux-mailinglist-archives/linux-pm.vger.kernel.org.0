Return-Path: <linux-pm+bounces-34563-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9D7B5562F
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 20:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 567333A75E6
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 18:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99293302CB2;
	Fri, 12 Sep 2025 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kcgjsho7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA24B2264BB
	for <linux-pm@vger.kernel.org>; Fri, 12 Sep 2025 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757701808; cv=none; b=Qc+iiwSTyZSalIwuNQPK7yuLeS0wOFb9zNCm94mJWnIzkIYCA63jl4QQkWAxrU+wFiqh22uynqvfWv7VNoyxtG77qmsGymhgHajnygwcD1Dn4eD1EOEZmY0UMNJD7jWTScXhPDkQr3Sd08IcLPBBwwFRe3x9XVmZBB1dD+ajohU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757701808; c=relaxed/simple;
	bh=+IX8OUBo+6XzloxAZe7AlqdtVnVRNRI6i1SY6T2Sepc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lyWzZ2W1blZx4p4yJ7ZUYRHFrDObxE9VZMx60/h00v2SCtBth0/IZs0y+GxTR3vFMLebNcVyIEll+3M7SXzJLVYQcfLE2MtLQQcOYc4MXJrDbYEx3+BZ+iiv0NC+fusHBVSDr4OF4SQx0PUIiz5/JMTnTwVwVkoml5d8woSIYdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kcgjsho7; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-8988b982245so1070763241.1
        for <linux-pm@vger.kernel.org>; Fri, 12 Sep 2025 11:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757701806; x=1758306606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRevzUKnmamoxUQtNVHn3e2NLqtGP9Hi8zLLoZd4kwQ=;
        b=Kcgjsho7tH03tDGuMV5wa2Shz5m9czlmAcwe0ldBkO1YC9x+fheJk1Orp148g761Uv
         HhMyu0iZ/HEwrTyqq8qAL/W8R5dGY+0M8+zgRahxtxqWVw+zOZVVuy/qm+z39gRX0jgv
         pXnEEg2K5wbIqQXSXkvGlwnBzUUKHc5FJG88qcSrnP7wihJstbxjZF5KCIeRqpL+Bmeg
         qzgRT91SeEiBN9y0cdLLgCPbyEHOcp0llIDUEoi+E2oZDcGuOWANlMW2p9C56gq7wrGK
         vmo4p8q/kYTMZDxzB1V/7eFWCiBqIjzsAB9rbtJZJp9m6mfCeV0p6Npd9phW9/4aQ6Ba
         tA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757701806; x=1758306606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRevzUKnmamoxUQtNVHn3e2NLqtGP9Hi8zLLoZd4kwQ=;
        b=GAEZNgfR388poJw0bLOCO9skSppqyV1dtF9n6ZulxaJTO3Bc+FghX5WG1zHAo+Ed+s
         wRdUcswzmEw6zKozvbMPRY4TpBaigYdTu78pKKxdESJuktN6k6xPWVOPfj7V2OauFxVU
         n5Jv3wkHuV7X7tqJ0WEtiGF5R+qrwKbVI4BiYrS/EztxyadLQcO0Oe1eZbFJYe4QS/Rb
         8eFUY1JI4e8opsrwWOfbJNF3KrmephOelIL2fSVFarLy0teZXiLuIrvwqy9nMR4eGYin
         9CRvdxSejWO8AVGu2RUctnVHvxFX00+HRRZ6IBs/fQ7r1GvONR5tOuWKPkBwsg1iSVlQ
         wt0w==
X-Forwarded-Encrypted: i=1; AJvYcCVzHuSGkfK7MY/ox4sVVDgSgFZ7EUPvFtEr0zBjQ7wNFP4gZb1/T57zgTc0PBjrZMQZgwuhaZ8Vdg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8LapzV+gBX6d4waCAclr467L90UBFxf8EDc6S1C6J0eAMEYcT
	1lihHEWEd8t/A0FU7pj2OZIbUvTPbwnWKT9jPMWQpTgd2tMq+M8GCYQZKWtnLQhwzz9znxTyHfV
	yZlrqroNj/krnOGcoIRW0eG2A4MtFsIc9x0PZOLgc
X-Gm-Gg: ASbGncszR8E9HnN6MSk69+tUYS8D82YzfAeXhhnU8QEgDUsNPQWLZF1x58kWaHrSBBh
	T4I4yvh7R1a7KVywlvnTHH9yr5MevBs2mU47zC1kPa32kbvtV49P0wNlG/llnT4OI7TTMABFMmg
	T6gtjDAmLmTezSXd7qAa7braooai7XVHdLlwJCrv0Nh/Mt0Zf1ab040lQEMbPIOfgh26vWGTYq2
	w4rBssn7bdkR3NkCPBjnnA=
X-Google-Smtp-Source: AGHT+IHxsa+70uHWqJpGA1Rf1RQgQInzrnlKv38jo++DlHDxlcaEfPbXudoHo8pkOm2mFFUdmxC9MpI+uufU86ag8as=
X-Received: by 2002:a05:6102:441a:b0:536:7bfa:22bc with SMTP id
 ada2fe7eead31-55608e9ed8cmr1997283137.4.1757701805263; Fri, 12 Sep 2025
 11:30:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912143911.445452-1-treapking@chromium.org>
In-Reply-To: <20250912143911.445452-1-treapking@chromium.org>
From: Saravana Kannan <saravanak@google.com>
Date: Fri, 12 Sep 2025 11:29:27 -0700
X-Gm-Features: AS18NWBW3aCWBhJQCTV-8BCU8dkmnVAlT-JEQvndeTlARqf407TWPOkWdwyderI
Message-ID: <CAGETcx_bzjiLcQSXhCGM1gg2Xy=fgD2FPAdt3ZHDJmY357WnHg@mail.gmail.com>
Subject: Re: [PATCH v3] PM: sleep: Don't wait for SYNC_STATE_ONLY device links
To: Pin-yen Lin <treapking@chromium.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	linux-kernel@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>, 
	Hsin-Te Yuan <yuanhsinte@chromium.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 7:48=E2=80=AFAM Pin-yen Lin <treapking@chromium.org=
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

We've had SYNC_STATE_ONLY devlink for years in the kernel. Also,
SYNC_STATE_ONLY device links get deleted once the consumer device
probes. You also can't suspend a device before it probes.

Why are you hitting this issue only now? Something doesn't sound
right. I'm asking this because I'm wondering if some other recent
change broke any of my statements/design decisions above.

Not to fix this, but to also ensure better suspend/resume ordering in
the future, you might want to add a "post-init-suppliers" to the real
supplier node here and point it to the real consumer here. This will
also help break the cycle here. Because even with this fix, all it
does is avoid enforcing any ordering between these two devices. It is
just working based on the order in DT, which you shouldn't count on
for correctness.

Thanks,
Saravana

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
> 2.51.0.384.g4c02a37b29-goog
>

