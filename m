Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7D17B7C42
	for <lists+linux-pm@lfdr.de>; Wed,  4 Oct 2023 11:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbjJDJhC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Oct 2023 05:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbjJDJhB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Oct 2023 05:37:01 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD98B8
        for <linux-pm@vger.kernel.org>; Wed,  4 Oct 2023 02:36:57 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5363227cc80so3168792a12.3
        for <linux-pm@vger.kernel.org>; Wed, 04 Oct 2023 02:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696412216; x=1697017016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Guzco4DSTTWXEfu8ybH7kjykVNG0n/YKMR7x/qH9e8=;
        b=AXBse7OIikUbZdQzQ4vENGkPzRkgu770UOtiGwMzyIsVN3bKvMrnOHduil55Mc4O9C
         8Vuo6Fvl7DNjvWIarrdWLcN0OAVH2ZMA+M/AjYygCa7ZhFENmpq4ezXDbJ9ovbnN5eRW
         MOhrIE9xGIiUEN8vjOBzdnFg36EUjsJkktfnsZ0MdpCsymzPMa9gXOWXDIz6gELF6R1B
         F33QqaP8yv99Uat09x3dU9UAZoXFUwqHCOt/SMtjlk+3Z8uIz9HOjGhNieVuya6Xwply
         lYmCIKdvTNSl+g/8Nb4QI5WLPQRzAFmJHSqSC4DuLBCaSWmUgxa731ZdVilmFLs862d2
         qu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696412216; x=1697017016;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Guzco4DSTTWXEfu8ybH7kjykVNG0n/YKMR7x/qH9e8=;
        b=UDDw6Yu2lN25OQOl/EUGiUpLvT0A6dtXW02d4R3sdRyn1xY/VGTSl3YuqujOI+G9wL
         xzPeiXrszAuhll+y+PXbb8KwtNUYsUv0eEdzilBhqqZVPR0W0T6Ezp797npH/pEyqpAf
         sGDHSk/LD9FICkRxbfgv2usnVhO5VIXT5w4ImmTXYCwnWJnbpokOWIT8Gkn4h2sGmiz3
         BEF+RSeWWye2cCJ9uqa6BkyoyLmhJDYApNSHT6vHgbJrxj1+AUDY6V5ACQbgZPHElSdD
         zcuvPV2F1bdRKcrmKoifERWLHaYM+8804MbCb+1tJZZDE7jlSmsrnwddSyY4H0XXYfou
         wnJQ==
X-Gm-Message-State: AOJu0YwKhs9Hh0HbTBqfTVy7eK9zzejgbwGlawI5sbn46pg6JTexkaVU
        RjzyzcBbi3BAeaJp3gH8k9/aJNl98OQnOHkI2iM=
X-Google-Smtp-Source: AGHT+IEoubDP+B0lU2jNpnEUEsVHJUJVFBBTVjFgOdeCBxKG0jZjj0Ek+Gv193MqbBNX8ImHfHwjUg==
X-Received: by 2002:a17:906:8467:b0:9ae:62ec:f4a1 with SMTP id hx7-20020a170906846700b009ae62ecf4a1mr1472429ejc.33.1696412216340;
        Wed, 04 Oct 2023 02:36:56 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:a496:68ab:9165:6f16? ([2a05:6e02:1041:c10:a496:68ab:9165:6f16])
        by smtp.googlemail.com with ESMTPSA id 6-20020a05600c22c600b0040303a9965asm1042161wmg.40.2023.10.04.02.36.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 02:36:55 -0700 (PDT)
Message-ID: <1c551796-0143-a511-8c51-1feafab031d8@linaro.org>
Date:   Wed, 4 Oct 2023 11:36:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/6] thermal: core: Add function to walk trips under
 zone lock
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <4846448.GXAFRqVoOG@kreacher> <2169023.irdbgypaU6@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2169023.irdbgypaU6@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03/10/2023 15:17, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add a wrapper around for_each_thermal_trip(), called
> thermal_zone_for_each_trip(), that will invoke the former under the
> thermal zone lock and pass its return value to the caller.
> 
> Two drivers will be modified subsequently to use this new function.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

