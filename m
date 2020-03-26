Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5D811942E3
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 16:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgCZPVA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 11:21:00 -0400
Received: from mail-eopbgr150087.outbound.protection.outlook.com ([40.107.15.87]:50775
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726067AbgCZPVA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Mar 2020 11:21:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDHXo/uhL7qfvYUPjJLBffdYPJqfpZwbZY4HCAyljaM=;
 b=p32YQxY/ODdP1/mCCp3/XN1wLEprEoxapruNYVuUpsBLmbaknmd7uLldlJpuQRbufgOFopq4dfzRqgxNMAo9SZtGbcJNuTRB+n99vDKB3yF3sJLZzGfz3f5Rkbrx9NlsfrUW3JsasMJeLBKVmD1tcxaPcBfhuK8G43139aCZYYw=
Received: from DB6PR1001CA0007.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:b7::17)
 by AM6PR08MB5094.eurprd08.prod.outlook.com (2603:10a6:20b:e4::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Thu, 26 Mar
 2020 15:20:54 +0000
Received: from DB5EUR03FT028.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:b7:cafe::1b) by DB6PR1001CA0007.outlook.office365.com
 (2603:10a6:4:b7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19 via Frontend
 Transport; Thu, 26 Mar 2020 15:20:54 +0000
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
 15.20.2856.17 via Frontend Transport; Thu, 26 Mar 2020 15:20:54 +0000
Received: ("Tessian outbound fb361fb66447:v48"); Thu, 26 Mar 2020 15:20:54 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 35c0a64cbefaeb34
X-CR-MTA-TID: 64aa7808
Received: from 1339a7ce3481.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 6E1BB955-5A9B-4FB2-81B5-8F1EF67E1CD6.1;
        Thu, 26 Mar 2020 15:20:49 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 1339a7ce3481.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 26 Mar 2020 15:20:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/iLOTvPxOsFaj8ANy9Gt2MyIPFEax9I7ngtxumsx2wO0Gmamh9ipj8MFbZibLsdU4IXFrzsU5cHD94mXgopT8zIwET5tn1DZKl4ozWXBWNVLD1ztG1IXErAglzbhl8dgQ0OE32XLQ8EP8He4FMRfH0k+p9MsdPbOHjVhZXguKnMOoO8BOuremSG3kkFQty5k1TXH/Gj1cqOKrAUan823GyYYxOOn/TgTGWkvi08FvN4HdnFmc6AviiJNltVz2XI0SJRyhqT7jo+k7r/YeIZ1V0kd+p8WTOS3GHPVbV6/o1sk9ZCpxed6bEeCzrhehQBl2xa8/2hjHG3uGKCLP7pTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDHXo/uhL7qfvYUPjJLBffdYPJqfpZwbZY4HCAyljaM=;
 b=fkfdKjZmt6QPSAVwt2GfaU5+W4DEEsBnDJ2EBWSqdLrc3Zz1nhvvHLOX6YG81tB1YxzPJ/VgwJ67vsdVTF/YnsPA5IxiUyv9IccZXSgc97Wz4JEUuKJh0iD4pLiME1R6hbJpeIApFIAjzXe3fOozPn53eLH3BB0Y0bfdX9F1glNg8mHHaSs/9+twmY8S2lsvv+wYoWOgKxs3FbIh/L9BJnpekKXIla7KwvjH8p8wc2iszbmDXTq/+VPfx63bPP0JIHf1fNgVtsBoLUMbDuLRWZZ00mKn2WdroPU/dxSdyA7t2EK8YRyTxKT+KV2lPTLeUXftHh4l6i8hyA6xvSlD+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDHXo/uhL7qfvYUPjJLBffdYPJqfpZwbZY4HCAyljaM=;
 b=p32YQxY/ODdP1/mCCp3/XN1wLEprEoxapruNYVuUpsBLmbaknmd7uLldlJpuQRbufgOFopq4dfzRqgxNMAo9SZtGbcJNuTRB+n99vDKB3yF3sJLZzGfz3f5Rkbrx9NlsfrUW3JsasMJeLBKVmD1tcxaPcBfhuK8G43139aCZYYw=
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Grant.Likely@arm.com; 
Received: from DB8PR08MB4010.eurprd08.prod.outlook.com (20.179.10.207) by
 DB8PR08MB5259.eurprd08.prod.outlook.com (20.179.15.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.19; Thu, 26 Mar 2020 15:20:47 +0000
Received: from DB8PR08MB4010.eurprd08.prod.outlook.com
 ([fe80::4521:d746:9e7:4ae3]) by DB8PR08MB4010.eurprd08.prod.outlook.com
 ([fe80::4521:d746:9e7:4ae3%5]) with mapi id 15.20.2835.023; Thu, 26 Mar 2020
 15:20:47 +0000
Subject: Re: [PATCH v3] driver core: Break infinite loop when deferred probe
 can't be satisfied
From:   Grant Likely <grant.likely@arm.com>
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
 <295d25de-f01e-26de-02d6-1ac0c149d828@arm.com>
Message-ID: <2a5cb0a2-6236-d265-ae88-e0d0db427d38@arm.com>
Date:   Thu, 26 Mar 2020 15:20:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <295d25de-f01e-26de-02d6-1ac0c149d828@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0348.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::24) To DB8PR08MB4010.eurprd08.prod.outlook.com
 (2603:10a6:10:ab::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.16.141] (92.40.174.3) by LO2P265CA0348.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:d::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19 via Frontend Transport; Thu, 26 Mar 2020 15:20:45 +0000
X-Originating-IP: [92.40.174.3]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f700205f-3428-453a-4664-08d7d19946f7
X-MS-TrafficTypeDiagnostic: DB8PR08MB5259:|AM6PR08MB5094:
X-Microsoft-Antispam-PRVS: <AM6PR08MB5094B5B1F702648B0B6720F595CF0@AM6PR08MB5094.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;OLM:7219;
X-Forefront-PRVS: 0354B4BED2
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(26005)(66946007)(6666004)(66476007)(55236004)(66556008)(36756003)(53546011)(44832011)(956004)(2906002)(478600001)(2616005)(186003)(16526019)(31686004)(86362001)(8936002)(8676002)(81166006)(110136005)(81156014)(5660300002)(52116002)(16576012)(4326008)(7416002)(6486002)(31696002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB5259;H:DB8PR08MB4010.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: uGoXK9/m9VoKAU/aouPIRdEjnQBxxfKSkcwAtksw5eBdrTH/xU969iToBW3sX/9LAUpzfKDhEUovn4+XoIl64eO0rtr4u//2PiQ3j6bm7F9EDG/IUuHKOEvC9EwdqQyjF7W+dwQns96cTHHucB/Xcndooi+f9yHU10fMx+nxBLyhaRvcARLkuoi+fbJ5L9IUf9aaQuuI754p83dHl5F0Twf3Oz2MtYiKdZVWNPZL66yptLKbPmFPXfb/BHBiYs2kPDH9UrJkCMEIZ4Zr10ijt/Sk92T3ajdduH//zCd6a5Bld4rrouoOimodSvDyZnr8UuvpPO1TX0dsHPT6tFfrFwxi12lVyLVRp8FuFbEq5YnH+dcF+Rq2hoSSbM60f9jdoBZlXFAHwSrm9+rWBAC+aSUtGywEpagDaLGmL7v9thTelGjS2Q6TDrYir14wfM1b
X-MS-Exchange-AntiSpam-MessageData: sZbDXj8AqtqxdcxU9+kkMD8jlcrE/nE5GdS6Lc8vAE47o5LFucJvlIKVa5jI6V7buFfeImt0Y9cQ/R8YwOFaKRCmz6LqW4wszTQzWtgzYBtBaojwQfmnCBQvLHot/78uPNIBLWffPNbXFYEE48yZow==
X-MS-Exchange-Transport-Forked: True
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5259
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Grant.Likely@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT028.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(376002)(46966005)(6486002)(956004)(186003)(2616005)(26005)(316002)(5660300002)(8676002)(47076004)(82740400003)(16576012)(336012)(16526019)(36756003)(44832011)(110136005)(70586007)(8936002)(26826003)(478600001)(70206006)(53546011)(31696002)(81156014)(81166006)(450100002)(86362001)(356004)(6666004)(2906002)(31686004)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB5094;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;
X-MS-Office365-Filtering-Correlation-Id-Prvs: f2d481d5-c65c-4198-1d22-08d7d1994254
X-Forefront-PRVS: 0354B4BED2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LwLqvI7Ri5H86dMniU0y7A4V6yUkM+AbT8Hmh0kvTYT2v2wnK7IawbXlgPedIHGaq/zx+2er0sDAgbJ3mEOwUT8TObxKl9yLwmDya0SDmC6P5Q38Z91A+Rvi/XucNnq71r8P+o5vbCemgHZHM51F64Jgf2P83x0hEyZvW5mPZwNeBrKhYxmdI3vcAHRJWvuzJ0bViwgJlxlIzR3ladLSCeTZBEOcVVZO0wMF0ZoB69J5wbF4w+67XrSBVeBZ/4jJCwL1u8DMuHs9cYFib196OsB3q+mFEzQtw6I2kjh4kPUE3MIsVO9nVPynJhQUmSVFVw1Od2gKDTaJspy1SsGrz1+gXsWNe3sjlC9o5I9M4vxmoYjWoWWS6gY0YJxrqkVhpTrSJz9qNsOMqLHYAH4CLP5HHubycxSZTniy69+2o7TqrjVT5ES5P56Dq/xo7+1h9qDOEIPfmsgSZHEO4vVa47r6j4M6zQS9ValBhx25AJmE0j+WmcBe6M7LjP/EjXAU1WFDwJ8eml1v2kkMOyyx6g==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2020 15:20:54.6936
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f700205f-3428-453a-4664-08d7d19946f7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5094
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26/03/2020 15:01, Grant Likely wrote:
> 
> 
> On 25/03/2020 12:51, Andy Shevchenko wrote:
>> On Tue, Mar 24, 2020 at 08:29:01PM -0700, Saravana Kannan wrote:
>>> On Tue, Mar 24, 2020 at 5:38 AM Andy Shevchenko 
>>> <andriy.shevchenko@linux.intel.com> wrote:
[...]
>>>> ...but extcon driver is still missing...
>>>>
>>>> [   22.283174] platform dwc3.0.auto: Added to deferred list
>>>> [   22.288513] platform dwc3.0.auto: 
>>>> driver_deferred_probe_add_trigger local counter: 1 new counter 2
>>>
>>> I'm not fully aware of all the USB implications, but if extcon is
>>> needed, why can't that check be done before we add and probe the ulpi
>>> device? That'll avoid this whole "fake" probing and avoid the counter
>>> increase. And avoid the need for this patch that's touching the code
>>> code that's already a bit delicate.
>>
>>> Also, with my limited experience with all the possible drivers in the
>>> kernel, it's weird that the ulpi device is added and probed before we
>>> make sure the parent device (dwc3.0.auto) can actually probe
>>> successfully.
>>
>> As I said above the deferred probe trigger has flaw on its own.
>> Even if we fix for USB case, there is (and probably will be) others.
> 
> Right here is the driver design bug. A driver's probe() hook should 
> *not* return -EPROBE_DEFER after already creating child devices which 
> may have already been probed.
> 
> It can be solved by refactoring the driver probe routine. If a resource 
> is required to be present, then check that it is available early; before 
> registering child devices.

If it is difficult to determine whether extcon is available before 
creating the child devices, then there is a way to solve it that still 
leverages the driver core. You could refactor dwc3_core_init_mode() into 
a set of separate probe() routines, one for each mode. dwc3_probe() 
could register the matching child device just before it exits. Then the 
driver core will take care of calling it again at a later point in time 
without tearing down the ulpi device probe.

Cheers,
g.
