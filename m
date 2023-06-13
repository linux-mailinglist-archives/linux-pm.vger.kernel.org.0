Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1B872E572
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jun 2023 16:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242793AbjFMON1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Jun 2023 10:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242895AbjFMONX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jun 2023 10:13:23 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0585EC
        for <linux-pm@vger.kernel.org>; Tue, 13 Jun 2023 07:12:52 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f7378a75c0so42576955e9.3
        for <linux-pm@vger.kernel.org>; Tue, 13 Jun 2023 07:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686665571; x=1689257571;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+jDLKP7QVBlzynmtRh0Z7fKYi859hQtE7sIS1qPZ6cs=;
        b=dtlT9erKUE0lbsQ7LEI1yKuWbUzTVsV5wRCBWpPS8X555VpiVirMSJzUdCh8Rp69tm
         5qLZ/kHUYAmmbVYDuPgqAzA52gJeePeIPb6MD2EFoYuMrBJMjksIjw6PmZaybBo2h9cp
         1EqGJuSjMPVzEHYxweD22/d9S18gRhlaT8rC6vNAn7ssY+1PNaGhRQ1tklAm7MxzUb3g
         ENa5DT4KijTIcsOcAv21+quK6wYCFlI+iDPZK8vH5ZOyI7E84daVcO5+L42dV+ht+mF4
         RslDumdhsH5vEBvljoS1WuisUn0fOMGonKS4hVyYazE+MN9u3pQ77OBiBHFu9pN9YmOH
         Pi0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686665571; x=1689257571;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+jDLKP7QVBlzynmtRh0Z7fKYi859hQtE7sIS1qPZ6cs=;
        b=CHk5tE497eEHYY8IKJnP4+W2Jx27ZjfFvuqWhMpgnwg0VVYP00zOcyoReN+jp5phDl
         OoCuklssonYZQVabXqXroQsT+GV/l2mw0qPcopEQRiJgOl/QElxok8dwWk+j/mqk4mNR
         ruHWbWcYA414K7QklpuqTl+oBAnfFHu3yiQV6BmekN6i2J692WQDLBH/yfFjxQZxEhOE
         lfF9H1gukWFmk20MkhJt6XYQ3L0/2S/x/S+l8q4T5m39W4QWBqOIEFX1faYSsu63b1/o
         /n0Pua9VtEUxeS0BTUb+b+lqir1B1xFw79xF0qjGy4Y/dpjqpZMw3AR8U76E3JWZtWWy
         MD4A==
X-Gm-Message-State: AC+VfDwG4kalKkkQuBsMyF3fsZl4R47HDRA+hX715S2bfa3zJFEjERoG
        pqFTWJ61Tos99PqEK483ipm22Q==
X-Google-Smtp-Source: ACHHUZ68Vs68NTI8VIpCNTheg+R1K1xwqCim2h4KqSdzdxg7dDUaexwoEyhiksy4AYW0IcvAMELB4A==
X-Received: by 2002:a7b:c30c:0:b0:3f4:298b:d925 with SMTP id k12-20020a7bc30c000000b003f4298bd925mr8879573wmj.41.1686665571177;
        Tue, 13 Jun 2023 07:12:51 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:d6bf:b78b:2fff:653a? ([2a05:6e02:1041:c10:d6bf:b78b:2fff:653a])
        by smtp.googlemail.com with ESMTPSA id t1-20020adfe101000000b0030e5a63e2dbsm15635804wrz.80.2023.06.13.07.12.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 07:12:50 -0700 (PDT)
Message-ID: <e9d2e286-df54-1b6f-484b-afadaf594e82@linaro.org>
Date:   Tue, 13 Jun 2023 16:12:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/8] Finish thermal zone structure encapsulation
Content-Language: en-US
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, thierry.reding@gmail.com
References: <20230525140135.3589917-1-daniel.lezcano@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230525140135.3589917-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Rafael,

On 25/05/2023 16:01, Daniel Lezcano wrote:
> The series are the last changes to self-encapsulate the thermal zone device
> structure in order to protect wild accesses to the thermal zone device
> internals, especially the trip points and the locks.
> 
> Meanwhile the latest changes, a new driver has come via the network tree which
> directly accesses the thermal zone device structure information and uses the
> old thermal_zone_device_register function. The first patch does the change to
> use the accessor and the new registering function. It is expected to have the
> changes to go through the thermal tree along with the other patches.
> 
> The second patch adds a macro to warn at compilation time if the
> thermal_core.h is included in a file not belonging to the thermal core
> code. One warning will happen with the nvidia drivers but this is in
> the way to be solved.
> 
> The third patch reorders the headers inclusion in the core code.
> 
> The fourth patch provides an API to update the thermal trips of a
> thermal zone. This function takes care of the locking and the thermal
> zone update.
> 
> The next patches makes the int340x drivers to use the thermal trip
> update above and the different accessors for thermal zone structure.
> 
> Finally the last patch moves the thermal zone device structure from
> the exported thermal.h header to the thermal core private header.

I think we are all pretty busy for this cycle and that series did not 
raised any comments (yet?).

I would like to go forward with the generic trip points changes and 
finish the conversion so we can fix the trip points monitoring once and 
for all. This series consolidate the self-encapsulation of the thermal 
zone device to prevent changing the trip points directly in the thermal 
zone device structure.

Most of the patches of this series don't have functional changes.

If nobody has concern with it, I propose to pick them up in the next days.

> Daniel Lezcano (8):
>    net/mlx5: Update the driver with the recent thermal changes
>    thermal/core: Hardening the self-encapsulation
>    thermal/core: Reorder the headers inclusion
>    thermal/core: Update the generic trip points
>    thermal/drivers/int3400: Use thermal zone device wrappers
>    thermal/drivers/int340x: Do not check the thermal zone state
>    thermal/drivers/int340x: Use thermal zone device trip update
>    thermal/core: Move the thermal zone structure to the private core
>      header
> 
>   .../net/ethernet/mellanox/mlx5/core/thermal.c | 15 ++--
>   drivers/thermal/gov_bang_bang.c               |  1 +
>   drivers/thermal/gov_fair_share.c              |  1 +
>   drivers/thermal/gov_power_allocator.c         |  7 +-
>   drivers/thermal/gov_step_wise.c               |  1 +
>   drivers/thermal/gov_user_space.c              |  1 +
>   .../intel/int340x_thermal/int3400_thermal.c   | 44 +++++-----
>   .../int340x_thermal/int340x_thermal_zone.c    | 17 ++--
>   drivers/thermal/thermal_acpi.c                |  1 +
>   drivers/thermal/thermal_core.c                | 47 +++++------
>   drivers/thermal/thermal_core.h                | 82 +++++++++++++++++++
>   drivers/thermal/thermal_helpers.c             |  1 +
>   drivers/thermal/thermal_hwmon.c               |  1 +
>   drivers/thermal/thermal_netlink.c             |  1 +
>   drivers/thermal/thermal_of.c                  |  1 +
>   drivers/thermal/thermal_sysfs.c               |  1 +
>   drivers/thermal/thermal_trip.c                | 79 ++++++++++++++++++
>   include/linux/thermal.h                       | 79 +-----------------
>   18 files changed, 241 insertions(+), 139 deletions(-)
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

