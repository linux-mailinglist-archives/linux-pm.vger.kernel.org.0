Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CABFF9059
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2019 14:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfKLNRd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Nov 2019 08:17:33 -0500
Received: from mail-eopbgr140058.outbound.protection.outlook.com ([40.107.14.58]:24678
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727324AbfKLNRc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 12 Nov 2019 08:17:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwE//niPuwhMCffUnuBJCbVEbed/cf8dtd842Y2NOl5m77XF1mHEgubFDWkXy+ZAXzYJXm6F/9HlZpuhAGB2550OBajFixnhLtTFnm9KZNNKjuOktn1xe9MelEk9G/HmO/+bBXsr64zqqkCEpVyQ10d6LetHSqVs/0gZU2AVoIP+N2F43NMGfip2eVVKVcZJ3j6esyvqTsW4PN9vxaMi3QuQ4t+Nzfubg6hCNQwfoMfGgwYxYhtCJyxYx+6mPrGWsSaQg/uTWCnIgQ+K7+cCCGMEe967qxpYaWN8rnPgy+CTj0U/feTCY30Ya5ymR8tx6/zMRMVp7ycFit9IsAOPxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtIVyvNbbQqlo2slNTjT0AC2YJBvBMOR+W5TAxmD/Fw=;
 b=jJSzDyKhZ/N/D93nqLX5Bq28TPGe6e/CpjcA/LGQa+oDREHriXoolfUTg6OtQgkSgYmZcKAlmTWICI8zAzWphiisZA3IprmOi87gC6X+IlDhO6ka1DI6kr70KUHt4dkNNaXtDF8TAdDrbqWSjNA8h5Mdu7fL2iVeJlZ9FjgPB5kQ5KmWDdDh7/eQ26a8F/eM+eMLrmuJajEGjXaA/52gWPKJUTDZH4FNcmFBpp+rYZlX0ws1t/818H9TlrHh8c4rJ77fBv0q2RKDGG8V/3ot+0g6hGLw8pASv8faStPL3NonvGx6K59XXU4Zj0W20Eneb1hNV+E1zjc9YIhqALZ7Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtIVyvNbbQqlo2slNTjT0AC2YJBvBMOR+W5TAxmD/Fw=;
 b=k/FEzm+bl3nsjstWJ2AcsBRBtbT698rvc4cJuSCOIJw9wnZ1YnUWoeBfFvzJdrg4VZf7AJYw7DhPnG/l7ZnvC7DusB1quzoNTCioQfBY3QUu1rRwCVJEgvAq2ZPGpSG2diaVJ4bLCIpNisa53AlNui5wzyF5SWvI0mImdGzlUm8=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB6030.eurprd04.prod.outlook.com (20.179.26.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Tue, 12 Nov 2019 13:17:23 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 13:17:23 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 5/6] PM / devfreq: imx8m-ddrc: Measure bandwidth with
 perf
Thread-Topic: [PATCH v4 5/6] PM / devfreq: imx8m-ddrc: Measure bandwidth with
 perf
Thread-Index: AQHVloV+zGA9oz88V0ShgPz1YTDKzA==
Date:   Tue, 12 Nov 2019 13:17:22 +0000
Message-ID: <VI1PR04MB702331A22024C6EDB57AC840EE770@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1573252696.git.leonard.crestez@nxp.com>
 <CGME20191108224023epcas1p43cb02d83f5d9b8d8774405dcea03530f@epcas1p4.samsung.com>
 <a25094eac4c0f740e0e33c04af699b39a4226a08.1573252696.git.leonard.crestez@nxp.com>
 <59f37128-45e8-763d-dd48-32baa864d2a6@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e97d41a8-c9e9-4d35-ea7a-08d76772a795
x-ms-traffictypediagnostic: VI1PR04MB6030:|VI1PR04MB6030:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB60305EE46ECF31D685153AF6EE770@VI1PR04MB6030.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(199004)(189003)(51444003)(52314003)(66446008)(33656002)(478600001)(3846002)(6116002)(25786009)(14454004)(316002)(76176011)(6506007)(66556008)(64756008)(53546011)(66476007)(66946007)(7696005)(44832011)(486006)(446003)(229853002)(476003)(74316002)(26005)(6436002)(102836004)(186003)(7736002)(86362001)(8936002)(256004)(14444005)(5024004)(2906002)(91956017)(66066001)(7416002)(8676002)(81166006)(81156014)(76116006)(5660300002)(54906003)(110136005)(9686003)(99286004)(305945005)(52536014)(6246003)(71190400001)(71200400001)(55016002)(4326008)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6030;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E7qV8pgzwtsGfkiIZC3Yqo5N/Yf70sDbPYwvbjwZnCWBS9H69/d2you39pXdqz9AR3g0d8cJOFGAr/bMt5NpltZoyVsOkjUi78NweqCc2aE/nJFWvOZbNl1WjpPBpr+Z/Yr/P8GYqm+Ik8ZOk/TM3sSTP1bgRKhE9vBegxvG2vIzaU3x0fwenr+P95m7i41nNFajE9mkpYA0bIAuKQZ6scJtytTh9cAPTY+9SWiScdP2MfHt5SHgO/1COThYfvmjBgL8IzhF3PJaqfsDSZ5hc2Pm+o0oGi2SBou6fnWkcDuBDDbhchFN7ga5KugcEJktwP5PLOQ1OsC7p7POmiRrQB6WAtmrs/1lmZ5mLdW2AgszYWeRnYJVIUCZQcOU0pHVPQOI6O9qhSroAeFwKZJA/NjL6k5W9SCfDdY81/3R2os6Q3vW1gfzxFEAwzirIPEJ
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e97d41a8-c9e9-4d35-ea7a-08d76772a795
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 13:17:22.9835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AKRZjR8zAoOT6Nwb7EonaVbZau059DTJMtyb8VKIWSySU9frZC1uBEfRwvcpx0mXGfw5sw/NzWNyOcgwssabtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6030
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11.11.2019 07:13, Chanwoo Choi wrote:=0A=
> Hi Leonard,=0A=
> =0A=
> On 11/9/19 7:39 AM, Leonard Crestez wrote:=0A=
>> The imx8m ddrc has a performance monitoring block attached which can=0A=
>> be used to measure bandwidth usage and automatically adjust frequency.=
=0A=
>>=0A=
>> There is already a perf driver for that block so instead of implementing=
=0A=
>> a devfreq events driver use the in-kernel perf API to implement=0A=
>> get_dev_status directly.=0A=
>>=0A=
>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>> ---=0A=
>>   drivers/devfreq/imx8m-ddrc.c | 153 +++++++++++++++++++++++++++++++++++=
=0A=
>>   1 file changed, 153 insertions(+)=0A=
>>=0A=
>> diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc.c=
=0A=
>> index 51903fee21a7..6372191f72d7 100644=0A=
>> --- a/drivers/devfreq/imx8m-ddrc.c=0A=
>> +++ b/drivers/devfreq/imx8m-ddrc.c=0A=
>> @@ -11,10 +11,13 @@=0A=
>>   #include <linux/pm_opp.h>=0A=
>>   #include <linux/clk.h>=0A=
>>   #include <linux/clk-provider.h>=0A=
>>   #include <linux/arm-smccc.h>=0A=
>>   =0A=
>> +#include <asm/perf_event.h>=0A=
>> +#include <linux/perf_event.h>=0A=
>> +=0A=
>>   #define IMX_SIP_DDR_DVFS			0xc2000004=0A=
>>   =0A=
>>   /* Values starting from 0 switch to specific frequency */=0A=
>>   #define IMX_SIP_DDR_FREQ_SET_HIGH		0x00=0A=
>>   =0A=
>> @@ -78,10 +81,22 @@ struct imx8m_ddrc {=0A=
>>   	struct clk *dram_alt;=0A=
>>   	struct clk *dram_apb;=0A=
>>   =0A=
>>   	int freq_count;=0A=
>>   	struct imx8m_ddrc_freq freq_table[IMX8M_DDRC_MAX_FREQ_COUNT];=0A=
>> +=0A=
>> +	/* For measuring load with perf events: */=0A=
>> +	struct platform_device *pmu_pdev;=0A=
>> +	struct pmu *pmu;=0A=
>> +=0A=
>> +	struct perf_event_attr rd_event_attr;=0A=
>> +	struct perf_event_attr wr_event_attr;=0A=
>> +	struct perf_event *rd_event;=0A=
>> +	struct perf_event *wr_event;=0A=
>> +=0A=
>> +	u64 last_rd_val, last_rd_ena, last_rd_run;=0A=
>> +	u64 last_wr_val, last_wr_ena, last_wr_run;=0A=
>>   };=0A=
>>   =0A=
>>   static struct imx8m_ddrc_freq *imx8m_ddrc_find_freq(struct imx8m_ddrc =
*priv,=0A=
>>   						    unsigned long rate)=0A=
>>   {=0A=
>> @@ -245,10 +260,131 @@ static int imx8m_ddrc_get_cur_freq(struct device =
*dev, unsigned long *freq)=0A=
>>   	*freq =3D clk_get_rate(priv->dram_core);=0A=
>>   =0A=
>>   	return 0;=0A=
>>   }=0A=
>>   =0A=
>> +static int imx8m_ddrc_get_dev_status(struct device *dev,=0A=
>> +				     struct devfreq_dev_status *stat)=0A=
>> +{=0A=
>> +	struct imx8m_ddrc *priv =3D dev_get_drvdata(dev);=0A=
>> +=0A=
>> +	stat->current_frequency =3D clk_get_rate(priv->dram_core);=0A=
>> +=0A=
>> +	if (priv->rd_event && priv->wr_event) {=0A=
>> +		u64 rd_delta, rd_val, rd_ena, rd_run;=0A=
>> +		u64 wr_delta, wr_val, wr_ena, wr_run;=0A=
>> +=0A=
>> +		rd_val =3D perf_event_read_value(priv->rd_event,=0A=
>> +					       &rd_ena, &rd_run);=0A=
>> +		wr_val =3D perf_event_read_value(priv->wr_event,=0A=
>> +					       &wr_ena, &wr_run);=0A=
>> +=0A=
>> +		rd_delta =3D (rd_val - priv->last_rd_val) *=0A=
>> +			   (rd_ena - priv->last_rd_ena);=0A=
>> +		do_div(rd_delta, rd_run - priv->last_rd_run);=0A=
>> +		priv->last_rd_val =3D rd_val;=0A=
>> +		priv->last_rd_ena =3D rd_ena;=0A=
>> +		priv->last_rd_run =3D rd_run;=0A=
>> +=0A=
>> +		wr_delta =3D (wr_val - priv->last_wr_val) *=0A=
>> +			   (wr_ena - priv->last_wr_ena);=0A=
>> +		do_div(wr_delta, wr_run - priv->last_wr_run);=0A=
>> +		priv->last_wr_val =3D wr_val;=0A=
>> +		priv->last_wr_ena =3D wr_ena;=0A=
>> +		priv->last_wr_run =3D wr_run;=0A=
>> +=0A=
>> +		/* magic numbers, possibly wrong */=0A=
>> +		stat->busy_time =3D 4 * (rd_delta + wr_delta);=0A=
>> +		stat->total_time =3D stat->current_frequency;=0A=
>> +	} else {=0A=
>> +		stat->busy_time =3D 0;=0A=
>> +		stat->total_time =3D 0;=0A=
>> +	}=0A=
>> +=0A=
>> +	return 0;=0A=
>> +}=0A=
>> +=0A=
>> +static int imx8m_ddrc_perf_disable(struct imx8m_ddrc *priv)=0A=
>> +{=0A=
>> +	/* release and set to NULL */=0A=
>> +	if (!IS_ERR_OR_NULL(priv->rd_event))=0A=
>> +		perf_event_release_kernel(priv->rd_event);=0A=
>> +	if (!IS_ERR_OR_NULL(priv->wr_event))=0A=
>> +		perf_event_release_kernel(priv->wr_event);=0A=
>> +	priv->rd_event =3D NULL;=0A=
>> +	priv->wr_event =3D NULL;=0A=
>> +=0A=
>> +	return 0;=0A=
>> +}=0A=
>> +=0A=
>> +static int imx8m_ddrc_perf_enable(struct imx8m_ddrc *priv)=0A=
> =0A=
> Actually, this function have to call the just function for enabling=0A=
> the bandwidth monitoring instead of writing the detailed something.=0A=
> It looks like that you move the part of the different device driver into =
here.=0A=
=0A=
This is the code for enabling bandwith monitoring: it creates perf =0A=
counters using in-kernel API. The perf api doesn't seem to expose =0A=
anything else to enable/disable the counter after creation and honestly =0A=
just create/destroy seems fine.=0A=
=0A=
As far as I can tell bandwidth monitoring in devfreq is always enabled =0A=
on probe anyway, no matter which governor is in use. It would be nice if =
=0A=
devfreq drivers could receive a callback and dynamically acquire/release =
=0A=
monitoring resources only when the ondemand governor is in used.=0A=
=0A=
Until then this driver will permanently allocate 2 (out of 3) counters =0A=
in ddr pmu hardware.=0A=
=0A=
>> +{=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	priv->rd_event_attr.size =3D sizeof(priv->rd_event_attr);=0A=
>> +	priv->rd_event_attr.type =3D priv->pmu->type;=0A=
>> +	priv->rd_event_attr.config =3D 0x2a;=0A=
>> +=0A=
>> +	priv->rd_event =3D perf_event_create_kernel_counter(=0A=
>> +			&priv->rd_event_attr, 0, NULL, NULL, NULL);=0A=
>> +	if (IS_ERR(priv->rd_event)) {=0A=
>> +		ret =3D PTR_ERR(priv->rd_event);=0A=
>> +		goto err;=0A=
>> +	}=0A=
>> +=0A=
>> +	priv->wr_event_attr.size =3D sizeof(priv->wr_event_attr);=0A=
>> +	priv->wr_event_attr.type =3D priv->pmu->type;=0A=
>> +	priv->wr_event_attr.config =3D 0x2b;=0A=
>> +=0A=
>> +	priv->wr_event =3D perf_event_create_kernel_counter(=0A=
>> +			&priv->wr_event_attr, 0, NULL, NULL, NULL);=0A=
>> +	if (IS_ERR(priv->wr_event)) {=0A=
>> +		ret =3D PTR_ERR(priv->wr_event);=0A=
>> +		goto err;=0A=
>> +	}=0A=
>> +=0A=
>> +	return 0;=0A=
>> +=0A=
>> +err:=0A=
>> +	imx8m_ddrc_perf_disable(priv);=0A=
>> +	return ret;=0A=
>> +}=0A=
>> +=0A=
>> +static int imx8m_ddrc_init_events(struct device *dev,=0A=
>> +				  struct device_node *events_node)=0A=
> =0A=
> ditto.=0A=
> =0A=
>> +{=0A=
>> +	struct imx8m_ddrc *priv =3D dev_get_drvdata(dev);=0A=
>> +	struct device_driver *driver;=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * We need pmu->type for perf_event_attr but there is no API for=0A=
>> +	 * mapping device_node to pmu. Fetch private data for imx-ddr-pmu and=
=0A=
>> +	 * cast that to a struct pmu instead.=0A=
>> +	 */=0A=
>> +	priv->pmu_pdev =3D of_find_device_by_node(events_node);=0A=
>> +	if (!priv->pmu_pdev)=0A=
>> +		return -EPROBE_DEFER;=0A=
>> +	driver =3D priv->pmu_pdev->dev.driver;=0A=
>> +	if (!driver)=0A=
>> +		return -EPROBE_DEFER;=0A=
>> +	if (strcmp(driver->name, "imx-ddr-pmu")) {=0A=
>> +		dev_warn(dev, "devfreq-events node %pOF has unexpected driver %s\n",=
=0A=
>> +				events_node, driver->name);=0A=
>> +		return -ENODEV;=0A=
>> +	}=0A=
>> +=0A=
>> +	priv->pmu =3D platform_get_drvdata(priv->pmu_pdev);=0A=
> =0A=
> It seems that you access the different device driver without=0A=
> any standard interface from some linux kernel subsystem.=0A=
> =0A=
> For the communication or control between different device drivers,=0A=
> we have to use the standard interface instead of direct access or call.=
=0A=
> I think that it make it too tightly coupled driver between them.=0A=
> =0A=
> So, I developed the devfreq-event subsystem for this reason=0A=
> in order to remove the non-standard direct access to other device driver.=
=0A=
> =0A=
> Unfortunately, I can't agree this approach. I don't prefer to use=0A=
> the direct access of other device driver(imx-ddr-pmu). You need to=0A=
> use standard interface provided from subsystem. or You need to make=0A=
> the new device driver with devfreq-event subsystem.=0A=
=0A=
This could be cleaned-up by adding a new API to "fetch struct pmu* by =0A=
struct device_node*" as available for many other subsystems. The perf =0A=
api is otherwise standard/generic and has a few other in-kernel users.=0A=
=0A=
The perf driver for DDR PMU is already functional and useful for =0A=
profiling and reusing it seem very worthwhile. If you're suggesting I =0A=
implemented an unrelated "devfreq-event" driver then how would it get =0A=
probed? There's only one PMU node in DT.=0A=
=0A=
I wouldn't mind to delay the monitoring part into a second series.=0A=
=0A=
>> +	if (!priv->pmu) {=0A=
>> +		dev_err(dev, "devfreq-events device missing private data\n");=0A=
>> +		return -EINVAL;=0A=
>> +	}=0A=
>> +=0A=
>> +	dev_dbg(dev, "events from pmu %s\n", priv->pmu->name);=0A=
>> +=0A=
>> +	return imx8m_ddrc_perf_enable(priv);=0A=
>> +}=0A=
>> +=0A=
>>   static int imx8m_ddrc_init_freq_info(struct device *dev)=0A=
>>   {=0A=
>>   	struct imx8m_ddrc *priv =3D dev_get_drvdata(dev);=0A=
>>   	struct arm_smccc_res res;=0A=
>>   	int index;=0A=
>> @@ -328,17 +464,23 @@ static int imx8m_ddrc_check_opps(struct device *de=
v)=0A=
>>   	return 0;=0A=
>>   }=0A=
>>   =0A=
>>   static void imx8m_ddrc_exit(struct device *dev)=0A=
>>   {=0A=
>> +	struct imx8m_ddrc *priv =3D dev_get_drvdata(dev);=0A=
>> +=0A=
>> +	imx8m_ddrc_perf_disable(priv);=0A=
>> +	platform_device_put(priv->pmu_pdev);=0A=
>> +=0A=
>>   	dev_pm_opp_of_remove_table(dev);=0A=
>>   }=0A=
>>   =0A=
>>   static int imx8m_ddrc_probe(struct platform_device *pdev)=0A=
>>   {=0A=
>>   	struct device *dev =3D &pdev->dev;=0A=
>>   	struct imx8m_ddrc *priv;=0A=
>> +	struct device_node *events_node;=0A=
>>   	const char *gov =3D DEVFREQ_GOV_USERSPACE;=0A=
>>   	int ret;=0A=
>>   =0A=
>>   	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);=0A=
>>   	if (!priv)=0A=
>> @@ -350,10 +492,19 @@ static int imx8m_ddrc_probe(struct platform_device=
 *pdev)=0A=
>>   	if (ret) {=0A=
>>   		dev_err(dev, "failed to init firmware freq info: %d\n", ret);=0A=
>>   		return ret;=0A=
>>   	}=0A=
>>   =0A=
>> +	events_node =3D of_parse_phandle(dev->of_node, "devfreq-events", 0);=
=0A=
>> +	if (events_node) {=0A=
>> +		ret =3D imx8m_ddrc_init_events(dev, events_node);=0A=
>> +		of_node_put(events_node);=0A=
>> +		if (ret)=0A=
>> +			goto err;=0A=
>> +		gov =3D DEVFREQ_GOV_SIMPLE_ONDEMAND;=0A=
>> +	}=0A=
>> +=0A=
>>   	priv->dram_core =3D devm_clk_get(dev, "core");=0A=
>>   	priv->dram_pll =3D devm_clk_get(dev, "pll");=0A=
>>   	priv->dram_alt =3D devm_clk_get(dev, "alt");=0A=
>>   	priv->dram_apb =3D devm_clk_get(dev, "apb");=0A=
>>   	if (IS_ERR(priv->dram_core) ||=0A=
>> @@ -390,10 +541,12 @@ static int imx8m_ddrc_probe(struct platform_device=
 *pdev)=0A=
>>   	}=0A=
>>   =0A=
>>   	return 0;=0A=
>>   =0A=
>>   err:=0A=
>> +	imx8m_ddrc_perf_disable(priv);=0A=
>> +	platform_device_put(priv->pmu_pdev);=0A=
>>   	dev_pm_opp_of_remove_table(dev);=0A=
>>   	return ret;=0A=
>>   }=0A=
>>   =0A=
>>   static const struct of_device_id imx8m_ddrc_of_match[] =3D {=0A=
