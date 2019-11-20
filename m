Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F19B103F18
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2019 16:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732065AbfKTPlP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 10:41:15 -0500
Received: from node.akkea.ca ([192.155.83.177]:56262 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731906AbfKTPlI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 Nov 2019 10:41:08 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id A14614E200E;
        Wed, 20 Nov 2019 15:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1574264467; bh=c1bwvGZ3DtvSeRPrVEI/eLrZgFbhGdVgFlrw3H+Ljmg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=W8kQw5TiUDaohToYRNY47L6bmIwZ1V9gB2GsTL8ZcnBCvzYIuFzBsu+ZWC1RTl495
         tg8GMEM99IGqVzCmA4BeIqefw7g9e3VbBVJXEmkeJ/3TNBQcU7FPDLD6pd6c8ywVaH
         KwtpqvqJvQZgB3SVwvpxgvnc2Nl3VhGbNm6NOG3g=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bzL7GrYHn4P7; Wed, 20 Nov 2019 15:41:06 +0000 (UTC)
Received: from www.akkea.ca (node.akkea.ca [192.155.83.177])
        by node.akkea.ca (Postfix) with ESMTPSA id 7E7C64E2003;
        Wed, 20 Nov 2019 15:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1574264466; bh=c1bwvGZ3DtvSeRPrVEI/eLrZgFbhGdVgFlrw3H+Ljmg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=mwzIUaLoFOmzPRRwdy6cZm1S1cVC3dxyuglKyfH2imk2OPl2aFZgClNXZ2MoQsSd5
         5zvMyZw2rWcC0Beme8vIYyQW/vw+JDYhY4bDgw/OMjbULDuW7HH1JjI/W6X0x/Rryn
         S3ySlOmYGvbtcHZ+5OWyQotpdiB131AG7YWtTqDw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 20 Nov 2019 07:41:06 -0800
From:   Angus Ainslie <angus@akkea.ca>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Jacky Bai <ping.bai@nxp.com>,
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
In-Reply-To: <VI1PR04MB70233920AC838AD88E1ECC26EE4F0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1573761527.git.leonard.crestez@nxp.com>
 <f329e715898a6b9fd0cee707a93fb1e144e31bd4.1573761527.git.leonard.crestez@nxp.com>
 <e311a376e6aec0c380686a7e307d2c07@akkea.ca>
 <VI1PR04MB70233920AC838AD88E1ECC26EE4F0@VI1PR04MB7023.eurprd04.prod.outlook.com>
Message-ID: <008f2fa973b23fc716d678c5bd35af54@akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Leonard,

On 2019-11-20 07:04, Leonard Crestez wrote:
> On 20.11.2019 16:08, Angus Ainslie wrote:
>> Hi Leonard,
>> 
>> On 2019-11-14 12:09, Leonard Crestez wrote:
>>> Add initial support for dynamic frequency switching on pieces of the
>>> imx
>>> interconnect fabric.
>>> 
>>> All this driver does is set a clk rate based on an opp table, it does
>>> not map register areas.
>>> 
>> 
>> Is this working with mainline ATF or does it still need to be used 
>> with
>> your modified ATF code ?
> 
> This series doesn't perform SMC calls, that's done by the imx8m-ddrc
> driver: https://patchwork.kernel.org/cover/11244283/
> 
> This particular patch allows switching NOC frequency but that's just
> clk_set_rate.
> 
> DDRC frequency switching requires the imx branch of ATF (v2.0 + ~200
> patches) otherwise you will get probe failures. Source for imx atf is
> published here: https://source.codeaurora.org/external/imx/imx-atf/

Ok I was under the impression that the imx_2.0.y_busfreq branch below 
was based on this. Shouldn't those patches be added to the imx ATF ?

> 
> For your particular 8mq B0 case slightly different setpoints are used
> and the fix is not in any public release yet so you need this:
> 
> https://github.com/cdleonard/arm-trusted-firmware/commits/imx_2.0.y_busfreq
> 

We also have 2n14w ( is that B1 ? ) imx8mq's that we are working with.

> Is "mainline ATF" an important criteria for Purism?
> 

Yes we intend to bring all of our patches to mainline and were hoping 
that NXP would be doing the same. Shouldn't a mainline kernel run on a 
mainline ATF ?

Thanks
Angus

> --
> Regards,
> Leonard
