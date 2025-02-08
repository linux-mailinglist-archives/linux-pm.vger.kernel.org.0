Return-Path: <linux-pm+bounces-21584-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A91A2D5CD
	for <lists+linux-pm@lfdr.de>; Sat,  8 Feb 2025 12:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB2287A4BB1
	for <lists+linux-pm@lfdr.de>; Sat,  8 Feb 2025 11:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1481AF0D0;
	Sat,  8 Feb 2025 11:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPHDG1za"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EFB192D8E;
	Sat,  8 Feb 2025 11:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739014270; cv=none; b=GbGd56Ff4TKZeUjEKafSv6hfw8kDTOrFsAfMTNVMHx1yo5BlCaPVDW0+LTW85lYWSuYzG/VlQ66r7zT9O3GTK4+XtSRUtOB3UC14TRJAeWbkVMtRrlk8s9r8I4N4CBCB8IPGfYE6NK7/BaWiTCuuBZnI1urnYit+hHMYWjqqVlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739014270; c=relaxed/simple;
	bh=a9PtbP4iTsYXTPmKRarNcrQugYoPQf/03FrbZJrRghA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYx7eQ/qH/fFYhJGqEG2ONdY0DIIOvXCcrFXMlxoMeC4WwjeNWa7Q1GZUKzOQEcalM/kWzP+A54tiMAlv2ZZauhhmXlGoh6zUC/wc0jf8Vow5lH9Fm1dvbq8hnzXm0PgzGbhf6KBqbPsMTRyUq+Jkcpbopp/55N1HcN8Q2PBaMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPHDG1za; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3854CC4CEE6;
	Sat,  8 Feb 2025 11:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739014270;
	bh=a9PtbP4iTsYXTPmKRarNcrQugYoPQf/03FrbZJrRghA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jPHDG1zaotlpXhf5asfnoBeYZASB+OATIwAB7wTXvZeHWb6vhtOkJz+rlQfBDSP+m
	 Gc2IqbA/GKqCzA1be/ZE5Rvi0lmbNckZJdz8yCXaIUuwbbEN4YmfChEbtGnCESxVBc
	 je2D0grSqMiyAnyFg+WmGFPrOFpGol03Fy7Kl+r6PLKlXNcWjNDTRxmLdJl5/q1zqK
	 /VYkWBJt0pz0cuEpzyvhSrwqD5ZSvFZz15JErFwTgV+7+iDCABzgZBx9ghFupwzhz8
	 pLz2hCLOL/scExAT8SgCOFRPmMwdwNyagKJkYrwjCImtt54cqVpHPjiwWDke+Xy2kX
	 dps4vvnCXKvxQ==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5f89aa7a101so1038509eaf.2;
        Sat, 08 Feb 2025 03:31:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWiUZUPf45uPjJUHOwks95JqzAcjjVTey32epNfGNReWFjLLxdqpbfe/bJcVURrFzzVZ6w6l2WvAZzfrho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzad72Ep3GdUYBsVDPn4c5fssqWMIK24jDC2egwjKMEvBXt3tCq
	X+IHy6BO8K3xUqNTFr7W727+n5RDOBckzZqjoIGDjvPlN72GGyNEQl6F4GoSZXTa1dNLwrSjZLA
	Xms9w400E58uL59MuJtZyWUHpCqo=
X-Google-Smtp-Source: AGHT+IG1JlJtCnvqJUSiOxWkeEOCsazdBVYeG4ryDNk5FqiAtEwLYO8UOk3RYcnS+pcYGFl5IsC3XRkr77BvVSaXdl0=
X-Received: by 2002:a05:6820:1c8d:b0:5f8:a3df:a9b with SMTP id
 006d021491bc7-5fc5e71241bmr3327386eaf.8.1739014269461; Sat, 08 Feb 2025
 03:31:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207124802.165408-1-csokas.bence@prolan.hu> <20250207124802.165408-3-csokas.bence@prolan.hu>
