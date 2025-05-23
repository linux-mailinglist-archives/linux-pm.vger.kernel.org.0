Return-Path: <linux-pm+bounces-27585-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCF0AC25D1
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 17:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED4C1785B4
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 15:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C44F296D0D;
	Fri, 23 May 2025 15:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKnv+jZT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20A2296731;
	Fri, 23 May 2025 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748012563; cv=none; b=DCteN7LvnWiAxmmsrad7Ss2j4ueTggFtpvBve3I7xX7kZOKf7CkBP7QQ+dJ3OOip/SNv+V8GZLV3E6OtuK47LJBb5t+JRMjU5nBbnZY1sfnvF8+JhAEIAqfbow72kQqIadKWljjXQqWQsA3x9GqRVOfqkR3aOjoc+Grf2iDme3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748012563; c=relaxed/simple;
	bh=yeEwoT8PzEjoyanP7MaGg6wH0I3SAEbIqeSO/slYwaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JFAu3XCLSLNE7TFSW7jwEXr0FlrqUSExwryLZwAqcu5idjnUgl7kz9s+B6xkMctfWAFjPoaem4P4lAPdyktj//pMR9H/pRsfVNN6EAOj9lTnrTBuhumc70GpHavfrJKl2qwT6xS0EtqakPCG+D8LaIgzYv69mxmWZbXDFh/KYAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKnv+jZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E187C4CEF1;
	Fri, 23 May 2025 15:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748012562;
	bh=yeEwoT8PzEjoyanP7MaGg6wH0I3SAEbIqeSO/slYwaY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JKnv+jZT8uo3dhabyWrkSyfdLyXDRjwH7dxFnjtZt9tDxK25ZdSga/Hijv2WlMYD4
	 zkWYpP+bJusHqgBJ3qBm0iUN+8u6g/fp01mppelKjMTA9RfhIQwJsBK+kzA9fZXiD+
	 QPMyS5tl5SZrcKY7Btdbbk1AQwyEBhl79rhF6pTHDSC4wF2mdYIAMjcWO8DemnbF1i
	 a8WJWU9XoFPwdmFnu9tG1NY53u1WYzDUwwEaAg2+PdFvNhufSq2TpBlrjRSZRMDGzT
	 qyhUX6Xit5LFeT4RJhW23+5SjM7f1LPzogeiQVIg002wfnNkoMrylG87PNzcUVokb4
	 stIZxgvuB9OAA==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-606668f8d51so24318eaf.0;
        Fri, 23 May 2025 08:02:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUC2aRsfpmMkd2t84wgJ5SE++M+HWvobnHWCloFV23KORtw8lEVoEnY8rEFIvu54hqNDNTUSQkr43A=@vger.kernel.org, AJvYcCVkmjO4Lmc0uQ0Tau9U+tVwykSa7ppxKREc8NBbCFY2EUqDu8UjUcMuRQjWqLc1dJHJK7gRrPF67dUC+qT4C54=@vger.kernel.org, AJvYcCXy1Vi97/5tkzbHuqvVGn53/BTxYaeu5wAasp3vXb7WppSh49+FoZlPbC/N+1Cmmdz7QGIs5kOwbwnu8YvH@vger.kernel.org
X-Gm-Message-State: AOJu0YzotEhw+voetqzvKcHHAfd9Y3UIOfGLfvGg+3M1WCniBsw2zUVw
	sofP7rSe9WwHU81aLXrMf3eOjVs1GZ9g+4DTc1uYK0YaK7MPa07rAkXQExeIqMJbbiiPNFydCWj
	SHKD0STPfaDi+HYS8e0mZoJkAHI80NFw=
X-Google-Smtp-Source: AGHT+IH9Y4wLz5/pJ6ZzxN0hDwbYbOJN5QHqil4L+lAF31fYQ2PwzTFhe6cQLrw8+MzkeTje+8/0rG2DUGdVZRYsTdc=
X-Received: by 2002:a05:6820:206:b0:603:f809:ce19 with SMTP id
 006d021491bc7-60b93fc575amr2521581eaf.3.1748012561774; Fri, 23 May 2025
 08:02:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522083157.1957240-1-colin.i.king@gmail.com>
In-Reply-To: <20250522083157.1957240-1-colin.i.king@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 23 May 2025 17:02:30 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iE6LtKcDHiV88z3E11c_qhuWyoS4n0XjwGesdduDfDKg@mail.gmail.com>
X-Gm-Features: AX0GCFvSZPSsva3B90BZAwDIdj_iwZcxnJNROkMIUQJGlpaB3GGbyzorS7URnMw
Message-ID: <CAJZ5v0iE6LtKcDHiV88z3E11c_qhuWyoS4n0XjwGesdduDfDKg@mail.gmail.com>
Subject: Re: [PATCH][next] thermal/drivers/airoha: Fix spelling mistake
 "calibrarion" -> "calibration"
To: Colin Ian King <colin.i.king@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 10:32=E2=80=AFAM Colin Ian King <colin.i.king@gmail=
.com> wrote:
>
> There is a spelling mistake in a dev_info message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/thermal/airoha_thermal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_th=
ermal.c
> index 9a7a702a17de..b9fd6bfc88e5 100644
> --- a/drivers/thermal/airoha_thermal.c
> +++ b/drivers/thermal/airoha_thermal.c
> @@ -352,7 +352,7 @@ static void airoha_thermal_setup_adc_val(struct devic=
e *dev,
>                 priv->default_offset =3D airoha_get_thermal_ADC(priv);
>                 priv->default_slope =3D EN7581_SLOPE_X100_DIO_DEFAULT;
>                 priv->init_temp =3D EN7581_INIT_TEMP_NONK_X10;
> -               dev_info(dev, "missing thermal calibrarion EFUSE, using n=
on calibrated value\n");
> +               dev_info(dev, "missing thermal calibration EFUSE, using n=
on calibrated value\n");
>         }
>  }
>
> --

Applied as 6.16 material, thanks!

