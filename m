Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C38032EC9E
	for <lists+linux-pm@lfdr.de>; Fri,  5 Mar 2021 14:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhCEN4U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Mar 2021 08:56:20 -0500
Received: from mail-eopbgr60080.outbound.protection.outlook.com ([40.107.6.80]:11342
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229646AbhCENzr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Mar 2021 08:55:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivUVQSI7GgX3OUdjmG0edilgm06YVyfJOUrWtRvmpZ8=;
 b=i6gMoEFY30sjzxyoxYnG6lc1vjMQy0B38PbCvgtMNZcqI3F6y8DSw5ZvK4SGjN1b3th2eZLInCSTi1FMfxLrmhp9tLsUn64XhvbjDlLDgYfzdambugvWhiBNcp+k57u5xmT6XmoKEaD9V8KOLjtZ7gwlNU5tBmasa3As49kFEXI=
Received: from AM5PR0601CA0064.eurprd06.prod.outlook.com (2603:10a6:206::29)
 by PR3PR08MB5836.eurprd08.prod.outlook.com (2603:10a6:102:8f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 5 Mar
 2021 13:55:40 +0000
Received: from VE1EUR03FT057.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:206:0:cafe::46) by AM5PR0601CA0064.outlook.office365.com
 (2603:10a6:206::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 5 Mar 2021 13:55:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT057.mail.protection.outlook.com (10.152.19.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 13:55:39 +0000
Received: ("Tessian outbound efd554c08f3f:v71"); Fri, 05 Mar 2021 13:55:39 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 668f4d5d6b7cc9ac
X-CR-MTA-TID: 64aa7808
Received: from f7aa7be1fa68.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0617D4F5-E90C-45B7-9F1C-25C5B13779F6.1;
        Fri, 05 Mar 2021 13:55:33 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f7aa7be1fa68.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 05 Mar 2021 13:55:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJKqjIjA6x8ElvD5dpL7AzbIu+TrkAByvznLnTANHmTVvb3V+VI/LPkFgFd1/r/05Deak6BFr2gugSGVCR/Mm+tkfTLg/OQq1Hsj34971rhD5lTRS12hbHOffQZfenyqfL+Kiat6YvCjR4jIQv7WDUTKAC3Sg23MPRDSX4APW2u0UaNw7VrB06AReoAAku/Q6+oECauJcPKivPy72EgVwpTV0Lb/C6Izkn82GfX/c84VqCOUtUAnKPTHouo3XnOFT20FMtubSUSjpU6H2d/cuHSoRPiBkAOmfJo2iN5VsRFVq9FxLoPk2Xn3PFSsZkHGXq6g3unloXck0HKCAsdo6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivUVQSI7GgX3OUdjmG0edilgm06YVyfJOUrWtRvmpZ8=;
 b=TjSCdv4lWeESiQTrtTsspLBX7RxTBX7fcFNy24U5BNPIOZkEvlKKTvsgsGs5sDjvDRA1pDsA2muJeJb2um+YgHun8JWLTI8vPZ9URiXosgTfaplnde4w1kM6S9N23y/wHmOvs8eO+sx1FxTMgTlzLdrjtwoic3AUV1jGa1p9RmCNEQXtuDnhc7ZUI8mbVZI87YE4Cvc//CbwPEJlzTq8axBhz5oYSu+U1vCnmt3kFOBbEgXRMP6w6AzaOQ0LuG7XolPegaMGXUZGUI/YjVNFZ0VU5ko+FZJtU3mqbGbqIbQ+U8GExG0G9XIX2VTyGBUDM6vRwp4pS0faz+/jbf98Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivUVQSI7GgX3OUdjmG0edilgm06YVyfJOUrWtRvmpZ8=;
 b=i6gMoEFY30sjzxyoxYnG6lc1vjMQy0B38PbCvgtMNZcqI3F6y8DSw5ZvK4SGjN1b3th2eZLInCSTi1FMfxLrmhp9tLsUn64XhvbjDlLDgYfzdambugvWhiBNcp+k57u5xmT6XmoKEaD9V8KOLjtZ7gwlNU5tBmasa3As49kFEXI=
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
Received: from DB8PR08MB5337.eurprd08.prod.outlook.com (2603:10a6:10:11e::9)
 by DB9PR08MB6505.eurprd08.prod.outlook.com (2603:10a6:10:23e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 5 Mar
 2021 13:55:30 +0000
Received: from DB8PR08MB5337.eurprd08.prod.outlook.com
 ([fe80::508a:e472:afe1:8b0d]) by DB8PR08MB5337.eurprd08.prod.outlook.com
 ([fe80::508a:e472:afe1:8b0d%9]) with mapi id 15.20.3868.038; Fri, 5 Mar 2021
 13:55:28 +0000
Subject: Re: [PATCH] opp: Invalidate current opp when draining the opp list
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org
References: <1614870454-18709-1-git-send-email-beata.michalska@arm.com>
 <20210305042401.gktrgach4dzxp7on@vireshk-i7>
From:   Beata Michalska <beata.michalska@arm.com>
Message-ID: <418fc3cb-d5ec-9216-269a-e055e78718e5@arm.com>
Date:   Fri, 5 Mar 2021 13:55:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210305042401.gktrgach4dzxp7on@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [217.140.99.251]
X-ClientProxiedBy: LO2P265CA0129.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::21) To DB8PR08MB5337.eurprd08.prod.outlook.com
 (2603:10a6:10:11e::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.57.47.43] (217.140.99.251) by LO2P265CA0129.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9f::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend Transport; Fri, 5 Mar 2021 13:55:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e580ffb1-29a1-4403-a6fc-08d8dfde5c48
X-MS-TrafficTypeDiagnostic: DB9PR08MB6505:|PR3PR08MB5836:
X-Microsoft-Antispam-PRVS: <PR3PR08MB583637FBCD34478E39F9411BED969@PR3PR08MB5836.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: N/BsBr3wzREh4fSXUKOw3QIt9ilL99Xn1iqliI5TPdGGEMF25Bu20jBU7HsWGPIUyCMUPWJnAZo52+AN1U2LjPjASFu6OaK4BHDqRkEn4FIzuLrIt74uS+PuhDTdiD409qn/jdjVTwHzbgI0QRXTo6KnzN5B/xAedX9v2KO62K7GpyYGClAJeNCPHxQCiT+5XD/wLOniQmzj+bUpSbwPQP37PCoWkZq66aPEPRgs0Emmph08mFi1MwzQTXuL8TiqnKXP4GlqZZefWOJ91tupkaHrPdgdVJEqeXAWkRFHnKBLl1j6wSQPVxMUwvvJDrFLho5joHfmKwNyuPWvwAp00cVQ7WE1yOyRqBX7KJ+6BBpaXfqhCMj2G8YEOGAgI+Ob1hLu3dNgxH834ydBAd/GMvgcSx+TQy04gPdL1hIvp0wbOfcW8A7XvAIlisN8fsZe5Iljvehbyyk25UiFC2WUb+T+mcgxUhdT4/ZT2bo8FlQ0w4Gx4GI25kyCAsH3kMbeb8wE7D67O8UHM2j1K7PVIzJNJ4CcEMd8vMMDZQD3plRqK+hxr+0xOJdmIa/5hMz06cOkTlZsJRTaKHnVxwnhu5GPvNzUZl5mh38LeFABonY=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5337.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(6486002)(36756003)(31686004)(86362001)(478600001)(186003)(2906002)(16526019)(316002)(2616005)(52116002)(83380400001)(53546011)(4326008)(6916009)(26005)(16576012)(956004)(31696002)(8676002)(8936002)(5660300002)(6666004)(66556008)(66946007)(44832011)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?d1NOdktubmZJeDZQdVhkZjJXa1FaMHpyN2kyelBWS1hRMThPUXdHdGhSamdN?=
 =?utf-8?B?dFpUMGhqelVnZSsvcHZuemxSdWdTdm9oOVZzYTBvQWhkbnhDOTZuRHdXdGJR?=
 =?utf-8?B?UVFKckM0YjlhMEVoT1BRR0JjNi9QL0t2OXVtQzkzdVRrbEY1Y3p5T1J6MnRo?=
 =?utf-8?B?QktkUlNZMndVZW1DdDdkN00zVTkzZVFDZDVKNlhON3dCeVEycFVYOUlPdmJO?=
 =?utf-8?B?SHBlTUNjR1c3WDQzejUxZ3VwdmdUWlovWHp1SHlVVUUwSVhHWVozV2s3eHNi?=
 =?utf-8?B?S3Jmb0pQOG9DY2Q0YUw4SnRQM3N4YllXWFVCMTVuQlVwTG9YVnZ3bE0vSDJH?=
 =?utf-8?B?cFhRY3RCaitsNjQxOHVnaVpVcWdXUkUvMld6T3QwNUlFT2hURUppYmNGRUZI?=
 =?utf-8?B?OW92U3J4dHE3WG80SWEwSkxhREZVbW9tZjVDVTRIbjVUcEhHdWpISGd4aFFU?=
 =?utf-8?B?d1JDTFpINW1iUVV4cFk5SXd6bTZ5dW0rZ1d1TzdJQmFXU2cyeEE1cmZyU202?=
 =?utf-8?B?ZkVnempQUmNhTWllb21pTEROZjJuK3dRMUVVeWZmRU9BRnN4WWczc1F2Rklz?=
 =?utf-8?B?c2R6dngyckNrZWlra2hpeURiVy9xL21RYWxwRkxZdDlRVG8yWkRXQVZ5eVhj?=
 =?utf-8?B?bDRGQ2lwTDRUdW4xVUV3QW9NQTdDZS9UZHJqZGx5eDlhYjFSbjZHSldsbEhx?=
 =?utf-8?B?STFSdmxkMzNUVHhRTnMzQk5IZytCMldHOHVPM1A4TnB6U3BudDRIRElQUGxl?=
 =?utf-8?B?emVBZE5kMkFXWE9JY2t3UXMwb0l3ZEtlUVlQb2JSbFVIMXR3TWcwTkMwRkVr?=
 =?utf-8?B?cjc1R0xRaUYzdVErTW1GanN2anRKTnNFOUhMU1l1NHBhN1ZuOHk5RWYya25Z?=
 =?utf-8?B?b0hRZWtRdmpwMUVsTS9vZGNYSWU4WWdmcWdNY1J6Mmp5WGhwRXY3T2lYaHd4?=
 =?utf-8?B?OUxoTXlpbnYxcU9DQzlXMkR5eTVIa3FEQXJJR0tsVmNQODREdDd5U2NrRXdM?=
 =?utf-8?B?NUtOUGhPZDRONnJXZ0ZwL2p2bGs2Q1NLcEZqZ25vLytGNEhDZDRkQ1BtMm42?=
 =?utf-8?B?U2VvTkFVSG1hUDExK3ZyU1p4UHFhUWdkZnpEbU9UajBSRnU1bFhTZFJHQXM2?=
 =?utf-8?B?OHlVM05TNGhZaFQ0M0xyN3FHbnpLcWZQRXlSNFl5bUJJSXBEMHRsT01iY3hN?=
 =?utf-8?B?eXZMd1hYZVZzSTd0ZEJMa05lWGduQWswcHQyMUhvQXhrS2VDTUZrcWpMTi9u?=
 =?utf-8?B?a0hDZFkrTjRQbkZEZ2loWG5hbFZGMjQ1anFob3RlS1U1Zjh2UDh5d2pONkp6?=
 =?utf-8?B?TWptL0F0YjhBMUF0R0FGQkExdTRNaVp1cXYxVnpwUURhU296R054UTJ6cVFz?=
 =?utf-8?B?OVN2dlg3S0tpeGFlWTZaRmpwaVc2eDJKb1E0dzQzYTN1bjNlbWxQWlJ5OWF6?=
 =?utf-8?B?ZGRkbVRibUtVRXBaVXkvTFNjcURxZXljOFRMdEtyWVB6a1YrWlM3d2tmQm8y?=
 =?utf-8?B?aDNNL09FekVpQUxrTDVUbUgvcjB4R0RsSFdyYmtJcEw1YWY3akV5QTFhdGFZ?=
 =?utf-8?B?dzVOc3lqaC9VUVRyYzA2K3B2M2p6RUlZUytsU1BydUtzZ0RTK0F5VEhJZzZS?=
 =?utf-8?B?UmhOM0tNUHFxczRGOVR2YzZDaUJENzRSYW5zRjhpc3A3VzhZUk14YzlGQlJU?=
 =?utf-8?B?K3JUN2ZFNzBOWXhUam1vNXBKVytKYm5wMFFKeFd3ZXBOZlJRYUY5WHExS3FV?=
 =?utf-8?Q?V1MEoaaehHMnR1B0gSkbzocf438dPvNyVdT/LSx?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6505
Original-Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT057.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: fb333844-54ac-42b7-9e65-08d8dfde5577
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1lXVKvKPd/VDz2B7+5OUdBkJU5dR9CDVYs0lcp5JHER/00Z9H5c/grR9gs45jqeC6CBVuNT6lqnqo0G2UrIXzglRv6NwRuFGf/++Ah9yfAM7AljEM9amwyQ9/eQt8ziL9x67hJ78MVrjrcIvREeYmGr3mYK5h9APfpOSPBcQmwfoidvx5A9/aHvQbGAM7Fslil/8CjiYdCSaEJODmYtxi8Vaup2RpGbEkuR0qtNj3Wtnxj6Ut2njUGmdjFgIpyzx5HFEAGFXCQsabhxakWKK/UAZ7tG/+G4kLFTXTKe6/twDabgLNc4HDs6IVwIr8c/L7Bonv5ynAg80FBevm3anXYRB0j5HmRZZ/14hsVkf+iwWcJ9gmpVY56ZKUGUXdwDsaUNz/2G10w6NrE8cV1ZBMR07KrZQGW6o/0+bajtF53nyqoPEnpNSjo7ywDJzg4x/x5Noe6A/luhY2nP2jIP9PXjCMQmuAzj10pW1QFCJ7QRJ4tGQK0lSBW0wKRAjmeRJzP/gAV7tZIj/eUJqEj8HsmqFPcjmzwHmNcodgwsi5qNxV4HC1ERr9eiIKq/Pa6gm6ivvRQ0OIOruwU0+qgvC1SUreV06YQZ0RCXLbZBMW0UTTumjotI9oKR5zPI2YHyCFw6V+kl2S1Xtnxms63XuppaXTp9zBZcsnaI0CAfw86Y2sBlDdjkVgVtNNRImu+8H
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(46966006)(36840700001)(36860700001)(26005)(31686004)(36756003)(6862004)(16576012)(5660300002)(53546011)(4326008)(6666004)(47076005)(70206006)(8676002)(44832011)(70586007)(356005)(186003)(8936002)(86362001)(82310400003)(31696002)(956004)(2616005)(316002)(16526019)(478600001)(83380400001)(6486002)(450100002)(2906002)(336012)(81166007)(82740400003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 13:55:39.5105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e580ffb1-29a1-4403-a6fc-08d8dfde5c48
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT057.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5836
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 3/5/21 4:24 AM, Viresh Kumar wrote:
> On 04-03-21, 15:07, Beata Michalska wrote:
>> The current_opp when set, grabs additional reference on the opp,
>> which is then supposed to be dropped upon releasing the opp table.
>> Still both dev_pm_opp_remove_table and dev_pm_opp_remove_all_dynamic
>> will completely drain the OPPs list, including dropping the additional
>> reference on current_opp. This may lead to an attempt to access
>> memory that has already been released. Make sure that while draining
>> the list (in both dynamic and static cases) the current_opp gets
>> actually invalidated.
>>
>> Fixes: 81c4d8a3c414 ("opp: Keep track of currently programmed OPP")
>>
>> Signed-off-by: Beata Michalska <beata.michalska@arm.com>
>> ---
>>  drivers/opp/core.c | 49 ++++++++++++++++++++++++++++++++---------------=
--
>>  1 file changed, 32 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>> index c268938..10e65c4 100644
>> --- a/drivers/opp/core.c
>> +++ b/drivers/opp/core.c
>> @@ -1502,10 +1502,39 @@ static struct dev_pm_opp *_opp_get_next(struct o=
pp_table *opp_table,
>>      return opp;
>>  }
>>
>> -bool _opp_remove_all_static(struct opp_table *opp_table)
>> +static int __opp_drain_list(struct opp_table *opp_table, bool dynamic)
>>  {
>>      struct dev_pm_opp *opp;
>> +    int count =3D 0;
>> +
>> +    /*
>> +     * Can't remove the OPP from under the lock, debugfs removal needs =
to
>> +     * happen lock less to avoid circular dependency issues.
>> +     */
>> +    while ((opp =3D _opp_get_next(opp_table, dynamic))) {
>> +            /*
>> +             * The current_opp has extra hold on the ref count,
>> +             * still the draining here will result in all of them
>> +             * being dropped completely, so make
>> +             * sure no one will try to access the current_opp
>> +             * afterwords
>> +             */
>> +            if (opp_table->current_opp =3D=3D opp &&
>> +                !(kref_read(&opp->kref) - 1))
>> +                    opp_table->current_opp =3D NULL;
>
> Did you miss looking at:
>
> static void _opp_table_kref_release(struct kref *kref)
> {
>         ...
>
>       if (opp_table->current_opp)
>               dev_pm_opp_put(opp_table->current_opp);
>
>         ...
> }
>
> ?
>
> This is the place where the last reference to the current_opp is released=
 and so
> we shouldn't have any invalid access to it anywhere else.
>
> Or am I missing some context here ?
>

Actually, that one might be problematic: by the time the
_opp_table_kref_release is being reached, the opp pointed to
by current_opp may no longer be valid.
_opp_remove_all_static and/or dev_pm_opp_remove_all_dynamic
will release all the opps by going through opp_table->opp_list.
It will drop the reference for each opp on the list, until
the list gets empty(for given opp type), which means,
all the opps will actually get released
(only upon _opp_kref_release the opp will get removed
from the list).

so assuming simplified case where current_opp is the only
opp on the opp_list:

-> dev_pm_opp_add :  kref : 1
-> set current_opp : kref : 2
...
-> dev_pm_opp_remove_table:
  -> _opp_remove_all_static:
       /*
        * Here the dev_pm_opp_put will be called
        * as many times as the current object's kref
        * count (2)
        * as only then the object will be removed
        * from the list:
        */
       wile ((opp =3D _opp_get_next(opp_table, false)))
               dev_pm_opp_put(opp);
       ...
  -> dev_pm_opp_put_opp_table
    -> _opp_table_kref_release:
         /*
          * Here the opp_table->current_opp points to object
          * that has been released in _opp_remove_all_static
          * (or dev_pm_opp_remove_all_dynamic )
          * the opp_list might get emptied by that time
          */


Logging the ref counter for current_opp:

[  311.203910] core: _opp_remove_all_static: current opp  [2]
[  311.203943] core: _opp_remove_all_static: current opp  [1]
[  311.218904] core: _opp_table_kref_release: current opp: [0]


The other question is if that was the intention instead of
going through that list once, though
(so instead of list_for_each_entry using
list_for_each_entry_continue i.e.)


Hope I didn't miss anything on the way.

-----
BR
B.
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
