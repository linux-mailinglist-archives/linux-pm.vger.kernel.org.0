Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3FA7C829E
	for <lists+linux-pm@lfdr.de>; Fri, 13 Oct 2023 11:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjJMJ51 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Oct 2023 05:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjJMJ50 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Oct 2023 05:57:26 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2130.outbound.protection.outlook.com [40.107.104.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09E3CA
        for <linux-pm@vger.kernel.org>; Fri, 13 Oct 2023 02:57:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arCh1GjDQT0mjrIhJ/7OtJeGtr8cjxAUySN2hhYfcLhkoHS/UJwp5v7VsMO7HX4cFTMdKC21eaj9Agy2RQRdCoBgpjzbFztKomKriXENc688fu/GaBOkzA7KPsM9pRwpd9yGp02aY/+V9XyFlyjf4RZrDK4b0yz5cjAyc0DeeYVUf0y5Tpls9cBYyK2/VGOle+Hx0ZdQAWF1ddJLv5KhTwQZcKsHa0AE64sCxf+86kR0ww0KdNJ9R5blINtlqMk1p00Vn2KDGzVZAUNUwOvuXXqXK6mUTL33Hv0ew3io+WrYoYB/IDK0SQTZYFRNpFus9i5JOTcBukLO4t+BVQGJDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JoeO0eJTCT2Bsvmv+EHhGOvNlmy+bRSWVLloOhLP0FM=;
 b=ho1JOweBNho90HXl5hvh6HI95f4KvXcPqZ8iT6BH6S/TISP/r0L+HU1WEa7SdtyS1vvg9hAUxFTSxELYxH0B+ZcXeE618nqW0DPym7dPmSxjJVOBdFVkZPiY6hNfy7wJ6afF866kf8Hv2gw3NX+OQz0xfzI9hw3+uuv1XEEknuAEFFPjtn4LVU/Hb4EC4n0o06YCZLHGux8bnX0JNqS/GFnHMFdsIGELs6S9c47ppukbbQ5OeHxcYRa7hwqALvr2zCn/a7pJpJ9SeMDts9lFEOAoBCs7IwtLPuWUEMeDxeOV2p1SbNS3qG3Ti/34QCts3gt3mwaOtRKNbQdBC1yVFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoeO0eJTCT2Bsvmv+EHhGOvNlmy+bRSWVLloOhLP0FM=;
 b=a4UY2b87ustrO1R5nIWAGSRQy9HfAeA13XvTz/CryFc7N8kfiboR8Ack+fSLvyd5HGUzJNsq/uMyfoRw6YY+zA3YBSXRSqfW/uxGqUPAss22VKrb6B6yPD2KnhhIVBbmNUxBrPSymKOdZocO9yjfwbw1tSHXIS9tfeTMBWvtfrg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:10a::24)
 by PR3PR10MB3819.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 09:57:18 +0000
