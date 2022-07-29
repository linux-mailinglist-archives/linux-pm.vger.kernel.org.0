Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566D7585366
	for <lists+linux-pm@lfdr.de>; Fri, 29 Jul 2022 18:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiG2Q2e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Jul 2022 12:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiG2Q2d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Jul 2022 12:28:33 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2DDDF60;
        Fri, 29 Jul 2022 09:28:32 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id q6-20020a05683033c600b0061d2f64df5dso2138514ott.13;
        Fri, 29 Jul 2022 09:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=FrtWAe2AWSu0ytBk+RY2IWenDv3uSIfc4SXJrDvpAqY=;
        b=QPmQKM62GdP8hGc0v1OaRUaMoS8Pe1YFqXzhyUddyLSPCUkgo9DY4QSi3B9mKnTlPQ
         6f4V8NLpMF6ef+Y3k8Bc0evv4yBrqdax4wxCyqGUTK2Y6cwYluo6Xfd/qNuBSfMs3u3C
         thD7FSyMzlKMuYTwaCiNSD7Noyw+DuFZ/OQ35Xmr1E9hoxGiA2IBnJ+f+VAT9dt7oDQ/
         vDks41oNJRKwDj72q0DoUoH4S9HVex6TRV4mTrJ5D2yFZIZ0TRXETwEE9zNTyU5X/qzp
         KMCVy2crItzeXUXZxE1POCIq+UrQF2xJT6AyVENuAQI3oqD3eNR+RnMyDxThxP1t41H/
         KfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=FrtWAe2AWSu0ytBk+RY2IWenDv3uSIfc4SXJrDvpAqY=;
        b=k9rEMkjkfrK4NOa/ve6mKIlCAzfzu5EscDgnzsyDSgFwToc26mKXItjqDAoh8j33TM
         vYbtHQ93o0OpueDWASdtnP+H6hxQ4rUl4hVYbDR2hWougUjKZlVV8Ntw9pknuImvoAdt
         J0FsnDluXnytMnSxxeFHSOLtIeG9u1Q6nIg3BScWIGUONY6WDJnYzhPV4nHec5cEPwaR
         lzJdr2VaTpFsTMZh1kYsUc/Bw1iCwgor6spyWvLwZTmXV5D5M8y9waxBALXa8MebhwKK
         4c89Rw2kjwdTIK18NxHeIPI3fL+tlXbpdI+V4GvHlfqXILNlhFyQ6S9NQCo2hYpSJ9Y7
         /iqA==
X-Gm-Message-State: AJIora8y3Ep2ZGUOn6a6AJo4Lm3M5sriJDB9WQx0+SNdebjkTt0N1uoE
        nP0WzN+yTjMAiUaZ7N1/PBzzn7d/O/U=
X-Google-Smtp-Source: AGRyM1sDiXIt2MwtbSK2xFqF1JMI9Nc7fPF548IZgZE1d7ZCWQ3tWKHPotsPIt8NdbUAfrA19RUdlQ==
X-Received: by 2002:a9d:58cc:0:b0:61c:efc0:5c75 with SMTP id s12-20020a9d58cc000000b0061cefc05c75mr1771997oth.167.1659112111423;
        Fri, 29 Jul 2022 09:28:31 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id v5-20020a4aaec5000000b0043540f7701esm1332748oon.31.2022.07.29.09.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 09:28:30 -0700 (PDT)
Date:   Fri, 29 Jul 2022 11:28:28 -0500
From:   Chris Morgan <macroalpha82@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-pm@vger.kernel.org, kbuild-all@lists.01.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        zhangqing@rock-chips.com, zyw@rock-chips.com,
        jon.lin@rock-chips.com, sre@kernel.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lee.jones@linaro.org, Chris Morgan <macromorgan@hotmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Subject: Re: [RESEND 3/4 v7] power: supply: Add charger driver for Rockchip
 RK817
Message-ID: <20220729162828.GB102@wintermute.localdomain>
References: <20220721161718.29800-4-macroalpha82@gmail.com>
 <202207242227.mttUkfTB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202207242227.mttUkfTB-lkp@intel.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Jul 24, 2022 at 10:58:00PM +0800, kernel test robot wrote:
> Hi Chris,
> 
> Thank you for the patch! Perhaps something to improve:

I'm afraid I'm not sure the best way to fix this. The only thing I can
think of is for now the driver should only be for systems with a
Rockchip RK817 PMIC (to my knowledge only ARM based systems from
Rockchip), but it looks like the arch was set as parisc. Even still,
as long as some of the functions ahead of it don't error out each
of those variables should be used. Is there a way to confirm these
warnings?

