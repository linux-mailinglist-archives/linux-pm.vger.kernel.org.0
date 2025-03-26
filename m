Return-Path: <linux-pm+bounces-24548-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81960A71EFA
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 20:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A21A18943FF
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 19:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4159241128;
	Wed, 26 Mar 2025 19:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+JJ9M0B"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A526017A2FB;
	Wed, 26 Mar 2025 19:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743016697; cv=none; b=GFNKg57vR1f3Fvni/XH42Zk+W8LpVdhYLDWAZN25xLDEXdLZqRsChKigL8Kxetfqtq+ElkY5+2g3ooe1pvnqiuP4AZIhe8XXTdZNEk86MWV2ALc0XbMLh+viJ8DPuMBxTupt9jyt7toNFPDd1Zvt4/tvvO7Ue3ZZWBtJfOXs6vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743016697; c=relaxed/simple;
	bh=DYGw0oyOVG3YEZsmUiIFXZNFb21ACldjKww6r4RFIa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=StbhuvLwZLo0ehu5M04rgybOXiwMCdfs9FqFX7kFJBeHRx7zQQXcKaqQI3zj+/nxY9q9YuokLVtKIra3oh9eOFlAVo56u3zTcsUabmCM6Qflkp0hHwSMOfMNuu0vnUF1nxVm91Bd/jA9A2K1K5SqaAlFu65/RTauGHOnjxzAlLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+JJ9M0B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E80C4CEEB;
	Wed, 26 Mar 2025 19:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743016697;
	bh=DYGw0oyOVG3YEZsmUiIFXZNFb21ACldjKww6r4RFIa8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X+JJ9M0Bs4oPPtThRVssn+WGXXtCeKZt+wYrVnNx5YW/yT/31As/b9QxIXJCixNj3
	 ueA5tQjfsM8xKnPovjWDDvbl1nQgJqV79ThGtMKQ+7P3DNz6vs3d3jgcPK88Q3NTxu
	 UKxOzJZO653jkoRqBYuQv6i6iNHoJj/99z7+vcumWyIyJd8nHXeyXxsf/zq3TmmADG
	 tQj1J7/6tndWVILlpEGNIxaZyIh6scNmKUy9EDm42CWaDY24ua8rTvgimgrfm1fZea
	 OapbnHVwVqVsZLxTqH/vH9RmSJygWmbnrJpC3rLkM3L5CQlAkKzTexI3dr6y+oYsx/
	 wdw5t3tB5dxiQ==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-601a8b6c133so633664eaf.1;
        Wed, 26 Mar 2025 12:18:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVy0fC3Nqd4IAUl8pdmo8tqx76jfzhISkUvs24f5CSX3DAwys62TIa5vsiqkzYF2eRDIf2BrQVack3s9Twd@vger.kernel.org, AJvYcCWOdqysX7j6vaD4DOVmNYUpnPhS7Api6PUpGhFGvi//fCk1pzSypwVKfvUoxo8OesmQSHZi0SxZiHA=@vger.kernel.org, AJvYcCWXkWT+iZBwC81RdtRrfSIapxsN2ONrN9ej3iZPx3rBtRL1R0MIg1s7eewoBjdwUvQ+D/L1iyNeCoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBRBqN7iXkp+/W800wGrSRI5UJZY0+8dZyAuBFL1MFJITH+wEn
	r9biTEE6G6b/UeLBQqCCPRRFwupW2zmJCtLXlg3/reTh57lqtP9Jd/cedMiQ54NLkee06rrtl0q
	EfGsuPAz6HZgR3i13xgQzrSKZJ28=
X-Google-Smtp-Source: AGHT+IG0UmPVTD3cDhQJVFZoMhpJRzKf6J/tWP2zMPuUm+v79zDORchalWa9HtwTueAUOR/A3c61wdC5nJcal0vC6Ro=
X-Received: by 2002:a05:6870:6b0b:b0:2c3:13f7:2b3d with SMTP id
 586e51a60fabf-2c826ccb7e2mr3034764fac.13.1743016696052; Wed, 26 Mar 2025
 12:18:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326-cross-lock-dep-v1-0-3199e49e8652@bootlin.com> <20250326-cross-lock-dep-v1-1-3199e49e8652@bootlin.com>
