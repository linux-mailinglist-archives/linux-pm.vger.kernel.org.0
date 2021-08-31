Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8309E3FC6AC
	for <lists+linux-pm@lfdr.de>; Tue, 31 Aug 2021 14:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhHaLjj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Aug 2021 07:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbhHaLji (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Aug 2021 07:39:38 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD399C061575;
        Tue, 31 Aug 2021 04:38:42 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id j4so37802109lfg.9;
        Tue, 31 Aug 2021 04:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aOKH12yigEUKEi+tvc+Sgbj/UZEyVXFcxaWf8LQZzSE=;
        b=or70UHRQOq+m936p5onYrYG3w9Y7J+nKsbvvRGD6VAeyoZSfSRihKirEX2HMeuyyOb
         xZ3RhHKoDQmHSTRJ+hpCFGUd5HSSd03AuI50Ui2YYPZCf1ixg6MLfJM5F97JKfaOGuFY
         GLFFmNczJmwQ2Ydp+NMW34m8PJDgWnb66ZXPlniIo1eTjjMz4qyW37aXxPXgPzS1X9yE
         AJEJpm1z8KAS539zc1oh/92ODoCiYw9I9w15VHF1cmXhVXOTX5h6wMuDbqov0CtrQs+y
         JDpdEO3ph7komlndSShoJ2PVi28zlFt+rFlpPQEloS8YBC+4G538L7HPHtE7ZUKR8HII
         GDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aOKH12yigEUKEi+tvc+Sgbj/UZEyVXFcxaWf8LQZzSE=;
        b=U+w0mrM8ap88ssRlPe4/oRqQ7ujhUj2y/+qNg+RTuDg1WAzZn2e84aXbpsI1zitAGZ
         9nHVqwkEUtx/RYppI+W16Ed8tkbxtSf2/PPI9TT2Ev1x0dN2/NMMajGgCeF5o9sAt3me
         qNvKq0adey3HLKy7YdaO7eN0SQiXwZrfZQDMIGqnASdEN0MawWwbTLIcd9cv/a+G1FEA
         1O5YXzWiWNFzjY6gAnsxjKJfSTzOLcBe1Cy6ZFklYEXFGiy90zJb+Q99nq/w2MMTzg3Y
         +VK552E11BDNeH+/dl7QoztxGnrVeiTD7c146+AB7gCFVKLyUGOkCimDEvsH5iIgwlXh
         9cWQ==
X-Gm-Message-State: AOAM5315AAD/8Zqol8WKsVlzfxmxY8wIiEc7qKhqFOhMUICKJ4IPJTwV
        EXeSJnOoCf/K/eHFHJi34WI=
X-Google-Smtp-Source: ABdhPJwHkBEa8hlZ47/vQ1/vwGaxYc613gr2ScicJ6tAHnNve32gRkHYThHCzeaH3mxd3gDhYsF/3Q==
X-Received: by 2002:a19:c1c2:: with SMTP id r185mr20878699lff.563.1630409921117;
        Tue, 31 Aug 2021 04:38:41 -0700 (PDT)
Received: from [192.168.2.145] (46-138-26-37.dynamic.spd-mgts.ru. [46.138.26.37])
        by smtp.googlemail.com with ESMTPSA id 203sm2265427ljf.63.2021.08.31.04.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 04:38:40 -0700 (PDT)
Subject: Re: [PATCH 2/2] of: property: fw_devlink: Set 'optional_con_dev' for
 parse_power_domains
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20210831102141.624725-1-ulf.hansson@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <d6cbbaf7-03a1-34d7-afe3-823cd627c799@gmail.com>
Date:   Tue, 31 Aug 2021 14:38:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210831102141.624725-1-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

31.08.2021 13:21, Ulf Hansson пишет:
> The power-domain DT bindings [1] doesn't enforce a compatible string for a
> provider node, even if this is common to use. In particular, when
> describing a hierarchy with parent/child power-domains, as the psci DT
> bindings [2] for example, it's sometimes not applicable to use a compatible
> string.
> 
> Therefore, let's set the 'optional_con_dev' to true to avoid creating
> incorrect fw_devlinks for power-domains.
> 
> [1] Documentation/devicetree/bindings/power/power-domain.yaml
> [2] Documentation/devicetree/bindings/arm/psci.yaml
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Some more details of what goes on here. I have added a debug print in
> of_link_to_phandle() to see the fw_devlinks that gets created.
> 
> This is what happens on Dragonboard 410c when 'optional_con_dev' isn't set:
> ...
> [    0.041274] device: 'psci': device_add
> [    0.041366] OF: Linking power-domain-cpu0 (consumer) to psci (supplier)
> [    0.041395] OF: Linking power-domain-cpu1 (consumer) to psci (supplier)
> [    0.041423] OF: Linking power-domain-cpu2 (consumer) to psci (supplier)
> [    0.041451] OF: Linking power-domain-cpu3 (consumer) to psci (supplier)
> [    0.041494] device: 'platform:psci--platform:psci': device_add
> [    0.041556] platform psci: Linked as a sync state only consumer to psci
> ...
> 
> This is what happens on Dragonboard 410c when 'optional_con_dev' is set:
> ...
> [    0.041179] device: 'psci': device_add
> [    0.041265] OF: Not linking psci to psci - is descendant
> [    0.041293] OF: Not linking psci to psci - is descendant
> [    0.041319] OF: Not linking psci to psci - is descendant
> [    0.041346] OF: Not linking psci to psci - is descendant
> ...
> 
> The relevant dtsi file:
> arch/arm64/boot/dts/qcom/msm8916.dtsi
> 
> Kind regards
> Ulf Hansson
> 
> ---
>  drivers/of/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 2babb1807228..4d607fdbea24 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1356,7 +1356,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
>  	{ .parse_prop = parse_io_channels, },
>  	{ .parse_prop = parse_interrupt_parent, },
>  	{ .parse_prop = parse_dmas, .optional = true, },
> -	{ .parse_prop = parse_power_domains, },
> +	{ .parse_prop = parse_power_domains, .optional_con_dev = true, },
>  	{ .parse_prop = parse_hwlocks, },
>  	{ .parse_prop = parse_extcon, },
>  	{ .parse_prop = parse_nvmem_cells, },
> 

State syncing keeps working with this patch as before on Tegra.
