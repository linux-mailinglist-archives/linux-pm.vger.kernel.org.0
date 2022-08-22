Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B9659C384
	for <lists+linux-pm@lfdr.de>; Mon, 22 Aug 2022 17:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbiHVPyw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Aug 2022 11:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236318AbiHVPyv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Aug 2022 11:54:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153BC2AC51
        for <linux-pm@vger.kernel.org>; Mon, 22 Aug 2022 08:54:50 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEkSGx022999;
        Mon, 22 Aug 2022 15:54:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=nKOPf/xlV+xYex99m4zfnPigY9pzy/dxdimomJVXiSY=;
 b=vZlK+a3SS1+0zPjhh9ypn7BCB4WyiIUYVIm50RGXX46E2C7CewLmBEokAT62FHpIlMcF
 oFFgs+zC1J2uJMhexby6axGSxU6hCPLZvhKKAgCga7nbTIQ7tH+clMaIMYZhAIEmWya1
 zzHI5ir86zK3OmCCZ2Cei6VMhp3yJizrnxS9QoaToWPMBKMMRRVRL2tlh0rCayfdK3bO
 vHXQMt2shVja7J7lHOyburO6TcniaGnwRtFzpWi89Q5kiOb+Iyc8yczW/x35rZ7dzxZ2
 928fYvVkRX0Rkk67rXeEtEp3orB5U/6fTaU8JX8LRF4RORrHSqihu/MjCYlmzIrrRtFb jg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4ar8ghce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:54:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4Ond037940;
        Mon, 22 Aug 2022 15:54:40 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mkg5656-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:54:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1jLIHkbHqcDJdv55EtT83RGDRn8A4+/gyLFnQxRUdZgszcLt/ThjgJZlPsCxyy4duNgGcKY7n9IgE7zu9c/OcY/KLBDJBO3TVX+J40PulRVJtYjRFcXzpjhXRFlr+ji46fLH4GdGc8itBU1iUItDWcKzjlWsJQmR4lriZbRP57jvH9dRbrWzd2PP9HDvvXuTDwhEc6vIV74eohS+lAFeukSDARW/koXPqbJehtKdsB/0c6RxJk7p7c1GkgmEikE8MgN/kNWL8Q8itkAK3OJMnLrSs1920tP77bAz8qiWpc5r7u8+5WWgs0hFfFnJflaUL7BKVWYfG+JloUmCr+HFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKOPf/xlV+xYex99m4zfnPigY9pzy/dxdimomJVXiSY=;
 b=aJTTAGq7YPtRlZxMHbn6+09+cSLg2YjCFHkEYzkhyfoEoHmTzAxCDgZjYaJkNXT6JDEJzBFsewRArnJik9e9ejHLC1o2bcLD69Z0/F5li3tW0lFrTM6JJgf6gpHYhiz7ztL1p39BQKL29q449gCaARjLYcZ2QxkihGBC6BHZRkC5rCQIv0J1cGlvlPenSalbhG8rtslEBA6n15Xm6jQG/NLKd9e3uL7qixiwnR8bE+KciTZDwJe7b/54V2v5ksGpiBrCitS8ZWZYnMlTOisES7UrHFERZtsHfZGI4EZ2O9/TlaRd/j9NCgnM7Drhiwf/XQWYJxmbVNdmnVPsCVZq0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKOPf/xlV+xYex99m4zfnPigY9pzy/dxdimomJVXiSY=;
 b=G5S0dBoRP/rR4isaz331f/0QwklWsn/oEQvSg1z2LVTPhWvE3KyhpjBcjCpBlwRFAnCvrGkqobkt1POUMSi6pz1qn0SXVRNqz3rnKBjGYtRgDBdxMC6PgiNCkhXCSw5gsCM6+tDUTy6cyGQNBiMD8xJJVy+YLhMrmF4ucbKu0Jo=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by PH0PR10MB4629.namprd10.prod.outlook.com (2603:10b6:510:31::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Mon, 22 Aug
 2022 15:54:38 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::f1e9:f64a:1a86:ee3c]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::f1e9:f64a:1a86:ee3c%7]) with mapi id 15.20.5546.024; Mon, 22 Aug 2022
 15:54:38 +0000
Subject: Re: [PATCH] cpufreq: cppc_cpufreq: prevent crash on reading
 freqdomain_cpus
