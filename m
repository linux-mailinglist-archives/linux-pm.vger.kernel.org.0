Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 907ACBBC8F
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2019 21:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387510AbfIWT6i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Sep 2019 15:58:38 -0400
Received: from mail-eopbgr140045.outbound.protection.outlook.com ([40.107.14.45]:55086
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726777AbfIWT6i (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 23 Sep 2019 15:58:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFgbrMqlr7cel0+orsLJzCxyuSdA1U1k7rT6eH3Iesrj08gaam6NQRn1DvHpfOa5UyPlG+Z//CUwls1pAHPzRq9ZUr9KbCnw1aWBNNyRfJqfD3sk7ye0hP1Pki/zziluJQUXto74dwBALQjMENvQx8bLpEoK3Gfv9G4LP3VHV8pLBaomLB8ThE+B+/uwWGvFdyD8HCe02mS5E8M/MLWu8eoKBvwTHZoreFtsKw9zIBp2VqkjJ4vz+020jwXpOiky0Iq6pZfohCwI8/tgLgIxdog+sUWKh6noC99yA/CNMPGWX2Dx/bFtvo8rlZIcnClwfXpIko07nS/h5UsZVdcQfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhKkkocm6HK6AXDk7smCIHDE5QWNKiUg2bXdf1/0IFQ=;
 b=L0s7WXkpwmW0GJ3EvErjsDM6VV6DBOlVU5Xs9EceWbFG7Ip4rzYolzebKHPP9KOUm9dJqHyox9xBuHMfcj37HV19jDxdH1UEcL4mqU2dUnsQ6NfpC25on3ZavYXIIUftquWfOJPN2tqB5WMiTtKz+AXPlMcbWxkLY3+44cYFfXJYT8ZH6mlcLgjuQZQNqZwXRXv2mUXF2c+3Ffvm7B/gZInJ9F7J0dj+4NJFHnvWhShRHDzGgg+5nksDdKGTRtKloleaZL6XhAsWlS4JFhjauDbuHi+397qOMgHUeHjHT9rfYOgOrsie76QGSsc5g8bNVl6IucaO+AW+tnogLHo1MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhKkkocm6HK6AXDk7smCIHDE5QWNKiUg2bXdf1/0IFQ=;
 b=Gl7WUN2SJQ2kFxyfvKgR8AjFwoeRljL0D2REKOPc8CnVXd94+n2/LArjJoCzFCwjapgtqQDMCA9rS1SZkbjwYSMhut13hk4fNPwFw/c7k8ImQrlrkdqFTgeEohfb+gYoyNWCt6AFx7oWkjVBQ7Lcn/fDhlvHsIL3fU2SIPBPvuc=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5934.eurprd04.prod.outlook.com (20.178.205.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Mon, 23 Sep 2019 19:56:52 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::15cd:b6e7:5016:ae8]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::15cd:b6e7:5016:ae8%2]) with mapi id 15.20.2284.023; Mon, 23 Sep 2019
 19:56:52 +0000
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
Date:   Mon, 23 Sep 2019 19:56:51 +0000
Message-ID: <VI1PR04MB7023E58A11DF398FC90F98C7EE850@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1569252537.git.leonard.crestez@nxp.com>
 <0ad496507cd7e6731e46249b1499dfdebe205c16.1569252537.git.leonard.crestez@nxp.com>
 <20190923181057.GY133864@google.com>
 <VI1PR04MB7023C94F93C4E0E6E229F80AEE850@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <20190923191111.GE133864@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36c04759-ed1e-4c5c-582f-08d740602d8c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5934;
