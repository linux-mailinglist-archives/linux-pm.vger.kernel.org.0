Return-Path: <linux-pm+bounces-34723-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7A3B5922A
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 11:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D66071676B1
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 09:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076A7299950;
	Tue, 16 Sep 2025 09:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OfTAy+CC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2CE291C1E
	for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 09:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758014788; cv=none; b=VR9dSiWwLwLVwOlIS6HqRnMBZ1fnMFcLuuORRvzNkXYp6EgCn/6qEj8Bf5fJtsrczKkYVn0Sm/TwWXp9pvkFcW/Jw81RVhfQTZlfi+z9XAp799PxP8S/y5guAbwSzGBO3byWVZRu73Vfn6RxvFmq1aiTkOE2KXo0i4lavUa7az0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758014788; c=relaxed/simple;
	bh=4lfVZ57BQxvk8n1ZAcb8ezDDNgaWzRWeSYP8fyFLr1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZrIhG8pH9oePgxiw52qWItMR2JdGLNcu7x2Hcf1pGO0oW7hFdT5QlCN2/4yxKST+n2rUEr6M0Ex2ImfXNP+MVWH2qIzNEzJM9E0EMjk/vP8ZoePJcIKbluYjXq2FsVybTcVPenfgOINDRsz8tX6jzcKhKu6jBil2ucdzVZjjDqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OfTAy+CC; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-757a43dbed1so1466331a34.2
        for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 02:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758014786; x=1758619586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zk5r8Hw8cLLoguwRNZkamSDZOj0muwUPjejxUY6OYbk=;
        b=OfTAy+CC51/cnDTAHKDDRoRN4gpHt0i8DvKqkQEnw0Kf0CgxmZJ75c/68hQCoyjCHQ
         HiuMirGJalcmpP5d0bwd7jyBsVW/aAYwEwzlMi7Cc8pQV5lOrxtarjS0Q8HpFMHfGSpa
         rVzu8wohUqozBNPJ0YCM49ITebk+Un5PMnplQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758014786; x=1758619586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zk5r8Hw8cLLoguwRNZkamSDZOj0muwUPjejxUY6OYbk=;
        b=MZEeZVKKnHugVm4RQ6k9O1Zyeb9sP70n2yy27lTlC8VHDWYeT6HURZR3gzLIhLI/iu
         3w66peNLjRU4fuir+jGlrAGhFpPtqLaBJVODNRgeiTDPGazCCEG/bj8AKw2V0HlqY0cO
         U360gl5dTomNTNqynvDx4jLIBzM+pXKUH2beO70sn6o7o3GyAoQARSCGWPU0N25qjLdQ
         mEyxuuJhx8b4xZAaYUwtxJPkw6+jb/gN0l3rretvOH3JAt6z/JS9rhzKgqiEvjAD40Y9
         0u7Y+w8OpyPweaXY5robB7jaANv9fKJERwYkch3c5l8ed9NPDYdiCaeMHdde/VgE/K+N
         gOrA==
X-Forwarded-Encrypted: i=1; AJvYcCWxhz6RevJaadJ3lGO9eiGaea+zkRD8p5IYnSWxAcMc88cXoZQ8KG6dVlIzNOl4B1mEiJHALK/KOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYb/SJ1Aycm0HKY/j8cG0ccBy3YVj1wMqhhNWxfKZL2W2TKn8+
	jRs821ulLdtGatEWgeicYFMGvYxyypdSoL07P3K1Ah8LVVlbVxWn2I4gd49bRYZTV9VqZsj2psq
	EqYE33Hd56k1vWi13pxdg78Ko4Z64Arfn0uHmYTz8
X-Gm-Gg: ASbGnctv6GuHTQyqJmRHLcAqAUS0kdT6tE+SYbfmpg/Jlw37MPgvnwDM9LsNY6fz2oh
	TAKSruoDYHW2hlwrkq6rLKlKV4xIHQlRBqVzlJ50ztEVPyDO2pYQ8FSXkYCELYhpVTM0KE2jSrg
	2cWD5TWNUqrdhxWxnDHf/p4jc/yXHguj+NYryB0dpBmtiLgjzmv/9hn5urLly2oAgSHyxoBxbry
	lXuHmWLcOtQH/20rsNVL7zMoPc49tO6sy/y
X-Google-Smtp-Source: AGHT+IHANShcalJc4XqYSlztXKHAo+w8oe1Ln+QgGhP21DfPXVSEG5nbhJg8sgCMOFA0nRdsdtxVQPWh2BeY9SM6zJM=
X-Received: by 2002:a05:6830:6201:b0:746:d8f0:56ab with SMTP id
 46e09a7af769-7534f698fcfmr10436118a34.0.1758014786002; Tue, 16 Sep 2025
 02:26:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912143911.445452-1-treapking@chromium.org> <CAGETcx_bzjiLcQSXhCGM1gg2Xy=fgD2FPAdt3ZHDJmY357WnHg@mail.gmail.com>
In-Reply-To: <CAGETcx_bzjiLcQSXhCGM1gg2Xy=fgD2FPAdt3ZHDJmY357WnHg@mail.gmail.com>
From: Pin-yen Lin <treapking@chromium.org>
Date: Tue, 16 Sep 2025 17:26:15 +0800
X-Gm-Features: Ac12FXzGMG2Z-5Pc6OqkUh0ucllWTMLHijqaQ6IRDJ87MDxY3DibH_pHGm-o9fw
Message-ID: <CAEXTbpdPGLtjai_3jxyEPcOaDM1D=bhw4M8Gz4U78k_BcobY6w@mail.gmail.com>
Subject: Re: [PATCH v3] PM: sleep: Don't wait for SYNC_STATE_ONLY device links
To: Saravana Kannan <saravanak@google.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	linux-kernel@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>, 
	Hsin-Te Yuan <yuanhsinte@chromium.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Saravana,

