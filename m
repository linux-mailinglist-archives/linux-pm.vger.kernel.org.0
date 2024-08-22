Return-Path: <linux-pm+bounces-12745-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F43795BAFB
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 17:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E4231C23747
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 15:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B1C1CCB33;
	Thu, 22 Aug 2024 15:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRMaQutq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD9D1CCB31;
	Thu, 22 Aug 2024 15:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724341837; cv=none; b=rETusxHTJQ5Kkqxyw4pdvbe/W3KDHEnCPXuF0sxxdoDXzcDiLZKK2Vi4Z6FhkPH9T8LnjllEzjKraR7OZ9o2INj2Uk0iDc5esiNBbwPBWIbUXIjut7EKEgXz71e0iyeZ/yzqttGn/2WAtlmjWcM/ZYCnZgB9fB3kPtb+7SFZiJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724341837; c=relaxed/simple;
	bh=j8BItr8qFtlFL1i1wA14p7v59VTidcPk+3dA1wLsBGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qnm9UTSW6Xr0X8fgfAh2Fy57ydPS+CG+4gHlM9J3HW+z+XeLB9OVKbowSLg3koQ8gC5XaVoklCRt23XVSZH6D4Dqe3LO4E7sYainphyhJ2vO8mCEWDkA0rFFx9UCz/b3ydfQ+n12qMYJ4nyLHcumodOGIW8Nd55Lsyl796C6jj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRMaQutq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5757C4AF0F;
	Thu, 22 Aug 2024 15:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724341836;
	bh=j8BItr8qFtlFL1i1wA14p7v59VTidcPk+3dA1wLsBGs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uRMaQutqD5WYFpv4feT6N9WxoNflY2zLsR6qScI6+8mpt7U+3aOC5FzdfXtAtOP/0
	 8O4PFkoFzLCbgJ8066FAhR04P3zQuXZTe2+f91/NYls0v9lCcWCBM9AhDy3oOu1CcR
	 2fc4ubI8NooFvaySUQwp6+xG8DvbtP8TLl73g3URb6g7UYSTkg0bNARU1Y3CiDEZu/
	 JNFKK9TMBk+wZUVd0muGnQZmszchzfTLBrG1INisXEoINFDe72Z/ncjfHYF5ZAFXdd
	 0CEV5UnIHRAtknLPT/Iq6rY2Ek3UPONkqC18JJQaJcZXw3/ykGYj4vlUDFguBW7eKM
	 XcJ7ZVQzFGvPg==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-270263932d5so650211fac.2;
        Thu, 22 Aug 2024 08:50:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUklm1dLjATZZ6HRt6idUObsM79bXiLs+cc+lTvYMuTsgEps1Emvut1PEJiYA6CtqYnf8QSm4MTpgDkQpk=@vger.kernel.org, AJvYcCWSABJyhHZkTB1b8PulWmSThV7JhNfGpBHvvCHDJVk8/L9TFZYQRBf90jjC7RSX2DgGbk0p0tOz7iA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8iGqpPLFU90KG3zkF+vP+KTDF8ImQGCGMhi17/0r80W7y+gyT
	bQ93rnzAZLoN7Pvbeu3Z7pDF9WgnbTio7RykGBp5tzJKS8JkMRya3QKWnjEpTiANCMvCpLs20fN
	4pCpTx1D8EK8QTWvvjfda3GZmhw8=
X-Google-Smtp-Source: AGHT+IEjEtp8txbNTSVDAbESD159H3Xu4niXJ19/74sWzyDg/UqldA1uz+kuK2FvIRx8CoFpw4jJGKn2F6acQ3ReYOE=
X-Received: by 2002:a05:6870:9123:b0:25d:8d4:68ab with SMTP id
 586e51a60fabf-273cff4655dmr2938204fac.40.1724341836263; Thu, 22 Aug 2024
 08:50:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822012903.57986-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20240822012903.57986-1-yang.lee@linux.alibaba.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Aug 2024 17:50:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gtvcH4ukBxwyPYOqGxJ5zKwLiuedFwGmquzm1DmGBvGg@mail.gmail.com>
Message-ID: <CAJZ5v0gtvcH4ukBxwyPYOqGxJ5zKwLiuedFwGmquzm1DmGBvGg@mail.gmail.com>
Subject: Re: [PATCH -next] thermal: Correct typo in thermal zone documentation
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 3:29=E2=80=AFAM Yang Li <yang.lee@linux.alibaba.com=
> wrote:
>
> The term '@refcont' was corrected to '@refcount', ensuring clarity and
> accuracy in the code comments.
> Additionally, an obsolete comment regarding '@tt_zone' was removed, as
> it was commented out in the code.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D9797
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/thermal/testing/zone.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/testing/zone.c b/drivers/thermal/testing/zon=
e.c
> index fcee12b152da..173d86bcc4e2 100644
> --- a/drivers/thermal/testing/zone.c
> +++ b/drivers/thermal/testing/zone.c
> @@ -35,7 +35,7 @@
>   * @temp: Temperature value.
>   * @tz_temp: Current thermal zone temperature (after registration).
>   * @num_trips: Number of trip points in the @trips list.
> - * @refcont: Reference counter for usage and removal synchronization.
> + * @refcount: Reference counter for usage and removal synchronization.
>   */
>  struct tt_thermal_zone {
>         struct list_head list_node;
> @@ -60,7 +60,6 @@ DEFINE_GUARD(tt_zone, struct tt_thermal_zone *, mutex_l=
ock(&_T->lock), mutex_unl
>   * during the registration of a thermal zone based on a given zone templ=
ate.
>   *
>   * @list_node: Node in the list of all trip template in @tt_zone.
> - * @tt_zone: Zone template this trip template belongs to.
>   * @trip: Trip point data to use for thernal zone registration.
>   * @id: The ID of this trip template for the debugfs interface.
>   */
> --

Thanks for reporting this, I've fixed up the original patch and recommitted=
 it.

