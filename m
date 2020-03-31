Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 338511988D9
	for <lists+linux-pm@lfdr.de>; Tue, 31 Mar 2020 02:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbgCaAZC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Mar 2020 20:25:02 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:28877 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729358AbgCaAZB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Mar 2020 20:25:01 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200331002458epoutp03e95fc01432ae94e36bda8f9c0e059b44~BO83PWn7p2265222652epoutp03n
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2020 00:24:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200331002458epoutp03e95fc01432ae94e36bda8f9c0e059b44~BO83PWn7p2265222652epoutp03n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585614298;
        bh=0vFQ5DAOCCg07cddKStNnVqTqMmWXTB270Lf6ehE3uw=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=ia2q5LwzjmkQ2r1EKr2OhPJwB/KXVH8Q9GRCHj8q81JPB0j5iD+C/rTT9k50XAwIv
         qgdsOWWbgN5lgO768qqEsMt34QRN3C+/odtxrppQGLCO9Yf8R2GAK6gQKpW8yC5Ogs
         p3JLizrbOnOf7+oLxRKfVdtHaiK8F3j8Kz/qlZn0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200331002458epcas1p3d4271b0f889d45e170bcbae934534fc4~BO82luR0T1457414574epcas1p3k;
        Tue, 31 Mar 2020 00:24:58 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.156]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 48rqpb6xRmzMqYkm; Tue, 31 Mar
        2020 00:24:55 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        ED.88.04071.6DD828E5; Tue, 31 Mar 2020 09:24:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200331002453epcas1p1978886c235c127cd1c56ba7d6fef84f8~BO8yY1u2s1716417164epcas1p1X;
        Tue, 31 Mar 2020 00:24:53 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200331002453epsmtrp2349e6b96f91c1a932069b7ea5ccb9015~BO8yX_uNA2901429014epsmtrp2W;
        Tue, 31 Mar 2020 00:24:53 +0000 (GMT)
