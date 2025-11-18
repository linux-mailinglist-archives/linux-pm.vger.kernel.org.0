Return-Path: <linux-pm+bounces-38188-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 014ADC6AAE0
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 17:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id C743D2BFA4
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 16:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7D0288C30;
	Tue, 18 Nov 2025 16:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ywfue2ZH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YGq31A9O"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B620299931
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763483881; cv=none; b=I3Dv9mPM7MZ86HFilKVAv6s1I6GkpTUIIiv8sUFdaQxaym8jo05vBhcOv/LjuJasofj/fDHgFg9HK/m9leEXmNI1TZMyCaj85I3oQbHJGEZqMcy7WqjzNRT6sJKmvrPrS3NvS+EvMkPNgRXgHbmqBfm3upQ+2Y6+ga8hjuJMt74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763483881; c=relaxed/simple;
	bh=9z6UDj3Z4u9IkEFmwAObbZQ4q/1Vm9o0OtzGMIAFU50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sHkl+M9osO8FB39F+Thde/7dr9EnX++NhuQglu5BI9hTNDNdaa9TVcBBRg+UajUQ+PSj1U6YOpfajxvASDKn9nsOwGfL1iUmYV38n0BwN9xJ0Q4pnR7gCQshHHge7oLr1K0S91WCH7B2g9NDnrZ3SXo6R8BelAS9W9UPaUvNymY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ywfue2ZH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YGq31A9O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AIG8RJM2249853
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 16:37:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	278xTvQ9syatu6wSSEkZOerhlZ4K3Pm6rv6SVO8Wcyg=; b=Ywfue2ZHTOykmMzL
	/mOP0KFOoVZHwxh2O48aDfHQvzYrcnWhM1mIRpWz3IupEDHqPbrUwXhQs3HrsUq+
	PZ8HPYmVgpP+LumogGyiOjkU9EPz6+3LwZVeDDzjcp/95JKjuZ62ltTqACz4+QD9
	XWCi7pAHOw5fX8y/n+mdjCCUqqnYpKlHqFq3wal7/R0yNTBkeZgMWeTWxJpamLLC
	Yc5aTKk8uTa3l3RjTntaIbYAeBPGO8Bxe4zEFQ7/zYS2jSg/Z/k7j5M2MiHVtHL4
	iz3dE7rMtbuoDWbBWyNyMvd1Fp1cfO44M2D3zwZT+1hq1nxETS2Ac7sJ4KJKjHu0
	eSqSfA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agnc5hdmd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 16:37:58 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-297e5a18652so67106695ad.1
        for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 08:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763483878; x=1764088678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=278xTvQ9syatu6wSSEkZOerhlZ4K3Pm6rv6SVO8Wcyg=;
        b=YGq31A9Okk2dYKup2Vkw5ukjITjMJZgN7pd4buVwX27HSSk9tMrYcYaY62qWjgvA2o
         q1ljJ65/mDk+EkMlQjE/5GwqCcDh86dejSW4iloOSDx36LpEZv1G3nC9Vtp18I9y0+2M
         P4Lpvh+rki5G7SmL+3yyuabgRkqO2RDsz9qmB+E5MBs5aulgwmllZr9ePOL5qfAa97rs
         r+BNaPe2PV4vDSx1SE1sdTllHSxlZKKy7U88pZvhdWDlzjz0dgZN2RQr6d9/CWu/sUdN
         gVcTz7NtsDrFf+nDh+03toS3C+Oo6tflEqiYp0kaWjn0GC0lU0atpDQA11gS8KNFgoq5
         /RSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763483878; x=1764088678;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=278xTvQ9syatu6wSSEkZOerhlZ4K3Pm6rv6SVO8Wcyg=;
        b=JHvXFV+2tP0U1fq9WP8JIlF+tNEEYvAoWFwhlSGMcECSFyGLXMqANqR1C5d4R1YGZS
         mlqxyjQX3Trp/LtYt/rh77qRmDeMTI/pvvlRJLg1ZyCqqF9w54iw3+8Wf6oJ0Zes5cvM
         OQmTGIZ91VmGYIvXtSwXftJ/qgv5ikDi9qH8QdTsyoOf6Yjw0UAWC5k/LTGsYMx0i0Ec
         03hzTQBnDh9eWa4S74Kav/hqD5moFwAqB14OnXcCEU65F+hLEeOwkTFiZiHKc0kjgfpj
         KtCkhAYqTHCoz28yTdU0nPP5jGEtXFNYMlG9r6cSSAPpCbX8IiK0Rlxmr7fcCnerCzDV
         X6CA==
