Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7870EE37BA
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2019 18:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407816AbfJXQVT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Oct 2019 12:21:19 -0400
Received: from mail-eopbgr60056.outbound.protection.outlook.com ([40.107.6.56]:2734
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2407514AbfJXQVT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 24 Oct 2019 12:21:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PisSyYbXqVzP+mIDoOJybXmDSEdZ9R9IV6ANOnKbvpK3qs+4dFK5Pbnrd1ieXz2alfMmUkoS5JWbvUfGodSRP6Biq7MvUv07kucypaTU67iF8IXSqcgZBEXAP6retfH4VOgiWozVvQ5m4ZHgOdh0mrxhWtbIpPUm0P7Gq7EpNx+alj4xvXdltCIHcDa3bcc/71MR3tDxD2FJzTfpzkpxVrDj+KbwPmTI/yzSUKsAyA3kTcCTi3xMyQoWl/4R+G5Tc8BuqLkuAzmiKGwAtvURMCpm6NpTv+p/E5VrPT9iQ/PenQ1w52ZCpWrLyh3BaMw6RtzrwCzi6DK0RM98RiV9jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlPr/zkMIG9mLhWXcMYSlpPeQubFkfzqXXmUT03PUmc=;
 b=IMHw64VaC0vQXJwHoot3EfCYFE4fZ5Hfg0Zj4izoF1cwjBhiZac6SQDSeDavx9YyUb8Eb1gaXgHZNusA3ZC/JmnxpY772Qt4SpCN3RJaknziFq2eFIGWo0nLmiAn8GPR9urfXk/FF9R3X00Nv/SLnqJ26ouAWi5Br+JiPknGmEDUDPVFdRChAs5jG6eGNkUiLc+2QfFuNUQIpRcmaBYPWtHYfPJD1bqqLTsbufZbk2uhtJTV6Gp95gTT/Ifi7N24uWPLiNfGbcLHQI9wnv0dfnkcAxISMms2mEgdBd8Ot1iKsAdb1iv6z0Sk7OvuojNIJZdO2l5OD5KrejhoCNNdxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlPr/zkMIG9mLhWXcMYSlpPeQubFkfzqXXmUT03PUmc=;
 b=dJO2D3QOCoDohRprNunkTnAPxo/ZHUoa78TSiz37c/WHhiQR8cSBWplP69lXX+uyqcSfnvupf4CC68g5bQlVbRjL5PH879jpBOnf284K5gtJ0VIkU5rwivWg5gnBPeQILPvSLkejykdJ/8UBp0rIly+5sg/nxZTiB4DY3Rb7RhU=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4445.eurprd04.prod.outlook.com (20.177.55.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.21; Thu, 24 Oct 2019 16:21:12 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::24fb:fb99:b1c6:ba1f]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::24fb:fb99:b1c6:ba1f%4]) with mapi id 15.20.2387.021; Thu, 24 Oct 2019
 16:21:12 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v9 0/8] PM / devfreq: Add dev_pm_qos support
Thread-Topic: [PATCH v9 0/8] PM / devfreq: Add dev_pm_qos support
Thread-Index: AQHVeVcfE84n3PyghE+MA+tYDqGMmw==
Date:   Thu, 24 Oct 2019 16:21:12 +0000
Message-ID: <VI1PR04MB70236FB8DCC401EEAF97A424EE6A0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1570044052.git.leonard.crestez@nxp.com>
 <AM7PR04MB70154D3BA0D6402A9C9BE6A0EE6B0@AM7PR04MB7015.eurprd04.prod.outlook.com>
 <20191023163443.GL20212@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: edc28aaa-206c-49b1-f551-08d7589e2fca
