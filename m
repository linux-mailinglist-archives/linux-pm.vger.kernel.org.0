Return-Path: <linux-pm+bounces-21986-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5E3A3314C
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 22:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B460A3A1436
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 21:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9881D202C5B;
	Wed, 12 Feb 2025 21:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SUCthkxI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A170202C48;
	Wed, 12 Feb 2025 21:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739394572; cv=none; b=ciENBMpujCfLRodf3Af+0SCMTCshg4qRF08DWE7OXlLX7AtjPmfUP8DIWuFjk7/vot4umCwXdtP0R2keGy2NV9GCxnO3hxIdFmF2W0aFRpda8jna+sA/pJ3S0DJ9LwppQLZzizZS6aWHZGu+FrbfXfSS1WT51WsjsGXthkmbQ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739394572; c=relaxed/simple;
	bh=oF0JigHFH/l1ikPMQZhKR5mxc360qHhk0rGLIWZr3U8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b/H5gOk6ERPyh/1p2FZbDjaigNhKwkgTaA37AgK3HVOVEqOC2D/HbbL4Apx6tICxZPEQMNTWToKmyjT6F5F8lgqnDV43whQvRnIPhFkyxCInGH86IlH5BIN5EF7OC3J+TR1dG8fCgixiH6htyhmpS5sF9ewCyc+7IpN598Hwuv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SUCthkxI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CIVPWq025705;
	Wed, 12 Feb 2025 21:09:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3UXq15iJ8mRome0icL9hb5EkNcKpc5PO26ZwWTtBMRY=; b=SUCthkxIQU6G+e7Z
	oiWTcqHq66RtSYjZKX6aPar8CUfwBLszpOdhC0Ls4rJvz6x12aq4EAIoBi62HTbo
	NkEJUDJKNW7O6Yn4/Q5Dxb5NJSHMU37j+wbATWZqK2TuT5HfCBnwgc6iooPHGJbQ
	YcVkldu105WxlWhu4omgeCwDEi2ViikhXFCjm2b9X8udrT3dpC0hZUAz10RXcUaN
	SywsCGiT0GbqNfEBHrVJcettS8Y/bQc2QxPusYeSuRPFfsGBKVKlVapQP4msQnp3
	+rmnjTVamMfsaEF+V4X8P9zCx1fRb5hTFgPH8sri5SwAtmv1dTnhy0cTuc0esSX8
	DhB+RA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44r5j5cyu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 21:09:22 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51CL9Lcg030690
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 21:09:21 GMT
Received: from [10.216.26.102] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 12 Feb
 2025 13:09:18 -0800
Message-ID: <5bd75fc2-56e9-4e58-a18a-29afd07fe0df@quicinc.com>
Date: Thu, 13 Feb 2025 02:39:06 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] thermal: core: Fix race between zone registration and
 userspace sysfs access
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui
	<rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250211124421.27169-1-quic_manafm@quicinc.com>
 <CAJZ5v0j8WY4LdM-3AYr9nUO+z09jq2vAVnaW0rFP=RKAe7jTUA@mail.gmail.com>
From: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
In-Reply-To: <CAJZ5v0j8WY4LdM-3AYr9nUO+z09jq2vAVnaW0rFP=RKAe7jTUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wMUz0f9Rt5lSki0ELDMb0TOcVHRW01gW
X-Proofpoint-GUID: wMUz0f9Rt5lSki0ELDMb0TOcVHRW01gW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_06,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502120150


Hi Rafael,

Thank you for reviewing the patch.

