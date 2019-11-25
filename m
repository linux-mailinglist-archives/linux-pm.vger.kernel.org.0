Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDB1109219
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2019 17:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbfKYQqR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Nov 2019 11:46:17 -0500
Received: from mail-eopbgr40064.outbound.protection.outlook.com ([40.107.4.64]:51718
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728683AbfKYQqQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 25 Nov 2019 11:46:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4eH7JYo6DkCimOiemoyqj4SfbMUCvTjUiLjymRKO+Yy8QBYuQzkDKiHcngk7Zi+LESwn47kB85geqetPzc5p0GlDEXS/Z65jkGX8C6CZ1JegWxim+YfPZI8f2V2K2vN+6KH2Y9+YnxH2UTM1+KubJVx0pP6F+mFChdVZ5W/l2Fk0y++1GQQTMDBkEXILLlxlK1vbcTZC+BF+XNoRl9EZfe3Fo1ddJPOQ2MU8ocoNEqZGYDoWNECGY1yZKcfzrn3ShHtSLfqw0j0rbj5tilT0GWxAaV7rdGFyWNN5YatnIluxKncrKj7Mnf5dVNUFjssPDMnjOk8WLwapKyPZi8wGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjHwga8IPjFgENogdt+XEhtMbvhncergehFqTpYQJlQ=;
 b=iUBuUDjVvHmENIEDeKP7+p8PSIw9ZDJIKBrtErE7x0373ZBg2kZemzxuYuA8aR5kCLR8OWukcUFXCbUeYGsX/aERqFiZojFJR4BYOoc2KsO2/mmnNia1wZKa2iHctC8nc8257cfuKozlfrOpPE5uwR7WVAdTpimm0HfhZcO8X3h7QdlRChjpoBnQv9nXStAV55rv2A7HXsK+FGJpzzNzXSPlqBfPk3TJ8+j3iimoxC1mF6544eE/Qhx/r1LWt41HlTdgt8mvdCZ+E5OaVL3h3Wl8kuMRBDhLyqXbo6VK9n+joD+AP7wDNakuTUSE/iwQpLgUM3xsBRV7tMQTYmI3+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjHwga8IPjFgENogdt+XEhtMbvhncergehFqTpYQJlQ=;
 b=Nw0vQBbcJAa48HAH2H98krifqrod45TjjObQif4TWMXJQ8bKBZhDZhd6LR7bjA4SczNbZFAJHsbypHtuloxeGaI68Ebay74rsKnpHqT7Y0zB/Vce3vAcOvMeAqTe0LXrB93oAaIk8kGizA7UF+/n+BivoD2v4YqZaR/V2hckbYs=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB7183.eurprd04.prod.outlook.com (10.186.157.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Mon, 25 Nov 2019 16:46:12 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 16:46:12 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Chanwoo Choi <cw00.choi@samsung.com>
CC:     Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH RFC 2/2] PM / devfreq: Use PM QoS for sysfs min/max_freq
Thread-Topic: [PATCH RFC 2/2] PM / devfreq: Use PM QoS for sysfs min/max_freq
Thread-Index: AQHVnvQ6x9t0jA6r+U2AKNPDc34osQ==
Date:   Mon, 25 Nov 2019 16:46:12 +0000
Message-ID: <VI1PR04MB70237E859BBD7048B0DD0675EE4A0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1574179738.git.leonard.crestez@nxp.com>
 <1f567d6478b1782f7f4afc27cb6d3f896d77ac9f.1574179738.git.leonard.crestez@nxp.com>
 <20191121231622.GK27773@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e8f362c1-c1b0-46f4-8c5b-08d771c6fad4
x-ms-traffictypediagnostic: VI1PR04MB7183:|VI1PR04MB7183:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB7183172DE410BACFA3D53665EE4A0@VI1PR04MB7183.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0232B30BBC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(189003)(199004)(186003)(54906003)(26005)(99286004)(966005)(4326008)(5660300002)(91956017)(76116006)(66556008)(64756008)(66946007)(66476007)(8936002)(66446008)(9686003)(6306002)(7696005)(8676002)(76176011)(81166006)(81156014)(14454004)(55016002)(6436002)(33656002)(66066001)(316002)(6506007)(53546011)(14444005)(44832011)(256004)(229853002)(110136005)(478600001)(52536014)(3846002)(7736002)(6116002)(86362001)(25786009)(446003)(71190400001)(71200400001)(74316002)(102836004)(7416002)(305945005)(2906002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB7183;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uYH+VbPR686huVWIvq82IOgfduLUFfp90yhN8Z7HiJnt2Vp1sT6m+L41duECIJijPfjAaHVIqOKZFFIe2JvxzES4u9sUry0gc/fHHB+HFnb93ZkylaDMNn5IzJFGyFRFll6JOigSc5wvLUNGwKzBV15vgG3e0+PbMbquNr6wu95SdljgdYCU5eleZqS6IV0YTswJQh21udEQdYTFLqqLBDW+HEdQFBFUPm+cA9BMjXg4Z5zuSz8/RJAiqoyYrubwgPe+O/ViOURAPDpXl5DxpFcNLqEV/mnflFgtdhFHxE4JNiHekMiw9I5ISNAinM1OYObfyUam/8emzrAY3kXj8TmkmG0+gyDkBabbrCSZI93XgI2Q3L8JphoaEokgzbRa7x0uvcxRVjecvZ4quGdzIOi8OVzJxCIsYhvnkKJjCSwl1XdmZHW+ENOhhCeThANBtxm2F6dzg2RHEHh6WLl7G2BmcXjowGuF8UwjmJWxTMQ=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f362c1-c1b0-46f4-8c5b-08d771c6fad4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2019 16:46:12.0437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UmsOLI4PCvRT+aQaFWBgzgpPvBpK92km2+FSqFoCcH8XSxSOOJ9xexaFG0iuxFyVTWkiYzZtdiNEiI4b7HYvMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7183
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22.11.2019 01:16, Matthias Kaehlcke wrote:=0A=
> Hi Leonard,=0A=
> =0A=
> this seems to work ok as long as there are no other ('external') PM QoS=
=0A=
> requests, however the aggregate max_freq can be incorrect when there are=
=0A=
> multiple requests.=0A=
> =0A=
> I intended to test with devfreq_cooling using PM QoS, but this didn't wor=
k=0A=
> out due to limitations on my development platform. Instead I added anothe=
r=0A=
> set of requests and sysfs attributes to devfreq (see patch below).=0A=
=0A=
Thanks a lot for looking at this.=0A=
=0A=
> With this we get:=0A=
> =0A=
> cat available_frequencies=0A=
>    180000000 267000000 355000000 430000000 565000000 650000000 800000000=
=0A=
> =0A=
> # ok=0A=
> cat max_freq=0A=
>    800000000=0A=
> =0A=
> # wtf???=0A=
> echo 650000000 > max_freq=0A=
> cat max_freq=0A=
>    800000000=0A=
> =0A=
> # this looks better=0A=
> echo 800000000 > test_max_freq=0A=
> cat max_freq=0A=
>    650000000=0A=
> =0A=
> =0A=
> The problem appears to be:=0A=
> =0A=
> #define PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE      (-1)=0A=
> =0A=
> in include/linux/pm_qos.h (added by "PM / QoS: Restore=0A=
> DEV_PM_QOS_MIN/MAX_FREQUENCY")=0A=
> =0A=
> The aggregate value returned by=0A=
> dev_pm_qos_read_value(dev, DEV_PM_QOS_MAX_FREQUENCY) is the=0A=
> smallest of all requests, which is PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE=0A=
> unless all requests have set an actual constraint.=0A=
> =0A=
> You probably want to change the constant to resolve to S32_MAX or some=0A=
> other big value.=0A=
=0A=
Since dev_pm_qos is now layered on top of freq_qos that should be:=0A=
=0A=
#define PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE FREQ_QOS_MAX_DEFAULT_VALUE=0A=
=0A=
I wrote a synthetic test and it seems your issue can be reproduced using =
=0A=
kunit on top of raw freq_qos. Looking a bit deeper into pm_qos =0A=
implementation it seems that there isn't much special treatment for =0A=
pm_qos_constraints. A reasonable solution would be:=0A=
=0A=
#define FREQ_QOS_MAX_DEFAULT_VALUE	S32_MAX=0A=
=0A=
Cpufreq is not affected because it always sets "real" values but I =0A=
believe that creating requests that should be ignored is a valid approach.=
=0A=
=0A=
Update on pm/qos here: https://patchwork.kernel.org/cover/11260627/=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
=0A=