In-Reply-To: <20250326-cross-lock-dep-v1-1-3199e49e8652@bootlin.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 26 Mar 2025 20:18:03 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gFER-nbWpZK6FMDJCXA+iPQUm5DZDAiRY3ahugR2MM=g@mail.gmail.com>
X-Gm-Features: AQ5f1JrPtikMOCuX2uF1xkMrfdMjVy2NqIPXCeNXMupu0sMc1kMNdVTincA1LVs
Message-ID: <CAJZ5v0gFER-nbWpZK6FMDJCXA+iPQUm5DZDAiRY3ahugR2MM=g@mail.gmail.com>
Subject: Re: [PATCH RFC 01/10] PM: runtime: Add helpers to resume consumers
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	Chen-Yu Tsai <wenst@chromium.org>, Lucas Stach <l.stach@pengutronix.de>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marek Vasut <marex@denx.de>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, 
	Fabio Estevam <festevam@denx.de>, Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
	Shawn Guo <shawnguo@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>, linux-imx@nxp.com, 
	Ian Ray <ian.ray@gehealthcare.com>, =?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 7:26=E2=80=AFPM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> The runtime PM core currently allows to runtime resume/suspend a device,
> or its suppliers.
>
> Let's make it also possible to runtime resume/suspend consumers.
>
> Consumers and suppliers are seen here through the description made by
> device_links.

It would be good to explain why all of this is needed.

I gather that it is used for resolving some synchronization issues in
the clk framework, but neither the cover letter nor this changelog
explains how it is used.

> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/base/power/runtime.c | 54 ++++++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/pm_runtime.h   |  2 ++
>  2 files changed, 56 insertions(+)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 2ee45841486bc73225b3e971164466647b3ce6d3..04bb66c18e3e4a45751fb3f9a=
6a1267d73757310 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1841,6 +1841,60 @@ void pm_runtime_put_suppliers(struct device *dev)
>         device_links_read_unlock(idx);
>  }
>
> +static void __pm_runtime_get_consumers(struct device *dev)
> +{
> +       struct device_link *link;
> +
> +       list_for_each_entry_rcu(link, &dev->links.consumers, s_node,
> +                               device_links_read_lock_held())
> +               if (link->flags & DL_FLAG_PM_RUNTIME) {
> +                       pm_runtime_get_sync(link->consumer);
> +                       __pm_runtime_get_consumers(link->consumer);
> +               }
> +}
> +
> +/**
> + * pm_runtime_get_consumers - Resume and reference-count consumer device=
s.
> + * @dev: Supplier device.
> + */
> +void pm_runtime_get_consumers(struct device *dev)
> +{
> +       int idx;
> +
> +       idx =3D device_links_read_lock();
> +
> +       __pm_runtime_get_consumers(dev);
> +
> +       device_links_read_unlock(idx);
> +}
> +
> +static void __pm_runtime_put_consumers(struct device *dev)
> +{
> +       struct device_link *link;
> +
> +       list_for_each_entry_rcu(link, &dev->links.consumers, s_node,
> +                               device_links_read_lock_held())
> +               if (link->flags & DL_FLAG_PM_RUNTIME) {
> +                       pm_runtime_put(link->consumer);
> +                       __pm_runtime_put_consumers(link->consumer);
> +               }
> +}
> +
> +/**
> + * pm_runtime_put_consumers - Drop references to consumer devices.
> + * @dev: Supplier device.
> + */
> +void pm_runtime_put_consumers(struct device *dev)
> +{
> +       int idx;
> +
> +       idx =3D device_links_read_lock();
> +
> +       __pm_runtime_put_consumers(dev);
> +
> +       device_links_read_unlock(idx);
> +}
> +
>  void pm_runtime_new_link(struct device *dev)
>  {
>         spin_lock_irq(&dev->power.lock);
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index d39dc863f612fe18dc34182117f87908d63c8e6d..151c885a3f421f09509232f14=
4618da62297d61d 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -89,6 +89,8 @@ extern u64 pm_runtime_autosuspend_expiration(struct dev=
ice *dev);
>  extern void pm_runtime_set_memalloc_noio(struct device *dev, bool enable=
);
>  extern void pm_runtime_get_suppliers(struct device *dev);
>  extern void pm_runtime_put_suppliers(struct device *dev);
> +extern void pm_runtime_get_consumers(struct device *dev);
> +extern void pm_runtime_put_consumers(struct device *dev);
>  extern void pm_runtime_new_link(struct device *dev);
>  extern void pm_runtime_drop_link(struct device_link *link);
>  extern void pm_runtime_release_supplier(struct device_link *link);
>
> --
> 2.48.1
>

