Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99199233546
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 17:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbgG3P0B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 11:26:01 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49286 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgG3P0B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2020 11:26:01 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06UFPx6D063681;
        Thu, 30 Jul 2020 10:25:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596122759;
        bh=Hk4XLCjRC0bAuDvZqFBKFGcJMZTuqCPyp8W3M2pqgww=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Y8xpz30apu44bipZj5nbJVk0uVAjiIXbGsaFUdTckxujJfxCv0QDRzstlFvFRhnk0
         1574wg/74xyCUCkDU2/qeUqeN5eu2x0vTVBpwbVx/kYbnwHD7PM7YDiGlY3UVnB0f+
         DTwADjXA05RxskUTUIAWDHP1DplzmJmcrknvwqfI=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06UFPxBA040612
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Jul 2020 10:25:59 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 30
 Jul 2020 10:25:59 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 30 Jul 2020 10:25:59 -0500
Received: from [10.250.38.163] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06UFPwm6013205;
        Thu, 30 Jul 2020 10:25:58 -0500
Subject: Re: [PATCH 2/2] power: bq27xxx: Fix spacing style and white space
 issues
To:     Dan Murphy <dmurphy@ti.com>, <sre@kernel.org>, <pali@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200730143122.28519-1-dmurphy@ti.com>
 <20200730143122.28519-2-dmurphy@ti.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <99e39cd9-3c7f-908b-263f-42c78575bb29@ti.com>