X-Forwarded-Encrypted: i=1; AJvYcCXa6O4a6zlA3QTy/6Za3ESGmNLTGjyPp+iiHxm7T0WLB1VBly0QIbGbX4MTrnNwCcZ5Un66gxIwag==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt9J/qaHOikQ5BcOc7AAXgSyYyWn9944f3sHb0Zx19xsS+jYDG
	nbYSJig03nuKyDHQEcl0WatVbUwAZEzW2X+LtaGguolKcoX9PaZwHds3mzts0Ieg+0rV7jfspyp
	PBYzpYkDgvHkchEph3rMcgWsrD4enBqs/MUhoh+O3FLUQyuJrBp7yyhrQF50ogw/KyzqWFA==
X-Gm-Gg: ASbGncvWRNeq66g6vjWFaDzozhvgn8Ed6inKn/zx9ohNQsGOls4MIJPcmLfawlq35n5
	Gq+0QPjTaFXjDQR56z9G3GwqfAGd1aMckNfHh5VQcICrVK7xHftexkU5HH1KJaGxABgEPBnOOjp
	6KziWC93ouVEexhYHT5cI2jNdmILWmQRPZEoDOWEZnyNgwJVvQ7G4OxCUZqmW07jKzahVka8btp
	oB3wgwsmEQFI6sqSSpLHXyiitR/It0W4qlXeXHgJXIkOCJowaHtwdK2ZKZFFWXCxs6sQeGQBw6M
	SZ3B8jTUCEI1MQJRwshB3V8LYbj8maDuAjH9sOC7DscI4tAVdWP7oVJnpzJ2Xot9xSFGT255zzL
	7TcJOJYBqa5hSpYgBcEQg6ljrgvwc+D6m
X-Received: by 2002:a17:902:ecc7:b0:297:db6a:a82f with SMTP id d9443c01a7336-2986a6d27fcmr203916315ad.24.1763483877549;
        Tue, 18 Nov 2025 08:37:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGX+dqalZw5scjIY2OZzWPdI4dUmh/GJzWXJj0tvsX4qtpbMtnfJQvlgdxTs46Rutsfja2jNA==
X-Received: by 2002:a17:902:ecc7:b0:297:db6a:a82f with SMTP id d9443c01a7336-2986a6d27fcmr203915945ad.24.1763483877014;
        Tue, 18 Nov 2025 08:37:57 -0800 (PST)
Received: from [10.216.27.76] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3456513f0eesm13780137a91.7.2025.11.18.08.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 08:37:56 -0800 (PST)
Message-ID: <1ddb483e-3c09-ff45-9d36-cf29a40ba55d@oss.qualcomm.com>
Date: Tue, 18 Nov 2025 22:07:51 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/2] Documentation: ABI: Add
 sysfs-class-reboot-mode-reboot_modes
Content-Language: en-US
To: Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20251116-next-15nov_expose_sysfs-v1-0-3b7880e5b40e@oss.qualcomm.com>
 <20251116-next-15nov_expose_sysfs-v1-1-3b7880e5b40e@oss.qualcomm.com>
 <t3hfhlp27numfxurtmtcwrovvlgwdvnujain46kwmi37zehdak@xt3vngtkxpsm>
 <virjbkkpdmufx2midadzwiml4boyuxtokikcvupswapwehnv65@d2ppyiaeti22>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <virjbkkpdmufx2midadzwiml4boyuxtokikcvupswapwehnv65@d2ppyiaeti22>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 6U8mnPN6FZsm2VacRuK7Iu1FmqffHEyz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDEzNCBTYWx0ZWRfX4KbTLjuyPkyp
 1sXCbGKUySpJil+JAnRta0y92GXe0GFf8OHauG0P/DjH7TELX3KZ0qKcckY97YCfGtuDpinqdjw
 K125roW0vVD+47sbQU7IGlxzpsvhEpsZqUIiJKBbv2NSCrcn0xgHrbK1shTJden0vg6CPwZCvpX
 /B4yOAWMOiyO6tBeegV0H8sORujzKapMzd+BiN6N4/e8Gnnzl8Bcrw+YQyzuzufe1dOslXpn/pl
 1/jSC6/aFqQ8yfgQ1nyPcvFzT88XbK63PqMBOVyxuTHAnuEzucbi6jI7pHVZAFp8efZQMS2jfIs
 5MA5KdZbLKdr9B9DTO1soQyZOFBdQ49l+RDs1KiTgmbd2mF8lwQRZkKjF9CDzcG1E9+36qgKhM3
 odjBis+2VgJ2yTb2ryk31Yw4RsjwxA==