In-Reply-To: <20250207124802.165408-3-csokas.bence@prolan.hu>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 8 Feb 2025 12:30:57 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gEdo_BeZh2tnxJMzoosxL5zzJXyf6wi7SR9du7MoQmUw@mail.gmail.com>
X-Gm-Features: AWEUYZn7qNNPJwyjn01tuOBK_DdGPdz60cKCzLPxqXPH1jhK6KH04nQCttSsB-Q
Message-ID: <CAJZ5v0gEdo_BeZh2tnxJMzoosxL5zzJXyf6wi7SR9du7MoQmUw@mail.gmail.com>
Subject: Re: [PATCH for-6.14 v3 2/4] pm: runtime: Add new devm functions
To: =?UTF-8?B?QmVuY2UgQ3PDs2vDoXM=?= <csokas.bence@prolan.hu>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 1:48=E2=80=AFPM Bence Cs=C3=B3k=C3=A1s <csokas.bence=
@prolan.hu> wrote:
>
> Add `devm_pm_runtime_set_active()` and
> `devm_pm_runtime_get_noresume()` for
> simplifying common use cases in drivers.
>
> Signed-off-by: Bence Cs=C3=B3k=C3=A1s <csokas.bence@prolan.hu>

So I don't like this and it is not as straightforward as it looks, but
let me have a look at the entire series again and see why you think
this is useful.

> ---
>  drivers/base/power/runtime.c | 36 ++++++++++++++++++++++++++++++++++++
>  include/linux/pm_runtime.h   |  4 ++++
>  2 files changed, 40 insertions(+)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 2ee45841486b..f0a6c64bec19 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1545,6 +1545,24 @@ void pm_runtime_enable(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(pm_runtime_enable);
>
> +static void pm_runtime_set_suspended_action(void *data)
> +{
> +       pm_runtime_set_suspended(data);
> +}
> +
> +/**
> + * devm_pm_runtime_set_active - devres-enabled version of pm_runtime_set=
_active.
> + *
> + * @dev: Device to handle.
> + */
> +int devm_pm_runtime_set_active(struct device *dev)
> +{
> +       pm_runtime_set_active(dev);
> +
> +       return devm_add_action_or_reset(dev, pm_runtime_set_suspended_act=
ion, dev);
> +}
> +EXPORT_SYMBOL_GPL(devm_pm_runtime_set_active);
> +
>  static void pm_runtime_disable_action(void *data)
>  {
>         pm_runtime_dont_use_autosuspend(data);
> @@ -1567,6 +1585,24 @@ int devm_pm_runtime_enable(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(devm_pm_runtime_enable);
>
> +static void pm_runtime_put_noidle_action(void *data)
> +{
> +       pm_runtime_put_noidle(data);
> +}
> +
> +/**
> + * devm_pm_runtime_get_noresume - devres-enabled version of pm_runtime_g=
et_noresume.
> + *
> + * @dev: Device to handle.
> + */
> +int devm_pm_runtime_get_noresume(struct device *dev)
> +{
> +       pm_runtime_get_noresume(dev);
> +
> +       return devm_add_action_or_reset(dev, pm_runtime_put_noidle_action=
, dev);
> +}
> +EXPORT_SYMBOL_GPL(devm_pm_runtime_get_noresume);
> +
>  /**
>   * pm_runtime_forbid - Block runtime PM of a device.
>   * @dev: Device to handle.
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index d39dc863f612..d7eca86150b8 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -93,7 +93,9 @@ extern void pm_runtime_new_link(struct device *dev);
>  extern void pm_runtime_drop_link(struct device_link *link);
>  extern void pm_runtime_release_supplier(struct device_link *link);
>
> +int devm_pm_runtime_set_active(struct device *dev);
>  extern int devm_pm_runtime_enable(struct device *dev);
> +int devm_pm_runtime_get_noresume(struct device *dev);
>
>  /**
>   * pm_suspend_ignore_children - Set runtime PM behavior regarding childr=
en.
> @@ -276,7 +278,9 @@ static inline void __pm_runtime_disable(struct device=
 *dev, bool c) {}
>  static inline void pm_runtime_allow(struct device *dev) {}
>  static inline void pm_runtime_forbid(struct device *dev) {}
>
> +static inline int devm_pm_runtime_set_active(struct device *dev) { retur=
n 0; }
>  static inline int devm_pm_runtime_enable(struct device *dev) { return 0;=
 }
> +static inline int devm_pm_runtime_get_noresume(struct device *dev) { ret=
urn 0; }
>
>  static inline void pm_suspend_ignore_children(struct device *dev, bool e=
nable) {}
>  static inline void pm_runtime_get_noresume(struct device *dev) {}
> --
> 2.48.1
>
>

