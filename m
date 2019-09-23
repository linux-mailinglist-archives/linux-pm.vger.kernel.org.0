Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE435BB92E
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2019 18:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388189AbfIWQLe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Sep 2019 12:11:34 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39785 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387819AbfIWQLe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Sep 2019 12:11:34 -0400
Received: by mail-pf1-f195.google.com with SMTP id v4so4785061pff.6
        for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2019 09:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kzmk5oXzqDZ+eAfZk6u16J40xX3fX7uris0kIfdxInw=;
        b=fffi+cvfsjwYCv4QYdDnkvsY+TJKFEEpszFsHlCLEO+CEYgxiwuCzHIamqdPBoRfa2
         bZLHt74bTA0AGxOpx4NQXXyKqS+CD11W5glUd1qpDLKV+WlrgXDr5o8I7f+6+GKldDmq
         2x0XJdoUg9WqePPy+syGAofvFBBAiJGHwNtt/zMddFquelri0V27mZYRN5RKwxBjh67+
         qTAcjWXp0GhxJu4tvDoNXr9y9bpYxvLe7NNLpH0f4Jfl9svekAZKvmGPwQnF+Z8maNVC
         S9z4DofIS/Pe+oKOBhkJ16i43EVrlto9glpM7nqEGYIbrlC+ROtgaqyphhu0PPQaWaG+
         8f/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=kzmk5oXzqDZ+eAfZk6u16J40xX3fX7uris0kIfdxInw=;
        b=Hs3xjDz8Nhakg9YtmR51mgyCg51wZIMuXIMm58eERDRM/pOHksJETII1v47fHm3oqr
         VTN3SVdb8f8xt4Vvqi9D5vL7kIHzqsDgoKkTFRa9sMPk/JRYJduAG6L8VYDugVKyidng
         G25wg/hYoGUXGc8NcBjEpRMZR6ZQ/UXAoFHZrWYC7GSRJyybwrShui9HB4Z1Za4VGk6t
         0rIVdcyjfPR4JSyeXt/EkQIhl5ls1HxDxLbSS0uufogCP24YFxU6wrPq6PGcDclniAhX
         Z0Uy6aqFjrYiEd7RoeUESeF+rQVtz8KMcf8jc+hMiSCJotP0GilEaOVYZEmEdzY9mrKN
         aiHA==
X-Gm-Message-State: APjAAAVQZ5aTVetSq8TrrVarq//z0Fc3QOaQRkJeb+BNSJQjNKJ6hJbc
        23dKBFdm7/8KYaKMVgkwKp7vTQ==
X-Google-Smtp-Source: APXvYqwA+dFApMyvE2ln5b6T7vC7Gx5OynMdSY90utpDea9eKcaya8QCOjZ4dRYeEwXZKvzIZHjcSg==
X-Received: by 2002:a63:61c2:: with SMTP id v185mr694837pgb.96.1569255093168;
        Mon, 23 Sep 2019 09:11:33 -0700 (PDT)
Received: from [172.20.32.102] ([12.157.10.114])
        by smtp.googlemail.com with ESMTPSA id 197sm10443591pge.39.2019.09.23.09.11.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 09:11:32 -0700 (PDT)
Subject: Re: [PATCH] thermal: qoriq: add thermal monitor unit version 2
 support
