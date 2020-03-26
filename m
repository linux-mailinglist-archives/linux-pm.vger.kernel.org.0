Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB48E19423A
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 16:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgCZPBj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 11:01:39 -0400
Received: from mail-eopbgr60077.outbound.protection.outlook.com ([40.107.6.77]:11076
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726270AbgCZPBj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Mar 2020 11:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/keb0i3y+TnVvnV0vL5cphukEr4c02ZQ6Dijr96Qsk=;
 b=UlFYqC10dLV3OndlIwf6g+X/nmAq2w4xuru2zHBsYGvaWKu4831PGPorgw/j44cie1BmwO+P95bihLKeyzUQVbp8oJP9Diuqz2IA2WHF5h3YC1lwPWRvSYdSQoqGMZLUFdYKEsov20WJcOwduy9vp8+WfnXD4wY90W109lHZ7h4=
Received: from DB6PR0201CA0017.eurprd02.prod.outlook.com (2603:10a6:4:3f::27)
 by HE1PR08MB2697.eurprd08.prod.outlook.com (2603:10a6:7:30::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Thu, 26 Mar
 2020 15:01:34 +0000
Received: from DB5EUR03FT013.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:3f:cafe::60) by DB6PR0201CA0017.outlook.office365.com
 (2603:10a6:4:3f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19 via Frontend
 Transport; Thu, 26 Mar 2020 15:01:33 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT013.mail.protection.outlook.com (10.152.20.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.17 via Frontend Transport; Thu, 26 Mar 2020 15:01:33 +0000
Received: ("Tessian outbound 8f06d475fc37:v48"); Thu, 26 Mar 2020 15:01:33 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 39ab38604e06adfa
X-CR-MTA-TID: 64aa7808
Received: from 32cc9d150553.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0D510BAB-A375-488C-8A0C-9D96C80D7AD0.1;
        Thu, 26 Mar 2020 15:01:28 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 32cc9d150553.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 26 Mar 2020 15:01:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAwgDJLIbL70VeHmpMYQ0k/7N/2zyTQzk1tsBY+M9QY5/sQKmNkKYJYivrJrru2X7zsIxIQg7u2TEtbaVptyD7juZbAOUDTXOkc0op/L7r8MmsHjuJ+22F4B2lfaspQBBlXKl2V/gZWIp9pi50L3Xzl6pUbuyjOUCHTDZE3mSYibL/oeYCsvBJFjC+mnswLdOniZes5qr11c3PBpB/QvVMGQPIxJBIR/SgFVeET+Oha7rBdFhXzeQ/3DiWk7AvNiN/qh6g5eKBvbhn0nP5FGRzm/7mdxH5uV2p7dJmbtzzJSeEG8mZPs6/r3FOnkdnc+tQjB2jW/u4tAtiO1MX+cKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/keb0i3y+TnVvnV0vL5cphukEr4c02ZQ6Dijr96Qsk=;
 b=WrMLA1p92xfx+Ael6GujMpqyIseELJAnZq5hLvXNbue56JJgBIPA7QyOaTfEaM34KKLNgPSC2BZNwQDX5k9zs4ZHz8q9uP1Qo0fuO4RXW9Xl2vxFpsR3oL+Ef0OLu2bavYQKe99PvHI+0Jg4REmSi78+xBHUIhsqCW8XCMhoHnAFAO4stAP2O40Y3Am4dQE1zVEfjjf9AY2e0k1Yvy4/793JjOWreGVrqHm0Ocui3YuzPdSIpwhv2uLIbKcOu8jSl4DrYEk8S8TzCAMRkqqlJllf7dc5BVGdV3LJjO2MAf0CkTCDxPrihAbx/vKYO9OeheHiiIWju2xMz8PugO2lHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/keb0i3y+TnVvnV0vL5cphukEr4c02ZQ6Dijr96Qsk=;
 b=UlFYqC10dLV3OndlIwf6g+X/nmAq2w4xuru2zHBsYGvaWKu4831PGPorgw/j44cie1BmwO+P95bihLKeyzUQVbp8oJP9Diuqz2IA2WHF5h3YC1lwPWRvSYdSQoqGMZLUFdYKEsov20WJcOwduy9vp8+WfnXD4wY90W109lHZ7h4=
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Grant.Likely@arm.com; 
Received: from DB8PR08MB4010.eurprd08.prod.outlook.com (20.179.10.207) by
 DB8PR08MB4172.eurprd08.prod.outlook.com (20.179.11.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Thu, 26 Mar 2020 15:01:25 +0000
Received: from DB8PR08MB4010.eurprd08.prod.outlook.com
 ([fe80::4521:d746:9e7:4ae3]) by DB8PR08MB4010.eurprd08.prod.outlook.com
 ([fe80::4521:d746:9e7:4ae3%5]) with mapi id 15.20.2835.023; Thu, 26 Mar 2020
 15:01:25 +0000
Subject: Re: [PATCH v3] driver core: Break infinite loop when deferred probe
 can't be satisfied
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Saravana Kannan <saravanak@google.com>
Cc:     a.hajda@samsung.com, artem.bityutskiy@linux.intel.com,
        balbi@kernel.org, broonie@kernel.org, fntoth@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, peter.ujfalusi@ti.com, rafael@kernel.org,
        kernel-team@android.com, nd <nd@arm.com>
References: <20200324175719.62496-1-andriy.shevchenko@linux.intel.com>
 <20200325032901.29551-1-saravanak@google.com>
 <20200325125120.GX1922688@smile.fi.intel.com>
From:   Grant Likely <grant.likely@arm.com>
Message-ID: <295d25de-f01e-26de-02d6-1ac0c149d828@arm.com>
Date:   Thu, 26 Mar 2020 15:01:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200325125120.GX1922688@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CWLP123CA0152.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:88::20) To DB8PR08MB4010.eurprd08.prod.outlook.com
 (2603:10a6:10:ab::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.16.141] (92.40.174.1) by CWLP123CA0152.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:88::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19 via Frontend Transport; Thu, 26 Mar 2020 15:01:24 +0000
X-Originating-IP: [92.40.174.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3d19d99b-a48a-4a22-09e1-08d7d1969300
X-MS-TrafficTypeDiagnostic: DB8PR08MB4172:|HE1PR08MB2697:
X-Microsoft-Antispam-PRVS: <HE1PR08MB2697ADE736A9943D689687D995CF0@HE1PR08MB2697.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;OLM:5797;
X-Forefront-PRVS: 0354B4BED2
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(66476007)(86362001)(4326008)(7416002)(186003)(53546011)(52116002)(6486002)(5660300002)(66556008)(55236004)(478600001)(44832011)(66946007)(110136005)(16526019)(31696002)(956004)(2616005)(26005)(8676002)(36756003)(316002)(16576012)(81156014)(81166006)(8936002)(31686004)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB4172;H:DB8PR08MB4010.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: CBxcAqcLJOjrKnUdy7m3WA5ue6WyXgxCHJN9a69OfTkS3LKe2rqZbNv3OaspgTALiv6XnQY2Dq2+jZPQvmhNPgIk1WAzrOv4J/tA8bbyv2jER5fNjDiD9xMcDyn1U/33pJMRr1/K1RmgUQMNPpqQoUeRvDV4DG1ovYM3+8PkJ+8lPXXdTt1u/Gwmdenu1TyOxX8vLg3iGgsqeN7kbZ8WgW4egHGyINgyNYoz9SPY65YJcaMm8dCWbRKe2I54iB0ZVxcxrHKwDLpSisMvsKW68fQpQl7lIzbmbPVBNL6sfGLTdYZ2VTiOZiYYWDwU++y26SFdN0C/YPnJjZaaZ1nww3Frh9Y+enfOg7JlXOjDuap//dfOc6bnIXcHc0zk24/ePzukNVtnOSschtXNfU9omwYqsP/L+sfMjZTOOmGkB0EqN8qAybkaiyAxqM+k8G7T
X-MS-Exchange-AntiSpam-MessageData: hsOUBBfcrvedeSwXka8gwObhC7QB/e2699W7KqmRL/buFLZe4doc4LhriiZxiNgGEqtMaws2c9ivPqJurL8LbvoS07zHWi2QqEWV3ubhugtYxpglAhnhn7+aS4geYp19fkGxttvs03vqj/Pow72k0w==
X-MS-Exchange-Transport-Forked: True
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4172
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Grant.Likely@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT013.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(136003)(396003)(46966005)(36756003)(5660300002)(110136005)(2616005)(316002)(16576012)(82740400003)(53546011)(956004)(2906002)(6486002)(356004)(450100002)(86362001)(31686004)(44832011)(4326008)(47076004)(8936002)(186003)(26826003)(70206006)(26005)(478600001)(81156014)(336012)(81166006)(8676002)(31696002)(70586007)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR08MB2697;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0ac9ce5d-738d-4780-b3b5-08d7d1968e0f
X-Forefront-PRVS: 0354B4BED2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rCZc/04sO1+QPiCbQ3sih+v5tHQ5Zwq9M4wap5hwSa7scgL2pESD7G9QOwMtejrbx21ct89Mbv6UeJG2PTk2tEsXqLJqmoEMAoEH0SJ5UErnLgFzAJasmn1pm2j5lP0FGUNhNDHAJi+B4VmBUicydFWXlMelhcKSvaMxC36CTN0TAVxPAVVJsM3Zdms1KwvGxVkENiKomX/NEmW+mOUCW1aBLMi74cMynWBIQlA1ZiKf6yo3kRYPF6mJ8GiL3n2aKgMvlxiqePAXUyq5caimrBLuK6ToaIgxvxqomHAGqy7pkM7w4aQQTTi9AoQhoFUj0zX9tr9GCp+mDMQ3SY52OqxygT7Jr+Ulge9e1l71ncOHDoxW6M8gQNXl6PXVqIlhuNtnhhRffgWRxHb/fkXxMosl6Us4kS2TB8cg1jwHcTTlX/hE5ABNOaPuM4qzEKsEnWdeFCAxhXKYDQOYR7qWWfBhwlWD/ukOarMp2RDXaCHNNW2SSwST/GgoKYtJf1/Ii3YamC24r6anNG+ZJODTyQ==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2020 15:01:33.7667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d19d99b-a48a-4a22-09e1-08d7d1969300
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2697
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 25/03/2020 12:51, Andy Shevchenko wrote:
> On Tue, Mar 24, 2020 at 08:29:01PM -0700, Saravana Kannan wrote:
>> On Tue, Mar 24, 2020 at 5:38 AM Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>>> Consider the following scenario.
>>>
>>> The main driver of USB OTG controller (dwc3-pci), which has the following
>>> functional dependencies on certain platform:
>>> - ULPI (tusb1210)
>>> - extcon (tested with extcon-intel-mrfld)
>>>
>>> Note, that first driver, tusb1210, is available at the moment of
>>> dwc3-pci probing, while extcon-intel-mrfld is built as a module and
>>> won't appear till user space does something about it.
>>>
>>> This is depicted by kernel configuration excerpt:
>>>
>>> 	CONFIG_PHY_TUSB1210=y
>>> 	CONFIG_USB_DWC3=y
>>> 	CONFIG_USB_DWC3_ULPI=y
>>> 	CONFIG_USB_DWC3_DUAL_ROLE=y
>>> 	CONFIG_USB_DWC3_PCI=y
>>> 	CONFIG_EXTCON_INTEL_MRFLD=m
>>>
>>> In the Buildroot environment the modules are probed by alphabetical ordering
>>> of their modaliases. The latter comes to the case when USB OTG driver will be
>>> probed first followed by extcon one.
>>>
>>> So, if the platform anticipates extcon device to be appeared, in the above case
>>> we will get deferred probe of USB OTG, because of ordering.
>>>
>>> Since current implementation, done by the commit 58b116bce136 ("drivercore:
>>> deferral race condition fix") counts the amount of triggered deferred probe,
>>> we never advance the situation -- the change makes it to be an infinite loop.
>>
>> Hi Andy,
>>
>> I'm trying to understand this sequence of steps. Sorry if the questions
>> are stupid -- I'm not very familiar with USB/PCI stuff.
> 
> Thank you for looking into this. My answer below.
> 
> As a first thing I would like to tell that there is another example of bad
> behaviour of deferred probe with no relation to USB. The proposed change also
> fixes that one (however, less possible to find in real life).
> 
>>> ---8<---8<---
>>>
>>> [   22.187127] driver_deferred_probe_trigger <<< 1
>>>
>>> ...here is the late initcall triggers deferred probe...
>>>
>>> [   22.191725] platform dwc3.0.auto: deferred_probe_work_func in deferred list
>>>
>>> ...dwc3.0.auto is the only device in the deferred list...
>>
>> Ok, dwc3.0.auto is the only unprobed device at this point?
> 
> Correct.
> 
>>> [   22.198727] platform dwc3.0.auto: deferred_probe_work_func 1 <<< counter 1
>>>
>>> ...the counter before mutex is unlocked is kept the same...
>>>
>>> [   22.205663] platform dwc3.0.auto: Retrying from deferred list
>>>
>>> ...mutes has been unlocked, we try to re-probe the driver...
>>>
>>> [   22.211487] bus: 'platform': driver_probe_device: matched device dwc3.0.auto with driver dwc3
>>> [   22.220060] bus: 'platform': really_probe: probing driver dwc3 with device dwc3.0.auto
>>> [   22.238735] bus: 'ulpi': driver_probe_device: matched device dwc3.0.auto.ulpi with driver tusb1210
>>> [   22.247743] bus: 'ulpi': really_probe: probing driver tusb1210 with device dwc3.0.auto.ulpi
>>> [   22.256292] driver: 'tusb1210': driver_bound: bound to device 'dwc3.0.auto.ulpi'
>>> [   22.263723] driver_deferred_probe_trigger <<< 2
>>>
>>> ...the dwc3.0.auto probes ULPI, we got successful bound and bumped counter...
>>>
>>> [   22.268304] bus: 'ulpi': really_probe: bound device dwc3.0.auto.ulpi to driver tusb1210
>>
>> So where did this dwc3.0.auto.ulpi come from?
> 
>> Looks like the device is created by dwc3_probe() through this call flow:
>> dwc3_probe() -> dwc3_core_init() -> dwc3_core_ulpi_init() ->
>> dwc3_ulpi_init() -> ulpi_register_interface() -> ulpi_register()
> 
> Correct.
> 
>>> [   22.276697] platform dwc3.0.auto: Driver dwc3 requests probe deferral
>>
>> Can you please point me to which code patch actually caused the probe
>> deferral?
> 
> Sure, it's in drd.c.
> 
> if (device_property_read_string(dev, "linux,extcon-name", &name) == 0) {
>    edev = extcon_get_extcon_dev(name);
>    if (!edev)
>      return ERR_PTR(-EPROBE_DEFER);
>    return edev;
> }
> 
>>> ...but extcon driver is still missing...
>>>
>>> [   22.283174] platform dwc3.0.auto: Added to deferred list
>>> [   22.288513] platform dwc3.0.auto: driver_deferred_probe_add_trigger local counter: 1 new counter 2
>>
>> I'm not fully aware of all the USB implications, but if extcon is
>> needed, why can't that check be done before we add and probe the ulpi
>> device? That'll avoid this whole "fake" probing and avoid the counter
>> increase. And avoid the need for this patch that's touching the code
>> code that's already a bit delicate.
> 
>> Also, with my limited experience with all the possible drivers in the
>> kernel, it's weird that the ulpi device is added and probed before we
>> make sure the parent device (dwc3.0.auto) can actually probe
>> successfully.
> 
> As I said above the deferred probe trigger has flaw on its own.
> Even if we fix for USB case, there is (and probably will be) others.

Right here is the driver design bug. A driver's probe() hook should 
*not* return -EPROBE_DEFER after already creating child devices which 
may have already been probed.

It can be solved by refactoring the driver probe routine. If a resource 
is required to be present, then check that it is available early; before 
registering child devices.

The proposed solution to modify driver core is fragile and susceptible 
to side effects from other probe paths. I don't think it is the right 
approach.

g.

