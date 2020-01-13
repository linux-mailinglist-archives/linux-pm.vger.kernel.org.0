Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 833D11398BB
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2020 19:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgAMSS2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jan 2020 13:18:28 -0500
Received: from mail-am6eur05on2041.outbound.protection.outlook.com ([40.107.22.41]:35169
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728633AbgAMSS2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Jan 2020 13:18:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anVwJm5vKWFwke9m0ymsoPGUT6mH4Ps25K+WRuQQSiHXB9Kv3jqrjl7FrdXAs+FKRD1WSaNZd/SXG24FxwlX7iRUWRe2Tf2L5hIe8tEnFvjj+tZmDpChxinLsZbJdKYIoWk7y7UvVSdN8h9X6b7z3sFywU68/+0TkliF76HcyBJbZQkPipa/egDlohhlsboQ+7Lon3N2upNQQC0eEN7aC8q2v3wKQb5XBSGTFsC66RjsxIBzVcX+tonkC82sHE9na0Cp3DnvCd6rgamh1sDfwSAUZf44OO63Srn5cmRhk3zEEs/EgIJwH1JRkWn2zXEJrVVD3m9YnYmyvJeaCOo1Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0uL8XY4zlUaOVhpAHYkxdgGF0/KQQVoCghjnzNnQo4=;
 b=TZdOp3ub9zl4jXtS4d3UwIUGSnmElKbhpeHLlKfMF7wVDY5204Wq3sYrcFqo4DgiPm+KnUZ7aPmt3TmS3RD4dR25RnsF+A8s9iZo0nYoRY2GqTNoFDogH3llorrNYDbScGXF9TauP45GCPF1rsXk0TO3Fty9d4MfPJxA5L3B6AXg0H1FcziRxXDZRRZSRIsP7cpF6A2L4tuILEfNlOnLvoVWfm01HTkBfgK+8ygND40TM1uuQVc1iYb1kypFjZEaYGrkh19GPUShERgccOUOTb4q5TaLrVHRX9sTIggowZ27Jv4fJtL11CXkWd5AE9Y5tY9gjcIMT1hFuhPpGvFPlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0uL8XY4zlUaOVhpAHYkxdgGF0/KQQVoCghjnzNnQo4=;
 b=KNUbrATw3eh7pNel1WH99XKRLqeviQ9ENhi5aVmcbrgOXqjJ5CV6dXEhD4WSnrzttO/F/u10OX+Ce47d0VVrcgxGz0RqysfOVhizziTqPKosrQaLr29WRcwrXOgLT8bT4JN0mOnFNPaiiFBlPZGLFFg5QKeluMG3nwoUkvry734=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB6335.eurprd04.prod.outlook.com (20.179.26.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Mon, 13 Jan 2020 18:18:23 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::58c5:f02f:2211:4953]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::58c5:f02f:2211:4953%7]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 18:18:23 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
        "a.swigon@samsung.com" <a.swigon@samsung.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "hl@rock-chips.com" <hl@rock-chips.com>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jcrouse@codeaurora.org" <jcrouse@codeaurora.org>,
        "chanwoo@kernel.org" <chanwoo@kernel.org>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>
Subject: Re: [PATCH v2] PM / devfreq: Add debugfs support with devfreq_summary
 file
Thread-Topic: [PATCH v2] PM / devfreq: Add debugfs support with
 devfreq_summary file
Thread-Index: AQHVyc3KaFU/UFm3mEWFxixIQ8JQkg==
Date:   Mon, 13 Jan 2020 18:18:23 +0000
Message-ID: <VI1PR04MB702316C611FCF43240B02D7AEE350@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <CGME20200113045609epcas1p1188f24c37f8ba230a0e3856aeb0e4d8e@epcas1p1.samsung.com>
 <20200113050324.26232-1-cw00.choi@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: acfcbf2a-4cda-455a-fa01-08d79854fa3c
