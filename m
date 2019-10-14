Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A97B9D5F1A
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2019 11:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731044AbfJNJi5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Oct 2019 05:38:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63390 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730985AbfJNJi5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Oct 2019 05:38:57 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9E9bt50028711
        for <linux-pm@vger.kernel.org>; Mon, 14 Oct 2019 05:38:56 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vmkrm64hn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Mon, 14 Oct 2019 05:38:55 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <huntbag@linux.vnet.ibm.com>;
        Mon, 14 Oct 2019 10:38:53 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 14 Oct 2019 10:38:51 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9E9cock42139674
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Oct 2019 09:38:50 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18BAD4C058;
        Mon, 14 Oct 2019 09:38:50 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E3054C05C;
        Mon, 14 Oct 2019 09:38:49 +0000 (GMT)
Received: from oc0383214508.ibm.com (unknown [9.124.35.81])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Oct 2019 09:38:48 +0000 (GMT)
Subject: Re: [PATCH v2] cpupower : Handle set and info subcommands correctly
To:     shuah <shuah@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trenn@suse.com, ego@linux.vnet.ibm.com
References: <20190913080712.26383-1-huntbag@linux.vnet.ibm.com>
 <2614b112-5e19-96dc-179b-8d4e3b8c8858@kernel.org>
 <9f493ef7-8222-3e12-5068-41ea76e660a2@kernel.org>
From:   Abhishek <huntbag@linux.vnet.ibm.com>
Date:   Mon, 14 Oct 2019 15:08:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9f493ef7-8222-3e12-5068-41ea76e660a2@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19101409-4275-0000-0000-00000371DF97
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101409-4276-0000-0000-00003884EDCF
Message-Id: <b65b1063-941b-2838-4564-f6a6c40509c6@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910140092
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Shuah,


On 10/04/2019 03:45 AM, shuah wrote:
> Hi Abhishek,
>
> On 10/3/19 8:38 AM, shuah wrote:
>> On 9/13/19 2:07 AM, Abhishek Goel wrote:
>>> Cpupower tool has set and info options which are being used only by
>>> x86 machines. This patch removes support for these two subcommands
>>> from generic cpupower utility. Thus, these two subcommands will now be
>>> available only for intel.
>>> This removes the ambiguous error message while using set option in case
>>> of using non-intel systems.
>>>
>>> Without this patch on a non-intel box:
>>>
>>> root@ubuntu:~# cpupower info
>>> System does not support Intel's performance bias setting
>>>
>>> root@ubuntu:~# cpupower set -b 10
>>> Error setting perf-bias value on CPU
>>>
>>> With this patch on a non-intel box:
>>>
>>> root@ubuntu:~# cpupower info
>>> Supported commands are:
>>>          frequency-info
>>>          frequency-set
>>>          idle-info
>>>          idle-set
>>>          monitor
>>>          help
>>>
>>> Same result for set subcommand.
>>>
>>> This patch does not affect results on a intel box.
>>>
>>> Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
>>> Acked-by: Thomas Renninger <trenn@suse.de>
>>> ---
>>>
>>> changes from v1:
>>>     Instead of bailing out early in set and info commands, in V2, we
>>>     are cutting out support for these two commands for non-intel
>>>     systems.
>>
>> thanks. I will get this in for 5.4-rc3 veru likely. Definitely in 5.4
>>
>
> Okay I almost applied this and decided it needs improvements.
>
> I don't like using #if defined(__x86_64__) || defined(__i386__)
>
> tools/power/cpupower/utils/cpupower.c main() already does this
> dynamically using uname(). Please use the same logic do this,
> instead of adding compile time code.
>
> thanks,
> -- Shuah

Do you want the decision to be taken in cpupower-set and cpupower-info
file as was done in v1 but using uname() by identifying the architecture
there itself?

Thanks,
--Abhishek

