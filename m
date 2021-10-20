Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72BA4346D6
	for <lists+linux-pm@lfdr.de>; Wed, 20 Oct 2021 10:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhJTI3f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Oct 2021 04:29:35 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:2760 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229600AbhJTI3e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Oct 2021 04:29:34 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19K7P7ax009308;
        Wed, 20 Oct 2021 08:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WSS6L4KT4L/UtxVHu/3zYEdcsUnUUrI+/6ccgCIsyWA=;
 b=k1P8rz/GJ7Td9xG4tyZNjO70vXl1zFVqx7nebivAct0obCNp2Emdm7FRzQHM791YJqUd
 D2fsvp54OqCmeCcdBVtSU94GaFvBRNYna8XrBpVyRFCTp5zK9+8CriwWIPsOAlx2m/6Q
 CU7yRDVPQ6b59iHsNjUv5NKJMonN6Pp7p/9erIGZT9zrHXcGOGgngX490P9GNs/yTeOj
 jb89eUjhKKIQKO2ofqqqjT+igP/WGc3ZL6KwQTfK4LR+ydIndKeM88rsIvFfJN18/md6
 RnujyLNn+k37wUCU3rdQXL6tG+qgNribEKhd6t6uKj2gZeYyvJH+fRtVldXXHkt6Vy5B zw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bsr457hdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 08:27:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19K8FA1N149388;
        Wed, 20 Oct 2021 08:27:14 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by aserp3020.oracle.com with ESMTP id 3bqpj6qcf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 08:27:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eN/Q77HmTqb99WTN9PJZWpGb99MslQ4wlsEWq9UQuyapNh/1BgPgiUXuCeCRoDkBDYd41P9IVKAm/dntv+PoWLfc1Q2E4EPlm+NicEadz+TEH3WeABJe0bjnBpDYZXHbpAybA6QpgtY9+5linWkcJjcEwpDm3EIb/MeZZgML4ufc9wPMBWG1QxXwUjYk4Jp8gPPHkgPIDN9epDQblhvKjR9r0QzwS55rRMx+2PgIGeN79dguFhNTYqKSepVAnCry3UitVlL3eA88y9huxSW9CSUFz+P6HHUDFEmj54eFFgbZdVTp0bQmh/LYYz/sLIHXO1Ak761ued1YzzM7FaR61g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSS6L4KT4L/UtxVHu/3zYEdcsUnUUrI+/6ccgCIsyWA=;
 b=bpLgeyG0gQRJbC7eTXJs5Wg6++FsxPCXUx2/8qJdTOM7YO9f04XzRjC3NgJCHCjmKTHWYzj39nj+19z89VCFXWyQ7tZEo/2ZTIW+xfsC+LPPLInEzXYok6xvx1aq7HYdJbMatWIeR1yqGTeYKBVZBMpTg6yPRdxdIjw1KxUFOSUzQAX5A6B+mDyrxPGAy7VL1Mu/jenyjjyxJabh0WMSOOkp8VI/weJuSMgCe/dz6DPwEuFo8mf0r0afzGMSbgnHAmc07CWstOAna1Aik7OKeJD2/pMVLxlzpDOlrBl1gDrFRKeqGBJAxuLgSE+bplmQWBbhLA7rU/VqV4AbmfJzbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSS6L4KT4L/UtxVHu/3zYEdcsUnUUrI+/6ccgCIsyWA=;
 b=pArg43OMOqBCqGOfeoPLsTYU6WLYCOWRvTsf9CEB8DCP6Qdyks2ZiA2yA6TrgcYJqA20DydK2yrN3Afrh/1OnLV77DbdKyNiFVnOwMj85VdFbC+rlFLoO3J8vxf8LxcmQ3G1G/WQNkF3CM+sF9kg+k7JY+ycJBNYoWfzx9pyThw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Wed, 20 Oct
 2021 08:27:12 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::103f:cb46:49fe:de12]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::103f:cb46:49fe:de12%6]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 08:27:12 +0000
Message-ID: <0e4601e4-5fb1-ba8c-71cb-41038b1e141f@oracle.com>
Date:   Wed, 20 Oct 2021 19:27:05 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [RFC PATCH v3] workqueue: Introduce show_one_worker_pool and
 show_one_workqueue.
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, rafael@kernel.org, pavel@ucw.cz,
        len.brown@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20211016002007.143661-1-imran.f.khan@oracle.com>
 <YW8RYxb3rKGcD5mR@slm.duckdns.org>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <YW8RYxb3rKGcD5mR@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0014.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::27) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
