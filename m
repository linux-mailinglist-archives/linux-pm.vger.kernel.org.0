Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B881D0662
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 07:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgEMFbk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 01:31:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8378 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726168AbgEMFbk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 01:31:40 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04D5VWkC002555;
        Wed, 13 May 2020 01:31:32 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3101m6wg7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 May 2020 01:31:32 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04D542WA123007;
        Wed, 13 May 2020 01:31:10 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3101m6wg6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 May 2020 01:31:10 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04D5UAkJ024935;
        Wed, 13 May 2020 05:31:08 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3100ub0vej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 May 2020 05:31:08 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04D5V5Og5308918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 May 2020 05:31:05 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 468CCA405E;
        Wed, 13 May 2020 05:31:05 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D702A4051;
        Wed, 13 May 2020 05:31:03 +0000 (GMT)
Received: from [9.85.80.172] (unknown [9.85.80.172])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 May 2020 05:31:03 +0000 (GMT)
Subject: Re: [RFC 1/1] Weighted approach to gather and use history in TEO
 governor
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael.j.wysocki@intel.com, dsmythies@telus.net,
        daniel.lezcano@linaro.org, ego@linux.vnet.ibm.com,
        svaidy@linux.ibm.com, pratik.sampat@in.ibm.com,
        pratik.r.sampat@gmail.com
References: <20200511141055.43029-1-psampat@linux.ibm.com>
 <20200511141055.43029-2-psampat@linux.ibm.com>
 <20200512173722.GM2978@hirez.programming.kicks-ass.net>
From:   Pratik Sampat <psampat@linux.ibm.com>
Message-ID: <09b8bf40-e371-e1eb-d77e-6c676f22dd29@linux.ibm.com>
Date:   Wed, 13 May 2020 11:01:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200512173722.GM2978@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-13_01:2020-05-11,2020-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 spamscore=0 cotscore=-2147483648
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005130046
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thanks for your comment.


On 12/05/20 11:07 pm, Peter Zijlstra wrote:
> Just a quick note..
>
> On Mon, May 11, 2020 at 07:40:55PM +0530, Pratik Rajesh Sampat wrote:
>
>> +	/*
>> +	 * Rearrange the weight distribution of the state, increase the weight
>> +	 * by the LEARNING RATE % for the idle state that was supposed to be
>> +	 * chosen and reduce by the same amount for rest of the states
>> +	 *
>> +	 * If the weights are greater than (100 - LEARNING_RATE) % or lesser
>> +	 * than LEARNING_RATE %, do not increase or decrease the confidence
>> +	 * respectively
>> +	 */
>> +	for (i = 0; i < drv->state_count; i++) {
>> +		unsigned int delta;
>> +
>> +		if (idx == -1)
>> +			break;
>> +		if (i ==  idx) {
>> +			delta = (LEARNING_RATE * cpu_data->state_mat[last_idx][i]) / 100;
> 100 is a crap number to divide by as a computer. We bio-puddings happend
> to have 10 digits, so 100 makes sense to us, but it does not to our
> binary friends.
>
>
Absolutely! I just wrote the code exactly the way I did the Math on paper,
definitely need to figure out an optimal way of doing things.

~Pratik