x-ms-traffictypediagnostic: VI1PR04MB4445:|VI1PR04MB4445:
x-ms-exchange-purlcount: 3
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4445C69B9851447229970E5FEE6A0@VI1PR04MB4445.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(81156014)(81166006)(9686003)(4326008)(3846002)(5660300002)(6116002)(6306002)(6916009)(55016002)(52536014)(8936002)(478600001)(14454004)(14444005)(8676002)(76176011)(6436002)(99286004)(2906002)(6246003)(91956017)(66556008)(6506007)(446003)(53546011)(66446008)(66476007)(229853002)(66946007)(186003)(71190400001)(7736002)(316002)(45080400002)(33656002)(64756008)(66066001)(25786009)(102836004)(305945005)(86362001)(256004)(54906003)(476003)(561944003)(71200400001)(486006)(44832011)(7416002)(76116006)(26005)(74316002)(966005)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4445;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EIBJwZXHVcB+rKfPVOK/skOYAo8Ylx+/4/yaoOxJt76jUq3CsFk5m1+l+pOUH2EZlpLbZaXFWaRy22X1QhjZV0rjrGwzE5U88WVe9DrZXExXih7BIvmd8kxbiNm8BiQAZaobD4+SHnW474pdpYlmdhXtJr/M2/qvNZXMNMzU88tdFiakB+gxg1bb1OTH4H9Kcs6+vuge7bnvhf+vUo/hqYFA/xQrDIQ5stwLaD/1/n7lrM5gew/tnVUxpYbtga/hn0Yum/Msnlk4Z9jkVc1UeLl3pd9wC/9yJoQE898ygneGftnhpaWFwSeHcVqWyDw9zbNUcpInXjeOyUvT/kE0nXemyIEe2tFqfSaZF1nCSwE8GDCGLen+i2IgPG/Cfma0VqenXkWT03+lEP/9lnHmTjKw2QB7ZWjGB+49fJSIHNM+Nplu0MQrTtpG3WxobUke/FNuU5YQofQLK4K9WxEXVXSmkXYnZYOgBOIZzNO3RxE=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edc28aaa-206c-49b1-f551-08d7589e2fca
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 16:21:12.5106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O8oV6iqwb0e9vdYWwkTswZ1ZR3Vbvxd1LlMIivprb1LkwpbwcJLvNgG5312pu0GRIv8iyY16GNixHRHhPu5yPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4445
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23.10.2019 19:34, Matthias Kaehlcke wrote:=0A=
> On Wed, Oct 23, 2019 at 02:06:40PM +0000, Leonard Crestez wrote:=0A=
>> On 2019-10-02 10:25 PM, Leonard Crestez wrote:=0A=
>>> Add dev_pm_qos notifiers to devfreq core in order to support frequency=
=0A=
>>> limits via dev_pm_qos_add_request.=0A=
>>>=0A=
>>> Unlike the rest of devfreq the dev_pm_qos frequency is measured in Khz,=
=0A=
>>> this is consistent with current dev_pm_qos usage for cpufreq and=0A=
>>> allows frequencies above 2Ghz (pm_qos expresses limits as s32).=0A=
>>>=0A=
>>> Like with cpufreq the handling of min_freq/max_freq is moved to the=0A=
>>> dev_pm_qos mechanism. Constraints from userspace are no longer clamped =
on=0A=
>>> store, instead all values can be written and we only check against OPPs=
 in a=0A=
>>> new devfreq_get_freq_range function. This is consistent with the design=
 of=0A=
>>> dev_pm_qos.=0A=
>>>=0A=
>>> Notifiers from pm_qos are executed under a single global dev_pm_qos_mtx=
 and=0A=