From:   Chris Hyser <chris.hyser@oracle.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <1660935837-7481-1-git-send-email-chris.hyser@oracle.com>
 <1660935837-7481-2-git-send-email-chris.hyser@oracle.com>
 <20220822053920.y6us5rsi6u5cdapi@vireshk-i7>
 <6a77acc7-2bc2-2f97-b3cb-32ad1dd21007@oracle.com>
Message-ID: <7b716f03-fa86-dc49-6a8f-ac999503900e@oracle.com>
Date:   Mon, 22 Aug 2022 11:54:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <6a77acc7-2bc2-2f97-b3cb-32ad1dd21007@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:208:91::15) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2929792-e2c2-4e72-d5af-08da84569e51
X-MS-TrafficTypeDiagnostic: PH0PR10MB4629:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RJ/cIWreGAKhe1Ov1ZUeEZ8f5ThdSE5V7UOsn9BZ2HowCfjkADExoL8dSB+OBh5Mhu9eTTMHvYW/5ok87lOf2gjCktftE4xhOePrVmAOwG+iR575Jkxoc9XnwJbHqI9f5nv7z7egkSvs9tdIQ07ayBNN8nlNVBiPBepNoF9j+bpfZpXcJwYst5gnmSg9Dz7e7LnC+VrVuO+Af/ii1riZgjLOIOfS0wKt0pPcI/PQ+e4pbajTxPqSUowQfOpAOK4/AhK4P/elQCAdJxBEP4e4GgCUcnFmec24jbrrmaBV35Lf3A5ftaT5qiAwVdpLyUKMuHyKdppYajwD/XCeYV3M28jIW35F7dyL2VhlPVEOshaXuHUSdObrwaDiB6S7wvXt2XG7uaGOkrnswuiC+e6pda42/VIGe7La9UdA1wce1Pqa4vGdE/q1jpSLtVKKC4FWKUJtar2mVHaKAiXSeByhfpOiyRLi+Rbm1EwjiXMXHevIBYafm5OSX0B9HrcHqoN/HjlIuZZBoWMFCr0KsxDwuvKRjFK0AvjDuQwWuDpH+Ho2r7G4ITpC7mO9abywNDtcpui3xGVzzuqY+39ur7BPzfiVH+9QGnQwdfZXsK+Y/X8/F2yFSS9Xw7YCAkMC1+iFbz2Z47pZkp0mr7wqqjdBR+f3S0ZkAwleM8L7DxC5N/kE5W8CKa0JcdfiiSqatj8js0S/Mbn/GvqC57Tisvc+6nndZ3viAzl14Gwl2UrtjOuEN35WovDOku3K+LC+wslmnNkfHm400L47wofwoJDkjSSJ7XXfzbhEyc2Tfn1m6Db88VCPjo1w2KYnhSMO5P/+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(366004)(346002)(376002)(396003)(83380400001)(2906002)(44832011)(8936002)(4326008)(8676002)(66476007)(66556008)(66946007)(5660300002)(6512007)(41300700001)(6506007)(53546011)(52116002)(26005)(6666004)(36756003)(31686004)(186003)(2616005)(6486002)(478600001)(31696002)(86362001)(316002)(6916009)(38350700002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVBybU5xTFc3cXU2SlJ1SUVUaEF5VllGN2hxV0RNejZpcnIveDErU09YUTdN?=
 =?utf-8?B?M3ptUnNBalZSODk0MmFFejlVWUc0WWRVbkNnS2RobW54Tk9LYmIwaDRHdzRO?=
 =?utf-8?B?OGNya3dlWlRSaTdmTFU3M2lTVzJFREtDZEtvaGNQNDg2ZEFqWlYvdGhOd2NW?=
 =?utf-8?B?clBKUmJqWjRHT2tXNzMwSTY3MGpGQVJOWGhaT1I3ZWZkTWpJdlhrVDVmV2Za?=
 =?utf-8?B?eS9lQVlWbU1idFZTdXgyV1lvMjFqVzI3TFh4aFJBQTRMRnQveWNSdDc2Y3lp?=
 =?utf-8?B?cy9xcENhdFlleTJHMnAra2p4S0YwR1pVQ1FXY1ZKeVpyWm5IZGcrc09yY0Vo?=
 =?utf-8?B?VEJGdmVCWXkwNER5Q1FJZ0QzVDZLN3Z1OU83Z2F3ell5a1UrUGhqTVcwOWZi?=
 =?utf-8?B?ZEsrWS9vYTJGWXJKVm0wOTVkeGZBRlN0eS9pQ0FWWUR6Vzh2WkF1bjYrQWRW?=
 =?utf-8?B?all5US9LQkwvaVh1WlVsZHhkdUZic1Nkd0hjSzI1c2JKb0xST1A1S0dQRjg0?=
 =?utf-8?B?eUMyMG5CSUlNdUZkQ1BqeEhERFFEUThpbnFBSmJ5Sk0zU0Z3aHVrNTZ6bEV5?=
 =?utf-8?B?Y3NQQ2N6OXE5THF1NTlsdklSOFpEemw4Wkg4MGNxVWhQbDh3TGs1WmdDZ09m?=
 =?utf-8?B?VDlOUG9CUmJPS01kVlRvMVhvME9kS3hpaHN1SDBMOGwyN1E0Vm9abndlRVpV?=
 =?utf-8?B?cU9BeDZCbThaRGZzZyt2YUpzempzYVZ5bThWcFlXUVhYTTR6bDE3SkpRdWh1?=
 =?utf-8?B?RnhZOHdHMWVtT0ljdnBQVGIzSlVHU085S1NsTytZU01aMWdlbDdqcnRBYUNO?=
 =?utf-8?B?WHM0T3ZkQ0lwN1NraXdiWVlyd0xJWlcrM2lmdDczM21wajBwN2k5dVBpQy9y?=
 =?utf-8?B?ZmUrVmxiVHZGOHkydkdGcE1pT1VlQXk2S2J3RXBWKzMzR3JyRFVpR01ablRQ?=
 =?utf-8?B?SHNsY2N5VjBLeENKbW1sQTI0ZXZYbytXZWk4aTlobmplaG9FdTExU3FaN2xB?=
 =?utf-8?B?UVJkbnc3dGpMVEt2VVNEMFlUN3VsTDBQNGxBUlFFcS9qcXpiOStKak43WHBx?=
 =?utf-8?B?dW9xbVFkUnJsbHRKVURuUm85KzZSNUVIeEszODNRWXlMdm5BdUtNTjMyS0FC?=
 =?utf-8?B?T0FndzNBVHlNZnAzTkNyMjEwWEU0U1krWTd5TVc1cGVMMUhMVUx3SmNXK3RB?=
 =?utf-8?B?STdOZ0N4bWNkRklTQml0VC9XYnE2dWZZR3ZLU0F0WGFqVG80bWNEYzRLbEJO?=
 =?utf-8?B?Q3RqYXluOWdnVDMyYW0xeEJBREJiUkdhSGo2NERJalh0Y29ScFlDVjNjbjNV?=
 =?utf-8?B?SXM2NmxrbHBOU2RCM3g5Z1ROUXc2QkdBeWs2UktaQnAvRktlcGtTZ2Zya1Mw?=
 =?utf-8?B?cmI2eGdUWmxsWDNxUkF6cXlBZStTdm1VS01MVEgvL0c4N1JSbllCTXZ2ZlFL?=
 =?utf-8?B?azR6eTh0aERwTVdDUjZCbUdCeUoxWW5kazlSWGJtZVBGTkpLOGVnZWxFUTlO?=
 =?utf-8?B?amZjOThuY2o1ZERVUXdDYkRLa1JyUEZPNzM2VWN0UDl3RlhJOHJXS1VFaFcy?=
 =?utf-8?B?S2Z2dE9SRFQ5UjUzSDMwQ2U2RXhOTGxSQkpGTk53QVBBdktjaWV3WWE3SHlx?=
 =?utf-8?B?OE9YTFBCc2lJMFZFWjc2NlE5NHFWQkxlaUo1UHFxMHRJRU1HVElmcm04Y3Yw?=
 =?utf-8?B?SVB5ZHBoakF2ZklYWm9NVzJFS2ZIQXFhc1poOGNvZUJTNHBvaUdsL2hTMzFh?=
 =?utf-8?B?a2ZXYytpYWVuYS95WjRHTFhuR1laUTB1cmJWMm1aTndzVDN3MVI1T2VBc1dI?=
 =?utf-8?B?cjk2VjJjVWl4ZGpxeXEzS2JiYktieDB0a2RCT2ozdEhod05Dd2ZRYTJBK3BE?=
 =?utf-8?B?OENrWXRlNExsU1BDcFpwQ0xhVWE2UzdSZXNQN3dwQmszTnRpM214Snc0a1FL?=
 =?utf-8?B?RWdOd1dZWkQvaXNDKzdKTCtnNElxak5uV3RrbmFvNzNnVWd3aUdYWHM1bU1a?=
 =?utf-8?B?VnBCb1pqemFRQk8zdmhjUFhBRlZKTzF2NTFEZmRSUUxzNDA3aUE0Y1dMNjRJ?=
 =?utf-8?B?dGtueUY0RkV3Z3VubnlDaFZFcnB5Q0hxeGsyeUNqeHpPYVJ3alFDRUZjKytz?=
 =?utf-8?B?YTJxK0ZCd2sxeWpLSUk3T1dWdldQMEpXd2FSY1BQT0lON1RwaEFDbmZtTTlD?=
 =?utf-8?B?U0E9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2929792-e2c2-4e72-d5af-08da84569e51
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 15:54:38.5970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t8pJCMFf64Zrnb13MJLZ4MiOSGzC20bvnw2bBNkT26fc3WSEwi2nYvzNaLsASC08cZJUl3FfmZRvLq2fZM6qpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_10,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220069
X-Proofpoint-ORIG-GUID: cDlU3ymIW5LSm57OMIeoTNVspwMCZuwX
X-Proofpoint-GUID: cDlU3ymIW5LSm57OMIeoTNVspwMCZuwX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8/22/22 9:19 AM, Chris Hyser wrote:
> 
> 
> On 8/22/22 1:39 AM, Viresh Kumar wrote:
>> On 19-08-22, 15:03, Chris Hyser wrote:
>>> From: chris hyser <chris.hyser@oracle.com>
>>>
>>> While running stress-ng --sysfs on an ARM system following a cpu offline,
>>> we encountered the following NULL pointer dereference in the cppc_cpufreq
>>> scaling driver:
>>>
>>> [ 1003.576816] Call trace:
>>> [ 1003.579255]  _find_next_bit+0x20/0xc8
>>> [ 1003.582909]  cpufreq_show_cpus+0x78/0xf4
>>> [ 1003.586830]  show_freqdomain_cpus+0x20/0x30 [cppc_cpufreq]
>>> [ 1003.592318]  show+0x4c/0x78
>>> [ 1003.595104]  sysfs_kf_seq_show+0x9
>>>
>>> This is the exact issue described in commit e25303676e18 ("cpufreq:
>>> acpi_cpufreq: prevent crash on reading freqdomain_cpus") with the fix
>>> described there also solving this issue. I tracked the root cause to the
>>> following: a scaling driver which provides a struct freq_attr sysfs
>>> attributes array passed via struct cpufreq_driver during driver
>>> registration, has .init() and .exit() functions and does _not_ provide
>>> .online()/.offline() routines. cpufreq core creates the attributes, but
>>> does not remove them even though .exit() frees the underlying memory. The
>>> core functions and most drivers have corresponding NULL data pointer
>>> checks.
>>>
>>> Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
>>> ---
>>>   drivers/cpufreq/cppc_cpufreq.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>> index 24eaf0e..4210353 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>> @@ -876,6 +876,9 @@ static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
>>>   {
>>>       struct cppc_cpudata *cpu_data = policy->driver_data;
>>> +    if (unlikely(!cpu_data))
>>> +        return -ENODEV;
>>> +
>>>       return cpufreq_show_cpus(cpu_data->shared_cpu_map, buf);
>>>   }
>>>   cpufreq_freq_attr_ro(freqdomain_cpus);
>>
>> What kernel version are you testing this on ?
> 
> 5.19
> 
>> We merged a patch sometime back:
>>
>> commit d4627a287e25 ("cpufreq: Abort show()/store() for half-initialized policies")
>>
>> which I believe should have fixed this issue. I will be surprise if it
>> doesn't.
> 
> This patch is present and apparently does not solve the problem.

On digging into it, that patch says it is about catching partially initialized policies and indicates that by clearing 
the policy->cpus mask. However, on a normal online/offline a completely initialized policy survives (ptr in the percpu 
space) and that mask is not cleared and the driver show() funcs get called.

-chrish
