Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA3CADEC1
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2019 20:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbfIISVE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Sep 2019 14:21:04 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.170]:21305 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbfIISVE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Sep 2019 14:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1568053262;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Sk5OR4pmbgyWkeMqms3Ra2DZT4PK2j+gZDf8HZXEQFc=;
        b=l3i7HnvxNpjhSvJXwLhtOnaY2jlXz2BJ5MkTqfxlfTGfweDaIosqrBXFRVdh4mUSq3
        wUFa/0r0iESKne++pD2+l39TFnO7a36uVzmISC3wCLc0ZHm4hvbccnOvCHZ26ZD9RKbD
        UPemUYm8143kegF/wbtLprFUCgsyKUGOB26LjcHIRls/MSzEUgGxF864G2MHTVvzHoAD
        sjMmHxUSoZJxjPtQW8oyXiXEQxzikw72Omc7hUSPY8JRQbwLKEpxGTvKmbqU8rmCCrmD
        nEV3UAlVynO1EzVc70v89AQzonVxJWANRXzFnNdJAIP1b9WObNXM32ALs7DMcYddkQse
        Z8QQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHmMnw4vkig=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.27.0 DYNA|AUTH)
        with ESMTPSA id u036f9v89IKhy5y
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 9 Sep 2019 20:20:43 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 1/2] cpufreq: ti-cpufreq: Add support for AM3517
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CAHCN7xLfOo7xsmDq5ZuPZsh02pjKx3w9FkJGN6AowJoHkRrWmg@mail.gmail.com>
Date:   Mon, 9 Sep 2019 20:20:43 +0200
Cc:     Linux-OMAP <linux-omap@vger.kernel.org>,
        =?utf-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Tony Lindgren <tony@atomide.com>,
        Adam Ford <adam.ford@logicpd.com>,
        =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CBA5BBAF-3875-415D-A6C1-2C5B18AAA002@goldelico.com>
References: <20190909154502.19804-1-aford173@gmail.com> <6081134F-AACD-412C-B36A-BF9463C9712B@goldelico.com> <CAHCN7xLfOo7xsmDq5ZuPZsh02pjKx3w9FkJGN6AowJoHkRrWmg@mail.gmail.com>
To:     Adam Ford <aford173@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

> Am 09.09.2019 um 20:17 schrieb Adam Ford <aford173@gmail.com>:
>=20
> On Mon, Sep 9, 2019 at 1:13 PM H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>>=20
>> Hi Adam,
>>=20
>>> Am 09.09.2019 um 17:45 schrieb Adam Ford <aford173@gmail.com>:
>>>=20
>>> The AM3517 only lists 600MHz @ 1.2V, but the revister values for
>>=20
>> a small typo...
>>=20
>> s/revister/register/
>>=20
>>> 0x4830A204 =3D 1b86 802f, it seems like am3517 might be a derivative
>>> of the omap36 which has OPPs would be OPP50 (300 MHz) and OPP100
>>> (600 MHz).
>>>=20
>>> This patch simply enable adds the am3517 to the compatible table
>>> using the omap3630 structure instead of the 3430.
>>>=20
>>> Signed-off-by: Adam Ford <aford173@gmail.com>
>>>=20
>>> diff --git a/drivers/cpufreq/ti-cpufreq.c =
b/drivers/cpufreq/ti-cpufreq.c
>>> index f2f58d689320..6b69fb1d6bdf 100644
>>> --- a/drivers/cpufreq/ti-cpufreq.c
>>> +++ b/drivers/cpufreq/ti-cpufreq.c
>>> @@ -270,6 +270,7 @@ static int =
ti_cpufreq_setup_syscon_register(struct ti_cpufreq_data *opp_data)
>>>=20
>>> static const struct of_device_id ti_cpufreq_of_match[] =3D {
>>>      { .compatible =3D "ti,am33xx", .data =3D &am3x_soc_data, },
>>> +     { .compatible =3D "ti,am3517", .data =3D &omap36xx_soc_data, =
},
>>>      { .compatible =3D "ti,am43", .data =3D &am4x_soc_data, },
>>>      { .compatible =3D "ti,dra7", .data =3D &dra7_soc_data },
>>>      { .compatible =3D "ti,omap34xx", .data =3D &omap34xx_soc_data, =
},
>>> --
>>> 2.17.1
>>>=20
>>=20
>> Looks good to me.
>>=20
>> Should I include your two patches to my patch set (and resend)?
>> Or should we keep them separated?
>=20
> Go ahead and take credit for them.  I just did what you told me to do
> and tested them.

Well, you are still the Author, the one who wrote down the ideas :)
I think git will even keep the author name untouched.

> Go ahead and mark it as Tested-by with my name.

Best is to keep your Signed-Off + mine and add a tested-by as well :)

BR and thanks,
Nikolaus