>>> need to take devfreq->lock. Notifier registration takes the same dev_pm=
_qos_mtx=0A=
>>> so in order to prevent lockdep warnings it must be done outside devfreq=
->lock.=0A=
>>> Current devfreq_add_device does all initialization under devfreq->lock =
and that=0A=
>>> needs to be relaxed.=0A=
>>>=0A=
>>> Some of first patches in the series are bugfixes and cleanups, they cou=
ld be=0A=
>>> applied separately.=0A=
>>=0A=
>> Hello,=0A=
>>=0A=
>> This series was posted a few ago and all patches have been=0A=
>> reviewed/tested-by multiple people. Possible minor hangups:=0A=
>>=0A=
>> 1) Matthias found it confusing that min/max_freq in sysfs changes=0A=
>> on-the-fly. This is not a behavior change and I believe a decent=0A=
>> workaround would be to implement separate user_min/max_freq files from=
=0A=
>> which userspace will always read back the contraints it has written.=0A=
> =0A=
> As you said, it isn't a behavioral change, so it shouldn't be an issue=0A=
> for this series.=0A=
> =0A=
> Regarding the workaround I think it would be clearer to have new=0A=
> xyx_min/max_freq files for the aggregate values. min/max_freq are the=0A=
> interface userspace uses to specify the limits, it would be strange to=0A=
> use different files to read them out.=0A=
> =0A=
> In any case the aggregate values seem to be of little practical value,=0A=
> except perhaps for monitoring, since they could be stale right after=0A=
> userspace read them out. We could start with not providing them, and add=
=0A=
> them if it turns out that they are actually needed.=0A=
=0A=
But the min/max_freq files right now already are already aggregates and =0A=
sysfs is considered ABI. I wouldn't be surprised if somebody has an =0A=
userspace daemon which uses them.=0A=
=0A=
My proposal is to add user_min/max_freq as a new finer-grained interface =
=0A=
that you can both read and write to, no confusion here.=0A=
=0A=
Writes to min/max_freq would still be supported but only for =0A=
compatibility with older releases.=0A=
=0A=
>> 2) There was an objection to removing devm from two allocs in PATCH 4. I=
=0A=
>> believe current solution is acceptable but a possible alternative would=
=0A=
>> be to split device_register into device_initialize and device_add: this=
=0A=
>> should allow devm sooner.=0A=
>> Link: https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%=
2Fpatchwork.kernel.org%2Fpatch%2F11158385%2F%2322902151&amp;data=3D02%7C01%=
7Cleonard.crestez%40nxp.com%7Cb89f3efc3c934030fb6108d757d6ecb2%7C686ea1d3bc=
2b4c6fa92cd99c5c301635%7C0%7C0%7C637074452911403311&amp;sdata=3DDeOUpVjT1yZ=
2EWs50CFL98OoTjVMCpQDCM3qjCtKuW0%3D&amp;reserved=3D0=0A=
>>=0A=
>> Let me know if you think I should implement the options above and resend=
.=0A=
>>=0A=
>> The bigger problem is that DEV_PM_QOS_MIN/MAX_FREQUENCY was removed from=
=0A=
>> pm core because only user (cpufreq) was refactored to use a new=0A=
>> interface on top of cpufreq_policy. Links to discussion:=0A=
>>       https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%=
2Fpatchwork.kernel.org%2Fcover%2F11193021%2F&amp;data=3D02%7C01%7Cleonard.c=
restez%40nxp.com%7Cb89f3efc3c934030fb6108d757d6ecb2%7C686ea1d3bc2b4c6fa92cd=
99c5c301635%7C0%7C0%7C637074452911408301&amp;sdata=3DDxfUtaGch6MilSy5fX8AHN=
3%2BDIp8MrbQrHH%2B6VdRb%2FI%3D&amp;reserved=3D0=0A=
>>   =0A=
>> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore=
.kernel.org%2Flinux-pm%2FVI1PR04MB7023DF47D046AEADB4E051EBEE680%40VI1PR04MB=
7023.eurprd04.prod.outlook.com%2FT%2F%23u&amp;data=3D02%7C01%7Cleonard.cres=
tez%40nxp.com%7Cb89f3efc3c934030fb6108d757d6ecb2%7C686ea1d3bc2b4c6fa92cd99c=
5c301635%7C0%7C0%7C637074452911408301&amp;sdata=3DsYQZUbzEk2DsWGQ5eQnu2m2%2=
Bsp%2BYBO16Abyjwf7Z1sQ%3D&amp;reserved=3D0=0A=
>>=0A=
>> I believe there is still significant value in supporting min/max=0A=
>> frequency requests on a per-target-device basis. This makes much more=0A=
>> sense for devfreq that for cpufreq because the whole point of devfreq is=
=0A=
>> scaling arbitrary independent devices.=0A=
> =0A=
> Agreed.=0A=
> =0A=
> It seems Rafael would be ok with reverting the patch that removes=0A=
> DEV_PM_QOS_MIN/MAX_FREQUENCY, IIUC he just doesn't want to keep it around=
=0A=
> at this time because with the rest of his series there remain no in-tree=
=0A=
> users.=0A=