x-ms-traffictypediagnostic: VI1PR04MB6335:
x-microsoft-antispam-prvs: <VI1PR04MB6335EDC261DCEC7C1806133CEE350@VI1PR04MB6335.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(199004)(189003)(33656002)(478600001)(5660300002)(71200400001)(186003)(4326008)(7696005)(9686003)(26005)(55016002)(52536014)(6506007)(53546011)(2906002)(86362001)(54906003)(64756008)(6916009)(91956017)(44832011)(66476007)(8936002)(66946007)(66556008)(66446008)(7416002)(8676002)(76116006)(81166006)(81156014)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6335;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J9NBQPD4FWAALQWxfCjix6rhEbfnL6FnLoek7STbXM854MnN9X5g60GJHj2A80vP7eqtyIDwt+VL/4Yp3PyMBSzkfuhTejqmvyhwA9QYWhXpSzkpTtPNLQ/urzBJFRGC/gFxhW6f2AJw+Oxa54vYLe4/SMLIlWke09890kqVZwiohkpoILLVy5lO03acq2EIpAvU7JoOumlqkOoWbiQl+uwjqw1ciVLH5kQFF6VI03gnrCnuB89/XfX2O/VJnlEqhmMaBgSuJ+/9JPan2MpSi3GsF1jZBj1uVfVzYkJAtulCp0Sl7WPEIIQa0NArgsJyBCO76u/aeAKnXs4E6Gp6sj5ZN5eT2s860eYF9SEP8n8RArlq/+HY2r0Ih8ZgusDUGUrJRIIVDbJuY2B5hAG1uRh6BvO1qjc3Lc22oNknKL32pUVO7iL3KuhX440eNV3V
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acfcbf2a-4cda-455a-fa01-08d79854fa3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 18:18:23.8313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e6lVzXgF57DEBtuga/6bXYav3Kuid0+fKLyOKPyuBI+67Vr8PViMd4VjJBpOYukUwmKHM0lV5qlUcuPRF5HpNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6335
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13.01.2020 06:56, Chanwoo Choi wrote:=0A=
> Add debugfs interface to provide debugging information of devfreq device.=
=0A=
> It contains 'devfreq_summary' entry to show the summary of registered=0A=
> devfreq devices as following and the additional debugfs file will be adde=
d.=0A=
> - /sys/kernel/debug/devfreq/devfreq_summary=0A=
> =0A=
> [Detailed description of each field of 'devfreq_summary' debugfs file]=0A=
> - dev_name	: Device name of h/w.=0A=
> - dev		: Device name made by devfreq core.=0A=
> - parent_dev	: If devfreq device uses the passive governor,=0A=
> 		  show parent devfreq device name.=0A=
> - governor	: Devfreq governor.=0A=
> - polling_ms	: If devfreq device uses the simple_ondemand governor,=0A=
> 		  polling_ms is necessary for the period. (unit: millisecond)=0A=
> - cur_freq_Hz	: Current Frequency (unit: Hz)=0A=
> - old_freq_Hz	: Frequency before changing. (unit: Hz)=0A=
> - new_freq_Hz	: Frequency after changed. (unit: Hz)=0A=
> =0A=
> [For example on Exynos5422-based Odroid-XU3 board]=0A=
> $ cat /sys/kernel/debug/devfreq/devfreq_summary=0A=
> dev_name                       dev        parent_dev governor        poll=
ing_ms  cur_freq_Hz  min_freq_Hz  max_freq_Hz=0A=
> ------------------------------ ---------- ---------- --------------- ----=
------ ------------ ------------ ------------=0A=
> 10c20000.memory-controller     devfreq0              simple_ondemand     =
     0    165000000    165000000    825000000=0A=
> soc:bus_wcore                  devfreq1              simple_ondemand     =
    50    532000000     88700000    532000000=0A=
> soc:bus_noc                    devfreq2   devfreq1   passive             =
     0    111000000     66600000    111000000=0A=
> soc:bus_fsys_apb               devfreq3   devfreq1   passive             =
     0    222000000    111000000    222000000=0A=
> soc:bus_fsys                   devfreq4   devfreq1   passive             =
     0    200000000     75000000    200000000=0A=
> soc:bus_fsys2                  devfreq5   devfreq1   passive             =
     0    200000000     75000000    200000000=0A=
