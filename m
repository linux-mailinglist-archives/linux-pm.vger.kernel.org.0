Return-Path: <linux-pm+bounces-36357-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF7EBE9545
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 16:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09218403271
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 14:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEE53328FA;
	Fri, 17 Oct 2025 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J9VrrRU/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2068B3328EB
	for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2025 14:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712472; cv=none; b=E7zykHE1MRWeZ6Oyzsufe4xy8ZG1SWTrDnqQ9Sq6f/0HD/MyQAgYTvx198DjSvhP8Kr/lWs0ul1Xa7EEt5HyVZXFXTkWLLwydMJsUp3Tyn5czG6fS6ifjpsaJC72ri8hQUYhNmcPnH+8ns1BnSbaTHoYbVCs4s5W8dRM2aB8rpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712472; c=relaxed/simple;
	bh=DiyVdXABTrVQ08Fd2LFM1CVCN+GGwKGDZECsTWV1E3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZeF6ossqBD6JmDogHEjZNjB0rPwKTORN9TZB5aAVklRC8TV256my78m3EPbgH36E1uZOEdA8AURZBXUyh/aR+r+LFVhoVE6rrp4Ci9bgXzXO3d6/ubtNtRYKkN8ipo99UQ/PaneGICkt8Vm0/TydyfiiZzgU7OdoXhC/XJN0JV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J9VrrRU/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H7g8uG020629
	for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2025 14:47:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QiH2J+dIVcecXrrAGCkcTfZdS4TOBQ+cjT9NDaaTuF0=; b=J9VrrRU/jdbJq9bO
	0EAk7acvt5zAn0ZR59QlF+A/Q6sJ6hGysgUBLOJNpFyYH5hoku1AQ7vdpigqUUKQ
	Rm+70vC4PnW2Wmddofi1eEZNooEf1eeffMljto/pEOdgZ3l5f5DYUuHBJ30s54eE
	Caf6AjtQO9quon4iMBrGB2J7+F+/9NlXMEAxoHn+rwaM8199FfxSTKqcfAZC9xGK
	iSxcDik/1ObWfEE1zbFpICVyLn3u4CGMRytMtYQ4Xg4nFUs16nLIo8enaDh1/aZG
	lr+n274IM3bv1A9bgfVy5Yf7YQnEnVfdPArXuAuCgGEcwIn9Nm7kD5ndBLjPNy9/
	q+7X9w==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49sua8u9ut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2025 14:47:48 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b55118e2d01so1420306a12.1
        for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2025 07:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760712468; x=1761317268;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QiH2J+dIVcecXrrAGCkcTfZdS4TOBQ+cjT9NDaaTuF0=;
        b=FLfplwQjYWcK1i/cQ2inecJLAc9wqCFaH+8sACcsgssZF5/D4iEVlQpRMPz+V+rRx7
         ZZnfi8u/ijV2/Qidqhjc7YQKILk2lB9Co8XY6s4BcWMjssA2gVigLfY78rPlCH5hkSnD
         nH48vL3JyEBghR/MlnGQ37S0FVlgc4LYekojgnyLEbHz2Xz31Bh8VRfY/LWgLlQnIs/c
         EZ3xMkwODsJvXDWcqEeriEdGJBIXsOeiIBe7enupEj63Xd5eOOgs6inPL01x9oWbecbr
         emQhF9L3/j3qdNG4Z0sd6y94fhbT5mFZrNKCSJEAEYf0Vt9qwoIZNk4z6uKffYP4zjdP
         VAOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhac/ck0QEGh4rsEkfwg0YgXCEusB2eQ4cW5T5OQIoWhnHmFTkT5XVAgcaWcc7NqDqoOOqYfUTRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxllTtdL6ubdR3crNsUkEtuZ4Bc+pY7rYQbbeFyn3/ISfDSeJV9
	hxF/YTSfHV7Zmsm6yMMrSm8su2srWLOPFFa/cbvb4ku+Bmfp4X5OzH4mH2c0/ut1bT5NBJeXxia
	PYsIZZiTnxDiYs0JaO/VoS7ay8LNrPzmyDKhNBJrVrNz81ihp+wVcBOdKED7rpA==
X-Gm-Gg: ASbGncuEWB+F5NI8C+KmksQHW+JIwzvBnGQjRIjPJWXGCVtg9ZaJ1devrdLVnDtJuee
	Z5a+AhgVh8Cv7QG6x/5Rp2vr5gC4BvrYqtycv8Ygebj3KumxWlcClVST5agb7xvxEkLnZBIvi9g
	dVg6VUmTQVUxw955j924g20WJju0eLIzF5Q5sKDjdd0r+4ruC/lliYh0Aw/t7fdGJMJ9/+No1NE
	Dm9lU8Yq+N8CMe+aNsGvhsadlHspFEgyuJ44aZfKKPHmvUQehgUTAsAkyx6vgXKkd+DAIVDAU48
	gwniBpOYqwbAQlRVp6gUqDmjYkPr1b5Tz/zTw+XhkvVVreQ/lQ+kMOMkKcXnsFNyHhv1a1kHYm5
	3RtILFlgRM0ShMWeNzpuY4YdQGzjio7OZ+Q==
