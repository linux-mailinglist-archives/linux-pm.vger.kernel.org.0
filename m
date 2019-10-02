Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48F12C952D
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2019 01:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfJBXr6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 19:47:58 -0400
Received: from mail-eopbgr70084.outbound.protection.outlook.com ([40.107.7.84]:6186
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727349AbfJBXr6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Oct 2019 19:47:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fs2yIYfyIs+a7pN6kH4zeKNlGogsZlELGb4ID+SL6Zl5prc+Yhfj87T13TuzPF0DCLZFFT+aeuZlnndPq52pqvrfiAkzUZND+Xewb1KadhNhocso3HEFa0bwuNdyQUbrcMrTrmimhGiB9w35L4aIo51+PA5rfSGK4WkN5wLS0wBABk98WB3sZCxeOlYAoRX+JZW+1g76Zp0MnGqD1Xrl0BMUVeRI5oRY4mTPkfDfXKWxGR2wyVWV9s/B7bG8wX1suBqnlhGfn2DHEU+N0ka2bF4jCDoC/IiD0FPuV3FD2sQs3iIEZ6J1mf/fmJ+L2xmEMxMf9aOX4u6W1SFDYc+lyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nl8MMl01vTJ8vUhVXOuyXvN5C+WqYBQhPCPEU62qZZQ=;
 b=mKhzKM7wA8ru1ntWZG/MhmWdmDViY6nQ4GykFubosw6BNsBXLG/baOgbZQ6FZzNiUWS5d3LbwJdGxDiqDvfekR8NxJdYXtCBDWgu+6qx/30q0YJk2PLM2ZuQlaBqoYZkHkqLb+R4fgpHgCQ6HZuvRLBDhsE6RYMruEhn93R0rZ1enWdx+fPlD12k0m5ONKiC7uoITmEEzz8QXq25zZhGr1jajgpRnXs7CHE8q9OV5JipeW73EytxqvP4TPDPYLcf8Wr2RJ4jo//eJkrECgRRX6joPjhEklwFUcxZezs0gkY4xVDkx0E+YgX/cYcAXczyf6ds6/ajlaJjMHZyHO3oog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nl8MMl01vTJ8vUhVXOuyXvN5C+WqYBQhPCPEU62qZZQ=;
 b=FaCWdYlQB9MxCajI6cdWwqLQlZHERxsZvZd/SlDoNl/O4pQ5i2gFRc4DL6Z79aXWMg2d0ThFCq0QeRqWqI5O7Cg1UnuwxILSP9kO7zW19O9s+zVJQqi1b7T7S3jPVXtcPPNa2kOQFlTYpz/8SRTOhyeswXo5ZDkuQIoLSfr//X0=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5247.eurprd04.prod.outlook.com (20.177.51.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Wed, 2 Oct 2019 23:47:35 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2ce6:267:b2a6:9902]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2ce6:267:b2a6:9902%2]) with mapi id 15.20.2305.023; Wed, 2 Oct 2019
 23:47:35 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v9 2/8] PM / devfreq: Fix devfreq_notifier_call returning
 errno
Thread-Topic: [PATCH v9 2/8] PM / devfreq: Fix devfreq_notifier_call returning
 errno
