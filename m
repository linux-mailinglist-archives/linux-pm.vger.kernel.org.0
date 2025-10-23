Return-Path: <linux-pm+bounces-36709-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47040C006B4
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 12:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA98719A320B
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 10:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AAF2F90DE;
	Thu, 23 Oct 2025 10:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azsRUBpz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35D82F363B
	for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 10:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761214640; cv=none; b=V3hMFd9sW/nNA2mAqs6W71yzrTMqYG9/z8qifdKp2D+aK+JXQl/R3I/pTxWnXdRLic3rtnUMPpr3bu//3Rz5HO1xxmKWy9gaftN2KfH0909Oo2lUvVpCntZ68ZSCOG0V65ecYos5hK2hxKTx7Bjt6JAGz9hxMnrC4qPEW8dGrbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761214640; c=relaxed/simple;
	bh=H7OH5nlgN/fXAcqV+jMO0agHgFLXj5Deoy6TObZZmv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o3d+3tO5Yhgl4RT7Mh7XlFtNQq8kuFAGbluEGThgnyCIPwfiUkyc3x776a6j7u4Od70fFo3J3HU8ywtQJlYEjwpMhRQGtItn+DaUBgMdZ8oQXmdPYCRCebTRirAc8CQ5b/v8TJ+FozVviZEgCxSY+Q5GjmvL/Ns9orqbow8dGaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azsRUBpz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85597C4CEF7
	for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 10:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761214639;
	bh=H7OH5nlgN/fXAcqV+jMO0agHgFLXj5Deoy6TObZZmv0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=azsRUBpznuWSKawTCQEoIoYYOwkbBPcqzKCS0FCvDxDxyMY23Y/OkLrFyqQ876Det
	 eNocsXrRd9JPmjBDhXcfdwoZMNu7C+i7BEWXyUbCC80JmopY/LBlt5Whu2x/dJNq2E
	 z3qKWDZKExElESu//TMkn2Ol3cmwUt/hc5TZgxuyMhOGFfLdSxRV/vep52X0U0WKQ1
	 Qu/7k8xeewaxoKSi5i3nPrDb10jvgCmZf9s4qFWP5DCjkGmIxZQe+oOXzUuVIh/8aN
	 NelE9m3pAZqsgIzdlbgFsKmBEE4kvzRAU7GLZCsKM/txasaBxUKEfHO9CcLKmhiUP0
	 J7uaKL5SFPuRA==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-444b94983f7so158815b6e.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 03:17:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHt7bxwiqVDa5sc0bGMpvfMQ1OAwzzGa5gO3gmQE170iShxjOGhWSn4MaUPesM1g3pvmhKaJ/3lg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm2+U8RrZ4lEcE74etU7VxnsT2OfahBmn6hSeuuFsMkzHybREX
	DJfK3ijwULBRmeQvRDCCxI8uS1mj5qOHni93NiaQUZZvnF3uY9a0Irw2WHRm0gNbsGioqiXq4IE
	8a7UfnI2GCMvnohJst+Rv3SrD5ja6pMs=
X-Google-Smtp-Source: AGHT+IHxXa5fxiwQ1fYivwjeYO5YsAdmoS2/KtdVbBn1phJ0pgplo94etZCxSSLJlEoTqTmy3gG/SfKKhR0rP0RGkNY=
X-Received: by 2002:a05:6808:1784:b0:43f:1c3a:c731 with SMTP id
 5614622812f47-443a30d10e7mr9442740b6e.34.1761214638871; Thu, 23 Oct 2025
 03:17:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12780841.O9o76ZdvQC@rafael.j.wysocki> <aPlCJB3nzSbpO-S2@google.com>
In-Reply-To: <aPlCJB3nzSbpO-S2@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 23 Oct 2025 12:17:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jFdUDN_Z5isEpWoisxzMHSgzu460VH2LDCLQTRsUtEDA@mail.gmail.com>
X-Gm-Features: AS18NWCUSJt0ureYrq1N3j893qfIWbhldvJXESV6HEXNWNQHrl4tPWwnEP8mK-8
Message-ID: <CAJZ5v0jFdUDN_Z5isEpWoisxzMHSgzu460VH2LDCLQTRsUtEDA@mail.gmail.com>
Subject: Re: [PATCH v1] PM: runtime: docs: Update pm_runtime_allow/forbid() documentation
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Lukas Wunner <lukas@wunner.de>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Brian,

