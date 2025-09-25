Return-Path: <linux-pm+bounces-35339-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B9CB9F8D1
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 15:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F06119C5E54
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 13:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8D9239E91;
	Thu, 25 Sep 2025 13:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lhP2s1oU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A00274FC2
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 13:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758806466; cv=none; b=RavzmWAtmzNmzHx7HVc8qz25wvg7LZyb4kEcDfISXh+CxqK2g9xdeWNc/pdN2/YnWwNoD0ixiABts7Gy0e9u4cbGojqhcv4nkl2Muhy9c1uB0B5euY6IK0fiH577ervkPnKDn537Q29Jr3CM0BIG8xj8avaymOhYicVakkbS/sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758806466; c=relaxed/simple;
	bh=tyrQdtC54KPwmXubmBZv1Sfqbp1p1MiwVKd043bXTNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQ8xoCTn1ZgNIQQGRZWwX39mnjz68lafkYBEOzc9UvTXZ6KfBzeFy6hbH0UmugiEP8PFxTz7gPiEkAxEEUS0oBmFfV3JSAc3xj/GqjrN7LF4Z0foAD9HZGfiGWmMBF1QApzslz8YIl9uDwbIgvYqr2QR7Z9P+RT+wAKxbRAGMvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lhP2s1oU; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-74f6974175dso13431287b3.3
        for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 06:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758806463; x=1759411263; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4VG4axCfxY2VruLkFskd43MY3X29CZllfJGqxG9KijI=;
        b=lhP2s1oUz3waXO/sajAnPLCUKMMZO13tNpHAMepg/b5giMPQ8SlO/4qMWWeDtv0c5z
         LthHYHaP/iFyHcVAKqbaMAEM/f+Q9XTcYZWZ/Ql5SApMP26QOeBWH5ArUuL2nPp+pm6Q
         NmSQ0W28pHcMcBKFhnlWNGY4cSDBNffcsGkQ7zKQMvca1povacH5k1H60Rjp2Wk69lQl
         dPEIAYxLW8bG63feWndm9TPkUh62UxgxXRLV0NvWnsLTu2IxuhtyyNw27iaM01eg6cEj
         kg5mghiA70VueqqqTJ1liKJuO8dPYp3dMjBkXz1kxE76obVdfVKtB58CY+9a/6jCzANp
         Z1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758806463; x=1759411263;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4VG4axCfxY2VruLkFskd43MY3X29CZllfJGqxG9KijI=;
        b=oKU3P3jbP3c9Ot5cspERwr8YeDbOEjTtN/yGpDdXjpajkp2JYVO1gUM4BbcJENv1aJ
         SVNN5gqHRsauYh44AC83WkrGgf5CKeuOu9/Y/jQvIiWzDnHUJo92jSEwzd4bUlQnn6ac
         IgjEx7lRJSaSbrJk9N7a6Yyt1xivwNSFYvbuNJWX5kzylB4K0Pe1hvXlC1bsHVVjcil6
         Jeq76mFEmvPWG8h152JPyRv1KdxCI5J1gC15viE0GZ1q899fETPdv9eNoXkysyA9TK4+
         6vywWJcAF6MCpXBZ9iVFFxhyJW5tgaL+kTAcEiY/W86hCgrqAVpeWi0EX1i42ctIpAb6
         371w==
X-Forwarded-Encrypted: i=1; AJvYcCXGs8NS9/W1FR2mguI9ZveEVbam+T/9/Imi1jbE4r9I1nYRN4xp+tvC5NACglJJNBudgG/6Y4og+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzL5MDF3VgTWj0PVtAIyXuUNx1pmRRhhe2X2sGroNugAqx7h1O9
	YpLJNf0dmtoKNcUt6cZKJ+qOjRtq2S3aRH27e19wDTkJP+6ybv6lxWMIwDOIJqYafJkFoIGLR7Z
	GadugKI/FXmoUC4o7YM0XLqsAxxru+O6Z+zMfoBaLBQ==
X-Gm-Gg: ASbGncu0gIURT839L1vTkrOHZZUk1DHrdMKbe6bcB77tB11fnv+v98AuEMYbImRK41C
	hfSWeO4cvx6IgkqI63XRarXlJI3dR0W1op/+Vk4qXpK7zhRrVPeju0K+4dCOmKuPTRc5Qv115QN
	gqnei0ZifuzH2Uzw3oCGsrdsFkD8HnpmSbb5PxkkhALnxpsJLe3YZHSkn57AxTK8+H/22p7dXC0
	kWovMXn
