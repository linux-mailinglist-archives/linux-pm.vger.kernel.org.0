Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFA5310E521
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2019 05:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfLBEpY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Dec 2019 23:45:24 -0500
Received: from mail-eopbgr10062.outbound.protection.outlook.com ([40.107.1.62]:20814
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727308AbfLBEpY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 1 Dec 2019 23:45:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6PDfgGziIcO6BA2ZbeRkm1orAK9oqRWJHvnDcyOL577LzyexA3dQstt8H2slLT7md08/bbpLL1cVuMMrh7UI4/DNmdl06AQJa6f6yy9UMMgbqfwST5xr9Kl5n1AuzK5KAav2Yt/Kt9s5NR61qB0S8sR/1lepffVCSpIa06KSsGZG0WJetPO0147tH/IjoQtUZ57Bn3S91Vh229+hP2ICL5foVElSNpKFpvARv2BxgYYx3675O52qPylR7ASzvqA+9nEREn+fHzOMKdlzJffisKjAz6yIdVsoWAwnQ0yseNv1Sy2pGHOnUQtGioSZvAZtMvsrDUCApgUFxPaaI6Q/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2MXlJH49hejZV/XgTE8y8hZg7jNv8TB2HFnRebs/hM=;
 b=fRlTOTJ75SPgwPhjm+PsG8vuVGSm4GCNYi2CwzUIdbf2jffqQBbwmkA+x/vWP4IAf9AUm7zn6Z03HUlQdU4UeNfHSt0V2wr7LE8UisNaaHDLEiwLlGpKFtnqLqBNqNrzMY1PeIl3AWP3GCTsWA8YHo2UqngzdCRRKPVrAa7rdrSQ9vPCz3RzCqjoz7ULJPuFInn9WVYIWk7QVFMa1JiG8aHzNioIFIbwKwc9RbeVKI+UomJC0VeqVAKk4N9zREnXEd8zg04deQSs8t3+mvtnvHWTlEynCe6a2MiPkyeTuAfTp4pNyakK9UwYEZQRqWllh0djbo7XihZqWLAQeJqX6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2MXlJH49hejZV/XgTE8y8hZg7jNv8TB2HFnRebs/hM=;
 b=Byrl4KssncVCoU33PEkYwgG9kBes+2IP357EHU3A59gtyJNw01wuNuq6Sga/twLyIMGCEgzGnNIidPLcjecZiKTam6yU0rv4WUMj1SFRUpOaUQNQibmGPTyYjQ7At59v01nPlJAPMQ2lFU5P08PLyZH7IBzGs9jYEY2heHJlsIg=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5806.eurprd04.prod.outlook.com (20.178.204.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Mon, 2 Dec 2019 04:45:17 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 04:45:16 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
CC:     Kyungmin Park <kyungmin.park@samsung.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Kaehlcke <mka@chromium.org>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 2/5] PM / devfreq: Split device_register usage
Thread-Topic: [PATCH 2/5] PM / devfreq: Split device_register usage
Thread-Index: AQHVmnkb/0VMwHylrEWcL8nyQOOCfQ==
Date:   Mon, 2 Dec 2019 04:45:16 +0000
Message-ID: <VI1PR04MB7023135B9D53D86A101F1895EE430@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1573686315.git.leonard.crestez@nxp.com>
 <CGME20191113232144epcas1p37b0c4f2d15be4686b4796c6132ef6bbe@epcas1p3.samsung.com>
 <85ccf6afe5db556c610ce2b47ccc38132b6671f6.1573686315.git.leonard.crestez@nxp.com>
 <69d37137-8c7a-ddcc-f692-09546c79ff7d@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6cbe7f32-5daf-42b3-721b-08d776e26d95
x-ms-traffictypediagnostic: VI1PR04MB5806:|VI1PR04MB5806:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5806CBF483374FEBF16EA430EE430@VI1PR04MB5806.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(189003)(199004)(256004)(8676002)(81156014)(14444005)(25786009)(2906002)(316002)(54906003)(14454004)(81166006)(110136005)(8936002)(76176011)(6116002)(3846002)(478600001)(7696005)(44832011)(446003)(229853002)(76116006)(91956017)(6436002)(33656002)(7736002)(66066001)(305945005)(102836004)(64756008)(66446008)(66556008)(66476007)(66946007)(4326008)(5660300002)(6246003)(53546011)(6506007)(9686003)(99286004)(55016002)(7416002)(186003)(71200400001)(86362001)(71190400001)(26005)(52536014)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5806;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eDn/OBmaUF90xeJtYzahnrd75D0xKkOcxatJO1X41sAl7bzfGLyC2tQIoe8j/jwFaW7as6oBQseEyuvF6zrnLxRlPDB8D0hFSiZ9A83Ev2cZ3hbrE2Ene8WfpklUrNgte/mT+J/ZYLOJpwYtmTCRQjRQ9UuPNNOiP2CYO9jHbDXvQY98l71VK9xMSsUaNsWZTWfhdIHPsanXyakhtZVaozVqluFXNFuRluWyOcH7DUWBntj1algFCZIDW6um+PWNDF2FaObkBApK/7oomYJJ67B9xhF49inNvxGdcsJlrmmNsVP+PGkS1tCLRpvHGmlaA4SPMdUPIPnyFvi1HgbZJ4T/xt9GCafgTyosUJWY3RcVT8K7SgnaXxAwLhRHwdhktfysJS1MB2DjntbnzG6tQnWFwN97qN7UNwvwBCdavKlrCU3Gk44/w4x7wfAKXRfy
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbe7f32-5daf-42b3-721b-08d776e26d95
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 04:45:16.7928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vKVON5WxNpM3qQ2bycGX9irBbuoEIkrTsQn4Tiu30Kl9Vksaeo+xssRDA9yk9S0yZvs0ccuVkre+XYdFy46Okg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5806
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019-12-02 3:02 AM, Chanwoo Choi wrote:=0A=
> On 11/14/19 8:21 AM, Leonard Crestez wrote:=0A=
>> Splitting device_register into device_initialize and device_add allows=
=0A=
>> devm-based allocations to be performed before device_add.=0A=
>>=0A=
>> It also simplifies error paths in devfreq_add_device: just call=0A=
>> put_device instead of duplicating parts of devfreq_dev_release.=0A=
>>=0A=
>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>> ---=0A=
>>   drivers/devfreq/devfreq.c | 10 +++++-----=0A=
>>   1 file changed, 5 insertions(+), 5 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c=0A=
>> index 27af1b95fd23..b89a82382536 100644=0A=
>> --- a/drivers/devfreq/devfreq.c=0A=
>> +++ b/drivers/devfreq/devfreq.c=0A=
>> @@ -689,10 +689,11 @@ struct devfreq *devfreq_add_device(struct device *=
dev,=0A=
>>   	mutex_init(&devfreq->lock);=0A=
>>   	mutex_lock(&devfreq->lock);=0A=
>>   	devfreq->dev.parent =3D dev;=0A=
>>   	devfreq->dev.class =3D devfreq_class;=0A=
>>   	devfreq->dev.release =3D devfreq_dev_release;=0A=
>> +	device_initialize(&devfreq->dev);=0A=
>>   	INIT_LIST_HEAD(&devfreq->node);=0A=
>>   	devfreq->profile =3D profile;=0A=
>>   	strncpy(devfreq->governor_name, governor_name, DEVFREQ_NAME_LEN);=0A=
>>   	devfreq->previous_freq =3D profile->initial_freq;=0A=
>>   	devfreq->last_status.current_frequency =3D profile->initial_freq;=0A=
>> @@ -726,15 +727,14 @@ struct devfreq *devfreq_add_device(struct device *=
dev,=0A=
>>   	devfreq->suspend_freq =3D dev_pm_opp_get_suspend_opp_freq(dev);=0A=
>>   	atomic_set(&devfreq->suspend_count, 0);=0A=
>>   =0A=
>>   	dev_set_name(&devfreq->dev, "devfreq%d",=0A=
>>   				atomic_inc_return(&devfreq_no));=0A=
>> -	err =3D device_register(&devfreq->dev);=0A=
>> +	err =3D device_add(&devfreq->dev);=0A=
>>   	if (err) {=0A=
>>   		mutex_unlock(&devfreq->lock);=0A=
>> -		put_device(&devfreq->dev);=0A=
>> -		goto err_out;=0A=
>> +		goto err_dev;=0A=
>>   	}=0A=
>>   =0A=
>>   	devfreq->trans_table =3D devm_kzalloc(&devfreq->dev,=0A=
>>   			array3_size(sizeof(unsigned int),=0A=
>>   				    devfreq->profile->max_state,=0A=
>> @@ -789,13 +789,13 @@ struct devfreq *devfreq_add_device(struct device *=
dev,=0A=
>>   =0A=
>>   err_init:=0A=
>>   	mutex_unlock(&devfreq_list_lock);=0A=
>>   err_devfreq:=0A=
>>   	devfreq_remove_device(devfreq);=0A=
>> -	devfreq =3D NULL;=0A=
>> +	return ERR_PTR(err);=0A=
>>   err_dev:=0A=
>> -	kfree(devfreq);=0A=
>> +	put_device(&devfreq->dev);=0A=
>>   err_out:=0A=
>>   	return ERR_PTR(err);=0A=
>>   }=0A=
>>   EXPORT_SYMBOL(devfreq_add_device);=0A=
>>   =0A=
>>=0A=
> =0A=
> As I previously commented, I don't prefer to split out of bodyf of device=
_register().=0A=
> Instead, your first version is better without devm.=0A=
=0A=
Very well, feel free to drop 2-5 of this series then.=0A=
=0A=
Or perhaps I misunderstood and the locking cleanups would be acceptable =0A=
in the variant that removes devm from a few allocations? There's quite a =
=0A=
bunch of stuff flying around the merge window already so I'll refrain =0A=
from posting until v5.5-rc1 anyway.=0A=
=0A=
I went a little overboard with tricky cleanups and this ended up =0A=
delaying the functionality I wanted to push.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
