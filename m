Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0FD12E6EF
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2020 14:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgABNxz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jan 2020 08:53:55 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34952 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728342AbgABNxz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jan 2020 08:53:55 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so5721278wmb.0;
        Thu, 02 Jan 2020 05:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UWP8T2dSY7on4bhuJvvJczYvJx5ExaoKE13WYmlRLaE=;
        b=BpAs5Ymn625eA/7UDL2mngUe6FHCqNi1N5DPpTwF++MjAalqhYw13VZ121XTxdW3bc
         k8XUmRiv8I/FedSc6Z4suNRUXX70I53CVZXDmBIbOaN3+WvwJfRqxu7CJTqxlJQOsX5w
         oKyuAo9tHeP2XALMiOaRJIyKsgirGl96iFYh7ACCMujtTGqKdCQC48ImRJ7UsqB4u5EY
         QxpwwRl5coiAMuozQqicMQxMsvRhOk5KPvqUUulgtNY3GOZoKevSI3F2UMdYeZs/y4u8
         CvHPtK7IZk6u9KQbPqjOuZ5w6eiaHGTfIdy8WzjjtuOZ6viGLVL30rkCth30aDrWxMX2
         QlAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UWP8T2dSY7on4bhuJvvJczYvJx5ExaoKE13WYmlRLaE=;
        b=dmh+oSGhA+dWujlajUY8HMRwoW+akNUJQ6VvdPPI0QUjSH9EKRPQbItGVlNdueMz2V
         NCuxQoL13TA6LmAm2FjKrVyEYO+ImAW1Z1HR3NKhawGnwU2/AQDtloCNav7i8dlXnGyc
         IByiLM7fIRBtaFMVXV8CQD/jkM+ynCEohwFyqN1Ap4al73ST+SJLrNozcbl2dI78LBKs
         wXCEEOGkm3odDIIXYPn85ROUiRutGwMTIY5tIkw0u8XwH9pJnLVD+McGVDCtxkdrZU2W
         I+hUCHsEwkcSeK3uyyzGmtsGRkLZP1hY0BaO/9y/JdcMAZXrD3GmQ+ZvVs8G/54UT4Zq
         0YfQ==
X-Gm-Message-State: APjAAAUMKEttCUSmxcW4V9uV74v2ZTV3WMVzqbfFOU2zJXdZwWr4zuLi
        k/9TtMJEOd2feH2Sv4d+wD3OZFxXsog=
X-Google-Smtp-Source: APXvYqxufgSY0u9Yp9j7987C/5ccAx6l5mQEkU9dAfV0VueShs93vukz+XU6wUh2h1CSSgsoa0ZKlw==
X-Received: by 2002:a1c:4d18:: with SMTP id o24mr14415612wmh.35.1577973232941;
        Thu, 02 Jan 2020 05:53:52 -0800 (PST)
Received: from localhost.localdomain ([46.216.160.87])
        by smtp.gmail.com with ESMTPSA id a184sm8755176wmf.29.2020.01.02.05.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 05:53:52 -0800 (PST)
Received: from [127.0.0.1] (helo=jeknote.loshitsa1.net)
        by localhost.localdomain with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <jekhor@gmail.com>)
        id 1in0v8-00055Z-WC; Thu, 02 Jan 2020 16:53:51 +0300
Date:   Thu, 2 Jan 2020 16:53:35 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] power: supply: bq25890_charger: Add support of
 BQ25892 and BQ25896 chips
Message-ID: <20200102135335.GA13218@jeknote.loshitsa1.net>
References: <20200101224627.12093-1-jekhor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200101224627.12093-1-jekhor@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 02, 2020 at 01:46:25AM +0300, Yauhen Kharuzhy wrote:
> Support BQ25892 and BQ25896 chips by this driver. They shared one chip
> ID 0, so distinquish them by device revisions (2 for 25896 and 1 for
> 25892).
> 
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> ---
>  drivers/power/supply/bq25890_charger.c | 97 ++++++++++++++++++++------
>  1 file changed, 76 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> index 9d1ec8d677de..a3dcd4eb1287 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -25,12 +25,20 @@
>  #define BQ25895_ID			7
>  #define BQ25896_ID			0
>  
> +enum bq25890_chip_version {
> +	BQ25890,
> +	BQ25892,
> +	BQ25895,
> +	BQ25896,
> +};
> +
...
> +static int bq25890_get_chip_version(struct bq25890_device *bq)
> +{
> +	int id, rev;
> +
> +	id = bq25890_field_read(bq, F_PN);
> +	if (id < 0) {
> +		dev_err(bq->dev, "Cannot read chip ID.\n");
> +		return id;
> +	}
> +
> +	rev = bq25890_field_read(bq, F_DEV_REV);
> +	if (rev < 0) {
> +		dev_err(bq->dev, "Cannot read chip revision.\n");
> +		return id;
> +	}
> +
> +	switch (id) {
> +	case BQ25890_ID:
> +		bq->chip_version = BQ25890;
> +		break;
> +
> +	/* BQ25892 and BQ25896 share same ID 0 */
> +	case BQ25896_ID:
> +		switch (rev) {
> +		case 0:
Sorry, typo here: should be 2 for 25896, I will fix this in v2.

> +			bq->chip_version = BQ25896;
> +			break;
> +		case 1:
> +			bq->chip_version = BQ25892;
> +			break;
> +		default:
> +			dev_err(bq->dev,
> +				"Unknown device revision %d, assume BQ25892\n",
> +				rev);
> +			bq->chip_version = BQ25892;
> +		}
> +		break;
> +
> +	case BQ25895_ID:
> +		bq->chip_version = BQ25895;
> +		break;
> +
> +	default:
> +		dev_err(bq->dev, "Unknown chip ID %d\n", id);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
...

-- 
Yauhen Kharuzhy