> soc:bus_mfc                    devfreq6   devfreq1   passive             =
     0    333000000     83250000    333000000=0A=
> soc:bus_gen                    devfreq7   devfreq1   passive             =
     0    266000000     88700000    266000000=0A=
> soc:bus_peri                   devfreq8   devfreq1   passive             =
     0     66600000     66600000     66600000=0A=
> soc:bus_g2d                    devfreq9   devfreq1   passive             =
     0    333000000     83250000    333000000=0A=
> soc:bus_g2d_acp                devfreq10  devfreq1   passive             =
     0    266000000     66500000    266000000=0A=
> soc:bus_jpeg                   devfreq11  devfreq1   passive             =
     0    300000000     75000000    300000000=0A=
> soc:bus_jpeg_apb               devfreq12  devfreq1   passive             =
     0    166500000     83250000    166500000=0A=
> soc:bus_disp1_fimd             devfreq13  devfreq1   passive             =
     0    200000000    120000000    200000000=0A=
> soc:bus_disp1                  devfreq14  devfreq1   passive             =
     0    300000000    120000000    300000000=0A=
> soc:bus_gscl_scaler            devfreq15  devfreq1   passive             =
     0    300000000    150000000    300000000=0A=
> soc:bus_mscl                   devfreq16  devfreq1   passive             =
     0    666000000     84000000    666000000=0A=
