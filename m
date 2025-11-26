Return-Path: <linux-pm+bounces-38733-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B1EC8B218
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 18:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93D043B5035
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 17:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC57E31D364;
	Wed, 26 Nov 2025 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IWjTbkgy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fv29vcsx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC0833CE89
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 17:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764176716; cv=none; b=TItnOYfttnGvDg5qi5s5wxeCALoRuxLdWH46s/Wsohta092pFiGoFR4L2tKdPUTpiIwJx0PudL5TPDYXxDnhfmtJ4nycD1YedUjJGJz9vXQh2de8lONwkbfjeKAyz5OdzFP632shoCvupCNAMxuwold4C/WiG4/oUg18dX7220Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764176716; c=relaxed/simple;
	bh=IBJIyCGos+Df5v2QF9ELzxIsygjlK7zQK9zsEMYIOSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gVYkzcc4yerPDWOeQnf42uPT8mj9aJ2wHRS/ZgqnfyobsuU0wEdbRPSkxkUdl71T/mAt8LA3kgkKFmNVPtD49u3QDLRRLzS5nUGSsp0iOCfU/9SOJDt9NUKvAw5vtDnIG9dhgYdyNKHMdll7jiLDRQ4Lt/sxAW4S2YGI3KWAP4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IWjTbkgy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fv29vcsx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AQBNXcQ1849220
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 17:05:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QryErQwyuR3L+zgYIAijcUhN4Vw58XDmRjXoajIzf28=; b=IWjTbkgyS2JGpM8G
	1fvLxTYmJd+9XsG38c0YEdFpUQ3FxN8qoAI9C9OgHu8j+6ztprmKVsfcXPbiDn+z
	qazFJBFSopbMk73JhxXN+ST5DGpMQAwiLolkj0eVuC4wfgNZZpBGu02DKK4K2gSJ
	Zrsp2JvMDyDK3bHGTgLEJkxG6OoLZWM1tyio7PibvAlwDyiBOz86jf3iqfAQn9fU
	31AmKLPTRsi80Y0tgIuWEW4OnHp3zir0RTf6hMjSFTEuAeK8ZZZKkhL5Ha+wzKl9
	gpr1aKASKGSJGmw7CH8U8DZchWzL1QCrGTuNBCRKophnij+vb5j5ccah7nOhTST5
	MWY/xA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ap0msry93-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 17:05:14 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-297e66542afso229539875ad.3
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 09:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764176713; x=1764781513; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QryErQwyuR3L+zgYIAijcUhN4Vw58XDmRjXoajIzf28=;
        b=fv29vcsxJdcAB9+6cgbvYNS0lNzRobx8gYvre3T2FBIxcKys6TalEIq6/+QAWabs6A
         KRoh7i4BExXCD64Uta4PY1M79bdwzM0gW822XRsEcVXWXE40p0ZIRPvCwBhW0aXxE6GB
         wpBxktZ3W1J0GCT6NRzNA8yTURiAb8l5jlDIdm5K0lVezPeH4WrKCMnWnYtQTJqp3rNd
         OGGSPPDz7Egdsif8uLqiWmEVrmRiiJT0NlrWHhFsDWOWNHK103n4OTocqYv90uu6FdGQ
         Cw1DQueZExgZgSG894HrueFy//y+8MCKv8iZQc+iTYf48GByWYpKaZzAr7nDOt3Lbthc
         gEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764176713; x=1764781513;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QryErQwyuR3L+zgYIAijcUhN4Vw58XDmRjXoajIzf28=;
        b=eNE4FFsSZ5xW3VlAkCMYb0CgZOabumx+FnkHmS4TsimJ4ogPqmttpydy7zi/GL0HRF
         E4zfHSJMC7kzcv9X3s24NebfIk0m3NOFvCp6dInqFCMaPrTH7m4JLE1TnBNj62FtDnWO
         a6FBLsf3bkacqcJA8Q3vkrlHXiDk4kIeNjlRj95C7flf1fjq3t7pYvNTzHlecxRtQDh0
         H+q1qluGrEJAM2CGN8mWLMIZWfPEEYGYGFuwcoHN/Oi/I9Jn0aLpxqiCLmCVYg6lejl3
         grF5LWOSZNmKzZPEIwUugZwbvf2bYjq3FsfkoAmEzhjtIXilnNYaroyeghlhtSTM4y95
         JiwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyBGjlwNIrF9Spo2q+iasfhKO+88ZjYz/NBmvfNmlZ+HU12TfpOOQiZgHeZ4yQM47xKVh7SD+96g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3tnIU7jiBd+BoLkRoSWgVHhFIIB5eVQyLbzgVl9MtYekng3GC
	D2NaXpR7u+SR3nMws3On/q6/UKQ4fUzH4m1ks6Zx0aqKa96T/Of6aCH6Ogilc8EFkl5SQk1HhPz
	2eOjfg+VfV/tTrQcclPr+BvCy1eKqQk7lPl+QBc4SUYgM6nKThnmDibugr4Xm6w==
