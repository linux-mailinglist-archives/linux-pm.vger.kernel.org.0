Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB66194029
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 14:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgCZNqI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 09:46:08 -0400
Received: from mail-eopbgr140050.outbound.protection.outlook.com ([40.107.14.50]:38703
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726359AbgCZNqF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Mar 2020 09:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2XK8lwFOcD1KKuyU6VhRPOIPugs8cJ7rHDNc1bI+Hk=;
 b=ZMd0GsKtVUaid+StSOiE+4Szhfi3B65Jok6FrEY+/UN67M3gcChetfubi8iC+QJJx+Tut/wbV4vC1JC/+p0EgsGMrQPMaVGGkF+5OEpKHvN2YYCqpNLQRPn2GEs3cUUmAF3EwGPa+Gsuk8Jg7wwHbG3JyyleUg7BZl+5tJYZ9NI=
Received: from DB8P191CA0027.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::37)
 by DB8PR08MB5324.eurprd08.prod.outlook.com (2603:10a6:10:11e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Thu, 26 Mar
 2020 13:46:00 +0000
Received: from DB5EUR03FT064.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:130:cafe::c) by DB8P191CA0027.outlook.office365.com
 (2603:10a6:10:130::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20 via Frontend
 Transport; Thu, 26 Mar 2020 13:46:00 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT064.mail.protection.outlook.com (10.152.21.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.17 via Frontend Transport; Thu, 26 Mar 2020 13:46:00 +0000
Received: ("Tessian outbound 19f8d550f75c:v48"); Thu, 26 Mar 2020 13:46:00 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 4ba8de5ebd98c7b9
X-CR-MTA-TID: 64aa7808
Received: from 3f2188c1157e.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D1058082-F5B3-4E9E-8E30-C4EE924BC052.1;
        Thu, 26 Mar 2020 13:45:54 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 3f2188c1157e.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 26 Mar 2020 13:45:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FsPXkE869yamamJ19u5WCh2n3/UDJ16GQEYgKRv3W/6kH6NAagxUDdbS5lXPYX3W0J63aXCcUSpC696qc42tEndgLCNc4kjrX8T4ZAXrbmJ391M9PKcC5EMZM2y6ni9B/RNANKYN6ixz+hHEBdQX8qedEnly2zBTE9o992tU/f/uuMl1IjVLkpoakZJOGl9o9giQZKCwF+jpz2A+qx4RJWRDnZso0c77jRfiKz4tj/3Rwo5DhdpC77j9Jd7GUDXMUaN1fGM6vAuYFMd8wqGCQctqOyZGllTH4myMsUCLZTBuhfqpL3J5fvHSqg6FeCUYI+9XLJfxuGmh3VU0TtM54Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2XK8lwFOcD1KKuyU6VhRPOIPugs8cJ7rHDNc1bI+Hk=;
 b=BYDwgYLA3GIr0azsZ6Dn3xLsEmkl11k6pYznzuHAl4PFZfMyTGT+ucEWDI8o2e1goS6Ucql+ErHik2NjUsem8QvTWmjelJfdiOAQKEjBjT08GBd7/O6KFLVwRdO1XQKcV17oX5AV7FmXWcRRT0jzAJPv583UebMSRS6u5+4CjaK2Rj1sEEsa4SkX9cxPcYaZQvHfKqsAHaDqstmk9mXvaR1mEKSYOd4w4MBx9MrMQfoVpU0s5K3sh1hFIITcFUp/DDc1mZl68mUFcs5fYaGjsysPpBSuqosbmvyHHhmGhV2+wL4dsEXz6UWKURnRprMLtLurtLG54d4UzPMCCXWjqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2XK8lwFOcD1KKuyU6VhRPOIPugs8cJ7rHDNc1bI+Hk=;
 b=ZMd0GsKtVUaid+StSOiE+4Szhfi3B65Jok6FrEY+/UN67M3gcChetfubi8iC+QJJx+Tut/wbV4vC1JC/+p0EgsGMrQPMaVGGkF+5OEpKHvN2YYCqpNLQRPn2GEs3cUUmAF3EwGPa+Gsuk8Jg7wwHbG3JyyleUg7BZl+5tJYZ9NI=
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Grant.Likely@arm.com; 
Received: from DB8PR08MB4010.eurprd08.prod.outlook.com (20.179.10.207) by
 DB8PR08MB5100.eurprd08.prod.outlook.com (10.255.18.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Thu, 26 Mar 2020 13:45:52 +0000
Received: from DB8PR08MB4010.eurprd08.prod.outlook.com
 ([fe80::4521:d746:9e7:4ae3]) by DB8PR08MB4010.eurprd08.prod.outlook.com
 ([fe80::4521:d746:9e7:4ae3%5]) with mapi id 15.20.2835.023; Thu, 26 Mar 2020
 13:45:52 +0000
Subject: Re: [PATCH v3] driver core: Break infinite loop when deferred probe
 can't be satisfied
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mark Brown <broonie@kernel.org>, Ferry Toth <fntoth@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        nd <nd@arm.com>
References: <20200324175719.62496-1-andriy.shevchenko@linux.intel.com>
 <20200325032901.29551-1-saravanak@google.com>
 <20200325125120.GX1922688@smile.fi.intel.com>
 <CAGETcx_TGw24UqX7pXZePyskrao6zwnKTq8mBk9g_7jokqAqkA@mail.gmail.com>
 <CAJZ5v0jB1hqzYK8ezjf1_1yMCudNXNS-CsrUJQcmL4W5mBD6fQ@mail.gmail.com>
 <ca661616-f5bf-d92f-9173-172792797b16@ti.com>
 <20200326120323.GR1922688@smile.fi.intel.com>
From:   Grant Likely <grant.likely@arm.com>
Message-ID: <6c04af00-adc8-6be2-b7fd-b4a875524563@arm.com>
Date:   Thu, 26 Mar 2020 13:45:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200326120323.GR1922688@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0050.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::14) To DB8PR08MB4010.eurprd08.prod.outlook.com
 (2603:10a6:10:ab::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.16.141] (92.40.174.3) by LNXP265CA0050.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:5d::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19 via Frontend Transport; Thu, 26 Mar 2020 13:45:51 +0000
X-Originating-IP: [92.40.174.3]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b33cdbca-8eeb-4e6e-f6bc-08d7d18c04be
X-MS-TrafficTypeDiagnostic: DB8PR08MB5100:|DB8PR08MB5324:
X-Microsoft-Antispam-PRVS: <DB8PR08MB5324F59C3F2C0C50D467466B95CF0@DB8PR08MB5324.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;OLM:8882;
X-Forefront-PRVS: 0354B4BED2
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(16576012)(44832011)(316002)(110136005)(7416002)(54906003)(5660300002)(6486002)(2906002)(4326008)(31686004)(478600001)(86362001)(66556008)(31696002)(81166006)(186003)(16526019)(81156014)(53546011)(66476007)(52116002)(55236004)(2616005)(8676002)(956004)(26005)(36756003)(8936002)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB5100;H:DB8PR08MB4010.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 0CNrdGIgxtyRUEO74RYFax+tkmhb4CjhHe1Tm45RgDyQBdDE6FUlcFqdwebBnmkjwAPyTMomUmAyq0KS3jCe/C0t1oMiv8UV0MbBrIl4yRuiv2vXnYG6dH0hdKu+SJxEb7Z3GkKwKvJJlbuHJkyXRzehiAhNJOUS5c8cD6VBOWEngjGB3GF4fUFdqVlsySINW8T6KhT1aF4abQVqaOjMhQnjzFNOyIfuc0nOh07AtlStxQKnNnOrYmQfrVORT5rTTV62xAb9edvaQuigtkVNkcs8k+kLpLpm4xKIrdbp6mtvv4i9Q6O6h3AI4LbgnmpUQEUIpx9BG2CZXM7UE0FqzNepSuFJlu1HOqwojeXBJy1QneKeyNGqMlExEtQNaSkndtM8FUrZdk5D2RqQZj0bOcIUnfam7CNUxKz7GCFwNABhV7LahibevbRMJygBMmmB
X-MS-Exchange-AntiSpam-MessageData: YBD1pvzDolVNGksaDXShVNKMgkt8HBmxpUOrJ1Jv6JkWcYzC80JsRUEKSJ79wGBmXrYa5Yspe9GI0gb6xzr+gRwthxm1aDGaJ36REAiWjAWzWXNDY69iR88SkfSPYn6nSxP8y8RAbwGFnf8yclraRA==
X-MS-Exchange-Transport-Forked: True
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5100
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Grant.Likely@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT064.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(396003)(346002)(39860400002)(46966005)(356004)(6486002)(336012)(450100002)(8676002)(26005)(81156014)(8936002)(4326008)(81166006)(956004)(2616005)(16526019)(186003)(36756003)(44832011)(110136005)(86362001)(70206006)(478600001)(31686004)(47076004)(31696002)(53546011)(26826003)(16576012)(316002)(54906003)(2906002)(70586007)(5660300002)(82740400003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB5324;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7e16c0e5-c806-487a-942f-08d7d18c003d
X-Forefront-PRVS: 0354B4BED2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +F/4rClX+u9IDrx6lZakcKXNppbO06cfoswlCLb2nVOWhkxUrqBZe4hSoe+IxrNfmB3EuZwVCts/kkmD+ZeekqjmRu+g+Kda6ksFfbJNAe/wZCLZMhPuELCJ7enpKouTAXlPf7NJns2Aqk0qUYtkIJg/+FOWAqD7zogWhlE9n2F931BYTkNpDvM7ATpEz2HPTyjy4+iJm/F6V52LOVbSVRlEkXqncJqLl+NWbuJnDBJIvhrwX1ndavg9N0yHliaoyz5Fd+vkfffLC7i8wI5BoJU7MvtuRjpeL87ivCU351cbNv498APIiRh/AWdClrMSRLvipjtzeEAgRgUW+xOxJwZxcl/BnuRjwUYt09r2Xv61zqD+fzIdoSnaUTzfcTbfWhVCiEzFyOsud5bkbsq8QJjOX8jaGr5xoe7iDU/CE5lfKB5BirDQD5uyw5fuwOwNlrDeioyMF7zHAG6+WKjcsKEizBu9ddxyHEr+AqA7JiYHhMXjd5DSfH/rQdsRsS/XDRSutQJ6gUI4soQSIl9Fiw==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2020 13:46:00.1154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b33cdbca-8eeb-4e6e-f6bc-08d7d18c04be
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5324
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 26/03/2020 12:03, Andy Shevchenko wrote:
> On Thu, Mar 26, 2020 at 11:45:18AM +0200, Peter Ujfalusi wrote:
>> On 26/03/2020 10.39, Rafael J. Wysocki wrote:
>>> On Wed, Mar 25, 2020 at 11:09 PM Saravana Kannan <saravanak@google.com> wrote:
>>>> On Wed, Mar 25, 2020 at 5:51 AM Andy Shevchenko
>>>> <andriy.shevchenko@linux.intel.com> wrote:
> 
> ...
> 
>>> OK, so the situation right now is that commit 58b116bce136 has
>>> introduced a regression and so it needs to be fixed or reverted.  The
>>> cases that were previously broken and were unbroken by that commit
>>> don't matter here, so you cannot argue that they would be "broken".
>>
>> commit 58b116bce136 is from 2014 and the whole ULPI support for dwc3
>> came in a year later.
>> While I agree that 58b116bce136 fail to handle came a year later, but
>> technically it did not introduced a regression.
>>
>> The revert on the other hand is going to introduce a regression as
>> things were working fine since 2014. Not sure why the dwc3 issue got
>> this long to be noticed as the 58b116bce136 was already in kernel when
>> the ULPI support was added...
> 
> I dare to say that is luck based on people's laziness to figure out the root
> cause. As I pointed out in email to Saravana the issue is not limited to USB
> case and, if my memory doesn't trick me out, I suffered from it approximately
> in ~2014-2015 with pin control tables.

I've not been involved in this for a very long time, but from our past 
conversations and the description that is given here I still feel that 
this problem is a design bug on the dwc3 driver dependencies rather than 
a failure with driver core. dwc3 is doing something rather convoluted 
and it would be worth reevaluating how probe failures are unwound on 
that particular driver stack.

g.