X-Google-Smtp-Source: AGHT+IGZF84EGEcJ4wcONA3NS9+OZ2xh3iimMrOT8Psj642ZRdZzPsML4L6NnKLHVd29XW7oN/nkEmvMCvQcCrnK/Q4=
X-Received: by 2002:a05:690e:1583:10b0:636:bd92:b253 with SMTP id
 956f58d0204a3-636bd92b7b2mr527783d50.53.1758806463094; Thu, 25 Sep 2025
 06:21:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925115924.188257-1-ulf.hansson@linaro.org> <55b41549-f5c4-4e83-ac1e-11dd068b1f5f@ideasonboard.com>
In-Reply-To: <55b41549-f5c4-4e83-ac1e-11dd068b1f5f@ideasonboard.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 25 Sep 2025 15:20:27 +0200
X-Gm-Features: AS18NWDgHhaPpJ-kJEdm5ZBKa_hqeUvNyG8N7Cy2NJLVKY_w8Ixa57gUB_BvF98
Message-ID: <CAPDyKFr3sXU4nXmQTH3+hfVN2P6nFVXRBPUgTPng1-j4m8+r6g@mail.gmail.com>
Subject: Re: [PATCH] driver core: fw_devlink: Don't warn in fw_devlink_dev_sync_state()
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Saravana Kannan <saravanak@google.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Heiko Stuebner <heiko@sntech.de>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Sebin Francis <sebin.francis@ti.com>, 
	Diederik de Haas <didi.debian@cknow.org>, Jon Hunter <jonathanh@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Sept 2025 at 14:08, Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
>
>
>
> On 25/09/2025 14:59, Ulf Hansson wrote:
> > Due to the wider deployment of the ->sync_state() support, for PM domains
> > for example, we are receiving reports about the messages that are being
> > logged in fw_devlink_dev_sync_state(). In particular as they are at the
> > warning level, which doesn't seem correct.
> >
> > Even if it certainly is useful to know that the ->sync_state() condition
> > could not be met, there may be nothing wrong with it. For example, a driver
> > may be built as module and are still waiting to be initialized/probed.
> >
> > Ideally these messages should be at the debug level, but since the
> > ->sync_state() feature is under an ongoing deployment and the prints
> > provides valuable information, let's move to the info level for now.
> >
> > Cc: Saravana Kannan <saravanak@google.com>
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Reported-by: Sebin Francis <sebin.francis@ti.com>
> > Reported-by: Diederik de Haas <didi.debian@cknow.org>
> > Reported-by: Jon Hunter <jonathanh@nvidia.com>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/base/core.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index d22d6b23e758..97eab79c2f3b 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -1784,7 +1784,7 @@ static int fw_devlink_dev_sync_state(struct device *dev, void *data)
> >               return 0;
> >
> >       if (fw_devlink_sync_state == FW_DEVLINK_SYNC_STATE_STRICT) {
> > -             dev_warn(sup, "sync_state() pending due to %s\n",
> > +             dev_info(sup, "sync_state() pending due to %s\n",
> >                        dev_name(link->consumer));
> >               return 0;
> >       }
> > @@ -1792,7 +1792,7 @@ static int fw_devlink_dev_sync_state(struct device *dev, void *data)
> >       if (!list_empty(&sup->links.defer_sync))
> >               return 0;
> >
> > -     dev_warn(sup, "Timed out. Forcing sync_state()\n");
> > +     dev_info(sup, "Timed out. Forcing sync_state()\n");
>
> I have no issue with this, but I also think that while the pending print
> above could well be dev_dbg, this one is perhaps a bit more warning-ish.
> It may be harmless to get the time-out, but it would be better not to
> time-out (i.e. everything was already sync_stated, or startup scripts
> handled forcing the sync state).

I agree. Perhaps we should consider moving the above "sync_state()
pending.." to dev_dbg at some later point, then we should probably
keep the "Timed out..." print at dev_info().

Anyway, I don't think using dev_warn makes sense, at least for
configurations with CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT being set.

>
> >       sup->state_synced = true;
> >       get_device(sup);
> >       list_add_tail(&sup->links.defer_sync, data);
>
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>
>  Tomi
>

Thanks for reviewing!

Kind regards
Uffe

