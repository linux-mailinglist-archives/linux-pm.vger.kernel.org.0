Return-Path: <linux-pm+bounces-34363-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC06B5179E
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 15:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D705E01C9
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 13:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB41730CD9C;
	Wed, 10 Sep 2025 13:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IylvfrZI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B178628C5D9;
	Wed, 10 Sep 2025 13:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757509754; cv=none; b=pnxVXxXAuhVbcMlRGcXEeL35JufnYendWYg5EmmheN6LN4F1MNWFPf99sIdANcBppoM4eGA/jNc8XjcBvc5AQ3hAxCIEfIOs5zkLzJNgRFPGNZ75Dd76dBfnvpndt7GES1ZL8jh6saCbY3YLNxe7FJju7l4c+nSAmX0iMe59y4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757509754; c=relaxed/simple;
	bh=uvhIjfKa8lTdjsCWUdtRVp8DWidoMVrr7CNRdvWoSv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=smaoVNczpgiY8OCk/Q+wtQZNwgjD3qsAfKgaKRY1H+WQbuWcUCgQtzfgat8j455Eit/xbsh4CefOPYEBKdTiDK+4lOnwSaeD3iQXbd1HAPqj8JFYWUgITvTUMFMKru3RE1pn/nfxOW2n088gUcqPruKy0Mt3B2KdR+dUeXvs660=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IylvfrZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E63C4CEF5;
	Wed, 10 Sep 2025 13:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757509753;
	bh=uvhIjfKa8lTdjsCWUdtRVp8DWidoMVrr7CNRdvWoSv4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IylvfrZID0skbH0951saMUSNs5tUaZUXV6nKzwW/Jh248IH9tvnGCcCl/+29Yhoni
	 QU1weGycrsJmtQWKm0gDIyx+1Vkkn8lr/eaWzV4LfFeejBQoVNK8Ix7w57Qff3Y/TO
	 IlF08MaRklC4m7xV2nprFgF9hz/TriQMfplQwpth4RBtWysVRoW/+GiCPtPA+YRWKi
	 wU8cpEOVyPGmxLk2hAo18WYDbwdIs3itKvsEFljtaUgWGlNMg1ikwTaXToQ1J5wH8D
	 Vaoti+el6/GWat9XFGRx59ausx7ymwijgxqkBKbRbM39xFVsP/dntU1xszO69/Y34L
	 tSC28Z26UaUog==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6219257cb0fso638758eaf.2;
        Wed, 10 Sep 2025 06:09:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVdV9l8wIf+wT69aQsofBrmYN9CxEtulGTUyIIE7lbj3tgbLkAq+GttY6/FLBoG7asnT6vbeKY9LORFxRg=@vger.kernel.org, AJvYcCXjKCNYLEZRaa4kbSOYTecKxCFevZ/4WHygzIkINlGA5/lMHMzD4WlEtdKE2K826GO9iAMvDaAmBPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4og7rFLQpirAT8ApmtVVXsj0CxMQOkLE1phGV82t8+O7pXFEa
	WXGCgaxF2KeZUWKfRRbuCVopYlrwPbrLxuXdfrrQR11l06jCRn96Sbx7SL5Ww9EcC1q6g2jsYh8
	CibXQZSlIxa4veLXcwQnlEOEzlB5PM2M=
X-Google-Smtp-Source: AGHT+IEV1+Zwr1jjsISpN+i6rFKuCoD11ljywxpczs93aLgS8TuxE6wRy0V56lCleUm3bASPQVStW/q4JsAlGKHeigo=
X-Received: by 2002:a05:6820:300b:b0:621:858a:ee1c with SMTP id
 006d021491bc7-621858af1dcmr4630740eaf.7.1757509752556; Wed, 10 Sep 2025
 06:09:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909094335.1097103-1-treapking@chromium.org>
 <CAJZ5v0jNytfP8W2XSyBNLe8OsD=O9M7WWvhtxdwXA-5KxwKfbg@mail.gmail.com> <CAEXTbpd6k=_yF4vG-zU4C0ymriLYXcT4AusCFJ03wZWJecOS5w@mail.gmail.com>
