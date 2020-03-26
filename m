Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 300561941DA
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 15:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgCZOrK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 10:47:10 -0400
Received: from mail-vi1eur05on2045.outbound.protection.outlook.com ([40.107.21.45]:3809
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727547AbgCZOrJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Mar 2020 10:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spIRn6VuTpsIISBrUdh/6eAgRBpC+6NPfnOjnLyc+Ew=;
 b=MXkkkbgm+d1kpLKF74nCyY94pqeaFJuh6v7NHV0IjMpkN5LeZxT5d4R/WLOtANY4m02blblVXu38HjGHO3j4mpMTTBJ6k8/vXbo/escAtwJaTxdUs1B/za5MzdWc+cBFSTON6/qQ0OCnAFgzlNoaTWgfNfSzNZP9W75M0sJJo68=
Received: from AM5P189CA0002.EURP189.PROD.OUTLOOK.COM (2603:10a6:206:15::15)
 by DBBPR08MB4489.eurprd08.prod.outlook.com (2603:10a6:10:cf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Thu, 26 Mar
 2020 14:47:03 +0000
Received: from AM5EUR03FT055.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:206:15:cafe::83) by AM5P189CA0002.outlook.office365.com
 (2603:10a6:206:15::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18 via Frontend
 Transport; Thu, 26 Mar 2020 14:47:03 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT055.mail.protection.outlook.com (10.152.17.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.17 via Frontend Transport; Thu, 26 Mar 2020 14:47:03 +0000
Received: ("Tessian outbound e13acb17570e:v48"); Thu, 26 Mar 2020 14:47:03 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 83b6308ede1b2e8d
X-CR-MTA-TID: 64aa7808
Received: from df4531217b39.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9946A0D7-8879-4F31-BC57-2207966042CA.1;
        Thu, 26 Mar 2020 14:46:58 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id df4531217b39.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 26 Mar 2020 14:46:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BegMCrOk1IjbxNPHkRr2b+pF8ejhe0bKGKTTKnYYDorabCof3/9YOxwQ8OAY+xg2TLht0Ou5i8kYQa8LuMJwbdL2utBD8JZ557iOCBbfTfQ8BS1+iYw1cLeimRWqJlmQQRV8zYUpP4q+NAU3xA9/scn9XjyNVR/zpJYZmsvWnbEGCqexgYOC+QordumWHNdVa78iq/v7jZiGZZrMZjdcheCKGUC6iiOfe2VfUl0X/CcMe1/9Ups2D4r8v1pJLHCIP1EHLbrVUW52LZhUBT91+zcQxOZL/Z1FJMOIdn6ILJxDUhp0MwgUg1Er3w6e1amCtRzMqJwR7i5DMfSDFDfphA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spIRn6VuTpsIISBrUdh/6eAgRBpC+6NPfnOjnLyc+Ew=;
 b=kavV/of110rsoO/IUrZ08uaII94vpuqUXhvGFiz4r4pkfMYGaLrTWv3YChHfzgKNw6xMqGnOtdyKPxkTOsNODFOKLKxbb5G70OZTwTBcoOfguGSaE47/D0DAwM5nO35HyNRJTHDso8CqHxV9S0C5AB8ArHw7qU3Zw63RrfWiQjtq8KQv1w4t4SHzBS73/E6TSee28Bi4l2oTR4oxHmF8tNf7JliKi1GAaKXeslCxFCbyzm+bMx8R94P6WVC3UY7JHqD6+woAmMWLg5Bhth+OXBZ7juhDLdwEaYo+qas6TQQPIsjR2emFG7w2eEW2KCweJOy81T3imYPVLp4bEaDegQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spIRn6VuTpsIISBrUdh/6eAgRBpC+6NPfnOjnLyc+Ew=;
 b=MXkkkbgm+d1kpLKF74nCyY94pqeaFJuh6v7NHV0IjMpkN5LeZxT5d4R/WLOtANY4m02blblVXu38HjGHO3j4mpMTTBJ6k8/vXbo/escAtwJaTxdUs1B/za5MzdWc+cBFSTON6/qQ0OCnAFgzlNoaTWgfNfSzNZP9W75M0sJJo68=
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Grant.Likely@arm.com; 
Received: from DB8PR08MB4010.eurprd08.prod.outlook.com (20.179.10.207) by
 DB8PR08MB5244.eurprd08.prod.outlook.com (10.255.17.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19; Thu, 26 Mar 2020 14:46:55 +0000
Received: from DB8PR08MB4010.eurprd08.prod.outlook.com
 ([fe80::4521:d746:9e7:4ae3]) by DB8PR08MB4010.eurprd08.prod.outlook.com
 ([fe80::4521:d746:9e7:4ae3%5]) with mapi id 15.20.2835.023; Thu, 26 Mar 2020
 14:46:55 +0000
Subject: Re: [PATCH v3] driver core: Break infinite loop when deferred probe
 can't be satisfied
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Saravana Kannan <saravanak@google.com>
Cc:     a.hajda@samsung.com, artem.bityutskiy@linux.intel.com,
        balbi@kernel.org, Mark Brown <broonie@kernel.org>,
        fntoth@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, peter.ujfalusi@ti.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        nd <nd@arm.com>
References: <20200324175719.62496-1-andriy.shevchenko@linux.intel.com>
 <20200325032901.29551-1-saravanak@google.com>
 <20200325125120.GX1922688@smile.fi.intel.com>
 <CAGETcx_TGw24UqX7pXZePyskrao6zwnKTq8mBk9g_7jokqAqkA@mail.gmail.com>
 <20200326115431.GP1922688@smile.fi.intel.com>
From:   Grant Likely <grant.likely@arm.com>
Message-ID: <9175e54e-6764-458f-6e86-39a599574af5@arm.com>
Date:   Thu, 26 Mar 2020 14:46:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200326115431.GP1922688@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0126.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::18) To DB8PR08MB4010.eurprd08.prod.outlook.com
 (2603:10a6:10:ab::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.16.141] (92.40.174.3) by LO2P265CA0126.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9f::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19 via Frontend Transport; Thu, 26 Mar 2020 14:46:54 +0000
X-Originating-IP: [92.40.174.3]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e5dd8c54-ece3-43bb-676f-08d7d1948c56
X-MS-TrafficTypeDiagnostic: DB8PR08MB5244:|DBBPR08MB4489:
X-Microsoft-Antispam-PRVS: <DBBPR08MB4489FF0DD1C8FDA2D9C5C7AC95CF0@DBBPR08MB4489.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;OLM:6108;
X-Forefront-PRVS: 0354B4BED2
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(5660300002)(54906003)(110136005)(55236004)(53546011)(8676002)(31696002)(52116002)(7416002)(2616005)(26005)(478600001)(2906002)(956004)(44832011)(8936002)(16526019)(316002)(66476007)(66556008)(4326008)(36756003)(66946007)(86362001)(6486002)(81166006)(186003)(81156014)(31686004)(16576012);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB5244;H:DB8PR08MB4010.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: IxAQWSnod3NIqBMvesxMOzHcwQAQVl9ujW4WuslUGGYNhci493FlFOoiHChrYU4kojFJs9UG58G+1z6z4GqXsEXXPviqWgivhIcAJL5Y65w5DyzDLodYzV6Gcmv3EBaB8zGCDDF/xVw3MxA37JsAiYcWfGts+TA8QwlixYTcWtxe96uErpBAKDrLgG0s/XAGtQQs0jyRMYGigoZihJu8j/hvWZwEediQM4+WN/lsNzeILnKEV3cbbi0As0PtHwdjViJ+mK9su7H5dZf4zsiq20WVyv4idAFg6erbD3lXzPUAtNqIURyPUOu5K6O2JNSIzxf4gaWVBo/nwxOB7XM2sNy/kjuz1aEnS+NEwWwVtDG+gACRcRdIupI+kki0yVG8JUI8Qcuv/HyFfmFNgKGzHlax3bgJFXeqUnDalc1LIjegrCfJvCn0O7JLTxLUu690
X-MS-Exchange-AntiSpam-MessageData: 2mjYEf3zkGj6HLkI/8Z5tfrlfhzCCLSB02AOwtjTQgvotsRzybgCS64QM7uE7q/qzOfKyg7lj1EMDuiEHCciKGZpGcrOjwHpQGYZJtXhixKHbvhjL0ak1lox96oYQd+QHC7Lo+i6LIgbe6/x/ZApJw==
X-MS-Exchange-Transport-Forked: True
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5244
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Grant.Likely@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT055.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(39860400002)(376002)(346002)(46966005)(2906002)(36756003)(82740400003)(31686004)(81156014)(26826003)(8676002)(81166006)(53546011)(316002)(70206006)(36906005)(4326008)(47076004)(70586007)(86362001)(186003)(44832011)(16526019)(2616005)(336012)(110136005)(54906003)(31696002)(956004)(356004)(5660300002)(450100002)(26005)(478600001)(8936002)(6486002)(16576012);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR08MB4489;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;
X-MS-Office365-Filtering-Correlation-Id-Prvs: e50fdff2-337d-4763-6d30-08d7d194876b
X-Forefront-PRVS: 0354B4BED2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nTGYN3UGYcBrYPTHzn4wxleIKEZYtvLw8pLHbu6s2AYF9K3wMURaxUsEpk3j+JuNSUcHJpTlSNOpM4suP7q57uxOwq4YFSfm9vC/gX/TgZcAiqtTLwAuM+xLWdCTo0aMAL07Lu8INkRg1UxTg3U47S9lk32ib4Em2sGrFL/UkAm0fZTZrLDobvax23rwPQ1yeTbM5IYn8ZBzr0xAH2IwfWR0/h+291MKmGAHeaIq0sJBMlYc22uuItPHxScp1YX3tIdWI+ll8a2GK3ldnyiR7IlUFzgkyH9m+Cn8i+klCAhp35CBP5X3oYmerjsgjITxPAZJ1VvxuM7ZHZj4zD8rg8sZpFN1RrJAEzYVVG98GsiL3uQ/TQUNUi2O3zP5VJcQ8HzoSsUZLb2pCE10oFrsrS2ohx0X1I2A3Jr6YDjSLKS9W641qbCSg6+iydMrob0N+YfzHu6Vw4dVcuIDX+nLmIdAp9vX5tGJ34Cz6erKX8J/viYcw3DiGcTJb0BKfM7yawY6xYQnVg9m9O/pwQb0ag==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2020 14:47:03.5221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5dd8c54-ece3-43bb-676f-08d7d1948c56
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4489
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 26/03/2020 11:54, Andy Shevchenko wrote:
> On Wed, Mar 25, 2020 at 03:08:29PM -0700, Saravana Kannan wrote:
>> On Wed, Mar 25, 2020 at 5:51 AM Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:
>>> On Tue, Mar 24, 2020 at 08:29:01PM -0700, Saravana Kannan wrote:
>>>> On Tue, Mar 24, 2020 at 5:38 AM Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>>>>> Consider the following scenario.
>>>>>
>>>>> The main driver of USB OTG controller (dwc3-pci), which has the following
>>>>> functional dependencies on certain platform:
>>>>> - ULPI (tusb1210)
>>>>> - extcon (tested with extcon-intel-mrfld)
>>>>>
>>>>> Note, that first driver, tusb1210, is available at the moment of
>>>>> dwc3-pci probing, while extcon-intel-mrfld is built as a module and
>>>>> won't appear till user space does something about it.
>>>>>
>>>>> This is depicted by kernel configuration excerpt:
>>>>>
>>>>>      CONFIG_PHY_TUSB1210=y
>>>>>      CONFIG_USB_DWC3=y
>>>>>      CONFIG_USB_DWC3_ULPI=y
>>>>>      CONFIG_USB_DWC3_DUAL_ROLE=y
>>>>>      CONFIG_USB_DWC3_PCI=y
>>>>>      CONFIG_EXTCON_INTEL_MRFLD=m
>>>>>
>>>>> In the Buildroot environment the modules are probed by alphabetical ordering
>>>>> of their modaliases. The latter comes to the case when USB OTG driver will be
>>>>> probed first followed by extcon one.
>>>>>
>>>>> So, if the platform anticipates extcon device to be appeared, in the above case
>>>>> we will get deferred probe of USB OTG, because of ordering.
>>>>>
>>>>> Since current implementation, done by the commit 58b116bce136 ("drivercore:
>>>>> deferral race condition fix") counts the amount of triggered deferred probe,
>>>>> we never advance the situation -- the change makes it to be an infinite loop.
>>>>
>>>> Hi Andy,
>>>>
>>>> I'm trying to understand this sequence of steps. Sorry if the questions
>>>> are stupid -- I'm not very familiar with USB/PCI stuff.
>>>
>>> Thank you for looking into this. My answer below.
>>>
>>> As a first thing I would like to tell that there is another example of bad
>>> behaviour of deferred probe with no relation to USB. The proposed change also
>>> fixes that one (however, less possible to find in real life).
>>
>> Unless I see what the other issue is, I can't speak for the unknown.
> 
> Okay, let's talk about other case (actually it's the one which I had noticed
> approximately at the time when culprit patch made the kernel).
> 
> For some debugging purposes I have been using pin control table in board code.
> 
> Since I would like to boot kernel on different systems I have some tables for
> non-existing pin control device. Pin control framework returns -EPROBE_DEFER
> when trying to probe device with attached table for wrong pin control. This is
> fine, the problem is that *any* successfully probed device, which happens in
> the deferred probe initcall will desynchronize existing counter. As a result ->
> infinite loop. For the record, I didn't realize and didn't investigate that
> time the issue and now I can confirm that this is a culprit which is fixed by
> this patch.

Specific code path please?

g.