To:     Andy Tang <andy.tang@nxp.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>
Cc:     Leo Li <leoyang.li@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190604025114.46085-1-andy.tang@nxp.com>
 <VI1PR04MB433382A830BE0857134ABF5BF3D50@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <VI1PR04MB4333D4FAA6F25AD30CADF0D4F3A20@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <VI1PR04MB433332B34EF758457365AE91F3850@VI1PR04MB4333.eurprd04.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 mQINBFv/yykBEADDdW8RZu7iZILSf3zxq5y8YdaeyZjI/MaqgnvG/c3WjFaunoTMspeusiFE
 sXvtg3ehTOoyD0oFjKkHaia1Zpa1m/gnNdT/WvTveLfGA1gH+yGes2Sr53Ht8hWYZFYMZc8V
 2pbSKh8wepq4g8r5YI1XUy9YbcTdj5mVrTklyGWA49NOeJz2QbfytMT3DJmk40LqwK6CCSU0
 9Ed8n0a+vevmQoRZJEd3Y1qXn2XHys0F6OHCC+VLENqNNZXdZE9E+b3FFW0lk49oLTzLRNIq
 0wHeR1H54RffhLQAor2+4kSSu8mW5qB0n5Eb/zXJZZ/bRiXmT8kNg85UdYhvf03ZAsp3qxcr
 xMfMsC7m3+ADOtW90rNNLZnRvjhsYNrGIKH8Ub0UKXFXibHbafSuq7RqyRQzt01Ud8CAtq+w
 P9EftUysLtovGpLSpGDO5zQ++4ZGVygdYFr318aGDqCljKAKZ9hYgRimPBToDedho1S1uE6F
 6YiBFnI3ry9+/KUnEP6L8Sfezwy7fp2JUNkUr41QF76nz43tl7oersrLxHzj2dYfWUAZWXva
 wW4IKF5sOPFMMgxoOJovSWqwh1b7hqI+nDlD3mmVMd20VyE9W7AgTIsvDxWUnMPvww5iExlY
 eIC0Wj9K4UqSYBOHcUPrVOKTcsBVPQA6SAMJlt82/v5l4J0pSQARAQABtCpEYW5pZWwgTGV6
 Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz6JAlcEEwEIAEECGwEFCwkIBwIGFQoJ
 CAsCBBYCAwECHgECF4ACGQEWIQQk1ibyU76eh+bOW/SP9LjScWdVJwUCXAkeagUJDRnjhwAK
 CRCP9LjScWdVJ+vYEACStDg7is2JdE7xz1PFu7jnrlOzoITfw05BurgJMqlvoiFYt9tEeUMl
 zdU2+r0cevsmepqSUVuUvXztN8HA/Ep2vccmWnCXzlE56X1AK7PRRdaQd1SK/eVsJVaKbQTr
 ii0wjbs6AU1uo0LdLINLjwwItnQ83/ttbf1LheyN8yknlch7jn6H6J2A/ORZECTfJbG4ecVr
 7AEm4A/G5nyPO4BG7dMKtjQ+crl/pSSuxV+JTDuoEWUO+YOClg6azjv8Onm0cQ46x9JRtahw
 YmXdIXD6NsJHmMG9bKmVI0I7o5Q4XL52X6QxkeMi8+VhvqXXIkIZeizZe5XLTYUvFHLdexzX
 Xze0LwLpmMObFLifjziJQsLP2lWwOfg6ZiH8z8eQJFB8bYTSMqmfTulB61YO0mhd676q17Y7
 Z7u3md3CLH7rh61wU1g7FcLm9p5tXXWWaAud9Aa2kne2O3sirO0+JhsKbItz3d9yXuWgv6w3
 heOIF0b91JyrY6tjz42hvyjxtHywRr4cdAEQa2S7HeQkw48BQOG6PqQ9d3FYU34pt3WFJ19V
 A5qqAiEjqc4N0uPkC79W32yLGdyg0EEe8v0Uhs3CxM9euGg37kr5fujMm+akMtR1ENITo+UI
 fgsxdwjBD5lNb/UGodU4QvPipB/xx4zz7pS5+2jGimfLeoe7mgGJxrkBDQRb/8z6AQgAvSkg
 5w7dVCSbpP6nXc+i8OBz59aq8kuL3YpxT9RXE/y45IFUVuSc2kuUj683rEEgyD7XCf4QKzOw
 +XgnJcKFQiACpYAowhF/XNkMPQFspPNM1ChnIL5KWJdTp0DhW+WBeCnyCQ2pzeCzQlS/qfs3
 dMLzzm9qCDrrDh/aEegMMZFO+reIgPZnInAcbHj3xUhz8p2dkExRMTnLry8XXkiMu9WpchHy
 XXWYxXbMnHkSRuT00lUfZAkYpMP7La2UudC/Uw9WqGuAQzTqhvE1kSQe0e11Uc+PqceLRHA2
 bq/wz0cGriUrcCrnkzRmzYLoGXQHqRuZazMZn2/pSIMZdDxLbwARAQABiQI2BBgBCAAgFiEE
 JNYm8lO+nofmzlv0j/S40nFnVScFAlv/zPoCGwwACgkQj/S40nFnVSf4OhAAhWJPjgUu6VfS
 mV53AUGIyqpOynPvSaMoGJzhNsDeNUDfV5dEZN8K4qjuz2CTNvGIyt4DE/IJbtasvi5dW4wW
 Fl85bF6xeLM0qpCaZtXAsU5gzp3uT7ut++nTPYW+CpfYIlIpyOIzVAmw7rZbfgsId2Lj7g1w
 QCjvGHw19mq85/wiEiZZNHeJQ3GuAr/uMoiaRBnf6wVcdpUTFMXlkE8/tYHPWbW0YKcKFwJ3
 uIsNxZUe6coNzYnL0d9GK2fkDoqKfKbFjNhW9TygfeL2Qhk949jMGQudFS3zlwvN9wwVaC0i
 KC/D303DiTnB0WFPT8CltMAZSbQ1WEWfwqxhY26di3k9pj+X3BfOmDL9GBlnRTSgwjqjqzpG
 VZsWouuTfXd9ZPPzvYdUBrlTKgojk1C8v4fhSqb+ard+bZcwNp8Tzl/EI9ygw6lYEATGCUYI
 Wco+fjehCgG1FWvWavMU+jLNs8/8uwj1u+BtRpWFj4ug/VaDDIuiApKPwl1Ge+zoC7TLMtyb
 c00W5/8EckjmNgLDIINEsOsidMH61ZOlwDKCxo2lbV+Ij078KHBIY76zuHlwonEQaHLCAdqm
 WiI95pYZNruAJEqZCpvXDdClmBVMZRDRePzSljCvoHxn7ArEt3F14mabn2RRq/hqB8IhC6ny
 xAEPQIZaxxginIFYEziOjR65AQ0EW//NCAEIALcJqSmQdkt04vIBD12dryF6WcVWYvVwhspt
 RlZbZ/NZ6nzarzEYPFcXaYOZCOCv+Xtm6hB8fh5XHd7Y8CWuZNDVp3ozuqwTkzQuux/aVdNb
 Fe4VNeKGN2FK1aNlguAXJNCDNRCpWgRHuU3rWwGUMgentJogARvxfex2/RV/5mzYG/N1DJKt
 F7g1zEcQD3JtK6WOwZXd+NDyke3tdG7vsNRFjMDkV4046bOOh1BKbWYu8nL3UtWBxhWKx3Pu
 1VOBUVwL2MJKW6umk+WqUNgYc2bjelgcTSdz4A6ZhJxstUO4IUfjvYRjoqle+dQcx1u+mmCn
 8EdKJlbAoR4NUFZy7WUAEQEAAYkDbAQYAQgAIBYhBCTWJvJTvp6H5s5b9I/0uNJxZ1UnBQJb
 /80IAhsCAUAJEI/0uNJxZ1UnwHQgBBkBCAAdFiEEGn3N4YVz0WNVyHskqDIjiipP6E8FAlv/
 zQgACgkQqDIjiipP6E+FuggAl6lkO7BhTkrRbFhrcjCm0bEoYWnCkQtX9YFvElQeA7MhxznO
 BY/r1q2Uf6Ifr3YGEkLnME/tQQzUwznydM94CtRJ8KDSa1CxOseEsKq6B38xJtjgYSxNdgQb
 EIfCzUHIGfk94AFKPdV6pqqSU5VpPUagF+JxiAkoEPOdFiQCULFNRLMsOtG7yp8uSyJRp6Tz
 cQ+0+1QyX1krcHBUlNlvfdmL9DM+umPtbS9F6oRph15mvKVYiPObI1z8ymHoc68ReWjhUuHc
 IDQs4w9rJVAyLypQ0p+ySDcTc+AmPP6PGUayIHYX63Q0KhJFgpr1wH0pHKpC78DPtX1a7HGM
 7MqzQ4NbD/4oLKKwByrIp12wLpSe3gDQPxLpfGgsJs6BBuAGVdkrdfIx2e6ENnwDoF0Veeji
 BGrVmjVgLUWV9nUP92zpyByzd8HkRSPNZNlisU4gnz1tKhQl+j6G/l2lDYsqKeRG55TXbu9M
 LqJYccPJ85B0PXcy63fL9U5DTysmxKQ5RgaxcxIZCM528ULFQs3dfEx5euWTWnnh7pN30RLg
 a+0AjSGd886Bh0kT1Dznrite0dzYlTHlacbITZG84yRk/gS7DkYQdjL8zgFr/pxH5CbYJDk0
 tYUhisTESeesbvWSPO5uNqqy1dAFw+dqRcF5gXIh3NKX0gqiAA87NM7nL5ym/CNpJ7z7nRC8
 qePOXubgouxumi5RQs1+crBmCDa/AyJHKdG2mqCt9fx5EPbDpw6Zzx7hgURh4ikHoS7/tLjK
 iqWjuat8/HWc01yEd8rtkGuUcMqbCi1XhcAmkaOnX8FYscMRoyyMrWClRZEQRokqZIj79+PR
 adkDXtr4MeL8BaB7Ij2oyRVjXUwhFQNKi5Z5Rve0a3zvGkkqw8Mz20BOksjSWjAF6g9byukl
 CUVjC03PdMSufNLK06x5hPc/c4tFR4J9cLrV+XxdCX7r0zGos9SzTPGNuIk1LK++S3EJhLFj
 4eoWtNhMWc1uiTf9ENza0ntqH9XBWEQ6IA1gubCniGG+Xg==
