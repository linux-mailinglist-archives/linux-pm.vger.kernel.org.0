Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDF1F20D9
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2019 22:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbfKFVbb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Nov 2019 16:31:31 -0500
Received: from mail-eopbgr140085.outbound.protection.outlook.com ([40.107.14.85]:4163
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727587AbfKFVba (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 6 Nov 2019 16:31:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvhnEmmOQ7TVpmxeJQQb5/l8c8nN/aq9MyN0VnZj5+xKV6f2FfjhLQv7EdGTA8fSbopwdFI1DsskdvSsFfWi//MkzGv9G9z5RCq2gZuQzEh7nrDWu78cz8I8cKn6NV0iw7/3dlVhSj2uxCKoIPYEMuWt6LlikNfsuSZpRaEM8y5/Pm/5X78MMeuWuLnY1/xGzFEaN3ZkmVxv/d9h9awU5/vdK9wgrY/WwQn8wSeyw/Prb7WbzAPfqQdeMUs8eIZ11f84GQ1d7mFvpkw3x23N8kpE+XmYpYfC8y7Ym+tZi55aqnMgsMGjZzHhq0A0dwFwoG0IjXtOv5HJF/H3uriEiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gr8y8jwVc8+Dfj+DQuPJUQFa6V0sttGRMnzUPxQUpqE=;
 b=eKnRN7ytAhjbRQSUXdETQCfF4UowdB0zfRqw1XfTDtdhcHxMFCLnnmDqRxH74cizX5tJ3yeix4RjWh9EGKeJS5TOwkpYczvSqZv9c8GNpcHgPe8LKpA/CbB9n4hdxh6Am6AeKoi9nhQrr1Rt0+nA8NweTuxXHTHyx15IJ0pqdRgGljKHAc6mDKWH6wHWaSPlzbfPqModE4BvUKqODZ9/b7HZgCBcUXnjxeV7uaCPzyx97KLbcPbvTNWM0qVUK7lkdb4DI9nqLHh0C187L7Imiqb50BHinSKxqwudnWSKQ/8KfFIkD8+E8jNhhpquas27J9TEkGSRXQj/6rDjkWRluA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gr8y8jwVc8+Dfj+DQuPJUQFa6V0sttGRMnzUPxQUpqE=;
 b=UbJ0UqUHVNzx7oowOY4YCnq9E1yzoVhFgYggEBgadCOkG1pnW9tV8aiMF5U4y8h2Osv3I7OkU8fGh+byWTUKtXIuLdY1Yg0Q+TSELUkjDCALl3zs3hfKFojX03D3p/WM8glYBCxFkfssFIZjeDFj/TsC4hKT45E36zaIRzAqEaw=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB3229.eurprd04.prod.outlook.com (10.170.231.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 21:31:24 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2430.023; Wed, 6 Nov 2019
 21:31:24 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC 0/7] cpuidle: Add poking mechanism to support non-IPI wakeup
Thread-Topic: [RFC 0/7] cpuidle: Add poking mechanism to support non-IPI
 wakeup
Thread-Index: AQHU5J/uL6RBBX3AA0GxPKCBIrMc4A==
Date:   Wed, 6 Nov 2019 21:31:24 +0000
Message-ID: <VI1PR04MB7023BCCCE80A02B00F5F2ED0EE790@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <1553692845-20983-1-git-send-email-abel.vesa@nxp.com>
 <1553701479.2561.38.camel@pengutronix.de>
 <564216aa-1144-71de-e887-00c58f466bf5@arm.com>
 <1553702767.2561.40.camel@pengutronix.de>
 <85c91392-9cbf-a5fc-b037-3d58f2b0ac9c@arm.com>
 <cb2e5521cc0d29b7c3ac42a6717256ec2e8d35e6.camel@nxp.com>
 <20190328104542.GA27459@e107981-ln.cambridge.arm.com>
 <ebf1b5f3-1612-9dae-72bb-cc67be69ebf2@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4970d12b-7cc3-49cd-b9f5-08d76300acec
x-ms-traffictypediagnostic: VI1PR04MB3229:|VI1PR04MB3229:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB3229EFDD40ABD30BE2E029D8EE790@VI1PR04MB3229.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(199004)(189003)(446003)(6116002)(54906003)(476003)(305945005)(99286004)(76176011)(33656002)(110136005)(66556008)(8936002)(81166006)(9686003)(6436002)(6636002)(6306002)(7416002)(6246003)(66446008)(76116006)(66476007)(64756008)(86362001)(316002)(3846002)(478600001)(7696005)(6506007)(53546011)(8676002)(5660300002)(52536014)(81156014)(7736002)(14444005)(102836004)(14454004)(25786009)(26005)(256004)(66066001)(186003)(74316002)(44832011)(55016002)(486006)(66946007)(91956017)(71190400001)(71200400001)(2906002)(4326008)(229853002)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3229;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xZRV2/hzdc3jTAvzpVuPe1xmEMMWRZ062YBGlmtcS6kDG4Mb7toN4UOo3mphYRJrfXyjPERbXM7oeBJVaScwZzFuYA+7BoJ+qVWeMIvLz7oXf8uPdTlEzqo3AMjwKQ1ChKApz81AywliaR3227JQj0azSDLO10ZEV6240xfb8gRjBZaQ0pp1HxBBk9r2hCrdkt59OFAJgdriZ4SHp78rjw/t1pIHfdzaYEgX1zpoMZC6uWx49Ni2L4fFGJiMIYidBGqnDiemuLrBAsn8qS07OgUN8/Bm+1wn2odZ+cHdpRxhzmZwftK5+TSQ2D/kkaTS9XNVEBP+IG9Yju8pdm9hP/+tzYkWqiYutsYk/5KhMzB4XgSutnvdkB/M9VeDjHAjnaYYsZaXzQpOHZdMa9wRnHESXlqjzQ4X0RAHVu3SjKHhPGNS+JsV5itWo6ShMT/a/Nq5Uj1wZuxOMArWhz685/ddQUV7hQeHyJtFOJVqOoM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4970d12b-7cc3-49cd-b9f5-08d76300acec
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 21:31:24.6508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dW0JAy4646Mx9o0VLhDGkIhPpwR7h1q52KXQOw6JzoDTLqqhbnKQmhk1hDWLWQnFPg+pTRHdbj1ek/kmPrZORA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3229
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06.11.2019 22:15, Florian Fainelli wrote:=0A=
> On 3/28/19 3:45 AM, Lorenzo Pieralisi wrote:=0A=
>> On Wed, Mar 27, 2019 at 06:40:07PM +0000, Leonard Crestez wrote:=0A=
>>> On Wed, 2019-03-27 at 17:45 +0000, Marc Zyngier wrote:=0A=
>>>> On 27/03/2019 16:06, Lucas Stach wrote:=0A=
>>>>> Am Mittwoch, den 27.03.2019, 15:57 +0000 schrieb Marc Zyngier:=0A=
>>>>>> On 27/03/2019 15:44, Lucas Stach wrote:=0A=
>>>>>>> Am Mittwoch, den 27.03.2019, 13:21 +0000 schrieb Abel Vesa:=0A=
>>>>>>>> This work is a workaround I'm looking into (more as a background t=
ask)=0A=
>>>>>>>> in order to add support for cpuidle on i.MX8MQ based platforms.=0A=
>>>>>>>>=0A=
>>>>>>>> The main idea here is getting around the missing GIC wake_request =
signal=0A=
>>>>>>>> (due to integration design issue) by waking up a each individual c=
ore through=0A=
>>>>>>>> some dedicated SW power-up bits inside the power controller (GPC) =
right before=0A=
>>>>>>>> every IPI is requested for that each individual core.=0A=
>>>>>>>=0A=
>>>>>>> Just a general comment, without going into the details of this seri=
es:=0A=
>>>>>>> this issue is not only affecting IPIs, but also MSIs terminated at =
the=0A=
>>>>>>> GIC. Currently MSIs are terminated at the PCIe core, but terminatin=
g=0A=
>>>>>>> them at the GIC is clearly preferable, as this allows assigning CPU=
=0A=
>>>>>>> affinity to individual MSIs and lowers IRQ service overhead.=0A=
>>>>>>>=0A=
>>>>>>> I'm not sure what the consequences are for upstream Linux support y=
et,=0A=
>>>>>>> but we should keep in mind that having a workaround for IPIs is onl=
y=0A=
>>>>>>> solving part of the issue.=0A=
>>>>>>=0A=
>>>>>> If this erratum is affecting more than just IPIs, then indeed I don'=
t=0A=
>>>>>> see how this patch series solves anything.=0A=
>>>>>>=0A=
>>>>>> But the erratum documentation seems to imply that only SGIs are=0A=
>>>>>> affected, and goes as far as suggesting to use an external interrupt=
=0A=
>>>>>> would solve it. How comes this is not the case? Or is it that anythi=
ng=0A=
>>>>>> directly routed to a redistributor is also affected? This would brea=
k=0A=
>>>>>> LPIs (and thus MSIs) and PPIs (the CPU timer, among others).=0A=
>>>>>=0A=
>>>>> Anything that isn't visible to the GPC and requires the GIC=0A=
>>>>> wake_request signal to behave as specified is broken by this erratum.=
=0A=
>>>>=0A=
>>>> I really wonder how a timer interrupt (a PPI, hence not routed through=
=0A=
>>>> the GPC) can wake up the CPU in this case. It really feels like=0A=
>>>> something like "program CNTV_CVAL_EL0 to expire at some later point;=
=0A=
>>>> WFI" could result in the CPU going to a deep sleep state, and not=0A=
>>>> wake-up at all.=0A=
>>>=0A=
>>> This is already a common issue for cpuidle implementions handled by the=
=0A=
>>> "local-timer-stop" property. imx has other timer blocks in the SOC,=0A=
>>> they generate SPIs which are connected to GPC.=0A=
>>=0A=
>> It is not a common issue. The tick-broadcast mechanism relies on=0A=
>> IPIs that are sent to specific CPUs upon timer expiry.=0A=
>>=0A=
>> If IPIs don't work for CPUs in shutdown state (which is what this patch=
=0A=
>> is fixing AFAIU), the only reason I can see how a CPU can resume from=0A=
>> idle on a timer expiry is the GPC waking up all cores upon the global=0A=
>> timer SPI; if that's the case there is precious little point in=0A=
>> implementing CPUidle at all - too bad people worked hard to implement=0A=
>> NOHZ in a power efficient manner.=0A=
>>=0A=
>>>> This would indicate that not only cpuidle is broken with this, but=0A=
>>>> absolutely every interrupt that is not routed through the GPC.=0A=
>>>=0A=
>>> Yes, cpuidle is broken for irqs not routed through GPC. However:=0A=
>>>=0A=
>>> * All SPIs are connected to GPC in a 1:1 mapping=0A=
>>> * This series deals with SGIs=0A=
>>> * The timer PPIs are not required; covered by local-timer-stop=0A=
>>> * LPIs are currently unused (I understand imx-pci uses SPI by default=
=0A=
>>> from Lucas)=0A=
>>>=0A=
>>> Anything missing?=0A=
>>=0A=
>> Yes, LPIs must be able to wake up CPUs and only the CPU for which=0A=
>> an IRQ is actually pending.=0A=
>>=0A=
>> >From an architectural perspective, an ARM core executing the WFI=0A=
>> instruction must resume execution upon an IRQ occurrence targeted=0A=
>> at it and that's true regardless of the idle state entered.=0A=
>>=0A=
>> Anything deviating from this behaviour is not architecture compliant.=0A=
> =0A=
> What if you enter a deeper state than WFI, which leads to the power=0A=
> gating of your CPU core, and you are missing the necessary hardware that=
=0A=
> should be driven from the GIC's nIRQOUT/nFIQOUT signals to automatically=
=0A=
> bring the core back on upon the GIC seeing a pending interrupt targeting=
=0A=
> that core?=0A=
=0A=
imx8mq has a secondary "GPC" block which receives SPIs and can wake the =0A=
cores. Do you have something similar? Because if you only have the GIC =0A=
then that sounds much worse: you'd have to ensure that all peripheral =0A=
interrupts are routed away from sleeping cores.=0A=
=0A=
On IMX only SGIs need special treatment and a newer version just =0A=
replaces __smp_cross_call in a platform-specific manner:=0A=
=0A=
     https://lkml.org/lkml/2019/6/10/350=0A=
