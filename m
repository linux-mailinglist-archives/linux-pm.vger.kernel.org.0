Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09A9913AE6B
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2020 17:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgANQIn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jan 2020 11:08:43 -0500
Received: from mail-eopbgr50084.outbound.protection.outlook.com ([40.107.5.84]:14244
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725904AbgANQIm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Jan 2020 11:08:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/zd51ia640Tfp0MMqoS3vcGEEV1QLad+KNhBn1MO44mdb6AFNmhodfzSe8zqo+lvmVjorMmVYZJseJyXnPSMeHSdNcdHUXxzS3ywdYppiYEp4pUFdsjD+bItfVV2ebtHdaoX7qwLLdRKyo+t5M3NWOAgVx0PeA4NfzM2za183iO3M6VmBISMy4Qhm+MRT9UtM2tsXcxPDxdnh91vQ2qnp3InuJlW2LOk6jrC0jxv03pZj//BoA8umArrV/OFEHQyx+Xg8ivcRxsJShUV7j+qzy8OhLXw2vrqnBPw1U70jdwI27zQisbcMRzcSt+Q6w10kelCOW6SRE7P8N8dczDow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVhhZozBGEFP+R0qHiSbAHb3dZjqdAb9bO1/gfmqwGM=;
 b=iFdcDfSvAq6tQhzXfIb7MEmTgwRt3tOL0UDhsjQjS7SLo/bBhC5HYSkr2fo8NNcoSgzVYsUJZsSrcZXi9W1xgif066kLn8XqIWLq2AcTIPSSo5+HtbxzK56D6IWhXkDZHzckht9mUoSUbFZCq5keGwAks17Lsgzk7qdGO9wbXV6D+w4i5uD7xgzqNNFKVkZQNerSs837vxej8CcJEpXgeY9fojjFARHH4wljSViSD5p1ql+xhv/+MwbHwyeE8QEko7hj0uZ1yt8DlhKpZu/BIh/doU+eILpS66BGXluHXI2vprKSLqKYa3K7uXR+UbVo4aOS7wD+FBCmPLf325cqDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVhhZozBGEFP+R0qHiSbAHb3dZjqdAb9bO1/gfmqwGM=;
 b=D/kPgnNDDhevrgAQbaLOISVpE8fs9KxYduaPY8z2R76ULie+xFbI3g1aizx7sfRKzv86SC/GJayLUyPQDySKudU/caLpSsivhk3iDYo/ZoTCJyJxP1dZceNQ82yxdytDSSEDDrcqHP2gVa3MX8RVvZiZdiqGVUg1fphdFsaLdfE=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB3149.eurprd04.prod.outlook.com (10.170.229.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Tue, 14 Jan 2020 16:08:38 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::58c5:f02f:2211:4953]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::58c5:f02f:2211:4953%7]) with mapi id 15.20.2623.017; Tue, 14 Jan 2020
 16:08:38 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
CC:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] thermal: devfreq_cooling: Use PM QoS to set frequency
 limits
Thread-Topic: [PATCH 1/2] thermal: devfreq_cooling: Use PM QoS to set
 frequency limits
