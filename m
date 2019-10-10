Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB0FD26AB
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2019 11:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbfJJJvM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Oct 2019 05:51:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36766 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387400AbfJJJvL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Oct 2019 05:51:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id m18so6069976wmc.1
        for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2019 02:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KxvyLSNPBNqr8hwOZEENSRAkbCbwJnw2YdKxEcXGeWk=;
        b=rWSLPRm5tZxT+p0YSI9eTVuT/uSDt4HlKzeZ4Vjocue46ccyNKDxI/Ultqvv+AuZYh
         cLQVo3gvM1+kwZHc9+vtzYInChXX7F+26fbwKImZjh3e9iROXE9HuS8NE7WbtCp17LXp
         40UqThDFpY4GwfXP8YBzWpTL40bYpQTLjkehEdDND2LBfSdAtD0z4ez+WwHLDM+SjJCh
         EFDU4/CFQkBUGzLipJE5L0w+yLNKBT4IcfFQdzlAkkyCLdBSO6nl5vmwWUOS/e20wFoO
         uZBSIeFx0nxRdH+sEuyC7lNxyYV+svKz94A8Pswsqj2ur0HW+pkt+cMQpqu4P1UUcSE5
         ZnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KxvyLSNPBNqr8hwOZEENSRAkbCbwJnw2YdKxEcXGeWk=;
        b=YC8iWgOa2Sgs94/GL974ZLIp5lOxYO52M2hABwZZ08frOUK3BcE+U4vfx9+8Tkc3Ep
         81RQ8V/A0oWMarZ7ZCrZa9owR7Fnlw4oqADlF9TxfJOgjWpKOd9QUpPgakIb1M/EQQcU
         5q035NIVuGaLlOctyCXA52Azc4ujq+wDC/yHByoLM7VnOwqP8K1m2GlA3lQt6rDtWjyE
         kz32hnPbVObA/S72VRfPZaAN0AwMon+H0MwnxOh0SWz0xZq+0riNTdtw3H1Si35q4Lu7
         XsgyjP9CQPwPvkfr9rLX9/SCcJOuP2NBt/SkDJDyiwH2cv/PB5iIuIDoYdXR840IHrcS
         VmOQ==
X-Gm-Message-State: APjAAAXpldb37ZfjALeR4K0lEyLfRe2P1/O4ByqboS2ONAB52wzBqoNx
        hcUgicoVLJbNj5JuhbVL2Fi9bnb7wy4=
X-Google-Smtp-Source: APXvYqykBzBb9Oihu7f9FD91Eo1VdTn5hy9KxKOnOp1Rec1BUW++xeSRPHvSI+aKzbx4Ya1d60SiQg==
X-Received: by 2002:a7b:c4c6:: with SMTP id g6mr6976390wmk.126.1570701066357;
        Thu, 10 Oct 2019 02:51:06 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:dcc2:7192:a634:4b9f? ([2a01:e34:ed2f:f020:dcc2:7192:a634:4b9f])
        by smtp.googlemail.com with ESMTPSA id r140sm6897187wme.47.2019.10.10.02.51.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 02:51:05 -0700 (PDT)
Subject: Re: [PATCH v2] thermal: qoriq: add thermal monitor unit version 2
 support
To:     Andy Tang <andy.tang@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>
Cc:     Leo Li <leoyang.li@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190924031640.3159-1-andy.tang@nxp.com>
 <DB3PR0402MB3916BF35E6EFEC5B29DB0FDDF5840@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <VI1PR04MB4333BDD3F355D6D3C7A356FAF3940@VI1PR04MB4333.eurprd04.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <446c668b-0050-5963-e4b1-a484f1ecdc6a@linaro.org>
Date:   Thu, 10 Oct 2019 11:51:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB4333BDD3F355D6D3C7A356FAF3940@VI1PR04MB4333.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/10/2019 11:35, Andy Tang wrote:
> Hi Edubezval, Rui,
> 
> I had addressed Anson's comments and got his Reviewed-by.
> Could you please merge it if you don't have other comments?

Except I'm missing something the patch does no longer apply.

Please can you rebase it on top of v5.4-rc1? So I can take the patch in
the testing branch [1].

Thanks

  -- Daniel

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/log/?h=testing