=0A=
> Would it be acceptable in that case to "help" the platform by ensuring=0A=
> that there is at least one core that is not allowed to enter the deepest=
=0A=
> idle state and be able to help wake back up the others? I am asking=0A=
> because I am facing a similar issue to what Abel is trying to solve here=
=0A=
> with ARCH_BRCMSTB platforms which do not have the ability to have their=
=0A=
> CPU cores wake-up on their once power gated.=0A=
=0A=
Maybe you can workaround in ATF: if (last_core) wfi(); else powerdown();=0A=
=0A=
But you still need special treatment for interrupts targeted at gated cores=
.=0A=
=0A=
>>> My understanding is that this wake request feature via GIC is new in v3=
=0A=
>>> and this is maybe why HW team missed it during integration. Older=0A=
>>> imx6/7 has GICv2 and has deep idle states which always rely on GPC to=
=0A=
>>> wakeup so the approach can work.=0A=
>>=0A=
>> If HW designers really wanted to have sensible power management policy=
=0A=
>> in this SoC they would have paid attention, I am against patching the=0A=
>> kernel heavily to fix a platform bug.=0A=
=0A=
> HW designers may not be aware of how the cpuifle framework operates or=0A=
> what its constraints are, so they may not understand that any interrupt,=
=0A=
> must be able to autonomously (with lack of a better name) wake-up a=0A=
> given core, given any idle state it has entered.=0A=
=0A=
My understanding is that this is a requirement of GICv3 architecture.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
