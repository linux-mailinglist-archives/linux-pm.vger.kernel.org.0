Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8A535F49C
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2019 10:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfGDIcW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Jul 2019 04:32:22 -0400
Received: from mail-eopbgr60088.outbound.protection.outlook.com ([40.107.6.88]:56135
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726870AbfGDIcW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 4 Jul 2019 04:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCQRrydNyh3ccGGLjK11Ak+lAQqZN+VNWyfNvTvLHTo=;
 b=PiQqwfJum3yr4u0fErNqfidW1A/Onqi2x9f7Nto4K2PvFPJ3FMRqovPJj7bhUDZtnfQ1PHtNDGpXBSPS0fEOZxSezz7H3lb4uX4+8H1eAgSGDOmN4LdkZOlsZHeGfUJEHvh4sAnFUgkUpALStV7xcWWu/cXKI70CwZ4nPCe2MB4=
Received: from DB7PR04MB5051.eurprd04.prod.outlook.com (20.176.234.223) by
 DB7PR04MB4009.eurprd04.prod.outlook.com (52.134.107.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.15; Thu, 4 Jul 2019 08:32:17 +0000
Received: from DB7PR04MB5051.eurprd04.prod.outlook.com
 ([fe80::6c98:1416:8221:bdfc]) by DB7PR04MB5051.eurprd04.prod.outlook.com
 ([fe80::6c98:1416:8221:bdfc%4]) with mapi id 15.20.2052.010; Thu, 4 Jul 2019
 08:32:17 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Saravana Kannan <saravanak@google.com>,
        Georgi Djakov <georgi.djakov@linaro.org>
CC:     Viresh Kumar <viresh.kumar@linaro.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFCv2 0/8] Add imx8mm bus frequency switching
Thread-Topic: [RFCv2 0/8] Add imx8mm bus frequency switching
Thread-Index: AQHVLYSy6nskEZuxAkK/D6W15Np9Kw==
Date:   Thu, 4 Jul 2019 08:32:17 +0000
Message-ID: <DB7PR04MB5051CA1EE62E3D8687352B05EEFA0@DB7PR04MB5051.eurprd04.prod.outlook.com>
References: <cover.1561707104.git.leonard.crestez@nxp.com>
 <CAGETcx_63KnP75qySbhX_P_=o4=ox9J8AsBqKsFHeQRjCpSeJA@mail.gmail.com>
 <DB7PR04MB505163FDCAD7BE9A0C71A65EEEFB0@DB7PR04MB5051.eurprd04.prod.outlook.com>
 <CAGETcx-p4L3LBVpDBmBrPKXxMUtUXtsw-7AntpWs+AL3kaaP5Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [82.144.34.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6be4d8cf-bc69-4c84-f123-08d7005a1fe2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR04MB4009;
x-ms-traffictypediagnostic: DB7PR04MB4009:
x-microsoft-antispam-prvs: <DB7PR04MB4009C2E77B7FAEB3216B4A8DEEFA0@DB7PR04MB4009.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(199004)(189003)(478600001)(26005)(256004)(76176011)(68736007)(3846002)(6116002)(52536014)(186003)(73956011)(76116006)(91956017)(99286004)(81156014)(86362001)(8936002)(81166006)(66556008)(8676002)(5660300002)(102836004)(66476007)(64756008)(25786009)(5024004)(66946007)(53546011)(7416002)(7696005)(14444005)(66446008)(14454004)(6506007)(6436002)(74316002)(66066001)(110136005)(229853002)(71190400001)(316002)(2906002)(33656002)(71200400001)(9686003)(55016002)(53936002)(6246003)(486006)(476003)(4326008)(7736002)(446003)(305945005)(54906003)(44832011)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4009;H:DB7PR04MB5051.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NDkkiR+RAOxS8Ou7cqFAckIxeoQ+B9W0hFr25Pt3Mghp2GuwDooJRwLK4Nb7Lta5NEV5askCrg2KyZywnFlHAe9CYLAyKlcCWFJYPHIuDrF/m09p38bYvgvdjxkZvvJ22zVXabgUoTDd8zEC5P9jASQbfwFcCyhSW5RyB71Wv6Nv/UGgsbQaqACTkueV6Ct8UP0CurZcnPR08xNW0nn4iVcb0s3KpCmhaw9o5HTreHkhx6nAXxdqhIDd8UCjF88rX/b9npafwxpb4b95xYcrf8NSpzlkgPoJ78fyTT5HucR1Fm1QS1xC937ayyGZ0Z5SkzR+KK5gbTKqwhu17hgBWrEWIxKzBzlSiKG62jN6UkdsjcLAviaDDkGSiJ9KXr0YdHgjkyDs4E/eum7MvBiDKrDSz2jliAMzD2OCkvbl6Ak=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be4d8cf-bc69-4c84-f123-08d7005a1fe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 08:32:17.6468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonard.crestez@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4009
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/4/2019 6:03 AM, Saravana Kannan wrote:=0A=
> On Wed, Jul 3, 2019 at 4:30 PM Leonard Crestez <leonard.crestez@nxp.com> =
wrote:=0A=
=0A=
>> On 7/4/2019 1:20 AM, Saravana Kannan wrote:=0A=
>>=0A=
>>>> The interconnect and devfreq parts do not communicate explicitly: they=
 both=0A=
>>>> just call clk_set_min_rate and the clk core picks the minimum value th=
at can=0A=
>>>> satisfy both. They are thus completely independent.=0A=
>>>=0A=
>>> Two different parts not talking to each other and just setting min=0A=
>>> rate can cause problems for some concurrency use cases. ICC framework=
=0A=
>>> is explicitly designed to handle cases like this and aggregate the=0A=
>>> needs correctly. You might want to look into that more closely.=0A=
>>=0A=
>> The clk framework aggregates the min_rate requests from multiple=0A=
>> consumers under a big "prepare_lock" so I expect it will deal with=0A=
>> concurrent requests correctly. As for performance: frequency switching=
=0A=
>> shouldn't be a fast path.=0A=
> =0A=
> Sorry I wasn't clear. I was not talking about locking issues or race=0A=
> conditions when I said concurrency use cases. What I meant was if GPU=0A=
> wants 5 GB/s and at the same time (concurrent) camera wants 5 GB/s=0A=
> you'll need to configure the interconnect for 10 GB/s. If both of them=0A=
> just try to set the min freq equivalent for 5 GB/s the performance=0A=
> would be bad or functionality might break.=0A=
=0A=
I'm not calling clk_set_min_rate independently for each icc path, that =0A=
would be obviously broken. The interconnect framework is still used to =0A=
aggregate bandwith requests and in your scenario clk_set_min_rate for =0A=
the main NOC would be called in a way that meets the combined 10 GB/s =0A=
requests.=0A=
=0A=
It is devfreq which calls clk_set_min_rate independently of =0A=
interconnect, this results in CLK performing the final aggregation =0A=
between the "proactive" and "reactive" scaling.=0A=
=0A=
>>>> The clk_set_min_rate approach does not mesh very well with the OPP fra=
mework.=0A=
>>>> Some of interconnect nodes on imx8m can run at different voltages: OPP=
 can=0A=
>>>> handle this well but not in response to a clk_set_min_rate from an unr=
elated=0A=
>>>> subsystem. Maybe set voltage on a clk notifier?=0A=
>>>=0A=
>>> I think if you design it something like below, it might make your life=
=0A=
>>> a whole lot easier.=0A=
>>> Hopefully the formatting looks okay on your end. The arrow going up is=
=0A=
>>> just connecting devfreq to ICC.=0A=
>>>=0A=
>>>                           Proactive -> ICC -> clk/OPP API to set freq/v=
olt=0A=
>>>                                         ^=0A=
>>>                                         |=0A=
>>> HW measure -> governor -> devfreq ----+=0A=
>>>=0A=
>>> That way, all voltage/frequency requirements are managed cleanly by=0A=
>>> clk/OPP frameworks. The ICC deals with aggregating all the=0A=
>>> requirements and devfreq lets you handle reactive scaling and policy.=
=0A=
>>=0A=
>> If icc and devfreq are to directly communicate it makes more sense to do=
=0A=
>> it backwards: ICC should set a min_freq on nodes which have a devfreq=0A=
>> instance attached and devfreq should implement actual freq switching.=0A=
>>=0A=
>> HW measurement is done on individual nodes while ICC deals with requests=
=0A=
>> along a path. In particular on imx we have a performance monitor=0A=
>> attached to the ddr controller and I doubt it can distinguish between=0A=
>> masters so how could this be mapped usefully to an interconnect request?=
=0A=
> =0A=
> Ah, that was the missing piece for me -- you are trying to use a=0A=
> central performance monitor. I see what you are trying to do.=0A=
> =0A=
> So you are looking at system wide traffic at DDR and then using that=0A=
> to scale the interconnect/DDRC. I don't know how complicated or not=0A=
> the IMX interconnect topology is, so please pardon my questions. If=0A=
> you are using a performance monitor at the DDR controller, why do you=0A=
> need the "proactive" requests from other clients? Wouldn't the=0A=
> performance monitor account for all the traffic to DDR?=0A=
=0A=
Reactive scaling is too slow to ramp-up in media playback scenarios and =0A=
first few frames would fail.=0A=
=0A=
>> As far as I understand with devfreq the ddrc node could use "ondemand"=
=0A=
>> while the other nodes would default to the "passive" governor and run at=
=0A=
>> predefined default ratios relative to DDRC.=0A=
> =0A=
> Yes, that approach would also work but I'm not sure why you need the=0A=
> ICC framework in that case.=0A=
=0A=
For proactive scaling: to ensure bandwidth *before* traffic starts. In =0A=
imx vendor tree that's all that's implemented; for reactive scaling we =0A=
just set busfreq to high as soon as cpu leaves min opp.=0A=
=0A=
IMX interconnect topology is not very complex so mechanisms other than =0A=
interconnect could be used. But ICC is the most powerful and expressive =0A=
subsystem for proactive requests.=0A=
=0A=
>>> If all of this makes sense, please take a look at [2] and provide your=
=0A=
>>> thoughts. I've dropped a few patches from [1] to avoid confusion (too=
=0A=
>>> much going on at once). I think BW OPP tables and having OPP tables=0A=
>>> for interconnect paths will be something you'll need (if not now,=0A=
>>> eventually) and something you can build on top of nicely.=0A=
>>=0A=
>> I found it very confusing that you're assigning BW OPP tables to=0A=
>> devices. My initial understanding was that BW OPP would map "bandwidth"=
=0A=
>> to "frequency" so BW OPPs should be assigned to links along the=0A=
>> interconnect graph. But maybe what you want is to have OPPs for the BW=
=0A=
>> values requested by devices?=0A=
> =0A=
> I want to have OPPs for bandwidths requested for paths.=0A=
=0A=
Right, this was not very obvious.=0A=
=0A=
> Each interconnect node can also use BW OPPs if that makes sense for them,=
=0A=
> but I think they'd be better served by using frequency OPPs.=0A=
=0A=
Each interconnect node is asked by the framework to ensure a certain BW =0A=
is available in "bytes". The nodes could use OPPs with BW values to map =0A=
the icc request to a frequency in "hz".=0A=
=0A=
>> Looking at the sdm845 icc provider source and it seems that those=0A=
>> "peak/avg" values are actually parameters which go into a firmware=0A=
>> command!? It makes sense that you want interconnect to be "below"=0A=
>> devfreq since icc_provider.set maps very closely to what firmware expose=
s.=0A=
> =0A=
> Even without the firmware (it's mainly there to aggregate requests for=0A=
> some system wide resources) or if interconnects are scaled directly=0A=
> using clock APIs (older chips), sdm845 would still want ICC to be=0A=
> below devfreq. It's because 845 doesn't try to do ICC scaling by=0A=
> measuring at the DDR. Each master makes separate requests and then the=0A=
> ICC aggregates and sets the frequency. They have their reasons (good=0A=
> ones) for doing that.=0A=
=0A=
Maybe I'm confused about how devfreq is used in your scenario: you have =0A=
devices which have their own OPPs (like a GPU) and expose this via =0A=
devfreq. Then for each GPU OPP you want to pick a the BW value to =0A=
request from interconnect, right?=0A=
=0A=
My idea was to use devfreq *after* icc so that you can do stuff like =0A=
force a certain NOC to "max" via echo "performance" > $sysfs/governor. =0A=
It also allows encapsulating complex freq switching (clk maintainers =0A=
don't seem to like my dram clk).=0A=
=0A=
On a second examination there is no actual incompatibility here, devfreq =
=0A=
could be used both below and above ICC.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
