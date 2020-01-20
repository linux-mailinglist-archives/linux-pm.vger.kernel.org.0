Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0DC142111
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2020 01:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgATAXA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 Jan 2020 19:23:00 -0500
Received: from mail-eopbgr00071.outbound.protection.outlook.com ([40.107.0.71]:26087
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728841AbgATAXA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 19 Jan 2020 19:23:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSJW0/4Sn2/3n3Z5BkIsKCjVdoLtZdwn22XRtCUltgEU3i+PhTrwbRUEhiR9Shv7XuuF/5VpOMOlyFiUY5ii1MfqEnmpsr2IbwTtqx4pd6DDc6jOCw5UVN1F0Fm8ZPnFmXyxClJDYz62FurtqHVJGGFuqjtFD9KJxwbDZmNIrq6oZ6KRHV1j0sCIy7567IXoI5xylaHQ6eg71433tXfMopCATPxUCu4QKhWSePY3Im1tEWmWVCz0tiqE5XxTc6YAgScS36BfqPpc1EKILQKJ/3jlEbXnbWMKyS2Dl/fGajeF3wys3xr5fMXbqkout5Ov3B5OcqGluTrG+XNLdHNQSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVceeFXfZHmhqJO78ZRziU+UGGBZigdJTCZ+dOR53ds=;
 b=iJvlFeU18ArMkbvmpB+H6vK/YCkpiBPBoAQ245+L/LndegpLC2RE8j6a85fU13ijYQOYuUwJ8raKclrlB0J9tzSs2QHnhQ3c3OpF+NIiKcz5FbxTM2C7wyJ/tB1Pjo9Gy3oN5tz4dvbZp/ilz6x0YO5yx3reE267xWx4ec89a8S86kwlEurtGwIsc9g3kmNs4qoErQbJ5W8MyMZrkoSSB3lnA9OO5OyLZyNcMB3D3u9uP2t6DpmOk9YdqHnQxF/qrJI0YzcRNa6bCPbS1AzVAS+vBQwlff+tIss5sH1NSSmUeojPtUyJnrbmXd13bzqOq4Bb4zSkcTXObCT2w23vjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVceeFXfZHmhqJO78ZRziU+UGGBZigdJTCZ+dOR53ds=;
 b=QQNmMmcTA7tJU1YWsiiPGA5nHOTteaU4G8xSh/hVFXk1MFLdRvCpvCKJjd+igS5h3gfPSjHT9dm2ZiL/eI2PbTZVVbmcGeV+fYRNyW4sNfr3XXuruQHzIVpJwNmNh1k8ic8XB8tigXS/Q1Xwuozr6K5+QIxESVQ4ZwCjwMmnASA=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5536.eurprd04.prod.outlook.com (20.178.123.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Mon, 20 Jan 2020 00:22:50 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::58c5:f02f:2211:4953]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::58c5:f02f:2211:4953%7]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 00:22:50 +0000
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
Subject: Re: [PATCH v5] PM / devfreq: Add debugfs support with devfreq_summary
 file
Thread-Topic: [PATCH v5] PM / devfreq: Add debugfs support with
 devfreq_summary file