Received: from [10.191.128.183] (138.3.200.55) by BY5PR16CA0014.namprd16.prod.outlook.com (2603:10b6:a03:1a0::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Wed, 20 Oct 2021 08:27:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4eeec2de-3f51-4094-ec99-08d993a36a24
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:
X-Microsoft-Antispam-PRVS: <CO6PR10MB54095B52FC0FB741E96FC82DB0BE9@CO6PR10MB5409.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F7VpJbnCGWXBzeik3/LxCLbLWJvKwzXUyhBcnXO4MrECgWHxvcGEY6AlmHBSMDms8jKD1YSDz7fDR/u0F7/4/APoc/zcxZQUWOUQid5KT/Horl4e5sCf1umyfCvlQV1qZ7PgPXDNxy+/ExDk0CW/Iw5lkIwCsRkrpmKSDlGekqgn/VV4GdN2VALZrivdw8xwh+8D2NM4lEbJujkVR9N+2Nw61T631yzaebhx4jghR8SfQUOaEZrK6CLxsFXdF6OJiQiSfT0vVKFCmCerhKoKRizarnsBHnddswxlsA+gIuvJpchazPXRFJDPUfgfpEkT0EvrB6CXh40d+TpfD7PUhjpWs0+yxzBMJVkWzQ1LgDyN2jaA9BcEE6mbLv9cmRTDWNp+bW1H9gXAVAMB93vedRWi0b/eGrKbXTegAYHzqg1gr+HR22J0mR03wbCdWYAp+IUWkIkIP2FR/FGWLEwxGJIljGhenPsgHHkwC3stOX68PeaUM6zKDEfQND9SAjDliBqnwDb8y2FNwhbTupbHl4VtUsU8e7Eq2HWWp5tLsGmlVTDB61nKRI/fx4H0N9VMuc10BA0S/ZlgQj434VoQ9DzIzOI2uaJnXPEycbRJMvqTlJzPGTce+gZSWnduqjh7EufpZlDD473Nqb5YFAm1DGaH0IwGqfHBzerEpkLeoL+Eyw2dv/ZxqohmXHMXMEVLWit80Xr0tCUdvv3ooUboWoOSuXvBzcbbHTfFZI/aAY9km2BpcCFvVq1mRgbh2gzZh1w0Uid4CAlhJIaCHi52qu9Y1Iz2zxu4SSxDuAL7QkJRNKUUNoznZ+TsF/lv5T5J
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(966005)(6916009)(8676002)(38100700002)(508600001)(26005)(6666004)(16576012)(186003)(31696002)(86362001)(53546011)(316002)(31686004)(66476007)(66556008)(66946007)(956004)(2616005)(4326008)(6486002)(36756003)(8936002)(5660300002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1F2SFh6MkNJQUhoak9GY1lQV2Jsd2dMN25PeUxNR3FZQUdlY2x0Rk9qSzQy?=
 =?utf-8?B?MVZPMXZFMGh3blIvWmI4QXlsK0Jjb3dHTTYvNXM1ZmVTMEQxYzdsb0FuU2pW?=
 =?utf-8?B?M3NHVG9Ldm03QXFzZ2F2Z1crbmRLSEVWeGdVNVpTd0VpbVA2eU8rcDVBcEE2?=
 =?utf-8?B?OHZSeko2Q2JGWFhLRmg2TkxvcEZ0OEhvL1hZZ3RiN1plbWlFQU1mUS9uakdt?=
 =?utf-8?B?SXo3VzNDdllTVkNsSXVubU1nMGlaa1pnN3dkOXpPRkdOaUhzcS9FejJRZFE0?=
 =?utf-8?B?OXVyWUFGcVNBY2piamVoRzA3Z3RLdWdVQVlmWVlPSkpuR2tUQ1FMQkJ2MnZC?=
 =?utf-8?B?V0pQWDMvVkkzZk1sVk1oZ1ZzOWxZTkp1dHF0d0swMDZXV1pkbWlQakF3aHdD?=
 =?utf-8?B?K1A1aTNGNkNDaW00VjhDVGl1RVp5bVpqMkIzaTN1TmszYU5vbTYzc2xxYlor?=
 =?utf-8?B?Z0Q4eXVRelg1TnM3KzViOEszb2VTdnpxaVlMdlRWU3Brd2xtUGZGdjlXWS9P?=
 =?utf-8?B?d3pQdlF4Y0hOUWFrM0Z5VXZqOERBUU03T3ZxbEl3QllacXJRSXF5M1F3clFl?=
 =?utf-8?B?L1duNnk5RXBmMVExd1hBeExLNGd3NWVkaFJtVzNIQUpOeXJzei9TVTV6Wnh3?=
 =?utf-8?B?RzNSOGdUZzFRZTdNekRPend0T2gvZHRaSTY3MjJmcGFjdjZnTStBY3dFRXg3?=
 =?utf-8?B?cDlEVDEyQlJtZ2VjWFY1R2ZBYzk1dWIxcERJU2taWnhqM095dWFwN0tva0E3?=
 =?utf-8?B?aXJ4RmQ1TWp0MTk5VEtnVXBsZnE2U3hqWkIyZzIyNjIxWldmaW9HL1hsRW83?=
 =?utf-8?B?bU9Xc3E4ZHg4RTNBNXltMzJ5RGdDWXBhVVl3M0FwTnFWK0tLSERMV2lJYzA0?=
 =?utf-8?B?cVcrTjZSbXRsTW5UaTRRYm5tdTM5akZsdytFbEJiRnc5ZHdxNWlvZGhvQTN2?=
 =?utf-8?B?MFN4QW5raGFrUndMNU5iU25QWnFLcWtQdmRGQ3FwMFRJdmRpUlh1dlJGL1hQ?=
 =?utf-8?B?MUJkaXUrNWN1djJEU1UvUHhmL1VtZlVOK3dKcTZ2UmhiNDcybDlQMk85V2RM?=
 =?utf-8?B?MW44WUlRdXY2cTFjaGd6Tml4L0RBY0c5WHFuLzlLMkRaTzh4andPd3djdkNL?=
 =?utf-8?B?SlAzc3lTeWVnRW5vOEEybXdBR1ROSnNMT2V6QVhFb0kzalZlc21FUncyRSsx?=
 =?utf-8?B?dGc1RGdVSWRXVDV0NDZCOGN5ODMrNXEwdjhXaURVUFNWV3JBYVYwV0lyK3hr?=
 =?utf-8?B?ajQ0d1crcDZiM09kUlEvTjlFbHJYU3VYQVBycTJveTF3SEtIOG1IUmdKK1Zm?=
 =?utf-8?B?bEg5Wms2b21zMkxBelhnUTQ2WU8xazI2RWhCTUVZeGFiOFY4T1IvRVMzUjgz?=
 =?utf-8?B?TE5Wd3kxM0NMYmpFZ3NCRlYwRUVFUENVaDFpTW5BYnVWV0JFb3FySU1LaTF5?=
 =?utf-8?B?QnMrSUhYeXBEc1hOQVVHeGJyRFZnaU55aDhoc0RJckg1dWhXbC80aVBraXk1?=
 =?utf-8?B?Y2hDSG5hVG8xNXZ0NGRhRmQrMmI1amRuamJLTm5GY0lXdnNQNSs4KzdaVXg4?=
 =?utf-8?B?RmVkRGo0Y1cwbStBVkN4bFZHcnBwdFo4aDVTZzRqOHY0eFpWWWFaNnRYN1hV?=
 =?utf-8?B?d29ySzM1TmNQdG5OK3M3VHlmS1JlV3NscHRmNXNpUVFrV2FaTnRJMHhYUlVz?=
 =?utf-8?B?VktqTHdpM3RLUlhWdTNNaTRNRlREa09TSjd0WVpndTRMMUtEZlFQeVpkMmVl?=
 =?utf-8?B?clZJTURnaGhPYTFRMlJpeW55d3ZveHBia2RaeHo1Q2swSnpLbncvbjZwTkFZ?=
 =?utf-8?B?d3p3bll1NFRISEgwOW03Nzg3azZLTVRYb2Z3cXl5YmozOFBUaXRmK0RmaitE?=
 =?utf-8?B?dVdHdEkrSEJmSG85LzZtODZ5RDdCNWNpellETG9xczFqdWkweXFmbG9lamt0?=
 =?utf-8?Q?HqNZY+pMKp8rqwpnGalkm9Iwa7bUQBFd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eeec2de-3f51-4094-ec99-08d993a36a24
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 08:27:12.1095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: imran.f.khan@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5409
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10142 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110200046
X-Proofpoint-ORIG-GUID: rnnYndAhZPvkKNDicVXT2oLjFnu5QJo3
X-Proofpoint-GUID: rnnYndAhZPvkKNDicVXT2oLjFnu5QJo3
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Tejun,

On 20/10/21 5:41 am, Tejun Heo wrote:
> On Sat, Oct 16, 2021 at 11:20:07AM +1100, Imran Khan wrote:
>> Currently show_workqueue_state shows the state of all workqueues and of
>> all worker pools. In certain cases we may need to dump state of only a
>> specific workqueue or worker pool. For example in destroy_workqueue we
>> only need to show state of the workqueue which is getting destroyed.
>>
>> So rename show_workqueue_state to show_all_workqueues(to signify it
>> dumps state of all busy workqueues) and divide it into more granular
>> functions (show_one_workqueue and show_one_worker_pool), that would show
>> states of individual workqueues and worker pools and can be used in
>> cases such as the one mentioned above.
>>
>> Also, as mentioned earlier, make destroy_workqueue dump data pertaining
>> to only the workqueue that is being destroyed and make user(s) of
>> earlier interface(show_workqueue_state), use new interface
>> (show_all_workqueues).
>>
>> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
> 
> Can you respin the patch on top of the following branch?
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.16

Sure, I have rebased it upon the suggested branch and have sent v4 [1] 
of the change.

[1] 
https://lore.kernel.org/lkml/20211020030900.321837-1-imran.f.khan@oracle.com/

Thanks,
--Imran
> 
> Thank you.
> 
