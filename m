Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC5795A90
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2019 11:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbfHTJCn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Aug 2019 05:02:43 -0400
Received: from mail-eopbgr70047.outbound.protection.outlook.com ([40.107.7.47]:31085
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728545AbfHTJCn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Aug 2019 05:02:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksNO1x1z9R2ZWEaawOSfM8flPCZVsIXosXFdG2dhrZes5f/DtCxKTXHUIRUPWdmYDrAZ50MnvHKZN2mcHJOepcU/H27w1XBXseTr28/vDIPIqTJlVGedJnhJZlgqSvKUp7R8sGLIRK/ETXwCqPTuxlfYbFZ5D5YnzqUNtrLDrVvl/lQk+6XJ+axdW+D+qvk+Gk+31kCwukBxO9KEZJcYs8aao6dfFETyOjTtAcQibwkiCoyrRdzg4OFu94rJzpfs8VeMsnFm9HMTtiaVnMRnW1Y89GV3ibQyJO75ha7DJlYl3p6ZUfEeN8mmmI9nfM8KxENi89ztGn9nk2EEUCfcOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zobw+++3joPUNY5A9Q9I7TfXjTpMQbHC6Zadgy+tkdk=;
 b=CZV4gC9IBiMNRyTFX1S2c2yEdNdWqidRYu7aap8HESEv/arnRHbRoftapmNwcr7qcnIY3S9LR2jg47aY2RrhwNl+YnO1DLq2fj1dAr/GKaiP4Ep08q6c6rhSNQBHOQBMLbiRNejsVpYaicYcnW7mnjRychExR9zqk7SvCIHDPVBIBFikuS5KtoO1MQqdp9w8PcN5HEfGg62byT8SavfIoYZqpzAcJ8LFK+eajpB6wZSll8lhIcLdrlrRuXoSQcyv6W/dvYYxdLyDMBLFLm6fqITYb+7Y7OjqRBhX4sQtIz3ip3eHy8jSUmj+SB0zrmaaOXA9WIVmRY5b9XevaAD/Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zobw+++3joPUNY5A9Q9I7TfXjTpMQbHC6Zadgy+tkdk=;
 b=H624Bg33ikbtGP3bAqBnuJN2x6rJa9aA9HF0/CkaIJ0neuMvST0knumXIokKUZ3vflzt8GvFoZK0/H11vhOYLpHkjJ4DkkSBVqfUvRlFkSEWc1seFHA3x7QEVU+oiX5Mo4LJ6PJJCdDFbBXUpwVKo3bmECmiOALl0LSpZhyu7go=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4910.eurprd04.prod.outlook.com (20.177.49.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Tue, 20 Aug 2019 09:02:39 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e%3]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 09:02:39 +0000
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
Date:   Tue, 20 Aug 2019 09:02:39 +0000
Message-ID: <VI1PR04MB70237DE1719FB78C0427A436EEAB0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1565089196.git.leonard.crestez@nxp.com>
 <20190820065202.fet4ctxk4jku7ul2@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 097ffa15-0c6a-4ce6-b025-08d7254d26f1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB4910;
x-ms-traffictypediagnostic: VI1PR04MB4910:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB491028EC6C02F1324D847C38EEAB0@VI1PR04MB4910.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(189003)(199004)(186003)(14444005)(7416002)(316002)(6506007)(7696005)(66066001)(45080400002)(478600001)(2906002)(71200400001)(966005)(86362001)(14454004)(3846002)(54906003)(110136005)(71190400001)(99286004)(76176011)(229853002)(8936002)(6436002)(76116006)(91956017)(81156014)(305945005)(6116002)(64756008)(66946007)(66446008)(81166006)(74316002)(33656002)(8676002)(66476007)(66556008)(5660300002)(7736002)(102836004)(446003)(9686003)(55016002)(486006)(53936002)(53546011)(25786009)(44832011)(6246003)(476003)(6306002)(26005)(256004)(4326008)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4910;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wx3CG7DvdruepaSQtA4MeOL/pdQarhD9f7WnW4W3SyZxhLn+ioSTScEVVBcsPB49yFE+HI9c09LB1VeFceWBZDR5Zs6YrKl3fTOF7iWIqyl3YEFF0Z0zNTU8caPhtf7WxOljz/NNJie45MMNr5cTceIkRbzp0F9ACLFMVXMvipry2o3V7JuAtONdFN5n5rMlTsGwJbaWJmt09LINKKhLuJV6daPXfmdWlpnCiqGDZgEW7PL6coVG0RgQW6P1aUbDzbzmP7LbbEFl7dY6WuAYRG4y95nxdFUo/B/rs8DOBCoR39E5Nlzwzqbc3vVD6R8eGaSIgPVtl+4HvNO7708ICqCH5+RUIUb7BwN5252DhSKVFE9oZV69MY5gCbQ9l0wKHjkGLq8GMc7Swsu35u20+9hUnprwifkiDPNkX230jcA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 097ffa15-0c6a-4ce6-b025-08d7254d26f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 09:02:39.0726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OcY0pNTboEA/nIc6RCckiP7jlqB6temY10uekJPDqOc90jCdG1zVmewHtYSZXsE3NuUR7ZPtlMLZSTGnm1pa1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4910
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20.08.2019 09:52, Viresh Kumar wrote:=0A=
> On 06-08-19, 14:12, Leonard Crestez wrote:=0A=
>> The "required-opps" property can be placed on any device and point to=0A=
>> any OPP table according to bindings doc but this is not fully=0A=
>> implemented. In practice it can only point from the opp table of a=0A=
>> device to the opp table of a power domain.=0A=
>>=0A=
>> As part of my investingating QOS mechanisms I implemented support for=0A=
>> parsing "required-opps" into a DEV_PM_QOS_MIN_FREQUENCY=0A=
>> dev_pm_qos_request. Since OPPs can be shared between devices this only=
=0A=
>> works when OPP tables are unshared.=0A=
>>=0A=
>> This would need to be called from a device probe function and any=0A=
>> suspend/resume handling (which likely means disabling the QOS requests)=
=0A=
>> would also be handled manually by each driver.=0A=
>>=0A=
>> This is RFC mostly because I plan to use the "interconnect" framework=0A=
>> for device requests instead. In theory this could be used if you don't=
=0A=
>> care about implementing smart aggregation and just want to "set bus freq=
=0A=
>> to high".=0A=
>>=0A=
>> Devfreq support for dev_pm_qos is here: https://eur01.safelinks.protecti=
on.outlook.com/?url=3Dhttps%3A%2F%2Fpatchwork.kernel.org%2Fpatch%2F11078475=
%2F&amp;data=3D02%7C01%7Cleonard.crestez%40nxp.com%7C09dabcdb17434862317508=
d7253aeac8%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637018807295295723&=
amp;sdata=3DvXvTIowhuqDkTxVZMHq%2BQxrKuqYv7n%2FU01ZDA7fdB0c%3D&amp;reserved=
=3D0=0A=
> =0A=
> Some work is going on in related field. Please have a look at this as wel=
l.=0A=
=0A=
I noticed that series but other than touching "required-opp" there is =0A=
little in common. It seems to be mostly an expansion of the passive =0A=
governor.=0A=
=0A=
My series doesn't even depend on devfreq; in theory you could even use =0A=
required-opp =3D <&opp_1200mhz> on a cpu device.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