Thread-Index: AQHVeVcive2Iv4wdX0S21lWzbVbDKw==
Date:   Wed, 2 Oct 2019 23:47:35 +0000
Message-ID: <VI1PR04MB7023EF602656CC360032E720EE9C0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1570044052.git.leonard.crestez@nxp.com>
 <10b1e5f93e7594852aa5cbfe1309bf486f70ecbb.1570044052.git.leonard.crestez@nxp.com>
 <20191002212437.GF87296@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 678f6ee5-eb36-4bdc-8e9f-08d74792e691
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR04MB5247:|VI1PR04MB5247:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB52474D8DE4F8D6B9B592E8A7EE9C0@VI1PR04MB5247.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(52314003)(199004)(189003)(256004)(14444005)(446003)(8936002)(71200400001)(71190400001)(110136005)(81156014)(81166006)(476003)(44832011)(486006)(8676002)(316002)(54906003)(14454004)(33656002)(478600001)(25786009)(2906002)(99286004)(9686003)(6436002)(66066001)(3846002)(229853002)(55016002)(5660300002)(6116002)(74316002)(7416002)(7736002)(305945005)(64756008)(66446008)(4326008)(6246003)(76116006)(66556008)(66476007)(66946007)(91956017)(186003)(26005)(52536014)(53546011)(6506007)(102836004)(7696005)(86362001)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5247;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i+4bRtJpvx43QPKEqX+2sOQc67+UcaUFX2Xl3yVUWAQbnMYSJpRQZSOx4BS0MvUncSSzLP3p0d7yDoM3e6OO3IehXeZmJ5IE75o9mvm9lGrHpK++f0mVghv2l3kroL6/3315EXI3d0qs5Jy8/pTmw4Y7lX7+88lYHAOUihO2q7wItO3z4amjwzRnq2WgUcNEb/AsIRZdyHvBa3Qp5h7h9worg49gbt5UhPUDDikLFu+JehhXvmwN9y6VQLeEnIW7glqEo1yzwBkxKEUSOhlTXACknX0kYs5fgkafc4NoGYLw94VNKHfrs47KcPoKFBabMkiUVIXNklTB+gHWa14f+op3zQh8/fGsfaX20i5PUtxIdysDuCDfTd9X/yxtpcjEv96r4oIwC9oh4M17yJyBd2TOqzmyK60EwnbE5FXHSgc=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 678f6ee5-eb36-4bdc-8e9f-08d74792e691
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 23:47:35.3449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qX/ixD997sfRiKarNBU3ijrUY5uO5Rn5BPBQLABtdLRxtBa7Lno4sjTKSQ5J05ChuO5KNz0CZ6+NxfLRcySK2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5247
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019-10-03 12:24 AM, Matthias Kaehlcke wrote:=0A=
> On Wed, Oct 02, 2019 at 10:25:05PM +0300, Leonard Crestez wrote:=0A=
>> Notifier callbacks shouldn't return negative errno but one of the=0A=
>> NOTIFY_OK/DONE/BAD values.=0A=
>>=0A=
>> The OPP core will ignore return values from notifiers but returning a=0A=
>> value that matches NOTIFY_STOP_MASK will stop the notification chain.=0A=
>>=0A=
>> Fix by always returning NOTIFY_OK.=0A=
>>=0A=
>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>> ---=0A=
>>   drivers/devfreq/devfreq.c | 24 +++++++++++++-----------=0A=
>>   1 file changed, 13 insertions(+), 11 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c=0A=
>> index 7dc899da1172..32bbf6e80380 100644=0A=
>> --- a/drivers/devfreq/devfreq.c=0A=
>> +++ b/drivers/devfreq/devfreq.c=0A=
>> @@ -548,30 +548,32 @@ EXPORT_SYMBOL(devfreq_interval_update);=0A=
>>    */=0A=
>>   static int devfreq_notifier_call(struct notifier_block *nb, unsigned l=
ong type,=0A=
>>   				 void *devp)=0A=
>>   {=0A=
>>   	struct devfreq *devfreq =3D container_of(nb, struct devfreq, nb);=0A=
>> -	int ret;=0A=
>> +	int err =3D -EINVAL;=0A=
>>   =0A=
>>   	mutex_lock(&devfreq->lock);=0A=
>>   =0A=
>>   	devfreq->scaling_min_freq =3D find_available_min_freq(devfreq);=0A=
>> -	if (!devfreq->scaling_min_freq) {=0A=
>> -		mutex_unlock(&devfreq->lock);=0A=
>> -		return -EINVAL;=0A=
>> -	}=0A=
>> +	if (!devfreq->scaling_min_freq)=0A=
>> +		goto out;=0A=
>>   =0A=
>>   	devfreq->scaling_max_freq =3D find_available_max_freq(devfreq);=0A=
>> -	if (!devfreq->scaling_max_freq) {=0A=
>> -		mutex_unlock(&devfreq->lock);=0A=
>> -		return -EINVAL;=0A=
>> -	}=0A=
>> +	if (!devfreq->scaling_max_freq)=0A=
>> +		goto out;=0A=
>> +=0A=
>> +	err =3D update_devfreq(devfreq);=0A=
>>   =0A=
>> -	ret =3D update_devfreq(devfreq);=0A=
>> +out:=0A=
>>   	mutex_unlock(&devfreq->lock);=0A=
>> +	if (err)=0A=
>> +		dev_err(devfreq->dev.parent,=0A=
>> +			"failed to update frequency from OPP notifier (%d)\n",=0A=
>> +			err);=0A=
> =0A=
> In case an OPP freq can't be found the log doesn't provide clues=0A=
> about what the problem could be. I couldn't find a clearly superior=0A=
> errno value though, so I guess this is as good as it gets, unless=0A=
> you want to have a dedicated message for those errors. Should be a=0A=
> rare exception anyway, and previously there was no log at all.=0A=
=0A=
I guess it could happen if all OPPs are disabled after probe?=0A=
=0A=
The devfreq core will attempt to switch away if the current OPP get =0A=
disabled but if nothing else is available then printing an error and =0A=
sticking to the current frequency seems reasonable.=0A=
=0A=
It would indicate a bug somewhere else.=0A=
=0A=
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>=0A=
