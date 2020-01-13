Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 626AB139762
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2020 18:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgAMRT5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jan 2020 12:19:57 -0500
Received: from mail-vi1eur05on2086.outbound.protection.outlook.com ([40.107.21.86]:46209
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728665AbgAMRT5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Jan 2020 12:19:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUkX/yLJJu63py/kRiE49PoUTpMT/wjOqXS65+9xGukvVVepj1macxDJYDxx+l9ZOXMFgCbStHrq3t0Bax/vbKv6YsvwAtx00Fc+r20HUrnVWniJ/elPzlGsA/YAR0AGw3FHFchdJUDVYgxRMZ/ilS3tiDB/0KQJ2hr0/nnF9PDapG6MCrluezDR52GcbV6813IX+hh3lHQVMmANz1W7bQEFr8d+36AmEG9T4SwQSW79PPaDt2R0aWC8O9IKSEcdaV2LwZUP3gB80ZGOwTLxGMaxqDNp+4VuGlvzI7kKMiMMY+ICQrl+aujsXGbniWzhROLEtX1DpluUxl8ymXCO+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o97qjigBsn+An1EPd/853xlVsTcHAb08z8WPCbyOEmo=;
 b=N3jptQHw0hAnZFJ5wgKSyosqaea3X9hmK5CcG+1Mzbv8WccvbNzYVNNRj7PtOJu/GZ8FVEOfECPkhqsQcmAuD2bQPB8fC35pgcDL8PE7xPhOzhgwivmncX4+Yvvcj1XHV07M4xb2kgTbAyFacVc+9hhjxbXDeJdWvBdwvNvkCVFODShMNmVOtJkMeTuwzLXwTA6Cd/+jTge4JnhX6Cr+lQQ/cmg4DVoEEYbXaozqVM7PbtRC8btEzfC0hR8xnDslw35e1RAWpXAS/UPC91NFJCSaSP+59e3ab/9c8WtxvyhYwZzTK1agEKuKAyEYEumIeBiGyc8evP9uFS9isMih7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o97qjigBsn+An1EPd/853xlVsTcHAb08z8WPCbyOEmo=;
 b=LuFESbjn3HeTZTv/c9lzuo470OO73LoYlEgaZwz3WOlkBbBcu8zYBJTYiOKEnC3V9bzOZ4gNzxRkM6X6pTku7U+r9biIBTC/oBM/hhcA3euGk6Jd3sncI6ZPrMiNwTgCU3+qJfbRXoQY4iFy88moyAutlgN2DVxkPNCjrs3KxV0=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4911.eurprd04.prod.outlook.com (20.177.49.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Mon, 13 Jan 2020 17:19:51 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::58c5:f02f:2211:4953]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::58c5:f02f:2211:4953%7]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 17:19:51 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Lukasz Luba <lukasz.luba@arm.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "a.swigon@samsung.com" <a.swigon@samsung.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "hl@rock-chips.com" <hl@rock-chips.com>,
        "jcrouse@codeaurora.org" <jcrouse@codeaurora.org>,
        "chanwoo@kernel.org" <chanwoo@kernel.org>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>
Subject: Re: [PATCH 2/2] PM / devfreq: Add devfreq_transitions debugfs file
Thread-Topic: [PATCH 2/2] PM / devfreq: Add devfreq_transitions debugfs file
Thread-Index: AQHVxTid9i7DZ/9UzUWyef1PEzA4Vg==
Date:   Mon, 13 Jan 2020 17:19:51 +0000
Message-ID: <VI1PR04MB70232D962B603DC882388B92EE350@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <20200107090519.3231-1-cw00.choi@samsung.com>
 <CGME20200107085812epcas1p4670ae2265573d887aa75cab36c04b1ea@epcas1p4.samsung.com>
 <20200107090519.3231-3-cw00.choi@samsung.com> <20200107214834.GB738324@yoga>
 <c1e6f324-b0c2-41ff-a015-7ba0b29ad42c@gmail.com>
 <ddbc54d1-c657-747c-265d-3c7bd5924e59@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d4a55736-8e0a-4907-d57a-08d7984cccb4
