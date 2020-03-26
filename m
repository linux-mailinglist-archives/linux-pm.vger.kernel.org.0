Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5166194044
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 14:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgCZNst (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 09:48:49 -0400
Received: from mail-eopbgr10080.outbound.protection.outlook.com ([40.107.1.80]:48558
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727444AbgCZNss (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Mar 2020 09:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgqy24BmzozvGQTMibtjgJY0iHTS1xZkK4dproG9vVU=;
 b=w73oKZRbtwEVmC3Z3oar/bTAy9QfE081eORk4HcjnKscV6gWSGxZ2XJ9QMgY5IXf6mIvGOXkCEVVJihdqV7k0FC0UBdGIdKtIyi4jABh7eAgjOLgNImQ0kAuqprHFkKQ5byO4QiLiglh9TPSrXN8uNLnMZWY3shzWFBEgNMdJFk=
Received: from DB3PR0102CA0021.eurprd01.prod.exchangelabs.com
 (2603:10a6:8::34) by AM0PR08MB3490.eurprd08.prod.outlook.com
 (2603:10a6:208:e4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Thu, 26 Mar
 2020 13:48:43 +0000
Received: from DB5EUR03FT046.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:8:0:cafe::8c) by DB3PR0102CA0021.outlook.office365.com
 (2603:10a6:8::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19 via Frontend
 Transport; Thu, 26 Mar 2020 13:48:43 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT046.mail.protection.outlook.com (10.152.21.230) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.17 via Frontend Transport; Thu, 26 Mar 2020 13:48:43 +0000
Received: ("Tessian outbound e13acb17570e:v48"); Thu, 26 Mar 2020 13:48:43 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 183e9a8fb6d4ddef
X-CR-MTA-TID: 64aa7808
Received: from 1e3552f4845c.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 2574BCEB-31F7-4458-96AC-41B83FCFAD2E.1;
        Thu, 26 Mar 2020 13:48:38 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 1e3552f4845c.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 26 Mar 2020 13:48:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ftc/0uyVaNK9Q4O8nCTO6f15x1A75/QqwwfePcNAUHeWMyJrbG5aBurxV92h/sK9xXoEG/0wWaX/N1HRo4UHaUmNkL2VF5P4idmaQYJUUhsXySxIlao9LhkSSxdz5UEpX2lsyjzxN3SqGi0ajG38fG25BbwDUetKkUStKIM50sHXkvHHJEixOdRoLDZoU7W2G3/pmRwoO6gGvN8uOScHwWZFgkRrY5eT3+OFX30IaRlKMmoYaECV9E7Wr3PxzT/dU7I+1nAZEb61CL8rxEnBBgwuOrLzRzDzwZ0henW+naS+uBz0QVNG2X/6Qt7aPKzmRBCllHhU5cYxyNpnxe8d4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgqy24BmzozvGQTMibtjgJY0iHTS1xZkK4dproG9vVU=;
 b=juyRheNSlad73kbkw+1MNnOWey+VXg4qJBXL1qTLVqyQKlrN4BpzVGq2doe7kl5/VzmlGjDaOPOJ8d6oQjZW5MRBQD2v/8IeaVk+nMBSM3Tgis2FmiMRg9eggMRQu9D6muEwMloLTfJ2kI2+c9rwT8pkH+OfQnzu7jJfaeF4JHMsXwDLsLQlkfqmoAmPdXFUoeUZMuoPsod3pGewCdVC+gBn15R87t9BKhpt/vkIc558EQhY+h3qr3Zpn4fZfYFXatYMvI3Cb8xQe1vM9hC6LPgNVdlBV7YjU7n6frtV7kt9HpLKpS1dpjdjfuQgyEghYaWwXJqsQPvS1BY8Nvdb/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgqy24BmzozvGQTMibtjgJY0iHTS1xZkK4dproG9vVU=;
 b=w73oKZRbtwEVmC3Z3oar/bTAy9QfE081eORk4HcjnKscV6gWSGxZ2XJ9QMgY5IXf6mIvGOXkCEVVJihdqV7k0FC0UBdGIdKtIyi4jABh7eAgjOLgNImQ0kAuqprHFkKQ5byO4QiLiglh9TPSrXN8uNLnMZWY3shzWFBEgNMdJFk=
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Grant.Likely@arm.com; 
Received: from DB8PR08MB4010.eurprd08.prod.outlook.com (20.179.10.207) by
 DB8PR08MB4569.eurprd08.prod.outlook.com (20.179.12.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Thu, 26 Mar 2020 13:48:36 +0000
Received: from DB8PR08MB4010.eurprd08.prod.outlook.com
 ([fe80::4521:d746:9e7:4ae3]) by DB8PR08MB4010.eurprd08.prod.outlook.com
 ([fe80::4521:d746:9e7:4ae3%5]) with mapi id 15.20.2835.023; Thu, 26 Mar 2020
 13:48:36 +0000
Subject: Re: [PATCH v3] driver core: Break infinite loop when deferred probe
 can't be satisfied
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mark Brown <broonie@kernel.org>, Ferry Toth <fntoth@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Android Kernel Team <kernel-team@android.com>,
        nd <nd@arm.com>
References: <20200324175719.62496-1-andriy.shevchenko@linux.intel.com>
 <20200325032901.29551-1-saravanak@google.com>
 <20200325125120.GX1922688@smile.fi.intel.com>
 <CAGETcx_TGw24UqX7pXZePyskrao6zwnKTq8mBk9g_7jokqAqkA@mail.gmail.com>
 <CAJZ5v0jB1hqzYK8ezjf1_1yMCudNXNS-CsrUJQcmL4W5mBD6fQ@mail.gmail.com>
 <20200326115730.GQ1922688@smile.fi.intel.com>
From:   Grant Likely <grant.likely@arm.com>
Message-ID: <73f75a7d-dd5d-30d3-0acc-549d87a5ab1c@arm.com>
Date:   Thu, 26 Mar 2020 13:48:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200326115730.GQ1922688@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0415.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::19) To DB8PR08MB4010.eurprd08.prod.outlook.com
 (2603:10a6:10:ab::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.16.141] (92.40.174.0) by LO2P265CA0415.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a0::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18 via Frontend Transport; Thu, 26 Mar 2020 13:48:35 +0000
X-Originating-IP: [92.40.174.0]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4813b717-eeeb-41f8-c729-08d7d18c660c
X-MS-TrafficTypeDiagnostic: DB8PR08MB4569:|AM0PR08MB3490:
X-Microsoft-Antispam-PRVS: <AM0PR08MB34905447BBB94F7621626ABC95CF0@AM0PR08MB3490.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;OLM:8882;
X-Forefront-PRVS: 0354B4BED2
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(316002)(16576012)(110136005)(8936002)(4326008)(478600001)(44832011)(16526019)(8676002)(81166006)(81156014)(26005)(186003)(36756003)(66476007)(86362001)(52116002)(31696002)(54906003)(31686004)(7416002)(55236004)(53546011)(956004)(2616005)(6486002)(2906002)(5660300002)(66556008)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB4569;H:DB8PR08MB4010.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 9yqaJZzzShC31io2yPFeiUXm135ZovrAz3UMAvcTiEJvR1+ZDsdpmpSPqGg3GCFvoNv+U2Nkf70BsDPgopCHLynLZxGyWaNfJR3X7fOIfHDuFxWzEc5RzKxAshZacAAGQqL8tWSJ9iIOKQEGEKYpuT/lBif3nhXO4152eLHaGDp+HilyE+/XBhszxJcUtoj2BxHdyE4MHXkgn+OyNNTY0A3Yg6RKxn+2NVuB8m59tO5bo1fONuwfrzYC7BHu65Z2VqOb2KHqUCmHXNaeUkc+C5sGwBd4hknC7Kvwsy+kFksurxOCUXHpTgdfnxC/+AAOo+PTdGJEdsoMhQEsbbWhEk4onRwqtIRb9RYdcH+o3Of2u95aPv0iPMnfKeAmAx97/501XkDNux9f2obsABcfzBz0GX15UQa/qDOJp80mqfrg/RjZMiVFqhgSCGmCaZ/O
X-MS-Exchange-AntiSpam-MessageData: VHvMD/vszstIuq99Co6E5unkYuXbKz603ysmAlWIqJepV+5pgOdZfKeTjnKKePXvHaBaKax5mKm3eccruTsRxPvvtIkRbU5REdfhXMsf9w8GMf5nTWhcHelws4liSx8EvsNcygOYLW4US9v54gBXvw==
X-MS-Exchange-Transport-Forked: True
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4569
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Grant.Likely@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT046.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(346002)(376002)(46966005)(450100002)(356004)(82740400003)(4326008)(2906002)(81156014)(81166006)(47076004)(316002)(8936002)(16526019)(8676002)(16576012)(54906003)(110136005)(26005)(336012)(186003)(86362001)(26826003)(956004)(2616005)(44832011)(70586007)(6486002)(36756003)(31686004)(478600001)(70206006)(31696002)(5660300002)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3490;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 01674478-0f7b-4648-d2de-08d7d18c61fc
X-Forefront-PRVS: 0354B4BED2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UwSPyFJBdFvFMUdt7JD/Lo0V+XkXJ0CCyhMuPs+Z6JxbTiQZZn0BYlXByEHJClwhQ2c1N3TOxLAY+YbCl2/F5Aao/YkFPZGiBAovVCZxBlvYwrcmJTMqYSqn8IcLjzSXsHQPpnwQGfgw4Kg0hYx2KRwTLEftr1uFFVVFLIL2qD1xXZvgD2bf0N/fD6IkvF0WyDAYv+zKtw252LFgs5BVme+/RPJJ6VqRtTeG43J25U6cpC1/VvOqq/Zq7rdI1Vpc1SIc7bWYkBcje/bSMeId4ptsdNlcMefTV/9eo2QKMJCO1uBVPiUR8aw/R/9NlzJxZeQMV2jo6ejgN/ffn/io9KyEHi/qsAhPMj7TnTzy28TIKyDLl4b8dPxskFKrG0CoFzEGRFbKs2RBUEQtiEXfFSvN/Lat8wVTOMKT3ZNNnkkic1sxIKPL5fQ4GrA5/zQ3MjE8T8LewMjJU+efHD1dboKrdgvFByOwqQe8FWqnrjfCb+HSJeObTlt1JriEnghCIeIsjLw0vu4C16OB1APg6w==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2020 13:48:43.3634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4813b717-eeeb-41f8-c729-08d7d18c660c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3490
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 26/03/2020 11:57, Andy Shevchenko wrote:
> On Thu, Mar 26, 2020 at 09:39:40AM +0100, Rafael J. Wysocki wrote:
>> On Wed, Mar 25, 2020 at 11:09 PM Saravana Kannan <saravanak@google.com> wrote:
>>> On Wed, Mar 25, 2020 at 5:51 AM Andy Shevchenko
>>> <andriy.shevchenko@linux.intel.com> wrote:
> 
>>>> Yes, it's (unlikely) possible (*), but it will give one more iteration per such
>>>> case. It's definitely better than infinite loop. Do you agree?
>>>
>>> Sorry I wasn't being clear (I was in a rush). I'm saying this patch
>>> can reintroduce the bug where the deferred probe isn't triggered when
>>> it should be.
>>>
>>> Let's take a simple execution flow.
>>>
>>> probe_okay is at 10.
>>>
>>> Thread-A
>>>    really_probe(Device-A)
>>>      local_probe_okay_count = 10
>>>      Device-A probe function is running...
>>>
>>> Thread-B
>>>    really_probe(Device-B)
>>>      Device-B probes successfully.
>>>      probe_okay incremented to 11
>>>
>>> Thread-C
>>>    Device-C (which had bound earlier) is unbound (say module is
>>> unloaded or a million other reasons).
>>>    probe_okay is decremented to 10.
>>>
>>> Thread-A continues
>>>    Device-A probe function returns -EPROBE_DEFER
>>>    driver_deferred_probe_add_trigger() doesn't do anything because
>>>      local_probe_okay_count == probe_okay
>>>    But Device-A might have deferred probe waiting on Device-B.
>>>    Device-A never probes.
>>>
>>>> *) It means during probe you have _intensive_ removing, of course you may keep
>>>> kernel busy with iterations, but it has no practical sense. DoS attacks more
>>>> effective in different ways.
>>>
>>> I wasn't worried about DoS attacks. More of a functional correctness
>>> issue what I explained above.
>>
>> The code is functionally incorrect as is already AFAICS.
>>
>>> Anyway, if your issue and similar issues can be handles in driver core
>>> in a clean way without breaking other cases, I don't have any problem
>>> with that. Just that, I think the current solution breaks other cases.
>>
>> OK, so the situation right now is that commit 58b116bce136 has
>> introduced a regression and so it needs to be fixed or reverted.  The
>> cases that were previously broken and were unbroken by that commit
>> don't matter here, so you cannot argue that they would be "broken".
>>
>> It looks to me like the original issue fixed by the commit in question
>> needs to be addressed differently, so I would vote for reverting it
>> and starting over.
> 
> I think Saravana's example is not fully correct as I had responded to his mail.
> I would like to hear Grant, but seems he is busy with something and didn't reply.

Sadly I don't look much like a kernel developer these days. The last 
code change I committed to the kernel was over 4 years ago.

g.
