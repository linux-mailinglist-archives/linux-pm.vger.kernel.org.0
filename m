Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF9941040EF
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2019 17:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbfKTQiu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 11:38:50 -0500
Received: from node.akkea.ca ([192.155.83.177]:58348 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728632AbfKTQiu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 Nov 2019 11:38:50 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 03FA34E2006;
        Wed, 20 Nov 2019 16:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1574267929; bh=yczOZvIA0pLja/5G0e638pMmagqLwd3PNzd2MZu2vOU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=lj/jZgQOfWzo9rVMjutg1sXICkp8Vk+49zefmARb4JwXgRKj9s5c6+gchibOiHVPG
         hDUmJj7Dr0KagVFA3OWk5o6jj3NEqqumnSzXnkGzPwjYpudUCZOvf7BlwDkwX7X7ld
         GHbVRZYi+SPyduIMwtZG8YVI/XdIdE3vVLZHtwMI=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Iv-fRhyZHsij; Wed, 20 Nov 2019 16:38:48 +0000 (UTC)
Received: from www.akkea.ca (node.akkea.ca [192.155.83.177])
        by node.akkea.ca (Postfix) with ESMTPSA id E6FDA4E2003;
        Wed, 20 Nov 2019 16:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1574267928; bh=yczOZvIA0pLja/5G0e638pMmagqLwd3PNzd2MZu2vOU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=tqbElT9ZO2tAyJD7l5bEkeiJteKz2XWL4JyNFyLBz88DyiD0eVQXerb8ql0O48ffK
         xgojrMoXhpEhRz/OHGmIuaytixs1dmK3j24oeZC3DJ+klFXGUfbAicDEHn49eVfL4O
         21kp12ypXZVGw+Aso2Y3V/SWfFPZb5lTz41hGhcs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 20 Nov 2019 08:38:47 -0800
From:   Angus Ainslie <angus@akkea.ca>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Jacky Bai <ping.bai@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?Q?Artur_=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Martin Kepplinger <martink@posteo.de>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de,
        dl-linux-imx <linux-imx@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-pm-owner@vger.kernel.org
Subject: Re: [PATCH RFC v6 2/9] PM / devfreq: Add generic imx bus scaling
 driver
In-Reply-To: <VI1PR04MB7023E7C380EFA956629EEB67EE4F0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1573761527.git.leonard.crestez@nxp.com>
 <f329e715898a6b9fd0cee707a93fb1e144e31bd4.1573761527.git.leonard.crestez@nxp.com>
 <e311a376e6aec0c380686a7e307d2c07@akkea.ca>
 <VI1PR04MB70233920AC838AD88E1ECC26EE4F0@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <008f2fa973b23fc716d678c5bd35af54@akkea.ca>
 <VI1PR04MB7023E7C380EFA956629EEB67EE4F0@VI1PR04MB7023.eurprd04.prod.outlook.com>
Message-ID: <d1ca09bdeb7580c9b62b491c6eb30148@akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019-11-20 08:30, Leonard Crestez wrote:
> On 20.11.2019 17:41, Angus Ainslie wrote:
>> Hi Leonard,
>> 
>> On 2019-11-20 07:04, Leonard Crestez wrote:
>>> On 20.11.2019 16:08, Angus Ainslie wrote:
>>> Is "mainline ATF" an important criteria for Purism?
>> 
>> Yes we intend to bring all of our patches to mainline and were hoping
>> that NXP would be doing the same. Shouldn't a mainline kernel run on a
>> mainline ATF ?
> 
> You can still use mainline ATF (tested right now) but the imx8m-ddrc
> driver won't probe.
> 

Sorry I was talking about the DDR frequency scaling specifically.

> The ability to mix and match different branches of firmware and kernel
> is very useful for testing. There might be slight incompatibilities but
> in theory if a feature depends on both firmware and kernel support then
> it should gracefully degrade rather than crash or hang.

I saw the check you put in for the correct ATF version and that's very 
helpful thanks.

> 
> ATF support for this feature will be mainlined eventually, I picked the
> linux side first because review is more challenging and changes are 
> much
> larger relative to what we have in our internal tree.
> 

Do you have a patch against mainline ATF that we can test this feature 
with ?

Thanks
Angus

> --
> Regards,
> Leonard