Thread-Index: AQHVzFr5qXK7VKZu0kmxCcMuLXEhPw==
Date:   Mon, 20 Jan 2020 00:22:50 +0000
Message-ID: <VI1PR04MB7023483C8D9E774444CAB24DEE320@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <CGME20200116105149epcas1p36fa4867bae7d1a6f4827a8ddb4e75b35@epcas1p3.samsung.com>
 <20200116105909.29281-1-cw00.choi@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [2a04:241e:500:9200:6182:be7e:37de:ba10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 37abf548-f618-4d5a-2bea-08d79d3ee236
x-ms-traffictypediagnostic: VI1PR04MB5536:
x-microsoft-antispam-prvs: <VI1PR04MB553601CA832AD19FC6EDC26CEE320@VI1PR04MB5536.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:234;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(189003)(199004)(64756008)(66446008)(66556008)(478600001)(186003)(66946007)(71200400001)(76116006)(66476007)(53546011)(6506007)(8936002)(54906003)(81166006)(316002)(81156014)(8676002)(86362001)(6916009)(44832011)(55016002)(4326008)(5660300002)(9686003)(2906002)(52536014)(33656002)(7696005)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5536;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RPkTUNyJljQwt7WbTL7ubbaATlHETKqgWjxAEnjaINh5ZtPZbHf8iv2BUNABCAZDZEmFfH3HMK0NFDLx7zAceUuj7byGcMfLFvLBc0isNE0zZuuUv5ll1u7OvVXV0rde3EpNPPtPIGTO9FpwktCUKm3MzdaN3aRiQ6+wz9s7yTlZGFRboN6CAkYX8sN+H0BhX+UrDmUhvJSFrjd8ZgwbBoXNGQ/ZzBv4NQcezZU7xdD8JNkd2geBst5y2nB02AhLX/TDH1bDIaLknbjqR9wYfcV9alXUgyusnSBkGaUTWREXDfbxgm2KX5+TF5TnhVdnDGQHLwLqM9ve9JtZAOf4E4K3i80kd3OGUYXtFmZMLKQOdUhMsHwVLMfj9RbswDSTd+ABlYR/qbOXw92q1ZXiRjniusy3PvrUxlltWgADKbANlUaIoX6SLZqUwXEauR+g
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37abf548-f618-4d5a-2bea-08d79d3ee236
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 00:22:50.3315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l0bVPyULtzTxGVpXzQhIiwtTIi4azyJhVTTFphnEHSuQySL//rbZynqbld/UJM0gCEkkSx4g+u96AfbqysapGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5536
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16.01.2020 12:51, Chanwoo Choi wrote:=0A=
> Add debugfs interface to provide debugging information of devfreq device.=
=0A=
> It contains 'devfreq_summary' entry to show the summary of registered=0A=
> devfreq devices as following and the additional debugfs file will be adde=
d.=0A=
> - /sys/kernel/debug/devfreq/devfreq_summary=0A=
> =0A=
> [Detailed description of each field of 'devfreq_summary' debugfs file]=0A=
> - dev_name	: Device name of h/w=0A=
> - dev		: Device name made by devfreq core=0A=
> - parent_dev	: If devfreq device uses the passive governor,=0A=
> 		  show parent devfreq device name. Otherwise, show 'null'.=0A=
> - governor	: Devfreq governor name=0A=
> - polling_ms	: If devfreq device uses the simple_ondemand governor,=0A=
> 		  polling_ms is necessary for the period. (unit: millisecond)=0A=
> - cur_freq_Hz	: Current frequency (unit: Hz)=0A=
> - min_freq_Hz	: Minimum frequency (unit: Hz)=0A=
> - max_freq_Hz	: Maximum frequency (unit: Hz)=0A=
> =0A=
> [For example on Exynos5422-based Odroid-XU3 board]=0A=
> $ cat /sys/kernel/debug/devfreq/devfreq_summary=0A=
> dev_name                       dev        parent_dev governor        poll=
ing_ms  cur_freq_Hz  min_freq_Hz  max_freq_Hz=0A=
> ------------------------------ ---------- ---------- --------------- ----=
------ ------------ ------------ ------------=0A=
> 10c20000.memory-controller     devfreq0   null       simple_ondemand     =
     0    165000000    165000000    825000000=0A=
> soc:bus_wcore                  devfreq1   null       simple_ondemand     =
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
=0A=
I'm not sure I understand why this is mentioned in the commit message. =0A=
If kbuild robot reports an error for an in-flight patch that's not =0A=
usually mention in the commit message.=0A=
=0A=
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>=0A=
> ---=0A=
> Changes from v4:=0A=
> - Fix wrong patch description=0A=
> Changes from v3:=0A=
> - Remove the unneeded checking of return value when calling debugfs_creat=
e_dir=0A=
> - Add missing IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE) condition=0A=
> Changes from v2:=0A=
> - Show 'null' at 'parent_dev' field when governor of devfreq device=0A=
>    is not passive=0A=
> Changes from v1:=0A=
> - Drop the patch about 'devfreq_transitions' debugfs file=0A=
> - Modify from 'hz' to 'Hz'=0A=
> - Edit the indentation of 'devfreq_summary' when show summary=0A=
> - Exchange sequence between PTR_ERR and IS_ERR when debugfs_create_dir=0A=
> =0A=
>   drivers/devfreq/devfreq.c | 82 +++++++++++++++++++++++++++++++++++++++=
=0A=
>   1 file changed, 82 insertions(+)=0A=
> =0A=
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c=0A=
> index 89260b17598f..cceee8bc3c2f 100644=0A=
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
> @@ -1643,6 +1645,81 @@ static struct attribute *devfreq_attrs[] =3D {=0A=
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
> +#if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE)=0A=
> +		if (!strncmp(devfreq->governor_name, DEVFREQ_GOV_PASSIVE,=0A=
> +							DEVFREQ_NAME_LEN)) {=0A=
> +			struct devfreq_passive_data *data =3D devfreq->data;=0A=
> +=0A=
> +			if (data)=0A=
> +				p_devfreq =3D data->parent;=0A=
> +		} else {=0A=
> +			p_devfreq =3D NULL;=0A=
> +		}=0A=
> +#endif=0A=
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
> +			p_devfreq ? dev_name(&p_devfreq->dev) : "null",=0A=
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
> @@ -1659,6 +1736,11 @@ static int __init devfreq_init(void)=0A=
>   	}=0A=
>   	devfreq_class->dev_groups =3D devfreq_groups;=0A=
>   =0A=
> +	devfreq_debugfs =3D debugfs_create_dir("devfreq", NULL);=0A=
> +	debugfs_create_file("devfreq_summary", 0444,=0A=
> +				devfreq_debugfs, NULL,=0A=
> +				&devfreq_summary_fops);=0A=
> +=0A=
>   	return 0;=0A=
>   }=0A=
>   subsys_initcall(devfreq_init);=0A=
> =0A=
=0A=
