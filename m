Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C037A4296
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 09:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240005AbjIRHcI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 03:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240138AbjIRHbg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 03:31:36 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D0310D
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 00:31:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJw/qQfwWHX1M6NrqSnzD77RzzFxCVOQEqcmmcWyVVUeSaZGE8qmUqJV97k2KKdeCZoVxo05P+jcRFbfQTDZBTAdhMpAjS4SokZLkE4lLAo2oBtCvTT+T7hngZZTqs7usBAYlC98NGS0Nanm6JI41hsoAVY6JACmwXZwTRXdmBWHu2mLqsXx+ocOlMxKhZI4/YNTPNitwzxAZCDT5uUoItv04c5+m4DPE17VjU3aKUjdr67HOAFXNiRkUtg36tCwNK0vd8lESjyZ+PKRSLWDDe4m6h9DxDBbOhKvrMdKAF+sJNCzLpLu7E/GMbKjdN4pXoj1eENTILbOw2hAQSomwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvVo9P5qy6L2zKVxi4W7gW4dyic/b/qtyetK1gpcsz4=;
 b=FDjlHIl3/r/Zn4gdPejrNCah92urBYSAliGnmn3h/1JgkQJZLHQ/OdjxDOE8zacgAQLfWgwHdfXdoLODvQcSCT5jbNvwnJ+U6mrNNIOne9wkP0p6BF5TMXI1VPHAD37kmNJdZeFMn0VWt9KVrsaH6eZGTKdrJT3mPYyqu0yiQfg9SFAGAnihymLXCYZwTq/ScnNFuHUKamMDq0a6SetE8K7Nz9bciz9RCKkmpSK9Nxqv6EPHeybYCWLk/zeGT1hsPveXWefsPh9icFP/j/di4ZlGV66ier4hNEy6fWnvWv+s3WHkx3hnBEKWESDsSfGNTk2qa1JJY21GJWmdgXF7Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvVo9P5qy6L2zKVxi4W7gW4dyic/b/qtyetK1gpcsz4=;
 b=DcUPyOtNOSoRK3Sv0K2jYu02lGrT++3T+H6DG2imYwE4irzfKXG3SCFcpPJD2XDOFf0g3R7GFOSrpHxLf6HFpldoRI/ti9FbkUf6nTkKmVSKg8XGTU7QOTHAYt2uh6rAJAihGvKKaY0XnjD8P50XK+0sJdWR5mzprI1xcqM5Dik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by LV3PR12MB9438.namprd12.prod.outlook.com (2603:10b6:408:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Mon, 18 Sep
 2023 07:31:06 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::c3b:811:fd1d:c33e]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::c3b:811:fd1d:c33e%6]) with mapi id 15.20.6792.021; Mon, 18 Sep 2023
 07:31:06 +0000
Date:   Mon, 18 Sep 2023 15:30:43 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Meng Li <li.meng@amd.com>,
        Perry Yuan <perry.yuan@amd.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: Unable to disable AMD cpu boost using amd-pstate driver?