x-ms-traffictypediagnostic: VI1PR04MB4911:
x-microsoft-antispam-prvs: <VI1PR04MB4911157C401F43D82ED3F294EE350@VI1PR04MB4911.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(189003)(199004)(66446008)(66476007)(2906002)(6506007)(53546011)(71200400001)(66556008)(64756008)(66946007)(91956017)(76116006)(26005)(33656002)(186003)(44832011)(5660300002)(52536014)(86362001)(8936002)(7696005)(45080400002)(7416002)(4326008)(966005)(81166006)(316002)(9686003)(55016002)(81156014)(8676002)(478600001)(110136005)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4911;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hjK9dQJ92fuy28zSsHVtYuBoowkfCAT8mddovxYbyWzJ9evDCz1621JAYMFwkMhKGsNMSQGmZB8j6Tqgl2BtBJCmj6BLwrSX4FdWSJEdWYJUcK7u7SlOXANZHjNBnXifmjNz29vZVayi8OZbzbz7Waeuh+qd/nfTRJPnwOeidbMLCq+2IcdITnDd0VXhgF2sGs/Fuv7NTEthp10zdwwn6ywm3sWGa6PLcpWyz0cdAZ6ly/r02jaxf2747SHqphf4isZgswmvCZ5hN1cb9hEu3IqcvhrQXgtAKSZ/3msDTjIybXPIfXP5q4RmmAIN2Mksqt1VV8KKldAPKFJM549l293rdw+E8yVjNHNbg7eiVrr/SASgqpAAWGOyps9MYuuHgWQPBIKo8NSLeI8uKDScvOXgeAEYEhGg551qtiWI49hm/S7qPwBDbNDt00lS+jm2f9yZrz4NnBxl2OSaA17bZhdgKPpDk8h8ao4Cf7VjjkU8+fl9TRNeSayFVLesw9CWRoUUVH18vLQoCODF8+oYKg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a55736-8e0a-4907-d57a-08d7984cccb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 17:19:51.4279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pu6GKPNub3OB2djDU+Ud7aCwNfY3S+bb3dojB2oPGJyDofFGKbh1MobiGv65pJJDh/QwpHurnN7MPN4RwVLjDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4911
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08.01.2020 17:44, Lukasz Luba wrote:=0A=
> On 1/8/20 2:20 PM, Dmitry Osipenko wrote:=0A=
>> 08.01.2020 00:48, Bjorn Andersson =D0=C9=DB=C5=D4:=0A=
>>> On Tue 07 Jan 01:05 PST 2020, Chanwoo Choi wrote:=0A=
>>>=0A=
>>>> Add new devfreq_transitions debugfs file to track the frequency transi=
tions=0A=
>>>> of all devfreq devices for the simple profiling as following:=0A=
>>>> - /sys/kernel/debug/devfreq/devfreq_transitions=0A=
>>>>=0A=
>>>> And the user can decide the storage size (CONFIG_NR_DEVFREQ_TRANSITION=
S)=0A=
>>>> in Kconfig in order to save the transition history.=0A=
>>>>=0A=
>>>> [Detailed description of each field of 'devfreq_transitions' debugfs f=
ile]=0A=
>>>> - time_ms	: Change time of frequency transition. (unit: millisecond)=
=0A=
>>>> - dev_name	: Device name of h/w.=0A=
>>>> - dev		: Device name made by devfreq core.=0A=
>>>> - parent_dev	: If devfreq device uses the passive governor,=0A=
>>>> 		  show parent devfreq device name.=0A=
>>>> - load_%	: If devfreq device uses the simple_ondemand governor,=0A=
>>>> 		  load is used by governor whene deciding the new frequency.=0A=
>>>> 		  (unit: percentage)=0A=
>>>> - old_freq_hz	: Frequency before changing. (unit: hz)=0A=
>>>> - new_freq_hz	: Frequency after changed. (unit: hz)=0A=
>>>>=0A=
>>>> [For example on Exynos5422-based Odroid-XU3 board]=0A=
>>>> $ cat /sys/kernel/debug/devfreq/devfreq_transitions=0A=
>>>> time_ms    dev_name                       dev        parent_dev load_%=
 old_freq_hz  new_freq_hz=0A=
>>>> ---------- ------------------------------ ---------- ---------- ------=
---- ------------ ------------=0A=
>>>> 14600      soc:bus_noc                    devfreq2   devfreq1   0     =
 100000000    67000000=0A=
>>>> 14600      soc:bus_fsys_apb               devfreq3   devfreq1   0     =
 200000000    100000000=0A=
>>>> 14600      soc:bus_fsys                   devfreq4   devfreq1   0     =
 200000000    100000000=0A=
>>>> 14600      soc:bus_fsys2                  devfreq5   devfreq1   0     =
 150000000    75000000=0A=
>>>> 14602      soc:bus_mfc                    devfreq6   devfreq1   0     =
 222000000    96000000=0A=
>>>> 14602      soc:bus_gen                    devfreq7   devfreq1   0     =
 267000000    89000000=0A=
