Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95737434657
	for <lists+linux-pm@lfdr.de>; Wed, 20 Oct 2021 09:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbhJTICB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Oct 2021 04:02:01 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:60982 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229498AbhJTICA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Oct 2021 04:02:00 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19K7EkAu007934;
        Wed, 20 Oct 2021 07:59:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=oqodPZtS4ALl4fJMGc8x6ekd1yMKs0WwsH4X5BIQPIs=;
 b=kW8/QcOni+QQgagNAmWfol4Iw8Yl3zpzWuIQ9J3C6ilHAc1eGvdJKj+BQAHuum7vlvU3
 a39cR+qreI1LfixUO5uK8aVhuGsrL32oYT7L0hxkXrG9x3Ps/apd/CQfsr8nzCmSvpet
 KNr/DxwaSaFfKYYl8XtdmDRYPLV5GSwrvQhPwBAyRzNaAl1UQmjPEtKCV4cBgxrEXIRV
 ojIvVxtjdWGpcZZX+v2Cz6Ee918vFsA18qLOaqVZC3NW/VhwSwPjIPhK6TyXMdSbJSKJ
 k+k5GmxXf46POJe6HbOtmFj6ZWVRhi4MqrO0ICkoJKmAdZ+dfMgjmjfLButJNcYksbRv 5w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bsqgmqdvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 07:59:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19K7pCYm057589;
        Wed, 20 Oct 2021 07:59:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by aserp3020.oracle.com with ESMTP id 3bqpj6p65t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 07:59:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PU76Q+Qm5Hz3NKJTr52ImG/LjHSajPQhL+0/TZ7H7yBMxx9hVlYMle+sV53qmDBVXQillqyn5rjVvO2pz/hnNN0esyplMYxWsw+rQUzWoA3WLnbutXSQPouG51q/HZ36UNdrkR1DOHcdLZBwM/tzRqy1sOUIhPzeXWXVUG6SWmrwopU0Gkil8FJoeSWkGc2OEuKSta6qb22lLcqjJp+OGoN7NCApC8rFQVnBLHFLaZkzvIFFxfISuDkPNwdNGcWGC7Rc5zz9JBp16u7D4Z6ODieOOysAesHeRHuVgN5eHmDmm9+eZF+GSGcjzbMQAkG2MHSSTZddBJKfKLBVy7Ihgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqodPZtS4ALl4fJMGc8x6ekd1yMKs0WwsH4X5BIQPIs=;
 b=mS9Wyg2ebCZyqbOCXGIrGh3CpPMy1afsNBcsYhQARVuFTgzoI4Saxjj2tLzucHdDDZqW3LBEkFWcmtih9SxHLtMWECzSb05aUZnOFaoNHhYNpnZ6jm2ApI9Aw0Tf8wsBbncb34GmOBcYv+BU6mRv1+A74LJ/hsV5x1WwnytMMT2TBdOIOMzvS8t0B0ZUjxEWoO5YholPuRJLDLW35BaBjT6w9U/S05rP3wSR/V4g9sC/bCtSFs19ofE9z00WPC+XHuyfxoQ2HEm0zjXSUxw2EmF36wvmjq+I+Dyql+sdXscjFwnXLrGYklTtQahfpM5jtdJErguh3vf60QE+pEk2Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqodPZtS4ALl4fJMGc8x6ekd1yMKs0WwsH4X5BIQPIs=;
 b=MsbvUfT1uExikIyrK75aKok4Panr6UdnSmMGWSi+MZK6rr7DipSYnlsl03xvv0yH+pryFTGwQ3ijTAmrMjvNSW6cG1OalUoBzJbE39P66WxvIEtLUoUvX7KICr2l0Cu5oNunAbxSePBdMsanr5d6s1HaRWMS8uBkZdjeDuGMCwI=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MW5PR10MB5667.namprd10.prod.outlook.com (2603:10b6:303:19c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Wed, 20 Oct
 2021 07:59:11 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::103f:cb46:49fe:de12]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::103f:cb46:49fe:de12%6]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 07:59:11 +0000
Message-ID: <e3bd151d-4658-c5ff-36ce-42e3155f7c2d@oracle.com>
Date:   Wed, 20 Oct 2021 18:59:03 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [RFC PATCH v4] workqueue: Introduce show_one_worker_pool and
 show_one_workqueue.
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tj@kernel.org, jiangshanlai@gmail.com, jirislaby@kernel.org,
        rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20211020030900.321837-1-imran.f.khan@oracle.com>
 <YW+wagIij7zUbfsZ@kroah.com>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <YW+wagIij7zUbfsZ@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0101.namprd04.prod.outlook.com
 (2603:10b6:805:f2::42) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
