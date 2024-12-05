Return-Path: <linux-pm+bounces-18616-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9101E9E5386
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 12:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B972285654
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 11:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726381DFE37;
	Thu,  5 Dec 2024 11:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioLKkfr9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456F81DFE16;
	Thu,  5 Dec 2024 11:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733397464; cv=none; b=kFOfGczrModmHTiQjSVwsKlIqOLdhDhi6evj8IpepLWG/Cr65n6GRIvAAXYv1f3MMJwLax14mY4SF7GWZFbUn+RzfSrMihueAIzJfTI5KX1vxmwuomc3KC4HTt1tuh/YymkzJaRKcrIG8mUUWjMMTdfksOHTzJidRJLqlSU/IwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733397464; c=relaxed/simple;
	bh=u9mfEkwS/F0LXCkeBbReWFy8k6OGAUx7jGWeoTnvIqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mo3bYsfFjApFAQdC9akRrJoaN1+lnUjkgnjHADzrfDlFiibaq+SgYvGRvYCJ9yIjkCRoavOsfoFGLmp625rPucouPEkfgcfh8PdVxlkuy9bL7cnSLLiidBVa4CKtLRGNH22BkVkZPou2z8FhhwXX4ZiXhoxmUBbVbrcH76oWJls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioLKkfr9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CC9C4CEE2;
	Thu,  5 Dec 2024 11:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733397463;
	bh=u9mfEkwS/F0LXCkeBbReWFy8k6OGAUx7jGWeoTnvIqI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ioLKkfr9r04+OwkcNMhG4NZ1LF0+oTrtJMPKJa2xRmougMtMOrz4xHERkrxvH7u2W
	 ywAROKO8AtQJtwD0sbs1zrCW911gFcK7IE5/6blrm7oM7tFUQ8Q/+6XvT8QHHkd0eA
	 C5zNQ7+W8hx0okL19P5jnXZa+tilXoDaiEGbYNn+glvl/1PnSglB8hy4glLkqi/Lbr
	 PhhwF9jh2G+5Y+lV1WO+7T3nzVqJOZFJwuE8kM2/tcyF8YL3RBb2MHtYkl+wkyVwfj
	 uc/QUeQad0/clgCn304DxyAH5ZGHnEdhGwnSH6SBUke68ahIGjX9y257QbRbYBlbnh
	 aNMxBy/quDMQw==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-29645a83b1bso472815fac.1;
        Thu, 05 Dec 2024 03:17:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXrtoIZ1koO8bAyO9lzDtrFElegQJpzn75WuekgG1lzj1OwFV9MLogK3zNHdaE2CfxBmdbHMB2qsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHW+jLzdYiht+6eRenhxB7QzMHamMhm7H1UoAaAihnVzs6RwRq
	crbSLp3iBzzS/z40qqhVPBufIv+S7ogWMjyurx+ygZvjlA0Uf0yT9ItdfVJAa/KoUW0Aekwm3Q/
	AKJJR9742LjWby4i6agDBTxUcDWU=
X-Google-Smtp-Source: AGHT+IHu1YddXwtQKIAVMNtRYmCSeaH/o2sQ+KXE1+zg9Aj8K/DviKHsBiVJSHi2yFhUNS6ViQV2Quy4FsgA7NOyFs4=
X-Received: by 2002:a05:6870:912b:b0:29e:8068:e089 with SMTP id
 586e51a60fabf-29e9b1853b5mr4712672fac.19.1733397463016; Thu, 05 Dec 2024
 03:17:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118072917.3853-1-wsa+renesas@sang-engineering.com> <20241118072917.3853-3-wsa+renesas@sang-engineering.com>
In-Reply-To: <20241118072917.3853-3-wsa+renesas@sang-engineering.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 5 Dec 2024 12:17:30 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iJgQuuHVbQxom6VLKHZvSnAzP75oQMDcr-3a1GAdzAFQ@mail.gmail.com>
Message-ID: <CAJZ5v0iJgQuuHVbQxom6VLKHZvSnAzP75oQMDcr-3a1GAdzAFQ@mail.gmail.com>
Subject: Re: [PATCH 02/15] drivers core: don't include 'pm_wakeup.h' directly
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 8:29=E2=80=AFAM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> The header clearly states that it does not want to be included directly,
> only via 'device.h'. 'platform_device.h' works equally well. Remove the
> direct inclusion.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/base/power/sysfs.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> index a1474fb67db9..82ce2d9f54e5 100644
> --- a/drivers/base/power/sysfs.c
> +++ b/drivers/base/power/sysfs.c
> @@ -6,7 +6,6 @@
>  #include <linux/export.h>
>  #include <linux/pm_qos.h>
>  #include <linux/pm_runtime.h>
> -#include <linux/pm_wakeup.h>
>  #include <linux/atomic.h>
>  #include <linux/jiffies.h>
>  #include "power.h"
> --

Applied as 6.14 material, thanks!

