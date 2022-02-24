Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C70C4C2AFE
	for <lists+linux-pm@lfdr.de>; Thu, 24 Feb 2022 12:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiBXLgR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Feb 2022 06:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiBXLgP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Feb 2022 06:36:15 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDBD29A542
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 03:35:45 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id g39so3276862lfv.10
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 03:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=NZuHngch+JHmuvEgqQBfXkIpYeRT4dKdef8WxS2/DVs=;
        b=Wj4krb0/K5PH2S4BJw9+lss9C+vkmn9+8qNQVlgbW/GE80IlTfPjahOoLIr4RyMbAM
         bq261C9C3GWIYmqVyMEWLPZoKrAnxAtGY+M0hn7F5O5Yp/0oCvjxzzvVgc6ibrUmp6vX
         8xATWe8iA6qKyCSDjZ9ui5xu8KrJZn0GofwZYx+UFs/wAKeLM6JQw8JjirJbwNxKrrc5
         1RzhCJ4L3a/Xaxmksr1EMcl3sdjwzjndC13gdhb8NuUr63M70aXckfjKlOVRJqiZ+X+C
         uztuD950dVqeTH9h5ODE4LIXYoBJnCVZ3SC84kxO9kt40j6I6CafyqPq7WGvZPP/T+VQ
         u8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=NZuHngch+JHmuvEgqQBfXkIpYeRT4dKdef8WxS2/DVs=;
        b=Pfq5jpgG1nagTawxuhQ+V7qz5CHGTmLuiZKWwjZuuhVuT+5GkJ/Pt5twicMomTQdxn
         tEDcL79FOT5/OLoFY37K9TICuNpUu1UgFso502dzqp8GuY5zgacwqLWrJGOQLvANNOOz
         f/Ao6VUyzZoqzDkDDBqBQO6ppn4yzb7wJLQ6DRFFCMl37UaMgNcgr0//kP4sejalk/8r
         tDVi/kIOi0nlT3W4u71WgvpC8doYfuIXMS7U96IJf4a9xS5iRFKfJ8Svut2fXTXcapUo
         N8MShZtHZYylmYfp1Wkxi2GjVFKUmf/WwKsW2l5ZYGPaTtBeuHnKRHVWufC/UQXvhRMb
         UY4w==
X-Gm-Message-State: AOAM531it51auq9so0tT9uDq5No7b1jTZcFdVBYTpMmI1BdWAnM3I0Tm
        KoUx3pG5VT9SixFIk3OnkOUrqlVVSfo=
X-Google-Smtp-Source: ABdhPJz50zftGW1fZ7H+WJg8HIO2lTXHud3mLl9rNxMRPwiPYOi5MfhjBbJYKfxV7thgCCMzh800nw==
X-Received: by 2002:ac2:41d0:0:b0:437:929a:124a with SMTP id d16-20020ac241d0000000b00437929a124amr1561262lfi.214.1645702543941;
        Thu, 24 Feb 2022 03:35:43 -0800 (PST)
Received: from [192.168.2.145] (109-252-137-194.dynamic.spd-mgts.ru. [109.252.137.194])
        by smtp.googlemail.com with ESMTPSA id t4sm314080ljh.67.2022.02.24.03.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 03:35:43 -0800 (PST)
Message-ID: <666e7ad7-1eb2-f8bb-8ef8-d92d5e18d01b@gmail.com>
Date:   Thu, 24 Feb 2022 14:35:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] power: supply: Use an rbtree rather than flat register
 cache
Content-Language: en-US
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org
References: <20220222214331.1557723-1-broonie@kernel.org>
 <951baa84-1613-7567-4426-ffc6412994da@gmail.com>
In-Reply-To: <951baa84-1613-7567-4426-ffc6412994da@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

24.02.2022 14:07, Dmitry Osipenko пишет:
> 23.02.2022 00:43, Mark Brown пишет:
>> The smb347 has a very sparse register map (the maximum register is 0x3f but
>> less than 10% of the possible registers appear to be defined) and doesn't
>> have any hardware defaults specified so the sparser data structure of an
>> rbtree is a better fit for it's needs than a flat cache. Since it uses I2C
>> for the control interface there is no performance concern with the slightly
>> more involved code so let's convert it.
>>
>> This will mean we avoid any issues created by assuming that any previously
>> unaccessed registers hold a value that doesn't match what's in the hardware
>> (eg, an _update_bits() suppressing a write).
>>
>> Signed-off-by: Mark Brown <broonie@kernel.org>
>> ---
>>  drivers/power/supply/smb347-charger.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
>> index d56e469043bb..1511f71f937c 100644
>> --- a/drivers/power/supply/smb347-charger.c
>> +++ b/drivers/power/supply/smb347-charger.c
>> @@ -1488,8 +1488,7 @@ static const struct regmap_config smb347_regmap = {
>>  	.max_register	= SMB347_MAX_REGISTER,
>>  	.volatile_reg	= smb347_volatile_reg,
>>  	.readable_reg	= smb347_readable_reg,
>> -	.cache_type	= REGCACHE_FLAT,
>> -	.num_reg_defaults_raw = SMB347_MAX_REGISTER,
>> +	.cache_type	= REGCACHE_RBTREE,
> 
> Why you removed the num_reg_defaults_raw? It was needed in order to
> populate the default values on the regcache init, is it somehow
> different for the REGCACHE_RBTREE? Otherwise this patch is incorrect.

To make it more clear.. there was no problem with "suppressing a write",
the problem was that regmap reads are done from the cache, and if cache
isn't per-initialized, then you read zeros from the cache until write is
made.
