Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD28B50E525
	for <lists+linux-pm@lfdr.de>; Mon, 25 Apr 2022 18:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243095AbiDYQJO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Apr 2022 12:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242595AbiDYQJN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Apr 2022 12:09:13 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD52B3DA41
        for <linux-pm@vger.kernel.org>; Mon, 25 Apr 2022 09:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1650902765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=boHxbdb8NBLWXnab3oA+iAPsDyacQrjj4MmrrkUtw2A=;
        b=VEBKRb+1Z+Tr94OmOzU6LKHE4GAG7Mg3/Be/vqH7UaUbdqHG03xznduRVRHU+7sXMpHo4Q
        8YWFKjhLZyXRyi4kqM08DbCvpWRSHXkjMqyPWM94MPmtP8rXEEaRyXC4kKTG+X2kyISODs
        feBOOz/Ooxw6ydi8O4C8MMCH3S3eOnQ=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2059.outbound.protection.outlook.com [104.47.14.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-5-8Hv8VcqHOTGAt3dk5meEzg-1; Mon, 25 Apr 2022 18:05:56 +0200
X-MC-Unique: 8Hv8VcqHOTGAt3dk5meEzg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDICH6XlYQodU7BbGDskxS56FRAFCzfT16mprb1FVKFlgagcsKIoxbtBjuzCpzE6q7U8qZ0TmAh/8vv9AgQsqkDjHy5zYxCSUYCrkq+s7A8CEPQrpjtl5ZGr0yaK1e6a4QxrH9TenjORfyyi423I+OgdyZKRSCvfoFRFZXGKQb9/ySbF4NPetVESunUOQwO5by/hwWiSXFV0Z8/VOr8Zp/b7MtRL2jm0uAUJZ5TfcWPy/wojLUxQF4lBaKkODQpfeC9X/Nr03FS5g3YhEMNtrAsfhIDARlTtQwzc+eH9XSC0gQHTKbjUlL/N0lIXcAOigtwE9Pu676hM000S/amo9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boHxbdb8NBLWXnab3oA+iAPsDyacQrjj4MmrrkUtw2A=;
 b=FhR3xtmPsqXJbrpDiHHlIEVd2BvrOaDsZnGOwxP3KuXBBuyqN0dlKEO2tB3fJOLK8KAxEe6G7iG1WHo5gOYhGt6ag7H6vjgnbsb6Qu2dZNcqyneYRQYZPMwFIz1tt5Dj7/cO9ywdo47oyrLTaqCbKNhVLNVfTzTChv1R32yHQKWNpwll6AE2dep3qMHQM8Cl9Psrd7BXNBKskV48iOVwc9k/rpfQubiIiTBxJ98QDjijKDjeKoeVJVI2fy4+oEGf8gmj1VIJF8BYNEyGPQ4sURt4FzBF8/4RXbzAdMxrFNZorkcmePtsgbE0cLVryl89AYQglf7FSe1QpLgiWsvylA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DU2PR04MB8616.eurprd04.prod.outlook.com (2603:10a6:10:2db::16)
 by AS8PR04MB9009.eurprd04.prod.outlook.com (2603:10a6:20b:42d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Mon, 25 Apr
 2022 16:05:56 +0000
Received: from DU2PR04MB8616.eurprd04.prod.outlook.com
 ([fe80::5cb0:5195:4203:7c2f]) by DU2PR04MB8616.eurprd04.prod.outlook.com
 ([fe80::5cb0:5195:4203:7c2f%9]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 16:05:56 +0000
Message-ID: <9229419f-bfea-ee25-6176-7c529334eb90@suse.com>
Date:   Mon, 25 Apr 2022 18:05:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: your patch "intel_idle: add 'preferred_cstates' module argument"
Content-Language: en-US
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <097a5547-2b0b-1b05-6b36-4e6a67e6f060@suse.com>
 <70621d99576bca327283d3dccf39379405177bc5.camel@gmail.com>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <70621d99576bca327283d3dccf39379405177bc5.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR0202CA0062.eurprd02.prod.outlook.com
 (2603:10a6:20b:3a::39) To DU2PR04MB8616.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 800784d3-fa75-40d5-2aaf-08da26d57ad4
X-MS-TrafficTypeDiagnostic: AS8PR04MB9009:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB9009863E77ED31ECEB03CC47B3F89@AS8PR04MB9009.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +jtTQk9lhNzHdtqBsxBDWsnn1LInZGriN0X0Fgrc0i/oNtDBzSnyHkVx6/h8BOshbrSD5wkekC6kzHUa1Cod6stBejh1PYIL4XFM1lCF+rYF89OAuJu+1bsu9rL+KGtMlcE9XZjofOgyJAJyMs0yyzk+bF9eFGCR7GsqFhMYAc4M1dpnN463d5ZPdHeyUqNf4ixxY3yZH+CYF0onIr4hfqlwMgLqqolx93yBo5joSG9TP9Jaa3YlP4sYIHMmPqWinxErBjiLiuuvYtQYpw+YBotrmoiGBWRD2AIkPI21SYv1/L/oBplbIlBxFvW2dvTdh50zpStxJgehP3UOXpnAdev5PpoygxBpb9XutnY5zi6lAsQz7wSwY9AN6ERFl4m+kR6CGzOGhzuVsTjaJxAjRdEQi046C1M6sOmeWF4toc9IaHQbJTUSK6PCHF28k4PSxrpXhteRJA1Dfmn+PHPyYWDmfhx/SIXBKaBbwIz/vfO0rEYEtM6U9kdXL0lvzj0++vkHL6O+c/EizJKcuQMBgo8Bs7/7gvYYe6JPj3yZPo4vNvDtC+k7+g60di/oyIEiqr+1my8qh0XR8gYjMYNhw/n4fUlHg8rQ/r8//THxPJ8eJDX72XVFrsX3Trw3cRVS70ZmVrJLZJfs2M75MkYFJRR7dhyKf6nOzPjdkzsy3GiAQL81IE8Tj0ddl7DCb6MnouQkhKL0RpQeqXgDqrZnmMTpZ3kxcVAPkYTvcpwWc+odwkx64KBIYT25/gWwcG8K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8616.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(66946007)(26005)(316002)(38100700002)(66476007)(6486002)(53546011)(86362001)(6916009)(508600001)(6506007)(6512007)(31696002)(186003)(2616005)(5660300002)(2906002)(8936002)(4744005)(31686004)(36756003)(4326008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVQ5YWVRMnpkKzZ4STI5cFBlY2RxdHVaYmRpenQ0WklSVnBSazJsM3Q1eFlx?=
 =?utf-8?B?TklxTVNuYXYvN2FUM3NOUEExTy9OSEdZQ3M5b3I4UlVtTFA3TG5DTEFWSmZG?=
 =?utf-8?B?azVkeGhnTklTSXFCVnNxbEkyd0I5M0JjTEd6c1ZRY2Z5TmhYa3kyeFhZdkdT?=
 =?utf-8?B?M3lJU1l2bngwTEEzVkloQjd6Szd5MUxxQVdheGFjNDk0T1ZCYlEvMkFveFBL?=
 =?utf-8?B?VUltOEo3cld0UkFyUzBkU0hYMjlSTFA0VnJOYlhRdUhmU24vU3N1eGxJUXRI?=
 =?utf-8?B?TmZyTlpBVSt2bitna1Q5V0lJY3J3VDlyN0pXQ1VHQy8xaVorWlJJRnN6Qit2?=
 =?utf-8?B?V2d1MDJrRUd5UFc2WWZ2eDdKeVM2WFpLMUhscW5FVHFFdWN2VVhBK1BHcjZm?=
 =?utf-8?B?MGY4Y2oxS2UrQkxiZCtscDlBY1Y2ZktWeDZUdmdEY2hTZEJBWU1PMGd3Yk9W?=
 =?utf-8?B?NExnTkIvNytJUU5GYzZxVHhXVlo3ZVZxWFZJM09RU2xpbzJvZEtVTnRNVWlu?=
 =?utf-8?B?NVNteXlaRUl1ZnoxY2NsRUZnZE9nR2JJc2V4TmRiYUp2TXVjNW5GMHpqUEd6?=
 =?utf-8?B?NnhaWUdiajhTVldDRDV4M3BpMGhlcFlQVk1YeHpuY0cvRHdXaWZUTGVQMzRF?=
 =?utf-8?B?SnltMDhabXNxeWxWYzRLOHJzbU5ZZlk0QVlGYitoNGg1bHpOWGNwTHNSTHQ0?=
 =?utf-8?B?T01oZ25oUXFPS044d3dDTkhkZ2FnRHAva0xrSDRiYWZJKzVGekVjcExTdXNY?=
 =?utf-8?B?NmdOaGJtUlFHUHlGaGxENUFpNGx6d1RrbEFBQU5OQmZ0ZHBjaG9jTXRRYXoz?=
 =?utf-8?B?T2NGUUM2cmwxa2VSbVJPaDVvWE1yYzdCQVJxQzRYRlo2VDZscktScUlHYWdu?=
 =?utf-8?B?dGc0TkNYemR6a2hUaVZvSnE0c2NBdEw0WkJxMWJUa1RtNEMwbzBvZlI5ZXU1?=
 =?utf-8?B?VWtydXVUNFo5aU1teFBEZXpuWlVlZnNyNUMxMGVFeThGM0NHN0VwMjdWWjlW?=
 =?utf-8?B?V29uM2VTenJCUjIrbDRscktNd092aWhqTE92QmpOV3FmSWlmM0NicTNLSUh6?=
 =?utf-8?B?ODhSQnVEVmJKME94cDBjdEZzNTN1TEtXT3ZFY1V4aTVPd01uTW9pNmpyT3Az?=
 =?utf-8?B?SjdOMThWZ3dDNXVWOWlpM2ZYRENWWldpcGQ5Z201b3Z0bGF4L21VQlRqbUl3?=
 =?utf-8?B?UU5MSkZhNGJZTm5JaS9VeThFMDdMeENrWFdvTjh3Mk1OSUZVc2FCM2dyMStZ?=
 =?utf-8?B?eU5qeW1HVGcza2F6eVBhd0lkWEtSUDNLSHlMb1NjbTEvS1RiQzkzR2Q1ZFNS?=
 =?utf-8?B?bmU3N3lmWmpSQzl0cWIwMlEwOUx6ZzMwckM3TjBpWm9FRk84NDhHYWd1QkY1?=
 =?utf-8?B?OTBqQ2FMOWNPT2VSRUJiaXYvRDhYZVFFMHJveldSbUtCSW5WUVRkeUxpQTB4?=
 =?utf-8?B?QkhIbURMaHQyZ1h2Y0V5dmRPaU1pRnBEVmdFeG5XT2F2ODM2TU01R1l0QVlu?=
 =?utf-8?B?MlZ3V0h5U0FvLzJSTXEwaWJFQ3BlenpldTk3WU9qd0JWSWJXcDJlMjdYdlNV?=
 =?utf-8?B?enJpOS9qVk4yaGpkcWgrK3ZRSEZLZ3VkRmZLQkNnUWpQdCsvaFZJZTU0ai9M?=
 =?utf-8?B?disrMHdlUm50T3E0OUl1SXU1VEVJU1FnSE9zbnpXcElleTkyVmJMMmpiaTUv?=
 =?utf-8?B?eGdWN0NsVnZqY0hLMmY1YnErRHVWOTFRTGZnMXp0UC9hclpWSkEzQXlCbjBG?=
 =?utf-8?B?TlZaRlFLNU83bGNXM1pxWlF3VHZSelMxNGlVUUhTcWNhMmt3NkpudTVqd21B?=
 =?utf-8?B?QWVXeGdkanJEK2I0eWVHRnpVR2kxbWpWUnRHRmFlMExQRkZMWC91bHU1NlFL?=
 =?utf-8?B?OU50bXI1VFluQUlSMHY2d3JmbGp1K2JHNW0xTmZVSlFBM2Vjc3hxTURMTWZT?=
 =?utf-8?B?MUtzcHpDMFVOUDQ1RWoyNmZIRDhRRHNQakpDdUhIOG9mZ3p5Q0FiYnhhYVho?=
 =?utf-8?B?SmhoRktINjFuY1lkYmxhY0piY2wxWlg5Qno3NytySitkaVY5cEZteTl5YTlm?=
 =?utf-8?B?K3lrclMvbWFvdzNBcDRhamlwa29pc1QvOFZZRUFSdjFwMDFEaWF5YWdFd2du?=
 =?utf-8?B?anNmcUtFa3ZrTk5xdG0xdTFlVTBDOGVQai92cWxYQ2N1WTdISzQ3d0FXQXQ3?=
 =?utf-8?B?WkV1OHg3L2k5MU1GMjJWdnVTUkttL3YxaUl1b1dTbWFoVzJFRHF4RzN5NnJE?=
 =?utf-8?B?djRwaTMrdGFaNHpuODJOY0FmZEM3K2dacXhDS0FkLzJsdzFuTUhJdGdVdlZR?=
 =?utf-8?B?UU4wb1lxeGo4RjJ6OTN1Y0krRVg3Mk1kZWlGbmdIZWQ1L0pnTi9hdz09?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 800784d3-fa75-40d5-2aaf-08da26d57ad4
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8616.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 16:05:55.9786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JfTjGdylVzuTl+BMTFgOdVzPaos0fDIs0Tqtqjh+WqGJxvs6BHZhtGi/eJbzEpmeAA9Swn64zUjLmGO9YkV2hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9009
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25.04.2022 17:54, Artem Bityutskiy wrote:
> On Mon, 2022-04-25 at 17:47 +0200, Jan Beulich wrote:
>> Artem,
>>
>> while porting this change of yours to our clone of the driver in
>> Xen, I've gained the impression that the respective MSR write
>> wouldn't happen on all CPUs / cores. Was that an oversight, or am
>> I overlooking something?
> 
> on SPR the C1E promotion bit is "global". So any CPU can change it, and the
> change should be visible to all CPUs.

But perhaps no more global than extending to an entire socket? Or even
across sockets?

> But I can see that this is subtle and deserves at least a comment. Let me look
> into this.

Indeed, with the MSR itself documented as per-core.

Jan

