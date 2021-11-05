Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8CC445DE1
	for <lists+linux-pm@lfdr.de>; Fri,  5 Nov 2021 03:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhKECXE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Nov 2021 22:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbhKECXE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Nov 2021 22:23:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AFEC061714
        for <linux-pm@vger.kernel.org>; Thu,  4 Nov 2021 19:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=20NjZ2iAj1oxQiLvRxWu/b283lMgJvFLxy3x8iNiiz4=; b=o6olz4jMKvurx+m4Gc210ZK1Zn
        RlO146o8XxUmESqg6siHXOdjwETEpA1NaZEsDg1i4HGeA7MwPHKgxBYpBWss180M3PLDkyM8dKn8s
        wEBfDAGOv1FsjQCYfHULVt0DaMKJGWf6y+HXMuBe++LN5al6MaoXIp0q2M7ZAmwzw/c6kpqN7uvRL
        1SCNPrMa5kI4SnOH7RGqR16JomlFPBqrYim7vdPy0T9biBkdh/D0w0KT1wCONKA+5mLMA2cNbl+Tx
        5zU+GAjQeseghstbuHU8HAmAn55vXt49COOKBied9hwpEV2/ZS6yysIyp0VnxwjgEPSr4FbEruL+l
        iE+E62Ig==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mioq8-00APUE-KH; Fri, 05 Nov 2021 02:20:24 +0000