Message-ID: <1f0f5931-ae9a-5495-aa56-3d66d114a488@linaro.org>
Date:   Mon, 23 Sep 2019 18:11:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB433332B34EF758457365AE91F3850@VI1PR04MB4333.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23/09/2019 11:24, Andy Tang wrote:
> Hi Rui, Edubezval,
> 
> Would you please review this patch?

Eduardo,

can you give an update about the thermal maintenance discussion we had
at LPC2019?

Thanks

  -- Daniel

>> -----Original Message-----
>> From: Andy Tang
>> Sent: 2019年8月29日 16:38
>> To: 'edubezval@gmail.com' <edubezval@gmail.com>; 'rui.zhang@intel.com'
>> <rui.zhang@intel.com>
>> Cc: 'daniel.lezcano@linaro.org' <daniel.lezcano@linaro.org>; Leo Li
>> <leoyang.li@nxp.com>; 'linux-pm@vger.kernel.org'
>> <linux-pm@vger.kernel.org>; 'linux-kernel@vger.kernel.org'
>> <linux-kernel@vger.kernel.org>
>> Subject: RE: [PATCH] thermal: qoriq: add thermal monitor unit version 2
>> support
>>
>> Hi Rui, Edubezval,
>>
>> Almost three monthes passed, I have not got your comments from you.
>> Could you please take a look at this patch?
>>
>> BR,
>> Andy
>>
>>> -----Original Message-----
>>> From: Andy Tang
>>> Sent: 2019年8月6日 10:57
>>> To: edubezval@gmail.com; rui.zhang@intel.com
>>> Cc: daniel.lezcano@linaro.org; Leo Li <leoyang.li@nxp.com>;
>>> linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
>>> Subject: RE: [PATCH] thermal: qoriq: add thermal monitor unit version
>>> 2 support
>>>
>>> Any comments?
>>>
>>> BR,
>>> Andy
>>>
>>>> -----Original Message-----
>>>> From: Yuantian Tang <andy.tang@nxp.com>
>>>> Sent: 2019年6月4日 10:51
>>>> To: edubezval@gmail.com; rui.zhang@intel.com
>>>> Cc: daniel.lezcano@linaro.org; Leo Li <leoyang.li@nxp.com>;
>>>> linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; Andy Tang
>>>> <andy.tang@nxp.com>
>>>> Subject: [PATCH] thermal: qoriq: add thermal monitor unit version 2
>>>> support
>>>>
>>>> Thermal Monitor Unit v2 is introduced on new Layscape SoC.
>>>> Compared to v1, TMUv2 has a little different register layout and
>>>> digital output is fairly linear.
>>>>
>>>> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
>>>> ---
>>>>  drivers/thermal/qoriq_thermal.c | 122
>>>> +++++++++++++++++++++++++-------
>>>>  1 file changed, 98 insertions(+), 24 deletions(-)
>>>>
>>>> diff --git a/drivers/thermal/qoriq_thermal.c
>>>> b/drivers/thermal/qoriq_thermal.c index 3b5f5b3fb1bc..0df6dfddf804
>>>> 100644
>>>> --- a/drivers/thermal/qoriq_thermal.c
>>>> +++ b/drivers/thermal/qoriq_thermal.c
>>>> @@ -13,6 +13,15 @@
>>>>  #include "thermal_core.h"
>>>>
>>>>  #define SITES_MAX	16
>>>> +#define TMR_DISABLE	0x0
>>>> +#define TMR_ME		0x80000000
>>>> +#define TMR_ALPF	0x0c000000
>>>> +#define TMR_ALPF_V2	0x03000000
>>>> +#define TMTMIR_DEFAULT	0x0000000f
>>>> +#define TIER_DISABLE	0x0
>>>> +#define TEUMR0_V2	0x51009C00
>>>> +#define TMU_VER1	0x1
>>>> +#define TMU_VER2	0x2
>>>>
>>>>  /*
>>>>   * QorIQ TMU Registers
>>>> @@ -23,17 +32,55 @@ struct qoriq_tmu_site_regs {
>>>>  	u8 res0[0x8];
>>>>  };
>>>>
>>>> -struct qoriq_tmu_regs {
>>>> +struct qoriq_tmu_regs_v2 {
>>>> +	u32 tmr;		/* Mode Register */
>>>> +	u32 tsr;		/* Status Register */
>>>> +	u32 tmsr;		/* monitor site register */
>>>> +	u32 tmtmir;		/* Temperature measurement interval Register
>> */
>>>> +	u8 res0[0x10];
>>>> +	u32 tier;		/* Interrupt Enable Register */
>>>> +	u32 tidr;		/* Interrupt Detect Register */
>>>> +	u8 res1[0x8];
>>>> +	u32 tiiscr;		/* interrupt immediate site capture register */
>>>> +	u32 tiascr;		/* interrupt average site capture register */
>>>> +	u32 ticscr;		/* Interrupt Critical Site Capture Register */
>>>> +	u32 res2;
>>>> +	u32 tmhtcr;		/* monitor high temperature capture register */
>>>> +	u32 tmltcr;		/* monitor low temperature capture register */
>>>> +	u32 tmrtrcr;	/* monitor rising temperature rate capture register
>> */
>>>> +	u32 tmftrcr;	/* monitor falling temperature rate capture register
>> */
>>>> +	u32 tmhtitr;	/* High Temperature Immediate Threshold */
>>>> +	u32 tmhtatr;	/* High Temperature Average Threshold */
>>>> +	u32 tmhtactr;	/* High Temperature Average Crit Threshold */
>>>> +	u32 res3;
>>>> +	u32 tmltitr;	/* monitor low temperature immediate threshold */
>>>> +	u32 tmltatr;	/* monitor low temperature average threshold
>> register */
>>>> +	u32 tmltactr;	/* monitor low temperature average critical
>> threshold */
>>>> +	u32 res4;
>>>> +	u32 tmrtrctr;	/* monitor rising temperature rate critical threshold
>> */
>>>> +	u32 tmftrctr;	/* monitor falling temperature rate critical
>> threshold*/
>>>> +	u8 res5[0x8];
>>>> +	u32 ttcfgr;	/* Temperature Configuration Register */
>>>> +	u32 tscfgr;	/* Sensor Configuration Register */
>>>> +	u8 res6[0x78];
>>>> +	struct qoriq_tmu_site_regs site[SITES_MAX];
>>>> +	u8 res7[0x9f8];
>>>> +	u32 ipbrr0;		/* IP Block Revision Register 0 */
>>>> +	u32 ipbrr1;		/* IP Block Revision Register 1 */
>>>> +	u8 res8[0x300];
>>>> +	u32 teumr0;
>>>> +	u32 teumr1;
>>>> +	u32 teumr2;
>>>> +	u32 res9;
>>>> +	u32 ttrcr[4];	/* Temperature Range Control Register */
>>>> +};
>>>> +
>>>> +struct qoriq_tmu_regs_v1 {
>>>>  	u32 tmr;		/* Mode Register */
>>>> -#define TMR_DISABLE	0x0
>>>> -#define TMR_ME		0x80000000
>>>> -#define TMR_ALPF	0x0c000000
>>>>  	u32 tsr;		/* Status Register */
>>>>  	u32 tmtmir;		/* Temperature measurement interval Register
>> */
>>>> -#define TMTMIR_DEFAULT	0x0000000f
>>>>  	u8 res0[0x14];
>>>>  	u32 tier;		/* Interrupt Enable Register */
>>>> -#define TIER_DISABLE	0x0
>>>>  	u32 tidr;		/* Interrupt Detect Register */
>>>>  	u32 tiscr;		/* Interrupt Site Capture Register */
>>>>  	u32 ticscr;		/* Interrupt Critical Site Capture Register */
>>>> @@ -53,10 +100,7 @@ struct qoriq_tmu_regs {
>>>>  	u32 ipbrr0;		/* IP Block Revision Register 0 */
>>>>  	u32 ipbrr1;		/* IP Block Revision Register 1 */
>>>>  	u8 res6[0x310];
>>>> -	u32 ttr0cr;		/* Temperature Range 0 Control Register */
>>>> -	u32 ttr1cr;		/* Temperature Range 1 Control Register */
>>>> -	u32 ttr2cr;		/* Temperature Range 2 Control Register */
>>>> -	u32 ttr3cr;		/* Temperature Range 3 Control Register */
>>>> +	u32 ttrcr[4];		/* Temperature Range Control Register */
>>>>  };
>>>>
>>>>  struct qoriq_tmu_data;
>>>> @@ -71,7 +115,9 @@ struct qoriq_sensor {  };
>>>>
>>>>  struct qoriq_tmu_data {
>>>> -	struct qoriq_tmu_regs __iomem *regs;
>>>> +	int ver;
>>>> +	struct qoriq_tmu_regs_v1 __iomem *regs;
>>>> +	struct qoriq_tmu_regs_v2 __iomem *regv2;
>>>>  	bool little_endian;
>>>>  	struct qoriq_sensor	*sensor[SITES_MAX];
>>>>  };
>>>> @@ -111,7 +157,7 @@ static const struct thermal_zone_of_device_ops
>>>> tmu_tz_ops = {  static int qoriq_tmu_register_tmu_zone(struct
>>>> platform_device *pdev)  {
>>>>  	struct qoriq_tmu_data *qdata = platform_get_drvdata(pdev);
>>>> -	int id, sites = 0;
>>>> +	int id, sites = 0, sv2 = 0;
>>>>
>>>>  	for (id = 0; id < SITES_MAX; id++) {
>>>>  		qdata->sensor[id] = devm_kzalloc(&pdev->dev, @@ -130,12
>>>> +176,24 @@ static int qoriq_tmu_register_tmu_zone(struct
>>>> +platform_device
>>>> *pdev)
>>>>  				return PTR_ERR(qdata->sensor[id]->tzd);
>>>>  		}
>>>>
>>>> -		sites |= 0x1 << (15 - id);
>>>> +		if (qdata->ver == TMU_VER1)
>>>> +			sites |= 0x1 << (15 - id);
>>>> +		else
>>>> +			sv2 |= 0x1 << id;
>>>>  	}
>>>>
>>>>  	/* Enable monitoring */
>>>> -	if (sites != 0)
>>>> -		tmu_write(qdata, sites | TMR_ME | TMR_ALPF,
>>>> &qdata->regs->tmr);
>>>> +	if (qdata->ver == TMU_VER1) {
>>>> +		if (sites != 0)
>>>> +			tmu_write(qdata, sites | TMR_ME | TMR_ALPF,
>>>> +					&qdata->regs->tmr);
>>>> +	} else {
>>>> +		if (sv2 != 0) {
>>>> +			tmu_write(qdata, sv2, &qdata->regv2->tmsr);
>>>> +			tmu_write(qdata, TMR_ME | TMR_ALPF_V2,
>>>> +					&qdata->regv2->tmr);
>>>> +		}
>>>> +	}
>>>>
>>>>  	return 0;
>>>>  }
>>>> @@ -148,16 +206,20 @@ static int qoriq_tmu_calibration(struct
>>>> platform_device *pdev)
>>>>  	struct device_node *np = pdev->dev.of_node;
>>>>  	struct qoriq_tmu_data *data = platform_get_drvdata(pdev);
>>>>
>>>> -	if (of_property_read_u32_array(np, "fsl,tmu-range", range, 4)) {
>>>> -		dev_err(&pdev->dev, "missing calibration range.\n");
>>>> -		return -ENODEV;
>>>> +	len = of_property_count_u32_elems(np, "fsl,tmu-range");
>>>> +	if (len == -ENODATA || len == -EINVAL || len > 4) {
>>>> +		dev_err(&pdev->dev, "invalid range data.\n");
>>>> +		return len;
>>>>  	}
>>>>
>>>> -	/* Init temperature range registers */
>>>> -	tmu_write(data, range[0], &data->regs->ttr0cr);
>>>> -	tmu_write(data, range[1], &data->regs->ttr1cr);
>>>> -	tmu_write(data, range[2], &data->regs->ttr2cr);
>>>> -	tmu_write(data, range[3], &data->regs->ttr3cr);
>>>> +	val = of_property_read_u32_array(np, "fsl,tmu-range", range, len);
>>>> +	if (val != 0) {
>>>> +		dev_err(&pdev->dev, "invalid range data.\n");
>>>> +		return val;
>>>> +	}
>>>> +
>>>> +	for (i = 0; i < len; i++)
>>>> +		tmu_write(data, range[i], &data->regs->ttrcr[i]);
>>>>
>>>>  	calibration = of_get_property(np, "fsl,tmu-calibration", &len);
>>>>  	if (calibration == NULL || len % 8) { @@ -181,7 +243,12 @@ static
>>>> void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
>>>>  	tmu_write(data, TIER_DISABLE, &data->regs->tier);
>>>>
>>>>  	/* Set update_interval */
>>>> -	tmu_write(data, TMTMIR_DEFAULT, &data->regs->tmtmir);
>>>> +	if (data->ver == TMU_VER1) {
>>>> +		tmu_write(data, TMTMIR_DEFAULT, &data->regs->tmtmir);
>>>> +	} else {
>>>> +		tmu_write(data, TMTMIR_DEFAULT, &data->regv2->tmtmir);
>>>> +		tmu_write(data, TEUMR0_V2, &data->regv2->teumr0);
>>>> +	}
>>>>
>>>>  	/* Disable monitoring */
>>>>  	tmu_write(data, TMR_DISABLE, &data->regs->tmr); @@ -190,6
>> +257,7
>>> @@
>>>> static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
>>>> static int qoriq_tmu_probe(struct platform_device *pdev)  {
>>>>  	int ret;
>>>> +	u32 ver;
>>>>  	struct qoriq_tmu_data *data;
>>>>  	struct device_node *np = pdev->dev.of_node;
>>>>
>>>> @@ -214,6 +282,12 @@ static int qoriq_tmu_probe(struct
>>> platform_device
>>>> *pdev)
>>>>  		goto err_iomap;
>>>>  	}
>>>>
>>>> +	/* version register offset at: 0xbf8 on both v1 and v2 */
>>>> +	ver = tmu_read(data, &data->regs->ipbrr0);
>>>> +	data->ver = (ver >> 8) & 0xff;
>>>> +	if (data->ver == TMU_VER2)
>>>> +		data->regv2 = (void __iomem *)data->regs;
>>>> +
>>>>  	qoriq_tmu_init_device(data);	/* TMU initialization */
>>>>
>>>>  	ret = qoriq_tmu_calibration(pdev);	/* TMU calibration */
>>>> --
>>>> 2.17.1
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