>>>> 14602      soc:bus_g2d                    devfreq9   devfreq1   0     =
 300000000    84000000=0A=
>>>> 14602      soc:bus_g2d_acp                devfreq10  devfreq1   0     =
 267000000    67000000=0A=
>>>> 14602      soc:bus_jpeg                   devfreq11  devfreq1   0     =
 300000000    75000000=0A=
>>>> 14602      soc:bus_jpeg_apb               devfreq12  devfreq1   0     =
 167000000    84000000=0A=
>>>> 14603      soc:bus_disp1_fimd             devfreq13  devfreq1   0     =
 200000000    120000000=0A=
>>>> 14603      soc:bus_disp1                  devfreq14  devfreq1   0     =
 300000000    120000000=0A=
>>>> 14606      soc:bus_gscl_scaler            devfreq15  devfreq1   0     =
 300000000    150000000=0A=
>>>> 14606      soc:bus_mscl                   devfreq16  devfreq1   0     =
 333000000    84000000=0A=
>>>> 14608      soc:bus_wcore                  devfreq1              9     =
 333000000    84000000=0A=
>>>> 14783      10c20000.memory-controller     devfreq0              35    =
 825000000    633000000=0A=
>>>> 15873      soc:bus_wcore                  devfreq1              41    =
 84000000     400000000=0A=
>>>> 15873      soc:bus_noc                    devfreq2   devfreq1   0     =
 67000000     100000000=0A=
>>>> [snip]=0A=
>>>>=0A=
>>>=0A=
>>> Wouldn't it make more sense to expose this through the tracing=0A=
>>> framework - like many other subsystems does?=0A=
>>=0A=
>> I think devfreq core already has some tracing support and indeed it=0A=
>> should be better to extend it rather than duplicate.=0A=
=0A=
+1 for tracing=0A=
> In my opinion this debugfs interface should be considered as a helpful=0A=
> validation entry point. We had some issues with wrong bootloader=0A=
> configurations in clock tree, where some frequencies could not be set=0A=
> in the kernel. Similar useful description can be find in clock subsystem=
=0A=
> where there is clock tree summary file.=0A=
> =0A=
> It is much cheaper to poke a few files in debug dir by some automated=0A=
> test than starting tracing, provoking desired code flow in the=0A=
> devfreq for every device, paring the results... A simple boot test=0A=
> which reads only these new files can be enough to rise the flag.=0A=
=0A=
Tracepoints are also very powerful for debugging boot issues! You can =0A=
add "tp_printk trace_event=3Ddevfreq:*" to boot arguments and you will see =
=0A=
console messages for all relevant events. This works even if boot fails =0A=
before userspace is available to mount debugfs.=0A=
=0A=
> Secondly the tracing is not always compiled.=0A=
=0A=
Tracing is deliberately light-weight and should be enabled even on =0A=
production systems.=0A=
=0A=
> It could capture old/wrong bootloaders which pinned devices=0A=
> improperly to PLLs or wrong DT values in OPP table.=0A=
> (a workaround for Odroid xu4 patchset:=0A=
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flkml.=
org%2Flkml%2F2019%2F7%2F15%2F276&amp;data=3D02%7C01%7Cleonard.crestez%40nxp=
.com%7C8397d37b41474137f8cf08d79451a007%7C686ea1d3bc2b4c6fa92cd99c5c301635%=
7C0%7C0%7C637140950611913278&amp;sdata=3DrcbWCyFmf0ZO7LU27D05mftTf8YdSvGPYN=
sst1GnNjQ%3D&amp;reserved=3D0=0A=
> )=0A=
> =0A=
> Chanwoo what do think about some sanity check summary?=0A=
> It could be presented in a 3rd file: 'devfreq_sanity', which=0A=
> could report if the devices could set their registered OPPs=0A=
> and got the same values, i.e. set 166MHz --> set to 150MHz=0A=
> in reality. If a config option i.e. DEVFREQ_SANITY is set=0A=
> then during the registration of a new device it checks OPPs=0A=
> if they are possible to set. It could be done before assigning=0A=
> the governor for the device and results present in of of your files.=0A=
=0A=
The new devfreq_transition tracepoint could include a field for =0A=
"new_effective freq" next to "old_freq" and "new_requested_freq".=0A=
=0A=
For imx8m-ddrc I handled this inside the target() function: clk_get_rate =
=0A=
is called after the transition and an error is reported if rate doesn't =0A=
match.=0A=
=0A=
It might make sense for devfreq core to handle this internally by =0A=
calling get_cur_freq instead.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
