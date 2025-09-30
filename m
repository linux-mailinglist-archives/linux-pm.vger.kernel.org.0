Return-Path: <linux-pm+bounces-35606-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 165C3BAEBBE
	for <lists+linux-pm@lfdr.de>; Wed, 01 Oct 2025 01:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22FB37AF1F3
	for <lists+linux-pm@lfdr.de>; Tue, 30 Sep 2025 23:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E932BDC34;
	Tue, 30 Sep 2025 23:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YiozpR+M"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFF02D0C99
	for <linux-pm@vger.kernel.org>; Tue, 30 Sep 2025 23:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759273706; cv=none; b=EpMlMOn1UMhd+EKdjLOfTXKJBivNP1jLqr7j3vNadp7C+ChGx9CIZ3aATxUJKmQC9gHrXTO6SSaXaPSHZJgT7h42B2BGR7pEBP76rIYSgZAIzYSuHFKf67UJxp/3W74spWo+rl3kgRY6Mfm+2SlwDk4lV4kRzHgNZFFo/NNonWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759273706; c=relaxed/simple;
	bh=xQ9ascDA7HHkZafxlNLWnd7gwlj790RZILnV2UbZ+FU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EZg0K4FqOkA2uoVCiA3bna42bqiBbc8B0lSnX2577shN20HGJ0IQ31XCQi7OAIE3ONDdPxKvM8zceR6jdVZ2uvYzHdYZL257FOz5DW3pLmx2UzuK/lolJPXXL3YRPVrCifLZRQ6jz7/SLqwlb+wURogLBOexzmQ4Q8P8gfi8rqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YiozpR+M; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7afbcf24c83so1347014a34.3
        for <linux-pm@vger.kernel.org>; Tue, 30 Sep 2025 16:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759273703; x=1759878503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiBaoGgaM2C3I3iKN33UN2nyaLpcr1G/mtPkZ6OT3tM=;
        b=YiozpR+MxYHU3jSEB3HPQ1XbfNGmMntZLX97QJhJbLVGiegTueuXwmasyPknkRf02G
         7FBO48x4Pkpq1eEaR7x+SVAC/9p1nYi17tgJtnXCxKHo0A2jMsaZz/vNySsVcX4qSHNP
         5bIxzAfDE5jBSVvyh3UvPKfF2q+1p03s9q9U0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759273703; x=1759878503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XiBaoGgaM2C3I3iKN33UN2nyaLpcr1G/mtPkZ6OT3tM=;
        b=aXgAY1XxSH/BO4TxL0htP4uUBLDoExmTZh+fLz4Ljh+jMGhCGItp3WHyW2x3zEafYz
         GKtamPfIki8cp1cYjdc5JBzUi+jp+/Pcw2cjK4fdbK2HJSNvFyhaGbz2Vwv90AZ5mkko
         VQvZ+0pjJn3Q6m59EqfkVc8EzcwLRfGk4q49s47IwMVNeDuxjPiVdezR6fdq83CqxfYV
         JDVbRrVCA8M+KmQxY+dBP/Gk39dAAOZfgyBnH9gQNzn/MZ4+TB1UBPm+2C2Z80oV0gzc
         jJl0++ur5sfv7Hn1rbNONFLdE+ZlTmCRPK0EssshI+MqC/btbwmFD/TWLKXo3kn8D5ye
         n9nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs6IooV5wJdJeBE7rUM6c0WQIqFLHzPUkVAOZcPBIYrhLMSrQPv3rlIzqrtuZK+FVaMRCDsaoqBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjNsJvFBab3D243uIqaRs7s+GOn/9ZaVYoc7gl37TKm/7CRrRv
	mDr74bLvwDDrwoM6zDRh0DZAsAUW0VbUkxv8fNLVoffLDR7pRopN66Yfnyy83eJtnc/+abgCjz0
	GQc6Qf+rgI0dAC6ITUEvrPZTAFt4g+gmkD7qGkyQZ
X-Gm-Gg: ASbGnct/7CwVzgUkvw3BfkX97hGV/YIRPuEc9OkbxhUACr0ho0YuCZWmNRtIYX9R5bB
	GZG7DOjmurOPBH4vHTsbWRLngAp8Gh29CKkn41cAKt1kJfUqPgwRY4hhoCz6AjqOdCGu+LOVBhx
	d+bHnr+wjCKY+NrynJ1nMbB4fEBh3UzAa7srrefh4ZHeGigMzW6A0U+RjhV+Q9R40PBVkThyuUz
	PVSTOZNjm72OXCiIKP6INHhR+hF2ca521WqzBpHfVx8RFrA7ZtKOC0R8wWi
X-Google-Smtp-Source: AGHT+IHMEqNH78iPNiGGP3bb7Kx8uDn/T1LzaPL/CpPUoH7hqsowKpT+GgRGF3J9BiV9iQL5QcSwcug4NCAhGjFiogA=
X-Received: by 2002:a05:6830:3c09:b0:7af:a0ac:d56 with SMTP id
 46e09a7af769-7bddae3c229mr992705a34.22.1759273703460; Tue, 30 Sep 2025
 16:08:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926102320.4053167-1-treapking@chromium.org> <CAJZ5v0i-iT-3nEjX7Nm2s91GSm0OTXQ3yZSf2Q3VRNTOseREHw@mail.gmail.com>
In-Reply-To: <CAJZ5v0i-iT-3nEjX7Nm2s91GSm0OTXQ3yZSf2Q3VRNTOseREHw@mail.gmail.com>
From: Pin-yen Lin <treapking@chromium.org>
Date: Wed, 1 Oct 2025 07:08:12 +0800
X-Gm-Features: AS18NWBTNmMaOUfYxFxTvE7zS5oWKcOj0SYvHdkUx6TzVPgyImUlvVKEMGKXEwk
Message-ID: <CAEXTbpfUEDf_L3wVJEwD=Wjhx05X6Z2F-rbZT5L7vUR8GUAWTQ@mail.gmail.com>
Subject: Re: [PATCH v4] PM: sleep: Don't wait for SYNC_STATE_ONLY device links
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, linux-kernel@vger.kernel.org, 
	Hsin-Te Yuan <yuanhsinte@chromium.org>, Chen-Yu Tsai <wenst@chromium.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

On Sat, Sep 27, 2025 at 8:13=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Fri, Sep 26, 2025 at 12:23=E2=80=AFPM Pin-yen Lin <treapking@chromium.=
org> wrote:
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
> > Changes in v4:
> > - Remove inline for device_link_flag_is_sync_state_only()
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
> > index d22d6b23e758..a54ec6df1058 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -287,7 +287,7 @@ static bool device_is_ancestor(struct device *dev, =
struct device *target)
> >  #define DL_MARKER_FLAGS                (DL_FLAG_INFERRED | \
> >                                  DL_FLAG_CYCLE | \
> >                                  DL_FLAG_MANAGED)
> > -static inline bool device_link_flag_is_sync_state_only(u32 flags)
> > +bool device_link_flag_is_sync_state_only(u32 flags)
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
>
> Rebased on top of linux-pm.git/linux-next and applied as 6.18 material
> with some minor edits in the subject and changelog.
>
> Thanks!

Thanks for updating the commit message and applying the patch.

However, I can't find this patch at
https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=
=3Dlinux-next

Did I check the wrong place for this?

Regards,
Pin-yen