x-ms-traffictypediagnostic: VI1PR04MB5934:|VI1PR04MB5934:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5934BC214FA60E5DFFC9D2FDEE850@VI1PR04MB5934.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0169092318
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(199004)(189003)(51914003)(53546011)(6916009)(9686003)(26005)(14454004)(7736002)(186003)(55016002)(76176011)(7416002)(102836004)(81156014)(81166006)(66066001)(71190400001)(71200400001)(8676002)(478600001)(86362001)(476003)(6506007)(3846002)(446003)(6116002)(8936002)(91956017)(25786009)(54906003)(7696005)(66446008)(99286004)(64756008)(66476007)(6246003)(256004)(66556008)(66946007)(486006)(2906002)(6436002)(44832011)(316002)(5660300002)(14444005)(229853002)(52536014)(74316002)(4326008)(33656002)(76116006)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5934;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JPr9XughU5zx91ovYciU5SvA/iYzdhMEuMXlIuKQLnt+tM/aX5VAHexZmSJmy78HWrmdzyX861QZuNTeCxHuHblIhwsriuUnd7Pm8d5tqAti4SVUq1mYpaL9r97aAdmhMhtzJAmFooUIlLkBltqkhNVEfYGWAeATrKpOn0ZpsSvIW1E4LWly2c1L26ls81sn2gprMkN6no9KjK84+lw5e3iTKBrwEocansNEJfXWBGW1ZqEk9000iMi5DwkssWgUssie2F3icpUSFFr2ubvLBNUj2JrzW4Ge/+3c+epjhsInh3wRkPcsOSearwYrmlcOovDkCjl1lUGFZ0sySIAFyVhBDMEqfPszU9F6X8Tp4A9rvX0UXzqoIvOejRYHJ7xxd/fgcpa1wvHESO05Fh3WEf3B+Xd53dGyK/O+UgvaYs4=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c04759-ed1e-4c5c-582f-08d740602d8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2019 19:56:52.0093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9gjdHM4T+mTVYgT2Y6siXLy+3bBIO4gO0QddPaVYbrkNRVTYp1gltU9pXNg36DlluifV/EIn0A8hut6YnkJPwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5934
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23.09.2019 22:11, Matthias Kaehlcke wrote:=0A=
> On Mon, Sep 23, 2019 at 06:56:28PM +0000, Leonard Crestez wrote:=0A=
>> On 23.09.2019 21:11, Matthias Kaehlcke wrote:=0A=
>>> On Mon, Sep 23, 2019 at 06:51:05PM +0300, Leonard Crestez wrote:=0A=
>>>> In general it is a better to initialize an object before making it=0A=
>>>> accessible externally (through device_register).=0A=
>>>>=0A=
>>>> This makes it possible to avoid relying on locking a partially=0A=
>>>> initialized object.=0A=
>>>>=0A=
>>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>>>> ---=0A=
>>>>    drivers/devfreq/devfreq.c | 43 +++++++++++++++++++++++-------------=
---=0A=
>>>>    1 file changed, 25 insertions(+), 18 deletions(-)=0A=
>>>>=0A=
>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c=0A=
>>>> index 323d43315d1e..b4d2bfebb140 100644=0A=
>>>> --- a/drivers/devfreq/devfreq.c=0A=
>>>> +++ b/drivers/devfreq/devfreq.c=0A=
>>>> @@ -587,10 +587,12 @@ static void devfreq_dev_release(struct device *d=
ev)=0A=
>>>>    	mutex_unlock(&devfreq_list_lock);=0A=
>>>>    =0A=
>>>>    	if (devfreq->profile->exit)=0A=
>>>>    		devfreq->profile->exit(devfreq->dev.parent);=0A=
>>>>    =0A=
>>>> +	kfree(devfreq->time_in_state);=0A=
>>>> +	kfree(devfreq->trans_table);=0A=
>>>>    	mutex_destroy(&devfreq->lock);=0A=
>>>>    	kfree(devfreq);=0A=
>>>>    }=0A=
>>>>    =0A=
>>>>    /**=0A=
>>>> @@ -670,44 +672,43 @@ struct devfreq *devfreq_add_device(struct device=
 *dev,=0A=
>>>>    	devfreq->max_freq =3D devfreq->scaling_max_freq;=0A=
>>>>    =0A=
>>>>    	devfreq->suspend_freq =3D dev_pm_opp_get_suspend_opp_freq(dev);=0A=
>>>>    	atomic_set(&devfreq->suspend_count, 0);=0A=
>>>>    =0A=
>>>> -	dev_set_name(&devfreq->dev, "devfreq%d",=0A=
>>>> -				atomic_inc_return(&devfreq_no));=0A=
>>>> -	err =3D device_register(&devfreq->dev);=0A=
>>>> -	if (err) {=0A=
>>>> -		mutex_unlock(&devfreq->lock);=0A=
>>>> -		put_device(&devfreq->dev);=0A=
>>>> -		goto err_out;=0A=
>>>> -	}=0A=
>>>> -=0A=
>>>> -	devfreq->trans_table =3D devm_kzalloc(&devfreq->dev,=0A=
>>>> +	devfreq->trans_table =3D kzalloc(=0A=
>>>>    			array3_size(sizeof(unsigned int),=0A=
>>>>    				    devfreq->profile->max_state,=0A=
>>>>    				    devfreq->profile->max_state),=0A=
>>>>    			GFP_KERNEL);=0A=
>>>>    	if (!devfreq->trans_table) {=0A=
>>>>    		mutex_unlock(&devfreq->lock);=0A=
>>>>    		err =3D -ENOMEM;=0A=
>>>> -		goto err_devfreq;=0A=
>>>> +		goto err_dev;=0A=
>>>>    	}=0A=
>>>>    =0A=
>>>> -	devfreq->time_in_state =3D devm_kcalloc(&devfreq->dev,=0A=
>>>> -			devfreq->profile->max_state,=0A=
>>>> -			sizeof(unsigned long),=0A=
>>>> -			GFP_KERNEL);=0A=
>>>> +	devfreq->time_in_state =3D kcalloc(devfreq->profile->max_state,=0A=
>>>> +					 sizeof(unsigned long),=0A=
>>>> +					 GFP_KERNEL);=0A=
>>>>    	if (!devfreq->time_in_state) {=0A=
>>>>    		mutex_unlock(&devfreq->lock);=0A=
>>>>    		err =3D -ENOMEM;=0A=
>>>> -		goto err_devfreq;=0A=
>>>> +		goto err_dev;=0A=
>>>>    	}=0A=
>>>>    =0A=
>>>>    	devfreq->last_stat_updated =3D jiffies;=0A=
>>>>    =0A=
>>>>    	srcu_init_notifier_head(&devfreq->transition_notifier_list);=0A=
>>>>    =0A=
>>>> +	dev_set_name(&devfreq->dev, "devfreq%d",=0A=
>>>> +				atomic_inc_return(&devfreq_no));=0A=
>>>> +	err =3D device_register(&devfreq->dev);=0A=
>>>> +	if (err) {=0A=
>>>> +		mutex_unlock(&devfreq->lock);=0A=
>>>> +		put_device(&devfreq->dev);=0A=
>>>> +		goto err_out;=0A=
>>>=0A=
>>> As per my comment on v5 I think the goto needs to go to 'err_dev'. The=
=0A=
>>> device registration failed, hence devfreq_dev_release() won't be=0A=
>>> called to free allocated memory.=0A=
>>=0A=
>> This code is not modified in the patch, it only shows up as +added=0A=
>> because diff got confused but there is an identical -removed chunk=0A=
>> higher up.=0A=
>>=0A=
>> The device_register documentation mentions the following:=0A=
>>=0A=
>>    * NOTE: _Never_ directly free @dev after calling this function, even=
=0A=
>>    * if it returned an error! Always use put_device() to give up the=0A=
>>    * reference initialized in this function instead.=0A=
>>=0A=
>> Cleanup path then goes like this (from a hacked error in device_add):=0A=
>>    dump_stack+0xdc/0x144=0A=
>>   =0A=
>>=0A=
>>    devfreq_dev_release+0x38/0xc0=0A=
>>   =0A=
>>=0A=
>>    device_release+0x34/0x90=0A=
>>   =0A=
>>=0A=
>>    kobject_put+0x8c/0x1f0=0A=
>>   =0A=
>>=0A=
>>    put_device+0x24/0x30=0A=
>>   =0A=
>>=0A=
>>    devfreq_add_device+0x540/0x570=0A=
>>   =0A=
>>=0A=
>>    devm_devfreq_add_device+0x60/0xd0=0A=
>>   =0A=
>>=0A=
>>    imx_ddrc_probe+0x35c/0x4c8=0A=
> =0A=
> Good to know, thanks for the pointer!=0A=
> =0A=
>> Can I add your "Reviewed-By" for the rest of the series if I fix the nit=
s?=0A=
> =0A=
> By now you should have it for most patches. For this one:=0A=
> =0A=
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>=0A=
> =0A=
> There is one doubt I have left on "PM / devfreq: Add PM QoS support" that=
 I=0A=
> posted on v5:=0A=
> =0A=
> "IIUC you rely on the notifiers being removed by devfreq_dev_release().=
=0A=
> Does dev_pm_qos_remove_notifier() behave gracefully if the notifier is=0A=
> not initialized/added or do we need to use BLOCKING_NOTIFIER_INIT() or=0A=
> similar?"=0A=
=0A=
Sorry for missing that.=0A=
> Could you clarify this replying to the thread? Besides that and the=0A=
> nits (which are optional to fix) the patch looks good to me.=0A=
=0A=
The blocking_notifier_head structs are managed by PM QoS inside =0A=
dev_pm_qos_constraints_allocate and dev_pm_qos_constraints_destroy. The =0A=
devfreq subsystem only registers a notifier_block, that's a =0A=
NULL-terminated singly-linked list for which zero-initialization from =0A=
kzalloc should be sufficient.=0A=
=0A=
But now that I look at this again I should warn and return NOTIFY_DONE =0A=
from devfreq_qos_notifier_call instead of propagating a negative errno.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