Thank you.

> 
> [auto build test WARNING on lee-mfd/for-mfd-next]
> [also build test WARNING on sre-power-supply/for-next rockchip/for-next linus/master v5.19-rc7 next-20220722]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Chris-Morgan/power-supply-Add-Support-for-RK817-Charger/20220722-002431
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
> config: parisc-allmodconfig (https://download.01.org/0day-ci/archive/20220724/202207242227.mttUkfTB-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/008e6f0d590e275cbb56d4506b5638156506dd40
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Chris-Morgan/power-supply-Add-Support-for-RK817-Charger/20220722-002431
>         git checkout 008e6f0d590e275cbb56d4506b5638156506dd40
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/power/supply/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/power/supply/rk817_charger.c: In function 'rk817_read_or_set_full_charge_on_boot':
> >> drivers/power/supply/rk817_charger.c:701:33: warning: variable 'soc_tmp3' set but not used [-Wunused-but-set-variable]
>      701 |         int soc_tmp1, soc_tmp2, soc_tmp3;
>          |                                 ^~~~~~~~
> >> drivers/power/supply/rk817_charger.c:701:23: warning: variable 'soc_tmp2' set but not used [-Wunused-but-set-variable]
>      701 |         int soc_tmp1, soc_tmp2, soc_tmp3;
>          |                       ^~~~~~~~
> >> drivers/power/supply/rk817_charger.c:701:13: warning: variable 'soc_tmp1' set but not used [-Wunused-but-set-variable]
>      701 |         int soc_tmp1, soc_tmp2, soc_tmp3;
>          |             ^~~~~~~~
> 
> 
> vim +/soc_tmp3 +701 drivers/power/supply/rk817_charger.c
> 
>    692	
>    693	static int
>    694	rk817_read_or_set_full_charge_on_boot(struct rk817_charger *charger,
>    695					struct power_supply_battery_info *bat_info)
>    696	{
>    697		struct rk808 *rk808 = charger->rk808;
>    698		u8 bulk_reg[4];
>    699		u32 boot_voltage, boot_charge_mah, tmp;
>    700		int ret, reg, off_time;
>  > 701		int soc_tmp1, soc_tmp2, soc_tmp3;
>    702		bool first_boot;
>    703	
>    704		/* Check if the battery is uninitalized. If it is, the columb counter
>    705		 * needs to be set up.
>    706		 */
>    707		ret = regmap_read(rk808->regmap, RK817_GAS_GAUGE_GG_STS, &reg);
>    708		if (ret < 0)
>    709			return ret;
>    710		first_boot = reg & RK817_BAT_CON;
>    711		/* If the battery is uninitialized, use the poweron voltage and an ocv
>    712		 * lookup to guess our charge. The number won't be very accurate until
>    713		 * we hit either our minimum voltage (0%) or full charge (100%).
>    714		 */
>    715		if (first_boot) {
>    716			regmap_bulk_read(rk808->regmap, RK817_GAS_GAUGE_PWRON_VOL_H,
>    717					 bulk_reg, 2);
>    718			tmp = get_unaligned_be16(bulk_reg);
>    719			boot_voltage = (charger->voltage_k * tmp) +
>    720					1000 * charger->voltage_b;
>    721			/* Since only implementation has no working thermistor, assume
>    722			 * 20C for OCV lookup. If lookup fails, report error with OCV
>    723			 * table.
>    724			 */
>    725			charger->soc = power_supply_batinfo_ocv2cap(bat_info,
>    726								    boot_voltage,
>    727								    20) * 1000;
>    728			if (charger->soc < 0)
>    729				charger->soc = 0;
>    730	
>    731			/* Guess that full charge capacity is the design capacity */
>    732			charger->fcc_mah = charger->bat_charge_full_design_uah / 1000;
>    733			/* Set battery as "set up". BSP driver uses this value even
>    734			 * though datasheet claims it's a read-only value.
>    735			 */
>    736			regmap_write_bits(rk808->regmap, RK817_GAS_GAUGE_GG_STS,
>    737					  RK817_BAT_CON, 0);
>    738			/* Save nvram values */
>    739			ret = rk817_record_battery_nvram_values(charger);
>    740			if (ret < 0)
>    741				return ret;
>    742		} else {
>    743			ret = rk817_read_battery_nvram_values(charger);
>    744			if (ret < 0)
>    745				return ret;
>    746	
>    747			regmap_bulk_read(rk808->regmap, RK817_GAS_GAUGE_Q_PRES_H3,
>    748					 bulk_reg, 4);
>    749			tmp = get_unaligned_be32(bulk_reg);
>    750			if (tmp < 0)
>    751				tmp = 0;
>    752			boot_charge_mah = ADC_TO_CHARGE_UAH(tmp,
>    753							    charger->res_div) / 1000;
>    754			/* Check if the columb counter has been off for more than 300
>    755			 * minutes as it tends to drift downward. If so, re-init soc
>    756			 * with the boot voltage instead. Note the unit values for the
>    757			 * OFF_CNT register appear to be in decaminutes and stops
>    758			 * counting at 2550 (0xFF) minutes. BSP kernel used OCV, but
>    759			 * for me occasionally that would show invalid values. Boot
>    760			 * voltage is only accurate for me on first poweron (not
>    761			 * reboots), but we shouldn't ever encounter an OFF_CNT more
>    762			 * than 0 on a reboot anyway.
>    763			 */
>    764			regmap_read(rk808->regmap, RK817_GAS_GAUGE_OFF_CNT, &off_time);
>    765			if (off_time >= 30) {
>    766				regmap_bulk_read(rk808->regmap,
>    767						 RK817_GAS_GAUGE_PWRON_VOL_H,
>    768						 bulk_reg, 2);
>    769				tmp = get_unaligned_be16(bulk_reg);
>    770				boot_voltage = (charger->voltage_k * tmp) +
>    771						1000 * charger->voltage_b;
>    772				charger->soc =
>    773					power_supply_batinfo_ocv2cap(bat_info,
>    774								     boot_voltage,
>    775								     20) * 1000;
>    776			} else {
>    777				charger->soc = (boot_charge_mah * 1000 * 100 /
>    778						charger->fcc_mah);
>    779			}
>    780		}
>    781	
>    782		regmap_bulk_read(rk808->regmap, RK817_GAS_GAUGE_PWRON_VOL_H,
>    783				 bulk_reg, 2);
>    784		tmp = get_unaligned_be16(bulk_reg);
>    785		boot_voltage = (charger->voltage_k * tmp) + 1000 * charger->voltage_b;
>    786		soc_tmp1 = power_supply_batinfo_ocv2cap(bat_info,
>    787							boot_voltage, 20) * 1000;
>    788		regmap_bulk_read(rk808->regmap, RK817_GAS_GAUGE_Q_PRES_H3,
>    789				 bulk_reg, 4);
>    790		tmp = get_unaligned_be32(bulk_reg);
>    791		if (tmp < 0)
>    792			tmp = 0;
>    793		boot_charge_mah = ADC_TO_CHARGE_UAH(tmp, charger->res_div) / 1000;
>    794		soc_tmp2 = (boot_charge_mah * 1000 * 100 / charger->fcc_mah);
>    795		regmap_bulk_read(rk808->regmap, RK817_GAS_GAUGE_OCV_VOL_H,
>    796				 bulk_reg, 2);
>    797		tmp = get_unaligned_be16(bulk_reg);
>    798		boot_voltage = (charger->voltage_k * tmp) + 1000 * charger->voltage_b;
>    799		soc_tmp3 = power_supply_batinfo_ocv2cap(bat_info,
>    800							boot_voltage, 20) * 1000;
>    801	
>    802		/* Now we have our full charge capacity and soc, init the columb
>    803		 * counter.
>    804		 */
>    805		boot_charge_mah = charger->soc * charger->fcc_mah / 100 / 1000;
>    806		if (boot_charge_mah > charger->fcc_mah)
>    807			boot_charge_mah = charger->fcc_mah;
>    808		tmp = CHARGE_TO_ADC(boot_charge_mah, charger->res_div);
>    809		put_unaligned_be32(tmp, bulk_reg);
>    810		ret = regmap_bulk_write(rk808->regmap, RK817_GAS_GAUGE_Q_INIT_H3,
>    811				  bulk_reg, 4);
>    812		if (ret < 0)
>    813			return ret;
>    814	
>    815		/* Set QMAX value to max design capacity. */
>    816		tmp = CHARGE_TO_ADC((charger->bat_charge_full_design_uah / 1000),
>    817				    charger->res_div);
>    818		put_unaligned_be32(tmp, bulk_reg);
>    819		ret = regmap_bulk_write(rk808->regmap, RK817_GAS_GAUGE_Q_MAX_H3,
>    820					bulk_reg, 4);
>    821		if (ret < 0)
>    822			return ret;
>    823	
>    824		return 0;
>    825	}
>    826	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
