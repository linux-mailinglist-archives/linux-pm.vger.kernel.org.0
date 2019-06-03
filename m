Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1DC336C2
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2019 19:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfFCRaz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Jun 2019 13:30:55 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45976 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729937AbfFCRay (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jun 2019 13:30:54 -0400
Received: by mail-pl1-f195.google.com with SMTP id x7so6256510plr.12;
        Mon, 03 Jun 2019 10:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x6LxCMvNbKAvwufPMN7pUEzpJTJQGX+IjHaO61nLrhc=;
        b=YQ5Brn47WmIUvxHa11mrJMb/bYejP+FD0Afb7Ey8tTnpBdSokXokZ656J9Dv0WB6fL
         eAoGRSTdY9915p9+DzDT9HOGN+1WUbigkCkoAC4T4v2GILXJbDiaUdeMLNPG3cmj1xBe
         yaT0UW6KJ1dcxKlsYtE5Ano6R83qTneWrr+e4azAn3W7Z3bReHBbjnlHpwNmaM27mlKB
         a6L3wQwzJ8tIGXul6Zgw5MwDR7fALBF47i5TKHs0FdDVWFnPO41Qw+K/BfSEZosMot+y
         id/pHJXOhEhWAJpJZZxut2ZvqHa09UGKPBiuP7kbz8Y1rzC/QKqLOvc8QqjSqpUNnDWb
         bKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=x6LxCMvNbKAvwufPMN7pUEzpJTJQGX+IjHaO61nLrhc=;
        b=tQhZyjG39leZ+GOHbH900qqT8j3LasXvCsd49JWqXvnqCNYfouuRpPXHUCeEOi5p4h
         i40OIAmsfuLWdyJM0v8+3HtA+KYMVeOe9DA4VczPedzgeaP/DcXrNZ/rksXGmZnMnnRv
         oHkazxH7qh/z1/Nb9tEpk6Zok8ph4ZRzs8pAMS568lxqxdL3F0AkisZ7f9rRBcoZlbn6
         drbaEbniaj71u2dMTIarCZ4ANjkXpR1xxy6vtHvfir/5MDrZiJ5XHiXZF1kI6JRK8vZY
         t3N/iFB63M1kXFJDcxOm8pwU70kFrPYu2pCBEbPY54v2awIrDFXZ1Q4D9+RSUkMEBaUH
         Orkg==
X-Gm-Message-State: APjAAAUMvNlKZXZ4b5TLXTBfFQq4x5rMVjYr1XouIg6Mh/URqtWuv+j/
        3wMAtG7Xw+6Iexj/9Z8i2z4=
X-Google-Smtp-Source: APXvYqzNjxQ4dQJciaN24y3Z8GJOIyhK6apkaM3QDoPTxdGJ6+DnNvx6wBHVXO0NkrbcjcGU+HaT+Q==
X-Received: by 2002:a17:902:8c8f:: with SMTP id t15mr31739499plo.87.1559583054215;
        Mon, 03 Jun 2019 10:30:54 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d3sm10724873pfa.176.2019.06.03.10.30.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 10:30:53 -0700 (PDT)
Date:   Mon, 3 Jun 2019 10:30:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-pm@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] power: supply: ucs1002: Add HWMON interface
Message-ID: <20190603173052.GB5220@roeck-us.net>
References: <20190531011620.9383-1-andrew.smirnov@gmail.com>
 <20190531011620.9383-3-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531011620.9383-3-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 30, 2019 at 06:16:20PM -0700, Andrey Smirnov wrote:
> Expose current sensors found on UCS1002 via HWMON.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/power/supply/ucs1002_power.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/supply/ucs1002_power.c
> index 1c89d030c045..ebe84f1ca42f 100644
> --- a/drivers/power/supply/ucs1002_power.c
> +++ b/drivers/power/supply/ucs1002_power.c
> @@ -571,6 +571,12 @@ static int ucs1002_probe(struct i2c_client *client,
>  		return ret;
>  	}
>  
> +	ret = devm_power_supply_add_hwmon_sysfs(info->charger);
> +	if (ret) {
> +		dev_err(dev, "Failed to add hmwon attributes: %d\n", ret);
> +		return ret;
> +	}
> +
>  	ret = regmap_read(info->regmap, UCS1002_REG_PIN_STATUS, &regval);
>  	if (ret) {
>  		dev_err(dev, "Failed to read pin status: %d\n", ret);
> -- 
> 2.21.0
> 
