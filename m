Return-Path: <linux-pm+bounces-30055-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075BDAF77F0
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 16:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13455664D0
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 14:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF602EE281;
	Thu,  3 Jul 2025 14:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMfjkxpv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE0D2EE274;
	Thu,  3 Jul 2025 14:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751553906; cv=none; b=Fxqbp6g/R6BCHG+SCv4HpLr9ELVH/Dn8J2tCGXkf2WTgDcLfDoYmtJwh7PSxmINsy8giGWqZ/nA7fgCANR0ZcKAaJOpDlWc2Hwv2EJ8mOXECa4digWIemeLrGXl2Uy2nnAcEKy9t6+8AxEUoJ3sShxZ1y69rXOAolnYC0mbHza8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751553906; c=relaxed/simple;
	bh=zTPoGsfvzf77TfbmCmPJCQTRAbMyUUIX1ms6SsgW3Wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UQkRRZRVfhk8Q02LbH+vwM0ePcNusL6ut8GLpl3PfGO1dulIB2RO7Oj6WwNgfBtJou4TMDlFaNjxmGAvHDPaJKF/aN4Fqwe43lmbist6KPAeHj8jrSbvx0fdypWYfcbVUSFb517y3BUdT7uWFPOLQR203RPgNGI4+M80atGRvKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMfjkxpv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645FFC4CEED;
	Thu,  3 Jul 2025 14:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751553906;
	bh=zTPoGsfvzf77TfbmCmPJCQTRAbMyUUIX1ms6SsgW3Wo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YMfjkxpvfjVipk2YpIGFgFmaoWAQAgjaH5rkIFO6OVbWjDr0Ivm9GbxCqb4h51Dc6
	 aMCE8WAtkLhZqeUQuIhZ0xsF0Jv1JeytACasPAMj1oJXQzHf2N8oeYq9lE97Z+/X9H
	 KuJ+rQ3JqemgJR/KvDkzdmetQ/FF/VHLl6ib7NNQZP9ywSFI2jp5W7jHPkfcQW0NaF
	 xjhE/SHy5vNzocI0I8j6cFg4UxmNJE3bCX/aBb0s6e/Oa6/F9pIPuSzliBI4LQIgXj
	 JREa9dgoh2l2aitnKMOXNa8HIzxAcoKouPqPWLhrKZKt4ItnmWrb7zcDQuN2VxKHun
	 G7CSN5SCWj6Yg==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-40b859461easo19627b6e.1;
        Thu, 03 Jul 2025 07:45:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWDXurDmm5zCnQ2VZ3Fg9g7vHjAClAD2TxHyws0IS6WKMLV4m9asBXy1Q2vBIWD2+PzmGUoblXaCPk=@vger.kernel.org, AJvYcCXZzqUPgMn0KNOwZ+mnzlcFAkXRTzAs4ualQmPguVKtm+NqyglaWlppENva4Ta5gdngWL0+aazVZHqgZrk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoce91EY9l/RtEdx+Bs6NKqNGtKhrIPmWXYYeP6pmMTUq2fUD0
	jkWDTebk1sLbZzwmWrS4xZKbWlrSAIgu7xbSsngcgVRcAGnX/qeZgxhuAWIAtFfXEAmWDlgr41d
	BAPbsfmW4JQ4r57kYLF42/Tg2Gp/m6fk=
X-Google-Smtp-Source: AGHT+IEIAPlGdI/PFCTjqa0TNr4AIU7IYU6kC3w2j01PIL1EvX3xYE4BETV/clcNcidt96xuZtuj91/nm2/Qmvl+66Y=
X-Received: by 2002:a05:6808:118c:b0:406:6f21:8161 with SMTP id
 5614622812f47-40c07b26667mr2863697b6e.9.1751553905713; Thu, 03 Jul 2025
 07:45:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620-temp-v3-1-6becc6aeb66c@chromium.org>
In-Reply-To: <20250620-temp-v3-1-6becc6aeb66c@chromium.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 3 Jul 2025 16:44:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gUzFGxbR+en2JUaFvGt5vGY8z3LAJOba9f8RHoPrTvWQ@mail.gmail.com>
X-Gm-Features: Ac12FXx6YEKyQuiC50Rz1nN2CRFIwyEsx33fJZtZTzMgo2QWuLvfp-9xLrSClvg
Message-ID: <CAJZ5v0gUzFGxbR+en2JUaFvGt5vGY8z3LAJOba9f8RHoPrTvWQ@mail.gmail.com>
Subject: Re: [PATCH v3] thermal: sysfs: Return ENODATA instead of EAGAIN for reads
To: Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 12:41=E2=80=AFPM Hsin-Te Yuan <yuanhsinte@chromium.=
org> wrote:
>
> According to POSIX spec, EAGAIN returned by read with O_NONBLOCK set
> means the read would block. Hence, the common implementation in
> nonblocking model will poll the file when the nonblocking read returns
> EAGAIN. However, when the target file is thermal zone, this mechanism
> will totally malfunction because thermal zone doesn't implement sysfs
> notification and thus the poll will never return.
>
> For example, the read in Golang implemnts such method and sometimes
> hangs at reading some thermal zones via sysfs.
>
> Change to throw ENODATA instead of EAGAIN to userspace.
>
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> ---
> Changes in v3:
> - Refine the control flow and optimize the success case.
> - Link to v2: https://lore.kernel.org/r/20250512-temp-v2-1-048be58eaaa5@c=
hromium.org
>
> Changes in v2:
> - Modify commit message to make it clear
> - Link to v1: https://lore.kernel.org/r/20250409-temp-v1-1-9a391d8c60fd@c=
hromium.org
> ---
>  drivers/thermal/thermal_sysfs.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sy=
sfs.c
> index 24b9055a0b6c515b865e0d7e2db1d0de176ff767..d80612506a334ab739e7545cd=
fe984ab4dffab7c 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -40,10 +40,13 @@ temp_show(struct device *dev, struct device_attribute=
 *attr, char *buf)
>
>         ret =3D thermal_zone_get_temp(tz, &temperature);
>
> -       if (ret)
> -               return ret;
> +       if (!ret)
> +               return sprintf(buf, "%d\n", temperature);
>
> -       return sprintf(buf, "%d\n", temperature);
> +       if (ret =3D=3D -EAGAIN)
> +               return -ENODATA;
> +
> +       return ret;
>  }
>
>  static ssize_t
>
> ---

Applied as 6.17 material, thanks!

