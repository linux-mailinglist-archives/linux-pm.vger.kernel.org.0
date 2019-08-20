Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED70296531
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2019 17:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfHTPtN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Aug 2019 11:49:13 -0400
Received: from mail-eopbgr50082.outbound.protection.outlook.com ([40.107.5.82]:18158
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729810AbfHTPtN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Aug 2019 11:49:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEkrplNCc5YVg+ucSlgVZusoMZ5jENCgf70dTOkY//6hKgU/beeSIVfuTOEhb/vegAQeeMQuKa6bHP5z9RyxGhY8PnfGOA63BLvMOTncJZOqI2SIeuGLSifvkm78ShpJRPzBH7yn0RcoNvKUOt+FIUaElZqa7Y7WTLa2KE7mBmNhIzrygt8i3YWPXTRe3wxalMHD2ceOCB/hb+YftY80JwyBjh4xQ5uJfgAS+W3f5rFEEqoAticPWyU9xPuFtwB3msI+xgLNTVkT0r08xRQwM9SKzArp0h3pEvROhkIBrF4wo2vbsJSCelSe6qWhh15L4ibu1k+dBHBnmUmpIJRiXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vK23T8Kn1Sti6KKv3Ugnk0M+RpKvk/7TDy9PUzE4awQ=;
 b=MTQC1RilYuZJS2HtAawf7RpwqtyvDDy+hjTlywUCrwG4nG0iiEJWocg0VAAIYAFciCHURFwSw3iRIHI/Q0VIlIn7RlFRpzO446h4U50C/bAfrngl02Mw2C98x1urmEGXeIBBClGf5wqdeGq1vwT+lA4v2xJDJGxpXEbft78Fly/S5kzw1IJ30WWGtcgl+SZD9e3olTdzc8vP/4gGVQXehrDAdQcBU1Q1QEN9/x8K/xaEglD0f/yFI1DR9x72tTL6Bs4Eu66YFtShkUVb9OLYPj92ZpvjtiUiQB/HDJaSriNizpZIw+88Q7qHIaaim+vzbXxDdJ7LQ2qFNU22KknW9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vK23T8Kn1Sti6KKv3Ugnk0M+RpKvk/7TDy9PUzE4awQ=;
 b=m0mGM8/6CMuSQ5tlx+8O1LzHIKK9c91Se9zG8WilTmI0e1nFenAFu8yFYT43GVF+KI2WqODPNAIxcaQple/aGdpJz44jGXzb9EqyD7Rc7r7rhQleOx6zQk0MYiG0xGqaSPfHB39wUtpDq3RgHbAwzAMkclCfBLX57VixcA+3NgQ=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5070.eurprd04.prod.outlook.com (20.177.50.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Tue, 20 Aug 2019 15:48:55 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e%3]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 15:48:55 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Saravana Kannan <saravanak@google.com>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [RFC 0/4] opp: Parse required-opp as dev_pm_qos_request
Thread-Topic: [RFC 0/4] opp: Parse required-opp as dev_pm_qos_request
Thread-Index: AQHVVyPJOVFUQPWk/0qpH7QxdG3u2Q==
Date:   Tue, 20 Aug 2019 15:48:55 +0000
Message-ID: <VI1PR04MB7023B5D1305A4A4BB9DF534FEEAB0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1565089196.git.leonard.crestez@nxp.com>
 <20190820065202.fet4ctxk4jku7ul2@vireshk-i7>
 <VI1PR04MB70237DE1719FB78C0427A436EEAB0@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <20190820092206.7cv3hfvitil2oyg3@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b18463c-d1c9-473c-e1c5-08d72585e86f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5070;
x-ms-traffictypediagnostic: VI1PR04MB5070:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VI1PR04MB5070DBBEBBDA1F4B6365F6FDEEAB0@VI1PR04MB5070.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(199004)(189003)(5660300002)(26005)(86362001)(256004)(45080400002)(25786009)(74316002)(6436002)(6246003)(102836004)(478600001)(966005)(14454004)(4326008)(53546011)(6506007)(7416002)(53936002)(229853002)(9686003)(33656002)(6306002)(6116002)(8936002)(44832011)(7696005)(446003)(14444005)(71200400001)(55016002)(3846002)(486006)(99286004)(71190400001)(476003)(110136005)(91956017)(76116006)(66476007)(8676002)(7736002)(81156014)(81166006)(64756008)(316002)(305945005)(2906002)(76176011)(66446008)(66946007)(66556008)(52536014)(186003)(54906003)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5070;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xssxXJdWX/hzY6WCh5VvI/DCjvtSzsuKDGORh0aUKwdgkueNMlDuADsGozpb2ETG+5kl5NfIo9qjJEkc/d2iklI9FKXHIsKXSBNQoBcfDp/H7NT/P3TdmMLBzmjEEFZHALbr865IPNsigF55WMboRv692rWUclnXjTNDEAQZ5v3e6/UlhLb2SyY08re4HdKz78mhkVysTDGSKTzhoe0UiC5gkfnWEIElir8hI+WErWslS4HrW7JtZP9iCpD/coCq71lOuyRSqz12JoljX3PCyiVFlvM1+kGi/C9zVjWrnTPn2tk0IDppLAediOsLJ0oRRE33Mf1Yv5r3hNekiax/6mSa/hEKEVFp61ARnNWhVxWD6DwFpJ4+AjBhuS6qos5msLa1LNnmbmKyws7H4Vi9BCpkfOreYNqYUzuzCSyIaz0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b18463c-d1c9-473c-e1c5-08d72585e86f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 15:48:55.5808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rM5Sx+x7A0Z/Tr+FAX9SWNyzxe9FUydr70mGsfYGJFVDQmsq58IapkmYy3kZ+9fAb1V75B1Ti6lNJW3b/MBBcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5070
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20.08.2019 12:22, Viresh Kumar wrote:=0A=
> On 20-08-19, 09:02, Leonard Crestez wrote:=0A=
>> On 20.08.2019 09:52, Viresh Kumar wrote:=0A=
>>> On 06-08-19, 14:12, Leonard Crestez wrote:=0A=
>>>> The "required-opps" property can be placed on any device and point to=
=0A=
>>>> any OPP table according to bindings doc but this is not fully=0A=
>>>> implemented. In practice it can only point from the opp table of a=0A=
>>>> device to the opp table of a power domain.=0A=
>>>>=0A=
>>>> As part of my investingating QOS mechanisms I implemented support for=
=0A=
>>>> parsing "required-opps" into a DEV_PM_QOS_MIN_FREQUENCY=0A=
>>>> dev_pm_qos_request. Since OPPs can be shared between devices this only=
=0A=
>>>> works when OPP tables are unshared.=0A=
>>>>=0A=
>>>> This would need to be called from a device probe function and any=0A=
>>>> suspend/resume handling (which likely means disabling the QOS requests=
)=0A=
>>>> would also be handled manually by each driver.=0A=
>>>>=0A=
>>>> This is RFC mostly because I plan to use the "interconnect" framework=
=0A=
>>>> for device requests instead. In theory this could be used if you don't=
=0A=
>>>> care about implementing smart aggregation and just want to "set bus fr=
eq=0A=
>>>> to high".=0A=
>>>>=0A=
>>>> Devfreq support for dev_pm_qos is here: https://eur01.safelinks.protec=
tion.outlook.com/?url=3Dhttps%3A%2F%2Fpatchwork.kernel.org%2Fpatch%2F110784=
75%2F&amp;data=3D02%7C01%7Cleonard.crestez%40nxp.com%7C9ff357888cba49c522ce=
08d7254fe2c4%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63701889734427600=
9&amp;sdata=3DNV2Xnop9%2BplnKdIqrMCHF05xpt9y651ed%2BhwFK8gEKI%3D&amp;reserv=
ed=3D0=0A=
>>>=0A=
>>> Some work is going on in related field. Please have a look at this as w=
ell.=0A=
>>=0A=
>> I noticed that series but other than touching "required-opp" there is=0A=
>> little in common. It seems to be mostly an expansion of the passive=0A=
>> governor.=0A=
>>=0A=
>> My series doesn't even depend on devfreq; in theory you could even use=
=0A=
>> required-opp =3D <&opp_1200mhz> on a cpu device.=0A=
> =0A=
> What is the exact use case you are targeting here or the problem you are =
trying=0A=
> to solve ?=0A=
=0A=
My exact use case is that devices (such as display, gpu, audio etc) need =
=0A=
DRAM to run at a minimum frequency. This is currently done in imx vendor =
=0A=
tree with a custom API but I'm trying to upstream via devfreq:=0A=
=0A=
https://patchwork.kernel.org/cover/11104113/=0A=
=0A=
The "required-opp" documentation looked like it would be a fit but =0A=
apparently it requires all requesting devices to have OPPs and the =0A=
target to be a power domain? This seemed very restrictive so this series =
=0A=
implements a different way to handle required-opp, via dev_pm_qos.=0A=
=0A=
The interconnect subsystem has additional capabilities (scaling along a =0A=
path) so I plan to use that instead. You can treat this series as a =0A=
"curiosity".=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
