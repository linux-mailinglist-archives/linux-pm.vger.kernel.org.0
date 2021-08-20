Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A423F2B3E
	for <lists+linux-pm@lfdr.de>; Fri, 20 Aug 2021 13:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239629AbhHTLbI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Aug 2021 07:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238769AbhHTLbI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Aug 2021 07:31:08 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812DFC061575
        for <linux-pm@vger.kernel.org>; Fri, 20 Aug 2021 04:30:30 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id n5so1423239wro.12
        for <linux-pm@vger.kernel.org>; Fri, 20 Aug 2021 04:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qDKfRZRU7nzYZWhRJJ9/0dIDBxxKxoJMevlwhIQ2MBE=;
        b=K9ZRFlHl8vmyynKsEHwmhmZn0L2EbAYxMEMV/C4Vbc5Qe4HOZC6X+5qWCoBXRa1xKB
         bBH71UNA71ckpnPSCf4XjKX1WTOkG/1ASY6fGe51D5of8fPZ9Q+HBcx/WIZycmN1PBuK
         K1bTez5YaDVNTYpDAMfkGm9FMzEJQ6/yAtxrtY2Gag3iZpE6oAHM+BaBadhpFlMUrhaG
         NpjUALqy+A0xidp/HSgA3n7AjGS3qVvQytL0ErA07LSRqGgCs7VKwHAq5dcInFZ5qb5K
         8YGP7znljbcJEFBBbZvHijsJrFGCGOSTYMvu0gmALqNVTXD0BOqza24oJ4G0yLMgq3Po
         upSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qDKfRZRU7nzYZWhRJJ9/0dIDBxxKxoJMevlwhIQ2MBE=;
        b=Q9pXakqb4dUQYxHxL8u+U4lK5G8t55ZcyLXEjpQ2c993L2pCOFZfrWm0OmlYCPSnDG
         Fl/H9hY1S1MWXX0lYdNQX5CUVwQ0XaJWCf6OFavKBzHyNBy+1Ug89GxgnckHnHm1EMTX
         cxjU0Xa0xdaa9wx681VkraencK2EjuJbLaecAtXPqxWAMDoIsi50d2ktWHi/DAbYqdzu
         b2tCMq4mHDCYURaCK7Ynmjr/tQjgdE96Fk6I/89c7JguxAX7suYkCTPjWB3Op/glmuhy
         yBNWTPuCmnBcZcd02+7wa+OGr8j5Viz/lJQSpMunLpkyC2FEPj76r2f1w7Iu2rty9oR7
         H2Hw==
X-Gm-Message-State: AOAM532XyQCxyQq1tBYsp8qSKyesng6IRCMTLsiPCfMph1ROfy4tOFoI
        ausWgxcFK+uisjwb2OEWh+8f0g==
X-Google-Smtp-Source: ABdhPJxgiXh5Uwv9cgb9XBAyiujiZHro30bND8lWH4Gh5erzv2Oh3PODyusAuRD+3aJZyfhhVApvJQ==
X-Received: by 2002:adf:f0c2:: with SMTP id x2mr9412185wro.107.1629459028907;
        Fri, 20 Aug 2021 04:30:28 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:c378:b01b:5d2d:5223? ([2a01:e34:ed2f:f020:c378:b01b:5d2d:5223])
        by smtp.googlemail.com with ESMTPSA id h11sm11696878wmc.23.2021.08.20.04.30.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 04:30:28 -0700 (PDT)
Subject: Re: [RFC PATCH 0/2] Add a generic virtual thermal sensor
To:     Alexandre Bailon <abailon@baylibre.com>, rui.zhang@intel.com,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, khilman@baylibre.com
References: <20210819123215.591593-1-abailon@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f7d1205b-e859-e059-c835-c09a85c8c480@linaro.org>
Date:   Fri, 20 Aug 2021 13:30:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210819123215.591593-1-abailon@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Alexandre,

thanks for the proposal.

On 19/08/2021 14:32, Alexandre Bailon wrote:
> This series add a virtual thermal sensor that uses the hardware thermal sensors,
> aggregate them to return a temperature.
> 
> My first aptempt was to do the aggregation in the thermal zone but it was not
> that easy to do, and, there were some case that would have been conflictual
> such as setting differents trip for a regular zone and a multisensor zone.
> 
> Instead, I made a virtual thermal sensor that could registered in a thermal
> zone, and have its own properties.
> It could be added in the device tree, with the list of sensors to aggregate,
> and the type of aggregation to be done.
> 
> As example:
>   soc_max_sensor: soc_max_sensor {
>     compatible = "generic,thermal-aggregator";
>     #thermal-sensor-cells = <1>;
>     type = "max";
>     thermal-sensors = <&lvts 0>, <&lvts 1>, <&lvts 2>, <&lvts 3>,
>           <&lvts 4>, <&lvts 5>, <&lvts 6>, <&lvts 7>,
>           <&lvts 8>, <&lvts 9>, <&lvts 10>, <&lvts 11>,
>           <&lvts 12>, <&lvts 13>, <&lvts 14>, <&lvts 15>,
>           <&lvts 16>;
>   };
> 
> The current series build and work but it would require to be completed
> aswell a lot of cleanup.
> Before working on it, I would like to get some feedback and I know if that
> would an acceptable solution and continue that way.

Yes, I think it is going to the right direction.

IMO, we can get rid of the thermal_of changes. From a design PoV, the
patch itself should be the virtual thermal driver without any changes in
the core code, including thermal_of.

I have some comments on patch 2/2


> Follows the following discussion:
> https://patchwork.kernel.org/project/linux-mediatek/patch/20210617114707.10618-3-ben.tseng@mediatek.com/
> 
> Alexandre Bailon (2):
>   thermal: provide a way to get thermal sensor from a device tree node
>   thermal: add a virtual sensor to aggregate temperatures
> 
>  drivers/thermal/Kconfig              |   8 ++
>  drivers/thermal/Makefile             |   1 +
>  drivers/thermal/thermal_aggregator.c | 134 +++++++++++++++++++++++++++
>  drivers/thermal/thermal_of.c         |  43 +++++++++
>  include/linux/thermal.h              |  12 +++
>  5 files changed, 198 insertions(+)
>  create mode 100644 drivers/thermal/thermal_aggregator.c
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
