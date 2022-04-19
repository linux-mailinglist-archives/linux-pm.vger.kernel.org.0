Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998F35067AD
	for <lists+linux-pm@lfdr.de>; Tue, 19 Apr 2022 11:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241584AbiDSJ3S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Apr 2022 05:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241574AbiDSJ3R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Apr 2022 05:29:17 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C8E27FCF
        for <linux-pm@vger.kernel.org>; Tue, 19 Apr 2022 02:26:35 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bq30so28326580lfb.3
        for <linux-pm@vger.kernel.org>; Tue, 19 Apr 2022 02:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ucCTRELX4zCTJzJPK11mYMzxPEoSt04PTFJD2yMathA=;
        b=HwYrgQlLdpFFev2Ri3U34hIAwlfFITtK+zpPCLMix9c7SomauYGioFgQD/PXMU2Pty
         6odKxSvmAOhpXBoqA7vY6xd1jG8CwaFM0YqVhgMwlBoRY7Oa/4eLyWdan9woK+jN5qpS
         sB18Ol1zkgeTb0OeTPpjchATjB9r2pLt5loXt88L2d5D1nGxuY5E+0fKPy0oSK6fSRFx
         WXD9JN8F03XCzxQOayuwG+YamN+5seBe+JHce3ZAwV/v6kg81KXc6yKM2hbBshHK5S5y
         GMwzJTR2/5wbLeFuIsY6yW3wbuv1vwS7gU14cFvDCPIhtgDTzCbaxOqrDx2DxykKVWkA
         C01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ucCTRELX4zCTJzJPK11mYMzxPEoSt04PTFJD2yMathA=;
        b=4BqKujxqmT8sMGSQWGRc5J7pjnwzKmtVeKyQEYpFd1xuvCFbyaKb1nlWlYeOdT8Id+
         cq+SphsbUA5/2j0x2IAqEnJHRwVOwXMoYleSzoKd/7+vtSe4p5kiduvqC3ugxqZLf3Yh
         mLtakgTX7gwL+s4eUPGLiX6NtfpWOJinD7ltTfP/uazXYrkR5r3CM6bouMgAu9zkQYJz
         4lD1iJiisJ1U0ZXLNJhdNf6cJa30wAVGD+7AWPkCURficFiR130JsDWfJUq4Ehz2WxIX
         YPCNiLnmpFiM5AlzDUtMW/weVdOMA/37t1nzbGplmy9C5KgNNWY/s7aktcoQkJyS9Fkd
         /DHg==
X-Gm-Message-State: AOAM530J6JCWA7iwkx//zCd19izpIRkYtkhEzSzneS9JvJmld3f3J7Gs
        wPFsu+xAcZsWnJ7oH1JP/io=
X-Google-Smtp-Source: ABdhPJxVQsVyReutFIgh5sQbmfQgzKjwyo+X3zjrf/DdkvH1Efgi3akEDAu7WQqm8VAJKq2wO57Bag==
X-Received: by 2002:a05:6512:3ba0:b0:471:6396:6b2a with SMTP id g32-20020a0565123ba000b0047163966b2amr8140928lfv.432.1650360393350;
        Tue, 19 Apr 2022 02:26:33 -0700 (PDT)
Received: from [172.16.187.191] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id q20-20020a05651232b400b00470010b25c3sm1101818lfe.206.2022.04.19.02.26.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 02:26:32 -0700 (PDT)
Message-ID: <36001b47-99fc-1b49-49e7-018f81b717c4@gmail.com>
Date:   Tue, 19 Apr 2022 12:26:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] power: supply: ab8500: Exit maintenance if too low
 voltage
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org
References: <20220415203638.361074-1-linus.walleij@linaro.org>
 <20220415203638.361074-2-linus.walleij@linaro.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20220415203638.361074-2-linus.walleij@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi deee Ho Linus,

On 4/15/22 23:36, Linus Walleij wrote:
> The maintenance charging is supposedly designed such that the
> maintenance current compensates for the battery discharge curve,
> and as the charging progress from CC/CV -> maintenance A ->
> maintenance B states, we end up on a reasonable voltage to
> restart ordinary CC/CV charging after the safety timer at the
> maintenance B state exits.
> 
> However: old batteries discharge quicker, and in an old
> battery we might not get to the expiration of the maintenance B
> timer before the battery is completely depleted and the system
> powers off with an empty battery.
> 
> This is hardly the desire of anyone leaving their phone in the
> charger for a few days!
> 
> Introduce a second clause in both maintenance states such that
> we exit the state and return to ordinary CC/CV charging if
> the voltage drops below charge_restart_voltage_uv or 95%
> if this is not defined for the battery.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>   drivers/power/supply/ab8500_chargalg.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
> index b9622eb9fc72..1b23b5261881 100644
> --- a/drivers/power/supply/ab8500_chargalg.c
> +++ b/drivers/power/supply/ab8500_chargalg.c
> @@ -1514,6 +1514,14 @@ static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
>   			ab8500_chargalg_stop_maintenance_timer(di);
>   			ab8500_chargalg_state_to(di, STATE_MAINTENANCE_B_INIT);
>   		}
> +		/*
> +		 * This happens if the voltage drops too quickly during
> +		 * maintenance charging, especially in older batteries.
> +		 */
> +		if (ab8500_chargalg_time_to_restart(di)) {
> +			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
> +			dev_info(di->dev, "restarted charging from maintenance state A - battery getting old?\n");
> +		}
>   		break;
>   
>   	case STATE_MAINTENANCE_B_INIT:
> @@ -1538,6 +1546,14 @@ static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
>   			ab8500_chargalg_stop_maintenance_timer(di);
>   			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
>   		}
> +		/*
> +		 * This happens if the voltage drops too quickly during
> +		 * maintenance charging, especially in older batteries.
> +		 */
> +		if (ab8500_chargalg_time_to_restart(di)) {
> +			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
> +			dev_info(di->dev, "restarted charging from maintenance state B - battery getting old?\n");
> +		}
>   		break;
>   
>   	case STATE_TEMP_LOWHIGH_INIT:


Probably just a matter of taste (like underscores in private function 
names ;] ) - I would prefer combining the cases for INITs to something like:

	case STATE_MAINTENANCE_A_INIT:
	case STATE_MAINTENANCE_B_INIT:

		mt = power_supply_get_maintenance_charging_setting(bi,
			(di->charge_state == STATE_MAINTENANCE_B_INIT));

...
		ab8500_chargalg_state_to(di, di->charge_state + 1);

	break;

That would slightly reduce the code although at the cost of additional 
arithmetics. I'm leaving this to you though.

FWIW: After someone telling me that I should not worry about the cold 
weather (ref. my comment for the patch 1/2)

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>


Best Regards
	-- Matti

