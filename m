Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AD61D3532
	for <lists+linux-pm@lfdr.de>; Thu, 14 May 2020 17:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgENPf4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 May 2020 11:35:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64534 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726117AbgENPf4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 May 2020 11:35:56 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04EFWcfO134212;
        Thu, 14 May 2020 11:35:48 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 310v92ywww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 11:35:47 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04EFWpfh135593;
        Thu, 14 May 2020 11:35:47 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 310v92ywv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 11:35:47 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04EFYjkt025388;
        Thu, 14 May 2020 15:35:43 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 3100ub1k6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 15:35:43 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04EFZeog64225342
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 May 2020 15:35:40 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C02EA4064;
        Thu, 14 May 2020 15:35:40 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 749B0A4054;
        Thu, 14 May 2020 15:35:38 +0000 (GMT)
Received: from [9.85.86.4] (unknown [9.85.86.4])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 May 2020 15:35:38 +0000 (GMT)
Subject: Re: [RFC 1/1] Weighted approach to gather and use history in TEO
 governor
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Doug Smythies <dsmythies@telus.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
        pratik.sampat@in.ibm.com, pratik.r.sampat@gmail.com
References: <20200511141055.43029-1-psampat@linux.ibm.com>
 <20200511141055.43029-2-psampat@linux.ibm.com>
 <20200512173722.GM2978@hirez.programming.kicks-ass.net>
 <09b8bf40-e371-e1eb-d77e-6c676f22dd29@linux.ibm.com>
 <CAJZ5v0jOGRQv1EUEhkba30OKuS8aupdoGConKJH9C=R6DxptFA@mail.gmail.com>
From:   Pratik Sampat <psampat@linux.ibm.com>
Message-ID: <47e3d97d-7dd3-85f5-d790-42b95760c64e@linux.ibm.com>
Date:   Thu, 14 May 2020 21:05:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jOGRQv1EUEhkba30OKuS8aupdoGConKJH9C=R6DxptFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_05:2020-05-14,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 cotscore=-2147483648
 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005140133
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 13/05/20 8:19 pm, Rafael J. Wysocki wrote:
> On Wed, May 13, 2020 at 7:31 AM Pratik Sampat <psampat@linux.ibm.com> wrote:
>> Thanks for your comment.
>>
>>
>> On 12/05/20 11:07 pm, Peter Zijlstra wrote:
>>> Just a quick note..
>>>
>>> On Mon, May 11, 2020 at 07:40:55PM +0530, Pratik Rajesh Sampat wrote:
>>>
>>>> +    /*
>>>> +     * Rearrange the weight distribution of the state, increase the weight
>>>> +     * by the LEARNING RATE % for the idle state that was supposed to be
>>>> +     * chosen and reduce by the same amount for rest of the states
>>>> +     *
>>>> +     * If the weights are greater than (100 - LEARNING_RATE) % or lesser
>>>> +     * than LEARNING_RATE %, do not increase or decrease the confidence
>>>> +     * respectively
>>>> +     */
>>>> +    for (i = 0; i < drv->state_count; i++) {
>>>> +            unsigned int delta;
>>>> +
>>>> +            if (idx == -1)
>>>> +                    break;
>>>> +            if (i ==  idx) {
>>>> +                    delta = (LEARNING_RATE * cpu_data->state_mat[last_idx][i]) / 100;
>>> 100 is a crap number to divide by as a computer. We bio-puddings happend
>>> to have 10 digits, so 100 makes sense to us, but it does not to our
>>> binary friends.
>>>
>>>
>> Absolutely! I just wrote the code exactly the way I did the Math on paper,
>> definitely need to figure out an optimal way of doing things.
> There is no particular reason to use percent in computations at all.
> You may as well use 1/1024 parts instead (and then use shifts instead
> of divisions).

Yes you're right. Looking at it now the whole percent system and divisions
does seem quite unnecessary and we can achieve it rather with bitwise
operations.

Thanks!

