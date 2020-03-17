Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6F491877D6
	for <lists+linux-pm@lfdr.de>; Tue, 17 Mar 2020 03:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgCQCcx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Mar 2020 22:32:53 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42529 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgCQCcx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Mar 2020 22:32:53 -0400
Received: by mail-pl1-f196.google.com with SMTP id t3so8908914plz.9;
        Mon, 16 Mar 2020 19:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FAaAv0KAtQ+g4TsuLnEC4E5T9EN4DSzcxghQTVvaPqw=;
        b=WWx/4uLUu+gZLifjHan2oBAScWRAOvN5ihCO++2P3H897mATH/d5cdydNK7b37c5AB
         SK4rr+8KMrQeWyzizz4mx6UEZlZR7ZgNYDXInGUNYR1iaMk3gPn2/5rVi0dPj/CdlUiL
         ltuGB+Sd19jlo0aizVpGDjUpquzdNTNc+ntdbCXPd0TKJUC8oky3SWZDGAX1mmamRjOu
         DYbH6Zmli8R2DxjRBek2OfN/RpHzdgvHlzJeKsNIGeqFIlzIRwf5aphWKdspRLPIDKsV
         BWR04/ZzxhINSvNPji+xCrMsqdN08UMdbIntpMLt2WhroWX2k4mFWYS5LpPBjmqjd1Mw
         etEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=FAaAv0KAtQ+g4TsuLnEC4E5T9EN4DSzcxghQTVvaPqw=;
        b=EeF5YRMJX2me3iuLadmKFa0nGr0EkN2LamRtnepawdN5Kjp0X5yt2H/Ib/RtWrrCus
         0PEzmJunfmFnpVxykbXqOtq4030L+REN/36/HXHYIKvT9MYIKQoeuepxxvvHmUBZb2ZY
         dqM2jV6EfH1ZOZJaROwUJQUs2qmYG0VmxJskrAHtXq+DM75Dr4vZBVEiGpbc6KPEQklT
         fNdDL6vefT559ohRvG4h2PCY76FHB3xMTTSew0xTAORELuPtOh0mwaHgfaGMymaM4b+0
         OeCO1MqXoDxR7vuMwMy+nKlz/uEQ523RsLoLbsg/kGEkcs/HMT/MQB0E6tCATlXVcY8H
         g+KQ==
X-Gm-Message-State: ANhLgQ1zb8+DYiegV7ZEFA33Eal3cetwpVo8GM8k5DVVUMnBHBaOeXC6
        c/PxvJW6ObaLONCicasFWzg=
X-Google-Smtp-Source: ADFU+vu5uSPxzs7cH/nMK+GHPB1KRUFrsBapPgV1+Fa1nCOT0TBYHWvZflsk9z44akXMzEhLVEffFQ==
X-Received: by 2002:a17:90a:232d:: with SMTP id f42mr2434700pje.185.1584412370784;
        Mon, 16 Mar 2020 19:32:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l17sm722415pgi.71.2020.03.16.19.32.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2020 19:32:49 -0700 (PDT)
Subject: Re: [PATCH V3 1/7] firmware: imx: Add stubs for !CONFIG_IMX_SCU case
To:     Peng Fan <peng.fan@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "ronald@innovation.ch" <ronald@innovation.ch>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
References: <20200316005219.GD17221@dragon>
 <AM0PR04MB44819E4A9E027F1555C33D0B88F90@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20200316030744.GC17221@dragon>
 <AM0PR04MB44817A48746601EADA4E06BC88F90@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20200316033447.GE17221@dragon>
 <DB3PR0402MB3916DA9F0F175B9D2E9E684FF5F90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20200316084056.GG4518@piout.net>
 <DB3PR0402MB391663DB37A8D241092AD708F5F90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20200316090053.GH4518@piout.net>
 <DB3PR0402MB391683A05820920158DFDA77F5F90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20200316091541.GI4518@piout.net>
 <DB3PR0402MB39169528B3FF39E23C7A90FCF5F90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM0PR04MB4481A54C639FD1D45098302088F60@AM0PR04MB4481.eurprd04.prod.outlook.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <b049be1c-1f3f-54fc-3c47-0873d95cb769@roeck-us.net>
