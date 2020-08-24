Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE9824FCB5
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 13:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgHXLjO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 07:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgHXLiv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 07:38:51 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DEEC061573;
        Mon, 24 Aug 2020 04:38:40 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id i10so9230876ljn.2;
        Mon, 24 Aug 2020 04:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=COA2OoHledK6LxvVEpN2e5CT6+lH8tSEYYTfZmmyU+4=;
        b=SR0SwN7M6dpgYK7DRYbwwCnClbUHBxGuJ5fyR4tdZrmskdS7xDOrOepiBGL5BqJ+s1
         4qcix95iMTmwpAxwxcm9fOFJgwQECfE4mxvs47NM/OiEdmbqLuA8AE0LgOEAj6/b9Bh9
         MFSL/6FpM99suqavlWe7Zbeg//rTkahk9GGG6CwXaD35Lni8Mdb/quypDi4t9iLjfo4r
         J6Ne7zqRLtsCcOO5HgXSPq7kmFEuLySeXTu1JfiuJL9HixZBlA7sRd5I+gOiii+B+1zv
         dtJEZvJyJYoIlr/3HPsoY+MC1VWNZqgXwZqErbMhf7eSQ5TUZdffF0sj0Cn1vtdZLCjR
         In9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=COA2OoHledK6LxvVEpN2e5CT6+lH8tSEYYTfZmmyU+4=;
        b=fERC0izN1MZ4w1houtQn78zjYtkMaL0rhP9Btg0clkZD6VIpYkq+uPrC4QHyJkABj6
         fL6foyqKZRmrrZNjD8+bqunDVAKyuuxanMhU4R6MIX4CQH4pzkEXzlM9R8SxgZZ/ix9f
         5jGduoouvJrk3d1sYBQUmapDW5FunI3qOgtBzw8ahNZELkiKUv4qVyM7qyBRtsKKVLcC
         PJofxX1JvUxZmoYi4SfBUqufY1mv4N9Nf8+MEaAJ7MZVLEplBQf9w+QHhDvh/mzNqoEg
         o+nfjrK1K8F5qr8uyr6VkfUeiTenn1ggImeO9FIq9dG/CWGd2fpSD1zvPACc6B9yHRlH
         VmwA==
X-Gm-Message-State: AOAM533kLhWt69OIBDons0FFRbrH4VVvhbg2X5uEJb7E7X4Tyt+1cIAt
        tG/48JTJk4L17BRfARpvBUwwFJOb2Ls=
X-Google-Smtp-Source: ABdhPJxsOi1noSnwLv7Tf5DhsoD96d7iPEV0CBG6t4E1gTnBmk7t6lPxQXly/bV+TJiX2fyz+avHIg==
X-Received: by 2002:a05:651c:1349:: with SMTP id j9mr2317590ljb.392.1598269118514;
        Mon, 24 Aug 2020 04:38:38 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id h23sm2129796lji.139.2020.08.24.04.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 04:38:37 -0700 (PDT)
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
Message-ID: <31e11f94-41cc-9181-cd08-95a074f3487b@gmail.com>
Date:   Mon, 24 Aug 2020 14:38:37 +0300
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
>> +	orange_led->cdev.name = "power-button-orange";
> 
> "orange:power" -- or what is this LED usually used for?

The orange LED is supposed to indicate that battery is charging up.
