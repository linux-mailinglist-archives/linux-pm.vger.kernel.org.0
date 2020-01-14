Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0720413AE67
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2020 17:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgANQIR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jan 2020 11:08:17 -0500
Received: from mail-eopbgr50047.outbound.protection.outlook.com ([40.107.5.47]:24067
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725904AbgANQIR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Jan 2020 11:08:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEVQRnc9AdfSDULcY23y+z3ddjVE8CKRI/0PuF6vSRexDxj/ErPLsppe+k1H4WzQmty0lml6VmGc5kfjWOiyNZOTuP2WoQG0CORfzP/OZUOshyhyX6q0eNje+0V82dcHB+T8DHiqAnVvdF1imiH4H5SJ+qSZ1r/uvo8B2TTQct2MgJuSE1+E1rwhVE9nNdsiSEvc6mY//HHWIGkO1zlUiO16dbrM8nrD4hAaJE2O7BTrWs4Tm5H4HMEvEgL2fS8Hw2vBVPi+bOlgdC7NP57YfyZRiE6Tp5LuLA9GGhfz/XdKujWSfEy8ImabVueba4bOUCKA0sM1pZf0DZg9ti1LSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EW5HEcM9fy/AWI6W4AYmEQxPitjMm3s7gafFACV1wtk=;
 b=GbehdEnPD3uvXCrDKl2T+hy7aXHFOzV08TdFwQVgFHuQfB7ofBJwiDT9fKg76m7VXE7dntPrVGCybUJHispSQFLQk3LNNMI7q/gtOuct5dqKpHmmb7wkFBd8TpC51Wx5adLWGxB/DljiwKLNbVJ9hLpU3Y7Vtv4By2LgWxRGdW3ykODW53wLvm2PELbA8z0DOis8o8MrsM/A1BlQ0YNdUzEUTiGclYxCqOXIdhrIXa4/SA5lGKsepQHxatjev7gWfrOQ1qmLDsTDg1thwts12IDD36wfFtGnK0wR6ybuuHZOz1D4fVeqIL9D2jRROdKoWQ+y2d+eKZ/PjV9KLwbOLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EW5HEcM9fy/AWI6W4AYmEQxPitjMm3s7gafFACV1wtk=;
 b=p5rA0+J8LbQCGBJnPUkarmrNtbNVfCdOlusz+B3IHPnbIVn6ug80B9XrnWGZJ0kUEz4KOldkXo2LaYmQrwwyal3vrURDQugxxt7is0hGU3SmQ4VZ4cbEcWXdTQTXI5ZZuxa4lLShO2gymOGngW3qKO5bM7RjC54Mcu952e/mqPA=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5472.eurprd04.prod.outlook.com (20.178.122.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Tue, 14 Jan 2020 16:08:12 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::58c5:f02f:2211:4953]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::58c5:f02f:2211:4953%7]) with mapi id 15.20.2623.017; Tue, 14 Jan 2020
 16:08:12 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/2] PM / devfreq: Use exclusively PM QoS to determine
 frequency limits
Thread-Topic: [PATCH 2/2] PM / devfreq: Use exclusively PM QoS to determine
 frequency limits
Thread-Index: AQHVx95Oo8Zzm3lRTk2yNfld8Mz1Kg==
Date:   Tue, 14 Jan 2020 16:08:11 +0000
Message-ID: <VI1PR04MB702308C23513581F33EFE697EE340@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <20200110094913.1.I146403d05b9ec82f48b807efd416a57f545b447a@changeid>
 <CGME20200110174932epcas1p345b0e750b48cc9e351dca14e0dd4de86@epcas1p3.samsung.com>
 <20200110094913.2.Ie8eacf976ce7a13e421592f5c1ab8dbdc537da5c@changeid>
 <c793c2e5-dd0e-bff4-9769-26344afe914e@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3e651e2b-9786-4e7d-eb82-08d7990bf471
