Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C4C455DE6
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 15:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbhKRO0E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Nov 2021 09:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbhKRO0E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Nov 2021 09:26:04 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC631C061574;
        Thu, 18 Nov 2021 06:23:03 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id a11-20020a4ad1cb000000b002c2657270a0so2477394oos.8;
        Thu, 18 Nov 2021 06:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6T1f8FWSmsU6MVFT+WxHT2jhXiX8nlTfr0KgoJNhNeA=;
        b=T0EQbFQEkJNhuu7hUOGc3Ea0dyww0GfaoNtjpF74PncXqPWLwl7H4eEmt2Jhav0FWv
         gOHsyRX8eQF1ClTRx8AOhx0LxneBuFDwY4739A1etB6B7tT617p4XPWO37QocjuJMY1c
         kfJ17a0VtbIbcS1cfjAjao4YmBdmrARlcc4j6Z5LZRQW7H3NcdSXzTE2HQTsFg700HDL
         7KSTTxbS1EKu5VrOZAeOUdYpktuCWIaRZU4ECLhyllmcw2yEKoj26oz7ePa99RD1PTj7
         GsacyTQJD6S9eWuSZpfm0U6YwrOSepyzA2WFifd4FbDDzizjSMJbtgpx8zvPiau/KEEP
         jh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6T1f8FWSmsU6MVFT+WxHT2jhXiX8nlTfr0KgoJNhNeA=;
        b=OFrCkE/lqs94gYNYq+RY5q+mWxf3g2xIoK9G7q3kzwbNdGXUa/I2G0DiTsd6zKzTJr
         Kwvw/BRJOXaqy2ydZDXftFuGUm9t0RusskMlW9OmL6jsLXzKCrZJZ28LBS6KBD13zXwk
         cZ58w1d9TwziaoaA+5H0datgLAMz5/MkmJIsFZobPWDfxcpidD9xDAOY5jTMId562+8V
         DOKh4Ezex86t/g7AGWxCE7xKiNP6tNjYY3wLO4CVYSDu9JbKiTtW/miakCRU2NV2Kwsh
         wbPf8gOhyammdLpl+kJY+G1AfAnpyb4k6I1/xaBXE/+XbAYZEMWbw5KoW7A+zHkMjQOD
         Cd5w==
X-Gm-Message-State: AOAM532xaAFvhKYPd3V3lRYpvTeXrgBuMOvzfDRdrojkHNbkt8Rw5JPB
        4dSar7zHXQcY0AiqXdT6NwdTvq31rSQ=
X-Google-Smtp-Source: ABdhPJzIKwW9OwPQxrI4kEoLUUAqHZIMHAIxX80CmK7pKR8WzuHnXT87i90MiYoehIsUGZA6ORACwQ==
X-Received: by 2002:a4a:b544:: with SMTP id s4mr13455528ooo.94.1637245382815;
        Thu, 18 Nov 2021 06:23:02 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bi20sm862655oib.29.2021.11.18.06.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Nov 2021 06:23:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-omap@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20211118113026.GG1147@kili>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] extcon: fix extcon_get_extcon_dev() error handling
Message-ID: <a33fc3d7-a389-a805-0ef9-4b90de1d3d89@roeck-us.net>
Date:   Thu, 18 Nov 2021 06:22:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211118113026.GG1147@kili>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/18/21 3:32 AM, Dan Carpenter wrote:
> The extcon_get_extcon_dev() function returns error pointers on error
> and NULL when it's a -EPROBE_DEFER defer situation.  There are eight
> callers and only two of them handled this correctly.  In the other
> callers an error pointer return would lead to a crash.
> 
> What prevents crashes is that errors can only happen in the case of
> a bug in the caller or if CONFIG_EXTCON is disabled.  Six out of
> eight callers use the Kconfig to either depend on or select
> CONFIG_EXTCON.  Thus the real life impact of these bugs is tiny.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> The two callers where the drivers can be built without CONFIG_EXTCON
> are TYPEC_FUSB302 and CHARGER_MAX8997.
> 
[ ... ]
> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> index 7a2a17866a82..8594b59bd527 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -1706,8 +1706,8 @@ static int fusb302_probe(struct i2c_client *client,
>   	 */
>   	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0) {
>   		chip->extcon = extcon_get_extcon_dev(name);
> -		if (!chip->extcon)
> -			return -EPROBE_DEFER;
> +		if (IS_ERR(chip->extcon))
> +			return PTR_ERR(chip->extcon);

Why does the code not need to return -EPROBE_DEFER ? The description states
that NULL is returned in that situation. Doesn't that mean that defer situations
are no longer handled with this patch in place ?

Also, with this patch in place, the code will no longer work if extcon is disabled,
because extcon_get_extcon_dev() will return -ENODEV and the above code will bail out.
The behavior of the code wasn't optimal in that case (it would wait until timeout
in tcpm_get_current_limit() before returning), but at least it didn't fail.

Thanks,
Guenter
