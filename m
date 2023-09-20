Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950567A8324
	for <lists+linux-pm@lfdr.de>; Wed, 20 Sep 2023 15:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbjITNUX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Sep 2023 09:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbjITNUW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Sep 2023 09:20:22 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E68A9
        for <linux-pm@vger.kernel.org>; Wed, 20 Sep 2023 06:20:15 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52a49a42353so8530901a12.2
        for <linux-pm@vger.kernel.org>; Wed, 20 Sep 2023 06:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695216014; x=1695820814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MHBrblzB+i2M2dKo5AOf+BBmdJCshrIq3n7KCqpT3BQ=;
        b=M8a43qN5jDbNngZdYGqD5Y4AFYAsucSHvsPebKHJmNFYqlVHkjWovNfBeqWmi44Blt
         Rkcm4TIvIBlTKF2csPvmBxehipb1j69wJKyPbYVIjzpjntTIhQK8wlYZgN0O+JltanHD
         /zWg8T0pgUcF1tmslw26TOY05YFNEkN0kEsTrnL9E28mCJz0nNMOEdW7l+R6g7ba2h8C
         Ow6EO5olhz+3yR6ZRAkfLUQxIhYyOrx5KNwrZRfCM6SnEMRc2IInVvn8+NqP5BPz7P06
         5NC6xhra24zRtSOIPfiH95/rrc1k/Yo5gqTB0gG31Y8LYQOsKCpj70jyJuxOY229Hwov
         yZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695216014; x=1695820814;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MHBrblzB+i2M2dKo5AOf+BBmdJCshrIq3n7KCqpT3BQ=;
        b=mgSCcEbnTA+1+rttckAZ9ZEZUhQOzc3ruCO/XyAEJvSyxAD/BPTqvYWWYyHshL3xA2
         kXiFPrJ/dt2IDEkGR8B2qVew77Nq2DkjNEkWbhYGsWF0JwzRbG3pKXyE8J+Qq++doPpx
         2gJJfykWRn01WhxxF6eP956Q/Jhv9KFFC6CRZBgrp+fXEum8d0A63Ptwg2z+Mzf1zQ7L
         a7jDwEnbwiNTSW6K0SzKrsAqB20cmffqS7hPDJB1F5nSqFdlf+W2zsA3ZC1X3Qooqbkn
         6Iczs7KMZNpOJU4fAWZB7MnJcIYDFvHf6DSjoZN9V6tSWI8FsPLZUmW+6s67wwooFP5n
         0dMg==
X-Gm-Message-State: AOJu0Yx0gSTEqTISOGbuYLsPxP0Hr6cj9dbP/oAor+tyNPYEMxhN+2dY
        K8dLvdWLLmvlpKb7f4f2qCuj3pSB/0cvx9RB9STqZQ==
X-Google-Smtp-Source: AGHT+IHzE/a8e2IPoGup+KCY1RZlYkERGEBM8G9T0qDdGb6P0jNOS86ub85iYvjrT4nDVB6HzuRQuw==
X-Received: by 2002:a05:6402:297:b0:52a:250e:a052 with SMTP id l23-20020a056402029700b0052a250ea052mr2138008edv.7.1695216014259;
        Wed, 20 Sep 2023 06:20:14 -0700 (PDT)
Received: from [172.20.122.226] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.googlemail.com with ESMTPSA id n16-20020a05640206d000b0052f3051f7d2sm8927336edy.80.2023.09.20.06.20.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 06:20:13 -0700 (PDT)
Message-ID: <289d5ed9-8879-91b5-d5fe-948ff2dd61d2@linaro.org>
Date:   Wed, 20 Sep 2023 15:20:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1] thermal: core: Drop trips_disabled bitmask
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Ido Schimmel <idosch@nvidia.com>
References: <12296181.O9o76ZdvQC@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <12296181.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19/09/2023 20:54, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After recent changes, thermal_zone_get_trip() cannot fail, as invoked
> from thermal_zone_device_register_with_trips(), so the only role of
> the trips_disabled bitmask is struct thermal_zone_device is to make
> handle_thermal_trip() skip trip points whose temperature was initially
> zero.  However, since the unit of temperature in the thermal core is
> millicelsius, zero may very well be a valid temperature value at least
> in some usage scenarios and the trip temperature may as well change
> later.  Thus there is no reason to permanently disable trip points
> with initial temperature equal to zero.
> 
> Accordingly, drop the trips_disabled bitmask along with the code
> related to it.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The logical change after changing how the trip point are handled ;)

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

