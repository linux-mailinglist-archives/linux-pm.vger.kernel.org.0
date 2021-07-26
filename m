Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22523D5AD7
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jul 2021 16:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbhGZNT6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jul 2021 09:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbhGZNT6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jul 2021 09:19:58 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE275C061757;
        Mon, 26 Jul 2021 07:00:25 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id d17so5056153qvn.13;
        Mon, 26 Jul 2021 07:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=pxMM15ZHXjLx5HEWP2ljfrxj5I8bM98TUGkRptn2eJc=;
        b=Qf2LmVbSl9kTgbqdlNUVhOdyd+yNxxcP7wfQ/CaAIfH7Hft+4wIvhedth+71WhHBV7
         Nr+3zTmJdoZtoo1SRN8myq2jQKUr9AhkWa7gmnwaFX9mQkDJo6dTYeyWxgb5GpIqxDvE
         dDsWjXh9Am3VraObY1ionR1s8Z9p5fjp0qs3yHPfd4zOfsVWNVjg4IKW+YkZ7J9PPTT3
         5LTx9zXrdS63Xh6QaYDBYMIaRKA726J7fVydrWNuUV290mC08KxV7clB0LA5kMPA79xw
         Efz15tYH9PECyZy38aL+Dww65BituNb31u0NNE8rOTXXSfNFeQFFAU241s3EIqSaQn4O
         rCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=pxMM15ZHXjLx5HEWP2ljfrxj5I8bM98TUGkRptn2eJc=;
        b=OaOkU0l1lhl86TU7H5kRftOUtDETCsbdCxUNrrMV9BMJfOhv8RCDu12eS9itmpHhYY
         fZQ4gKpZAgmtL2oPm0V9xTCTKng9KeofVgzDvBnILkPeMpzhrCwIxiTMdraLKDInZ2M/
         WsAKY+vVMGy2M+SPpMjCGR6yQnmbDRh+A4QbqDxyrVgoMLMJvlqYHdxQPVCnYxP4UTY2
         laufR8ExorcoZLSGkTwnT1iYyi1XXeaKr/qnGkT/MdW6ylSJrw37yYuaeO4jKnupeRWZ
         TT3jmjQTn74ITc8pPoJpYKSMLVgRauln8l7RRJ8Q+uAFKc/uoSy+MPCN1KtK6q6O9pX7
         L/iw==
X-Gm-Message-State: AOAM530hjhZY+GlFsYffpOnggF4qKy3sEYQ4B5QJ4Be5liRPyAkxdOOp
        N3JprbxP134U2jTH8iLquE0=
X-Google-Smtp-Source: ABdhPJw48dTY8WUiWkjDerFNPjvQvAUCyTp2uni4QtKPaVhNgOIf6mzr/X9WEZdSFJ7DhnbTekwlcg==
X-Received: by 2002:a05:6214:27e7:: with SMTP id jt7mr18028066qvb.28.1627308024966;
        Mon, 26 Jul 2021 07:00:24 -0700 (PDT)
Received: from [192.168.1.3] ([69.73.219.130])
        by smtp.gmail.com with ESMTPSA id u3sm48780qtg.16.2021.07.26.07.00.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jul 2021 07:00:23 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH] thermal: fix thermal_cooling_device_register() prototype
From:   =?utf-8?Q?Jean-Fran=C3=A7ois_Dagenais?= <jeff.dagenais@gmail.com>
In-Reply-To: <20210722090717.1116748-1-arnd@kernel.org>
Date:   Mon, 26 Jul 2021 10:00:18 -0400
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Amit Kucheria <amitk@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <ABDAFCAB-8DF5-41A7-B1E0-4953A9BF32B3@gmail.com>
References: <20210722090717.1116748-1-arnd@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Good job.

> On Jul 22, 2021, at 05:06, Arnd Bergmann <arnd@kernel.org> wrote:
>=20
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> There are two pairs of declarations for =
thermal_cooling_device_register()
> and thermal_of_cooling_device_register(), and only one set was changed
> in a recent patch, so the other one now causes a compile-time warning:
>=20
> drivers/net/wireless/mediatek/mt76/mt7915/init.c: In function =
'mt7915_thermal_init':
> drivers/net/wireless/mediatek/mt76/mt7915/init.c:134:48: error: =
passing argument 1 of 'thermal_cooling_device_register' discards 'const' =
qualifier from pointer target type [-Werror=3Ddiscarded-qualifiers]
>  134 |         cdev =3D =
thermal_cooling_device_register(wiphy_name(wiphy), phy,
>      |                                                =
^~~~~~~~~~~~~~~~~
> In file included from =
drivers/net/wireless/mediatek/mt76/mt7915/init.c:7:
> include/linux/thermal.h:407:39: note: expected 'char *' but argument =
is of type 'const char *'
>  407 | thermal_cooling_device_register(char *type, void *devdata,
>      |                                 ~~~~~~^~~~
>=20
> Change the dummy helper functions to have the same arguments as the
> normal version.
>=20
> Fixes: f991de53a8ab ("thermal: make device_register's type argument =
const")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
> ---
> include/linux/thermal.h | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index d296f3b88fb9..8050d929a5b4 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -404,12 +404,13 @@ static inline void =
thermal_zone_device_unregister(
> 	struct thermal_zone_device *tz)
> { }
> static inline struct thermal_cooling_device *
> -thermal_cooling_device_register(char *type, void *devdata,
> +thermal_cooling_device_register(const char *type, void *devdata,
> 	const struct thermal_cooling_device_ops *ops)
> { return ERR_PTR(-ENODEV); }
> static inline struct thermal_cooling_device *
> thermal_of_cooling_device_register(struct device_node *np,
> -	char *type, void *devdata, const struct =
thermal_cooling_device_ops *ops)
> +	const char *type, void *devdata,
> +	const struct thermal_cooling_device_ops *ops)
> { return ERR_PTR(-ENODEV); }
> static inline struct thermal_cooling_device *
> devm_thermal_of_cooling_device_register(struct device *dev,
> --=20
> 2.29.2
>=20