Received: from [10.191.128.183] (138.3.200.55) by SN6PR04CA0101.namprd04.prod.outlook.com (2603:10b6:805:f2::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Wed, 20 Oct 2021 07:59:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42805812-792e-4d30-821c-08d9939f8058
X-MS-TrafficTypeDiagnostic: MW5PR10MB5667:
X-Microsoft-Antispam-PRVS: <MW5PR10MB566750629E98CA43C706EE6DB0BE9@MW5PR10MB5667.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CS3D2GigE5u0ZI6WoKS65G/xUIvTMJEObz/8kN6bKK7tVmlhNBeDAbidnbldpLhOG9FwaBudcXSmgc76k06bFMHdeaZkO7DmGmcgPuz0sQUpSVbu3k0IDD6uzBFwyPo6nl+FFAvndzrmgFiuSkhl0QwdhTw0ALzFdS8fm2qpym4ZIHVHAXPtzv01bX+Nucmn9QxCEBpdaAIb8zVCFzyD8SMKE36JbLpplnKY44FsgGbhMzyyx8pUmIRgrRcSoe1/VGjClnk3Ri+hRTVuBK6L2cCgkxp2SdT4MJ+54slj8AC3OOgdiJ+pjWKGFcOx2fo+WjEBUqi/huy8Vfes1tG/LreiHgop9VCO73CKSpnT5v0DEET2yQZUptcB1CFw5oEUP1wbZL998VNvrMfBm2gZ+6H5R8pGHmhWx3jVOoDblhortRqCSq2rJDWGheyBUFUmr6gNO68xdV28Bh50tnaY3C8s8eK+JjY99dTK2D8f7eNaRgH4xrZ2nZ6xmRglp05mcmJ57g1YUHVqqWYQHVunVg4DSdPdqVKxlNVX4gaD7hsMfAtcN+etEEWdbegT0bgdw7bFQP/Nj8rXKZLxd+3WTs6EIrsOglWqc2VpFCSh2w2RGaumZzfNIsaPIp3KMYLGeSaI+9+dQXadewZbLEYqAipYOexK77zk29/hUxW2blDOZ6MD0kP3s4Wxj4VA6+/PScn763uf5C6LVULbn8Xt/tgMKsvk6RDFfMunjC54v74=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(6666004)(316002)(31686004)(2906002)(5660300002)(36756003)(66556008)(66476007)(956004)(186003)(2616005)(6916009)(86362001)(26005)(16576012)(53546011)(31696002)(6486002)(508600001)(4326008)(4744005)(8936002)(66946007)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTFaYlRyaEpReFdiV3phdG5kRTJtZHUwdXh3OHVTOGJQVm54SG5mQmVPZGJj?=
 =?utf-8?B?UXYwZjJTZlZnWkJwWkJXNVl2R2NTdHFraVRCOGRSS2lQRUtEME9KbW5WdnV5?=
 =?utf-8?B?VG5yVzZ0bkNScjlkN3RhZ1B4LzNOeFFRUzRlb2w4aXNTTUIxYzN0ekYwUU0x?=
 =?utf-8?B?VDJncVl3cDZIUEhQSTRSbnh2U0YxMk5VTVVlcEhpdG1DUWY0VVhKYmJJRzQr?=
 =?utf-8?B?RGxPcXIxb0dzbnJyV2FmTy9PWkl1SFVwMk9aMFluL0k5WG0xZ2V0VnJQb2VN?=
 =?utf-8?B?WjBtYXU2c0lGb0VOdXluUmtxeE5QYTNJRnBlWEZmMEU0VklaMndiQWhVVDN1?=
 =?utf-8?B?Z0RaVy81WmNzSktucFFSdWczTFFMTndiY2NQSTR5eXFQb1RiaysxTXRaSnlG?=
 =?utf-8?B?RUgreWRsZGZSQTBWdDU4MXVUZHE4UE10djFqNmJuL0RIaGc3TngzU1g4VkVI?=
 =?utf-8?B?SjJMVkk0dW1oVGNyK0pjakhDM2pQWjJWNGM1UFRtcGRXVXZxTVhrZHVvRmdq?=
 =?utf-8?B?UXJxZjNLVzMwdUNXNWNwZnEzWDVoRkE4N1ZmYVJPWjhmQWJodnhqaFE3aVgy?=
 =?utf-8?B?Wi9ZVDB0MUQwU0ZWOWJldFE2Y2NhQkF6ZG9GOG5BS1Jxc2xidHVqUUROTlBQ?=
 =?utf-8?B?MTdjSXROZzliMHpCWTgwa1JrRHdhQ3JURVN6L2ZUU0R6MXhlSE1ja0RVSDcz?=
 =?utf-8?B?RUhwbjgvTEp6WkU1ODZpalM2cEd2MllyZHpuOXFnTGVIUmQrMk9heXAwbTBD?=
 =?utf-8?B?azVWbDEwczZCL2NYd2RMc2lsYXowUXlyVFloZWxkcy8wQjhPN0JYNEhUcnNv?=
 =?utf-8?B?MXpOWlZ6MXBiMWRDUHltTHViYk5GQnE4VC9SaTQxM0w1SUtLWnZTbklHVWgv?=
 =?utf-8?B?cDVZbkV0eHhsVzMvUTM4RWlOZ2JsR1FiSTFPdUhCSWdhN0xUbTdIWlZ2aWIz?=
 =?utf-8?B?dUw2ZlFHR0FoRmFZNXM3SEFsUHBJeXRNWVNibnlqSWJuYkh0OG5yem0raUhx?=
 =?utf-8?B?dExMZWxrbTBKOWpNUG5UMVJJUStaMnIyUU1IWENPVFdmYm5kWHVHOUY1SmVh?=
 =?utf-8?B?N3FoaS9rRFRSWDZjaWpOcEVpWWd5RDQzMzM1NFpCb0ZmcGEwTGpCL1htMlNL?=
 =?utf-8?B?eWhuN3oxbjExY0F0cU80dktYbTY0dWMrYlpwQmpucWtqNEFYMm8zemFwNEVM?=
 =?utf-8?B?UG9XMXRvMURtNTd0bDY3VDRFeXlHMjJBNHliN0ZSNm1PUjVNeGR3aXBJc01a?=
 =?utf-8?B?aWM3QlkzM0VZUlFNVndjVk5GY0lmTE0rYmJCbFVJbVVHRFUveGpadTEzVm1x?=
 =?utf-8?B?QWJSbkxpUmxNY3JLWHpuNkdtcnRiVWVieUpPUVRpS1ozZXBjZENBYlFZTzRH?=
 =?utf-8?B?eXJKV3ZoUzBXS2NnZ0JpK0NHdzgxL2d6UElYNGZ2aXBKTUlNMVVSUVY5V1hR?=
 =?utf-8?B?ekoybUVmemE1TTNucWtKanNsOERqQ1p6SzZTUzRqZmYxVE05VTEzd3RaMzJ6?=
 =?utf-8?B?VUJqVmQ4V2lYRWlLaHdjbnh2TUpoRXZMVXNJOE5XYXRuZDNTVVE5bGxHZTZK?=
 =?utf-8?B?OTNtOGhsZnBKVGR6WW5qaHRNcWllL3hva0h6OWdZOXdWdGVtM25mM2FNUkVL?=
 =?utf-8?B?bGI5VE9oQmJmdTFZQUVoV2pOYldVaUV4ZXV4NEpVWG9sYmlRMlR1M0RpRy9C?=
 =?utf-8?B?VnRYcWF0cm9HMGtYeFNkdUsxSEtGRXpMUHJJZEN5eW80Q3dTVXo4RnBPdEZm?=
 =?utf-8?Q?SfZ64wDDKom+/WCt18c1IPodR6UdieuccqEYG5a?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42805812-792e-4d30-821c-08d9939f8058
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 07:59:11.3586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: imran.f.khan@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5667
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10142 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110200043
X-Proofpoint-GUID: 6ooIGlmm6v813yF5ruvHpkaYwy8dEmEH
X-Proofpoint-ORIG-GUID: 6ooIGlmm6v813yF5ruvHpkaYwy8dEmEH
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Greg,

On 20/10/21 5:00 pm, Greg KH wrote:
> On Wed, Oct 20, 2021 at 02:09:00PM +1100, Imran Khan wrote:
[...]
>>
>> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
>> ---
>> Changes in v4:
>>    - Rebase on git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git
>>      for-5.16
> 
> "RFC" means "I am not sure about this patch, please do not apply it."
> 
Thanks for clarifying this.

> Yet a v4 is very odd, why not be sure about this?

I have not got any negative feedback about the change so far, so I am 
fairly sure about it now. There was a mistake in my understanding where 
I thought that something that starts as an RFC remains like that in 
subsequent revisions. I will definitely be mindful about it in future.
Could you please let me know if I should send a "PATCH v5", removing RFC 
from the subject.

Thanks,
Imran
> 
> thanks,
> 
> greg k-h
> 
