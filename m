Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3626A54D414
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jun 2022 23:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350181AbiFOV7z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jun 2022 17:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349889AbiFOV7n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2022 17:59:43 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02hn2201.outbound.protection.outlook.com [52.100.10.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3725F54BFA
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2022 14:59:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MH8nkg/IUodr0iRTFBUn6wmoSFnRj4z1JPAWds+7l6J7uO763FrOL/0I0oZA/TAvOrs4RXviLwq99qxvRYP80ofaHbP2H0pRxP+X+tiBxEjuCnLNVQQ8svrgc1BgYTd42fy9M+UW0L/KfpJtiRCV7AGo8M22Zc18hxAgKnVS6uW5owuCSkGYD1608Oip+11ZgmYoWcMv8eeN4pOALuT/5wGxZ1fqRux3pSbhr6pgdLsN6IMG+f5nBWD1mNdS9q51GbeNKVBzAzQzy7DneZX/GHWpw5GCCSw2MR8bjPPAZ/APOrgDfWettzrJ3BRRrEmSFp+xm0hyigXWQ1Nb1vCg1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQsm62DnO3DRMaTO7/AWxijWtNxIrL/VW/Qe6xhipJU=;
 b=XGgypmEHy4uWDDIY4TCejAXQLvmzIl3vCgXFtFE8nbzPLQ4nPdssDIm2IgstPENYQHtcMyDDcOK0OEkYI6SVYq+bsoL7Y2fAeOC/UTncfCw2rccFUfDb6gwOMMjxP20+rKRqo6kfpK+80TrbhQbo6OHaRXZhwEtvukPZ61meXSwfCcwNexHBCEDjYERadUAyBldzJ6Sj/wYjK1nNw7afc67mkW9w4O7pt/DuMCr2oo96vOgrh3PiFWfHIgWQzu9t8IW4kKMUBBNV4+4tiBPBLT17POGfrzdNLhCP9IE8f0dFb9HqkrbWSygwjZoSYVsRc83BgDDuHJZ07JIbGU9e3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=permerror (sender ip
 is 91.151.71.70) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=solairedirect.co.za; dmarc=none action=none
 header.from=solairedirect.co.za; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solairdirect.onmicrosoft.com; s=selector1-solairdirect-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQsm62DnO3DRMaTO7/AWxijWtNxIrL/VW/Qe6xhipJU=;
 b=QIDFLLW96SG6XTwJpZJF5P+FAwhJ8oMYrxoiUoBjnBaoE94YfhHZbhK4CgWnNx5URv1giukIE63oot9SLktHeCq2NymIZdoqJrv9vqzCgkTqkcx8ySfuf96Blj0JyDOFFwVPrBUaM9s/pb3h5v8ernOUmw1PEvjZKuqwwih1D48=
Received: from DB6PR0601CA0013.eurprd06.prod.outlook.com (2603:10a6:4:7b::23)
 by AM6PR06MB5015.eurprd06.prod.outlook.com (2603:10a6:20b:6b::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Wed, 15 Jun
 2022 21:59:40 +0000
Received: from DB5EUR01FT086.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:7b:cafe::56) by DB6PR0601CA0013.outlook.office365.com
 (2603:10a6:4:7b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Wed, 15 Jun 2022 21:59:40 +0000
X-MS-Exchange-Authentication-Results: spf=permerror (sender IP is
 91.151.71.70) smtp.mailfrom=solairedirect.co.za; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=solairedirect.co.za;
Received-SPF: PermError (protection.outlook.com: domain of solairedirect.co.za
 used an invalid SPF mechanism)
Received: from SDSV152-VM.solairedirect.lan (91.151.71.70) by
 DB5EUR01FT086.mail.protection.outlook.com (10.152.5.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5353.14 via Frontend Transport; Wed, 15 Jun 2022 21:59:39 +0000
Received: from [206.72.197.122] ([206.72.197.122] unverified) by SDSV152-VM.solairedirect.lan with Microsoft SMTPSVC(8.5.9600.16384);
         Thu, 16 Jun 2022 00:00:12 +0200
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Hi
To:     linux-pm@vger.kernel.org
From:   "Emerald Johansson" <marketing@solairedirect.co.za>
Date:   Wed, 15 Jun 2022 17:59:34 -0400
Reply-To: emjo680@gmail.com
Message-ID: <SDSV152-VM3uPpSixFo0004701b@SDSV152-VM.solairedirect.lan>
X-OriginalArrivalTime: 15 Jun 2022 22:00:12.0526 (UTC) FILETIME=[497D40E0:01D88103]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7faf092b-5d5c-4ad4-409e-08da4f1a586a
X-MS-TrafficTypeDiagnostic: AM6PR06MB5015:EE_
X-Microsoft-Antispam-PRVS: <AM6PR06MB5015578A3B1ABA9D1EE77405EBAD9@AM6PR06MB5015.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?N+vJtQRUiPuwh1bI50NgRJk+61+ZJ35u9UJnadKJ7+nZ01hG2jAL5GMDql?=
 =?iso-8859-1?Q?+xe3+JYoQAA1R5fkSXBEdYv3BnHOv3hV/+2k163KtCr2v/LMYFCaw5pORl?=
 =?iso-8859-1?Q?ArbVZTyvyhhfIVh5kBLhhuloOyoj7LSTwW0td3h3FVuTVVsuxXiATm6478?=
 =?iso-8859-1?Q?q/CiK/ywMBkQ2iuGvzjV472IdCovZULqtW3+p9S+bOxisw4db8lfLtik22?=
 =?iso-8859-1?Q?LM8gMBSR9Dd1ZL35XjXpouhnAQqeGOwOA49wggxctTcU81Q08f0gClaFAp?=
 =?iso-8859-1?Q?dmt7X2mvz1YKmeEv+0QcnwSSwExz5xKr9iJVhqY2Z5H4W0qQMt6X2aHdcf?=
 =?iso-8859-1?Q?CKqWZDbWAqyJ1YTm984+LoKoY3QVGYqQGsU+Zez+2LtO+oUcMmgkDyBHl3?=
 =?iso-8859-1?Q?xIm8rp8+p332DYeQzXmLqCpVJJZjXU2THqIY1SnbmCe7GKsNzMBdVH0xyQ?=
 =?iso-8859-1?Q?Mh6461HAd1i09FZm2tGYMUxn4VICqRw+qoah2E5yFX+lgdTYeUfnXkvGv2?=
 =?iso-8859-1?Q?h0GDdRNkFlbxXfpc4anPNcaZjb0iLsmOfcLVwvYlDIXQVe5UdRLaAyL4xN?=
 =?iso-8859-1?Q?y7VugH4oEcGSj6Y4cZ98YckFh8NwTHs0fU6U1ePDKaPyC7DNkDHQv6nEi8?=
 =?iso-8859-1?Q?sGZgimwSOLYpsgQ5hMxIG2AzVMc2WrsCD8thd72IszGOMSvMbBBFd0XCiS?=
 =?iso-8859-1?Q?MfpZ2gTeE3uNtYnBQ8RGO187LXkbAh6BpL+hYdXgri6VXrungxQwi0Q4L2?=
 =?iso-8859-1?Q?+1aIe2XvpBylZnDAiGAVSfLgj7ja+XQ/puYJX9JiC5lhMrfrynNqcaqlqS?=
 =?iso-8859-1?Q?5En6J7x3lztHq+w5GhKzvJ2wEf3q0cGn4tWglRm11VCo4qhTGfJvoj7OLS?=
 =?iso-8859-1?Q?FL+4g95RFNxPBnBgOV/LYgMRt5O7s/qJsQH5YiYc0MGH6EWoZY2R5icVrl?=
 =?iso-8859-1?Q?FXGBwPFsrrEbRHIrinfOw4ZOI5Pq+Aa3tfUpLW3blPqLM8K5ai/73wHH56?=
 =?iso-8859-1?Q?lod2HfXXgQuCBTMIrtluZOkKI0aFwFBcKfzx8d5R9/OIDIw8Eat87nSFWg?=
 =?iso-8859-1?Q?KyYVjwMe4mz6FaEqHmF5Y4Y=3D?=
X-Forefront-Antispam-Report: CIP:91.151.71.70;CTRY:FR;LANG:en;SCL:5;SRV:;IPV:CAL;SFV:SPM;H:SDSV152-VM.solairedirect.lan;PTR:undef-71-70.c-si.fr;CAT:OSPM;SFS:(13230016)(346002)(396003)(39860400002)(136003)(46966006)(40470700004)(36840700001)(6666004)(26005)(36860700001)(6916009)(508600001)(186003)(70586007)(336012)(3480700007)(956004)(41300700001)(47076005)(9686003)(5660300002)(356005)(7116003)(40460700003)(4744005)(82310400005)(86362001)(40480700001)(2906002)(8676002)(8936002)(316002)(70206006)(81166007)(2860700004)(16900700008);DIR:OUT;SFP:1501;
X-OriginatorOrg: solairedirect.co.za
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 21:59:39.6355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7faf092b-5d5c-4ad4-409e-08da4f1a586a
X-MS-Exchange-CrossTenant-Id: 1c138fa9-0b91-4473-baea-5be5feac0f7e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1c138fa9-0b91-4473-baea-5be5feac0f7e;Ip=[91.151.71.70];Helo=[SDSV152-VM.solairedirect.lan]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT086.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB5015
X-Spam-Status: No, score=4.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I hope that you are at your best and doing well. The purpose of this letter=
 is seeking for a pen pal like friendship and I'd love to and be honored to=
 be friends with you if you do not mind.. If the Idea sounds OK with you, j=
ust say yes and we can take it on from there. I look forward to hear hearin=
g from you.. My name is Emerald From Sweden 36 years , this will mean a lot=
 to me to hear back from you.

Warm Regards.

Emerald