ps: we are putting in place a thermal tree group to make sure the
patches are not floating around during weeks.

>> -----Original Message-----
>> From: Anson Huang
>> Sent: 2019年9月24日 14:15
>> To: Andy Tang <andy.tang@nxp.com>; edubezval@gmail.com;
>> rui.zhang@intel.com
>> Cc: daniel.lezcano@linaro.org; Leo Li <leoyang.li@nxp.com>;
>> linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; Andy Tang
>> <andy.tang@nxp.com>
>> Subject: RE: [PATCH v2] thermal: qoriq: add thermal monitor unit version 2
>> support
>>
>>
>>
>>> -----Original Message-----
>>> From: Yuantian Tang <andy.tang@nxp.com>
>>> Sent: Tuesday, September 24, 2019 11:17 AM
>>> To: edubezval@gmail.com; rui.zhang@intel.com; Anson Huang
>>> <anson.huang@nxp.com>
>>> Cc: daniel.lezcano@linaro.org; Leo Li <leoyang.li@nxp.com>; linux-
>>> pm@vger.kernel.org; linux-kernel@vger.kernel.org; Andy Tang
>>> <andy.tang@nxp.com>
>>> Subject: [PATCH v2] thermal: qoriq: add thermal monitor unit version 2
>>> support
>>>
>>> Thermal Monitor Unit v2 is introduced on new Layscape SoC.
>>> Compared to v1, TMUv2 has a little different register layout and
>>> digital output is fairly linear.
>>>
>>> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
>>
>> Reviewed-by: Anson Huang <Anson.Huang@nxp.com>
>>
>>> ---
>>> v2:
>>> 	- refine the code: remove redundant variable, rename variable etc.
>>>
>>>  drivers/thermal/qoriq_thermal.c | 121
>>> +++++++++++++++++++++++++-------
>>>  1 file changed, 97 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/drivers/thermal/qoriq_thermal.c
>>> b/drivers/thermal/qoriq_thermal.c index 7b364933bfb1..43617e53554b
>>> 100644
>>> --- a/drivers/thermal/qoriq_thermal.c
>>> +++ b/drivers/thermal/qoriq_thermal.c
>>> @@ -12,7 +12,16 @@
>>>
>>>  #include "thermal_core.h"
>>>
>>> -#define SITES_MAX	16
>>> +#define SITES_MAX		16
>>> +#define TMR_DISABLE		0x0
>>> +#define TMR_ME			0x80000000
>>> +#define TMR_ALPF		0x0c000000
>>> +#define TMR_ALPF_V2		0x03000000
>>> +#define TMTMIR_DEFAULT	0x0000000f
>>> +#define TIER_DISABLE	0x0
>>> +#define TEUMR0_V2		0x51009c00
>>> +#define TMU_VER1		0x1
>>> +#define TMU_VER2		0x2
>>>
>>>  /*
>>>   * QorIQ TMU Registers
>>> @@ -23,17 +32,55 @@ struct qoriq_tmu_site_regs {
>>>  	u8 res0[0x8];
>>>  };
>>>
>>> -struct qoriq_tmu_regs {
>>> +struct qoriq_tmu_regs_v2 {
>>> +	u32 tmr;		/* Mode Register */
>>> +	u32 tsr;		/* Status Register */
>>> +	u32 tmsr;		/* monitor site register */
>>> +	u32 tmtmir;		/* Temperature measurement interval
>>> Register */
>>> +	u8 res0[0x10];
>>> +	u32 tier;		/* Interrupt Enable Register */
>>> +	u32 tidr;		/* Interrupt Detect Register */
>>> +	u8 res1[0x8];
>>> +	u32 tiiscr;		/* interrupt immediate site capture register
>>> */
>>> +	u32 tiascr;		/* interrupt average site capture register */
>>> +	u32 ticscr;		/* Interrupt Critical Site Capture Register */
>>> +	u32 res2;
>>> +	u32 tmhtcr;		/* monitor high temperature capture register
>>> */
>>> +	u32 tmltcr;		/* monitor low temperature capture register
>>> */
>>> +	u32 tmrtrcr;	/* monitor rising temperature rate capture register
>>> */
>>> +	u32 tmftrcr;	/* monitor falling temperature rate capture register
>>> */
>>> +	u32 tmhtitr;	/* High Temperature Immediate Threshold */
>>> +	u32 tmhtatr;	/* High Temperature Average Threshold */
>>> +	u32 tmhtactr;	/* High Temperature Average Crit Threshold */
>>> +	u32 res3;
>>> +	u32 tmltitr;	/* monitor low temperature immediate threshold */
>>> +	u32 tmltatr;	/* monitor low temperature average threshold
>>> register */
>>> +	u32 tmltactr;	/* monitor low temperature average critical
>>> threshold */
>>> +	u32 res4;
>>> +	u32 tmrtrctr;	/* monitor rising temperature rate critical threshold
>>> */
>>> +	u32 tmftrctr;	/* monitor falling temperature rate critical
>>> threshold*/
>>> +	u8 res5[0x8];
>>> +	u32 ttcfgr;	/* Temperature Configuration Register */
>>> +	u32 tscfgr;	/* Sensor Configuration Register */
>>> +	u8 res6[0x78];
>>> +	struct qoriq_tmu_site_regs site[SITES_MAX];
>>> +	u8 res7[0x9f8];
>>> +	u32 ipbrr0;		/* IP Block Revision Register 0 */
>>> +	u32 ipbrr1;		/* IP Block Revision Register 1 */
>>> +	u8 res8[0x300];
>>> +	u32 teumr0;
>>> +	u32 teumr1;
>>> +	u32 teumr2;
>>> +	u32 res9;
>>> +	u32 ttrcr[4];	/* Temperature Range Control Register */
>>> +};
>>> +
>>> +struct qoriq_tmu_regs_v1 {
>>>  	u32 tmr;		/* Mode Register */
>>> -#define TMR_DISABLE	0x0
>>> -#define TMR_ME		0x80000000
>>> -#define TMR_ALPF	0x0c000000
>>>  	u32 tsr;		/* Status Register */
>>>  	u32 tmtmir;		/* Temperature measurement interval
>>> Register */
>>> -#define TMTMIR_DEFAULT	0x0000000f
>>>  	u8 res0[0x14];
>>>  	u32 tier;		/* Interrupt Enable Register */
>>> -#define TIER_DISABLE	0x0
>>>  	u32 tidr;		/* Interrupt Detect Register */
>>>  	u32 tiscr;		/* Interrupt Site Capture Register */
>>>  	u32 ticscr;		/* Interrupt Critical Site Capture Register */
>>> @@ -53,10 +100,7 @@ struct qoriq_tmu_regs {
>>>  	u32 ipbrr0;		/* IP Block Revision Register 0 */
>>>  	u32 ipbrr1;		/* IP Block Revision Register 1 */
>>>  	u8 res6[0x310];
>>> -	u32 ttr0cr;		/* Temperature Range 0 Control Register */
>>> -	u32 ttr1cr;		/* Temperature Range 1 Control Register */
>>> -	u32 ttr2cr;		/* Temperature Range 2 Control Register */
>>> -	u32 ttr3cr;		/* Temperature Range 3 Control Register */
>>> +	u32 ttrcr[4];		/* Temperature Range Control Register */
>>>  };
>>>
>>>  struct qoriq_tmu_data;
>>> @@ -71,7 +115,9 @@ struct qoriq_sensor {  };
>>>
>>>  struct qoriq_tmu_data {
>>> -	struct qoriq_tmu_regs __iomem *regs;
>>> +	int ver;
>>> +	struct qoriq_tmu_regs_v1 __iomem *regs;
>>> +	struct qoriq_tmu_regs_v2 __iomem *regs_v2;
>>>  	bool little_endian;
>>>  	struct qoriq_sensor	*sensor[SITES_MAX];
>>>  };
>>> @@ -130,12 +176,23 @@ static int qoriq_tmu_register_tmu_zone(struct
>>> platform_device *pdev)
>>>  				return PTR_ERR(qdata->sensor[id]->tzd);
>>>  		}
>>>
>>> -		sites |= 0x1 << (15 - id);
>>> +		if (qdata->ver == TMU_VER1)
>>> +			sites |= 0x1 << (15 - id);
>>> +		else
>>> +			sites |= 0x1 << id;
>>>  	}
>>>
>>>  	/* Enable monitoring */
>>> -	if (sites != 0)
>>> -		tmu_write(qdata, sites | TMR_ME | TMR_ALPF, &qdata-
>>>> regs->tmr);
>>> +	if (sites != 0) {
>>> +		if (qdata->ver == TMU_VER1) {
>>> +			tmu_write(qdata, sites | TMR_ME | TMR_ALPF,
>>> +					&qdata->regs->tmr);
>>> +		} else {
>>> +			tmu_write(qdata, sites, &qdata->regs_v2->tmsr);
>>> +			tmu_write(qdata, TMR_ME | TMR_ALPF_V2,
>>> +					&qdata->regs_v2->tmr);
>>> +		}
>>> +	}
>>>
>>>  	return 0;
>>>  }
>>> @@ -148,16 +205,20 @@ static int qoriq_tmu_calibration(struct
>>> platform_device *pdev)
>>>  	struct device_node *np = pdev->dev.of_node;
>>>  	struct qoriq_tmu_data *data = platform_get_drvdata(pdev);
>>>
>>> -	if (of_property_read_u32_array(np, "fsl,tmu-range", range, 4)) {
>>> -		dev_err(&pdev->dev, "missing calibration range.\n");
>>> -		return -ENODEV;
>>> +	len = of_property_count_u32_elems(np, "fsl,tmu-range");
>>> +	if (len < 0 || len > 4) {
>>> +		dev_err(&pdev->dev, "invalid range data.\n");
>>> +		return len;
>>> +	}
>>> +
>>> +	val = of_property_read_u32_array(np, "fsl,tmu-range", range, len);
>>> +	if (val != 0) {
>>> +		dev_err(&pdev->dev, "failed to read range data.\n");
>>> +		return val;
>>>  	}
>>>
>>> -	/* Init temperature range registers */
>>> -	tmu_write(data, range[0], &data->regs->ttr0cr);
>>> -	tmu_write(data, range[1], &data->regs->ttr1cr);
>>> -	tmu_write(data, range[2], &data->regs->ttr2cr);
>>> -	tmu_write(data, range[3], &data->regs->ttr3cr);
>>> +	for (i = 0; i < len; i++)
>>> +		tmu_write(data, range[i], &data->regs->ttrcr[i]);
>>>
>>>  	calibration = of_get_property(np, "fsl,tmu-calibration", &len);
>>>  	if (calibration == NULL || len % 8) { @@ -181,7 +242,12 @@ static
>>> void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
>>>  	tmu_write(data, TIER_DISABLE, &data->regs->tier);
>>>
>>>  	/* Set update_interval */
>>> -	tmu_write(data, TMTMIR_DEFAULT, &data->regs->tmtmir);
>>> +	if (data->ver == TMU_VER1) {
>>> +		tmu_write(data, TMTMIR_DEFAULT, &data->regs->tmtmir);
>>> +	} else {
>>> +		tmu_write(data, TMTMIR_DEFAULT, &data->regs_v2-
>>>> tmtmir);
>>> +		tmu_write(data, TEUMR0_V2, &data->regs_v2->teumr0);
>>> +	}
>>>
>>>  	/* Disable monitoring */
>>>  	tmu_write(data, TMR_DISABLE, &data->regs->tmr); @@ -190,6
>>> +256,7 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_data
>>> +*data)
>>> static int qoriq_tmu_probe(struct platform_device *pdev)  {
>>>  	int ret;
>>> +	u32 ver;
>>>  	struct qoriq_tmu_data *data;
>>>  	struct device_node *np = pdev->dev.of_node;
>>>
>>> @@ -209,6 +276,12 @@ static int qoriq_tmu_probe(struct
>> platform_device
>>> *pdev)
>>>  		goto err_iomap;
>>>  	}
>>>
>>> +	/* version register offset at: 0xbf8 on both v1 and v2 */
>>> +	ver = tmu_read(data, &data->regs->ipbrr0);
>>> +	data->ver = (ver >> 8) & 0xff;
>>> +	if (data->ver == TMU_VER2)
>>> +		data->regs_v2 = (void __iomem *)data->regs;
>>> +
>>>  	qoriq_tmu_init_device(data);	/* TMU initialization */
>>>
>>>  	ret = qoriq_tmu_calibration(pdev);	/* TMU calibration */
>>> --
>>> 2.17.1
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

