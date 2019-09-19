Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B06E5B8109
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 20:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391288AbfISSwM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 14:52:12 -0400
Received: from mail-eopbgr140041.outbound.protection.outlook.com ([40.107.14.41]:16110
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390669AbfISSwM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Sep 2019 14:52:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4fIhj+90Byu/O03THqBJz5if1fMvQoEEM51mfoflPtGl8ZVpLEXqu3ry2autSpgkjgikYH+CWQBNxngJOurUja/+pj0iqCCarTn1G6vW+FVjBTdCgZ1X/e+hsziTy3IF8qOG/6wYYGW7JEMbHe2h9siSJ+36L5RNDm2VTxphPB7GJJ6wBCiA1tII8gvTKs1IUsKk+CKnyjhBy4LbN7X9Uj4P0/cD3726aoaFwrQfKXn0VwnMhKVCyUKWInoj5/QsuW5QkxMkk/n526Pp3B2R9p3v0lE6C5PImW+L71XAcZsUyr66fQ6SOay9/GayCRrnRHObSbUX/Ip/oMaA4TLRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qateg/ey0AYl1xAX1qXNH/BSjTRGYq1NLWHHpyHP0Nk=;
 b=HbrtHNa5YZ/DKQv5skZgDtlTpnmBxbmnLwotXjhFDDx2OQ5XBCxmxJHDUTUXS9CY5p1tR232RFt1fKBFMrAVDopQVcrnD9uifgveCX3clau7cFhGilIykFGRzvENjsytbbbbS8NYR3icoT0IGcfSJsoZJx3dsnTxpJz1Q6x/kHMQ01shtLcHA4mWPqq4sSiFSQKQqoCBI99irt9AvqlvFDDOgSHe9t3aK/WrRuezYAYnKt80Ef4mOpsa8dHRw8I17M/RJ9+yS983v2OH2pfyLhZuDK+4Bl0fkYGHDkXbbR4DwILNFiQcA2PkEYy/vDQhAOiLC7QGK7wp03ORfXMDWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qateg/ey0AYl1xAX1qXNH/BSjTRGYq1NLWHHpyHP0Nk=;
 b=Eymlb+eNEKqIkzSNNR2b6eEH7/kecUOOxeKbV9FM9+4xn8VSEU73Qh9xLJMv2gfxd043SRGw3v/qBDRQacFRrK60l5Hred5CeNopWRPK1gVWQRNj6c83EXvhPFkVH/x6G9q/ogGw+9AYHkw+YtBTlGrFPgTbUMCB6qe8or/7tz4=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5151.eurprd04.prod.outlook.com (20.177.50.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.21; Thu, 19 Sep 2019 18:52:07 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::15cd:b6e7:5016:ae8]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::15cd:b6e7:5016:ae8%2]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 18:52:07 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Matthias Kaehlcke <mka@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
CC:     =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/8] PM / devfreq: Move more initialization before
 registration
Thread-Topic: [PATCH 3/8] PM / devfreq: Move more initialization before
 registration