On Wed, Oct 22, 2025 at 10:44=E2=80=AFPM Brian Norris <briannorris@chromium=
.org> wrote:
>
> Hi Rafael,
>
> On Wed, Oct 22, 2025 at 10:26:23PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Drop confusing descriptions of pm_runtime_allow() and pm_runtime_forbid=
()
> > from Documentation/power/runtime_pm.rst and update the kerneldoc commen=
ts
> > of these functions to better explain their purpose.
> >
> > Link: https://lore.kernel.org/linux-pm/08976178-298f-79d9-1d63-cff5a4e5=
6cc3@linux.intel.com/
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  Documentation/power/runtime_pm.rst |   10 ----------
> >  drivers/base/power/runtime.c       |   17 +++++++++++++----
> >  2 files changed, 13 insertions(+), 14 deletions(-)
> >
> > --- a/Documentation/power/runtime_pm.rst
> > +++ b/Documentation/power/runtime_pm.rst
> > @@ -480,16 +480,6 @@ drivers/base/power/runtime.c and include
> >    `bool pm_runtime_status_suspended(struct device *dev);`
> >      - return true if the device's runtime PM status is 'suspended'
> >
> > -  `void pm_runtime_allow(struct device *dev);`
> > -    - set the power.runtime_auto flag for the device and decrease its =
usage
> > -      counter (used by the /sys/devices/.../power/control interface to
> > -      effectively allow the device to be power managed at run time)
> > -
> > -  `void pm_runtime_forbid(struct device *dev);`
> > -    - unset the power.runtime_auto flag for the device and increase it=
s usage
> > -      counter (used by the /sys/devices/.../power/control interface to
> > -      effectively prevent the device from being power managed at run t=
ime)
> > -
>
> It feels a little odd just to strip 2 of the APIs from this doc, while
> the rest remain. I'm not too familiar with ReST, nor with kerneldoc
> integration, but would something like this work as a replacement?
>
> .. kernel-doc:: drivers/base/power/runtime.c
>    :export:
>
> .. kernel-doc:: include/linux/pm_runtime.h

Well, that's the plan for the future.

> >    `void pm_runtime_no_callbacks(struct device *dev);`
> >      - set the power.no_callbacks flag for the device and remove the ru=
ntime
> >        PM attributes from /sys/devices/.../power (or prevent them from =
being
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -1664,9 +1664,12 @@ EXPORT_SYMBOL_GPL(devm_pm_runtime_get_no
> >   * pm_runtime_forbid - Block runtime PM of a device.
> >   * @dev: Device to handle.
> >   *
> > - * Increase the device's usage count and clear its power.runtime_auto =
flag,
> > - * so that it cannot be suspended at run time until pm_runtime_allow()=
 is called
> > - * for it.
> > + * Resume @dev if already suspended and block runtime suspend of @dev =
in such
> > + * a way that it can be unblocked via the /sys/devices/.../power/contr=
ol
> > + * interface, or otherwise by calling pm_runtime_allow().
> > + *
> > + * Calling this function many times in a row has the same effect as ca=
lling it
> > + * once.
> >   */
> >  void pm_runtime_forbid(struct device *dev)
> >  {
> > @@ -1687,7 +1690,13 @@ EXPORT_SYMBOL_GPL(pm_runtime_forbid);
> >   * pm_runtime_allow - Unblock runtime PM of a device.
> >   * @dev: Device to handle.
> >   *
> > - * Decrease the device's usage count and set its power.runtime_auto fl=
ag.
> > + * Unblock runtime suspend of @dev after it has been blocked by
> > + * pm_runtime_forbid() (for instance, if it has been blocked via the
> > + * /sys/devices/.../power/control interface), check if @dev can be
> > + * suspended and suspend it in that case.
> > + *
> > + * Calling this function many times in a row has the same effect as ca=
lling it
> > + * once.
> >   */
> >  void pm_runtime_allow(struct device *dev)
> >  {
>
> The rewording looks helpful, as it's much more API-user-oriented now. So
> this looks good to me as-is, even if there are other potential
> improvements to make:
>
> Reviewed-by: Brian Norris <briannorris@chromium.org>

Thanks!