Received: from PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1315:9ecc:6928:f486]) by PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1315:9ecc:6928:f486%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 09:57:18 +0000
Message-ID: <78a905b6-020b-4d99-94d7-f09ffe4e156f@prevas.dk>
Date:   Fri, 13 Oct 2023 11:57:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: imx: gpc: set fwnode from parent device
Content-Language: en-US
To:     Emil Kronborg Andersen <emkan@prevas.dk>, ulf.hansson@linaro.org
Cc:     saravanak@google.com, linux-pm@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org
References: <20231012132214.257207-1-emkan@prevas.dk>
From:   Emil Kronborg Andersen <emil.andersen@prevas.dk>
In-Reply-To: <20231012132214.257207-1-emkan@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0096.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::31) To PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:10a::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB4576:EE_|PR3PR10MB3819:EE_
X-MS-Office365-Filtering-Correlation-Id: bd8d3089-afd3-463c-25d4-08dbcbd2c909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K5rkIpRwCmQj3jdC3yTw/Ap/QUc5rsFAQ9ODzxCfafzf1P5YFsi5VIUktPjFw/gWRcKMdmZB6JYUko+vDR69TSquh082Agou9gnklpnSLxQmNKvmfZXf544fVVHvDYnDkcNQyGd6zPdXbFC5BkSi9B6HYUAHSGylandm3wv3xTbYNRi4/TFXvc9SCF/T7HqtH8c47MbhQxMvRx/wIJwuUv9zMmM+SF9peK34PUCU/WQsZFqarTYDp8hio9pzRoxXdyiNE6/yZC4NPL0nYsOyK8emyiatFz4qCAfD6KHfAebfGnDcPZqW2/ycwGQt8L3SyQNs/TbA44yAe3n59l9avzmux5WK4xXhE3BdiQwmVaxLGQO7vWNUI4SRO4p0krEKfcYHpz5e+39wdRaDlLyGJjkMS3+DH4X0qvcXVAN5m3f9VBjaWoHTfWlr0+VhG1NvkPIGZ4nHoJk9pXM9eGhQ0NT3W/CHwOBi6uI0EZFgQuj7EhSzPR6tvP3U1PKY1bEizH9Ux8YnysNxYZV3Dh4A/fK+OOOKJzdIoEBxRm7M4q4yPENHzYzoQkcyz/R6Bhz1UyeoDKDdZniKENShpTb+O6UPBDBY8RRlYt6ZoGITbDGKpmipdenFhaRHxC1OeBRr+t54mYItS/dRQdC17eRRcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(39850400004)(366004)(376002)(396003)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(4326008)(8976002)(8676002)(53546011)(66946007)(6512007)(66556008)(6666004)(66476007)(6506007)(316002)(38100700002)(5660300002)(478600001)(2616005)(26005)(41300700001)(8936002)(31686004)(6486002)(83380400001)(2906002)(4744005)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUZSSkZENkhqaUI5WnhKZVgzR1BxZC9uYzF0c3lWeEF5WG1TZUw3anFYM3g3?=
 =?utf-8?B?Nk8yQ3Q1Vmw1TWt4UysrdUZTbjlVeUF2dGMzN3ozVFhwSWp0dWM0a1pCaGlS?=
 =?utf-8?B?N0xBMlFJOVJSTmJuMWdEZCtHdWRxaTB2MHRvaHBhcHlpQjAyTTJzakRwZmxZ?=
 =?utf-8?B?ZEtpWG15U3pVck0zelo4T2pyZDEvYmRnTXhVd2Y3MUtJS0lqd0p5OGFnTkVM?=
 =?utf-8?B?cUVHRnNCK3Z2YlZwNFA4SWZlVkRsZWJrdmZ1RWU0d2gyOVk3T1hJajV6eHcv?=
 =?utf-8?B?akFUZEF1UE1EcldaYTVGTzFIcE1tRVlYTkNMV0FHaEd3K0taMTlON1NEN1Uv?=
 =?utf-8?B?WnF5aGxhQjg1ckJONE82Um9lUE0xaFNucHhYVFlENnlSMGhUUkZGVEM0bExy?=
 =?utf-8?B?MGJWa0VndnJpVjcrMFZ4R2JpOVJvMFJQUUZyckViUk1odmtKTnZyR3F4ZkFZ?=
 =?utf-8?B?eGNlUzVQL0phYzlSQWpNWUhvaWZVUUUvRC8vL3VzdHV1RDdwVkxaQW92bXF1?=
 =?utf-8?B?dUgwZ1ZveGx2Q0R5dVljODRrVnk4dEtNNG0vUk1RUVA0SWZXTFZibUYwNzJi?=
 =?utf-8?B?ZG5MZUVVdHVmdHFyMDV1dXFWZnBuc0hXL0RUK0xRL2V6UXI1QTlyUXVMamtR?=
 =?utf-8?B?VVNBODZoUUhFVWdVb3BBcWdsemhvcytqMWxOQ0JRTjdsS2xETjlOa3l4Z01n?=
 =?utf-8?B?NDB6dVg0UHhGSEF3TGhOOVBXZzFwRWpidVFBdTc4dkdjcWJFMjlqeU4vZHhh?=
 =?utf-8?B?VGYwMkEvTnA1TWFmRXUrSlprcGpRUWNDNXVYQzE3aHJwN214aCt1YXlDZStU?=
 =?utf-8?B?eERuWmw5SWtkSkdtd1FjUVVqczdZdkswSVoyOStKWEVwVDdjeVJzR3VtZDNW?=
 =?utf-8?B?dFVLYlBHeTM2cGR4L0dlRURSd2hFKy93S0RJMnZ4K3hTaVlrQnp3NC9QSnBu?=
 =?utf-8?B?OHUzOURRZ293VWVvaHc4VmRpRGViRGhYRnRyVGw2aFdGdmZiTkF3R1BnS0pR?=
 =?utf-8?B?L0FBdWRKeE9KRnN3THJORjJXN3dXZlRHc2plSUZTN09IUE9tbUZaeDlnRGkr?=
 =?utf-8?B?eTJvK01xbVdSaVMyTTJMLzd0Njd4aWVhSVRZOWZ5bEhNOGFYVVFEdTBJMmZt?=
 =?utf-8?B?eEhsM3QzbmgxK0hBMCt4VzU4c3Bvajd3RDdRYm1pMVFsK1l5ZGZsWmx2MjBz?=
 =?utf-8?B?eitubXZVQjNGekdZZm41MGVIVEdjQnQyMXIySEJXLzVJRUNsZkNxUGE4Z1Aw?=
 =?utf-8?B?ZFB4T1VwSDcyL2xaWGNBR3pNWldpRlJ6RGxycWd2OEhJUlMvSTZWMXprMzdQ?=
 =?utf-8?B?aUNrMVVrWk9lMHhQdStVWGRzUXNWMzNiWWJqZDNqaGVDKzF6eGlsNjlxOTI0?=
 =?utf-8?B?ZzlFNmgrQ2tZOFU2MGtyUURhUkJOSUt2Y2R0ZUtoejV2MXpoNGU0SGlwU0hx?=
 =?utf-8?B?dktncEJnd3Eyc0wvTmwrY2taUk1FaWRlemFyRnRFcVpiRHQ4TGE1RXpoNEZS?=
 =?utf-8?B?aTRpdmZGTThPK1k2bUFGSXBoL3lnZVdGUUNha1F2NlN5NmZ3cEFqdFBYMHlV?=
 =?utf-8?B?cTRhYzZKMVhFY2RKK1pmd3FkUWZ1V0lHQTBJT0RDUXN0K0tDRUFITVhkcE5O?=
 =?utf-8?B?Z0ROMHRSZjNJQmJScHRlb2tnMXNvS3JUQ1JPVlk5NG9ZNlVnMldwMG55YWhJ?=
 =?utf-8?B?cHFTN3BoTXc4K2VVVVlISFBKU2xNMTBpOXpLUUdUTWdUb1lNcWljN3F1blNt?=
 =?utf-8?B?S3BaNGZuekpkRGdSTUFtdUQ3VlNuaDlIckloY2MxdFpZM1FCcFc2ZmRzeU4x?=
 =?utf-8?B?VE1FSmh0ZjBQaDVaYjlreWwvUkJtRGxQRG9VanE4ZmQ5M3RZL2JkSW9pR3pI?=
 =?utf-8?B?NHJtRXA5S29mRVYzOXBZMi9nVFBEK3NpdHhWN3VtWTNBLzFQSVJQUG5oTit1?=
 =?utf-8?B?L1BXcG1sczNFWGpOZFR2MndPMXI3UTZlWmg5M2J2TVA4YzdESldEaVFqSU44?=
 =?utf-8?B?UDMwT3gwVzV0Lyt6bkYvbjllNDlucDV3YXprUDRhWGRyZ2sxczlhSTFwTlZR?=
 =?utf-8?B?T2NCUFAyajFQalJCbnk4MEV4QTNlUnk0WTYyT2Z4aW1SSm9MZytkcTlNdWNY?=
 =?utf-8?B?Snl6d1U0c3hHdDJsOCtWcGpWa2ZtcXlBRlZ1eXYvZHJ1ei9yYVo0N3ZrSkJ3?=
 =?utf-8?B?Qnc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8d3089-afd3-463c-25d4-08dbcbd2c909
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 09:57:18.0850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BIOu3sKc0IK5JqR5hsqsfIq0iDx+Z6DRInouW9tzfZ+UBqghnBoHV/ydvm6RyIjXfBptdcsO+cVK5UCD9NrRjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3819
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/12/23 15:22, Emil Kronborg Andersen wrote:
> Before commit 3fb16866b51d ("driver core: fw_devlink: Make cycle
> detection more robust"), consumer devices without their fwnode set
> printed errors like the one below:

The commit message is wrong. Instead of "Before commit...", it should 
read "After commit...". Do you want me to send a new patch or can you 
fix it?

Best regards,
Emil