X-Received: by 2002:a17:902:cf42:b0:269:ed31:6c50 with SMTP id d9443c01a7336-290c9c896b0mr41632825ad.10.1760712467541;
        Fri, 17 Oct 2025 07:47:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOjKbFTkJh0ezCxCdJ3kP6joxM9yMTBKLaFVhNRS3DcOSUHjMrOrZfMhR8o9cNnCg8mifCEA==
X-Received: by 2002:a17:902:cf42:b0:269:ed31:6c50 with SMTP id d9443c01a7336-290c9c896b0mr41632325ad.10.1760712467017;
        Fri, 17 Oct 2025 07:47:47 -0700 (PDT)
Received: from [10.216.52.245] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099388dbasm66275665ad.47.2025.10.17.07.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 07:47:46 -0700 (PDT)
Message-ID: <2c8e7d94-cacb-427f-02ec-ecc83a189479@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 20:17:33 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v16 01/14] power: reset: reboot-mode: Synchronize list
 traversal
Content-Language: en-US
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel
 <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik
 <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>
References: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
 <20251015-arm-psci-system_reset2-vendor-reboots-v16-1-b98aedaa23ee@oss.qualcomm.com>
 <CACMJSeu_Y2Rra8x22kWN0B38jKZEwq7=B9C75zH18QdjDHAWqg@mail.gmail.com>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <CACMJSeu_Y2Rra8x22kWN0B38jKZEwq7=B9C75zH18QdjDHAWqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: vXYi9JEPeW3U02-M1Uhcsk2bwQaaeOQm
X-Authority-Analysis: v=2.4 cv=e5MLiKp/ c=1 sm=1 tr=0 ts=68f25714 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=js1QHsEmXU4TG3GKDNEA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDEzNCBTYWx0ZWRfX6drai+LIxOgd
 sdPhmqNCffnOCGIHa4SgHETRaDuuIllQiX896Y+JNOsNDT71XD10+0M5jNcgU5QKHL0LuRKxfNa
 op26iVHt28XHht/HbtFWl3RDxRS8PZfDaVvPkPMHGKkTB9jnqv6JDLe7Wy4n9jcrJdWVsQLMLgj
 sQoHa+ftrhoM/e5MSHKnzyALO4GpARduaJmwsLAH8qd8qjEmaNomxa2nYCw41iz76zliHKHwclB
 7tLxD2+jeEqB+jLC1B0i0uWFQjZ1hd8Fb0oMY4iWpmGYC7aOFYiXx3+kv1qqN+TfyZFCoAarFI+
 CAYVJ20iLhF2hZmGnwYm/7ZLxGUZ8xLAVVxWbc5gmgC+Q2/VrmDeTOHUFdT6fT8yfmLAWPDd04M
 IzjurZxKSpiwLCJm6N44pXRGHGRRVA==
X-Proofpoint-ORIG-GUID: vXYi9JEPeW3U02-M1Uhcsk2bwQaaeOQm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510140134