X-Gm-Gg: ASbGnctqFjqNsyLbk+//jnrhlNM3ztxfeFuLvaO2frhaPfNGE7AqEpodIYhxhfSB3qz
	eWeGckTyeg77K/T/S2CYViQmD8bhy94yyKWCi2dJ5rgE3WJ4pSAbI3a9jv1E/tt/KQoJ5rZWM7L
	FMqMPxZMuRBerTYlaX7j4/8U1HNwP5LuEyCkWmw8e5ptMZApOnj+0P38IjeVQyh6/nNf4I791+V
	6DI8+4DW2R+Xgx0V2RYYeXh6RxNmb0VawEFCdIsFdpJTYE3dBiWj9cKUtTcpJIndbZfg8j95Dkz
	y4/8ZNd1bQtcDW0GneTgJ20+e2QOPUYqCRDCXxN/t3lpo10jH5/wc+7Iemi8oTw+ufe6k/9Ua+q
	e48UwecGTJHaWc7qHOh131LFQzxzk5KyoHsxgrx5I6fY=
X-Received: by 2002:a17:902:e950:b0:295:ed0:f7bf with SMTP id d9443c01a7336-29bab1e47f5mr84626535ad.58.1764176713418;
        Wed, 26 Nov 2025 09:05:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUQrY36O8LKohiysR7lCMjX4h2Y3t9x93Pa/HJTHoIlnYg80C9KIw1s456QFTdB0W4TqJ1bQ==
X-Received: by 2002:a17:902:e950:b0:295:ed0:f7bf with SMTP id d9443c01a7336-29bab1e47f5mr84625795ad.58.1764176712571;
        Wed, 26 Nov 2025 09:05:12 -0800 (PST)