Thread-Index: AQHVbnjgwqBFLhrM3E2fNwR3RpKVeg==
Date:   Thu, 19 Sep 2019 18:52:07 +0000
Message-ID: <VI1PR04MB702350FA21534747D540C04FEE890@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1568764439.git.leonard.crestez@nxp.com>
 <59bd0d871fad520eb417ca46943fa7f86ef9186a.1568764439.git.leonard.crestez@nxp.com>
 <20190918232904.GP133864@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7a769a2-8cc0-4cfe-0d16-08d73d327857
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5151;
x-ms-traffictypediagnostic: VI1PR04MB5151:|VI1PR04MB5151:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5151C1CCF05AD96A73D82738EE890@VI1PR04MB5151.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(199004)(189003)(6116002)(3846002)(2906002)(14454004)(305945005)(74316002)(33656002)(99286004)(7736002)(478600001)(66066001)(7696005)(26005)(76176011)(25786009)(102836004)(76116006)(91956017)(7416002)(66946007)(186003)(6506007)(53546011)(316002)(110136005)(6246003)(66556008)(64756008)(66476007)(66446008)(54906003)(44832011)(486006)(8676002)(446003)(4326008)(476003)(9686003)(55016002)(14444005)(256004)(6436002)(52536014)(71200400001)(8936002)(71190400001)(86362001)(81166006)(81156014)(5660300002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5151;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vNaeqSpYB/826HVAlhcrxPY/qL2oYopvebXdzZQxJ9d/TVdO0n3w73W6e9Zc5UurvF+kj7F+NbiFD9FrYpXPXtEkGZvJXFCRvwjIFsjHYB+ACXDJg1OhwhM6aNjIVm1eGmE2I6nzu2RXWNQV4VfZwAiGuOKvScq6EqWPoQVNoRvJqfzd/DB19qNpOShSqhwpu4cyvVrqKOcpYqLihmM+JcnfeihlcSNJ3V7aOcKYqST8CWTMpTfSKEgfEeNaD8Dt/zCY4TcN1o9yzKvNlfyuSAN8D6nqEEhK43akFOezWRThgw5t1GMCN6i176ahGZCmiCGaBgKCb4cY6mUGimBTWxMD5snh0UOZFAzjPTcc+IT/uX8Oljn8Ynzn8rDxaCSd+KmXqTGxji/B08K51aI++wp6nT/f7ZWBEkQix+C6Ehw=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a769a2-8cc0-4cfe-0d16-08d73d327857
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 18:52:07.1783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ckG4bzVlCumotpHVk7Ue1YpmZqWo/AGkuIOn5jgjO6NxMoBFfeVjlTR+e6wrWxsoQesbTWZvtGQRlKdNSuXcwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5151
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19.09.2019 02:29, Matthias Kaehlcke wrote:=0A=
> Hi Leonard,=0A=
> =0A=
> On Wed, Sep 18, 2019 at 03:18:22AM +0300, Leonard Crestez wrote:=0A=
>> In general it is a better to initialize an object before making it=0A=
>> accessible externally (through device_register).=0A=
>>=0A=
>> This make it possible to avoid relying on locking a partially=0A=
>> initialized object.=0A=
>>=0A=
>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>> ---=0A=
>>   drivers/devfreq/devfreq.c | 38 ++++++++++++++++++++------------------=
=0A=
>>   1 file changed, 20 insertions(+), 18 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c=0A=
>> index a715f27f35fd..57a217fc92de 100644=0A=
>> --- a/drivers/devfreq/devfreq.c=0A=
>> +++ b/drivers/devfreq/devfreq.c=0A=
>> @@ -589,10 +589,12 @@ static void devfreq_dev_release(struct device *dev=
)=0A=
>>   =0A=
>>   	if (devfreq->profile->exit)=0A=
>>   		devfreq->profile->exit(devfreq->dev.parent);=0A=
>>   =0A=
>>   	mutex_destroy(&devfreq->lock);=0A=
>> +	kfree(devfreq->time_in_state);=0A=
>> +	kfree(devfreq->trans_table);=0A=
>>   	kfree(devfreq);=0A=
>>   }=0A=
>>   =0A=
>>   /**=0A=
>>    * devfreq_add_device() - Add devfreq feature to the device=0A=
>> @@ -671,44 +673,43 @@ struct devfreq *devfreq_add_device(struct device *=
dev,=0A=
>>   	devfreq->max_freq =3D devfreq->scaling_max_freq;=0A=
>>   =0A=
>>   	devfreq->suspend_freq =3D dev_pm_opp_get_suspend_opp_freq(dev);=0A=
>>   	atomic_set(&devfreq->suspend_count, 0);=0A=
>>   =0A=
>> -	dev_set_name(&devfreq->dev, "devfreq%d",=0A=
>> -				atomic_inc_return(&devfreq_no));=0A=
>> -	err =3D device_register(&devfreq->dev);=0A=
>> -	if (err) {=0A=
>> -		mutex_unlock(&devfreq->lock);=0A=
>> -		put_device(&devfreq->dev);=0A=
>> -		goto err_out;=0A=
>> -	}=0A=
>> -=0A=
>> -	devfreq->trans_table =3D devm_kzalloc(&devfreq->dev,=0A=
>> +	devfreq->trans_table =3D kzalloc(=0A=
>>   			array3_size(sizeof(unsigned int),=0A=
>>   				    devfreq->profile->max_state,=0A=
>>   				    devfreq->profile->max_state),=0A=
>>   			GFP_KERNEL);=0A=
>>   	if (!devfreq->trans_table) {=0A=
>>   		mutex_unlock(&devfreq->lock);=0A=
>>   		err =3D -ENOMEM;=0A=
>> -		goto err_devfreq;=0A=
>> +		goto err_dev;=0A=
>>   	}=0A=
>>   =0A=
>> -	devfreq->time_in_state =3D devm_kcalloc(&devfreq->dev,=0A=
>> -			devfreq->profile->max_state,=0A=
>> -			sizeof(unsigned long),=0A=
>> -			GFP_KERNEL);=0A=
>> +	devfreq->time_in_state =3D kcalloc(devfreq->profile->max_state,=0A=
>> +					 sizeof(unsigned long),=0A=
>> +					 GFP_KERNEL);=0A=
>>   	if (!devfreq->time_in_state) {=0A=
>>   		mutex_unlock(&devfreq->lock);=0A=
>>   		err =3D -ENOMEM;=0A=
>> -		goto err_devfreq;=0A=
>> +		goto err_dev;=0A=
>>   	}=0A=
>>   =0A=
>>   	devfreq->last_stat_updated =3D jiffies;=0A=
>>   =0A=
>>   	srcu_init_notifier_head(&devfreq->transition_notifier_list);=0A=
>>   =0A=
>> +	dev_set_name(&devfreq->dev, "devfreq%d",=0A=
>> +				atomic_inc_return(&devfreq_no));=0A=
>> +	err =3D device_register(&devfreq->dev);=0A=
>> +	if (err) {=0A=
>> +		mutex_unlock(&devfreq->lock);=0A=
>> +		put_device(&devfreq->dev);=0A=
>> +		goto err_out;=0A=
> =0A=
>    		goto err_dev;=0A=
> =0A=
>> +	}=0A=
>> +=0A=
>>   	mutex_unlock(&devfreq->lock);=0A=
>>   =0A=
>>   	mutex_lock(&devfreq_list_lock);=0A=
>>   =0A=
>>   	governor =3D try_then_request_governor(devfreq->governor_name);=0A=
>> @@ -734,14 +735,15 @@ struct devfreq *devfreq_add_device(struct device *=
dev,=0A=
>>   =0A=
>>   	return devfreq;=0A=
>>   =0A=
>>   err_init:=0A=
>>   	mutex_unlock(&devfreq_list_lock);=0A=
>> -err_devfreq:=0A=
>>   	devfreq_remove_device(devfreq);=0A=
>> -	devfreq =3D NULL;=0A=
>> +	return ERR_PTR(err);=0A=
> =0A=
> The two return paths in the unwind part are unorthodox, but I=0A=
> see why they are needed. Maybe add an empty line between the two paths=0A=
> to make it a bit more evident that they are separate.=0A=
=0A=
Old code did "devfreq =3D NULL" just so that the later kfree did nothing. =
=0A=
There were already two unwind paths, it's just that the second one was =0A=
less obvious. I will add a comment.=0A=
=0A=
>>   err_dev:=0A=
> =0A=
> This code path should include=0A=
> =0A=
> 	mutex_destroy(&devfreq->lock);=0A=
> =0A=
> That was already missing in the original code though.=0A=
=0A=
Yes, that would be a separate patch.=0A=
=0A=
> Actually with the later device registration the mutex could be=0A=
> initialized later and doesn't need to be held. This would=0A=
> obsolete the mutex_unlock() calls in the error paths=0A=
Next patch already removes mutex_lock before device_register (that's the =
=0A=
purpose of the cleanup). If you're suggesting to move mutex_init around =0A=
it's not clear what would be gained?=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