Subject: Re: [PATCH] power: supply: core: Add kerneldoc to battery struct
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org
References: <20211105003026.970184-1-linus.walleij@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d296ee8c-f6f0-aa42-e261-ed631f598fd0@infradead.org>
Date:   Thu, 4 Nov 2021 19:20:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211105003026.970184-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 11/4/21 5:30 PM, Linus Walleij wrote:
> This complements the struct power_supply_battery_info with
> extensive kerneldoc explaining the different semantics of the
> fields, including an overview of the CC/CV charging concepts
> implicit in some of the struct members.
> 
> This is done to first establish semantics before I can
> add more charging methods by breaking out the CC/CV parameters
> to its own struct.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>   include/linux/power_supply.h | 209 +++++++++++++++++++++++++++++++----
>   1 file changed, 186 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 9ca1f120a211..671730c5279f 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -342,37 +342,200 @@ struct power_supply_resistance_temp_table {
>   
>   #define POWER_SUPPLY_OCV_TEMP_MAX 20
>   
> -/*
> +/**
> + * struct power_supply_battery_info - information about batteries
> + * @technology: from the POWER_SUPPLY_TECHNOLOGY_* enum
> + * @energy_full_design_uwh: energy content when fully charged in microwatt
> + *   hours
> + * @charge_full_design_uah: charge content when fully charged in microampere
> + *   hours
> + * @voltage_min_design_uv: minimum voltage across the poles when the battery
> + *   is at minimum voltage level in microvolts. If the voltage drops below this
> + *   level the battery will need precharging when using CC/CV charging.
> + * @voltage_max_design_uv: voltage across the poles when the battery is fully
> + *   charged in microvolts. This is the "nominal voltage" i.e. the voltage
> + *   printed on the label of the battery.
> + * @tricklecharge_current_ua: the tricklecharge current used when trickle
> + *   charging the battery in microamperes. This is the charging phase when the
> + *   battery is fully charged and we just trickle in some current to keep the
> + *   voltage up between constant_charge_voltage_max_uv and overvoltage_limit_uv.
> + * @precharge_current_ua: current to use in the precharge phase in microamperes,
> + *   the precharge rate is limited by limiting the current to this value.
> + * @precharge_voltage_max_uv: the maximum voltage allowed when precharging in
> + *   microvolts. When we pass this voltage we will nominally switch over to the
> + *   next charging phase defined by constant_charge_current_ua and
> + *   constant_charge_voltage_max_uv.
> + * @charge_term_current_ua: when the current in the CV (constant voltage)
> + *   charging phase drops below this value in microamperes the charging will
> + *   terminate completely and not restart until the voltage over the battery
> + *   poles reach charge_restart_voltage_uv unless we use trickle charging.
> + * @charge_restart_voltage_uv: when the battery has been fully charged by
> + *   CC/CV charging and charging has been disabled, and the voltage subsequently
> + *   drops below this value in microvolts, the charging will be restarted
> + *   (typically using CV charging).
> + * @overvoltage_limit_uv: when tricklecharging the battery can temporarily
> + *   exceed the nominal voltage voltage_max_design_uv. The tricklecharginging
> + *   must stop when we reach this value, not to restart unless we get back
> + *   down to constant_charge_voltage_max_uv.
> + * @constant_charge_current_max_ua: current in microamperes to use in the CC
> + *   (constant current) charging phase. The charging rate is limited
> + *   by this current. This is the main charging phase and as the current is
> + *   constant into the battery the voltage slowly ascends to
> + *   constant_charge_voltage_max_uv.
> + * @constant_charge_voltage_max_uv: voltage in microvolts signifying the end of
> + *   the CC (constant current) charging phase and the beginning of the CV
> + *   (constant voltage) charging phase.
> + * @factory_internal_resistance_uohm: the internal resistance of the battery
> + *   at fabrication time, expressed in microohms. This resistance will vary
> + *   depending on the lifetime and charge of the battery, so this is just a
> + *   nominal ballpark figure.
> + * @ocv_temp: array indicating the open circuit voltage (OCV) capacity
> + *   temperature indices. This is an array of temperatures in degrees celsius

                                                            preferably    Celsius

> + *   indicating which capacity table to used for a certain temperature, since
> + *   the capacity for reasons of chemistry will be different at different
> + *   temperatures. Determining capacity is a multivariate problem and the
> + *   temperature is the first variable we determine.
> + * @temp_ambient_alert_min: the battery will go outside of operating conditions
> + *   when the ambient temperature goes below this temperature in degrees
> + *   celsius.
> + * @temp_ambient_alert_max: the battery will go outside of operating conditions
> + *   when the ambient temperature goes above this temperature in degrees
> + *   celsius.

Ditto. et al.

> + * @temp_alert_min: the battery should issue an alert if the internal
> + *   temperature goes below this temperature in degrees celsius.
> + * @temp_alert_max: the battery should issue an alert if the internal
> + *   temperature goes above this temperature in degrees celsius.
> + * @temp_min: the battery will go outside of operating conditions when
> + *   the internal temperature goes below this temperature in degrees celsius.
> + *   Normally this means the system should shut down.
> + * @temp_max: the battery will go outside of operating conditions when
> + *   the internal temperature goes above this temperature in degrees celsius.
> + *   Normally this means the system should shut down.
> + * @ocv_table: for each entry in ocv_temp there is a corresponding entry in
> + *   ocv_table and a size for each entry in ocv_table_size. These arrays
> + *   determine the capacity in percent in relation to the voltage in microvolts
> + *   at the indexed temperature.
> + * @ocv_table_size: for each entry in ocv_temp this array is giving the size of
> + *   each entry in the array of capacity arrays in ocv_table.
> + * @resist_table: this is a table that correlates a resistance to an internal
> + *   temperature of a battery. This can be achieved by a separate thermistor to
> + *   supply voltage on a third terminal on a battery which is the most
> + *   reliable. An external thermistor can also be used sometimes.
> + * @resist_table_size: the number of items in the resist table.
> + *
>    * This is the recommended struct to manage static battery parameters,
>    * populated by power_supply_get_battery_info(). Most platform drivers should
>    * use these for consistency.
> + *
>    * Its field names must correspond to elements in enum power_supply_property.
>    * The default field value is -EINVAL.
> - * Power supply class itself doesn't use this.
> + *
> + * The charging parameters here assumes a CC/CV charging scheme. This method

                                    assume

> + * is most common with Lithium Ion batteries (other methods are possible) and
> + * looks as follows:
> + *
> + * ^ Battery voltage
...
> + * +------------------------------------------------------------------> time
> + *
> + * ^ Current into the battery
...
> + * +-----------------------------------------------------------------> time
> + *
> + * These diagrams are synchronized on time and the voltage and current
> + * follow each other.
> + *
> + * With CC/CV charging commence over time like this for an empty battery:
> + *
> + * 1. First a small initial pre-charge current (precharge_current_ua)
> + *    is applied if the voltage is below precharge_voltage_max_uv until we
> + *    reach precharge_voltage_max_uv. CATION: in some text this is referred

                                          CAUTION:        texts
(although CATION is a word!)

> + *    to as "trickle charging" but the use in the Linux kernel is differen

                                                                      different

> + *    see below!
> + *
> + * 2. Then the main charging current is applied, which is called the constant
> + *    current (CC) phase. A current regulator is set up to allow
> + *    constant_charge_current_max_ua of current to flow into the battery.
> + *    The chemical reaction in the battery will make the voltage go up as
> + *    charge goes into the battery. This current is applied until we reach
> + *    the constant_charge_voltage_max_uv voltage.
> + *
> + * 3. At this voltage we switch over to the constant voltage (CV) phase. This
> + *    means we allow current to go into the battery, but we keep the voltage
> + *    fixed. This current will continue to charge the battery while keeping
> + *    the voltage the same. A chemical reaction in the battery goes on
> + *    storing energy without affecting the voltage. Over time the current
> + *    will slowly drop and when we reach charge_term_current_ua we will
> + *    end the constant voltage phase.
> + *
> + * After this the battery is fully charged, and if we do not support trickle
> + * charging, the charging will not restart until power dissapation make the

                                                           dissipation makes

> + * voltage fall so that we reach charge_restart_voltage_uv and at this point
> + * we restart charging at the appropriate phase, usually this will be inside
> + * the CV phase.


Tested-by: Randy Dunlap <rdunlap@infradead.org>

and if (when :) you fix these, you can add

Acked-by: Randy Dunlap <rdunlap@infradead.org>


Thanks for doing this.

-- 
~Randy
