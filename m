Return-Path: <linux-pm+bounces-35621-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44359BAFDD9
	for <lists+linux-pm@lfdr.de>; Wed, 01 Oct 2025 11:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2A153B331D
	for <lists+linux-pm@lfdr.de>; Wed,  1 Oct 2025 09:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990592737FD;
	Wed,  1 Oct 2025 09:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VD+hvNvR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A5E1F9F7A
	for <linux-pm@vger.kernel.org>; Wed,  1 Oct 2025 09:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759311043; cv=none; b=R2fLAemXxV+Oka/xeUAUJyYqrtyc/9thfsB1QyOZCJ3VDTlmwTe9SgbnEzVvno8Ew7CMijDa0V2ry/IuoAxxTP5ktYkQe311A6183jP6mdiGFY8c35c6Gw0fcmmfNxBrO5KEX1G/BGOCkQA0ySf24EUb00y9lGQwZzCHTosT4Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759311043; c=relaxed/simple;
	bh=SDnfVM3ubQYBlLvGAuhTvc+aBP5kwXyNhNvMC6/5rII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J1SqACYrIjFtLibpahKKN1VyYa1z0ZbeVTQdyqkSirHxMHJCuX55UJpx30DNCUIlmagSWzu153mjV+xaDiOh/1CepgnXgniuUsfuEcp+utLJEYsffKsll4cBsFdExSbFYgcBylhZ8DnrWLeDYLmoqBcphsavPz2qdQSZhpOzGoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VD+hvNvR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF81C19421
	for <linux-pm@vger.kernel.org>; Wed,  1 Oct 2025 09:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759311043;
	bh=SDnfVM3ubQYBlLvGAuhTvc+aBP5kwXyNhNvMC6/5rII=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VD+hvNvR5lVR8OAgW5XMRwuEYufegwavcNqmmXUU8MmMj3ZQVI2rS9KK2TKRVZOzp
	 8oGvj5/vhZgTVekJ4Ac60Z2soVHV2m9ZtJ1U7hIlrj4tdA+DwPIu6Dp0P2WLd7CmX5
	 34/ex68pgQ1tGI69bglVSafCoOzO3eJJBST3xcaTYgjm0+50HUuDItAmr9M49SGA3g
	 unNzycvkeWagMaWHsFDWxIr/boJ8xZikqaLGelBas0dsCBx64MzEWIKb0ezWii16at
	 0SKIrXFLc3AAXQkm3BMVgn5o5u72akcJ1rfbH1NnWKMJW7GjmVAYBt/d8k743vv0ag
	 TaYH0HVg714qQ==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-30cce5be7d0so2986487fac.0
        for <linux-pm@vger.kernel.org>; Wed, 01 Oct 2025 02:30:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUWMk/v8DLSBORQt/mYAZpSE22DNLqVTY7rI2oHNokWgtXqUZhctENGrXXs+JWd7rTycuisvVOj+w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2rU/qIyJLN/WS5kgW9fmCXLhr2wUwjaeccHisrY2KFvKTsHmz
	sKnpUkHrCh1cGMsEaJiYB5LaIh8jZ88k9ecmrY91pdPQsF1+6+w/5ebvBZQX4e3QOIOb0MteaDN
	tlDEAYnwUzce2KCIBjprJpvnOPIi0/6Q=
X-Google-Smtp-Source: AGHT+IFMq6gPIM8p2T5XZpW4CClVk3+8KJLeY5qho96aUc03KRZOpsIj5FDWDPo1KqM47wypNBQ0TV6LKrn1U7P55u0=
X-Received: by 2002:a05:6870:2056:b0:332:598e:e7b9 with SMTP id
 586e51a60fabf-39bb3c3ed3emr1390973fac.46.1759311042347; Wed, 01 Oct 2025
 02:30:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926102320.4053167-1-treapking@chromium.org>
 <CAJZ5v0i-iT-3nEjX7Nm2s91GSm0OTXQ3yZSf2Q3VRNTOseREHw@mail.gmail.com> <CAEXTbpfUEDf_L3wVJEwD=Wjhx05X6Z2F-rbZT5L7vUR8GUAWTQ@mail.gmail.com>
In-Reply-To: <CAEXTbpfUEDf_L3wVJEwD=Wjhx05X6Z2F-rbZT5L7vUR8GUAWTQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 1 Oct 2025 11:30:30 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hgOxOFA+LBNm+n3BVhuJOYD4F5LBj2BQA7fwLDAtcD=g@mail.gmail.com>
X-Gm-Features: AS18NWD5MXCZLHGjgbPUqgbKk5Xv_nA5WrnUDJcqS3Pi5ZCufO045FcJZrPL8cE
Message-ID: <CAJZ5v0hgOxOFA+LBNm+n3BVhuJOYD4F5LBj2BQA7fwLDAtcD=g@mail.gmail.com>
Subject: Re: [PATCH v4] PM: sleep: Don't wait for SYNC_STATE_ONLY device links
To: Pin-yen Lin <treapking@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, linux-kernel@vger.kernel.org, 
	Hsin-Te Yuan <yuanhsinte@chromium.org>, Chen-Yu Tsai <wenst@chromium.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 1, 2025 at 1:08=E2=80=AFAM Pin-yen Lin <treapking@chromium.org>=
 wrote:
