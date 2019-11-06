Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFE6DF2215
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2019 23:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfKFWry (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Nov 2019 17:47:54 -0500
Received: from mail-eopbgr150089.outbound.protection.outlook.com ([40.107.15.89]:11525
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726912AbfKFWry (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 6 Nov 2019 17:47:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCc08LqQnwd7Eg2VA+MHaErBtqZt/jJwAO5dJlwhbz37P/44xgF9rZdIEE+F6UTEMAW1Zsdhk35f0lUV8rMcqdpn78UYT2e5rRMZ4IcDBG6CGAE9p5/iwjYrVt085p5veND1voJZYZFciu+0FDDzp9HQagXX0yNPuSHprOW1SxDrpkVewY6ptpWghBiOu/imriYoyv7X24tTiVUkGzUBe0U6aivVKYcl9piPn7n/k8/H4RVNquTIT1JtowELkgy3wmm0D41nhiS0h9aX5l8ng2vOfBkkkJk504avv2a19BDt1bliTYakHXw4K28yuJlusvMCHH//rpX0RwHCC0tiQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PS6w/EOMirDDdRDO640GZz4QeoOFV3yy3/9q/nmXX/Q=;
 b=U1UImSzZCFimdrVitK7m+uwin9nUQCVn1qOL+Owa23+y666mcKX0ZPQ3zd5d4WotHc08Wb8kcBC7RFUHEvO6lvEPJmRpbtX0bzQehMKBYogZ36nFdTix5wDkeKbT8tLGfYi+wUYuDjvfUjOhke319A4pH/LbVTnZi2cyqN/y/TqFl+J/DfuJBf0k9obm8gvnCrPY/35Lj8mVeuDfpde63tVaf03Sz+P58DW5tW0rQncjgJi+tEnn7RJ558+2+W94NJ0jmpeRNDUzm1FzzgDgkX0pHFAW4at23qnVuGHzgEt5OAGY9HmTgR1/4v8h5gz1S9exHDIR2QKblhWjfi1d5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PS6w/EOMirDDdRDO640GZz4QeoOFV3yy3/9q/nmXX/Q=;
 b=e+ewFYnylv5bRTgIsuRpzCcCE0f62Lshsa9p+ViXnvPjSNd/McXnvlMb0LH5cixiDMRaAA7oPBaR7ThxAWteWnuIgIwVZcvBjrV6v8t5EnKmOXv/i1hUQuz7+zrG353zIFMBA2zpzvtAjbl0sPh5NhB0gcM241/2Lh4W5PbGRco=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4894.eurprd04.prod.outlook.com (20.177.48.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Wed, 6 Nov 2019 22:47:42 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2430.023; Wed, 6 Nov 2019
 22:47:42 +0000
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
Date:   Wed, 6 Nov 2019 22:47:42 +0000
Message-ID: <VI1PR04MB70239026F32223F80F92C607EE790@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <1553692845-20983-1-git-send-email-abel.vesa@nxp.com>
 <1553701479.2561.38.camel@pengutronix.de>
 <564216aa-1144-71de-e887-00c58f466bf5@arm.com>
 <1553702767.2561.40.camel@pengutronix.de>
 <85c91392-9cbf-a5fc-b037-3d58f2b0ac9c@arm.com>
 <cb2e5521cc0d29b7c3ac42a6717256ec2e8d35e6.camel@nxp.com>
 <20190328104542.GA27459@e107981-ln.cambridge.arm.com>
 <ebf1b5f3-1612-9dae-72bb-cc67be69ebf2@gmail.com>
 <VI1PR04MB7023BCCCE80A02B00F5F2ED0EE790@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <8e5de17a-b81b-fa92-3ffc-58ddb5b864b3@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fcb88f4c-1ab0-49bb-e6be-08d7630b5531
x-ms-traffictypediagnostic: VI1PR04MB4894:|VI1PR04MB4894:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4894AF4173622F71B49909E6EE790@VI1PR04MB4894.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(189003)(199004)(86362001)(6246003)(316002)(6436002)(45080400002)(4326008)(966005)(478600001)(5660300002)(14454004)(52536014)(71200400001)(71190400001)(14444005)(66066001)(256004)(8936002)(3846002)(6116002)(99286004)(81156014)(81166006)(8676002)(6306002)(110136005)(55016002)(25786009)(2906002)(54906003)(26005)(7736002)(102836004)(9686003)(486006)(53546011)(229853002)(6506007)(74316002)(44832011)(33656002)(305945005)(6636002)(66946007)(64756008)(66476007)(476003)(66556008)(186003)(91956017)(76116006)(7696005)(76176011)(66446008)(7416002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4894;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 87uCFhtSVzcMgIqFyIFGgyTpfOE4c4e/T1UzEUv/g7c08UjJ0Ib2DmPhl/9AQjyDGdr/7d2Ea30Hj7CUSWzDIh0GRx6kohoYzOPsq+HEiVwveW7sE6jb25fSXL9iuFDe9e3NEJoMjcdpcAIfvLtTGnDnW7XFgTML+6cLKqm3JySL6Rq3ahdiWxzsyLNvQh3drdsV19k67Fwa+8JfFSJtwwciEUdR5j1bEgRVhmXjhNXpXHqH0FRmS2B7Hp/R+N7vRbGdBjSOgUxE5A55PG6TfBkNE05LwTsONHXRQCQ7mk1T0jAZ6siwakDXVUkkvanJs04B+1QggIhaVgJBFVNLDrj3RpWawbbraK1Beaz16+adj4ONYvagxkIsXvvBCYUPJzP3c1DE/bXjEig89kBYUWGDPp0pj01UYaNBBDVcVT0wspWm5kccuTTbGAV49/co6UtpAw8+AVCQpOMl5VZeYlG5EJCM4We4zYqsm9kzLEA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb88f4c-1ab0-49bb-e6be-08d7630b5531
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 22:47:42.0492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fxtiAMdzzub+W/aib3KSpdIFfxOA2w45em9+BNUdRu3XIRa2cFkjQPzQ8/WcQ0ImH9+hcMZ9WngPmRwgJAz4ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4894
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07.11.2019 00:10, Florian Fainelli wrote:=0A=
> On 11/6/19 1:31 PM, Leonard Crestez wrote:=0A=
>> On 06.11.2019 22:15, Florian Fainelli wrote:=0A=
>>> On 3/28/19 3:45 AM, Lorenzo Pieralisi wrote:=0A=
>>>> On Wed, Mar 27, 2019 at 06:40:07PM +0000, Leonard Crestez wrote:=0A=
>>>>> On Wed, 2019-03-27 at 17:45 +0000, Marc Zyngier wrote:=0A=
>>>>>> On 27/03/2019 16:06, Lucas Stach wrote:=0A=
>>>>>>> Am Mittwoch, den 27.03.2019, 15:57 +0000 schrieb Marc Zyngier:=0A=
>>>>>>>> On 27/03/2019 15:44, Lucas Stach wrote:=0A=
>>>>>>>>> Am Mittwoch, den 27.03.2019, 13:21 +0000 schrieb Abel Vesa:=0A=
>>>>>>>>>> This work is a workaround I'm looking into (more as a background=
 task)=0A=
>>>>>>>>>> in order to add support for cpuidle on i.MX8MQ based platforms.=
=0A=
>>>>>>>>>>=0A=
>>>>>>>>>> The main idea here is getting around the missing GIC wake_reques=
t signal=0A=
>>>>>>>>>> (due to integration design issue) by waking up a each individual=
 core through=0A=
>>>>>>>>>> some dedicated SW power-up bits inside the power controller (GPC=
) right before=0A=
>>>>>>>>>> every IPI is requested for that each individual core.=0A=
>>>>>>>>>=0A=
>>>>>>>>> Just a general comment, without going into the details of this se=
ries:=0A=
>>>>>>>>> this issue is not only affecting IPIs, but also MSIs terminated a=
t the=0A=
>>>>>>>>> GIC. Currently MSIs are terminated at the PCIe core, but terminat=
ing=0A=
>>>>>>>>> them at the GIC is clearly preferable, as this allows assigning C=
PU=0A=
>>>>>>>>> affinity to individual MSIs and lowers IRQ service overhead.=0A=
>>>>>>>>>=0A=
>>>>>>>>> I'm not sure what the consequences are for upstream Linux support=
 yet,=0A=
>>>>>>>>> but we should keep in mind that having a workaround for IPIs is o=
nly=0A=
>>>>>>>>> solving part of the issue.=0A=
>>>>>>>>=0A=
>>>>>>>> If this erratum is affecting more than just IPIs, then indeed I do=
n't=0A=
>>>>>>>> see how this patch series solves anything.=0A=
>>>>>>>>=0A=
>>>>>>>> But the erratum documentation seems to imply that only SGIs are=0A=
>>>>>>>> affected, and goes as far as suggesting to use an external interru=
pt=0A=
>>>>>>>> would solve it. How comes this is not the case? Or is it that anyt=
hing=0A=
>>>>>>>> directly routed to a redistributor is also affected? This would br=
eak=0A=
>>>>>>>> LPIs (and thus MSIs) and PPIs (the CPU timer, among others).=0A=
>>>>>>>=0A=
>>>>>>> Anything that isn't visible to the GPC and requires the GIC=0A=
>>>>>>> wake_request signal to behave as specified is broken by this erratu=
m.=0A=
>>>>>>=0A=
>>>>>> I really wonder how a timer interrupt (a PPI, hence not routed throu=
gh=0A=
>>>>>> the GPC) can wake up the CPU in this case. It really feels like=0A=
>>>>>> something like "program CNTV_CVAL_EL0 to expire at some later point;=
=0A=
>>>>>> WFI" could result in the CPU going to a deep sleep state, and not=0A=
>>>>>> wake-up at all.=0A=
>>>>>=0A=
>>>>> This is already a common issue for cpuidle implementions handled by t=
he=0A=
>>>>> "local-timer-stop" property. imx has other timer blocks in the SOC,=
=0A=
>>>>> they generate SPIs which are connected to GPC.=0A=
>>>>=0A=
>>>> It is not a common issue. The tick-broadcast mechanism relies on=0A=
>>>> IPIs that are sent to specific CPUs upon timer expiry.=0A=
>>>>=0A=
>>>> If IPIs don't work for CPUs in shutdown state (which is what this patc=
h=0A=
>>>> is fixing AFAIU), the only reason I can see how a CPU can resume from=
=0A=
>>>> idle on a timer expiry is the GPC waking up all cores upon the global=
=0A=
>>>> timer SPI; if that's the case there is precious little point in=0A=
>>>> implementing CPUidle at all - too bad people worked hard to implement=
=0A=
>>>> NOHZ in a power efficient manner.=0A=
>>>>=0A=
>>>>>> This would indicate that not only cpuidle is broken with this, but=
=0A=
>>>>>> absolutely every interrupt that is not routed through the GPC.=0A=
>>>>>=0A=
>>>>> Yes, cpuidle is broken for irqs not routed through GPC. However:=0A=
>>>>>=0A=
>>>>> * All SPIs are connected to GPC in a 1:1 mapping=0A=
>>>>> * This series deals with SGIs=0A=
>>>>> * The timer PPIs are not required; covered by local-timer-stop=0A=
>>>>> * LPIs are currently unused (I understand imx-pci uses SPI by default=
=0A=
>>>>> from Lucas)=0A=
>>>>>=0A=
>>>>> Anything missing?=0A=
>>>>=0A=
>>>> Yes, LPIs must be able to wake up CPUs and only the CPU for which=0A=
>>>> an IRQ is actually pending.=0A=
>>>>=0A=
>>>> >From an architectural perspective, an ARM core executing the WFI=0A=
>>>> instruction must resume execution upon an IRQ occurrence targeted=0A=
>>>> at it and that's true regardless of the idle state entered.=0A=
>>>>=0A=
>>>> Anything deviating from this behaviour is not architecture compliant.=
=0A=
>>>=0A=
>>> What if you enter a deeper state than WFI, which leads to the power=0A=
>>> gating of your CPU core, and you are missing the necessary hardware tha=
t=0A=
>>> should be driven from the GIC's nIRQOUT/nFIQOUT signals to automaticall=
y=0A=
>>> bring the core back on upon the GIC seeing a pending interrupt targetin=
g=0A=
>>> that core?=0A=
>>=0A=
>> imx8mq has a secondary "GPC" block which receives SPIs and can wake the=
=0A=
>> cores. Do you have something similar? Because if you only have the GIC=
=0A=
>> then that sounds much worse: you'd have to ensure that all peripheral=0A=
>> interrupts are routed away from sleeping cores.=0A=
> =0A=
> We have a legacy interrupt controller that receives all SPIs as well,=0A=
> and it can be used as a full replacement for the GIC (with the loss of=0A=
> nVIRQ/nFIQ) but it cannot wake-up the cores unfortunately. This is all=0A=
> custom logic, so we could have done at least wake-up based on SPIs, but=
=0A=
> we missed that apparently, at least we were consistent.=0A=
> =0A=
> Out of curiosity, does your GPC somehow know the affinity of a given=0A=
> interrupt to a particular core?=0A=
=0A=
Yes, if it's told by software. There are mask and status registers for =0A=
each SPI for each core in GPC but AFAIK GIC bits are unrelated.=0A=
=0A=
>> On IMX only SGIs need special treatment and a newer version just=0A=
>> replaces __smp_cross_call in a platform-specific manner:=0A=
>>=0A=
>>       https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%=
2Flkml.org%2Flkml%2F2019%2F6%2F10%2F350&amp;data=3D02%7C01%7Cleonard.creste=
z%40nxp.com%7Ce019c8afbfff487ef72208d7630629f3%7C686ea1d3bc2b4c6fa92cd99c5c=
301635%7C0%7C1%7C637086750468897744&amp;sdata=3DSPCLEZJU5bpTrs8vQNQ7CuBWmlF=
8f3uyPaNUB%2F%2BAm%2Fs%3D&amp;reserved=3D0=0A=
> =0A=
> Right, because for PPIs you leverage the timer broadcast and for SPIs=0A=
> you have that GPC, so all your left are the remaining "intra GIC"=0A=
> interrupts which are SGIs.=0A=
> =0A=
>>> Would it be acceptable in that case to "help" the platform by ensuring=
=0A=
>>> that there is at least one core that is not allowed to enter the deepes=
t=0A=
>>> idle state and be able to help wake back up the others? I am asking=0A=
>>> because I am facing a similar issue to what Abel is trying to solve her=
e=0A=
>>> with ARCH_BRCMSTB platforms which do not have the ability to have their=
=0A=
>>> CPU cores wake-up on their once power gated.=0A=
>>=0A=
>> Maybe you can workaround in ATF: if (last_core) wfi(); else powerdown();=
=0A=
> =0A=
> Yes, that would certainly work, the biggest problem in my case is=0A=
> dealing with SPIs, since we still have no way to wake-up from those,=0A=
> other than by getting the help of another CPU that is not power gated.=0A=
> Lovely, I know.=0A=
=0A=
By default irqs are only routed to core0 so maybe you could only power =0A=
down if your core has no irqs enabled? It might even be possible to do =0A=
this by reading GIC registers in ATF but this might race with other GIC =0A=
manipulation from kernel.=0A=
=0A=
Perhaps your workarounds could also be encapsulated into a =0A=
platform-specific irqchip implementation which occasionally pokes at ATF.=
=0A=
=0A=
>> But you still need special treatment for interrupts targeted at gated co=
res.=0A=
>>=0A=
>>>>> My understanding is that this wake request feature via GIC is new in =
v3=0A=
>>>>> and this is maybe why HW team missed it during integration. Older=0A=
>>>>> imx6/7 has GICv2 and has deep idle states which always rely on GPC to=
=0A=
>>>>> wakeup so the approach can work.=0A=
>>>>=0A=
>>>> If HW designers really wanted to have sensible power management policy=
=0A=
>>>> in this SoC they would have paid attention, I am against patching the=
=0A=
>>>> kernel heavily to fix a platform bug.=0A=
>>=0A=
>>> HW designers may not be aware of how the cpuifle framework operates or=
=0A=
>>> what its constraints are, so they may not understand that any interrupt=
,=0A=
>>> must be able to autonomously (with lack of a better name) wake-up a=0A=
>>> given core, given any idle state it has entered.=0A=
>>=0A=
>> My understanding is that this is a requirement of GICv3 architecture.=0A=
>>=0A=
> =0A=
> The systems I use have a GICv2 architecture though this is still no=0A=
> excuse for not having hooked the nIRQOUT/nFIQOUT to a power management=0A=
> controller, this is clearly an oversight, and it should have been=0A=
> possible to automatically take a core out of power gating, since we did=
=0A=
> design our own power gating logic, but this was done that way. Hopefully=
=0A=
> future designs can remedy that, designers are aware of why this is a=0A=
> problem now.=0A=
> --=0A=
> Florian=0A=
> =0A=
=0A=
