Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF119B0CC9
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2019 12:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbfILKXu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Sep 2019 06:23:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36574 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730268AbfILKXt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Sep 2019 06:23:49 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8CAMobJ105461
        for <linux-pm@vger.kernel.org>; Thu, 12 Sep 2019 06:23:48 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uyk7mtf4q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Thu, 12 Sep 2019 06:23:48 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <huntbag@linux.vnet.ibm.com>;
        Thu, 12 Sep 2019 11:23:46 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 12 Sep 2019 11:23:44 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8CANhoC47120638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Sep 2019 10:23:43 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6C634C04A;
        Thu, 12 Sep 2019 10:23:43 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD6014C044;
        Thu, 12 Sep 2019 10:23:42 +0000 (GMT)
Received: from oc0383214508.ibm.com (unknown [9.124.35.231])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Sep 2019 10:23:42 +0000 (GMT)
Subject: Re: [PATCH] cpupower : Handle set and info subcommands for powerpc
To:     Thomas Renninger <trenn@suse.de>
Cc:     shuah <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
References: <20190911095424.49605-1-huntbag@linux.vnet.ibm.com>
 <3326dc53-f8a1-dd7b-5ae8-b86ef5ef8b24@kernel.org>
 <f43715dd-219b-d3ae-58a9-f343fe745d7d@linux.vnet.ibm.com>
 <4161437.KdBApSEpf3@skinner.arch.suse.de>
From:   Abhishek <huntbag@linux.vnet.ibm.com>
Date:   Thu, 12 Sep 2019 15:53:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4161437.KdBApSEpf3@skinner.arch.suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19091210-4275-0000-0000-00000364D45F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091210-4276-0000-0000-000038772EBD
Message-Id: <17ce06dd-9baf-e0d1-df64-4b81787b2000@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-12_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909120110
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,


On 09/12/2019 03:46 PM, Thomas Renninger wrote:
> On Thursday, September 12, 2019 11:43:40 AM CEST Abhishek wrote:
>> Hi Shuah,
>>
>> Thanks for the review. Few comments below.
> ...
>
>> Since these two options are not being used by any other architecture
>> except x86, I suggest these options should not even be shown for
>> other architecture. So we can do something like this in cpupower.c :
>>
>> static struct cmd_struct commands[] = {
>>            .............
>> +#if defined (__x86_64__) || defined (__i386__)
>>           { "set",        cmd_set,        1    },
>>           { "info",        cmd_info,        0    },
>> +#endif
>>           ..............
>>
>> Is this Okay?
> No, I expected you to add something meaningful for Power case...

Haha. Will add something meaningful later...
(One of the suggestion has already been given by you)
>
> Just kidding. If this works without any side-effects in not x86 case, this
> approach seem to be the best solution for now.
>
> Thanks.
>
>    Thomas
>
>

-- Abhishek