Date:   Mon, 16 Mar 2020 19:32:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB4481A54C639FD1D45098302088F60@AM0PR04MB4481.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/16/20 7:18 PM, Peng Fan wrote:
>> Subject: RE: [PATCH V3 1/7] firmware: imx: Add stubs for !CONFIG_IMX_SCU
>> case
>>
>> Hi, Alexandre
>>
>>> -----Original Message-----
>>> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
>>> Sent: Monday, March 16, 2020 5:16 PM
>>> To: Anson Huang <anson.huang@nxp.com>
>>> Cc: Shawn Guo <shawnguo@kernel.org>; Peng Fan <peng.fan@nxp.com>;
>>> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
>>> dmitry.torokhov@gmail.com; a.zummo@towertech.it;
>> rui.zhang@intel.com;
>>> daniel.lezcano@linaro.org; amit.kucheria@verdurent.com; wim@linux-
>>> watchdog.org; linux@roeck-us.net; Daniel Baluta
>>> <daniel.baluta@nxp.com>; gregkh@linuxfoundation.org;
>>> linux@rempel-privat.de; tglx@linutronix.de; m.felsch@pengutronix.de;
>>> andriy.shevchenko@linux.intel.com;
>>> arnd@arndb.de; ronald@innovation.ch; krzk@kernel.org; robh@kernel.org;
>>> Leonard Crestez <leonard.crestez@nxp.com>; Aisheng Dong
>>> <aisheng.dong@nxp.com>; linux-arm-kernel@lists.infradead.org; linux-
>>> kernel@vger.kernel.org; linux-input@vger.kernel.org; linux-
>>> rtc@vger.kernel.org; linux-pm@vger.kernel.org; linux-
>>> watchdog@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
>>> Subject: Re: [PATCH V3 1/7] firmware: imx: Add stubs for
>>> !CONFIG_IMX_SCU case
>>>
>>> On 16/03/2020 09:08:53+0000, Anson Huang wrote:
>>>>> Why do you absolutely need to compile them independently? From a
>>>>> code coverage point of view, having:
>>>>>
>>>>> COMPILE_TEST=y
>>>>> CONFIG_IMX_SCU=y
>>>>>
>>>>> is enough to select and compile the remaining drivers.
>>>>
>>>> What I meant is for below case, like using other arch config which
>>>> does NOT have CONFIG_IMX_SCU selected, ONLY with COMPILE_TEST
>>>> selected, adding stubs for IMX_SCU APIs can fix such scenario.
>>>>
>>>> COMPILE_TEST=y
>>>> CONFIG_IMX_SCU=n
>>>>
>>>
>>> Why is that an issue? If they don't have IMX_SCU selected, then the
>>> other SCU driver are not selected either, having stubs doesn't change
>>> that you will have to select at least one option. Please explain what
>>> is the issue that is not solved here.
>>
>> OK, what I thought is even without IMX_SCU selected, other SCU drivers still
>> can be selected for build test after adding "COMPILE_TEST" to the kconfig,
>> like below, if without IMX_SCU API stubs, the "COMPILE_TEST" can NOT be
>> added to SCU drivers to enable build test, so I think the IMX_SCU API stubs
>> should be added?
> 
> Forgot to mention, without stub api, for drivers with
> " #include <linux/firmware/imx/sci.h> " will met compile error without
> +#ifdef CONFIG_IMX_SCU
> +#endif
> 
> So we have to use ifdef CONFIG_IMX_SCU to guard the include.
> 
Add "depends on IMX_SCU" to the Kconfig entry for those drivers,
and/or drop "COMPILE_TEST" from their Kconfig entry.

Really, COMPILE_TEST is abused here. I start to understand those who
advocate that it should be removed. This is an excellent case in point.

Guenter
