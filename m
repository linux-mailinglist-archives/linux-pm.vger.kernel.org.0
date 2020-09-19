Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74205271047
	for <lists+linux-pm@lfdr.de>; Sat, 19 Sep 2020 21:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgISTco (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 19 Sep 2020 15:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgISTco (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 19 Sep 2020 15:32:44 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3560C0613CE;
        Sat, 19 Sep 2020 12:32:43 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a9so8743826wmm.2;
        Sat, 19 Sep 2020 12:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:cc:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=6boIJn1Hc6yrb/X3f5StEamiGaIf5qsazhLrdjuT1jg=;
        b=rKgy8J8Fi3dCPRbJA5BeAy3xNVjI1YvBMt+/4vHtRLOs98Asf+rRsb4GLm5oUMa+Mb
         3s1pPoFICMj5mVtTZ/Coa9FkZscpZmPvb7bPWLHrY7w56U2Q2lbn/VPcNkm6vXgOl2X0
         3CgnRPfepXJhVIyDQjY/aoQOfQV1eTWMcWBABW90M+b2C4bRpU7C6KH+thiwfzUJOMxK
         FLdpSydQwXUQgVRgBba9jHL70CS9HAr2VRBzjB3KDMiFyfLPhNHvMXAyVIWnaskAZsSO
         XPmLDb7sZyAF5q5gSjhFRMlRakdnuU4Rxt5q+4laOc80msmoyVIaaT8syEpmL3ZnS5f7
         St7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6boIJn1Hc6yrb/X3f5StEamiGaIf5qsazhLrdjuT1jg=;
        b=agGNG7BD8/vRRs2fTQNlYAtMjrIqQ6gQCi7xfvISvRxMbFmlKnaztiLBNK2Qmah/ya
         nIqt59S6OwRSmQMKKKmWzm1B3z7omFjsILkeTdlQFPp62ZT4gtFi8bnfS30wfIRwgzSa
         3rKZnGwq6nx50LIaACWR/fVuMQGCbrmx2lM+dZUUgCjKZBM21kZXiU36CADmlMcNqbsJ
         QNJpsTio0oIL1V1PfJeRp65hOVvuMyVw3FevG8TnZaDl/jZqpZwpOb/N8+X51iD/6RMo
         y6Nk3PDrnPXGAXSAGChqnKDWM9Y5Ibv7p2Ke8VcfGj5OcyyqTg+BH3F6FlOQDbGpMitR
         bN/A==
X-Gm-Message-State: AOAM532IxwygHfJ/USki1378TXJLkK5udXeWFNc+JAE2OtYdy8euIcsF
        H9NyfecdjoF9cdhxRQfIAnFZfIf9H8zHzQ==
X-Google-Smtp-Source: ABdhPJyNlKV2kgdVjY3G0msZ9YuKh9JVTs9EJZo7vcehlu+58pmD6tfcKEAYCH/mzh2qJH9Tt2eJ4g==
X-Received: by 2002:a1c:1f42:: with SMTP id f63mr21164283wmf.1.1600543962484;
        Sat, 19 Sep 2020 12:32:42 -0700 (PDT)
Received: from [192.168.43.148] (92.40.169.140.threembb.co.uk. [92.40.169.140])
        by smtp.gmail.com with ESMTPSA id 91sm13361561wrq.9.2020.09.19.12.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2020 12:32:42 -0700 (PDT)
Subject: Re: [PATCH] power: supply: charger-manager: Tidy function
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200902165816.401213-1-alex.dewar90@gmail.com>
From:   Alex Dewar <alex.dewar90@gmail.com>
Message-ID: <ad8f0610-b534-c699-e26f-3fa8c8637684@gmail.com>
Date:   Sat, 19 Sep 2020 20:32:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200902165816.401213-1-alex.dewar90@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-09-02 17:58, Alex Dewar wrote:
> check_charging_duration() contains some copy-pasted code, which makes it
> less readable. Refactor the function to be a bit tidier.
Ping?
>
> I've also fixed a couple of typos.
>
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> ---
>   drivers/power/supply/charger-manager.c | 39 +++++++++-----------------
>   1 file changed, 14 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
> index 07992821e252..67c7b1fb6601 100644
> --- a/drivers/power/supply/charger-manager.c
> +++ b/drivers/power/supply/charger-manager.c
> @@ -443,42 +443,31 @@ static int try_charger_enable(struct charger_manager *cm, bool enable)
>    * check_charging_duration - Monitor charging/discharging duration
>    * @cm: the Charger Manager representing the battery.
>    *
> - * If whole charging duration exceed 'charging_max_duration_ms',
> + * If whole charging duration exceeds 'charging_max_duration_ms',
>    * cm stop charging to prevent overcharge/overheat. If discharging
> - * duration exceed 'discharging _max_duration_ms', charger cable is
> + * duration exceeds 'discharging _max_duration_ms', charger cable is
>    * attached, after full-batt, cm start charging to maintain fully
>    * charged state for battery.
>    */
>   static int check_charging_duration(struct charger_manager *cm)
>   {
>   	struct charger_desc *desc = cm->desc;
> -	u64 curr = ktime_to_ms(ktime_get());
>   	u64 duration;
> -	int ret = false;
>   
> -	if (!desc->charging_max_duration_ms &&
> -			!desc->discharging_max_duration_ms)
> -		return ret;
> -
> -	if (cm->charger_enabled) {
> -		duration = curr - cm->charging_start_time;
> -
> -		if (duration > desc->charging_max_duration_ms) {
> -			dev_info(cm->dev, "Charging duration exceed %ums\n",
> -				 desc->charging_max_duration_ms);
> -			ret = true;
> -		}
> -	} else if (cm->battery_status == POWER_SUPPLY_STATUS_NOT_CHARGING) {
> -		duration = curr - cm->charging_end_time;
> +	if ((desc->charging_max_duration_ms == 0 &&
> +			desc->discharging_max_duration_ms == 0))
> +		return false;
> +	if (!cm->charger_enabled &&
> +			cm->battery_status != POWER_SUPPLY_STATUS_NOT_CHARGING)
> +		return false;
>   
> -		if (duration > desc->charging_max_duration_ms) {
> -			dev_info(cm->dev, "Discharging duration exceed %ums\n",
> -				 desc->discharging_max_duration_ms);
> -			ret = true;
> -		}
> +	duration = ktime_to_ms(ktime_get()) - cm->charging_start_time;
> +	if (duration > desc->charging_max_duration_ms) {
> +		dev_info(cm->dev, "Charging duration exceeds %ums\n",
> +				desc->charging_max_duration_ms);
> +		return true;
>   	}
> -
> -	return ret;
> +	return false;
>   }
>   
>   static int cm_get_battery_temperature_by_psy(struct charger_manager *cm,

