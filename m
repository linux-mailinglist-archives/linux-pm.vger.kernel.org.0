Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 668FF194604
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 19:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgCZSG4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 14:06:56 -0400
Received: from mail-eopbgr30077.outbound.protection.outlook.com ([40.107.3.77]:3493
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726163AbgCZSG4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Mar 2020 14:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iezzh8alfXWq/o78ep2jgZZaUW1/+x/Q8QGTcUnbyPA=;
 b=M/hXemF+Ce6GPsC6anGwwv5pOepnh47GbbUv48rj3sOjvsQDEsNc2Ybn6udJ4dGlhvvyTRh0UZKnJCLwFQeR3M8a5ppHm9dpqHxIf7j183txcBCRE7SfJTOdOEhq07jqYhfclskr2pJEU4GWND0kTFTMMgckDY47nYz26Vhu8Zs=
Received: from DB6PR1001CA0036.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:55::22)
 by AM6PR08MB5142.eurprd08.prod.outlook.com (2603:10a6:20b:d4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Thu, 26 Mar
 2020 18:06:48 +0000
Received: from DB5EUR03FT031.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:55:cafe::1) by DB6PR1001CA0036.outlook.office365.com
 (2603:10a6:4:55::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19 via Frontend
 Transport; Thu, 26 Mar 2020 18:06:48 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT031.mail.protection.outlook.com (10.152.20.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.17 via Frontend Transport; Thu, 26 Mar 2020 18:06:48 +0000
Received: ("Tessian outbound 6835489d965f:v48"); Thu, 26 Mar 2020 18:06:48 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 21ab9885a03caf95
X-CR-MTA-TID: 64aa7808
Received: from 322cfaa4bbad.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 27D19E96-A770-46D4-97B5-F57134044344.1;
        Thu, 26 Mar 2020 18:06:43 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 322cfaa4bbad.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 26 Mar 2020 18:06:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcJMZQE0IDXj44AtXMj1Mrhbo0aBvX3o8YuuRhSvyoGz+FsKhAWjOnu4jGKKYcumiu/xcWyxx2iepk25SvEhsdFMmtaSqfwmrwcVl2FgAqe7FWT5OUKWwOoCtvQD0FsYss+Kt8kZ2iPUbVabk8KH3E0FF8vysXT9tVQjl9lSV3AUOBzNJSQSYR0jmxgT7W/Q/rwtJzrbvtPjQ41NHdRl8t0+J8mdkAZFyunrLzNRncSHfHDykBZ3oukP66cYstWwtgVoenkaIhjeq4rAmkLWE1TpXx6dJ0nz6741c6uQP1JbxlqcrMSW9MVXOygrGQdaRhlF9lxzmQAXBzsYbAKBIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iezzh8alfXWq/o78ep2jgZZaUW1/+x/Q8QGTcUnbyPA=;
 b=BIKkUm87TkzDD+fVG0sjq0yz5ZUmnyP32sad9prSBq2z48jEpkRnKR4oJDRH/r4eFyeD+XF5GS4eBFlyDmWAHx2oCx4H1kA/cv0WDu3pyhHGs1qQkPrUH5TiBnWHaUY6EIOLZEU9j8sS7SNZRlmH6+V3nvpNGKDynDIh8yz+8Qgeq9EYk4sV3wzj+jAV9iLk+xZLjctEBqQeSd0H1Has5Wcky1us6tTEz6CNsIxNFbeVXLmABFma/4CZBWTgw/MDYrp/CGJl8QX/0Obo0O4bt1eEsWY7OEiEnpLKQ0nCO7JZ9HSb/v9VTovdqg28rFVLSB9HdL4Abb8x1zK+US6iLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iezzh8alfXWq/o78ep2jgZZaUW1/+x/Q8QGTcUnbyPA=;
 b=M/hXemF+Ce6GPsC6anGwwv5pOepnh47GbbUv48rj3sOjvsQDEsNc2Ybn6udJ4dGlhvvyTRh0UZKnJCLwFQeR3M8a5ppHm9dpqHxIf7j183txcBCRE7SfJTOdOEhq07jqYhfclskr2pJEU4GWND0kTFTMMgckDY47nYz26Vhu8Zs=
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Grant.Likely@arm.com; 
Received: from DB8PR08MB4010.eurprd08.prod.outlook.com (20.179.10.207) by
 DB8PR08MB4108.eurprd08.prod.outlook.com (20.179.12.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.22; Thu, 26 Mar 2020 18:06:41 +0000
Received: from DB8PR08MB4010.eurprd08.prod.outlook.com
 ([fe80::4521:d746:9e7:4ae3]) by DB8PR08MB4010.eurprd08.prod.outlook.com
 ([fe80::4521:d746:9e7:4ae3%5]) with mapi id 15.20.2835.023; Thu, 26 Mar 2020
 18:06:41 +0000
Subject: Re: [PATCH v3] driver core: Break infinite loop when deferred probe
 can't be satisfied
To:     Greg KH <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Saravana Kannan <saravanak@google.com>, a.hajda@samsung.com,
        artem.bityutskiy@linux.intel.com, balbi@kernel.org,
        broonie@kernel.org, fntoth@gmail.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, peter.ujfalusi@ti.com, rafael@kernel.org,
        kernel-team@android.com, nd <nd@arm.com>
References: <20200324175719.62496-1-andriy.shevchenko@linux.intel.com>
 <20200325032901.29551-1-saravanak@google.com>
 <20200325125120.GX1922688@smile.fi.intel.com>
 <295d25de-f01e-26de-02d6-1ac0c149d828@arm.com>
 <20200326163110.GD1922688@smile.fi.intel.com>
 <20200326163953.GA1551380@kroah.com>
From:   Grant Likely <grant.likely@arm.com>
Message-ID: <9350ec52-345f-5c3c-f175-4e256699b9cf@arm.com>
Date:   Thu, 26 Mar 2020 18:06:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200326163953.GA1551380@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0129.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::21) To DB8PR08MB4010.eurprd08.prod.outlook.com
 (2603:10a6:10:ab::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.16.141] (92.40.174.0) by LO2P265CA0129.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9f::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18 via Frontend Transport; Thu, 26 Mar 2020 18:06:38 +0000
X-Originating-IP: [92.40.174.0]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3b9df13d-fe1c-4c80-8695-08d7d1b073f2
X-MS-TrafficTypeDiagnostic: DB8PR08MB4108:|AM6PR08MB5142:
X-Microsoft-Antispam-PRVS: <AM6PR08MB51429E0407C86E537CACE26495CF0@AM6PR08MB5142.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;OLM:5797;
X-Forefront-PRVS: 0354B4BED2
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(110136005)(66946007)(6486002)(54906003)(36756003)(66476007)(8676002)(66556008)(81166006)(7416002)(16576012)(52116002)(44832011)(4326008)(31686004)(81156014)(956004)(2616005)(55236004)(26005)(8936002)(16526019)(316002)(186003)(5660300002)(53546011)(31696002)(86362001)(2906002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB4108;H:DB8PR08MB4010.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: +ydPbiw09w0oM7np1qC2vjv+hUs44qsCRVasczwyeDAKSSbvwDej8FO8ZvSk7/90ujmS3l3rqFIqsR9bL2yCWkWw9Q3m471tD4VjwzLY64NwSeEUN5YTG7TOcj3a9k63hF+bW8f209RzdP183MIEGB/rcoB7VJ/R7lbOtuCZA1SaHjMyRum31kNhiBbLkf/2RAWLU3U9bU1uw71RNj4wTNj018vcy9d1vY9dy+zi22DarsXpxnuWFmWhAJM/C8wSxOJgK6i3P73vsxSqC3KGRbHbDSyBbfNe+5TAJpxVma2ScWU6tNBCqAzZ0NTXnEsJsAscvFG3XxbvV8w4JlsHhznSVf1SojbcnDPbNrvEBxX2NTPdJnqCfjuYC9lSAcj0bZzftPpNO5p6aQu9MgrjC3ffzqolVDRSa3VMIDwCYd8XRcqJM9GsiynN/BX0+YhK
X-MS-Exchange-AntiSpam-MessageData: 6xNBo7IvYxYK5kfr4TIemu0CUn3UOi8VmG3iXZA51igGEdoVBKo8njJ+ziiPWW23rYWDkw4ljSD0QjGzx6QOaD4tQlzVfTFVepSvhhVr9kKKo3vSDDdagp4ohsEPKx5ZIsCz1j0KnZfd4DKEeiUKpA==
X-MS-Exchange-Transport-Forked: True
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4108
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Grant.Likely@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT031.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(136003)(39860400002)(346002)(46966005)(186003)(2906002)(16526019)(8936002)(47076004)(316002)(70206006)(8676002)(36756003)(81156014)(31696002)(16576012)(54906003)(81166006)(70586007)(110136005)(26005)(5660300002)(44832011)(26826003)(86362001)(356004)(53546011)(478600001)(4326008)(2616005)(6486002)(956004)(450100002)(82740400003)(336012)(31686004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB5142;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4bb645c2-5f86-47a7-079d-08d7d1b06f29
X-Forefront-PRVS: 0354B4BED2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QIQn0BC3OmdvzYo/Jw/7w2wAabP5hiIJ9kJWLWkmFmIQfr5tXs9z90+isnbPnCnxaRszt63SSxJVN6jCzyXZrZOj+rPLvwCMrWk7IonqNQGQp04f61Uo4vwnqrT9/unmJKAPwBgfKbS3BkhL7Y3PEk+sIu4BbJ4zez5t1XEAMziKtMM74xLR7nADX0iNYqZMt0v6bJIONZLXKOyHGWfuGJ9Rb/vi7cEJJdlwj3AYDr7Y+Wqd2nLBjc812FVGmVwkNoPYfHiAOBCDdwcIFVgUQOQs+DOnmRa0Ld12kH+DSDM0kLVrhXss6vF3DSVPCo6s41OA4+5NIpddXkrrEomrv7cdpf3Fy+ET8vTEQiesPugnqHONsD7apOoC6id/eJVyTn7fR4UR2Yw7OzGlr+BvUmOfQS6BRluTb6jloaXu5U93pv9UhcVrmHEeqXSIziDd0gA3WDjxM5xYYoRHCDM7jC1JfvsQEPVvTQejcjfPAXevRzsa8sBhamNsz0lb0+1hiP8pwGEIduycvF9lTSFEww==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2020 18:06:48.5797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9df13d-fe1c-4c80-8695-08d7d1b073f2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5142
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 26/03/2020 16:39, Greg KH wrote:
> On Thu, Mar 26, 2020 at 06:31:10PM +0200, Andy Shevchenko wrote:
>> On Thu, Mar 26, 2020 at 03:01:22PM +0000, Grant Likely wrote:
>>> On 25/03/2020 12:51, Andy Shevchenko wrote:
>>>> On Tue, Mar 24, 2020 at 08:29:01PM -0700, Saravana Kannan wrote:
>>>>> On Tue, Mar 24, 2020 at 5:38 AM Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>>>>>> Consider the following scenario.
>>>>>>
>>>>>> The main driver of USB OTG controller (dwc3-pci), which has the following
>>>>>> functional dependencies on certain platform:
>>>>>> - ULPI (tusb1210)
>>>>>> - extcon (tested with extcon-intel-mrfld)
>>>>>>
>>>>>> Note, that first driver, tusb1210, is available at the moment of
>>>>>> dwc3-pci probing, while extcon-intel-mrfld is built as a module and
>>>>>> won't appear till user space does something about it.
>>>>>>
>>>>>> This is depicted by kernel configuration excerpt:
>>>>>>
>>>>>> 	CONFIG_PHY_TUSB1210=y
>>>>>> 	CONFIG_USB_DWC3=y
>>>>>> 	CONFIG_USB_DWC3_ULPI=y
>>>>>> 	CONFIG_USB_DWC3_DUAL_ROLE=y
>>>>>> 	CONFIG_USB_DWC3_PCI=y
>>>>>> 	CONFIG_EXTCON_INTEL_MRFLD=m
>>>>>>
>>>>>> In the Buildroot environment the modules are probed by alphabetical ordering
>>>>>> of their modaliases. The latter comes to the case when USB OTG driver will be
>>>>>> probed first followed by extcon one.
>>>>>>
>>>>>> So, if the platform anticipates extcon device to be appeared, in the above case
>>>>>> we will get deferred probe of USB OTG, because of ordering.
>>>>>>
>>>>>> Since current implementation, done by the commit 58b116bce136 ("drivercore:
>>>>>> deferral race condition fix") counts the amount of triggered deferred probe,
>>>>>> we never advance the situation -- the change makes it to be an infinite loop.
>>>>>
>>>>> Hi Andy,
>>>>>
>>>>> I'm trying to understand this sequence of steps. Sorry if the questions
>>>>> are stupid -- I'm not very familiar with USB/PCI stuff.
>>>>
>>>> Thank you for looking into this. My answer below.
>>>>
>>>> As a first thing I would like to tell that there is another example of bad
>>>> behaviour of deferred probe with no relation to USB. The proposed change also
>>>> fixes that one (however, less possible to find in real life).
>>>>
>>>>>> ---8<---8<---
>>>>>>
>>>>>> [   22.187127] driver_deferred_probe_trigger <<< 1
>>>>>>
>>>>>> ...here is the late initcall triggers deferred probe...
>>>>>>
>>>>>> [   22.191725] platform dwc3.0.auto: deferred_probe_work_func in deferred list
>>>>>>
>>>>>> ...dwc3.0.auto is the only device in the deferred list...
>>>>>
>>>>> Ok, dwc3.0.auto is the only unprobed device at this point?
>>>>
>>>> Correct.
>>>>
>>>>>> [   22.198727] platform dwc3.0.auto: deferred_probe_work_func 1 <<< counter 1
>>>>>>
>>>>>> ...the counter before mutex is unlocked is kept the same...
>>>>>>
>>>>>> [   22.205663] platform dwc3.0.auto: Retrying from deferred list
>>>>>>
>>>>>> ...mutes has been unlocked, we try to re-probe the driver...
>>>>>>
>>>>>> [   22.211487] bus: 'platform': driver_probe_device: matched device dwc3.0.auto with driver dwc3
>>>>>> [   22.220060] bus: 'platform': really_probe: probing driver dwc3 with device dwc3.0.auto
>>>>>> [   22.238735] bus: 'ulpi': driver_probe_device: matched device dwc3.0.auto.ulpi with driver tusb1210
>>>>>> [   22.247743] bus: 'ulpi': really_probe: probing driver tusb1210 with device dwc3.0.auto.ulpi
>>>>>> [   22.256292] driver: 'tusb1210': driver_bound: bound to device 'dwc3.0.auto.ulpi'
>>>>>> [   22.263723] driver_deferred_probe_trigger <<< 2
>>>>>>
>>>>>> ...the dwc3.0.auto probes ULPI, we got successful bound and bumped counter...
>>>>>>
>>>>>> [   22.268304] bus: 'ulpi': really_probe: bound device dwc3.0.auto.ulpi to driver tusb1210
>>>>>
>>>>> So where did this dwc3.0.auto.ulpi come from?
>>>>
>>>>> Looks like the device is created by dwc3_probe() through this call flow:
>>>>> dwc3_probe() -> dwc3_core_init() -> dwc3_core_ulpi_init() ->
>>>>> dwc3_ulpi_init() -> ulpi_register_interface() -> ulpi_register()
>>>>
>>>> Correct.
>>>>
>>>>>> [   22.276697] platform dwc3.0.auto: Driver dwc3 requests probe deferral
>>>>>
>>>>> Can you please point me to which code patch actually caused the probe
>>>>> deferral?
>>>>
>>>> Sure, it's in drd.c.
>>>>
>>>> if (device_property_read_string(dev, "linux,extcon-name", &name) == 0) {
>>>>     edev = extcon_get_extcon_dev(name);
>>>>     if (!edev)
>>>>       return ERR_PTR(-EPROBE_DEFER);
>>>>     return edev;
>>>> }
>>>>
>>>>>> ...but extcon driver is still missing...
>>>>>>
>>>>>> [   22.283174] platform dwc3.0.auto: Added to deferred list
>>>>>> [   22.288513] platform dwc3.0.auto: driver_deferred_probe_add_trigger local counter: 1 new counter 2
>>>>>
>>>>> I'm not fully aware of all the USB implications, but if extcon is
>>>>> needed, why can't that check be done before we add and probe the ulpi
>>>>> device? That'll avoid this whole "fake" probing and avoid the counter
>>>>> increase. And avoid the need for this patch that's touching the code
>>>>> code that's already a bit delicate.
>>>>
>>>>> Also, with my limited experience with all the possible drivers in the
>>>>> kernel, it's weird that the ulpi device is added and probed before we
>>>>> make sure the parent device (dwc3.0.auto) can actually probe
>>>>> successfully.
>>>>
>>>> As I said above the deferred probe trigger has flaw on its own.
>>>> Even if we fix for USB case, there is (and probably will be) others.
>>>
>>> Right here is the driver design bug. A driver's probe() hook should *not*
>>> return -EPROBE_DEFER after already creating child devices which may have
>>> already been probed.
>>
>> Any documentation statement for this requirement?
> 
> There shouldn't be.  If you return ANY error from a probe function, your
> driver is essencially "dead" when it comes to that device, and it had
> better have cleaned up after itself. >
> That includes defering probe, that's not "special" here at all.

What is special in this case is that if a .probe() hook had registered a 
child device, then removed that child device (so it did clean up after 
itself) and then return -EPROBE_DEFER, then we end up in an endless 
probe loop.

But this is unusual behaviour. Normally a .probe() hook checks all 
required resources are available before registering any child devices. 
This driver doesn't do that. Arguably this is indeed an additional 
requirement beyond "clean up after yourself". I cannot find anyplace 
where it is documented. In fact, I cannot find any documentation on 
EPROBE_DEFER in the Documentation/ tree. How about the below?

>> By the way, I may imagine other mechanisms that probe the driver on other CPU
>> at the same time (let's consider parallel modprobes). The current code has a
>> flaw with that.
> 
> That can't happen, the driver core prevents that.

Greg's right, that can't happen. At worst a driver will get an 
additional defer event; but it all still works.

g.

---
diff --git a/Documentation/driver-api/driver-model/driver.rst 
b/Documentation/driver-api/driver-model/driver.rst
index baa6a85c8287..46adede13aba 100644
--- a/Documentation/driver-api/driver-model/driver.rst
+++ b/Documentation/driver-api/driver-model/driver.rst
@@ -167,7 +167,17 @@ the driver to that device.

  A driver's probe() may return a negative errno value to indicate that
  the driver did not bind to this device, in which case it should have
-released all resources it allocated::
+released all resources it allocated. Optionally, probe() may return
+-EPROBE_DEFER if the driver depends on resources that are not yet
+available (e.g., supplied by a driver that hasn't initialized yet).
+The driver core will put the device onto the deferred probe list and
+will try to call it again later. Important: -EPROBE_DEFER must not be
+returned if probe() has already created child devices, even if those
+child devices have were removed again in a cleanup path. If -EPROBE_DEFER
+is returned after a child device has been registered, it may result in an
+infinite loop of .probe() calls to the same driver.
+
+::

         void (*sync_state)(struct device *dev);

