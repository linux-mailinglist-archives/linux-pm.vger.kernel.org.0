Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28B65FF05A
	for <lists+linux-pm@lfdr.de>; Fri, 14 Oct 2022 16:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJNObF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Oct 2022 10:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiJNObE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Oct 2022 10:31:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3E214DF0D
        for <linux-pm@vger.kernel.org>; Fri, 14 Oct 2022 07:31:02 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29EDaS09001540;
        Fri, 14 Oct 2022 14:31:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=ZaovgJAQUZmOPAm7DM4YHnFhq28fuQxLlsOBFMnKaxs=;
 b=zl3VvwaJuEFjWS9bjZOAM+/i7BkRf4d95GJ1cEPb30DMTaVOs5R4pCgkq6WcjzJB2CmK
 ViRmYtT1KOx0Eq2b/x1VWWFxVNLOfGPppDjWYdPV0Rs5QvFdytA3fG4aEx0HYDSwgEyp
 +Tq/ricxKAkhWA6YbfZUS0kOBe0H0CDzhXMmdYjtlmHR/5G4Fgn7S4WBzinhATtgiQfF
 em4VdY5SetGkFc+vP1rWQpEablLBou8I7ltVyjsNM3mJ98SzPcLja/MiOG/lBSXtcMbT
 Zm5/UUT4W/U0lUnuboY2fR8J4vYVPGfZzm9IPFqvTY8sCOkI2KKkCT11YZbuWbrot1J6 XQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k6mswjy6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 14:31:01 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29EEI4AB015077;
        Fri, 14 Oct 2022 14:31:00 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yndytaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 14:31:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImEyRvt3Pp7bCFTlJ/9s2bRayvkOrDsStq3W9m5yM4xWjSY9gelPnnzVo+0o7z7hrchXi0v/RpfIKCGHloK06+yqyzox5sYkRQkbzLNF/fiZ3SHZFbij/vzXeaBwivTZC4R9JE+Cl4Ujc7lkYoqFtft7Tm9GqSjGee8Kpa1/BoNsNXISJVeJFWTe+gLyxihipvZ5KntTpl0fF0GF2NB7ktA85+1EqaWM15sw/SkbLUFXjz4mDC65udkaeQjAULDbQ+vUb0IMvg6l8LT8A13ZKccXwLNL25JbVdaDY2wnJeadTWJ2JQj8QLB1S8iQN6E9gjvYiNJnmOT8WakRxY7UYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZaovgJAQUZmOPAm7DM4YHnFhq28fuQxLlsOBFMnKaxs=;
 b=DNHfyueJKfV5RCtAlbhKx7yLgLoE5lBJs9cB93TivgOEMkTPYKbqg7QiZ1Xyqek9WIHZV9eRbVxTLyW1/++zaPpea6o7kRyy0wlS4tJhhR6M5H8kiRp7jEix3CICW87J4ZFRxlpG4D6Sech9PjvGmBvlsrszDDQzPANagwmslkMXcs39+S17w4/X6g+HJ6zxQTqsni22iltq8TJPRhznz7CoVtDDX+unwYWX6Vj6rP+CGvK0/rJqp5g9xOBBOgedTdxJdW12ZBCAy0hs4kXne7OuL7nsQBVZEglhwIxqUOoaFSdqADluyGU0ECmfTomuaIOEHtzCKElJuANLIrTqGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaovgJAQUZmOPAm7DM4YHnFhq28fuQxLlsOBFMnKaxs=;
 b=eSAKjuQK7pPUj3uw2TT8vMMTtCOZ+WQqj1I0t/lch6r9kquvGjYv2ygf+R8WsoRdjDJq88Zm+Oxue4tuNJuEaFxoP67GMRG5LwJ2YW8Cxs9N3ZVREHYU+r/PawJxo+iEqxo55WpedVunmLP6iOg2BS0xXbCZutBjZAR3J6yi+Uk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY8PR10MB6612.namprd10.prod.outlook.com
 (2603:10b6:930:54::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 14:30:58 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Fri, 14 Oct 2022
 14:30:58 +0000
Date:   Fri, 14 Oct 2022 17:30:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org
Subject: Re: [bug report] thermal: Add cooling device's statistics in sysfs
Message-ID: <Y0lylQhiGdVGTM1I@kadam>
References: <Y0ltRJRjO7AkawvE@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0ltRJRjO7AkawvE@kili>
X-ClientProxiedBy: JN2P275CA0046.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::34)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|CY8PR10MB6612:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ab313c3-26cf-427f-6bda-08daadf0b5e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PktRJvoTvF+FsmKfJWcUj+kukiz/C+ahWgbd6/X2nExd2lRwdydYrp9FaPYPg7SjHoU0bdr5mltDMFaWFpVkKmHW18JcnOC/eskT1GKd8OiLwVtMVBruzZLzQwY6TAQaWmdNgYHSkBi2WC77jphKRhPNEPu3JrbLjtCReRNMFndvnmZljrQA2U0yCY7VZsxHAealuqmpBbnC1+Y7sbIYzomn7rGXSqnKCiPA4Wsrxp0pR5AJbYZHrn5BZ+Gqhs95J9XkSqwKvd4SYrGXmEUP7wtQQ0+EdjBEGhMIImZuPjWssv1jnGB25YfW3+zJM6UH2a8Ws+sq5Cus4NN3wnPFNpKx5xl8cxNcOy0Z4GkxmOu0wtRX+pTJvHF0qLAjxJ7DTu7b6yusiEXIcWrTEKj/vGv7qam2eKeauFwEX1xVDeznF00tm7Rhf1qKqkAKdmKCMIBvrTlLSsE5x48S1AqyUDXpa81AhDdFUfR+jQatJSL5rBg1Vz9GBymf5KSZImOp7m95L4iR+x/VaetnFgK4+3bkqRuQbegY/fjwsAqnKVnablo+q0fJxE4UjIqAOpnV5/uJb87jUb2r9FckY+xhrzVnnaTn/eGihbjkLMAijO9zkk4r0r9lO22wo79u+/MYzD1UWN9GO4r83LmHHxlcaYBgfwcjRyLIXeaF8/RdWBf+1NDmdWuPC/ASdqEwPbmtVGRXoNlbX5jbdYO5fOZYjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(39860400002)(366004)(136003)(376002)(346002)(451199015)(8936002)(5660300002)(44832011)(186003)(2906002)(41300700001)(6506007)(26005)(6512007)(9686003)(33716001)(86362001)(83380400001)(38100700002)(316002)(6916009)(6486002)(478600001)(6666004)(66946007)(66556008)(8676002)(4326008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UldasEYseU5Q4EsUfyuSJWWtTKO49jozxprL+5PWRbkfpPaYQao3//Nvy0IV?=
 =?us-ascii?Q?jfPFoUSnZHTIOrzCkRCDIwF02VCwuwzI7v6RcV9pewZRJhI1WjZRDVRRIai+?=
 =?us-ascii?Q?o5ZytLPO2iVA1Tr4kD8VDJoW/l9JggUR7eUj57MlmKFJaUkCKAuDfoAQ0bKw?=
 =?us-ascii?Q?8pLgIKjUKcBK0eoUuvYNiBkUCgYeH56+kV4fjOK1+gffrBk6P4Qkv5/6huvQ?=
 =?us-ascii?Q?ohfKz+djBvF09lKAIS0X2WNRWFoLGmCwgxChjGlO053eZY+258JdrzWGlEMP?=
 =?us-ascii?Q?J7wUdi8/2RWRrk+Rc2vXIxaWUrtDxiojmD8DFwlhi88exR5hZSxM+7XcD6FO?=
 =?us-ascii?Q?y6Wb04+lyW8cag5kI/gTLhx6bytdnZqz4oR5nTC/z0csKw+/vOrbL0jBIYtg?=
 =?us-ascii?Q?IPZRXU1sf0Ez6DpolBPtA7urORhQTvUnY4MsasURfhdlT43PAaXcE5J08L7W?=
 =?us-ascii?Q?+elv7UeLmCxvqYDTWtsFn7LmGh0Z/AUTlphGQmqqQOhIzyRy/QUaaX7oUXt8?=
 =?us-ascii?Q?xG+dLSWWS/usf6mqbYhPGxwr9gqHLJG7L49J41S69x5/KpEz/V+T5I3dyUdw?=
 =?us-ascii?Q?q0DT49ngzPT7IKPH5G6qYBWyL2EGC4dtJXbP4fffs2BtW53ly/meMBW15Jhm?=
 =?us-ascii?Q?W1gSFnaVEjiVZw7gaf0tpzKQPhUmpqjUDcDIajbAM4dBbwDSpMkpSY3z0nN5?=
 =?us-ascii?Q?SDe9+nl4q9+60MTvVOLQ5BNLsaZy4z4XufQRwvmT+lhG6Fe92LzY91HUoA0H?=
 =?us-ascii?Q?PFNlKjkwn33zyzXqZ1wvSzaHAuO2tgkJGLsbGx5G5uSZedM9F0rSFnHsQEQ8?=
 =?us-ascii?Q?RcgQmf2POP0z8nH9lL7Na9krA86Gg+c+MpXFdrUjKO4Y0wnPSX7nuYbavo7Y?=
 =?us-ascii?Q?OoFq/Rcv9q6ujMTKwV/AIWfHy5PNX3mQe5sDXDTj6s2uAOPkaBcTd+X68HAc?=
 =?us-ascii?Q?AUQmpahpnUtqa3WWaCGFFvZ4z/eGFB1y6Fm+blaRsVx5PSFr9xzK6nK0ZIWv?=
 =?us-ascii?Q?u/2fWa6Awqx8PDk2anA5r8vo/fMWp8rDuGKzKlqvg+ZJXnN0VUs5/SdsGT4q?=
 =?us-ascii?Q?46FNk3ysNIvaeJngnIjf88uFN9E8HJcsPX+jpT2opXCrzwtyK11sJZxBSV2k?=
 =?us-ascii?Q?aNMyR94UMbKCAScNN/VJtVA3+NtzLRyhSGjA4Am4bKAh5GOvIDdCR9pQNCih?=
 =?us-ascii?Q?P8kouugLGPBKv65/cQ+c8YFb3d50Fd8gdgWvMrQiCgWP5TQFOoUhFJ1tGYS0?=
 =?us-ascii?Q?C56LqA6ezIpgluq1TS8T8AuVj+1Etrq+aq/hcYoSmfQw4KDPH4Af2G18wB7e?=
 =?us-ascii?Q?VuINw4KO4mPwmQaNdPU7NJq3CjP0ctCubyhIr1VRzIjR5w9wA3sFG9umx8JQ?=
 =?us-ascii?Q?xscUfUy7KuSgnQgi1qEmQsmvmfb0BxsXqUFAxNpjiS7ElV3hr9g5iNQPhLlV?=
 =?us-ascii?Q?PmrT6k+4Qz4YNtHjzMRYiJTBnKZIoD6TKG1c4s1CeN/CScA+A502GBFvaXpZ?=
 =?us-ascii?Q?3vgnILHxzzbmHgotLPDebqxGzW/IKJC88p6zTwndwth7dlVj+JnFLzPvt7d/?=
 =?us-ascii?Q?tImfgyoKT5ey3ZZWeRxTHGY3X011RAIAihX0UD96PUcl8dKnMJYYhwr4VxmA?=
 =?us-ascii?Q?jA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab313c3-26cf-427f-6bda-08daadf0b5e9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 14:30:58.3482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDxYofsBBg8Ndg+J0ttdc4tgLzlnPa1Glv+YeU1Z5Y6ijeLYGp0f8HWdRZGj2jjwpKAkHOTDgqYzMq28L8XWEm7HuK8zzldIz5MaHQpTWlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6612
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_08,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210140081
X-Proofpoint-ORIG-GUID: 6RahQnpu9tQha0-yi-uv7ryNi1FboZ28
X-Proofpoint-GUID: 6RahQnpu9tQha0-yi-uv7ryNi1FboZ28
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 14, 2022 at 05:08:04PM +0300, Dan Carpenter wrote:
> Hello Viresh Kumar,
> 
> The patch 8ea229511e06: "thermal: Add cooling device's statistics in
> sysfs" from Apr 2, 2018, leads to the following Smatch static checker
> warning:
> 
> 	drivers/thermal/thermal_sysfs.c:656 thermal_cooling_device_stats_update()
> 	warn: potential integer overflow from user 'stats->state * stats->max_states + new_state'
> 
> drivers/thermal/thermal_sysfs.c
>     642 void thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
>     643                                          unsigned long new_state)
>     644 {
>     645         struct cooling_dev_stats *stats = cdev->stats;
>     646 
>     647         if (!stats)
>     648                 return;
>     649 
>     650         spin_lock(&stats->lock);
>     651 
>     652         if (stats->state == new_state)
>     653                 goto unlock;
>     654 
>     655         update_time_in_state(stats);
> --> 656         stats->trans_table[stats->state * stats->max_states + new_state]++;
>                                                                       ^^^^^^^^^
> The new state value comes from the user via sysfs.  It is <= LONG_MAX
> but otherwise there is no limit on its value.  Presumably only the
> admin can write to this file so the security impact of this buffer
> overflow is not as bad as it could have been.
> 

(There are some drivers which might cap new_state.  I only looked at
tc654_set_cur_state() and it doesn't cap the value.  It's always going
to be safer to do the bounds checking in a central place).

regards,
dan carpenter

