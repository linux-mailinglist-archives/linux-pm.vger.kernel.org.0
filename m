Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80FDB81432
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2019 10:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfHEI36 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Aug 2019 04:29:58 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34461 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfHEI36 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Aug 2019 04:29:58 -0400
Received: by mail-io1-f68.google.com with SMTP id k8so165609095iot.1
        for <linux-pm@vger.kernel.org>; Mon, 05 Aug 2019 01:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=utE9KIcR0f6O7/Nl0QrtDLlS9or1TsF6Brw5BfMNxCA=;
        b=d0wHezomM4JELxNG1RXAvHXwky0XmyiTzsKSe/aaydaB+Ep00jiSc2XOmm0T0UKf0/
         R3IFTCaY3ORDePWQlzE3eOFpwpxXiQ8zgDy3i5+KDN58y3neju2XC7Pckm7hreBAxOUN
         kjxtmBubW+ncgwetw2nwYN0Fwk3A3EN8rpYKLBhlYRbmmdT309CeqHJUhZZdk93w1X2u
         Ic6sFRLmi+qnfvmJzkDgbtOtWKajfXoyG6CnlfxNiYNNVkTlfQ8I+vyWC2q/QsL+Wt/K
         G9zcgXiIhggUoQfWc/TreThgGqt5sC0c31QQJlY04qPhVKKwBfNUlTU2e7f6VtLywHvx
         XayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=utE9KIcR0f6O7/Nl0QrtDLlS9or1TsF6Brw5BfMNxCA=;
        b=J7/Wb/22DG837xzqL0f2mq9Yo26dNLlGWXV2NY8EiI3Mn1/NuTbWRHVjXgkZq7mcOY
         wusRnVKXqLC+e0//tqdvM+8uxGISIIQ3I3rZzYELhmfSZ87cKkroVHnUJt//9tgwQbxi
         FALckq91v1s3ovvi3N05gH3MKvLzCs6/O+3+SDNPt53u2qmOuGFfibdiWchbQRas7Emk
         hbJ+nhO4L+W5mt7dwYULUEbDcKxcgQTkf4Aa7mQZqfU0GlwVkRxKx8AqwrJZPV7JEjSj
         GRfvnuziqVN0ASs1KIbz0TUb7F3qtbn8lgeSGkFGv9LcOjsSDDiBtv0neJPdxrwO56Yb
         TFRg==
X-Gm-Message-State: APjAAAUfvKmGI77ebNm01eUk5rx6CmgwUfuOm92EboQZK1y06N7xmxG5
        vUG1E6mXdMOIc/ElUzFk0ICPyb2SeDq4yrWtOyd8mg==
X-Google-Smtp-Source: APXvYqwG2qGnHr5QDUaSd+OFbMEQGTuAoyrOpHr27vtVqWcgtgIvxk1ESLat++QpC/1nyVQeDMRQ2DrEjrqx+c8O4Rg=
X-Received: by 2002:a5d:80c3:: with SMTP id h3mr20730801ior.167.1564993796136;
 Mon, 05 Aug 2019 01:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190703084811.9582-1-brgl@bgdev.pl>
In-Reply-To: <20190703084811.9582-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 5 Aug 2019 10:29:45 +0200
Message-ID: <CAMRc=MdzZDHLRpgC966CGQMBj8O9FXuXLvjKJNf_N0UwcXzZgA@mail.gmail.com>
Subject: Re: [PATCH] power: supply: max77650: add MODULE_ALIAS()
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

=C5=9Br., 3 lip 2019 o 10:48 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=
=82(a):
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Define a MODULE_ALIAS() in the charger sub-driver for max77650 so that
> the appropriate module gets loaded together with the core mfd driver.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/power/supply/max77650-charger.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/power/supply/max77650-charger.c b/drivers/power/supp=
ly/max77650-charger.c
> index e34714cb05ec..5f9477c5cf5a 100644
> --- a/drivers/power/supply/max77650-charger.c
> +++ b/drivers/power/supply/max77650-charger.c
> @@ -366,3 +366,4 @@ module_platform_driver(max77650_charger_driver);
>  MODULE_DESCRIPTION("MAXIM 77650/77651 charger driver");
>  MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
>  MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:max77650-charger");
> --
> 2.21.0
>

Hi Sebastian,

just a gentle ping for this patch.

Bart