Date:   Thu, 30 Jul 2020 11:25:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730143122.28519-2-dmurphy@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/30/20 10:31 AM, Dan Murphy wrote:
> Fix spacing style issues with the chip data array.  As well as fix
> missing new line after variable declaration.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  drivers/power/supply/bq27xxx_battery.c | 63 ++++++++++++++------------
>  1 file changed, 33 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index 8b112449ace8..e58039db8e64 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -871,35 +871,35 @@ static struct {
>  	enum power_supply_property *props;
>  	size_t props_size;
>  } bq27xxx_chip_data[] = {
> -	[BQ27000]   = BQ27XXX_DATA(bq27000,   0         , BQ27XXX_O_ZERO),
> -	[BQ27010]   = BQ27XXX_DATA(bq27010,   0         , BQ27XXX_O_ZERO),
> -	[BQ2750X]   = BQ27XXX_DATA(bq2750x,   0         , BQ27XXX_O_OTDC),
> -	[BQ2751X]   = BQ27XXX_DATA(bq2751x,   0         , BQ27XXX_O_OTDC),
> -	[BQ2752X]   = BQ27XXX_DATA(bq2752x,   0         , BQ27XXX_O_OTDC),
> -	[BQ27500]   = BQ27XXX_DATA(bq27500,   0x04143672, BQ27XXX_O_OTDC),
> -	[BQ27510G1] = BQ27XXX_DATA(bq27510g1, 0         , BQ27XXX_O_OTDC),
> -	[BQ27510G2] = BQ27XXX_DATA(bq27510g2, 0         , BQ27XXX_O_OTDC),
> -	[BQ27510G3] = BQ27XXX_DATA(bq27510g3, 0         , BQ27XXX_O_OTDC),
> -	[BQ27520G1] = BQ27XXX_DATA(bq27520g1, 0         , BQ27XXX_O_OTDC),
> -	[BQ27520G2] = BQ27XXX_DATA(bq27520g2, 0         , BQ27XXX_O_OTDC),
> -	[BQ27520G3] = BQ27XXX_DATA(bq27520g3, 0         , BQ27XXX_O_OTDC),
> -	[BQ27520G4] = BQ27XXX_DATA(bq27520g4, 0         , BQ27XXX_O_OTDC),
> -	[BQ27521]   = BQ27XXX_DATA(bq27521,   0         , 0),
> -	[BQ27530]   = BQ27XXX_DATA(bq27530,   0         , BQ27XXX_O_UTOT),
> -	[BQ27531]   = BQ27XXX_DATA(bq27531,   0         , BQ27XXX_O_UTOT),
> -	[BQ27541]   = BQ27XXX_DATA(bq27541,   0         , BQ27XXX_O_OTDC),
> -	[BQ27542]   = BQ27XXX_DATA(bq27542,   0         , BQ27XXX_O_OTDC),
> -	[BQ27546]   = BQ27XXX_DATA(bq27546,   0         , BQ27XXX_O_OTDC),
> -	[BQ27742]   = BQ27XXX_DATA(bq27742,   0         , BQ27XXX_O_OTDC),
> -	[BQ27545]   = BQ27XXX_DATA(bq27545,   0x04143672, BQ27XXX_O_OTDC),
> -	[BQ27411]   = BQ27XXX_DATA(bq27411,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
> -	[BQ27421]   = BQ27XXX_DATA(bq27421,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
> -	[BQ27425]   = BQ27XXX_DATA(bq27425,   0x04143672, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP),
> -	[BQ27426]   = BQ27XXX_DATA(bq27426,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
> -	[BQ27441]   = BQ27XXX_DATA(bq27441,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
> -	[BQ27621]   = BQ27XXX_DATA(bq27621,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
> -	[BQ27Z561]  = BQ27XXX_DATA(bq27z561,  0         , BQ27Z561_O_BITS),
> -	[BQ28Z610]  = BQ27XXX_DATA(bq28z610,  0         , BQ27Z561_O_BITS),
> +	[BQ27000]   = BQ27XXX_DATA(bq27000, 0, BQ27XXX_O_ZERO),


The spacing before improved readability.

Andrew


> +	[BQ27010]   = BQ27XXX_DATA(bq27010, 0, BQ27XXX_O_ZERO),
> +	[BQ2750X]   = BQ27XXX_DATA(bq2750x, 0, BQ27XXX_O_OTDC),
> +	[BQ2751X]   = BQ27XXX_DATA(bq2751x, 0, BQ27XXX_O_OTDC),
> +	[BQ2752X]   = BQ27XXX_DATA(bq2752x, 0, BQ27XXX_O_OTDC),
> +	[BQ27500]   = BQ27XXX_DATA(bq27500, 0x04143672, BQ27XXX_O_OTDC),
> +	[BQ27510G1] = BQ27XXX_DATA(bq27510g1, 0, BQ27XXX_O_OTDC),
> +	[BQ27510G2] = BQ27XXX_DATA(bq27510g2, 0, BQ27XXX_O_OTDC),
> +	[BQ27510G3] = BQ27XXX_DATA(bq27510g3, 0, BQ27XXX_O_OTDC),
> +	[BQ27520G1] = BQ27XXX_DATA(bq27520g1, 0, BQ27XXX_O_OTDC),
> +	[BQ27520G2] = BQ27XXX_DATA(bq27520g2, 0, BQ27XXX_O_OTDC),
> +	[BQ27520G3] = BQ27XXX_DATA(bq27520g3, 0, BQ27XXX_O_OTDC),
> +	[BQ27520G4] = BQ27XXX_DATA(bq27520g4, 0, BQ27XXX_O_OTDC),
> +	[BQ27521]   = BQ27XXX_DATA(bq27521, 0, 0),
> +	[BQ27530]   = BQ27XXX_DATA(bq27530, 0, BQ27XXX_O_UTOT),
> +	[BQ27531]   = BQ27XXX_DATA(bq27531, 0, BQ27XXX_O_UTOT),
> +	[BQ27541]   = BQ27XXX_DATA(bq27541, 0, BQ27XXX_O_OTDC),
> +	[BQ27542]   = BQ27XXX_DATA(bq27542, 0, BQ27XXX_O_OTDC),
> +	[BQ27546]   = BQ27XXX_DATA(bq27546, 0, BQ27XXX_O_OTDC),
> +	[BQ27742]   = BQ27XXX_DATA(bq27742, 0, BQ27XXX_O_OTDC),
> +	[BQ27545]   = BQ27XXX_DATA(bq27545, 0x04143672, BQ27XXX_O_OTDC),
> +	[BQ27411]   = BQ27XXX_DATA(bq27411, 0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
> +	[BQ27421]   = BQ27XXX_DATA(bq27421, 0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
> +	[BQ27425]   = BQ27XXX_DATA(bq27425, 0x04143672, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP),
> +	[BQ27426]   = BQ27XXX_DATA(bq27426, 0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
> +	[BQ27441]   = BQ27XXX_DATA(bq27441, 0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
> +	[BQ27621]   = BQ27XXX_DATA(bq27621, 0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
> +	[BQ27Z561]  = BQ27XXX_DATA(bq27z561, 0, BQ27Z561_O_BITS),
> +	[BQ28Z610]  = BQ27XXX_DATA(bq28z610, 0, BQ27Z561_O_BITS),
>  };
>  
>  static DEFINE_MUTEX(bq27xxx_list_lock);
> @@ -1235,6 +1235,7 @@ static int bq27xxx_battery_cfgupdate_priv(struct bq27xxx_device_info *di, bool a
>  static inline int bq27xxx_battery_set_cfgupdate(struct bq27xxx_device_info *di)
>  {
>  	int ret = bq27xxx_battery_cfgupdate_priv(di, true);
> +
>  	if (ret < 0 && ret != -EINVAL)
>  		dev_err(di->dev, "bus error on set_cfgupdate: %d\n", ret);
>  
> @@ -1244,6 +1245,7 @@ static inline int bq27xxx_battery_set_cfgupdate(struct bq27xxx_device_info *di)
>  static inline int bq27xxx_battery_soft_reset(struct bq27xxx_device_info *di)
>  {
>  	int ret = bq27xxx_battery_cfgupdate_priv(di, false);
> +
>  	if (ret < 0 && ret != -EINVAL)
>  		dev_err(di->dev, "bus error on soft_reset: %d\n", ret);
>  
> @@ -1338,6 +1340,7 @@ static void bq27xxx_battery_set_config(struct bq27xxx_device_info *di,
>  
>  	if (info->voltage_min_design_uv != -EINVAL) {
>  		bool same = bd.class == bt.class && bd.block == bt.block;
> +
>  		if (!same)
>  			bq27xxx_battery_read_dm_block(di, &bt);
>  		bq27xxx_battery_update_dm_block(di, same ? &bd : &bt,
> @@ -1611,7 +1614,7 @@ static bool bq27xxx_battery_overtemp(struct bq27xxx_device_info *di, u16 flags)
>  {
>  	if (di->opts & BQ27XXX_O_OTDC)
>  		return flags & (BQ27XXX_FLAG_OTC | BQ27XXX_FLAG_OTD);
> -        if (di->opts & BQ27XXX_O_UTOT)
> +	if (di->opts & BQ27XXX_O_UTOT)
>  		return flags & BQ27XXX_FLAG_OT;
>  
>  	return false;
> 