Message-ID: <ZQf8o8bZOzF+bCn/@amd.com>
References: <5b410ac7-ea26-4f26-96a0-84451943c83a@gmx.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b410ac7-ea26-4f26-96a0-84451943c83a@gmx.com>
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|LV3PR12MB9438:EE_
X-MS-Office365-Filtering-Correlation-Id: 0671021c-d3a4-43b0-a069-08dbb81937ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YmP9OGr8RfaKZoOjrRTtr5g0s2rZnM6x+A2utOB28qdXQiXPzzdaz1tcSB//s204h5f/Tch8k8yc7NLn0Vasi4TE9mPgRkrSkGR4hz3jNWYQTVxF7cQQFfzNMULk76um8KvKrnZ2QbWuHJgI7Y+TMGl0xV4qC2iF8lOkTy7ZWmSfLWcdISvysb+b+kblVdB3t14FkOYpcCw3IG4q90O9/jW6EvVxXF69wT5ByH1cXY27uR7jJoKvH/TiiSQjj0SZzg0j0ToYKe9+OAVt+IiPZ7v0z7sdxpJ2TO2BQcqaoGWo+tuCojEOgXqtdqTwfu12Xx9MKhE1+lrQ4OtZxZ296MkvxA4L5BCIeWyjczmGq7nzT5SWuOWmC6ObJiFQEV2Vwj91sXQDc4reemRob3vxhEAtW9nZs7dLar+EC3RzYQQGOe5zTJEpBF/gk69lhpolZ/8kDpvjPczL9UjqFZabUtE3/IzEkqMnAH2n9zRykj1XpwLZSTHyE3NR/cHkBZ5lDsva0LGMqzapEvZYysmNpEd2x93lNEGPE3ztS2+nPWwyZhKHIsvvoSFtBR5VGcSd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(366004)(346002)(136003)(451199024)(186009)(1800799009)(6486002)(5660300002)(6506007)(86362001)(316002)(6512007)(66946007)(41300700001)(66556008)(66476007)(38100700002)(110136005)(6666004)(478600001)(6636002)(8936002)(2616005)(8676002)(26005)(2906002)(36756003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X4zlMyj37c6tyPIdzfgjZwSqA3OGlCR8El51ik7CuKIvhzBr9RZWBYvm8clJ?=
 =?us-ascii?Q?CGqZOc1pD+3jH6V47G9PCgHZY6eqcg3dxW3tJcdLAz7/FviS+XlGjaA4ZHOd?=
 =?us-ascii?Q?SphsJu+BZ8E63+Rl4ZSLZGiKVnsojLLKy+l/H2wykCHfaWPtsYv6IOG0gQcB?=
 =?us-ascii?Q?PNEzscBq/5gHm6rGQWRUPMMqwWCXlYDQiYAXW+KY2Je1NwlSsD8d2i4slbgr?=
 =?us-ascii?Q?FMvAii27ASzVFurCAJ964RQryqR5MsaYwKxyimD7yfKV6tHrlWp12NSrmInl?=
 =?us-ascii?Q?8nf3Ze2yJN/BsjDY/rXthToy8J5NktjL8w/pWSMZ2KWHnkSU/wqdy7UVnGsC?=
 =?us-ascii?Q?qYFGuRSKCcNY/v/KwKdqphdJ/ESzEcQu3BCW3YUACjl7vnsSFJNCCtJ5HmAp?=
 =?us-ascii?Q?oPspxjvv730uiQRWpu9qZRMd0E+Ds7+X5EYtdQYLpAwpWWVlvCKSXm3V/mE5?=
 =?us-ascii?Q?8xOWw3nO3h0aub77umX58dHRBTzYnU6iWHtYwAmNmJR0RvujmMhM0Dr4CG6R?=
 =?us-ascii?Q?zrYaW3Jq6axYN1GV/TMA5S5RcggxyWLO39RVpCtjuoDwivvQEGAuDFIxX5gh?=
 =?us-ascii?Q?QxRMdZQhzVSuHJqdyQiHgNgKikou8Oi6H8P159VRb31l56QkSRqQGUs0KkgK?=
 =?us-ascii?Q?+F/ER9Q+P6ZRZqIQ8qWnNnhjXoWoWXB5FY36FT9hoMr3AMU1quTwiMyfx3nD?=
 =?us-ascii?Q?6e9oEx+h+zCqRpprVstwp8V2RYIzGcTQ5W84MIZ5KlTKa5piV3GQ1v798En/?=
 =?us-ascii?Q?AU15O2gOrqRrFYFQeb2J/KvEEGxYxUqeugm/5meDcv0Zu5yZULvaiVGy0yWH?=
 =?us-ascii?Q?/JCszu83rMBRSvjtbHlTrOgO+u3YUcBxhBLrnHGSpy50U4pYbcOfjr4eJ/Tr?=
 =?us-ascii?Q?BXEVGDTHlCn8GZCioEuX5UGqmGTfDA2vzQ6BfL+zZDe+W10XCTal6XU/OMaP?=
 =?us-ascii?Q?z3AY2Cs88NcdDOeMhVT2Bj3sPcXQ5hWYj/Kq+0qbGtyBUNdUhZdgcbK5jnkf?=
 =?us-ascii?Q?ZQ6H2Q2m1VhHGnnFIMUmVx27eEgY53tqQIO+mGxCCB/oGUCIi3UCG0qTOgil?=
 =?us-ascii?Q?/Eln0IR51jTDrHS9/UZbPAZjjeXN5woqPvmyuo1S+0e5/DuQcbzkY0H11e5Z?=
 =?us-ascii?Q?A/Dza8vlUwXc7pn27RdF8TCigeX4cl4PEe4fJaLMd+vbrtuT4zhhkFi1+6KB?=
 =?us-ascii?Q?zItG6ugxkAjVVSyX7H93gJ+qFXkcZ9K2ikGtqvuWs3VtUmNjnUW3QRskmY+D?=
 =?us-ascii?Q?nkdlbKPFDT+iSh/hBSbIMl6tUPScLGXKcv6DPU415zcmc0QojsdVt+MJfYX/?=
 =?us-ascii?Q?ZMyl+UdeOemPbLyjjRTd+m8KvKah01vY9owEqrRUQQhTpxLwmCnQ5OOwK0OR?=
 =?us-ascii?Q?PWloZ+TbSxukmFaZpWSIDRSpkKE9CvgtS6C6m88lNR1CBU1IfcmyTOKxG9Y3?=
 =?us-ascii?Q?qCo//hG7eGcgub6McypCBmYHXPKVO+CSwQTjasJ4ngUYR++qvsLJKsGgELQ9?=
 =?us-ascii?Q?Aicq5CbPazCFQh6OjUvmRFFaP4+8mq5hObH2VxaYDb1z11KDLWMypU8K/60o?=
 =?us-ascii?Q?NPAK/s49cuvK/gDGCYOgIghFd+79ZyHLyXPrFbww?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0671021c-d3a4-43b0-a069-08dbb81937ef
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 07:31:05.6645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oCm00B+lIOHSAetdXfu8WUr2Zc8/+J75yQWCSEBXaNFhUhPGw33pzw0jsWEFd1HEwQTRDb9HA9aL9FkDkYXczw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9438
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Sep 17, 2023 at 05:52:06PM +0800, Qu Wenruo wrote:
> Hi Rui,
> 
> Thanks for your hard work maintaining amd-pstate driver first.
> 
> However it looks like if amd-pstate is used, there is no way to properly
> disable the CPU boost (this becomes obvious especially in Linux 6.5, as
> amd-pstate is enabled for my 7940HS CPU by default).
> 
> Previously using acpi-cppc, there is always a file named "boost" in
> /sys/devices/system/cpu/cpufreq, and echo 0 into that file makes my CPU
> temp never cross 75 during gaming sessions.
> 
> 
> But in Linux 6.5, with amd-pstate, I have to go amd_state=passive to get
> that file back, and echoing 0 into that file makes no difference.
> I still easily got 90C during the same game.

Have you tried amd_state=active and set balance_power? We can support EPP
and the EPP_INDEX_BALANCE_POWERSAVE maybe fit for your case.

Thanks,
Ray

> 
> For now I have to completely disable amd-pstate and rollback to acpi
> driver to get a sane temperature.
> 
> Is there any proper way to disable the boost using amd-pstate?
> 
> Thanks,
> Qu
