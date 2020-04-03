Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7668F19DBFB
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 18:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404562AbgDCQrn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 12:47:43 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:52858 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbgDCQrn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Apr 2020 12:47:43 -0400
Received: by mail-pj1-f65.google.com with SMTP id ng8so3231028pjb.2;
        Fri, 03 Apr 2020 09:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6wJZJH5Znk8qmc84gheG1lqLkLKUTVbMbhIJ9Z1qyEo=;
        b=qKbox1bS/J0QnFQTIXcYnI4Uy1k42tego2yASVnX6R/etobrQtZj4DStH36odAWasn
         dVVsT4cbGsQ9Q5w6NgWsbcUbcWrgWlvxjcy37HChgvY+WBR2TO1qbQgZdYwwBeBo+/iV
         KXio4pIu7wZpToYPy8yegk0XGr9ad2+K3eE+Lxlshp8aT+SGFZ1xKoQChZKBBLYKtLbr
         E/BqysLWYJl2EIVrio3gVuLrpp4/5P4gcxZE+FoIzofechJrTPbrvMEr1KQmAiGm3idA
         JVrKvAYQCkgI01OnPw7RknZyCsdIAdHjrJBbGXSKnU9+l6l5a4PxrvDb78Kb6tHOmkol
         q3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6wJZJH5Znk8qmc84gheG1lqLkLKUTVbMbhIJ9Z1qyEo=;
        b=OYZ3ZXWdR2NNW40iM74NpdgpvLQAVNhV0GzlxAGCsqwCUVkPGr37c4OqwgwcigIAKX
         GYIlHDUjTwKEqge5ACP8XNLTO7TcygMQZ3l6ITYULHBBAvHFvLD3Jp/4oZHIZuZYyjft
         LzhIjgFOUcUqZP3x5W8o/jGXVLfp6Zo0eB8QwBijILEnoQw24/65IekISaSjqsSUMPU+
         lUax4JXnAm8CepFTdzPfQeW4MELdLzjKV6ibu4XW1cAHNqSXu2UjV0wi0k5bt6MaGQf2
         oqquY4W78JeSz2SVvoCMes+A7PQx3/1CE2fCjqoyhP7EDNmqMusViPucSeESUSP0jSxm
         Zaxw==
X-Gm-Message-State: AGi0PuZyZEbePZJJbDLIfNFawpcXBgva4slMpmXYF3e2ps21GBvYnxyB
        aXw4uZuWMEvZsyzDeoReIEWEVffX
X-Google-Smtp-Source: APiQypI0HnJWjuQs+8IhDHpLCVF/PefF0IC5kT0pAI8rJhlaXv0tBbaTWW34DOHQX8TykQmhVQwEFw==
X-Received: by 2002:a17:90a:cb18:: with SMTP id z24mr10690031pjt.67.1585932462212;
        Fri, 03 Apr 2020 09:47:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c201sm6100863pfc.73.2020.04.03.09.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 09:47:41 -0700 (PDT)
Subject: Re: [PATCH v2 4/8] power: supply: core: tabularize HWMON temperature
 labels
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <cover.1585929579.git.mirq-linux@rere.qmqm.pl>
 <ae82abf9da86542f5657a8c37106bcdae5011927.1585929579.git.mirq-linux@rere.qmqm.pl>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <dad5d544-7f6d-5c0d-6c6e-9d23cb0a6055@roeck-us.net>
Date:   Fri, 3 Apr 2020 09:47:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ae82abf9da86542f5657a8c37106bcdae5011927.1585929579.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4/3/20 9:23 AM, Michał Mirosław wrote:
> Rework power_supply_hwmon_read_string() to check it's parameters.
> This allows to extend it later with labels for other types of
> measurements.
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
> v2: split from fix temperature labels
> ---
>  drivers/power/supply/power_supply_hwmon.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
> index 67b6ee60085e..48c73994732c 100644
> --- a/drivers/power/supply/power_supply_hwmon.c
> +++ b/drivers/power/supply/power_supply_hwmon.c
> @@ -43,6 +43,11 @@ static int power_supply_hwmon_curr_to_property(u32 attr)
>  	}
>  }
>  
> +static const char *const ps_temp_label[] = {
> +	"temp",
> +	"ambient temp",
> +};
> +
>  static int power_supply_hwmon_temp_to_property(u32 attr, int channel)
>  {
>  	if (channel) {
> @@ -144,8 +149,20 @@ static int power_supply_hwmon_read_string(struct device *dev,
>  					  u32 attr, int channel,
>  					  const char **str)
>  {
> -	*str = channel ? "temp ambient" : "temp";
> -	return 0;
> +	if (channel < 0)
> +		return -EINVAL;
> +

This is unnecessary.

> +	switch (type) {
> +	case hwmon_temp:
> +		if (channel >= ARRAY_SIZE(ps_temp_label))
> +			return -EINVAL;

As is this. We don't usually check boundaries like this for
in-kernel APIs, and I personally would not want to have it
introduced in the kernel more than necessary. This just increases
kernel image size with zero benefit.

Guenter

> +		*str = ps_temp_label[channel];
> +		return 0;
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
>  }
>  
>  static int
> 