In-Reply-To: <CAEXTbpd6k=_yF4vG-zU4C0ymriLYXcT4AusCFJ03wZWJecOS5w@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 10 Sep 2025 15:09:00 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gEeVraqck8q_Ave66RMLOSC=p8=33PaBCKsMBuHGLqKA@mail.gmail.com>
X-Gm-Features: Ac12FXy5-Dk5URgq2Yqz1iZj-3bn-vzI4RcpJwBsUOcnWoqt9zJj1y4WXjCk0Y0
Message-ID: <CAJZ5v0gEeVraqck8q_Ave66RMLOSC=p8=33PaBCKsMBuHGLqKA@mail.gmail.com>
Subject: Re: [PATCH] PM: sleep: Don't wait for SYNC_STATE_ONLY device links
To: Pin-yen Lin <treapking@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Hsin-Te Yuan <yuanhsinte@chromium.org>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Chen-Yu Tsai <wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 10, 2025 at 2:43=E2=80=AFPM Pin-yen Lin <treapking@chromium.org=
> wrote:
>
> Hi Rafael,
>
> Thanks for the review.
>
> On Wed, Sep 10, 2025 at 7:56=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Tue, Sep 9, 2025 at 11:44=E2=80=AFAM Pin-yen Lin <treapking@chromium=
.org> wrote:
> > >
> > > Device links with DL_FLAG_SYNC_STATE_ONLY should not affect suspend
> > > and resume, and functions like device_reorder_to_tail() and
> > > device_link_add() doesn't try to reorder the consumers with such flag=
.
> > >
> > > However, dpm_wait_for_consumers() and dpm_wait_for_suppliers() doesn'=
t
> > > check this flag before triggering dpm_wait, leading to potential hang
> > > during suspend/resume.
> >
> > Have you seen this happen or is it just a theory?
>
> We initially see this with a downstream kernel, but I can reproduce
> this with the upstream kernel when I connect the usb host controller
> to a "usb-a-connector" node on MT8186 Corsola Chromebook. The
> devicetree looks like:
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
> In this case, the two nodes form a cycle and I ended up seeing a
> SYNC_STATE_ONLY devlink from usb_host (supplier) to the
> usb-a-connector (consumer).

It would be good to add the above information to the patch changelog.

> I'm not very sure why we didn't see this issue before. Maybe it's
> related to the fact that the usb-a-connector has a compatible string
> (so a platform device is created) but no driver binds into it.
> >
> > > Add DL_FLAG_SYNC_STATE_ONLY in dpm_wait_for_consumers() and
> > > dpm_wait_for_suppliers() to fix this.
> >
> > The above sentence is incomplete AFAICS.
>
> Sorry, I meant "Add a check for DL_FLAG_SYNC_STATE_ONLY in ...". I'll
> update this in the next version.
> >
> > > Fixes: 05ef983e0d65a ("driver core: Add device link support for SYNC_=
STATE_ONLY flag")
> > > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> > > ---
> > >
> > >  drivers/base/power/main.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > > index 2ea6e05e6ec90..3271f4af2cb65 100644
> > > --- a/drivers/base/power/main.c
> > > +++ b/drivers/base/power/main.c
> > > @@ -282,7 +282,8 @@ static void dpm_wait_for_suppliers(struct device =
*dev, bool async)
> > >          * walking.
> > >          */
> > >         list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c=
_node)
> > > -               if (READ_ONCE(link->status) !=3D DL_STATE_DORMANT)
> > > +               if (READ_ONCE(link->status) !=3D DL_STATE_DORMANT &&
> > > +                   !device_link_test(link, DL_FLAG_SYNC_STATE_ONLY))
> >
> > This should use a check like device_link_flag_is_sync_state_only(),
> > which is different from the above one, for consistency with
> > device_reorder_to_tail().
>
> Thanks. I'll fix this in the next version.

Thanks!

