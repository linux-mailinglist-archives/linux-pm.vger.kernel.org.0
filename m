Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C11E2F18EB
	for <lists+linux-pm@lfdr.de>; Mon, 11 Jan 2021 15:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387634AbhAKO4j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jan 2021 09:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388919AbhAKO4Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2021 09:56:25 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00DAC061786;
        Mon, 11 Jan 2021 06:55:55 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id j20so17118383otq.5;
        Mon, 11 Jan 2021 06:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8BFCyJxHnV2W7FXaQSodkkTlXrpGj4TcvpLMb0Fv2E4=;
        b=aLe1Y6WxbTEwSb9PmhAjo3/3AAw4hKCnXZVIZPrB2O3Xl9aovFmUqVVWeJBnEkxZY+
         R48KtSq6n8YIFXf7nFOQBH+/PSg0roZ76qz4aIl++8Y5yCOOkA4XK67jvmmHcU8kEMUj
         WaaJQcntTAAwsHgBQWZQszcEIGGQrwcDUK3pHnlgqshoNw145DQIwDf1Xa++KJb6Y34e
         SGF3eD+Io5GS9gS/KiCRJ7HofZpZk8U7gMdezFbWfyKbpCCgRf8y3drkkYZS7Pw6Ktn6
         rfaJ390McvX1ikfwN/jFl3Hpm+OuKcl6PequTkLUHXTwZefoDoC0qqyesq38PvOV8Rl8
         Iaiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8BFCyJxHnV2W7FXaQSodkkTlXrpGj4TcvpLMb0Fv2E4=;
        b=qep1D6yaxFoLN41N1ydXUZeb+X6IkLmeL9Wt/i7banxdF0UyuIbzE+xW9P+QimUDW9
         t7LcGuuf4Jlqei1DLbTimYw2jwXNx3GWBkkXwezKoYW1j/wNSGcwef4GsluOCMHWOh8e
         spapJWMkqksbogtU4n9EO3EwtxLtmw/0zrOu7UR+xFWoiAmvB39bGGJSTTa4/fXRI8sE
         pGeh5syAUkE7CuG0lPrApdheDd1ZYxbJdK+RB4yx1vemBjV1jKpfZg2jLFf4jVufpUPh
         jdLt+mFIudnFmKduArNOSedG1ZXz0Lq75MIckFzhwgyLhZPtlWHrKo+AcGUO+C5dZDlG
         tHHQ==
X-Gm-Message-State: AOAM5328bSNzjUmVp2Rc3bvJ8ghw19+jqs6v1JxqJkj6LFBHM/h21NyP
        jR9NvusRjZFbyoXrnf7ZaypF07H++W4=
X-Google-Smtp-Source: ABdhPJx+/rHrDUfqqikLuJAjU1petTZmY4T1cYdgtInzxQWAwRf5VbW8BnUJhKaJT6fZCrNF6EgqTA==
X-Received: by 2002:a05:6830:10d2:: with SMTP id z18mr11234544oto.90.1610376954821;
        Mon, 11 Jan 2021 06:55:54 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p25sm3985335oip.14.2021.01.11.06.55.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 06:55:53 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] thermal/core: Make cooling device state change private
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com
Cc:     Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Amit Kucheria <amitk@kernel.org>,
        "open list:PWM FAN DRIVER" <linux-hwmon@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
References: <20210111141320.15452-1-daniel.lezcano@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <7bdb20ca-9baf-9d2e-1f3d-cc52a5645c8b@roeck-us.net>
Date:   Mon, 11 Jan 2021 06:55:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210111141320.15452-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/11/21 6:13 AM, Daniel Lezcano wrote:
> The change of the cooling device state should be used by the governor
> or at least by the core code, not by the drivers themselves.
> 
> Remove the API usage and move the function declaration to the internal
> headers.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/hwmon/pwm-fan.c        | 1 -
>  drivers/thermal/thermal_core.h | 2 ++
>  include/linux/thermal.h        | 3 ---
>  3 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index bdba2143021a..0b1159ceac9b 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -378,7 +378,6 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  			return ret;
>  		}
>  		ctx->cdev = cdev;
> -		thermal_cdev_update(cdev);
>  	}
>  
>  	return 0;
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index 90f9a80c8b23..86b8cef7310e 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -65,6 +65,8 @@ static inline bool cdev_is_power_actor(struct thermal_cooling_device *cdev)
>  		cdev->ops->power2state;
>  }
>  
> +void thermal_cdev_update(struct thermal_cooling_device *);
> +
>  /**
>   * struct thermal_trip - representation of a point in temperature domain
>   * @np: pointer to struct device_node that this trip point was created from
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 1e686404951b..6ac7bb1d2b1f 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -390,7 +390,6 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
>  int thermal_zone_get_slope(struct thermal_zone_device *tz);
>  int thermal_zone_get_offset(struct thermal_zone_device *tz);
>  
> -void thermal_cdev_update(struct thermal_cooling_device *);
>  void thermal_notify_framework(struct thermal_zone_device *, int);
>  int thermal_zone_device_enable(struct thermal_zone_device *tz);
>  int thermal_zone_device_disable(struct thermal_zone_device *tz);
> @@ -437,8 +436,6 @@ static inline int thermal_zone_get_offset(
>  		struct thermal_zone_device *tz)
>  { return -ENODEV; }
>  
> -static inline void thermal_cdev_update(struct thermal_cooling_device *cdev)
> -{ }
>  static inline void thermal_notify_framework(struct thermal_zone_device *tz,
>  	int trip)
>  { }
> 

