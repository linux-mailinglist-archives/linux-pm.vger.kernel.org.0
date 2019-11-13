Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDA80FB09A
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 13:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKMMiC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 07:38:02 -0500
Received: from mail-eopbgr00058.outbound.protection.outlook.com ([40.107.0.58]:9358
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726250AbfKMMiB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 13 Nov 2019 07:38:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHFislN6/6wNv7suCPipaCYtk5lhupOXP09SbzVSq8JkqLWfbiItDi67p4BOzDHuQ9VrQqd05+RuIO3Ys/sZLCXcBzJg6VhhtO9q2cTCugQXM2c3lZB30RnlNKfrfEu8hEhzhVLDPSzDYzKEdlwBj2VaqcaAwFnm2WgVw5X1JI7NUukgBhai7SXLu7oTO9QTkHtObDsEUC9YcrNkOB5Zilj7q2O2PFm30n5xU9cwIfmWnlWwbD66UpBaoXF46ml7jWWmaTSNmZ+3nlCXCRiz5bv2h5AI7Kvr7u3oj3h5O0ciq579DZCD/9On0dlKD1CEG5C0Ix3xcBPXQbrz+OQrPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1w6d3XKvql425afCQLV6b9UsIzgUk+dZQdYjmAURCI=;
 b=JKDFHZ+Gdei2jjf48bNFH6ZRBXtD7sZtCUA4d8dAlbAQxmByvY+GAO9v5/D3xKnCogr+mkQCPnt8LS+93JAmL6R6C9SFPV6cosa6rgUTw9n4izFGBRmB1Jwyx60bfAv7r6lYJy4kw6GuGkKf7Ph+mg8aceYl4Pmx7LBSsGc63GAN8IaSKkZaIAjpuy+V5xh2U/WigbUgf95QvkN/6xdofLKW676J9cwpTEOuo3sXosZnUZck+11XfNZ0oxKoCY8/E7m2ASMZVf2ecdrBH6AubXAcNaHr4aldDJUf7fkWCERDYPmOZuJ9kf3GvTz4WrSeVFkRB4hEhiGGo+50VeDRmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1w6d3XKvql425afCQLV6b9UsIzgUk+dZQdYjmAURCI=;
 b=AA4+XQAOHM8RRf1ET0HmQDs6VuJ59LBdpekAK0hpDwPk6CROvo4wBj20Hx9NfvyYMG2dG1diYZLIxZyguXmAogUAFWakhbS4bFif0JSeUiXC1n/RC5jz14pG8gGDxXjmZ7RK/jDj07Ai5aromNOzCG68QdvYKwi8+ABvWeW+5II=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB6928.eurprd04.prod.outlook.com (52.133.246.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 13 Nov 2019 12:37:56 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 12:37:56 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
CC:     "Rafael J. Wysocki <rjw@rjwysocki.net>" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] PM / devfreq: Add missing locking while setting
 suspend_freq
Thread-Topic: [PATCH] PM / devfreq: Add missing locking while setting
 suspend_freq
Thread-Index: AQHVmUau1RnKdFHTgkeyLR5NxA5iMA==
Date:   Wed, 13 Nov 2019 12:37:56 +0000
Message-ID: <VI1PR04MB7023CF3BC69BF51BF1313948EE760@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <CGME20191112104809eucas1p14d5d364021a359861788472b513e43e5@eucas1p1.samsung.com>
 <20191112104734.31074-1-m.szyprowski@samsung.com>
 <1d992c15-66bd-4d53-114f-66e3105e5fae@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 38187515-3898-48d0-aa8a-08d768364f57
x-ms-traffictypediagnostic: VI1PR04MB6928:
x-microsoft-antispam-prvs: <VI1PR04MB6928912EE23165788D811769EE760@VI1PR04MB6928.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(51914003)(199004)(189003)(51444003)(102836004)(55016002)(8936002)(15650500001)(86362001)(74316002)(305945005)(7736002)(6116002)(3846002)(486006)(81156014)(81166006)(8676002)(52536014)(476003)(66946007)(7696005)(66476007)(66556008)(7416002)(64756008)(66446008)(5660300002)(6506007)(44832011)(76176011)(2906002)(53546011)(6306002)(9686003)(99286004)(6436002)(33656002)(6246003)(26005)(71190400001)(446003)(966005)(413944005)(14454004)(4326008)(229853002)(256004)(91956017)(76116006)(14444005)(45080400002)(478600001)(316002)(25786009)(186003)(71200400001)(66066001)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6928;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qz1LHc8NogMl7jAOxHka2Rnh/L3l3FJdNNTeEw+a1XaBtD0A8sWLwfhB/K2JH+YF7ChCfBgy8OCGFXDKajozEaAWSIN1XHOXT1lU/V78HtVf5AH831Dp8x7nmG85cEpJ3ood1qZjYhKFZKzHICvg+vjbNPsI0fHewKbkYw+2NHPQ+Y1pzuhR/Af0oh8PrPf3f+jqThraLSap5r6GFfn0Q8erFpKwhIwe58XbnuBrwaoaxMTYTwcb0aMRB52LTbdi9f+nZiCIJe5ksJnTc0ijPNxTaF6xJwII4kLg9rucDuBjHR8HSHUIJdZsTc6HMZ0nx58MjYlk4R/u/GMyK6kw165cAezq8s01prOSJiZ25R5qE1tdOG6TE14IOip+o4IcEWz9MX+xLGjYeRVOOlZkpKL2FrcntuuOY/4SfN7NmzZf9K+zhXfWm2pVgrXORuBl
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38187515-3898-48d0-aa8a-08d768364f57
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 12:37:56.3229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H5/TKgSHCw0jKjwsC76NNHuzMmpBfLLQt5zRNgpDlHBbHRubKcF1CfoZ89ne1Y/IBxyMEWj68+dcJALtBJEkTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6928
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13.11.2019 04:11, Chanwoo Choi wrote:=0A=
> Dear Rafael,=0A=
> =0A=
> Could you take this patch directly into linux-pm.git for v5.5-rc1?=0A=
> =0A=
> Because the devfreq pull-request for v5.5-rc1 contained issue. This patch=
=0A=
> fix the issue of following patch[1].=0A=
> [1] https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
it.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Frafael%2Flinux-pm.git%2F=
commit%2F%3Fh%3Dlinux-next%26id%3D2abb0d5268ae7b5ddf82099b1f8d5aa8414637d4&=
amp;data=3D02%7C01%7Cleonard.crestez%40nxp.com%7C7f8b7da8a0db4c0c80c208d767=
ded288%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637092079037128803&amp;=
sdata=3DYW2zd3rpgphZtrhUfrA0wOTU10Ee0vDdEtcphKtGS3U%3D&amp;reserved=3D0=0A=
> =0A=
> =0A=
> ---=0A=
> Hi Marek,=0A=
> =0A=
> Thanks for the fixup.=0A=
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>=0A=
> =0A=
> Regards,=0A=
> Chanwoo Choi=0A=
> =0A=
> =0A=
> On 11/12/19 7:47 PM, Marek Szyprowski wrote:=0A=
>> Commit 2abb0d5268ae ("PM / devfreq: Lock devfreq in trans_stat_show")=0A=
>> revealed a missing locking while calling devfreq_update_status() functio=
n=0A=
>> during suspend/resume cycle.=0A=
>>=0A=
>> Code analysis revealed that devfreq_set_target() function was called=0A=
>> without needed locks held for setting device specific suspend_freq if su=
ch=0A=
>> has been defined. This patch fixes that by adding the needed locking, wh=
at=0A=
>> fixes following kernel warning on Exynos4412-based OdroidU3 board during=
=0A=
>> system suspend:=0A=
=0A=
I think that devfreq_suspend always need the lock, this issue was just =0A=
exposed by adding a lock assertion in devfreq_update_status.=0A=
=0A=
There was a rare but real race condition here between "set_target" and =0A=
suspend.=0A=
=0A=
>> PM: suspend entry (deep)=0A=
>> Filesystems sync: 0.002 seconds=0A=
>> Freezing user space processes ... (elapsed 0.001 seconds) done.=0A=
>> OOM killer disabled.=0A=
>> Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.=0A=
>> ------------[ cut here ]------------=0A=
>> WARNING: CPU: 2 PID: 1385 at drivers/devfreq/devfreq.c:204 devfreq_updat=
e_status+0xc0/0x188=0A=
>> Modules linked in:=0A=
>> CPU: 2 PID: 1385 Comm: rtcwake Not tainted 5.4.0-rc6-next-20191111 #6848=
=0A=
>> Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)=0A=
>> [<c0112588>] (unwind_backtrace) from [<c010e070>] (show_stack+0x10/0x14)=
=0A=
>> [<c010e070>] (show_stack) from [<c0afb010>] (dump_stack+0xb4/0xe0)=0A=
>> [<c0afb010>] (dump_stack) from [<c01272e0>] (__warn+0xf4/0x10c)=0A=
>> [<c01272e0>] (__warn) from [<c01273a8>] (warn_slowpath_fmt+0xb0/0xb8)=0A=
>> [<c01273a8>] (warn_slowpath_fmt) from [<c07d105c>] (devfreq_update_statu=
s+0xc0/0x188)=0A=
>> [<c07d105c>] (devfreq_update_status) from [<c07d2d70>] (devfreq_set_targ=
et+0xb0/0x15c)=0A=
>> [<c07d2d70>] (devfreq_set_target) from [<c07d3598>] (devfreq_suspend+0x2=
c/0x64)=0A=
>> [<c07d3598>] (devfreq_suspend) from [<c05de0b0>] (dpm_suspend+0xa4/0x57c=
)=0A=
>> [<c05de0b0>] (dpm_suspend) from [<c05def74>] (dpm_suspend_start+0x98/0xa=
0)=0A=
>> [<c05def74>] (dpm_suspend_start) from [<c0195b58>] (suspend_devices_and_=
enter+0xec/0xc74)=0A=
>> [<c0195b58>] (suspend_devices_and_enter) from [<c0196a20>] (pm_suspend+0=
x340/0x410)=0A=
>> [<c0196a20>] (pm_suspend) from [<c019480c>] (state_store+0x6c/0xc8)=0A=
>> [<c019480c>] (state_store) from [<c033fc50>] (kernfs_fop_write+0x10c/0x2=
28)=0A=
>> [<c033fc50>] (kernfs_fop_write) from [<c02a6d3c>] (__vfs_write+0x30/0x1d=
0)=0A=
>> [<c02a6d3c>] (__vfs_write) from [<c02a9afc>] (vfs_write+0xa4/0x180)=0A=
>> [<c02a9afc>] (vfs_write) from [<c02a9d58>] (ksys_write+0x60/0xd8)=0A=
>> [<c02a9d58>] (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)=
=0A=
>> Exception stack(0xed3d7fa8 to 0xed3d7ff0)=0A=
>> ...=0A=
>> irq event stamp: 9667=0A=
>> hardirqs last  enabled at (9679): [<c0b1e7c4>] _raw_spin_unlock_irq+0x20=
/0x58=0A=
>> hardirqs last disabled at (9698): [<c0b16a20>] __schedule+0xd8/0x818=0A=
>> softirqs last  enabled at (9694): [<c01026fc>] __do_softirq+0x4fc/0x5fc=
=0A=
>> softirqs last disabled at (9719): [<c012fe68>] irq_exit+0x16c/0x170=0A=
>> ---[ end trace 41ac5b57d046bdbc ]---=0A=
>> ------------[ cut here ]------------=0A=
>>=0A=
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>=0A=
>> ---=0A=
>>   drivers/devfreq/devfreq.c | 4 ++++=0A=
>>   1 file changed, 4 insertions(+)=0A=
>>=0A=
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c=0A=
>> index 94fb8e821e12..65a4b6cf3fa5 100644=0A=
>> --- a/drivers/devfreq/devfreq.c=0A=
>> +++ b/drivers/devfreq/devfreq.c=0A=
>> @@ -957,7 +957,9 @@ int devfreq_suspend_device(struct devfreq *devfreq)=
=0A=
>>   	}=0A=
>>   =0A=
>>   	if (devfreq->suspend_freq) {=0A=
>> +		mutex_lock(&devfreq->lock);=0A=
>>   		ret =3D devfreq_set_target(devfreq, devfreq->suspend_freq, 0);=0A=
>> +		mutex_unlock(&devfreq->lock);=0A=
>>   		if (ret)=0A=
>>   			return ret;=0A=
>>   	}=0A=
>> @@ -985,7 +987,9 @@ int devfreq_resume_device(struct devfreq *devfreq)=
=0A=
>>   		return 0;=0A=
>>   =0A=
>>   	if (devfreq->resume_freq) {=0A=
>> +		mutex_lock(&devfreq->lock);=0A=
>>   		ret =3D devfreq_set_target(devfreq, devfreq->resume_freq, 0);=0A=
>> +		mutex_unlock(&devfreq->lock);=0A=
>>   		if (ret)=0A=
>>   			return ret;=0A=
>>   	}=0A=
>>=0A=
> =0A=
> =0A=
=0A=
