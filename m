Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23F58195730
	for <lists+linux-pm@lfdr.de>; Fri, 27 Mar 2020 13:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgC0MiM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Mar 2020 08:38:12 -0400
Received: from mail-db8eur05on2064.outbound.protection.outlook.com ([40.107.20.64]:44928
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726742AbgC0MiM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 27 Mar 2020 08:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUJRBGwtwdjpdZmgnz8mk0osN9eg+HGLNeQaI7kwHqs=;
 b=R0ahhSP6gwvPEv0ZZBxBvCaxGUgTVsKuWr1Q7ZRM/3ElvQuuGsDcIzobQidEIsIy7LcUcDLkB2zw7a2944fL1yJk9elJc4RNHEXhqsP0c+NBIeRDeVuke04Vq2U8pQZChaZgwtyiaVqyvdFumGM6hij2QVgC//upiaN/V4EAsSc=
Received: from DB6PR07CA0173.eurprd07.prod.outlook.com (2603:10a6:6:43::27) by
 DB6PR0802MB2198.eurprd08.prod.outlook.com (2603:10a6:4:84::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Fri, 27 Mar 2020 12:38:06 +0000
Received: from DB5EUR03FT028.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:43:cafe::d) by DB6PR07CA0173.outlook.office365.com
 (2603:10a6:6:43::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.9 via Frontend
 Transport; Fri, 27 Mar 2020 12:38:06 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT028.mail.protection.outlook.com (10.152.20.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.17 via Frontend Transport; Fri, 27 Mar 2020 12:38:05 +0000
Received: ("Tessian outbound d6b3ed9fc62a:v48"); Fri, 27 Mar 2020 12:38:05 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 0d4f696df7679af7
X-CR-MTA-TID: 64aa7808
Received: from eb5a85c63824.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id C83DB20D-47EA-4168-AEC2-2C8ACE3B1D78.1;
        Fri, 27 Mar 2020 12:38:00 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id eb5a85c63824.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 27 Mar 2020 12:38:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6ADdjJ3ySVpJoCh1AdFk/R104TUYwbjSYZu1auV1tAbN1V1nrCAx48DoGMrqm8tViI6kKUcFYIgPOmIOLzmA3Gu9QSbiekbJ0cuZft4YgRJ5Kt8qTEEsynVQLcJzybvmiXlYqpC2B31CwZ6xybN4lsRHqhn3C5EdwA6w0cyDlhbzRKMFwMMe1NmJbwWiMWivhnP6vaOtuxxOkd2aPiuWEIhsoJnVHCW6E1aXtP89bYn6JGxMIA5sx9jZHx7u/B6BmTulzDwe4HR4WJNuCxFBhXifKkVIWgufLk/gdYswwRu3pQgwlHzCKeCKbScbpEBAeP02amUZ/+6bOzAR4VfTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUJRBGwtwdjpdZmgnz8mk0osN9eg+HGLNeQaI7kwHqs=;
 b=GRv+t+EOGM1u8+TV9xcgfmMMy4i/MrH71atpzRwcWX9AdOh+Ff/mH2OvGR4wRKleFTsHecrwb2+RSofwf9xqH4d/M2U24QC/Pcasnr2vmYLV9eZYK6uitzY7/r+H9wnmc3z1Moek2cD+1pGP9hpQLsIDkd/VDrxwmP5o5iqdeVMZhab9PisG4fhBolffWHwQjkj3Mzc1PssyW4tSEaIGwGpzPl62IJ8WkcaaLDvmrhFaWjq2S3hm7UeHoqvYh5+lCPBlA4lXovPY8QDfQdF4SFl+5RxiS5eya950PaHVXFpcO2oEb7pdKeY2YDNjuV7EklvjSjXk3zHcwc3oAjDOuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUJRBGwtwdjpdZmgnz8mk0osN9eg+HGLNeQaI7kwHqs=;
 b=R0ahhSP6gwvPEv0ZZBxBvCaxGUgTVsKuWr1Q7ZRM/3ElvQuuGsDcIzobQidEIsIy7LcUcDLkB2zw7a2944fL1yJk9elJc4RNHEXhqsP0c+NBIeRDeVuke04Vq2U8pQZChaZgwtyiaVqyvdFumGM6hij2QVgC//upiaN/V4EAsSc=
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Grant.Likely@arm.com; 
Received: from DB8PR08MB4010.eurprd08.prod.outlook.com (20.179.10.207) by
 DB8PR08MB5436.eurprd08.prod.outlook.com (52.133.240.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Fri, 27 Mar 2020 12:37:57 +0000
Received: from DB8PR08MB4010.eurprd08.prod.outlook.com
 ([fe80::4521:d746:9e7:4ae3]) by DB8PR08MB4010.eurprd08.prod.outlook.com
 ([fe80::4521:d746:9e7:4ae3%5]) with mapi id 15.20.2835.023; Fri, 27 Mar 2020
 12:37:57 +0000
Subject: Re: [PATCH v3] driver core: Break infinite loop when deferred probe
 can't be satisfied
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Saravana Kannan <saravanak@google.com>, a.hajda@samsung.com,
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
 <9350ec52-345f-5c3c-f175-4e256699b9cf@arm.com>
 <20200327080323.GA1627562@kroah.com>
From:   Grant Likely <grant.likely@arm.com>
Message-ID: <291a6afb-75b1-0717-d8d0-577f8f3d77da@arm.com>
Date:   Fri, 27 Mar 2020 12:37:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200327080323.GA1627562@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0272.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::20) To DB8PR08MB4010.eurprd08.prod.outlook.com
 (2603:10a6:10:ab::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.16.141] (92.40.174.0) by LO2P265CA0272.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a1::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19 via Frontend Transport; Fri, 27 Mar 2020 12:37:55 +0000
X-Originating-IP: [92.40.174.0]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bc7d76c9-edd1-4a42-9647-08d7d24bb2b0
X-MS-TrafficTypeDiagnostic: DB8PR08MB5436:|DB6PR0802MB2198:
X-Microsoft-Antispam-PRVS: <DB6PR0802MB2198FBCCD01FB4BBA9083B0D95CC0@DB6PR0802MB2198.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;OLM:5797;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB4010.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(53546011)(36756003)(55236004)(478600001)(6486002)(31696002)(31686004)(81166006)(16576012)(6916009)(86362001)(8676002)(81156014)(7416002)(2906002)(316002)(52116002)(5660300002)(54906003)(66946007)(66476007)(8936002)(44832011)(26005)(30864003)(16526019)(186003)(4326008)(2616005)(956004)(66556008);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 3fHI+s+bDp2NUusJ74lgxFyAvy2OGJl482jL5QKvhpks2mt564rIi54MJWduP0TAjMGsBQbxsBiWnT+vVwa5l94ckh/PWQhgEWncQ7s+ctSa7Ncb40a8X1Y96+kI9xKunFyyobWvqHUihWiuE1VIMJTgJpEaZr6zZRcXqPeijxvYgUuhMNVU1M+FvOIqoB2Syq0d/a+GzdQvi77dhBVe9z+k2XX10+uCRzT031lAfgFPmAW6B6UgXfmevhY0BIqz1B7zmceoen21HnX92aTxVsky1PCL3JHuz6tvOYCYYqqCEqQI7DtpY3TkseXkNxILRpmMXjLdsUQntRoBXTwBZQ5w+IFzDK/HIsz+UgtSEWQCFtW3Mj4rt3+7boH8gZ+Y+jBl9ewsl4/j6ex/3xuZI52D/8sEyPt8N+pghwzyCpJeBSB9hNU5lAu+7OCtmS8e
X-MS-Exchange-AntiSpam-MessageData: r4bdPPP5rkmzWMesUaB2GsvEnB3+/ZTESQIYY3d7SxXZRT06b6b6fGe98ESjO/hx8rtmk+jEvG7EjKshvGlyMo3LOIjKZB9Kcr+uqB+HKsVzxSUMrZk6a4/Ppq+htkxImUxZj7zVJ1oBxDmQf+O5qQ==
X-MS-Exchange-Transport-Forked: True
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5436
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Grant.Likely@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT028.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(346002)(376002)(39860400002)(396003)(46966005)(26826003)(70586007)(54906003)(478600001)(5660300002)(16576012)(316002)(6486002)(31696002)(86362001)(2906002)(44832011)(70206006)(81166006)(2616005)(356004)(956004)(53546011)(450100002)(36756003)(82740400003)(336012)(47076004)(26005)(16526019)(81156014)(8676002)(8936002)(6862004)(186003)(31686004)(30864003)(4326008);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 971b8ffd-1ada-4c6b-af06-08d7d24bad72
X-Forefront-PRVS: 0355F3A3AE
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AshTDRdaIUTd7xtCyped1bzPkvOndRdLfHfeiZpLRg/IUbtGhpLOJR4XNxAe7v7W5zPt4yUnr385P4V5yu/dOW1enjgBe83NnOUVoHFHHmiOzu3hXIOKG3CaUOR/RdewSaXhMPveIJjvzOwdSn86kg5RH9hA+CyXJBKhFji5ZCMETfG7DqmdaFC2NlERkBDyRyFtxnvfbchjtVVhYnY5S2kXivdi6utIgSFDCcqQbkjlFBxvtQitVsy0WaBPi21oM2rlypS6LZGnNw+WA8kRrZLxTBOE6tWGAp5xgLux8GbSOXK1yzdDEfzzNjMgxCUxuC9A0IT46Tq23NbaID6/v+8iLe/y6jcwtRywaTOkKkW64Ez7j/STiB55e+sm9dhNyEpwWd6pLvoZfi3+RxCSmiXJrWRimiSdUA+nKaHizd3YUuy84ZBNPWoPjr4wy8X98iu3VmpTigpEb/fEXBW+WUTvQhdAnBpZI0Bkuve4kY564OsLAiNzbRIrZFXEL/A+W9T4Mmz/ECL4fYzo+hwimw==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 12:38:05.8411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc7d76c9-edd1-4a42-9647-08d7d24bb2b0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2198
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 27/03/2020 08:03, Greg KH wrote:
> On Thu, Mar 26, 2020 at 06:06:37PM +0000, Grant Likely wrote:
>>
>>
>> On 26/03/2020 16:39, Greg KH wrote:
>>> On Thu, Mar 26, 2020 at 06:31:10PM +0200, Andy Shevchenko wrote:
>>>> On Thu, Mar 26, 2020 at 03:01:22PM +0000, Grant Likely wrote:
>>>>> On 25/03/2020 12:51, Andy Shevchenko wrote:
>>>>>> On Tue, Mar 24, 2020 at 08:29:01PM -0700, Saravana Kannan wrote:
>>>>>>> On Tue, Mar 24, 2020 at 5:38 AM Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>>>>>>>> Consider the following scenario.
>>>>>>>>
>>>>>>>> The main driver of USB OTG controller (dwc3-pci), which has the following
>>>>>>>> functional dependencies on certain platform:
>>>>>>>> - ULPI (tusb1210)
>>>>>>>> - extcon (tested with extcon-intel-mrfld)
>>>>>>>>
>>>>>>>> Note, that first driver, tusb1210, is available at the moment of
>>>>>>>> dwc3-pci probing, while extcon-intel-mrfld is built as a module and
>>>>>>>> won't appear till user space does something about it.
>>>>>>>>
>>>>>>>> This is depicted by kernel configuration excerpt:
>>>>>>>>
>>>>>>>> 	CONFIG_PHY_TUSB1210=y
>>>>>>>> 	CONFIG_USB_DWC3=y
>>>>>>>> 	CONFIG_USB_DWC3_ULPI=y
>>>>>>>> 	CONFIG_USB_DWC3_DUAL_ROLE=y
>>>>>>>> 	CONFIG_USB_DWC3_PCI=y
>>>>>>>> 	CONFIG_EXTCON_INTEL_MRFLD=m
>>>>>>>>
>>>>>>>> In the Buildroot environment the modules are probed by alphabetical ordering
>>>>>>>> of their modaliases. The latter comes to the case when USB OTG driver will be
>>>>>>>> probed first followed by extcon one.
>>>>>>>>
>>>>>>>> So, if the platform anticipates extcon device to be appeared, in the above case
>>>>>>>> we will get deferred probe of USB OTG, because of ordering.
>>>>>>>>
>>>>>>>> Since current implementation, done by the commit 58b116bce136 ("drivercore:
>>>>>>>> deferral race condition fix") counts the amount of triggered deferred probe,
>>>>>>>> we never advance the situation -- the change makes it to be an infinite loop.
>>>>>>>
>>>>>>> Hi Andy,
>>>>>>>
>>>>>>> I'm trying to understand this sequence of steps. Sorry if the questions
>>>>>>> are stupid -- I'm not very familiar with USB/PCI stuff.
>>>>>>
>>>>>> Thank you for looking into this. My answer below.
>>>>>>
>>>>>> As a first thing I would like to tell that there is another example of bad
>>>>>> behaviour of deferred probe with no relation to USB. The proposed change also
>>>>>> fixes that one (however, less possible to find in real life).
>>>>>>
>>>>>>>> ---8<---8<---
>>>>>>>>
>>>>>>>> [   22.187127] driver_deferred_probe_trigger <<< 1
>>>>>>>>
>>>>>>>> ...here is the late initcall triggers deferred probe...
>>>>>>>>
>>>>>>>> [   22.191725] platform dwc3.0.auto: deferred_probe_work_func in deferred list
>>>>>>>>
>>>>>>>> ...dwc3.0.auto is the only device in the deferred list...
>>>>>>>
>>>>>>> Ok, dwc3.0.auto is the only unprobed device at this point?
>>>>>>
>>>>>> Correct.
>>>>>>
>>>>>>>> [   22.198727] platform dwc3.0.auto: deferred_probe_work_func 1 <<< counter 1
>>>>>>>>
>>>>>>>> ...the counter before mutex is unlocked is kept the same...
>>>>>>>>
>>>>>>>> [   22.205663] platform dwc3.0.auto: Retrying from deferred list
>>>>>>>>
>>>>>>>> ...mutes has been unlocked, we try to re-probe the driver...
>>>>>>>>
>>>>>>>> [   22.211487] bus: 'platform': driver_probe_device: matched device dwc3.0.auto with driver dwc3
>>>>>>>> [   22.220060] bus: 'platform': really_probe: probing driver dwc3 with device dwc3.0.auto
>>>>>>>> [   22.238735] bus: 'ulpi': driver_probe_device: matched device dwc3.0.auto.ulpi with driver tusb1210
>>>>>>>> [   22.247743] bus: 'ulpi': really_probe: probing driver tusb1210 with device dwc3.0.auto.ulpi
>>>>>>>> [   22.256292] driver: 'tusb1210': driver_bound: bound to device 'dwc3.0.auto.ulpi'
>>>>>>>> [   22.263723] driver_deferred_probe_trigger <<< 2
>>>>>>>>
>>>>>>>> ...the dwc3.0.auto probes ULPI, we got successful bound and bumped counter...
>>>>>>>>
>>>>>>>> [   22.268304] bus: 'ulpi': really_probe: bound device dwc3.0.auto.ulpi to driver tusb1210
>>>>>>>
>>>>>>> So where did this dwc3.0.auto.ulpi come from?
>>>>>>
>>>>>>> Looks like the device is created by dwc3_probe() through this call flow:
>>>>>>> dwc3_probe() -> dwc3_core_init() -> dwc3_core_ulpi_init() ->
>>>>>>> dwc3_ulpi_init() -> ulpi_register_interface() -> ulpi_register()
>>>>>>
>>>>>> Correct.
>>>>>>
>>>>>>>> [   22.276697] platform dwc3.0.auto: Driver dwc3 requests probe deferral
>>>>>>>
>>>>>>> Can you please point me to which code patch actually caused the probe
>>>>>>> deferral?
>>>>>>
>>>>>> Sure, it's in drd.c.
>>>>>>
>>>>>> if (device_property_read_string(dev, "linux,extcon-name", &name) == 0) {
>>>>>>      edev = extcon_get_extcon_dev(name);
>>>>>>      if (!edev)
>>>>>>        return ERR_PTR(-EPROBE_DEFER);
>>>>>>      return edev;
>>>>>> }
>>>>>>
>>>>>>>> ...but extcon driver is still missing...
>>>>>>>>
>>>>>>>> [   22.283174] platform dwc3.0.auto: Added to deferred list
>>>>>>>> [   22.288513] platform dwc3.0.auto: driver_deferred_probe_add_trigger local counter: 1 new counter 2
>>>>>>>
>>>>>>> I'm not fully aware of all the USB implications, but if extcon is
>>>>>>> needed, why can't that check be done before we add and probe the ulpi
>>>>>>> device? That'll avoid this whole "fake" probing and avoid the counter
>>>>>>> increase. And avoid the need for this patch that's touching the code
>>>>>>> code that's already a bit delicate.
>>>>>>
>>>>>>> Also, with my limited experience with all the possible drivers in the
>>>>>>> kernel, it's weird that the ulpi device is added and probed before we
>>>>>>> make sure the parent device (dwc3.0.auto) can actually probe
>>>>>>> successfully.
>>>>>>
>>>>>> As I said above the deferred probe trigger has flaw on its own.
>>>>>> Even if we fix for USB case, there is (and probably will be) others.
>>>>>
>>>>> Right here is the driver design bug. A driver's probe() hook should *not*
>>>>> return -EPROBE_DEFER after already creating child devices which may have
>>>>> already been probed.
>>>>
>>>> Any documentation statement for this requirement?
>>>
>>> There shouldn't be.  If you return ANY error from a probe function, your
>>> driver is essencially "dead" when it comes to that device, and it had
>>> better have cleaned up after itself. >
>>> That includes defering probe, that's not "special" here at all.
>>
>> What is special in this case is that if a .probe() hook had registered a
>> child device, then removed that child device (so it did clean up after
>> itself) and then return -EPROBE_DEFER, then we end up in an endless probe
>> loop.
> 
> If all child devices really are cleaned up completly, why would this be
> a problem?  What is set internally in the driver core that would get
> tripped up by this?
> 
>> But this is unusual behaviour. Normally a .probe() hook checks all required
>> resources are available before registering any child devices. This driver
>> doesn't do that. Arguably this is indeed an additional requirement beyond
>> "clean up after yourself". I cannot find anyplace where it is documented. In
>> fact, I cannot find any documentation on EPROBE_DEFER in the Documentation/
>> tree. How about the below?
>>
>>>> By the way, I may imagine other mechanisms that probe the driver on other CPU
>>>> at the same time (let's consider parallel modprobes). The current code has a
>>>> flaw with that.
>>>
>>> That can't happen, the driver core prevents that.
>>
>> Greg's right, that can't happen. At worst a driver will get an additional
>> defer event; but it all still works.
>>
>> g.
>>
>> ---
>> diff --git a/Documentation/driver-api/driver-model/driver.rst
>> b/Documentation/driver-api/driver-model/driver.rst
>> index baa6a85c8287..46adede13aba 100644
>> --- a/Documentation/driver-api/driver-model/driver.rst
>> +++ b/Documentation/driver-api/driver-model/driver.rst
>> @@ -167,7 +167,17 @@ the driver to that device.
>>
>>   A driver's probe() may return a negative errno value to indicate that
>>   the driver did not bind to this device, in which case it should have
>> -released all resources it allocated::
>> +released all resources it allocated. Optionally, probe() may return
>> +-EPROBE_DEFER if the driver depends on resources that are not yet
>> +available (e.g., supplied by a driver that hasn't initialized yet).
>> +The driver core will put the device onto the deferred probe list and
>> +will try to call it again later. Important: -EPROBE_DEFER must not be
>> +returned if probe() has already created child devices, even if those
>> +child devices have were removed again in a cleanup path. If -EPROBE_DEFER
>> +is returned after a child device has been registered, it may result in an
>> +infinite loop of .probe() calls to the same driver.
> 
> Ok, this is a bug, if that is the case, in the driver core as it should
> not matter how many devices were added/removed/whatever while a driver
> is in it's probe function.
Fair enough, call it a bug. However, the solution proposed so far is 
broken, and I've not seen or been able to come up with an approach 
without adding significant complexity to driver core.

Alternately, highlighting the limitation that EPROBE_DEFER can only be 
used before the device gets to the point of registering child devices is 
simple, only affects a few drivers, and matches the best practice of if 
a driver needs to defer, it should do so *as soon as possible* to avoid 
work needing to be unwound multiple times, which reduces boot time delays.

> 
> But, I don't see how this patch solves that problem, another probe call
> should never be made for the same bus while in this probe function.  If
> we do:
> 	device1->probe()
> 		device1 creates device2 and registers it
> 			device2->probe is called
> 			device2->probe returns 0
> 		device1 has problems, unregisters device2
> 			device2->remove is called
> 		device1 deletes device2
> 		device1 returns -EPROBE_DEFER
> 
> So then where's the problem?  Did device2 somehow not really get
> properly cleaned up?

Using the above sequence with a couple of annotations

  	device1->probe()
  		device1 creates device2 and registers it
  			device2->probe is called
  			device2->probe returns 0
                        *Driver Core increments probe_count
				(drivers/base/dd.c:516)
  		device1 has problems, unregisters device2
  			device2->remove is called
  		device1 deletes device2
  		device1 returns -EPROBE_DEFER
       *Driver core notices that probe_count got incremented since 
device1->probe() call started; therefore it is possible that the 
required resource is now available, so try calling device1->probe() again.

g.