Thread-Index: AQHVx95NFadO4WGfQUyi2pcSmj7HoQ==
Date:   Tue, 14 Jan 2020 16:08:38 +0000
Message-ID: <VI1PR04MB70233705094CCA4BA7545CF0EE340@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <20200110094913.1.I146403d05b9ec82f48b807efd416a57f545b447a@changeid>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eb0f6c14-3abc-48df-f682-08d7990c0443
x-ms-traffictypediagnostic: VI1PR04MB3149:
x-microsoft-antispam-prvs: <VI1PR04MB3149AA65941AE69CE5206F8BEE340@VI1PR04MB3149.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:635;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(189003)(199004)(26005)(33656002)(2906002)(186003)(71200400001)(44832011)(53546011)(110136005)(7696005)(6506007)(54906003)(478600001)(7416002)(66476007)(9686003)(81156014)(81166006)(316002)(4326008)(64756008)(55016002)(8936002)(66446008)(5660300002)(86362001)(52536014)(66946007)(76116006)(66556008)(8676002)(91956017);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3149;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WUEWKLdc6+JGRkNLwXMImJoAJuG7OKxrF70p0skuet0+IoEZo+VsEmkjzfW/55vmU3yom8HCDDfsroDK8Y9UcSOZMySC6OZU8X9UEhRtfR4hXDZETuXrMW05KbKnCBNssF1anxKBivCMzNvJybrZ3wtVD7/c72P4cjXKIwMoMqEocY9bKwLT1BjFcfNCKzLac3jbjElyxPmMUjuCn9/SLqfofDbI5e1ZOLGl/+bj9XD27i1LstI0BYkUCmOUhn6+bqyM3G71ZRR5Z4emqnGPzjeKB/CL2knEeByp9YVjEUA+693mlZeCTQx7upd44PTX0cmEJJ4nw2hG7LhL27DlBrBMxlWpaY+cbrm+g7q6sgNSq1sw8Topi4vTIf3/xvZRu/mMvaOw5Hdtj6p2XgwjOJLVeAfWeW9ENiTmtE+0DfgmGtcyR+lIK5b3BZh9+NhN
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0f6c14-3abc-48df-f682-08d7990c0443
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 16:08:38.5299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OkIkVQq4vXLOc62u82HfsaTUtbhjBUYDdzFbUE47HFtc2/cwT7pKyo98SX/23ke1Osa0jcqMZ/ASCDOpnM0DAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3149
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10.01.2020 19:49, Matthias Kaehlcke wrote:=0A=
> Now that devfreq supports limiting the frequency range of a device=0A=
> through PM QoS make use of it instead of disabling OPPs that should=0A=
> not be used.=0A=
> =0A=
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>=0A=
> ---=0A=
=0A=
It is not obvious but this changes behavior when min max requests =0A=
conflict (min > max): with PM QoS a MIN_FREQUENCY request takes =0A=
precedence but if higher OPPs are disabled then this will override =0A=
MIN_FREQUENCY.=0A=
=0A=
There are very few users of this functionality so I don't think there =0A=
are any systems that depend on this behaving one way or the other but =0A=
perhaps it should be mentioned in commit message?=0A=
=0A=
As far as I can tell the only user of devfreq_cooling in upstream is =0A=
drivers/gpu/drm/panfrost?=0A=
=0A=
>   drivers/thermal/devfreq_cooling.c | 66 ++++++++++---------------------=
=0A=
>   1 file changed, 20 insertions(+), 46 deletions(-)=0A=
> =0A=
> diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_=
cooling.c=0A=
> index ef59256887ff..3a63603afcf2 100644=0A=
> --- a/drivers/thermal/devfreq_cooling.c=0A=
> +++ b/drivers/thermal/devfreq_cooling.c=0A=
> @@ -24,11 +24,13 @@=0A=
>   #include <linux/idr.h>=0A=
>   #include <linux/slab.h>=0A=
>   #include <linux/pm_opp.h>=0A=
> +#include <linux/pm_qos.h>=0A=
>   #include <linux/thermal.h>=0A=
>   =0A=
>   #include <trace/events/thermal.h>=0A=
>   =0A=
> -#define SCALE_ERROR_MITIGATION 100=0A=
> +#define HZ_PER_KHZ		1000=0A=
> +#define SCALE_ERROR_MITIGATION	100=0A=
>   =0A=
>   static DEFINE_IDA(devfreq_ida);=0A=
>   =0A=
> @@ -65,49 +67,9 @@ struct devfreq_cooling_device {=0A=
>   	struct devfreq_cooling_power *power_ops;=0A=
>   	u32 res_util;=0A=
>   	int capped_state;=0A=
> +	struct dev_pm_qos_request req_max_freq;=0A=
>   };=0A=
>   =0A=
> -/**=0A=
> - * partition_enable_opps() - disable all opps above a given state=0A=
> - * @dfc:	Pointer to devfreq we are operating on=0A=
> - * @cdev_state:	cooling device state we're setting=0A=
> - *=0A=
> - * Go through the OPPs of the device, enabling all OPPs until=0A=
> - * @cdev_state and disabling those frequencies above it.=0A=
> - */=0A=
> -static int partition_enable_opps(struct devfreq_cooling_device *dfc,=0A=
> -				 unsigned long cdev_state)=0A=
> -{=0A=
> -	int i;=0A=
> -	struct device *dev =3D dfc->devfreq->dev.parent;=0A=
> -=0A=
> -	for (i =3D 0; i < dfc->freq_table_size; i++) {=0A=
> -		struct dev_pm_opp *opp;=0A=
> -		int ret =3D 0;=0A=
> -		unsigned int freq =3D dfc->freq_table[i];=0A=
> -		bool want_enable =3D i >=3D cdev_state ? true : false;=0A=
> -=0A=
> -		opp =3D dev_pm_opp_find_freq_exact(dev, freq, !want_enable);=0A=
> -=0A=
> -		if (PTR_ERR(opp) =3D=3D -ERANGE)=0A=
> -			continue;=0A=
> -		else if (IS_ERR(opp))=0A=
> -			return PTR_ERR(opp);=0A=
> -=0A=
> -		dev_pm_opp_put(opp);=0A=
> -=0A=
> -		if (want_enable)=0A=
> -			ret =3D dev_pm_opp_enable(dev, freq);=0A=
> -		else=0A=
> -			ret =3D dev_pm_opp_disable(dev, freq);=0A=
> -=0A=
> -		if (ret)=0A=
> -			return ret;=0A=
> -	}=0A=
> -=0A=
> -	return 0;=0A=
> -}=0A=
> -=0A=
>   static int devfreq_cooling_get_max_state(struct thermal_cooling_device =
*cdev,=0A=
>   					 unsigned long *state)=0A=
>   {=0A=
> @@ -134,7 +96,7 @@ static int devfreq_cooling_set_cur_state(struct therma=
l_cooling_device *cdev,=0A=
>   	struct devfreq_cooling_device *dfc =3D cdev->devdata;=0A=
>   	struct devfreq *df =3D dfc->devfreq;=0A=
>   	struct device *dev =3D df->dev.parent;=0A=
> -	int ret;=0A=
> +	unsigned long freq;=0A=
>   =0A=
>   	if (state =3D=3D dfc->cooling_state)=0A=
>   		return 0;=0A=
> @@ -144,9 +106,10 @@ static int devfreq_cooling_set_cur_state(struct ther=
mal_cooling_device *cdev,=0A=
>   	if (state >=3D dfc->freq_table_size)=0A=
>   		return -EINVAL;=0A=
>   =0A=
> -	ret =3D partition_enable_opps(dfc, state);=0A=
> -	if (ret)=0A=
> -		return ret;=0A=
> +	freq =3D dfc->freq_table[state];=0A=
> +=0A=
> +	dev_pm_qos_update_request(&dfc->req_max_freq,=0A=
> +				  DIV_ROUND_UP(freq, HZ_PER_KHZ));=0A=
>   =0A=
>   	dfc->cooling_state =3D state;=0A=
>   =0A=
> @@ -529,6 +492,12 @@ of_devfreq_cooling_register_power(struct device_node=
 *np, struct devfreq *df,=0A=
>   	if (err)=0A=
>   		goto free_dfc;=0A=
>   =0A=
> +	err =3D dev_pm_qos_add_request(df->dev.parent, &dfc->req_max_freq,=0A=
> +				     DEV_PM_QOS_MAX_FREQUENCY,=0A=
> +				     PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);=0A=
> +	if (err < 0)=0A=
> +		goto remove_qos_req;=0A=
> +=0A=
>   	err =3D ida_simple_get(&devfreq_ida, 0, 0, GFP_KERNEL);=0A=
>   	if (err < 0)=0A=
>   		goto free_tables;=0A=
> @@ -552,6 +521,10 @@ of_devfreq_cooling_register_power(struct device_node=
 *np, struct devfreq *df,=0A=
>   =0A=
>   release_ida:=0A=
>   	ida_simple_remove(&devfreq_ida, dfc->id);=0A=
> +=0A=
> +remove_qos_req:=0A=
> +	dev_pm_qos_remove_request(&dfc->req_max_freq); > +=0A=
=0A=
A quirk of the dev_pm_qos API is that dev_pm_qos_remove_request prints a =
=0A=
WARN splat if !dev_pm_qos_request_active and this can true on =0A=
dev_pm_qos_add_request error.=0A=
=0A=
I dealt with this by checking dev_pm_qos_request_active explicitly but =0A=
perhaps dev_pm_qos API could be changed? In general "free/release" =0A=
functions shouldn't complain if there's nothing to do.=0A=
=0A=
>   free_tables:=0A=
>   	kfree(dfc->power_table);=0A=
>   	kfree(dfc->freq_table);=0A=
> @@ -600,6 +573,7 @@ void devfreq_cooling_unregister(struct thermal_coolin=
g_device *cdev)=0A=
>   =0A=
>   	thermal_cooling_device_unregister(dfc->cdev);=0A=
>   	ida_simple_remove(&devfreq_ida, dfc->id);=0A=
> +	dev_pm_qos_remove_request(&dfc->req_max_freq);=0A=
>   	kfree(dfc->power_table);=0A=
>   	kfree(dfc->freq_table);=0A=
