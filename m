Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09DECCAF09
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2019 21:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbfJCTQr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Oct 2019 15:16:47 -0400
Received: from mail-eopbgr20040.outbound.protection.outlook.com ([40.107.2.40]:55071
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729264AbfJCTQq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 3 Oct 2019 15:16:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4rq2puuBCE70phnSNAi2GJ3kcSZCUIM8XtfsVSUle2Ty04FvaNFO6CvPw/V7d38VOlZHUP0lWdSDhEbsBk262Ty/De9+ZKjwcfgNPqXbzDJMBl5bkxN2F10hp/R6dJUyZ1VN+/RnF52xkYAHqn0wERl/2iCm2cHYd9+iE/YmpKv8Z5/Kb7nKWCcSyknm1rjSEb/85PGhaqGwXoE2LedSKrcFnW0XHsCSzF6kSfYI/QV+b7kG9V/0V0iQx7L9ZXs+6ZidkukGPZr2pEu1VCCIAL3CGAN1t7DMVusyU8jBwjQnYE5MWpn+8OZVQVFRLCb5LSuWSeR+MBFCnkf5NYisA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Mk3oCoJwAwCNTrVSrKy4rpMD5e/bvEKzbz5afmQpgc=;
 b=liNIXhVOC8ZVR0fycG9s49Qqr0Da01zc+Bs7ZGoYWVrHDzFL8gFdVzZQBSWz1vC/JJ+XKz62T+DajyWOkq1QMqNLdQHIil4TfaryklhFjds/pj3gY+pIdn1ww3JLSb/s42MPpoc8Nho7FAs1zVJwK1UMjAoC3OFGDimOxH0xVVPeuUz3cBeszOA+rVLmNuVvyv6KNXUlQxmAxgVRTYgDDxDonM5YI9eN/bVv5yXZ39SIQL+O9sS6iWGQ9rDlqXrhpL/MmVsBOkYUf4GVO+cYaJfHULjDnkZufDoOcrIrfzq73+dTlYVm4EyN3oUuyH4XlrDSqMjTfLOJzsrah++vZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Mk3oCoJwAwCNTrVSrKy4rpMD5e/bvEKzbz5afmQpgc=;
 b=CxYDteC0pZ98wb2pNgbJXQtP8LjWupQ0fjH3thfoVylLZngbiWD/v3T4quNdS21HkxDUbOEHKxiOO9hfaG2fZml939n+gavgZdFuITsTOAhh8ecjj0fX60il8eyFIJhOYLnJx2ro+GAnIZKhFw2MsJ3al/x70SjIv8hGpPcqeJw=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB7040.eurprd04.prod.outlook.com (10.186.156.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Thu, 3 Oct 2019 19:16:03 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2ce6:267:b2a6:9902]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2ce6:267:b2a6:9902%2]) with mapi id 15.20.2305.023; Thu, 3 Oct 2019
 19:16:03 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Saravana Kannan <saravanak@google.com>
