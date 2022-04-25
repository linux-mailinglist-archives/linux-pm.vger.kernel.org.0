Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD5D50E4B6
	for <lists+linux-pm@lfdr.de>; Mon, 25 Apr 2022 17:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237947AbiDYPux (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Apr 2022 11:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240505AbiDYPuw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Apr 2022 11:50:52 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CA011423E
        for <linux-pm@vger.kernel.org>; Mon, 25 Apr 2022 08:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1650901666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=aMthauIydQ5RtfzOudDwGMMBzXkPupOArJd8pCPkpMM=;
        b=MWZcahUZ0xOfPOP5ak62puu9QmVM9qrx4jG3nbf77w4fPQ6xPoCzqpNJMrbk6IyFH6G55h
        Ee2xT08heHql7fe00O2KGSWtlzPNtp+9PERmErpFiJV5UxtiXHeHFv5Pd4/UcAGkqM1dvl
        snMAZU4CrNuCn8f7hGkOVeA+yQmQbkI=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2051.outbound.protection.outlook.com [104.47.2.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-25-qMBLD5AFPoaX1ToRLSdSLQ-1; Mon, 25 Apr 2022 17:47:44 +0200
X-MC-Unique: qMBLD5AFPoaX1ToRLSdSLQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZtVsGzfamYIE+gMaTnKSOQMTsLu6kFGtLU96kDIRyZx7m47n5waygWXHfOoDD3VoW2kCiY2SmsNMGryBZalcPk62Lq2yt1ARNbRHNjw0HH6bFSM7IR3w1u8F+7nFoqL/OBsGbxSgvvYa2H/Tqwf2VzKVJbhPXybIcL9TUdDLWL0dAmeZkvTfMkEP6wsIVhuk448ljp0YU/jQhbtkhxWFJWAEKCVMCGztPAKnAlpw33zL7lnwuWPbAuoRu+t2m/jlTNw33VRi8x6CC4Fh8mq0b4ajCo0fA4HnLao7AhmtHdyAlBaqHfu5J5bF39Hq4PI6oIYySbhq2SpObYCloqxWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMthauIydQ5RtfzOudDwGMMBzXkPupOArJd8pCPkpMM=;
 b=eNgbfx/kj+Y0TJmoBAr3EUxqiQAOL+K6nQRzl2DAHfj7z2L0w8L4qT5PwAjwdEAyugCegcPoVGnqkmBvf2drZgDArUlvl4mOG+dSlU1rppW+MqADxXhSn0gzmZJQq1FSfGdRggMqwcZp+h5Fsu7wVY07v57IOYvr9/g9o+aPgSb5VquhUL6UATEWtMWCvnl1baMVtE0enLGbibQJR2YRVTYl1lPfKB8NMnacSs8Q0g3r94q9pBMkxvBlvZgHYvH2sZ9V4hMrWVjPreyBEAkO56AZh3sr797d8jN6vYiCnY3pBzDoZayqVjsT0MaXMFeWuimec97zObXMBVDZo2UPPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DU2PR04MB8616.eurprd04.prod.outlook.com (2603:10a6:10:2db::16)
 by AS8PR04MB7496.eurprd04.prod.outlook.com (2603:10a6:20b:29d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Mon, 25 Apr
 2022 15:47:44 +0000
Received: from DU2PR04MB8616.eurprd04.prod.outlook.com
 ([fe80::5cb0:5195:4203:7c2f]) by DU2PR04MB8616.eurprd04.prod.outlook.com
 ([fe80::5cb0:5195:4203:7c2f%9]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 15:47:43 +0000
Message-ID: <097a5547-2b0b-1b05-6b36-4e6a67e6f060@suse.com>
Date:   Mon, 25 Apr 2022 17:47:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
From:   Jan Beulich <jbeulich@suse.com>
Subject: your patch "intel_idle: add 'preferred_cstates' module argument"
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::6) To DU2PR04MB8616.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bacc368-d98f-4d1f-fc10-08da26d2eff9
X-MS-TrafficTypeDiagnostic: AS8PR04MB7496:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB749648CFB70FD558F9423B02B3F89@AS8PR04MB7496.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0rtdXrR4d/ZbsaVW7RkR1pHjYE0qtRKCA9BKRtqAJwIs/6pFtP7yEiATCuOvOhY5Sw8mfUP4O/CpFqOJgsShWSHDOCajO+3TznWzZ5FphU8FTUn7orYkKTV9xX0l9xTta4rqw1Pdt6JfDm9dBp8K4/BhWP9+yGDJkeoKxZqDWL5r9dKQM44QgQzypJRT9wjBxBXsMpLqwbOSw8euuVUTN1M7638QvVCFbcJtctUBjqkdLLbeACC+lnaXH3xfIlM35mGa0GiGa1FsQV1YCrU3AMtBfmPDTZ491u55j1SLDs4g6HDBcqCDe6R4IPLA8tvOqOBG1jgLdmqejGMRBi5XlKU3lw5mKCjldV6d/0qj4eIyXm/Kx4F3M5Qj0np6C7+osp1bGlUYf7BpV/BSO9cmwZZifdSj6HIFqxaf4ashxs1q9C4USjjOWYDrMRUB5Ef7OhVcJoU4aO/Z4v5JLtdgy4ujRi8VJxlF/RGdAltFOw8PRIw4g5I4SavA0HTMNU/AMn4GBzvbv4LxdHo3XGCObN2lGx94TEcRKkT2xH54kdXWBwcNG10VknL20ubtTWAkqppVEa/aQHiARCf4ndUfOWtVG/MS7Iig12PxbQWiNYOQU7vIH7w8vtl1h2bpQzd9ByTgVqLJ5EjORCLZnkvbAQK0CTSk12TzP+gfx4MamVlNGQAtIiMrYxXJ7SsLllmB/v57/WEP0MwlvLfM4p9Zd8XzeToz8D3SSCW6p3EunsDJ9katQY4O3FfgFKv4lThd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8616.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(86362001)(2906002)(316002)(38100700002)(31696002)(8936002)(4326008)(8676002)(66556008)(66946007)(66476007)(2616005)(6506007)(6512007)(26005)(186003)(6916009)(6486002)(508600001)(31686004)(558084003)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ym5mUzg2dGxabW9TeUkzV3AwVEhTOUJGakhCUWNYRTErTjI4a0ZrMlhtVkx5?=
 =?utf-8?B?OWZIeDQ3N09OLzFtZ0d3a0E2NGx0M05GNmM5ZENIV1ZBeDcvV2ZWcTRVZUo0?=
 =?utf-8?B?ejkwaks5a1lHUkpQRkN3TEt2b2hveFdxYzF0U29NTDl5c3VvcnNkTmowWTd0?=
 =?utf-8?B?VlVSZUh5SEZwZjFGL3FUZUk5NitiNGdHaWUyeDdxWDVqbWRXRDRkL1dEY2VO?=
 =?utf-8?B?cDM1VkRMUDFLRkR2NmlIUU1LbXRkWWw5NTZJNmw3WG1vQytYTTZWbFpXNmVC?=
 =?utf-8?B?NWFqbVdiaE4xUzVxRnBZc3pEZWpCY2xNcVJuNWl1RUhHb0EvOHFMSEZ3bkVU?=
 =?utf-8?B?ZHRMRjh5OWs5S1JWaUkvbWtKWlBPWW5JV1RpbkRQaW9JM1k2WGdaTit1dnJm?=
 =?utf-8?B?YnB4TEFycmQ0cVVvQVQvTXEzVlI1eXRLNkt2SzB2SUh1TDRHM2tvMEpEMkNS?=
 =?utf-8?B?VHZEaTFBUVZCMklVTEFPZnFoSE9uMXU0N1A0OTlSaTV4QWZyRW1yWlJlMjZa?=
 =?utf-8?B?YXJiUm1LNWJlbzQ2Z1Q5S2JBWG54eDU2aTdjN0ZEL2dFeElJMzJpOG9sdmVT?=
 =?utf-8?B?ZlUyMGk4cGF4OEpGSzhyQkx6bUNzc0wvMVBXYzNOaWVENExoSG54V24zcWRZ?=
 =?utf-8?B?TWMrU1hmdmh3cTUwamJRZURyL3Q1YWY2dEVYK0toZ2NJdHBsSzIwbDlqdm5q?=
 =?utf-8?B?cW10T2FHQzJJb21YNkpWS2M4d2g4U2NRdDR4SytObFRFMzhiZWsyT1ZqS3Vu?=
 =?utf-8?B?WDVpbmtQY0RpL1NFNXJqSzZpbUtFd05TcHVTL1hCc3BmTzhWeVFKSXBHOVIy?=
 =?utf-8?B?eXdxWlExMit0YnR5U3VxM1VUcmxEOFNRUWJ5c0hTUG5kMWlUampQWnBwdHVU?=
 =?utf-8?B?MDl4RUM2VFlRdHNJWVROR04ydHhJM0MvbnM1OHVSTm5PQkwrbFI5ZklEQkc3?=
 =?utf-8?B?ZjZpZGpRbEtjSGJYSldkbHBlVFE3QlErUEpEaFN6MFpJbDZDeTRnMDlxVk9Y?=
 =?utf-8?B?aGJCYmplbnI2SHo4c1VDSkNPclJ2UjNXSHVjRXpKWWM2ZHZNRCtTNktRalVT?=
 =?utf-8?B?NmxsRnllczlvSWFsZHVHN1VXOTI1MHoxeVBWMis4NVE5RXRYWTFtNXpZRmRR?=
 =?utf-8?B?OXRWNHh0ZlA4YXcwWGJVU3FJTmtnZFhVL25JQTI1WkhRN3lwR1JLWCt5RU1F?=
 =?utf-8?B?SHo5YWpaR21UK3M1WHpwRTlBUWRPVHdaSzJydUZDZlNlRFlsaGhXemhIbCt5?=
 =?utf-8?B?N1ZOVTREem5UampLTThNdTI4OGpCK3ZPOXlzYWx2T2pieGhwb0F1M3R3c2Jr?=
 =?utf-8?B?OFRLeFprbVd0MGNETWt1Mm5Ka25CU1ZEMGc0WXZISUdvTUxONWJkd2REV2VJ?=
 =?utf-8?B?VWhVOEdxSFg1SkRPd3JFMlA1QjJyUlRudGN2ZXloMlhwNktOTk5IV2xodzl1?=
 =?utf-8?B?Vnc4dm9sRDBESXpMMUJIMTNYY25kdUtLd0k4dlBOcUUvZnFCcXhsMFNWbjRW?=
 =?utf-8?B?VXVIRDFFZTFJeGtLN1VwNzBlaGJEMnpXU1l3aWQ0M1BrbHBaVzRGYlh6K0ZP?=
 =?utf-8?B?WTVVTE5kYW5CcmtocXQyYzhZa1RxK3lKUFk4emF3QW1UbWx0aDZ3WjBpT09k?=
 =?utf-8?B?dC9DSG5GVm5UbVB6K3orWHBpalNmN2hueTFzaUNSRWdtV1FnTElwRTdzNUpE?=
 =?utf-8?B?d3RoK2MyZFM1Ymg3V2ovcEVVV0dOU2c5ZTEvd3JsSklldytDSklCRnRaVU5U?=
 =?utf-8?B?RTRGb1FPZzFZbkUyQWpFY0NYMDN5UkpWV0lvNFR4dUtxOFV3MUJoUVA1S2ov?=
 =?utf-8?B?ZFd6ekdkbGtmWGJsbWN3MTZkdHRNVGdJYndsZTZFZnlZelJuRDNwYzdsZkVi?=
 =?utf-8?B?RzVOeU43R0x5UEhIbnlMVU1GTHhxbUk5RGF5SUoyS3ZKNUxkZ2s0YkNKdWZv?=
 =?utf-8?B?NU9GU3ljNDJtNzBLMmVjTzR5a2VEQ3d5b29jNlZ5N2N6QjNSL3VyY3luR2tD?=
 =?utf-8?B?cC9WemI0c1FjaGV0Z3JvWHdaUXBBUStnNWZkVVIvOTRlcW81YUNpV1dJaDVP?=
 =?utf-8?B?QTVrSTFNMVptVFl3aU9pRVFDQ3RXalBId1pBeWxxS0F5b0NRWEZ6RFNobmRO?=
 =?utf-8?B?RERpQzExakFVcDI3Z1k5MmRqZUx2Tzl2UW9ab2pDdlZTRndUUTVITzBTZ080?=
 =?utf-8?B?eDFMZ3Vza085Z2JvTlZLV29sTDVqc1k0Q0plVVFCMWlmU1IxeklEVlFlcWgr?=
 =?utf-8?B?Uk83WXU2d3hhWFltUU5kWkxKeUdTSU9SbFY2d285RFFiZnB2UE9ad09qUzdE?=
 =?utf-8?B?SllmV1R0MzJzVmxTV3A2dmZOZzBUdTVIckRBSlpyYlJTbTBqTkJFZz09?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bacc368-d98f-4d1f-fc10-08da26d2eff9
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8616.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 15:47:43.9190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 21xGmafM7loT7NeyU6c6M2S4Zs1xZBT40rph4eKgYt61nbM0r/qZKImQLFfD5QSGhZ7uCwaYSfLjD32nIMIqBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7496
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Artem,

while porting this change of yours to our clone of the driver in
Xen, I've gained the impression that the respective MSR write
wouldn't happen on all CPUs / cores. Was that an oversight, or am
I overlooking something?

Jan