Thanks for the review.

On Sat, Sep 13, 2025 at 2:30=E2=80=AFAM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> On Fri, Sep 12, 2025 at 7:48=E2=80=AFAM Pin-yen Lin <treapking@chromium.o=
rg> wrote:
> >
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
>
> We've had SYNC_STATE_ONLY devlink for years in the kernel. Also,
> SYNC_STATE_ONLY device links get deleted once the consumer device
> probes. You also can't suspend a device before it probes.

In this case, "usb-a-connector" is a descriptive-only node that has no
driver binding into it, and this is why the SYNC_STATE_ONLY link never
gets deleted.

Also, out of curiosity, does that mean a system might not suspend if I
add a device node but doesn't include its driver in the kernel?
>
> Why are you hitting this issue only now? Something doesn't sound
> right. I'm asking this because I'm wondering if some other recent
> change broke any of my statements/design decisions above.

For our team, we didn't describe the on-board USB topology until
Stephen's series for the on-board USB hub support[1]. So, on previous
platforms we worked on, we don't have a graph connection from the USB
hosts and the USB connectors.

One explanation is that there aren't many use cases where you want to
add a graph connection to a node without a driver binding into that.
However, the code has been here for so many years, so I'm not sure if
this explanation really makes sense either.

[1]: https://lore.kernel.org/all/20240223005823.3074029-3-swboyd@chromium.o=
rg/
>
> Not to fix this, but to also ensure better suspend/resume ordering in
> the future, you might want to add a "post-init-suppliers" to the real
> supplier node here and point it to the real consumer here. This will
> also help break the cycle here. Because even with this fix, all it
> does is avoid enforcing any ordering between these two devices. It is
> just working based on the order in DT, which you shouldn't count on
> for correctness.

In this case, there is no driver for "usb-a-connector", so we don't
need any dependency between them.
>
> Thanks,
> Saravana

Regards,
Pin-yen
>
> >
> > In this case, the two nodes form a cycle and a SYNC_STATE_ONLY devlink
> > between usb_host (supplier) and usb-a-connector (consumer) is created.
> >
> > Export device_link_flag_is_sync_state_only() and use it to check this i=
n
> > dpm_wait_for_consumers() and dpm_wait_for_suppliers() to fix this.
> >
> > Fixes: 05ef983e0d65a ("driver core: Add device link support for SYNC_ST=
ATE_ONLY flag")
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> > ---
> >
> > Changes in v3:
> > - Squash to one patch and fix the export approach
> >
> > Changes in v2:
> > - Update commit message
> > - Use device_link_flag_is_sync_state_only()
> >
> >  drivers/base/base.h       | 1 +
> >  drivers/base/core.c       | 2 +-
> >  drivers/base/power/main.c | 6 ++++--
> >  3 files changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/base/base.h b/drivers/base/base.h
> > index 123031a757d9..80415b140ce7 100644
> > --- a/drivers/base/base.h
> > +++ b/drivers/base/base.h
> > @@ -248,6 +248,7 @@ void device_links_driver_cleanup(struct device *dev=
);
> >  void device_links_no_driver(struct device *dev);
> >  bool device_links_busy(struct device *dev);
> >  void device_links_unbind_consumers(struct device *dev);
> > +bool device_link_flag_is_sync_state_only(u32 flags);
> >  void fw_devlink_drivers_done(void);
> >  void fw_devlink_probing_done(void);
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index d22d6b23e758..741aa0571fc7 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -287,7 +287,7 @@ static bool device_is_ancestor(struct device *dev, =
struct device *target)
> >  #define DL_MARKER_FLAGS                (DL_FLAG_INFERRED | \
> >                                  DL_FLAG_CYCLE | \
> >                                  DL_FLAG_MANAGED)
> > -static inline bool device_link_flag_is_sync_state_only(u32 flags)
> > +inline bool device_link_flag_is_sync_state_only(u32 flags)
> >  {
> >         return (flags & ~DL_MARKER_FLAGS) =3D=3D DL_FLAG_SYNC_STATE_ONL=
Y;
> >  }
> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > index 2ea6e05e6ec9..73a1916170ae 100644
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -282,7 +282,8 @@ static void dpm_wait_for_suppliers(struct device *d=
ev, bool async)
> >          * walking.
> >          */
> >         list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_n=
ode)
> > -               if (READ_ONCE(link->status) !=3D DL_STATE_DORMANT)
> > +               if (READ_ONCE(link->status) !=3D DL_STATE_DORMANT &&
> > +                   !device_link_flag_is_sync_state_only(link->flags))
> >                         dpm_wait(link->supplier, async);
> >
> >         device_links_read_unlock(idx);
> > @@ -339,7 +340,8 @@ static void dpm_wait_for_consumers(struct device *d=
ev, bool async)
> >          * unregistration).
> >          */
> >         list_for_each_entry_rcu_locked(link, &dev->links.consumers, s_n=
ode)
> > -               if (READ_ONCE(link->status) !=3D DL_STATE_DORMANT)
> > +               if (READ_ONCE(link->status) !=3D DL_STATE_DORMANT &&
> > +                   !device_link_flag_is_sync_state_only(link->flags))
> >                         dpm_wait(link->consumer, async);
> >
> >         device_links_read_unlock(idx);
> > --
> > 2.51.0.384.g4c02a37b29-goog
> >