On 10/15/2025 8:02 PM, Bartosz Golaszewski wrote:
> On Wed, 15 Oct 2025 at 06:38, Shivendra Pratap
> <shivendra.pratap@oss.qualcomm.com> wrote:
>>
>> List traversals must be synchronized to prevent race conditions
>> and data corruption. The reboot-mode list is not protected by a
>> lock currently, which can lead to concurrent access and race.
>>
>> Introduce a mutex lock to guard all operations on the reboot-mode
>> list and ensure thread-safe access. The change prevents unsafe
>> concurrent access on reboot-mode list.
>>
>> Fixes: 4fcd504edbf7 ("power: reset: add reboot mode driver")
>> Fixes: ca3d2ea52314 ("power: reset: reboot-mode: better compatibility with DT (replace ' ,/')")
>>
>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>> ---
>>  drivers/power/reset/reboot-mode.c | 96 +++++++++++++++++++++------------------
>>  include/linux/reboot-mode.h       |  4 ++
>>  2 files changed, 57 insertions(+), 43 deletions(-)
>>
>> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
>> index fba53f638da04655e756b5f8b7d2d666d1379535..8fc3e14638ea757c8dc3808c240ff569cbd74786 100644
>> --- a/drivers/power/reset/reboot-mode.c
>> +++ b/drivers/power/reset/reboot-mode.c
>> @@ -29,9 +29,11 @@ static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
>>         if (!cmd)
>>                 cmd = normal;
>>
>> -       list_for_each_entry(info, &reboot->head, list)
>> -               if (!strcmp(info->mode, cmd))
>> -                       return info->magic;
>> +       scoped_guard(mutex, &reboot->rb_lock) {
>> +               list_for_each_entry(info, &reboot->head, list)
>> +                       if (!strcmp(info->mode, cmd))
>> +                               return info->magic;
>> +       }
>>
>>         /* try to match again, replacing characters impossible in DT */
>>         if (strscpy(cmd_, cmd, sizeof(cmd_)) == -E2BIG)
>> @@ -41,9 +43,11 @@ static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
>>         strreplace(cmd_, ',', '-');
>>         strreplace(cmd_, '/', '-');
>>
>> -       list_for_each_entry(info, &reboot->head, list)
>> -               if (!strcmp(info->mode, cmd_))
>> -                       return info->magic;
>> +       scoped_guard(mutex, &reboot->rb_lock) {
>> +               list_for_each_entry(info, &reboot->head, list)
>> +                       if (!strcmp(info->mode, cmd_))
>> +                               return info->magic;
>> +       }
>>
>>         return 0;
>>  }
>> @@ -78,46 +82,50 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
>>
>>         INIT_LIST_HEAD(&reboot->head);
>>
>> -       for_each_property_of_node(np, prop) {
>> -               if (strncmp(prop->name, PREFIX, len))
>> -                       continue;
>> -
>> -               info = devm_kzalloc(reboot->dev, sizeof(*info), GFP_KERNEL);
>> -               if (!info) {
>> -                       ret = -ENOMEM;
>> -                       goto error;
>> -               }
>> -
>> -               if (of_property_read_u32(np, prop->name, &info->magic)) {
>> -                       dev_err(reboot->dev, "reboot mode %s without magic number\n",
>> -                               info->mode);
>> -                       devm_kfree(reboot->dev, info);
>> -                       continue;
>> -               }
>> -
>> -               info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
>> -               if (!info->mode) {
>> -                       ret =  -ENOMEM;
>> -                       goto error;
>> -               } else if (info->mode[0] == '\0') {
>> -                       kfree_const(info->mode);
>> -                       ret = -EINVAL;
>> -                       dev_err(reboot->dev, "invalid mode name(%s): too short!\n",
>> -                               prop->name);
>> -                       goto error;
>> +       mutex_init(&reboot->rb_lock);
>> +
>> +       scoped_guard(mutex, &reboot->rb_lock) {
>> +               for_each_property_of_node(np, prop) {
>> +                       if (strncmp(prop->name, PREFIX, len))
>> +                               continue;
>> +
>> +                       info = devm_kzalloc(reboot->dev, sizeof(*info), GFP_KERNEL);
>> +                       if (!info) {
>> +                               ret = -ENOMEM;
>> +                               goto error;
>> +                       }
>> +
>> +                       if (of_property_read_u32(np, prop->name, &info->magic)) {
>> +                               dev_err(reboot->dev, "reboot mode %s without magic number\n",
>> +                                       info->mode);
>> +                               devm_kfree(reboot->dev, info);
>> +                               continue;
>> +                       }
>> +
>> +                       info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
>> +                       if (!info->mode) {
>> +                               ret =  -ENOMEM;
>> +                               goto error;
>> +                       } else if (info->mode[0] == '\0') {
>> +                               kfree_const(info->mode);
>> +                               ret = -EINVAL;
>> +                               dev_err(reboot->dev, "invalid mode name(%s): too short!\n",
>> +                                       prop->name);
>> +                               goto error;
>> +                       }
>> +
>> +                       list_add_tail(&info->list, &reboot->head);
> 
> This seems to be the only call that actually needs synchronization.
> All of the above can be run outside the critical section.

sure. will add it only around the required lines.

> 
>>                 }
>>
>> -               list_add_tail(&info->list, &reboot->head);
>> -       }
>> -
>> -       reboot->reboot_notifier.notifier_call = reboot_mode_notify;
>> -       register_reboot_notifier(&reboot->reboot_notifier);
>> +               reboot->reboot_notifier.notifier_call = reboot_mode_notify;
>> +               register_reboot_notifier(&reboot->reboot_notifier);
>>
>> -       return 0;
>> +               return 0;
>>
>>  error:
>> -       list_for_each_entry(info, &reboot->head, list)
>> -               kfree_const(info->mode);
>> +               list_for_each_entry(info, &reboot->head, list)
>> +                       kfree_const(info->mode);
>> +       }
>>
>>         return ret;
>>  }
>> @@ -133,8 +141,10 @@ int reboot_mode_unregister(struct reboot_mode_driver *reboot)
>>
>>         unregister_reboot_notifier(&reboot->reboot_notifier);
>>
>> -       list_for_each_entry(info, &reboot->head, list)
>> -               kfree_const(info->mode);
>> +       scoped_guard(mutex, &reboot->rb_lock) {
>> +               list_for_each_entry(info, &reboot->head, list)
>> +                       kfree_const(info->mode);
>> +       }
> 
> Please destroy the mutex here.

sure thanks. will add destroy here.

thanks,
Shivendra

