Return-Path: <linux-pm+bounces-34464-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F51B532B1
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 14:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC9981C88270
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 12:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545DA32143B;
	Thu, 11 Sep 2025 12:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulLDjnv5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA43243367
	for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 12:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757594962; cv=none; b=Ggz+T5qP99ihZnQVAZqzkL02FFf2kNwoxkE3nL3fKn2yak+FUYCDD4thMruuCkncJitkI/ozY+9+oSggIs8b6nZfttlZfaWMYqUk5cC7Tcng7A/cj0XzJOFAdWW+IU27o5UuW36GThHpAwGhrHOMHiM0PQEZ4uIaknRhkDW/rkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757594962; c=relaxed/simple;
	bh=C+IX8JQ2COSyVo9kw+3dxUx1yrGzrT5oSKuWeoymk8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q7uXgnxspzI/bb5DUES41vnA7LPpjjrndO7E4tv8WofAdDbiHc8TF8bSbiBt61K5jm5cBIaMiWmpWPSnwJUON0uvXn8YfRrtQGMDmYbMfGZrRqQEMX2WpR+wzXVVJ6BWoIWyloAu42ocCTSqwn2isTnADqNa20zeAW7ay9t3bA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulLDjnv5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCCCAC4CEFA
	for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 12:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757594961;
	bh=C+IX8JQ2COSyVo9kw+3dxUx1yrGzrT5oSKuWeoymk8w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ulLDjnv5s2w9RYBclhdpuAJs1GHrigt0gpobBci4xdrs4EHC4pxSZCOllmlQm4mBS
	 yDvmp+YtntA81dcy0Gv5W+AGWq5/gVY2aGMVYgyz53L8nNQqElh/flXj/+jS6Md9N6
	 /u8quAjxDpOCr9Jk6CMnb+2034puv+gRX3GygubXjQ7j9V9l3yU8kncP1g+uZPr28Q
	 cYyS9Hlm4jIqcyyOvytMfmCiLYgXIOSAVJLXqQrW9DH1roATZLVNDCuJ0Aw+7V90B4
	 Gb1LxaYzzE4jmNpZJ7aWPyHb695KyLaiHl4Qv42mbgfXr8Ncp6nPWvru3QQRW4T45R
	 Eohs1uRziz8Rg==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-62189987b54so363405eaf.3
        for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 05:49:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXMHH3Fhx//8xVCc9cmbquYMpERqJKa4cTtBLHFepCGOnjUjsIEL6TFiUHQRF7sZhXj+Zkq2R+Cog==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1PDzAfuVUJntX08s6TSUt8jy/T7KjShu08ZPdfGEWgmuouE8b
	SspmGGcCG2vvtsLdxZVWww6m+efWu3Uawevkd8GTgc1EiuV1TDGdVg9YXKSK7zfrL4wYDZQYHjl
	Joh5iyJINnfzvGC5QmVx7gEBa+RAaJI0=
X-Google-Smtp-Source: AGHT+IE0SZNhbg9/joMdRy/snswIByXzzTetPcERXhI96bVCxl0PqbwsRuWEUn2JI5L4Xv306WxjljMtTRct025/xTs=
X-Received: by 2002:a05:6820:515:b0:621:9802:d190 with SMTP id
 006d021491bc7-6219802d300mr5397523eaf.7.1757594961098; Thu, 11 Sep 2025
 05:49:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911112058.3610201-1-treapking@chromium.org>
 <20250911112058.3610201-2-treapking@chromium.org> <2025091129-harmonics-clambake-6240@gregkh>
In-Reply-To: <2025091129-harmonics-clambake-6240@gregkh>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 11 Sep 2025 14:49:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0incdNCxt=0AAdtbsBVdazZMCWG=15PUAnnpz8Rvr=psg@mail.gmail.com>
X-Gm-Features: Ac12FXyGERKfjrx2iuB_mbuxwFyy1_UKlI57GpG116b6xucqLEYqrQVyDeENyJw
Message-ID: <CAJZ5v0incdNCxt=0AAdtbsBVdazZMCWG=15PUAnnpz8Rvr=psg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] PM: sleep: Don't wait for SYNC_STATE_ONLY device links
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pin-yen Lin <treapking@chromium.org>
Cc: Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Hsin-Te Yuan <yuanhsinte@chromium.org>, linux-pm@vger.kernel.org, 
	Chen-Yu Tsai <wenst@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 2:28=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Sep 11, 2025 at 07:16:03PM +0800, Pin-yen Lin wrote:
> > Device links with DL_FLAG_SYNC_STATE_ONLY should not affect suspend
> > and resume, and functions like device_reorder_to_tail() and
> > device_link_add() doesn't try to reorder the consumers with such flag.
> >
> > However, dpm_wait_for_consumers() and dpm_wait_for_suppliers() doesn't
> > check this flag before triggering dpm_wait, leading to potential hang
> > during suspend/resume.
> >
> > This can be reproduced on MT8186 Corsola Chromebook with devicetree lik=
e:
> >
> > usb-a-connector {
> >         compatible =3D "usb-a-connector";
> >         port {
> >                 usb_a_con: endpoint {
> >                         remote-endpoint =3D <&usb_hs>;
> >                 };
> >         };
> > };
> >
> > usb_host {
> >         compatible =3D "mediatek,mt8186-xhci", "mediatek,mtk-xhci";
> >         port {
> >                 usb_hs: endpoint {
> >                         remote-endpoint =3D <&usb_a_con>;
> >                 };
> >         };
> > };
> >
> > In this case, the two nodes form a cycle and a SYNC_STATE_ONLY devlink
> > between usb_host (supplier) and usb-a-connector (consumer) is created.
> >
> > Use device_link_flag_is_sync_state_only() to check this in
> > dpm_wait_for_consumers() and dpm_wait_for_suppliers() to fix this.
> >
> > Fixes: 05ef983e0d65a ("driver core: Add device link support for SYNC_ST=
ATE_ONLY flag")
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Update commit message
> > - Use device_link_flag_is_sync_state_only()
> >
> >  drivers/base/power/main.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > index 2ea6e05e6ec9..73a1916170ae 100644
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -282,7 +282,8 @@ static void dpm_wait_for_suppliers(struct device *d=
ev, bool async)
> >        * walking.
> >        */
> >       list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_nod=
e)
> > -             if (READ_ONCE(link->status) !=3D DL_STATE_DORMANT)
> > +             if (READ_ONCE(link->status) !=3D DL_STATE_DORMANT &&
> > +                 !device_link_flag_is_sync_state_only(link->flags))
> >                       dpm_wait(link->supplier, async);
> >
> >       device_links_read_unlock(idx);
> > @@ -339,7 +340,8 @@ static void dpm_wait_for_consumers(struct device *d=
ev, bool async)
> >        * unregistration).
> >        */
> >       list_for_each_entry_rcu_locked(link, &dev->links.consumers, s_nod=
e)
> > -             if (READ_ONCE(link->status) !=3D DL_STATE_DORMANT)
> > +             if (READ_ONCE(link->status) !=3D DL_STATE_DORMANT &&
> > +                 !device_link_flag_is_sync_state_only(link->flags))
> >                       dpm_wait(link->consumer, async);
> >
> >       device_links_read_unlock(idx);
>
> The way you use this new function does not require it to have been
> exported to modules :(

Also, I'd just make it non-static (without exporting it to modules)
and use it in the same patch because the new usage is the reason for
exporting.

