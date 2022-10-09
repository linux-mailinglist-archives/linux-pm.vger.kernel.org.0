Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14865F94B6
	for <lists+linux-pm@lfdr.de>; Mon, 10 Oct 2022 02:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbiJJACK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 9 Oct 2022 20:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiJJABn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 9 Oct 2022 20:01:43 -0400
X-Greylist: delayed 549 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 09 Oct 2022 16:34:11 PDT
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68AE76447
        for <linux-pm@vger.kernel.org>; Sun,  9 Oct 2022 16:34:11 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4MlyQQ3NfqzF0;
        Mon, 10 Oct 2022 01:08:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1665356910; bh=1tjCaCOga1RdUh1bzpKBR1njpbuOFx6+MHcyJ0A1WeA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y3rOWAEE/z4Kqjp2gnYRaHD5tVgxqUrHTphdoZkJFNc+R07Bi2oKB+ipNZ1KAjQMu
         gsU7PFbIF76J0Z/6+JsUOHNKNN0biZEcGc8WZcqoXTqumdGN+O0MS2qOLvb3QaNaqH
         u2Rm8Dhnk+ALBWXyZ6cQOhIE4LvgGL/p1n9yKUkIEFEf++UTR7nq1Sf5tUwdXv9hIf
         dKA6jqvpe6YK+eJyKiAbHRB/65xAwj50AzWIfiK1lsIEP1lan/6S3nYbv6Ny54PnK3
         R1310YFMxKEvjLzdQbHI0cf6nqDIYRL61nLhE5cFrTIsmjJAR4AF44SbxFLz7tc3PY
         mRRUikcomKqLQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.7 at mail
Date:   Mon, 10 Oct 2022 01:08:29 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-pm@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 1/2] power: supply: bq25890: Add CC voltage to ADC
 properties
Message-ID: <Y0NUbeUae01t+UGa@qmqm.qmqm.pl>
References: <20221009191839.102686-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221009191839.102686-1-marex@denx.de>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Oct 09, 2022 at 09:18:38PM +0200, Marek Vasut wrote:
> The POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE , representing register
> REG0E field BATV is an ADC conversion of Battery Voltage (VBAT). Mark
> the property as ADC one.

In this case I believe the property is representing wrong value: it
should be REG06 - the programmed voltage limit, and _MAX should reflect
maximum setting possible. Though I think there is no proper property
for the VSYS value that is currently occupying VOLTAGE_NOW - this
might be better modelled as a separate regulator maybe?

But, for the time being this look ok.

> Fixes: 21d90eda433f ("power: bq25890: fix ADC mode configuration")
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> To: linux-pm@vger.kernel.org
> ---
>  drivers/power/supply/bq25890_charger.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> index 6020b58c641d2..34dbd498f0f51 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -432,6 +432,7 @@ static bool bq25890_is_adc_property(enum power_supply_property psp)
>  {
>  	switch (psp) {
>  	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
>  	case POWER_SUPPLY_PROP_CURRENT_NOW:
>  	case POWER_SUPPLY_PROP_TEMP:
>  		return true;
> -- 
> 2.35.1
> 

-- 
Micha³ Miros³aw
