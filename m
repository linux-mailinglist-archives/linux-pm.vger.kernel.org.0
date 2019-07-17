Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE236BE13
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2019 16:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfGQORP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jul 2019 10:17:15 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2674 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725936AbfGQORO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Jul 2019 10:17:14 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 11C1F52B2202777E0778;
        Wed, 17 Jul 2019 22:17:12 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Wed, 17 Jul 2019
 22:17:08 +0800
Subject: Re: [PATCH 1/3] power: supply: ab8500: remove set but not used
 variables 'vbup33_vrtcn' and 'bup_vch_range'
To:     <sre@kernel.org>, <linus.walleij@linaro.org>,
        <lee.jones@linaro.org>, <loic.pallardy@st.com>
References: <20190717141502.53968-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <3142ee96-0bca-a9f3-1138-a4cf58d46bd8@huawei.com>
Date:   Wed, 17 Jul 2019 22:17:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190717141502.53968-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sorry, Pls ignore this, I will fix patch title.

On 2019/7/17 22:15, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warnings:
> 
> drivers/power/supply/ab8500_charger.c:
>  In function ab8500_charger_init_hw_registers:
> drivers/power/supply/ab8500_charger.c:3013:24: warning:
>  variable vbup33_vrtcn set but not used [-Wunused-but-set-variable]
> drivers/power/supply/ab8500_charger.c:3013:5: warning:
>  variable bup_vch_range set but not used [-Wunused-but-set-variable]
> 
> They are not used since commit 4c4268dc97c4 ("power:
> supply: ab8500: Drop AB8540/9540 support")
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/power/supply/ab8500_charger.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
> index 30de448..270a48a 100644
> --- a/drivers/power/supply/ab8500_charger.c
> +++ b/drivers/power/supply/ab8500_charger.c
> @@ -3010,7 +3010,6 @@ static int ab8500_charger_usb_get_property(struct power_supply *psy,
>  static int ab8500_charger_init_hw_registers(struct ab8500_charger *di)
>  {
>  	int ret = 0;
> -	u8 bup_vch_range = 0, vbup33_vrtcn = 0;
>  
>  	/* Setup maximum charger current and voltage for ABB cut2.0 */
>  	if (!is_ab8500_1p1_or_earlier(di->parent)) {
> @@ -3111,12 +3110,6 @@ static int ab8500_charger_init_hw_registers(struct ab8500_charger *di)
>  		goto out;
>  	}
>  
> -	/* Backup battery voltage and current */
> -	if (di->bm->bkup_bat_v > BUP_VCH_SEL_3P1V)
> -		bup_vch_range = BUP_VCH_RANGE;
> -	if (di->bm->bkup_bat_v == BUP_VCH_SEL_3P3V)
> -		vbup33_vrtcn = VBUP33_VRTCN;
> -
>  	ret = abx500_set_register_interruptible(di->dev,
>  		AB8500_RTC,
>  		AB8500_RTC_BACKUP_CHG_REG,
> 