X-AuditID: b6c32a37-c0c519c000000fe7-cb-5e828dd6c545
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        91.A2.04024.5DD828E5; Tue, 31 Mar 2020 09:24:53 +0900 (KST)
Received: from [10.113.76.82] (unknown [10.113.76.82]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200331002453epsmtip210cff0f07743c8c30ca3667515dba97a~BO8yGsnOO1738617386epsmtip24;
        Tue, 31 Mar 2020 00:24:53 +0000 (GMT)
Subject: Re: [PATCH 5/9] power: supply: smb347-charger: Implement
 device-tree support
To:     David Heidelberg <david@ixit.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Myungjoo Ham <myungjoo.ham@samsung.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>,
        mika.westerberg@linux.intel.com, ramakrishna.pallala@intel.com,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Jonghwa Lee <jonghwa3.lee@samsung.com>
Message-ID: <2dc4e25c-4b3a-1675-1f9e-0437a3526835@samsung.com>
Date:   Tue, 31 Mar 2020 09:25:38 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
        Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200329162128.218584-6-david@ixit.cz>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFJsWRmVeSWpSXmKPExsWy7bCmru613qY4g2WreC2uf3nOanFsn73F
        6o+PGS3O/Na1uLxrDpvF594jjBZTth9ht7jduILNYuGbm0wWny+/ZLM4vbvE4tTdz+wOPB47
        Z91l91i85yWTR3/jQWaPTas62TzuXNvD5jHvZKBH35ZVjB6fN8kFcERl22SkJqakFimk5iXn
        p2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAnaqkUJaYUwoUCkgsLlbSt7Mp
        yi8tSVXIyC8usVVKLUjJKbAs0CtOzC0uzUvXS87PtTI0MDAyBSpMyM640r2IpeC9WcXRj7IN
        jNt0uhg5OSQETCReHP3H2MXIxSEksINR4uzMLWwQzidGiS3drUwQzjdGiWe/37DCtCx9+IoF
        xBYS2Msosb89A6LoNaPE1+Ob2UASwgLhEu/enwKbKyKwiVniRNcpdpAEm4COxP99N8FsXgE7
        iSlzFjKD2CwCqhInWt4xgdiiAhES07aDHAVSIyhxcuYTsG2cQJsPz1sL1sssIC/RvHU2M4Qt
        LnHryXywUyUE+tklHnRvZoI41UViSvcXFghbWOLV8S3sELaUxOd3e9kg7HKJCRO+skM0tzBK
        tCxfwwiRsJe4f2sC0M8cQBs0Jdbv0ocIK0rs/D2XEWIxn8S7rz1gJRICvBIdbUIQJWoS7y5d
        h1olI9F05SHUKg+J5r2N0CDdyCgx7edk1gmMCrOQ/DkLyW+zkPw2C+GKBYwsqxjFUguKc9NT
        iw0LjJGjexMjOB1rme9g3HDO5xCjAAejEg/vg6uNcUKsiWXFlbmHGCU4mJVEeNn8G+KEeFMS
        K6tSi/Lji0pzUosPMZoCo2Eis5Rocj4wV+SVxBuaGhkbG1uYGJqZGhoqifNOvZ4TJySQnliS
        mp2aWpBaBNPHxMEp1cBYPGfv4jl7xeYULznLqeF0yZDBo/5KzdpIl6APUVYFNTsXLN2SUp34
        3lDJ0yF+2bQlj9cZcCy9FxdaOCN1l/T8n5MPP3lveX9W6oK2xO/nrPeqrbx00499rf3PnTuX
        M1ZJnJvjO63Sd4Zn3PqXa0smHrp5U+6u9is5th3H97CJz3uuHOz84ryxlBJLcUaioRZzUXEi
        AIjgQTjdAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSvO7V3qY4g5c9yhbXvzxntTi2z95i
        9cfHjBZnfutaXN41h83ic+8RRosp24+wW9xuXMFmsfDNTSaLz5dfslmc3l1iceruZ3YHHo+d
        s+6yeyze85LJo7/xILPHplWdbB53ru1h85h3MtCjb8sqRo/Pm+QCOKK4bFJSczLLUov07RK4
        Mq50L2IpeG9WcfSjbAPjNp0uRk4OCQETiaUPX7F0MXJxCAnsZpT43beZESIhI3Fx9QGmLkYO
        IFtY4vDhYpCwkMBLRon+9WEgtrBAuMS8rZuZQHpFBDYxS7za9ZkNYtBGRom2zh9gg9gEdCT+
        77vJDmLzCthJTJmzkBnEZhFQlTjR8o4JxBYViJB4PLGdEaJGUOLkzCcsIDYn0HWH560F62UW
        MJOYt/khM4QtL9G8dTaULS5x68l8pgmMgrOQtM9C0jILScssJC0LGFlWMUqmFhTnpucWGxYY
        5qWW6xUn5haX5qXrJefnbmIER5mW5g7Gy0viDzEKcDAq8fA+uNoYJ8SaWFZcmXuIUYKDWUmE
        l82/IU6INyWxsiq1KD++qDQntfgQozQHi5I479O8Y5FCAumJJanZqakFqUUwWSYOTqkGxnRF
        0WWnDJ0b7N4+36e35D/30u7T7Dr8aW26Xw+UhB2bHn26VGnnj41vG2Zp8Dhe5t/+ZefW+EPf
        lG++7/7VGBia9TNx/b+853EGITelJR46fbRw3zFpxp1/70s9J7ztXXiR/eOna3qLjvLF7uO8
        13jh0N9mTuPmx0EW03aftItmc5Pubg9emK/EUpyRaKjFXFScCADCbo56rgIAAA==
X-CMS-MailID: 20200331002453epcas1p1978886c235c127cd1c56ba7d6fef84f8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200329163055epcas1p2cb50a5892440ecff127f87cb4306571e
References: <20200329161552.215075-1-david@ixit.cz>
        <CGME20200329163055epcas1p2cb50a5892440ecff127f87cb4306571e@epcas1p2.samsung.com>
        <20200329162128.218584-6-david@ixit.cz>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20. 3. 30. 오전 1:21, David Heidelberg wrote:
> This patch makes smb347 charger driver to support dt binding. All legacy
> platform data now can be parsed from dt.
> Because of that smb347 is i2c client driver, IRQ number can be passed
> automatically through client's irq variable if it is defined in dt.
> No more to use requesting gpio to irq manually in dt-way.
Thanks for keeping original commit description and revealing where it 
comes from.

Anyway, in the above description, the last three lines doesn't match to 
the commit since

the original patch is now split. Please remove them or you can rewrite 
description as your own.

>
> Based on: https://patchwork.kernel.org/patch/4284731/
> Original author: Jonghwa Lee <jonghwa3.lee@samsung.com>
>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   drivers/power/supply/smb347-charger.c | 107 +++++++++++++++++++++++---
>   1 file changed, 97 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
> index 4add9f64ba90..852d2ab566e0 100644
> --- a/drivers/power/supply/smb347-charger.c
> +++ b/drivers/power/supply/smb347-charger.c
> @@ -1180,6 +1180,87 @@ static bool smb347_readable_reg(struct device *dev, unsigned int reg)
>   	return smb347_volatile_reg(dev, reg);
>   }
>   
> +static void smb347_dt_parse_pdata(struct device_node *np,
> +				  struct smb347_charger_platform_data *pdata)
> +{
> +	/* Charging constraints */
> +	of_property_read_u32(np, "summit,max-chg-curr",
> +			     &pdata->max_charge_current);
> +	of_property_read_u32(np, "summit,max-chg-volt",
> +			     &pdata->max_charge_voltage);
> +	of_property_read_u32(np, "summit,pre-chg-curr",
> +			     &pdata->pre_charge_current);
> +	of_property_read_u32(np, "summit,term-curr",
> +			     &pdata->termination_current);
> +	of_property_read_u32(np, "summit,fast-volt-threshold",
> +			     &pdata->pre_to_fast_voltage);
> +	of_property_read_u32(np, "summit,mains-curr-limit",
> +			     &pdata->mains_current_limit);
> +	of_property_read_u32(np, "summit,usb-curr-limit",
> +			     &pdata->usb_hc_current_limit);
> +
> +	/* For thermometer monitoring */
> +	of_property_read_u32(np, "summit,chip-temp-threshold",
> +			     &pdata->chip_temp_threshold);
> +	if (of_property_read_u32(np, "summit,soft-cold-temp-limit",
> +				 &pdata->soft_cold_temp_limit))
> +		pdata->soft_cold_temp_limit = SMB347_TEMP_USE_DEFAULT;
> +	if (of_property_read_u32(np, "summit,soft-hot-temp-limit",
> +				 &pdata->soft_hot_temp_limit))
> +		pdata->soft_hot_temp_limit = SMB347_TEMP_USE_DEFAULT;
> +	if (of_property_read_u32(np, "summit,hard-cold-temp-limit",
> +				 &pdata->hard_cold_temp_limit))
> +		pdata->hard_cold_temp_limit = SMB347_TEMP_USE_DEFAULT;
> +	if (of_property_read_u32(np, "summit,hard-hot-temp-limit",
> +				 &pdata->hard_hot_temp_limit))
> +		pdata->hard_hot_temp_limit = SMB347_TEMP_USE_DEFAULT;
> +
> +	/* Suspend when battery temperature is outside hard limits */
> +	if (pdata->hard_cold_temp_limit != SMB347_TEMP_USE_DEFAULT ||
> +	    pdata->hard_hot_temp_limit != SMB347_TEMP_USE_DEFAULT)
> +		pdata->suspend_on_hard_temp_limit = true;
> +
> +	if (of_property_read_u32(np, "summit,soft-comp-method",
> +				 &pdata->soft_temp_limit_compensation))
> +		pdata->soft_temp_limit_compensation =
> +				SMB347_SOFT_TEMP_COMPENSATE_DEFAULT;
> +
> +	of_property_read_u32(np, "summit,chg-curr-comp",
> +			     &pdata->charge_current_compensation);
> +
> +	/* Supported charging mode */
> +	pdata->use_mains =
> +		of_property_read_bool(np, "summit,enable-mains-charging");
> +	pdata->use_usb =
> +		of_property_read_bool(np, "summit,enable-usb-charging");
> +	pdata->use_usb_otg =
> +		of_property_read_bool(np, "summit,enable-otg-charging");
> +
> +	/* Enable charging method */
> +	of_property_read_u32(np, "summit,enable-chg-ctrl",
> +			     &pdata->enable_control);
> +
> +	/* If IRQ is enabled or not */
> +	if (!of_find_property(np, "interrupts", NULL))
> +		pdata->irq_gpio = -1;
> +}
> +
> +static struct smb347_charger_platform_data
> +			*smb347_get_platdata(struct device *dev)
> +{
> +	struct smb347_charger_platform_data *pdata;
> +
> +	if (dev->of_node) {
> +		pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> +		if (pdata)
> +			smb347_dt_parse_pdata(dev->of_node, pdata);
> +	} else {
> +		pdata = dev_get_platdata(dev);
> +	}
> +
> +	return pdata;
> +}
> +
>   static const struct regmap_config smb347_regmap = {
>   	.reg_bits	= 8,
>   	.val_bits	= 8,
> @@ -1216,28 +1297,26 @@ static int smb347_probe(struct i2c_client *client,
>   			const struct i2c_device_id *id)
>   {
>   	static char *battery[] = { "smb347-battery" };
> -	const struct smb347_charger_platform_data *pdata;
>   	struct power_supply_config mains_usb_cfg = {}, battery_cfg = {};
>   	struct device *dev = &client->dev;
>   	struct smb347_charger *smb;
>   	int ret;
>   
> -	pdata = dev->platform_data;
> -	if (!pdata)
> -		return -EINVAL;
> -
> -	if (!pdata->use_mains && !pdata->use_usb)
> -		return -EINVAL;
> -
>   	smb = devm_kzalloc(dev, sizeof(*smb), GFP_KERNEL);
>   	if (!smb)
>   		return -ENOMEM;
>   
> +	smb->pdata = smb347_get_platdata(dev);
> +	if (!smb->pdata)
> +		return -ENODEV;
> +
> +	if (!smb->pdata->use_mains && !smb->pdata->use_usb)
> +		return -EINVAL;
> +
>   	i2c_set_clientdata(client, smb);
>   
>   	mutex_init(&smb->lock);
>   	smb->dev = &client->dev;
> -	smb->pdata = pdata;
>   
>   	smb->regmap = devm_regmap_init_i2c(client, &smb347_regmap);
>   	if (IS_ERR(smb->regmap))
> @@ -1250,6 +1329,7 @@ static int smb347_probe(struct i2c_client *client,
>   	mains_usb_cfg.supplied_to = battery;
>   	mains_usb_cfg.num_supplicants = ARRAY_SIZE(battery);
>   	mains_usb_cfg.drv_data = smb;
> +	mains_usb_cfg.of_node = dev->of_node;
>   	if (smb->pdata->use_mains) {
>   		smb->mains = power_supply_register(dev, &smb347_mains_desc,
>   						   &mains_usb_cfg);
> @@ -1282,7 +1362,7 @@ static int smb347_probe(struct i2c_client *client,
>   	 * Interrupt pin is optional. If it is connected, we setup the
>   	 * interrupt support here.
>   	 */
> -	if (pdata->irq_gpio >= 0) {
> +	if (smb->pdata->irq_gpio >= 0) {
>   		ret = smb347_irq_init(smb, client);
>   		if (ret < 0) {
>   			dev_warn(dev, "failed to initialize IRQ: %d\n", ret);
> @@ -1316,9 +1396,16 @@ static const struct i2c_device_id smb347_id[] = {
>   };
>   MODULE_DEVICE_TABLE(i2c, smb347_id);
>   
> +static const struct of_device_id smb3xx_of_match[] = {
> +	{ .compatible = "summit,smb347" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, smb3xx_of_match);
> +
>   static struct i2c_driver smb347_driver = {
>   	.driver = {
>   		.name = "smb347",
> +		.of_match_table = smb3xx_of_match,
>   	},
>   	.probe        = smb347_probe,
>   	.remove       = smb347_remove,