x-ms-traffictypediagnostic: VI1PR04MB5472:
x-microsoft-antispam-prvs: <VI1PR04MB5472446C5A4667C150CCFAC8EE340@VI1PR04MB5472.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(199004)(189003)(44832011)(52536014)(478600001)(8936002)(86362001)(7696005)(71200400001)(54906003)(186003)(66476007)(91956017)(9686003)(66446008)(4326008)(5660300002)(66556008)(55016002)(76116006)(66946007)(64756008)(8676002)(26005)(6506007)(53546011)(2906002)(316002)(33656002)(7416002)(110136005)(81166006)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5472;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6AoqZZCOnKBHaVIZ2ZZIlGgxoaEV232gMI91vezdIkDAYQozRlkiGZp77fR/jrhMjhO7wqJUNHt+zPlelN8VvxL0mp3SXN10mcOmeVhziSfDZj/16Ib2y1JFrQp47F488AKcb+dPKJ3oyIpYk4WHzIOrFnRcBWNRg3/UVYrf7k4omlOjkaXbcDkJdzQ5ex2CLXqmL6MiMLdBuwvrqyZ3sihrdljlAfDT4hC57lor8MwdrsizgUVrBlewAqjExHoA5BK2yqvO42fc0i9c7KAVpDv8Za87BTSyKd8BvRK8JujPwQQ8qCyu1LUR9QBFMTt3AaLQUii7wCwuya2ED4OnYkNEEdFDbQ3exOEylgNJkAQZkKRi/yUnuBLbNA9eINBj7+GlrLYr9QPJP+LN8ldO93s0TvFq/SuqMnAC27Y0xxr8edLRIg1j+fStazV34oaN
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e651e2b-9786-4e7d-eb82-08d7990bf471
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 16:08:11.9985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Em3J6l/nczxqDv/pOmEpWHB413Ip63mMohww6jb9b65vq1C4AId7spb92ufsw+fOc1P15eM2tM2k2ibfudUj/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5472
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13.01.2020 09:24, Chanwoo Choi wrote:=0A=
> Hi,=0A=
> =0A=
> Any device driver except for devfreq_cooling.c might=0A=
> use dev_pm_opp_enable/disable interface.=0A=
> So, don't need to remove the devfreq->scaling_max_freq=0A=
> and devfreq->scaling_min_freq for supporting OPP interface.=0A=
=0A=
It seems that devfreq_cooling was the only upstream user of =0A=
dev_pm_opp_enable and the remaining callers of dev_pm_opp_disable are =0A=
probe-time checks.=0A=
=0A=
> Regards,=0A=
> Chanwoo Choi=0A=
> =0A=
> On 1/11/20 2:49 AM, Matthias Kaehlcke wrote:=0A=
>> Traditionally devfreq cooling devices dynamically disabled OPPs=0A=
>> that shouldn't be used because of thermal pressure. Devfreq cooling=0A=
>> devices now use PM QoS to set frequency limits, hence the devfreq=0A=
>> code dealing that deals with disabled OPPs can be removed.=0A=
>>=0A=
>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>=0A=
>> ---=0A=
>>=0A=
>>   drivers/devfreq/devfreq.c | 75 +++++----------------------------------=
=0A=
>>   include/linux/devfreq.h   |  4 ---=0A=
>>   2 files changed, 8 insertions(+), 71 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c=0A=
>> index 57f6944d65a6..ec66e2c27cc4 100644=0A=
>> --- a/drivers/devfreq/devfreq.c=0A=
>> +++ b/drivers/devfreq/devfreq.c=0A=
>> @@ -73,34 +73,6 @@ static struct devfreq *find_device_devfreq(struct dev=
ice *dev)=0A=
>>   	return ERR_PTR(-ENODEV);=0A=
>>   }=0A=
>>   =0A=
>> -static unsigned long find_available_min_freq(struct devfreq *devfreq)=
=0A=
>> -{=0A=
>> -	struct dev_pm_opp *opp;=0A=
>> -	unsigned long min_freq =3D 0;=0A=
>> -=0A=
>> -	opp =3D dev_pm_opp_find_freq_ceil(devfreq->dev.parent, &min_freq);=0A=
>> -	if (IS_ERR(opp))=0A=
>> -		min_freq =3D 0;=0A=
>> -	else=0A=
>> -		dev_pm_opp_put(opp);=0A=
>> -=0A=
>> -	return min_freq;=0A=
>> -}=0A=
>> -=0A=
>> -static unsigned long find_available_max_freq(struct devfreq *devfreq)=
=0A=
>> -{=0A=
>> -	struct dev_pm_opp *opp;=0A=
>> -	unsigned long max_freq =3D ULONG_MAX;=0A=
>> -=0A=
>> -	opp =3D dev_pm_opp_find_freq_floor(devfreq->dev.parent, &max_freq);=0A=
>> -	if (IS_ERR(opp))=0A=
>> -		max_freq =3D 0;=0A=
>> -	else=0A=
>> -		dev_pm_opp_put(opp);=0A=
>> -=0A=
>> -	return max_freq;=0A=
>> -}=0A=
>> -=0A=
>>   /**=0A=
>>    * get_freq_range() - Get the current freq range=0A=
>>    * @devfreq:	the devfreq instance=0A=
>> @@ -141,10 +113,6 @@ static void get_freq_range(struct devfreq *devfreq,=
=0A=
>>   		*max_freq =3D min(*max_freq,=0A=
>>   				(unsigned long)HZ_PER_KHZ * qos_max_freq);=0A=
>>   =0A=
>> -	/* Apply constraints from OPP interface */=0A=
>> -	*min_freq =3D max(*min_freq, devfreq->scaling_min_freq);=0A=
>> -	*max_freq =3D min(*max_freq, devfreq->scaling_max_freq);=0A=
>> -=0A=
>>   	if (*min_freq > *max_freq)=0A=
>>   		*min_freq =3D *max_freq;=0A=
>>   }=0A=
>> @@ -610,23 +578,10 @@ static int devfreq_notifier_call(struct notifier_b=
lock *nb, unsigned long type,=0A=
>>   				 void *devp)=0A=
>>   {=0A=
>>   	struct devfreq *devfreq =3D container_of(nb, struct devfreq, nb);=0A=
>> -	int err =3D -EINVAL;=0A=
>> +	int err;=0A=
>>   =0A=
>>   	mutex_lock(&devfreq->lock);=0A=
>> -=0A=
>> -	devfreq->scaling_min_freq =3D find_available_min_freq(devfreq);=0A=
>> -	if (!devfreq->scaling_min_freq)=0A=
>> -		goto out;=0A=
>> -=0A=
>> -	devfreq->scaling_max_freq =3D find_available_max_freq(devfreq);=0A=
>> -	if (!devfreq->scaling_max_freq) {=0A=
>> -		devfreq->scaling_max_freq =3D ULONG_MAX;=0A=
>> -		goto out;=0A=
>> -	}=0A=
>> -=0A=
>>   	err =3D update_devfreq(devfreq);=0A=
>> -=0A=
>> -out:=0A=
>>   	mutex_unlock(&devfreq->lock);=0A=
>>   	if (err)=0A=
>>   		dev_err(devfreq->dev.parent,=0A=
>> @@ -781,19 +736,15 @@ struct devfreq *devfreq_add_device(struct device *=
dev,=0A=
>>   		mutex_lock(&devfreq->lock);=0A=
>>   	}=0A=
>>   =0A=
>> -	devfreq->scaling_min_freq =3D find_available_min_freq(devfreq);=0A=
>> -	if (!devfreq->scaling_min_freq) {=0A=
>> -		mutex_unlock(&devfreq->lock);=0A=
>> -		err =3D -EINVAL;=0A=
>> +	err =3D dev_pm_qos_add_request(dev, &devfreq->user_min_freq_req,=0A=
>> +				     DEV_PM_QOS_MIN_FREQUENCY, 0);=0A=
>> +	if (err < 0)=0A=
>>   		goto err_dev;=0A=
>> -	}=0A=
>> -=0A=
>> -	devfreq->scaling_max_freq =3D find_available_max_freq(devfreq);=0A=
>> -	if (!devfreq->scaling_max_freq) {=0A=
>> -		mutex_unlock(&devfreq->lock);=0A=
>> -		err =3D -EINVAL;=0A=
>> +	err =3D dev_pm_qos_add_request(dev, &devfreq->user_max_freq_req,=0A=
>> +				     DEV_PM_QOS_MAX_FREQUENCY,=0A=
>> +				     PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);=0A=
>> +	if (err < 0)=0A=
>>   		goto err_dev;=0A=
>> -	}=0A=
>>   =0A=
>>   	devfreq->suspend_freq =3D dev_pm_opp_get_suspend_opp_freq(dev);=0A=
>>   	atomic_set(&devfreq->suspend_count, 0);=0A=
>> @@ -834,16 +785,6 @@ struct devfreq *devfreq_add_device(struct device *d=
ev,=0A=
>>   =0A=
>>   	mutex_unlock(&devfreq->lock);=0A=
>>   =0A=
>> -	err =3D dev_pm_qos_add_request(dev, &devfreq->user_min_freq_req,=0A=
>> -				     DEV_PM_QOS_MIN_FREQUENCY, 0);=0A=
>> -	if (err < 0)=0A=
>> -		goto err_devfreq;=0A=
>> -	err =3D dev_pm_qos_add_request(dev, &devfreq->user_max_freq_req,=0A=
>> -				     DEV_PM_QOS_MAX_FREQUENCY,=0A=
>> -				     PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);=0A=
>> -	if (err < 0)=0A=
>> -		goto err_devfreq;=0A=
>> -=0A=
=0A=
Performing PM QoS initialization under devfreq->lock triggers lockdep =0A=
warnings for me. The warnings seem to be legitimate:=0A=
=0A=
1) At init time &dev_pm_qos_mtx is taken under &devfreq->lock;=0A=
2) At update time &devfreq->lock is called under &dev_pm_qos_mtx (it's =0A=
held while notifiers are called).=0A=
=0A=
It's not clear why you moved dev_pm_qos_add_request higher?=0A=
=0A=
>>   	devfreq->nb_min.notifier_call =3D qos_min_notifier_call;=0A=
>>   	err =3D dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_min=
,=0A=
>>   				      DEV_PM_QOS_MIN_FREQUENCY);=0A=
>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h=0A=
>> index fb376b5b7281..cb75f23ad2f4 100644=0A=
>> --- a/include/linux/devfreq.h=0A=
>> +++ b/include/linux/devfreq.h=0A=
>> @@ -126,8 +126,6 @@ struct devfreq_dev_profile {=0A=
>>    *		touch this.=0A=
>>    * @user_min_freq_req:	PM QoS minimum frequency request from user (via=
 sysfs)=0A=
>>    * @user_max_freq_req:	PM QoS maximum frequency request from user (via=
 sysfs)=0A=
>> - * @scaling_min_freq:	Limit minimum frequency requested by OPP interfac=
e=0A=
>> - * @scaling_max_freq:	Limit maximum frequency requested by OPP interfac=
e=0A=
>>    * @stop_polling:	 devfreq polling status of a device.=0A=
>>    * @suspend_freq:	 frequency of a device set during suspend phase.=0A=
>>    * @resume_freq:	 frequency of a device set in resume phase.=0A=
>> @@ -166,8 +164,6 @@ struct devfreq {=0A=
>>   =0A=
>>   	struct dev_pm_qos_request user_min_freq_req;=0A=
>>   	struct dev_pm_qos_request user_max_freq_req;=0A=
>> -	unsigned long scaling_min_freq;=0A=
>> -	unsigned long scaling_max_freq;=0A=
>>   	bool stop_polling;=0A=
>>   =0A=
>>   	unsigned long suspend_freq;=0A=
>>=0A=
> =0A=
=0A=