X-Authority-Analysis: v=2.4 cv=BYTVE7t2 c=1 sm=1 tr=0 ts=691ca0e6 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=GhQEx97vAAAA:20 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=IGWLzMHgmMv8I4HHU2kA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=AbAUZ8qAyYyZVLSsDulk:22 a=bA3UWDv6hWIuX7UZL3qL:22
 a=yULaImgL6KKpOYXvFmjq:22
X-Proofpoint-ORIG-GUID: 6U8mnPN6FZsm2VacRuK7Iu1FmqffHEyz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-18_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511180134



On 11/18/2025 2:18 AM, Bjorn Andersson wrote:
> On Sun, Nov 16, 2025 at 07:44:24PM +0200, Dmitry Baryshkov wrote:
>> On Sun, Nov 16, 2025 at 08:49:47PM +0530, Shivendra Pratap wrote:
>>> Add ABI documentation for /sys/class/reboot-mode/*/reboot_modes, a
>>> read-only sysfs attribute exposing the list of supported reboot-mode
>>> arguments. This file is created by reboot-mode framework and provides a
>>> user-readable interface to query available reboot-mode arguments.
>>>
>>> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>>> ---
>>>  .../testing/sysfs-class-reboot-mode-reboot_modes   | 39 ++++++++++++++++++++++
>>>  1 file changed, 39 insertions(+)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes b/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes
>>> new file mode 100644
>>> index 0000000000000000000000000000000000000000..28280ffe9bf962ef9d2136ea5d7c6aef77c4bd34
>>> --- /dev/null
>>> +++ b/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes
>>> @@ -0,0 +1,39 @@
>>> +What:		/sys/class/reboot-mode/<driver>/reboot_modes
>>> +Date:		November 2025
>>> +KernelVersion:	6.18.0-rc5
>>> +Contact:	linux-pm@vger.kernel.org
>>> +		Description:
>>> +		This interface exposes the reboot-mode arguments
>>> +		registered with the reboot-mode framework. It is
>>> +		a read-only interface and provides a space
>>> +		separated list of reboot-mode arguments supported
>>> +		on the current platform.
>>> +		Example:
>>> +		 recovery fastboot bootloader
>>> +
>>> +		The exact sysfs path may vary depending on the
>>> +		name of the driver that registers the arguments.
>>> +		Example:
>>> +		 /sys/class/reboot-mode/nvmem-reboot-mode/reboot_modes
>>> +		 /sys/class/reboot-mode/syscon-reboot-mode/reboot_modes
>>> +		 /sys/class/reboot-mode/qcom-pon/reboot_modes
>>
>> This part is obvious, isn't it?
>>
>>> +
>>> +		The supported arguments can be used by userspace
>>> +		to invoke device reset using the reboot() system
>>> +		call, with the "argument" as string to "*arg"
>>> +		parameter along with LINUX_REBOOT_CMD_RESTART2.
>>> +		Example:
>>> +		 reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2,
>>> +		        LINUX_REBOOT_CMD_RESTART2, "bootloader");
>>
>> So, does one need to write a tool for invoking reboot with the corerct
>> set of args?
> 
> Here's an implementation of such tool
> https://github.com/systemd/systemd/blob/main/src/shared/reboot-util.c#L80

Should i include this link for an example of existing tools or i just add
add a line saying that such tools are already available?

> 
> Many other implementations of reboot provides the same.
> 
>> If we are adding a sysfs interface, wouldn't it be logical
>> to also add another sysfs file, setting the argument?
>>
> 
> The inclusion of the example indicates that we need to expose it in an
> accessible form, but I don't think we should, as it's already a
> widespread standard interface.
> 
> As such, I don't think the example adds any value, but it would be
> valuable to clarify that this is a standard interface.

ok. Will remove this example of reboot syscall and add a line to
indicate that this is standard interface.

thanks,
Shivendra

