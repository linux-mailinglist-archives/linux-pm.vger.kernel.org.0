Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2F8B0CB7
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2019 12:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730742AbfILKT2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Sep 2019 06:19:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53938 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730268AbfILKT2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Sep 2019 06:19:28 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8CAI00e058411
        for <linux-pm@vger.kernel.org>; Thu, 12 Sep 2019 06:19:27 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uyj88mcgh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Thu, 12 Sep 2019 06:19:26 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <huntbag@linux.vnet.ibm.com>;
        Thu, 12 Sep 2019 11:19:25 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 12 Sep 2019 11:19:22 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8CAJLHG46072090
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Sep 2019 10:19:21 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 943334C040;
        Thu, 12 Sep 2019 10:19:21 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A677C4C058;
        Thu, 12 Sep 2019 10:19:20 +0000 (GMT)
Received: from oc0383214508.ibm.com (unknown [9.124.35.231])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Sep 2019 10:19:20 +0000 (GMT)
Subject: Re: [PATCH] cpupower : Handle set and info subcommands for powerpc
To:     Thomas Renninger <trenn@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        shuah@kernel.org, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
References: <20190911095424.49605-1-huntbag@linux.vnet.ibm.com>
 <12087195.kFesu4gPPu@skinner.arch.suse.de>
From:   Abhishek <huntbag@linux.vnet.ibm.com>
Date:   Thu, 12 Sep 2019 15:49:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <12087195.kFesu4gPPu@skinner.arch.suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19091210-0020-0000-0000-0000036B5F98
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091210-0021-0000-0000-000021C0F0BB
Message-Id: <754e96b7-19da-1a59-25bc-390afc9da00f@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-12_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909120109
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Thomas,

Thanks for the review.


On 09/12/2019 03:24 PM, Thomas Renninger wrote:
> Hi Abishek,
>
> On Wednesday, September 11, 2019 11:54:24 AM CEST Abhishek Goel wrote:
>> Cpupower tool has set and info options which are not being used by
>> POWER machines. For powerpc, we will return directly for these two
>> subcommands. This removes the ambiguous error message while using set
>> option in case of power systems.
>>
>> Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
>> ---
>>   tools/power/cpupower/utils/cpupower-info.c | 5 +++++
>>   tools/power/cpupower/utils/cpupower-set.c  | 5 +++++
>>   2 files changed, 10 insertions(+)
>>
>> diff --git a/tools/power/cpupower/utils/cpupower-info.c
>> b/tools/power/cpupower/utils/cpupower-info.c index
>> 4c9d342b70ff..674b707a76af 100644
>> --- a/tools/power/cpupower/utils/cpupower-info.c
>> +++ b/tools/power/cpupower/utils/cpupower-info.c
>> @@ -39,6 +39,11 @@ int cmd_info(int argc, char **argv)
>>   	} params = {};
>>   	int ret = 0;
>>
>> +	#ifdef __powerpc__
>> +	printf(_("Cannot read info as system does not support performance bias
>> setting\n")); +	return 0;
>> +	#endif
>> +
> Please do no do this.
>
> cpupower info
> is designed to show general information related to powersaving features of your CPU.
>
> For examle there has been (see changelog):
> cpupower: Remove mc and smt power aware scheduler info/settings
> These kernel interfaces got removed by:
>
> Unfortunately only -b (perf bias on Intel only) is left right now.
>
> So if you cut this out for Power you do not see anything and the cmd is useless.
> Which is a pity, but for now makes sense.
> Ideally you provide some tag/option which makes sense on power (e.g. whether run
> in OPAL mode and if provide some figures otherwise tell running in VM mode).
> But if this is cut out something like this should do the same and is more flexible:
> - Still allows additional cpupower info features for other CPUs later easily
> - Should also cover AMD or other non-perf bias supporting CPUs to exclude perf_bias
>    setting/info

As I have suggested in here : https://lkml.org/lkml/2019/9/12/159
We should cut out these two options as of now for other architecture
except x86, since the current implementation of both these subcommands
are very intel specific.
As you have already suggested, we can later on maybe change the
documentation of info to be architecture specific and use info based on
arch requirement.

>
> If this one works for you, can you please re-submit with also handling the set cmd
> similar. If it works or you only slightly adjust, feel free to already add:
> Acked-by: Thomas Renninger <trenn@suse.de>

Yeah. Sure.

> Thanks!
>
>         Thomas
>
> --- tools/power/cpupower/utils/cpupower-info.c.orig	2019-09-12 11:45:02.578568335 +0200
> +++ tools/power/cpupower/utils/cpupower-info.c	2019-09-12 11:46:09.618571947 +0200
> @@ -55,8 +55,11 @@
>   		}
>   	};
>
> -	if (!params.params)
> +	if (!params.params) {
>   		params.params = 0x7;
> +		if !(cpupower_cpu_info.caps & CPUPOWER_CAP_PERF_BIAS)
> +			params.perf_bias = 0;
> +	}
>
>   	/* Default is: show output of CPU 0 only */
>   	if (bitmask_isallclear(cpus_chosen))
>
>
>

-- Abhishek

