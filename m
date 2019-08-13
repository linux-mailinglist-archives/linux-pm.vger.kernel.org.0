Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56CEF8B6A0
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 13:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfHML1c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 07:27:32 -0400
Received: from mail-eopbgr60052.outbound.protection.outlook.com ([40.107.6.52]:45806
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727175AbfHML1c (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 13 Aug 2019 07:27:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cP3/wNjboKjcl3ReAHlXuPy1Gbi9eDt+6m6nDONHgCj2nMNm8cEXSmB49sAFfD3m/+X/qi/gDfkJ2CUqJWMmUvFJU3KWJ9Dn+jOHMfNGs5KtvqwCrgoXSIMOycaO+6F4/6zjWnKHZGovrSQs8VkRW1ZZkTs/85bCS9uknYUtdoR+kC4T1Vf2R2YEcVnm6I9cRU8QigqQ2kaEmABeperk6hINPev40ADc1ycoOp5BQ72S/wD7M/4UCNSgtDwHNef35rR8aiyyA9MDsKtIf7l/1p111Tg9tZoXpczgd1d9ifRXjLcxfmn8uWF2fnLPBecW8jmWdT0zjbdMhOIFCe4Pfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUKNrA4mzZhpzIqnEpzddYlgacjHgQIkJiKLqtBiq1s=;
 b=bDwjroo//CPDMOMueu/dUPawsBzMM10ZbkQX4n7aUWo/gQR15Syba4z0F+TxuUpWIW+KybvfcMaxRSoQKbPacZ+CINmw+JYZj6aR1bMkvxLhiXhp54XOf1RyZFQov9etyu5nrDDkWUsHnVkgiJ+iJ0zEptSVfaRSwXaiwfOz1Dx7i0KfvHsLcY6JQc+VH9l7VAtIWQfkkmKLUAZwcYq3GN4iQRH2SkRRe08+u+K121ivjgomsCkhGiPsuHzhDaofX937wpuHpCmj/OJVtxM25wQ3FpN7+fN3t8EXW2yNazGLDpwKugCDdlT5ZWZE2M2UmE+79NJI/qbK/lGAlKeNNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUKNrA4mzZhpzIqnEpzddYlgacjHgQIkJiKLqtBiq1s=;
 b=TrG3+SvSZu79Rmv7qY176WpeX1KrechXFjZ06mHRIW+5NPmt02ySJG68MPeXBtlGlP6MI6k/8XNsDGJSgOxC9RgyMdrdYznAU6S8rAht0PgXYBTEK0rFs7XK0p1h/iBeeMRHw/qfA+loo34Rt7zxOM//o+EtfcxnMa8zQefDxDE=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4496.eurprd04.prod.outlook.com (20.177.54.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Tue, 13 Aug 2019 11:27:28 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::e53d:e6a9:79bd:f970]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::e53d:e6a9:79bd:f970%2]) with mapi id 15.20.2157.022; Tue, 13 Aug 2019
 11:27:28 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Saravana Kannan <saravanak@google.com>
CC:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "cpgs (cpgs@samsung.com)" <cpgs@samsung.com>
Subject: Re: [PATCHv2] PM / devfreq: Add dev_pm_qos support
Thread-Topic: [PATCHv2] PM / devfreq: Add dev_pm_qos support
Thread-Index: AQHVUZ3LNnkjSHH5Mky7uPvCKAlxZw==
Date:   Tue, 13 Aug 2019 11:27:28 +0000
Message-ID: <VI1PR04MB7023EB13BB2DE94814B38477EED20@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <CGME20190808143919epcas4p33c93a5a3d4df1032fa84ddad9110a160@epcas4p3.samsung.com>
 <e45c28528ff941abb1f72fdb1eedf65fb3345c5a.1565274802.git.leonard.crestez@nxp.com>
 <b3941b19-f0aa-87a6-d50a-299d07a26532@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ab20c4a-59ff-40cf-622d-08d71fe13911
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4496;
x-ms-traffictypediagnostic: VI1PR04MB4496:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB4496CCE584777FED60543CC7EED20@VI1PR04MB4496.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(199004)(189003)(44832011)(476003)(229853002)(25786009)(486006)(316002)(76176011)(55016002)(446003)(102836004)(186003)(54906003)(99286004)(8936002)(26005)(7696005)(5660300002)(7416002)(6506007)(53546011)(110136005)(52536014)(66066001)(6436002)(305945005)(53936002)(14454004)(66446008)(76116006)(81156014)(9686003)(86362001)(2906002)(64756008)(6246003)(7736002)(81166006)(66556008)(91956017)(66476007)(478600001)(33656002)(71190400001)(71200400001)(66946007)(4326008)(74316002)(8676002)(6306002)(14444005)(966005)(6116002)(3846002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4496;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tgTifVtBHvivCgmTLElunBv7HyG4whdXDr1I2WdX0MYaGwbCBxUH0/r7JHuVcrE0RUyGRlKgJU1tfSfrvRmBXbWjueYgI4Hq33QJiYrxIMdCd6ZEQlZe4ltD45N2FPqj464q8EasaTNYOnIGLCf+nCw9bdk61xQHWpsFRAR34AhVU/s4tnBtiprza9sC9Wn0lMqqhrO5aqSCAk2RywAuO3BpW96hh5eMb5O36WbIk9xA3WvQWBsygpWsynrldI8ODgWZNeITo2/XYwJK3Ws/ZUGQnwTTuPcDM1x0o+FPxldbbEwGR6/6qY8z+ruiL8VOla6fLilgQDIuWjRVm/u1TEfY1U8yH57a+dqrM+3es3/LaQjNDZH6fYxA2E+RcLSSr5MeQxO0NRPxMBoO9vE5YNkwPngkxS4Fyud6EcIMJfY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab20c4a-59ff-40cf-622d-08d71fe13911
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 11:27:28.0446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bQtQUgJD4XVZoVZgHlSxTFwsLcZjSAHabRV1PP5R3AsPuW6bPIcL1bKDwge52ZTO9PgsyUgqkPBU/XYZrACZFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4496
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13.08.2019 09:10, Chanwoo Choi wrote:=0A=
> In case of cpufreq, cpufreq.c replace the body of store_min_freq()=0A=
> and store_max_freq() by using struct dev_pm_qos_request instancce=0A=
> with dev_pm_qos_update_request().=0A=
> =0A=
> If you use the new way with dev_pm_qos_update_request() for=0A=
> min_freq_store() and max_freq_store(), it doesn't need to=0A=
> get the final frequency from three candidate frequencies.=0A=
=0A=
Yes, I saw that but didn't implement the equivalent for devfreq because =0A=
it's not clear what there is to gain.=0A=
=0A=
Since dev_pm_qos is measured in khz it means that min_freq/max_req on =0A=
sysfq would lose 3 significant digits, however those digits are probably =
=0A=
useless anyway.=0A=
=0A=
> In result, We only consider the following two candidate frequencies=0A=
> as following:=0A=
> 1. "devfreq->scaling_min_freq" will contain the requirement=0A=
>     from devfreq thermal throttling by OPP interface.=0A=
=0A=
It's a bit awkward that the OPPs enable/disable API is not obviously =0A=
specific to "thermal".=0A=
=0A=
> 2. "devfreq->min_freq" will contain the requirements=0A=
>     from both user input through sysfs and the dev_pm_qos_request.=0A=
According to a comment on a previous version it would be useful to have =0A=
a separate files for "constraint min/max freq" and "user min/max freq":=0A=
=0A=
     https://patchwork.kernel.org/patch/11078475/#22805379=0A=
=0A=
Combining min/max requests from dev_pm_qos and sysfs would make this =0A=
harder to implement. I guess user_min_freq could be implemented by =0A=
reading back the dev_pm_qos request but there would be no way to =0A=
implement a qos_min_freq entry.=0A=
=0A=
>> +static int devfreq_qos_min_notifier_call(struct notifier_block *nb, uns=
igned long val, void *ptr)=0A=
> =0A=
> Please keep the under 80 line if there are no any special reason.=0A=
=0A=
OK, will check.=0A=