On 2/13/2025 1:12 AM, Rafael J. Wysocki wrote:
> On Tue, Feb 11, 2025 at 1:45 PM Manaf Meethalavalappu Pallikunhi
> <quic_manafm@quicinc.com> wrote:
>> Currently, the thermal zone sysfs is created before setting the
>> governor for that thermal zone during registration. If a thermal
>> zone is being registered while a userspace module tries to access
>> the same thermal zone policy sysfs node, it can lead to a potential
>> NULL pointer dereference issue in the policy sysfs path.
>>
>> To avoid this race condition, set the thermal zone governor first
>> before enabling the thermal zone sysfs during registration.
>> This change fixes below issue,
>>
>> [ 20.964589]   Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
>> [ 21.049645]   pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
>> [ 21.049647]   pc : policy_show+0x1c/0x3c
>> [ 21.049652]   lr : dev_attr_show+0x38/0x7c
>> [ 21.049655]   sp : ffffffc09a98bbf0
>> [ 21.049657]   x29: ffffffc09a98bbf0 x28: ffffff885b940000 x27: 0000000000000000
>> [ 21.049660]   x26: 0000000000000000 x25: 000000007ffff001 x24: 0000000000000001
>> [ 21.049664]   x23: ffffffdca6334c78 x22: ffffff88a2b2fe00 x21: ffffff881cee8000
>> [ 21.049667]   x20: ffffff8868318018 x19: ffffffdca7640d78 x18: ffffffdca74d94c0
>> [ 21.049670]   x17: 00000000ae84bcd4 x16: 00000000ae84bcd4 x15: 000000002df29963
>> [ 21.049673]   x14: 00000000cbef29c7 x13: 000000004e61db0a x12: ffffff885b940be0
>> [ 21.049677]   x11: ffffff881cee8000 x10: 0000000000000000 x9 : ffffffdca59f00b8
>> [ 21.049680]   x8 : 0000000000000000 x7 : 0000000000000000 x6 : 000000000000003f
>> [ 21.049683]   x5 : 0000000000000040 x4 : 0000000000000000 x3 : 0000000000000004
>> [ 21.049686]   x2 : ffffff881cee8000 x1 : ffffffdca66e5bfb x0 : ffffff881cee8000
>> [ 21.049689]   Call trace:
>> [ 21.049690]    policy_show+0x1c/0x3c
>> [ 21.049692]    dev_attr_show+0x38/0x7c
>> [ 21.049695]    sysfs_kf_seq_show+0xd8/0x160
>> [ 21.049699]    kernfs_seq_show+0x44/0x54
>> [ 21.049701]    seq_read_iter+0x16c/0x4ec
>> [ 21.049705]    kernfs_fop_read_iter+0x64/0x1d8
>> [ 21.049709]    vfs_read+0x2d8/0x33c
>> [ 21.049711]    ksys_read+0x78/0xe8
>> [ 21.049714]    __arm64_sys_read+0x1c/0x2c
>> [ 21.049716]    invoke_syscall+0x58/0x10c
>> [ 21.049719]    el0_svc_common+0xa8/0xdc
>> [ 21.049722]    do_el0_svc+0x1c/0x28
>> [ 21.049724]    el0_svc+0x40/0x90
>> [ 21.049726]    el0t_64_sync_handler+0x70/0xbc
>> [ 21.049728]    el0t_64_sync+0x1a8/0x1ac
>> [ 21.049731]   Code: f9435008 aa0203e0 d00054e1 912fec21 (f9400108)
>>
>> Signed-off-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
>> ---
>>   drivers/thermal/thermal_core.c | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>> index 2328ac0d8561..c6e6b229cc6e 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -1589,6 +1589,11 @@ thermal_zone_device_register_with_trips(const char *type,
>>
>>          tz->state = TZ_STATE_FLAG_INIT;
>>
>> +       thermal_zone_device_init(tz);
>> +       result = thermal_zone_init_governor(tz);
>> +       if (result)
>> +               goto unregister;
>> +
>>          /* sys I/F */
>>          /* Add nodes that are always present via .groups */
>>          result = thermal_zone_create_device_groups(tz);
>> @@ -1600,19 +1605,14 @@ thermal_zone_device_register_with_trips(const char *type,
>>                  thermal_zone_destroy_device_groups(tz);
>>                  goto remove_id;
>>          }
>> -       thermal_zone_device_init(tz);
>>          result = device_register(&tz->device);
>>          if (result)
>>                  goto release_device;
>>
>> -       result = thermal_zone_init_governor(tz);
>> -       if (result)
>> -               goto unregister;
>> -
>>          if (!tz->tzp || !tz->tzp->no_hwmon) {
>>                  result = thermal_add_hwmon_sysfs(tz);
>>                  if (result)
>> -                       goto unregister;
>> +                       goto release_device;
>>          }
>>
>>          result = thermal_thresholds_init(tz);
>> @@ -1629,12 +1629,12 @@ thermal_zone_device_register_with_trips(const char *type,
>>
>>   remove_hwmon:
>>          thermal_remove_hwmon_sysfs(tz);
>> -unregister:
>> -       device_del(&tz->device);
>>   release_device:
>>          put_device(&tz->device);
>>   remove_id:
>>          ida_free(&thermal_tz_ida, id);
>> +unregister:
>> +       device_del(&tz->device);
>>   free_tzp:
>>          kfree(tz->tzp);
>>   free_tz:
>> --
> The catch is good, but the patch isn't AFAICS.  The changes in the
> error path don't look correct to me in particular.
I understood the issues in the error path. I’ll try to fix them in the 
v2 patch. Is there any concern with setting the governor before 
initializing sysfs ?
>
> I'd rather make the attached change, please let me know if it works for you.

Yes, It will work for current issue. But it could provide a incorrect 
policy information to userspace if a thermal zone is created with a 
governor other than the default one (def_governor), right ?

Thanks,

Manaf