> =0A=
> [lkp: Reported the build error]=0A=
> Reported-by: kbuild test robot <lkp@intel.com>=0A=
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>=0A=
> ---=0A=
> Changes from v1:=0A=
> - Drop the patch about 'devfreq_transitions' debugfs file=0A=
> - Modify from 'hz' to 'Hz'=0A=
> - Edit the indentation of 'devfreq_summary' when show summary=0A=
> - Exchange sequence between PTR_ERR and IS_ERR when debugfs_create_dir=0A=
> =0A=
>   drivers/devfreq/devfreq.c | 84 +++++++++++++++++++++++++++++++++++++++=
=0A=
>   1 file changed, 84 insertions(+)=0A=
> =0A=
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c=0A=
> index 89260b17598f..c2ebed42704b 100644=0A=
> --- a/drivers/devfreq/devfreq.c=0A=
> +++ b/drivers/devfreq/devfreq.c=0A=
> @@ -10,6 +10,7 @@=0A=
>   #include <linux/kernel.h>=0A=
>   #include <linux/kmod.h>=0A=
>   #include <linux/sched.h>=0A=
> +#include <linux/debugfs.h>=0A=
>   #include <linux/errno.h>=0A=
>   #include <linux/err.h>=0A=
>   #include <linux/init.h>=0A=
> @@ -33,6 +34,7 @@=0A=
>   #define HZ_PER_KHZ	1000=0A=
>   =0A=
>   static struct class *devfreq_class;=0A=
> +static struct dentry *devfreq_debugfs;=0A=
>   =0A=
>   /*=0A=
>    * devfreq core provides delayed work based load monitoring helper=0A=
> @@ -1643,6 +1645,79 @@ static struct attribute *devfreq_attrs[] =3D {=0A=
>   };=0A=
>   ATTRIBUTE_GROUPS(devfreq);=0A=
>   =0A=
> +/**=0A=
> + * devfreq_summary_show() - Show the summary of the devfreq devices=0A=
> + * @s:		seq_file instance to show the summary of devfreq devices=0A=
> + * @data:	not used=0A=
> + *=0A=
> + * Show the summary of the devfreq devices via 'devfreq_summary' debugfs=
 file.=0A=
> + * It helps that user can know the detailed information of the devfreq d=
evices.=0A=
> + *=0A=
> + * Return 0 always because it shows the information without any data cha=
nge.=0A=
> + */=0A=
> +static int devfreq_summary_show(struct seq_file *s, void *data)=0A=
> +{=0A=
> +	struct devfreq *devfreq;=0A=
> +	struct devfreq *p_devfreq =3D NULL;=0A=
> +	unsigned long cur_freq, min_freq, max_freq;=0A=
> +	unsigned int polling_ms;=0A=
> +=0A=
> +	seq_printf(s, "%-30s %-10s %-10s %-15s %10s %12s %12s %12s\n",=0A=
> +			"dev_name",=0A=
> +			"dev",=0A=
> +			"parent_dev",=0A=
> +			"governor",=0A=
> +			"polling_ms",=0A=
> +			"cur_freq_Hz",=0A=
> +			"min_freq_Hz",=0A=
> +			"max_freq_Hz");=0A=
> +	seq_printf(s, "%30s %10s %10s %15s %10s %12s %12s %12s\n",=0A=
> +			"------------------------------",=0A=
> +			"----------",=0A=
> +			"----------",=0A=
> +			"---------------",=0A=
> +			"----------",=0A=
> +			"------------",=0A=
> +			"------------",=0A=
> +			"------------");=0A=
> +=0A=
> +	mutex_lock(&devfreq_list_lock);=0A=
> +=0A=
> +	list_for_each_entry_reverse(devfreq, &devfreq_list, node) {=0A=
> +		if (!strncmp(devfreq->governor_name, DEVFREQ_GOV_PASSIVE,=0A=
> +							DEVFREQ_NAME_LEN)) {=0A=
> +			struct devfreq_passive_data *data =3D devfreq->data;=0A=
> +=0A=
> +			if (data)=0A=
> +				p_devfreq =3D data->parent;=0A=
> +		} else {=0A=
> +			p_devfreq =3D NULL;=0A=
> +		}=0A=
> +=0A=
> +		mutex_lock(&devfreq->lock);=0A=
> +		cur_freq =3D devfreq->previous_freq,=0A=
> +		get_freq_range(devfreq, &min_freq, &max_freq);=0A=
> +		polling_ms =3D devfreq->profile->polling_ms,=0A=
> +		mutex_unlock(&devfreq->lock);=0A=
> +=0A=
> +		seq_printf(s,=0A=
> +			"%-30s %-10s %-10s %-15s %10d %12ld %12ld %12ld\n",=0A=
> +			dev_name(devfreq->dev.parent),=0A=
> +			dev_name(&devfreq->dev),=0A=
> +			p_devfreq ? dev_name(&p_devfreq->dev) : "",=0A=
=0A=
Can you prints some sort of "null" here instead of just skipping the field?=
=0A=
=0A=
This would ensure output is always a whitespace-separated table that can =
=0A=
be easily processed with tools like "awk".=0A=
=0A=
> +			devfreq->governor_name,=0A=
> +			polling_ms,=0A=
> +			cur_freq,=0A=
> +			min_freq,=0A=
> +			max_freq);=0A=
> +	}=0A=
> +=0A=
> +	mutex_unlock(&devfreq_list_lock);=0A=
> +=0A=
> +	return 0;=0A=
> +}=0A=
> +DEFINE_SHOW_ATTRIBUTE(devfreq_summary);=0A=
> +=0A=
>   static int __init devfreq_init(void)=0A=
>   {=0A=
>   	devfreq_class =3D class_create(THIS_MODULE, "devfreq");=0A=
> @@ -1659,6 +1734,15 @@ static int __init devfreq_init(void)=0A=
>   	}=0A=
>   	devfreq_class->dev_groups =3D devfreq_groups;=0A=
>   =0A=
> +	devfreq_debugfs =3D debugfs_create_dir("devfreq", NULL);=0A=
> +	if (IS_ERR(devfreq_debugfs) && PTR_ERR(devfreq_debugfs) !=3D -ENODEV) {=
=0A=
> +		pr_warn("%s: couldn't create debugfs dir\n", __FILE__); > +	} else {=
=0A=
> +		debugfs_create_file("devfreq_summary", 0444,=0A=
> +				devfreq_debugfs, NULL,=0A=
> +				&devfreq_summary_fops);=0A=
> +	}=0A=
> +=0A=
>   	return 0;=0A=
>   }=0A=
>   subsys_initcall(devfreq_init);=0A=
> =0A=
=0A=
