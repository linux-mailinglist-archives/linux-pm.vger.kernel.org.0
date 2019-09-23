Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6561ABBBDE
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2019 20:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbfIWS4e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Sep 2019 14:56:34 -0400
Received: from mail-eopbgr40070.outbound.protection.outlook.com ([40.107.4.70]:16290
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727732AbfIWS4e (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 23 Sep 2019 14:56:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYFEPmbqTHCioOfh2fSZgkhNJjKxQtugylIvhClGk7gUpbpHdBKWfVYzGydvz6OUctwkC3sAHsECfaeMsilpkdXVKJbKZrEqj2v2zdB2AoZmbJ109IOZuchPmclp7+r4TrWDS2HkzbFkHwXI6/IVvt6i7/PJRxeJtxDufKeJBYTe64Cg8FnmBfLgWYvYAwGwet5p6sv4BhPfGZJpwHVtP3aH4lMutw9PBrF7kaXFoni4uDh8ZUVUkHis99nEYO7KmfMa0SpsHKh1H68WsUiFEFw2xzkRHIDEXyPB68fyOxfPhdg79RI3A7sVmrwu6obUl3L8HQnppbZ6ZeCGk8tiNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFkk/sTehnB22QWwQLvqzdn+0Vf+goQkY1TdiXdzX1I=;
 b=mQmvJ81f4fIkXu/3nI26OcNCpGk71cV8ypUenqho6Fe5yJKPyrzZ/sseGJbX0K+MkWkzuHoc/5PEpwSeSihA55zZ65IOXM36K9lainGCW4WpoXZbnzgzaei6SKM0ahVgiY8ROB5/2MbipXtfdmESWZo9IR9O4hkpc350qZ6Comtlo0UEWtXBU1EGBudxpYpiy8AWYwkHGxKChpBButtXQ7pK0E385OvrrE/P8y9Iqj+lNQtmp0brHrhkRdX0d+fiatSQWEYP7kmpAu57SjKn96pGmPIwCgdnJKTvC7HCb+g0k6uT76upPyqb+/0lGMM1CclktkKhctwIeKUGslPR1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFkk/sTehnB22QWwQLvqzdn+0Vf+goQkY1TdiXdzX1I=;
 b=Cqeg2vy+MXbGZ3WrxKR1IqFCC8IsbgyK/Lr7CtK1j5sMZ0UkqzDpU4HXa+g1BrAbvxIHBHv3pED/1qHFz///gOOBGy3wDMATZ/YjXn8byrGo4udrXMnlWvW0zTTCJhjAg09931SW6jb0JEOQxcHR3azbwMlZ4d5IlogG2OLOY/k=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB6094.eurprd04.prod.outlook.com (20.179.25.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.25; Mon, 23 Sep 2019 18:56:28 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::15cd:b6e7:5016:ae8]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::15cd:b6e7:5016:ae8%2]) with mapi id 15.20.2284.023; Mon, 23 Sep 2019
 18:56:28 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v6 2/6] PM / devfreq: Move more initialization before
 registration
Thread-Topic: [PATCH v6 2/6] PM / devfreq: Move more initialization before
 registration
Thread-Index: AQHVcia8XApMx2vUsE+43WtJMSpWjg==
Date:   Mon, 23 Sep 2019 18:56:28 +0000
Message-ID: <VI1PR04MB7023C94F93C4E0E6E229F80AEE850@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1569252537.git.leonard.crestez@nxp.com>
 <0ad496507cd7e6731e46249b1499dfdebe205c16.1569252537.git.leonard.crestez@nxp.com>
 <20190923181057.GY133864@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 330a2769-e418-49d1-64ee-08d74057bdb5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB6094;
x-ms-traffictypediagnostic: VI1PR04MB6094:|VI1PR04MB6094:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB6094637D4472C92531634B7EEE850@VI1PR04MB6094.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0169092318
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(189003)(199004)(6116002)(6436002)(9686003)(55016002)(26005)(5660300002)(81166006)(81156014)(8676002)(229853002)(44832011)(14444005)(256004)(99286004)(74316002)(66066001)(478600001)(102836004)(8936002)(76176011)(186003)(305945005)(7696005)(7736002)(54906003)(66446008)(64756008)(7416002)(316002)(33656002)(53546011)(6506007)(76116006)(6246003)(52536014)(14454004)(66476007)(91956017)(66946007)(6916009)(66556008)(71190400001)(4326008)(25786009)(446003)(486006)(2906002)(86362001)(3846002)(476003)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6094;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uhvS1d1OIamAJIEmxn18Y5/e1D6ycWd0/NGindV30OEMPEe39bdxpKwCQNYMyjJlh5N6JLpot6RubOzvIzlqdOoVdlBY8dqLSsIZsxDY72oj0jnAwHQFuuyIOo6DeQW9HCSNNBVZrVGTygFxqaba2a5a2I16g83YpB4rTDGUGmnohOPP9DNsoR+ujAkUzxMLH1/sBfSeMUTL13f90KMst14dRno/a0HahKatUwr4wiIHcZyGiyxnb6ut0KihyivVeA0O4NNAZDzI4rMBjuEzI5RMRlBCUqAe/hP+X3tBWCjLcrxEoyKWrWD+nUJ/1UB+R2oNDfA8urvO5lZdGybO7fm6HxnkYNH1enbOHEV7zik3424MLB2sOU49LDe5oX/xTcBoN3ER2jzwEDXxGajdRg4K+bzOKUkdWp5oM4gFoco=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 330a2769-e418-49d1-64ee-08d74057bdb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2019 18:56:28.4037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: og0JSG+5/H5E9A+wsy3PkaDTx1I7oEcO40ECjpDT6/E0llT31n80BFml9v7apov5HYSI+6A2Wz+8uz2XafgLLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6094
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23.09.2019 21:11, Matthias Kaehlcke wrote:=0A=
> On Mon, Sep 23, 2019 at 06:51:05PM +0300, Leonard Crestez wrote:=0A=
>> In general it is a better to initialize an object before making it=0A=
>> accessible externally (through device_register).=0A=
>>=0A=
>> This makes it possible to avoid relying on locking a partially=0A=
>> initialized object.=0A=
>>=0A=
>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>> ---=0A=
>>   drivers/devfreq/devfreq.c | 43 +++++++++++++++++++++++----------------=
=0A=
>>   1 file changed, 25 insertions(+), 18 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c=0A=
>> index 323d43315d1e..b4d2bfebb140 100644=0A=
>> --- a/drivers/devfreq/devfreq.c=0A=
>> +++ b/drivers/devfreq/devfreq.c=0A=
>> @@ -587,10 +587,12 @@ static void devfreq_dev_release(struct device *dev=
)=0A=
>>   	mutex_unlock(&devfreq_list_lock);=0A=
>>   =0A=
>>   	if (devfreq->profile->exit)=0A=
>>   		devfreq->profile->exit(devfreq->dev.parent);=0A=
>>   =0A=
>> +	kfree(devfreq->time_in_state);=0A=
>> +	kfree(devfreq->trans_table);=0A=
>>   	mutex_destroy(&devfreq->lock);=0A=
>>   	kfree(devfreq);=0A=
>>   }=0A=
>>   =0A=
>>   /**=0A=
>> @@ -670,44 +672,43 @@ struct devfreq *devfreq_add_device(struct device *=
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
> As per my comment on v5 I think the goto needs to go to 'err_dev'. The=0A=
> device registration failed, hence devfreq_dev_release() won't be=0A=
> called to free allocated memory.=0A=
=0A=
This code is not modified in the patch, it only shows up as +added =0A=
because diff got confused but there is an identical -removed chunk =0A=
higher up.=0A=
=0A=
The device_register documentation mentions the following:=0A=
=0A=
  * NOTE: _Never_ directly free @dev after calling this function, even=0A=
  * if it returned an error! Always use put_device() to give up the=0A=
  * reference initialized in this function instead.=0A=
=0A=
Cleanup path then goes like this (from a hacked error in device_add):=0A=
  dump_stack+0xdc/0x144 =0A=
 =0A=
=0A=
  devfreq_dev_release+0x38/0xc0 =0A=
 =0A=
=0A=
  device_release+0x34/0x90 =0A=
 =0A=
=0A=
  kobject_put+0x8c/0x1f0 =0A=
 =0A=
=0A=
  put_device+0x24/0x30 =0A=
 =0A=
=0A=
  devfreq_add_device+0x540/0x570 =0A=
 =0A=
=0A=
  devm_devfreq_add_device+0x60/0xd0 =0A=
 =0A=
=0A=
  imx_ddrc_probe+0x35c/0x4c8=0A=
=0A=
Can I add your "Reviewed-By" for the rest of the series if I fix the nits?=
=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