>
> Hi Rafael,
>
> On Sat, Sep 27, 2025 at 8:13=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Fri, Sep 26, 2025 at 12:23=E2=80=AFPM Pin-yen Lin <treapking@chromiu=
m.org> wrote:
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
> > >
> > > This can be reproduced on MT8186 Corsola Chromebook with devicetree l=
ike:
> > >
> > > usb-a-connector {
> > >         compatible =3D "usb-a-connector";
> > >         port {
> > >                 usb_a_con: endpoint {
> > >                         remote-endpoint =3D <&usb_hs>;
> > >                 };
> > >         };
> > > };
> > >
> > > usb_host {
> > >         compatible =3D "mediatek,mt8186-xhci", "mediatek,mtk-xhci";
> > >         port {
> > >                 usb_hs: endpoint {
> > >                         remote-endpoint =3D <&usb_a_con>;
> > >                 };
> > >         };
> > > };
> > >
> > > In this case, the two nodes form a cycle and a SYNC_STATE_ONLY devlin=
k
> > > between usb_host (supplier) and usb-a-connector (consumer) is created=
.
> > >
> > > Export device_link_flag_is_sync_state_only() and use it to check this=
 in
> > > dpm_wait_for_consumers() and dpm_wait_for_suppliers() to fix this.
> > >
> > > Fixes: 05ef983e0d65a ("driver core: Add device link support for SYNC_=
STATE_ONLY flag")
> > > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> > > ---
> > >
> > > Changes in v4:
> > > - Remove inline for device_link_flag_is_sync_state_only()
> > >
> > > Changes in v3:
> > > - Squash to one patch and fix the export approach
> > >
> > > Changes in v2:
> > > - Update commit message
> > > - Use device_link_flag_is_sync_state_only()
> > >
> > >  drivers/base/base.h       | 1 +
> > >  drivers/base/core.c       | 2 +-
> > >  drivers/base/power/main.c | 6 ++++--
> > >  3 files changed, 6 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/base/base.h b/drivers/base/base.h
> > > index 123031a757d9..80415b140ce7 100644
> > > --- a/drivers/base/base.h
> > > +++ b/drivers/base/base.h
> > > @@ -248,6 +248,7 @@ void device_links_driver_cleanup(struct device *d=
ev);
> > >  void device_links_no_driver(struct device *dev);
> > >  bool device_links_busy(struct device *dev);
> > >  void device_links_unbind_consumers(struct device *dev);
> > > +bool device_link_flag_is_sync_state_only(u32 flags);
> > >  void fw_devlink_drivers_done(void);
> > >  void fw_devlink_probing_done(void);
> > >
> > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > index d22d6b23e758..a54ec6df1058 100644
> > > --- a/drivers/base/core.c
> > > +++ b/drivers/base/core.c
> > > @@ -287,7 +287,7 @@ static bool device_is_ancestor(struct device *dev=
, struct device *target)
> > >  #define DL_MARKER_FLAGS                (DL_FLAG_INFERRED | \
> > >                                  DL_FLAG_CYCLE | \
> > >                                  DL_FLAG_MANAGED)
> > > -static inline bool device_link_flag_is_sync_state_only(u32 flags)
> > > +bool device_link_flag_is_sync_state_only(u32 flags)
> > >  {
> > >         return (flags & ~DL_MARKER_FLAGS) =3D=3D DL_FLAG_SYNC_STATE_O=
NLY;
> > >  }
> > > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > > index 2ea6e05e6ec9..73a1916170ae 100644
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
> > > +                   !device_link_flag_is_sync_state_only(link->flags)=
)
> > >                         dpm_wait(link->supplier, async);
> > >
> > >         device_links_read_unlock(idx);
> > > @@ -339,7 +340,8 @@ static void dpm_wait_for_consumers(struct device =
*dev, bool async)
> > >          * unregistration).
> > >          */
> > >         list_for_each_entry_rcu_locked(link, &dev->links.consumers, s=
_node)
> > > -               if (READ_ONCE(link->status) !=3D DL_STATE_DORMANT)
> > > +               if (READ_ONCE(link->status) !=3D DL_STATE_DORMANT &&
> > > +                   !device_link_flag_is_sync_state_only(link->flags)=
)
> > >                         dpm_wait(link->consumer, async);
> > >
> > >         device_links_read_unlock(idx);
> > > --
> >
> > Rebased on top of linux-pm.git/linux-next and applied as 6.18 material
> > with some minor edits in the subject and changelog.
> >
> > Thanks!
>
> Thanks for updating the commit message and applying the patch.
>
> However, I can't find this patch at
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?=
h=3Dlinux-next
>
> Did I check the wrong place for this?

Yes, it was on the bleeding-edge branch for CI build testing coverage.

It has been added to the linux-next branch now.

Thanks!