Received: from [10.216.6.208] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b29b37fsm200792405ad.79.2025.11.26.09.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 09:05:12 -0800 (PST)
Message-ID: <164ae7a4-37b4-c8c4-3457-905c6bde52e1@oss.qualcomm.com>
Date: Wed, 26 Nov 2025 22:35:07 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v19 2/2] power: reset: reboot-mode: Expose sysfs for
 registered reboot_modes
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
References: <20251122-next-15nov_expose_sysfs-v19-0-4d3d578ad9ee@oss.qualcomm.com>
 <20251122-next-15nov_expose_sysfs-v19-2-4d3d578ad9ee@oss.qualcomm.com>
 <CAMRc=Me=F5gTmkfO+2_3_pqebsz9GvabCK+xv6bfQeGgkSs6Dw@mail.gmail.com>
 <dda61a49-90b1-ef48-5a46-d6953cd5375a@oss.qualcomm.com>
 <CAMRc=McgiuD1D+WqmO9x2G8devztrLy6uLwxjFpxJ+LbKx2YJg@mail.gmail.com>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <CAMRc=McgiuD1D+WqmO9x2G8devztrLy6uLwxjFpxJ+LbKx2YJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: IvyknIH_-0PS-dUpHqDVXs1ON79EpcId
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDEzOSBTYWx0ZWRfX0n0LHImCqma1
 UoEV5FcsfbJZ8aH7kAiWgZYx+NxSRAIhDpjRCXs0EEcyujgGTFSd8VphN7D5DCyM4G5fJ5TBvFd
 ANJZlqLlM7qbu+JF/wrxxYl30I8dsdaYb3jOtOd84zdjm3wj+IqsyAlfQ0zUMegePDG8VCRHUHN
 YZbvACNvgUKw0D0Wr7IKoSuPaw4Fx5gZT4eQJri7Glk//qsR0JnjZaXEuXrc3looOD5yb/o5Rwj
 iCvd5F8RM8iI9oV7Qve6vXJyF82VMuCJiSM6Wv8K2YPoZR8TJmI7DV39XN8Qs+OMXQ+FrUWvnt6
 LZqQgSujdLbRFLssDIfcfm74S947xqPEKNh5WR5tTDSfcaIFxNjIq4R0B5JAr+oVtN0ETmJ13Gt
 YVVs28ScZpXCtWrX1/RT4zvYm+rH3Q==
X-Authority-Analysis: v=2.4 cv=N5Qk1m9B c=1 sm=1 tr=0 ts=6927334a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=dyCLUdSM9kKjni6Dxd0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: IvyknIH_-0PS-dUpHqDVXs1ON79EpcId
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511260139



On 11/26/2025 10:26 PM, Bartosz Golaszewski wrote:
> On Wed, Nov 26, 2025 at 5:48 PM Shivendra Pratap
> <shivendra.pratap@oss.qualcomm.com> wrote:
>>
>>>>
>>>> +static bool reboot_mode_class_registered;
>>>
>>> You don't need this, please see below.
>>
>> reboot_mode_class_registered was used for two reason.
>> one is resolved: will directly call class_unregister.
>>
>> for second : If class_register fails, we want don't call register device
>> in reboot_mode_register.
>>
>> at -
>>         if (reboot_mode_class_registered)
>>                 reboot_mode_register_device(reboot);
>>
> 
> I'd just error out of the initcall if registering the class fails.
> It's very unlikely anyway and points to a bigger problem.

sure. thanks. will update this.

> 
>>>> +
>>>> +static void reboot_mode_register_device(struct reboot_mode_driver *reboot)
>>>> +{
>>>> +    reboot->reboot_mode_device.class = &reboot_mode_class;
>>>> +    reboot->reboot_mode_device.release = reboot_mode_device_release;
>>>> +    dev_set_name(&reboot->reboot_mode_device, reboot->driver_name);
>>>> +    if (!device_register(&reboot->reboot_mode_device))
>>>> +            reboot->reboot_mode_device_registered = true;
>>>> +    else
>>>> +            reboot->reboot_mode_device_registered = false;
>>>
>>> Just use device_create(). I would also suggest creating a private structure
>>> that embeds the pointer to the struct device created by device_create() and
>>> the pointer to the reboot_mode_driver. If you pass it as driver data to
>>> device_create(), you'll be able to retrieve it with dev_get_drvdata() in
>>> sysfs callbacks.
>>
>> Had made change to use device_create and dev_get_drvdata in below change, and have then
>> changed it to above as per the reviews on the same.
>> https://lore.kernel.org/all/qhlxxfsyc42xemerhi36myvil3bf45isgmpugkuqzsvgcc3ifn@njrtwuooij2q/
>>
>> Should we change to device_create?
>>
> 
> Ah, I missed that part. My preference is for device_create() as IMO it
> results in much more elegant code (especially if we don't end up
> extending the public struct) and memory is cheap but I'll let Bjorn
> decide.
> 
> Bart

