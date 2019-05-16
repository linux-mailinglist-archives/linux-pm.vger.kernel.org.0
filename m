Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0DF820CE8
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2019 18:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfEPQ03 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 May 2019 12:26:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59338 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726342AbfEPQ0W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 May 2019 12:26:22 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4GGH4oY093375
        for <linux-pm@vger.kernel.org>; Thu, 16 May 2019 12:26:21 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sha0skq9p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Thu, 16 May 2019 12:26:19 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Thu, 16 May 2019 17:26:17 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 16 May 2019 17:26:13 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4GGQCaj12976318
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 May 2019 16:26:12 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6EA6F53E28;
        Thu, 16 May 2019 16:26:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.91.88])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 97ECA53E14;
        Thu, 16 May 2019 16:26:10 +0000 (GMT)
Subject: Re: [RFCv2 6/6] sched/fair: Bound non idle core search by DIE domain
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, dietmar.eggemann@arm.com, dsmythies@telus.net
References: <20190515135322.19393-1-parth@linux.ibm.com>
 <20190515135322.19393-7-parth@linux.ibm.com>
 <20190515164414.GY2589@hirez.programming.kicks-ass.net>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Thu, 16 May 2019 21:56:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20190515164414.GY2589@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19051616-4275-0000-0000-000003358177
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051616-4276-0000-0000-0000384509ED
Message-Id: <6c7956f0-3ef0-ac6d-d950-b0ed8358b0db@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-16_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905160104
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 5/15/19 10:14 PM, Peter Zijlstra wrote:
> On Wed, May 15, 2019 at 07:23:22PM +0530, Parth Shah wrote:
>> This patch specifies the sched domain to search for a non idle core.
>>
>> The select_non_idle_core searches for the non idle cores across whole
>> system. But in the systems with multiple NUMA domains, the Turbo frequency
>> can be sustained within the NUMA domain without being affected from other
>> NUMA.
>>
>> This patch provides an architecture specific implementation for defining
>> the turbo domain to make searching of the core to be bound within the NUMA.
> 
> NAK, this is insane. You don't need arch hooks to find the numa domain.
> 

The aim here is to limit searching for non-idle cores inside a NUMA node
(or DIE sched-domain), because some systems can sustain Turbo frequency by task
packing inside of a NUMA node. Hence turbo domain for them should be DIE.

Since not all systems have DIE domain, adding arch hooks can allow each arch to
override their turbo domain within which to allow task packing.

Thanks

