Return-Path: <linux-pm+bounces-4664-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D53870D55
	for <lists+linux-pm@lfdr.de>; Mon,  4 Mar 2024 22:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B75E21C2472D
	for <lists+linux-pm@lfdr.de>; Mon,  4 Mar 2024 21:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7087BAE3;
	Mon,  4 Mar 2024 21:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dt0gfqUM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301B779DDE
	for <linux-pm@vger.kernel.org>; Mon,  4 Mar 2024 21:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587975; cv=none; b=qSUL3U8Ebl8PUZbvfNcw5SOpjKQNd0cLZUEaa3XICX3IzJQ0JHvQjhFtFbDs6efek0AsqaeLumyDLVAEHYt5+MNFv+H8YzcUIKAU0k4jm5lir4rAClzNNEsFeklhNDoDK+VbegUtRqwBx2LGHK3vOjRpkLUXC8seIQsmp1Tlu/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587975; c=relaxed/simple;
	bh=vUIE+PnbCHPY3yWhXZ4b5EcL/Br19znwg7t4PmplrAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dhx+dJBAqo4zX7ZW0SuQBce0LF/EuMm33wuw/AkqyDiiAeDQ1FnKCBdGT5QS/0Turhq/mwgSBfCKA00O1+txt8VS3BffEag0qtw5Pu2z7Ut8mUkUkP3z3iKpryMfZIoso+ZxgulKW4jWyksSt8QZHQE1s/UOELSYqjNqs+kDHI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dt0gfqUM; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33d90dfe73cso2639690f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 04 Mar 2024 13:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709587972; x=1710192772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gEfJ2Kg9284/c3Le6qMD+DwxWh1aoS/80hOyg6wh6o=;
        b=dt0gfqUMgOTgYW1UNTKsI5eNcK/ujMZS13Af9SXNllFo/Dr56QYbt93mdLC4pWECNq
         rLTnRkAwi4BFOLCGVyhn6+Q8kwpZmR9aue5bUV7LjbQoaL3LV8aWH8WURCZ6GB0llMbH
         UPseyhRD+cgGKtgEEVgdiBBd8uE681dpdB3qnwt8pN8fblxalAJAPZ0+WDUYRcqmrJsT
         XGMi6+qA77Yl8HZzHzbxIZZFqdaFT9HJUK3vJlZq0Exn5fw3cyTJxqS54LH+w8eSUfZ/
         rDc1Wq/7WP1LNo65xZ23W5R+8epGJ0u3N4Yr+rFRIuZB37hxXSNySGOIsQxsTRg7GKgx
         JTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709587972; x=1710192772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gEfJ2Kg9284/c3Le6qMD+DwxWh1aoS/80hOyg6wh6o=;
        b=moMuLrS7FVQ/BOlKG6J66Bx/hNcXs7prgmP8tEYGUH0c5g1g+Vo7idubmfwCbpD8Xe
         8JjBD/cilvOc94fLy2TXdW6lnvgkAUpkuYsU7hSg9S9Q5ou9gmGIcoo+e64UR5UcyBrt
         mq4XkuxpE9bCUS9jzxH/injjVyklJIMnyDKyKvuzCbYPKpgbcyMezk9Rls7yO18WAYWL
         0rzDf7auRsZ6fXrSehfq81F0gCcPdP/kED4BubFV+Sm7ai3OUphRTo3yo7jbTF3L5eLW
         ohyyi0v5ntM+V04jvv2XdF4qp0rLATxtf1K4DG4OT5gX0qXqUWtm9vlSpvsKtY+iLTM0
         5C4A==
X-Forwarded-Encrypted: i=1; AJvYcCVvCWm5Es17sY960hwItogMTD46CGZUzuK2GaemzBsh0YveMrcvMdvCkoyq9dk4YNF+MqSsoRjYPx+GXKXPB8PV4guf8VTMS5g=
X-Gm-Message-State: AOJu0Yz4nfed79KzKjumdbzwjAv91iIucc2vQQbFWu8N7CspGqJgthQN
	qlvrOW7kIHKWnX1LRvYpFzKkpUkw1LHX65VNB6hK19VBwLjiLvrs
X-Google-Smtp-Source: AGHT+IE8DqAnRoNBogGFb/riHiJFzj/xl1Ztb0tsaT8WRbkyPQ87GhcWCrkRQmVMiZdGWnSTZyDn5w==
X-Received: by 2002:adf:ca04:0:b0:33d:c45:15ec with SMTP id o4-20020adfca04000000b0033d0c4515ecmr643795wrh.32.1709587972146;
        Mon, 04 Mar 2024 13:32:52 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id u20-20020adfcb14000000b0033b7ce8b496sm13078199wrh.108.2024.03.04.13.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 13:32:51 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, kernel@pengutronix.de
Subject:
 Re: [PATCH 5/5] PM / devfreq: sun8i-a33-mbus: Convert to platform remove
 callback returning void
Date: Mon, 04 Mar 2024 22:32:50 +0100
Message-ID: <2719174.mvXUDI8C0e@jernej-laptop>
In-Reply-To:
 <0ca3f35bdf9549ccda7c6c10a476f28350d987df.1709587301.git.u.kleine-koenig@pengutronix.de>
References:
 <cover.1709587301.git.u.kleine-koenig@pengutronix.de>
 <0ca3f35bdf9549ccda7c6c10a476f28350d987df.1709587301.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Dne ponedeljek, 04. marec 2024 ob 22:28:43 CET je Uwe Kleine-K=F6nig napisa=
l(a):
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>=20
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/devfreq/sun8i-a33-mbus.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/devfreq/sun8i-a33-mbus.c b/drivers/devfreq/sun8i-a33=
=2Dmbus.c
> index 13d32213139f..bcf654f4ff96 100644
> --- a/drivers/devfreq/sun8i-a33-mbus.c
> +++ b/drivers/devfreq/sun8i-a33-mbus.c
> @@ -458,7 +458,7 @@ static int sun8i_a33_mbus_probe(struct platform_devic=
e *pdev)
>  	return dev_err_probe(dev, ret, err);
>  }
> =20
> -static int sun8i_a33_mbus_remove(struct platform_device *pdev)
> +static void sun8i_a33_mbus_remove(struct platform_device *pdev)
>  {
>  	struct sun8i_a33_mbus *priv =3D platform_get_drvdata(pdev);
>  	unsigned long initial_freq =3D priv->profile.initial_freq;
> @@ -475,8 +475,6 @@ static int sun8i_a33_mbus_remove(struct platform_devi=
ce *pdev)
>  	clk_rate_exclusive_put(priv->clk_mbus);
>  	clk_rate_exclusive_put(priv->clk_dram);
>  	clk_disable_unprepare(priv->clk_bus);
> -
> -	return 0;
>  }
> =20
>  static const struct sun8i_a33_mbus_variant sun50i_a64_mbus =3D {
> @@ -497,7 +495,7 @@ static SIMPLE_DEV_PM_OPS(sun8i_a33_mbus_pm_ops,
> =20
>  static struct platform_driver sun8i_a33_mbus_driver =3D {
>  	.probe	=3D sun8i_a33_mbus_probe,
> -	.remove	=3D sun8i_a33_mbus_remove,
> +	.remove_new =3D sun8i_a33_mbus_remove,
>  	.driver	=3D {
>  		.name		=3D "sun8i-a33-mbus",
>  		.of_match_table	=3D sun8i_a33_mbus_of_match,
>=20





