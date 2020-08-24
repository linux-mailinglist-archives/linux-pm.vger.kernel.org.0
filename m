Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C637A24FB19
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 12:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgHXKLJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 06:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgHXKLI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 06:11:08 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F806C061573;
        Mon, 24 Aug 2020 03:11:07 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id c8so4152847lfh.9;
        Mon, 24 Aug 2020 03:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eCM1MY9fL6XG/g9S5/R519/+dhVf/rR5iiVNVW9wNCM=;
        b=iZtbAURe/TcGpxgHsdxjWk+OBcVapW76EJhdem0MYolKHHUTpp7lpODnmH7+Vbf34w
         1OiD6R7tRTqvOZiScHDAcYR2tKiLLBO2KJ9ykXgEresO+HNuDPGDBhxwao7N//UWo1cV
         7nelPhDcGThb5Lh0+z6m1BFSPFrFCFPFJk0a45oCQoiTHZw5JTpih6g+K/Yp2zLwFVjh
         SZkf04JtwtIYCBa27oO3lZXiDWLLFjruvNIIN+6ov/w2gWAbfTL7Tv4nINtax5mo+N7L
         045CsgP4gdbbr/fCE2mQvngCsiAolJo9DmJZyhPtBBAFB9n2h2nlk3bZuDhV7d29r/G9
         8WfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eCM1MY9fL6XG/g9S5/R519/+dhVf/rR5iiVNVW9wNCM=;
        b=oixOVDFp+YXA7WIV9XHFoXWiZOJV6Fq/Q+LjpaSRyRAqG9u92k9ZkHCGFpeRrvHaa1
         XdIgK4VIYB+TyKdx7UWXyqmm2TuDDcYH8f/mBfHFlyFw29OIGLqcgxTPvjKgtiFqFVg5
         EQ4W20V4w1Gu8OjOa0Xc8VUxawjCDQyj4ZfQ3ac5AInHV/Qa7LCcJttG/vhJkkwXjEIu
         9jU+WFGfyKoYUvas5etDH7qJ+ptXgk8fYQcFb4OenOcBUKIZbKiR1PdBjwPJ5EmIW2kj
         +Wx0Q2b7doZoEr8Q4TtPnBv0tUqBsb7ri6LBHYGm4Gee/onBvA0IGs1scx1+WFsbZGF0
         IDYg==
X-Gm-Message-State: AOAM5316GIGXCizt76gYA8TqV+31hqb4+IH2b1ClEa1MmIINVpjwy2xs
        q1oatYQgPUxlZDGxnMZNMdOc2Bsjkew=
X-Google-Smtp-Source: ABdhPJxvtbBhDZM+Ig1AWobTyAP+bnsWRaGngsk0KGvGCf5SE5DqpM2UiJhgMN4XuNz5SFNsE1yirg==
X-Received: by 2002:a19:2202:: with SMTP id i2mr2316168lfi.35.1598263865536;
        Mon, 24 Aug 2020 03:11:05 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id t19sm2079121ljc.137.2020.08.24.03.11.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 03:11:05 -0700 (PDT)
Subject: Re: [PATCH v1 3/6] leds: Add driver for Acer Iconia Tab A500
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200823140846.19299-1-digetx@gmail.com>
 <20200823140846.19299-4-digetx@gmail.com>
 <20200823223037.5fkeg5ai6hry3axj@duo.ucw.cz>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <eb2da40a-9dbb-0a18-4dbc-3eb93bd2968c@gmail.com>
Date:   Mon, 24 Aug 2020 13:11:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200823223037.5fkeg5ai6hry3axj@duo.ucw.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

24.08.2020 01:30, Pavel Machek пишет:
> Hi!

Hello, Pavel! Thank you very much for the review! I'll take into account
yours comments in the v2!

>> Acer Iconia Tab A500 is an Android tablet device which has two LEDs
>> embedded into the Power Button. Orange LED indicates "battery charging"
>> status and white LED indicates "wake-up/charge-done" status. The new LED
>> driver provides control over both LEDs to userspace.
> 
>> @@ -0,0 +1,121 @@
>> +// SPDX-License-Identifier: GPL-2.0+
> 
> Nice.
> 
>> + * Copyright 2020 GRATE-driver project.
> 
> Probably untrue.
> 
> 
>> +	white_led->cdev.name = "power-button-white";
> 
> "white:power"
> 
>> +	white_led->cdev.max_brightness = LED_ON;
> 
> = 1. (And you'll need other adjustments over the code).
> 
>> +	orange_led->cdev.name = "power-button-orange";
> 
> "orange:power" -- or what is this LED usually used for?
> 
>> +MODULE_LICENSE("GPL v2");
> 
> Should be "GPL"?

Yes, apparently it should be "GPL". I'll try to double-check it for the v2.

Thanks!