CC:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v9 6/8] PM / devfreq: Introduce get_freq_range helper
Thread-Topic: [PATCH v9 6/8] PM / devfreq: Introduce get_freq_range helper
Thread-Index: AQHVeVcjG1LoKlXGikmvzB33amMNOQ==
Date:   Thu, 3 Oct 2019 19:16:03 +0000
Message-ID: <VI1PR04MB7023F76F9C7BA20CE54058BEEE9F0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1570044052.git.leonard.crestez@nxp.com>
 <c453bb60a74b41a5192e270f286dfc81c1088449.1570044052.git.leonard.crestez@nxp.com>
 <20191003181938.GJ87296@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe206d1e-5bd1-4e87-e03c-08d748362248
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR04MB7040:|VI1PR04MB7040:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB704040284D82B002F7441D40EE9F0@VI1PR04MB7040.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01792087B6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(189003)(199004)(74316002)(4326008)(316002)(6246003)(9686003)(305945005)(102836004)(26005)(7736002)(55016002)(110136005)(54906003)(64756008)(91956017)(66476007)(66556008)(76116006)(6506007)(6436002)(66946007)(53546011)(7416002)(52536014)(5660300002)(76176011)(446003)(229853002)(44832011)(99286004)(186003)(476003)(7696005)(66446008)(486006)(71200400001)(71190400001)(66066001)(6116002)(25786009)(33656002)(3846002)(478600001)(14454004)(14444005)(8936002)(86362001)(2906002)(256004)(8676002)(81156014)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB7040;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E/pgVl0ZAJWlvJn2ZIo7idQJlFuqU6TnyrxA9mbRTEBn1PK1jKc2KrFJ8wsyK985izbCgR3/Jc5uly6kXMVd54K9VSLlJhMgDvtDx51XmRyY8glTX7lAZwBCoO3I9zrEF9fmA7OfU+V60YcSeN8vmaiKOtps2urwEXDCDpaK0TevJ5QUo7AjdIZV+VlWKAt7vKbl1uI/8S57QKkQ5LflV5Z+JFA7uiGCBWVYlpMXcoJkGQ62W9b5xQElVw38Js8ITIoMpnp/eFiYH6c+NpuJNhxGN17bNYLy/Mo3XBGpxZOoZ9v+B6Vq++Dvm5dvN1nWDy3z6HV0oKCuLDFib3VLwOYGqq2sZQfykrdy6VwcVsBrP0GS6GsJ3wwPWCJfld8P3Lg9+yvAwNIZCCxZpvQ/kiPrNVPM8RX8eSvOwa0iG0g=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe206d1e-5bd1-4e87-e03c-08d748362248
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2019 19:16:03.4958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 85ew5d0vuXUPsBAlCNNSV8tXUjjdjVK7/prTdL/EbvG38XUXklx0vBRHgVv5sapxt7Dv/9fQzOESOAYt6QJ1fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7040
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03.10.2019 21:19, Matthias Kaehlcke wrote:=0A=
> On Wed, Oct 02, 2019 at 10:25:09PM +0300, Leonard Crestez wrote:=0A=
>> Moving handling of min/max freq to a single function and call it from=0A=
>> update_devfreq and for printing min/max freq values in sysfs.=0A=
>>=0A=
>> This changes the behavior of out-of-range min_freq/max_freq: clamping=0A=
>> is now done at evaluation time. This means that if an out-of-range=0A=
>> constraint is imposed by sysfs and it later becomes valid then it will=
=0A=
>> be enforced.=0A=
>>=0A=
>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>=0A=
>> ---=0A=
>>   drivers/devfreq/devfreq.c | 110 +++++++++++++++++++++-----------------=
=0A=
>>   1 file changed, 62 insertions(+), 48 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c=0A=
>> index 87eff789ce24..2d63692903ff 100644=0A=
>> --- a/drivers/devfreq/devfreq.c=0A=
>> +++ b/drivers/devfreq/devfreq.c=0A=
>>=0A=
>> ...=0A=
>>=0A=
>>   static ssize_t min_freq_show(struct device *dev, struct device_attribu=
te *attr,=0A=
>>   			     char *buf)=0A=
>>   {=0A=
>>   	struct devfreq *df =3D to_devfreq(dev);=0A=
>> +	unsigned long min_freq, max_freq;=0A=
>>   =0A=
>> -	return sprintf(buf, "%lu\n", max(df->scaling_min_freq, df->min_freq));=
=0A=
>> +	mutex_lock(&df->lock);=0A=
>> +	get_freq_range(df, &min_freq, &max_freq);=0A=
> =0A=
> With this min/max_freq shown aren't necessarily those set through sysfs,=
=0A=
> but the aggregated PM QoS values (plus OPP constraints).=0A=
> =0A=
> I did some testing with a WIP patch that converts devfreq_cooling.c to=0A=
> PM QoS. When reading sysfs min/max values to double check the limits=0A=
> set earlier I found it utterly confusing to see the sysfs min/max values=
=0A=
> fluctuating due to thermal throttling, and not being able to see the=0A=
> configured values.=0A=
=0A=
Isn't current devfreq_cooling based on OPP disabling which modifies =0A=
scaling_max_freq? This is not a behavior change: reading back always =0A=
showed the "effective maximum" rather than the value explicitly written =0A=
to max_freq.=0A=
=0A=
This behavior is indeed confusing but can be fixed by adding two new =0A=
files: user_min/max_freq and user_max_freq. These would act like current =
=0A=
min/max_freq on write but on read would only show the value explicitly =0A=
configured by the user.=0A=
=0A=
> Looks like cpufreq does the same, but I'm not convinced this is a good=0A=
> idea. I think we want to display the values set by userspace, as done=0A=
> before managing the limits through PM QoS. Viresh, was this change of=0A=
> userspace visible behavior done intentionally for cpufreq?=0A=
