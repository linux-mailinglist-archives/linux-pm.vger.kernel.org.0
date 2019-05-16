Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFE4D20CB6
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2019 18:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfEPQPx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 May 2019 12:15:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35304 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726510AbfEPQPx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 May 2019 12:15:53 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4GGCVEw189484
        for <linux-pm@vger.kernel.org>; Thu, 16 May 2019 12:15:52 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sha08kv8n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Thu, 16 May 2019 12:15:52 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Thu, 16 May 2019 17:15:50 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 16 May 2019 17:15:47 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4GGFkDY58785998
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 May 2019 16:15:47 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C73D15269F;
        Thu, 16 May 2019 16:15:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.91.88])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 87AA852692;
        Thu, 16 May 2019 16:15:44 +0000 (GMT)
Subject: Re: [RFCv2 2/6] sched: Introduce switch to enable TurboSched mode
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, dietmar.eggemann@arm.com, dsmythies@telus.net
References: <20190515135322.19393-1-parth@linux.ibm.com>
 <20190515135322.19393-3-parth@linux.ibm.com>
 <20190515163032.GU2589@hirez.programming.kicks-ass.net>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Thu, 16 May 2019 21:45:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20190515163032.GU2589@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19051616-0020-0000-0000-0000033D66A2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051616-0021-0000-0000-000021902F38
Message-Id: <fd7bd5e7-8d89-2c0b-1f3d-d229b7af5757@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-16_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905160103
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 5/15/19 10:00 PM, Peter Zijlstra wrote:
> On Wed, May 15, 2019 at 07:23:18PM +0530, Parth Shah wrote:
>> +void turbo_sched_get(void)
>> +{
>> +	spin_lock(&turbo_sched_lock);
>> +	if (!turbo_sched_count++)
>> +		static_branch_enable(&__turbo_sched_enabled);
>> +	spin_unlock(&turbo_sched_lock);
>> +}
> 
> Muwhahaha, you didn't test this code, did you?
> 

yeah, I didn't see task-sleep problem coming in.
I will change to mutex.

Thanks for pointing out.

