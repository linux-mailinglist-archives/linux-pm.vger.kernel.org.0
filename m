Return-Path: <linux-pm+bounces-37861-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B380C53BBF
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 18:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F1A4A20DD
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 17:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045B0345736;
	Wed, 12 Nov 2025 17:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K/ziOKnr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ThfCED6T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3FE31BCB6
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762968272; cv=none; b=IhsduITcKT+/9rdKcozkLKjiK/HufFkjAYE8ZwcPUpIfBEA+84Qd8aGSI3OCQ/jw0g8Dp4yBtQG/sc9/VTwvUKCANpTDUnva4zhAFJFBKl6N6bM+4VCkNAKV0To9AmHdCdSvws3V3EVtO2i8dhChqSHWV/3HHWbeIGQvnO+8T2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762968272; c=relaxed/simple;
	bh=mWpSqGBEYAudpmGnoQlVu5wRXRDB8Oc0jbvIumSSouM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TiggatsC8MJ9qZsFtDZKnIT4h1DIW+Qa40zGIrKjoyx4AaGMIY48iNek2szf8zaVMg+7S9ZRW7wqCjUcDCmNswoDBu7n9tbkv18+mzh8q26pM+0T12IGLOXZl/XhfIcFtMkPRMwIv5zMS+dDy0vemWWESCg6oqkfR6VeSxQbv6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K/ziOKnr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ThfCED6T; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACF2YYW1614832
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 17:24:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lZD7pUnx/84jE3WN452Z3V+2Bwtr/1GF7oDyaO0BBcw=; b=K/ziOKnr8oiZTisP
	79Z0V0BrOPuvxRMJimEKiUA4iQr4VktyLD/y7x9nwcKk6bcdjALQVV+oUipbCu4N
	bDBXi3GXt2p/sz+6eqGS0034MvMX31I8A4TbwVZT3lb2ZRyl/Y4fElG5a0n5mp9Q
	KO5eYpWkMSu8qEI0kyVj/tGSNYFuDANLuPTsn6NUVE/mD1VGFJ3SpSzbyEnslFfo
	Ofv+jwPj6rgjStt67nICZrG7Qa3lzM8sknTwioqYN+O6/nTyjGkRgYzTZ0H+YIcN
	28BthFxmbLvrcyefXbl2tMxUX6JWD8fxoRoLa6UtzynrRakK2QmvV9b2WieBeJTr
	p4z73Q==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acvhfrfnx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 17:24:29 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7900f597d08so1109431b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 09:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762968269; x=1763573069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lZD7pUnx/84jE3WN452Z3V+2Bwtr/1GF7oDyaO0BBcw=;
        b=ThfCED6TNuNxN5TNHvgvpdYlaJr5mS8X2bSzr90Q9gq9KvIj0JYF35NyzFD0rc+dDE
         MV8OOqVZMsRIIqRVfcKLyqPScnJiDghVNCZgj/FkU5726O8yFS4QoP0ZjYtS4GLHfviK
         PQ2gtD9Shx6/g3pUAq9yd+WyzQul+KLrkyY0n/vIbti2INwojDFQOukNDigB5HTnr0of
         Q7P3FzjZCWYACyrWC+Pqi3zpEOUS1+jjrfyhqPwP5ak9worOcov8MgzeBBXyP4Iev11A
         Rv5s2VG6PgHa2Stk8J3F6uk96PQ9X9+jAeqp+dQXC9TnEn/VC/tnj1z7BRtj8oS+djLr
         UlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762968269; x=1763573069;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lZD7pUnx/84jE3WN452Z3V+2Bwtr/1GF7oDyaO0BBcw=;
        b=M+su6/bbGaTRuy4uRZbiZK0ekEytBjZKEVtY1PPqbbRVYKtnoSUqNRcZppRdbqYqNm
         mqrFxCe3UiX5IycYEPSoqrGP0lKuObsCBnByXOEqU08GrP3FC6PfzKzg2CNtSojGtOLd
         SUxSGg9XIcgXkEH4dgDxkMMHD9u/0wK35tAVSIOoE+cksSMKVgddN+wyK7lGfGpFNgG8
         wkwTnriGKzBcj6QYJDBzCf/AdiuQ0HRJDEjoASrHFl4AptD7hMLhOCx6DnpLBaISXG1G
         1IAv0N9hz0OEo4DanVq8xDB6u99Tu4dCgIHOKTb48v6+5FhSi++k+yiZqs9rWNhGRO5d
         /ixQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx7XQND1ASc0S9OHh+YA/5bbqgr4yD8zqtIBGWR+Tk2NcZGLLFKsoVEv439Fet74UkTJScLF/73g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+UPK7zV4w9zcrv3HHnSa6uW8exBTsPxXvd616uJaEg6MqX2nw
	XJ2Br3t5OJaKueFlw1rcB2sDCwnVWmMteJXtIMft7fUy/TiEceyNItcFV5EPqs41Jn25Bw5wQN2
	ahHh5Kh6qu3gFsZXddUhxrCiPhFyczVtPHBxQ7aTFxuaXdK/Ffp4xifv7x087cA==
X-Gm-Gg: ASbGnctuGoQGikq4DNnkSAYHHRLaPRC1JfF8aqhzaZjwjDM3cX8q+/zbQ6gqFBzeXfA
	DolWRK3IgPKhUobvjeHEZAPSbktMiHbf6C5TERR+nN8kRTF+2+aB+wP70xFlPTiYDXGe+WAFxk3
	fO+MfiLrmlovnFAWUWWgR576LJtHHNx+bV5JKmjodzC25qtcBCKjHdK512YsbhMO4ckup7Jj3id
	C15ERDVxZhYp8MkRGC5scr2/Qzz24DXcpi5miJ/D/eDpicUglK0xDJ667BZNTKtLp1Gfx8JIwsx
	qEt3nhdbCHtZmP4M6DRTjerbSjVth3+MGpzGton/vAwLQf5Atb8my+96jbqJWTBoVqa2oBViDml
	cMSmYVKh9813wZTRwTBftg3KJn4+BHBZu
X-Received: by 2002:a05:6a21:3384:b0:355:1add:c291 with SMTP id adf61e73a8af0-35909095f95mr5328793637.10.1762968268223;
        Wed, 12 Nov 2025 09:24:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXIB97NgMwsJgk1cm/ljf5b9rzD8y605CRDG9zmQ3p8m9xcAG4Rtf7m+VohGOESJG3GEVTow==
X-Received: by 2002:a05:6a21:3384:b0:355:1add:c291 with SMTP id adf61e73a8af0-35909095f95mr5328725637.10.1762968267579;
        Wed, 12 Nov 2025 09:24:27 -0800 (PST)
Received: from [10.216.19.73] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf168d7bdasm3308875a12.20.2025.11.12.09.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 09:24:27 -0800 (PST)
Message-ID: <a45f1d23-c224-ba7d-eddc-a622cefd2ba0@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 22:54:15 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v17 05/12] power: reset: reboot-mode: Expose sysfs for
 registered reboot_modes
Content-Language: en-US
To: Bjorn Andersson <andersson@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
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
        Xin Liu <xin.liu@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
References: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
 <20251109-arm-psci-system_reset2-vendor-reboots-v17-5-46e085bca4cc@oss.qualcomm.com>
 <qhlxxfsyc42xemerhi36myvil3bf45isgmpugkuqzsvgcc3ifn@njrtwuooij2q>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <qhlxxfsyc42xemerhi36myvil3bf45isgmpugkuqzsvgcc3ifn@njrtwuooij2q>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=D49K6/Rj c=1 sm=1 tr=0 ts=6914c2cd cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=vUC0tSP6VGobWMCwuYQA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: QmZsRm-c4Xm50mBKFl88Yp8HomXa0fSX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0MCBTYWx0ZWRfXwVYDVeJ7nOsd
 TmuXTYJ3A4DJ4TRxHnSffe4UVBefO6YylLenanbEo2P4uVQj1qsLsaLCdpkbcSYScC3yTsetuaB
 WjesaSJHaMRHbIEovsupQYvn1+KLvn/VjCJURbvRBHrUkZJG6CXHGeePY6badv4lZJO/C0aRV1q
 ZLIZzHhK7qygCUREnjb734/xAkj1fb0xLeH+Pk5aAfXAqNLDp3L67ceOjvzqDg0m6RqbBHsJclm
 lxo6oTS0ivXWYcw1AZeexY/HxIigczbLuo/Eo5Ks+kB9l5vYj8EDUqDtOlc/wltQaN36ce4+kwS
 9vUFh7OgM0JRwBg48ICZsavfEPYJqkPMCQHMSOv0HHc1JrXa/S2Wycn2B7elxQkcEI2+bvU7lMz
 yJfKAw+PCy6DyB1FQYcGY9ZLC2rLQA==
X-Proofpoint-GUID: QmZsRm-c4Xm50mBKFl88Yp8HomXa0fSX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_05,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120140



On 11/10/2025 9:45 PM, Bjorn Andersson wrote:
> On Sun, Nov 09, 2025 at 08:07:18PM +0530, Shivendra Pratap wrote:
>> Currently, there is no standardized mechanism for userspace to
>> discover which reboot-modes are supported on a given platform.
>> This limitation forces tools and scripts to rely on hardcoded
>> assumptions about the supported reboot-modes.
>>
>> Create a class 'reboot-mode' and a device under it to expose a
>> sysfs interface to show the available reboot mode arguments to
>> userspace. Use the driver_name field of the struct
>> reboot_mode_driver to create the device. For device-based
>> drivers, configure the device driver name as driver_name.
>>
>> This results in the creation of:
>>   /sys/class/reboot-mode/<driver>/reboot_modes
>>
>> This read-only sysfs file will exposes the list of supported
>> reboot modes arguments provided by the driver, enabling userspace
>> to query the list of arguments.
>>
> 
> I like this addition, and your commit message reasoning about this
> addition. But, while touching upon the same subject, you've made this
> series add two separate things.
> 
> So now this part can't be merged unless there's agreement on the PSCI
> SYSTEM_RESET2, and the PSCI SYSTEM_RESET2 can't be merged unless this
> sysfs interface is agreed upon.
> 
> Unless I'm missing some clear dependency here, it would have been better
> to keep these two topics in separate series, and drive them to
> conclusion independently.

sure. Will split this series based on dependencies.

the psci patch does has a dependency on the fwnode based registration
and the u64 bit magic registration. Let me see how can i split the series
to 2 independent patchsets. Any suggestions will be helpful.

potentially it may be.
1 - devres removal + expose sysfs
2 - u64 bit registration = fw node + any extras + psci. 

> 
>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>> ---
>>  drivers/power/reset/reboot-mode.c | 62 ++++++++++++++++++++++++++++++++++++++-
>>  include/linux/reboot-mode.h       |  2 ++
>>  2 files changed, 63 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
>> index 873ac45cd7659b214b7c21958f580ca381e0a63d..582aa7f8ed7fa485c5a67877558c9b15d3600ef4 100644
>> --- a/drivers/power/reset/reboot-mode.c
>> +++ b/drivers/power/reset/reboot-mode.c
>> @@ -6,6 +6,7 @@
>>  #define pr_fmt(fmt)	"reboot-mode: " fmt
>>  
>>  #include <linux/device.h>
>> +#include <linux/err.h>
>>  #include <linux/init.h>
>>  #include <linux/kernel.h>
>>  #include <linux/list.h>
>> @@ -23,6 +24,8 @@ struct mode_info {
>>  	struct list_head list;
>>  };
>>  
>> +static struct class *rb_class;
> 
> Why not "static const struct class reboot_mode_class" and then a
> class_register() call? Why do you need the class dynamically allocated
> on the heap?

Ack. will update this.

> 
>> +
>>  static u64 get_reboot_mode_magic(struct reboot_mode_driver *reboot, const char *cmd)
>>  {
>>  	const char *normal = "normal";
>> @@ -65,6 +68,51 @@ static int reboot_mode_notify(struct notifier_block *this,
>>  	return NOTIFY_DONE;
>>  }
>>  
>> +static ssize_t reboot_modes_show(struct device *dev, struct device_attribute *attr, char *buf)
>> +{
>> +	struct reboot_mode_driver *reboot;
>> +	struct mode_info *info;
>> +	ssize_t size = 0;
>> +
>> +	reboot = (struct reboot_mode_driver *)dev_get_drvdata(dev);
>> +	if (!reboot)
>> +		return -ENODATA;
>> +
>> +	list_for_each_entry(info, &reboot->head, list)
>> +		size += sysfs_emit_at(buf, size, "%s ", info->mode);
>> +
>> +	if (size) {
>> +		size += sysfs_emit_at(buf, size - 1, "\n");
>> +		return size;
>> +	}
>> +
>> +	return -ENODATA;
>> +}
>> +static DEVICE_ATTR_RO(reboot_modes);
>> +
>> +static int create_reboot_mode_device(struct reboot_mode_driver *reboot)
> 
> Note how (almost) all other function names in this file start with
> a "reboot_mode_" prefix.

Ack. will update.

> 
>> +{
>> +	int ret = 0;
> 
> First use is an assignment, no need for you to zero-initialize it here.
> 
>> +
>> +	if (!rb_class) {
>> +		rb_class = class_create("reboot-mode");
>> +		if (IS_ERR(rb_class))
>> +			return PTR_ERR(rb_class);
>> +	}
>> +
>> +	reboot->reboot_dev = device_create(rb_class, NULL, 0, (void *)reboot, reboot->driver_name);
> 
> Every struct reboot_mode_driver is going to end up having one of these,
> so why not incorporate it into the reboot_mode_driver in the first
> place. It avoids the extra heap allocation, and you can use
> container_of() instead of drv_data to find your reboot_mode_driver in
> the reboot_modes_show() above.
> 
> 
> Just:
>   reboot->reboot_dev.class = &reboot_mode_class;
>   dev_set_name(&reboot->reboot_dev, reboot->driver_name);
>   ret = device_register(&reboot->reboot_dev);
> 

Ack. thanks.

>> +	if (IS_ERR(reboot->reboot_dev))
>> +		return PTR_ERR(reboot->reboot_dev);
>> +
>> +	ret = device_create_file(reboot->reboot_dev, &dev_attr_reboot_modes);
> 
> Manually creating sysfs attributes is both error prone and racy, so if
> you can you should avoid it.
> 
> Here you have the opportunity to just statically assign
> reboot_mode_class->dev_groups to an ATTRIBUTE_GROUP() with your
> attribute and it will all be handled for you.
> 

Ack. will update this.

>> +	if (ret) {
>> +		device_unregister(reboot->reboot_dev);
>> +		return ret;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>>  /**
>>   * reboot_mode_register - register a reboot mode driver
>>   * @reboot: reboot mode driver
>> @@ -83,13 +131,17 @@ int reboot_mode_register(struct reboot_mode_driver *reboot, struct fwnode_handle
>>  	u32 magic_arg2;
>>  	int ret;
>>  
>> -	if (!fwnode)
>> +	if (!fwnode || !reboot->driver_name)
>>  		return -EINVAL;
>>  
>>  	np = to_of_node(fwnode);
>>  	if (!np)
>>  		return -EINVAL;
>>  
>> +	ret = create_reboot_mode_device(reboot);
>> +	if (ret)
>> +		return ret;
>> +
>>  	INIT_LIST_HEAD(&reboot->head);
>>  
>>  	for_each_property_of_node(np, prop) {
>> @@ -142,6 +194,8 @@ int reboot_mode_register(struct reboot_mode_driver *reboot, struct fwnode_handle
>>  		kfree(info);
>>  	}
>>  
>> +	device_remove_file(reboot->reboot_dev, &dev_attr_reboot_modes);
>> +	device_unregister(reboot->reboot_dev);
>>  	return ret;
>>  }
>>  EXPORT_SYMBOL_GPL(reboot_mode_register);
>> @@ -155,6 +209,9 @@ int reboot_mode_unregister(struct reboot_mode_driver *reboot)
>>  	struct mode_info *info;
>>  	struct mode_info *next;
>>  
>> +	if (!reboot->reboot_dev)
>> +		return -EINVAL;
>> +
>>  	unregister_reboot_notifier(&reboot->reboot_notifier);
>>  
>>  	list_for_each_entry_safe(info, next, &reboot->head, list) {
>> @@ -163,6 +220,8 @@ int reboot_mode_unregister(struct reboot_mode_driver *reboot)
>>  		kfree(info);
>>  	}
>>  
>> +	device_remove_file(reboot->reboot_dev, &dev_attr_reboot_modes);
>> +	device_unregister(reboot->reboot_dev);
>>  	return 0;
>>  }
>>  EXPORT_SYMBOL_GPL(reboot_mode_unregister);
>> @@ -192,6 +251,7 @@ int devm_reboot_mode_register(struct device *dev,
>>  	if (!dr)
>>  		return -ENOMEM;
>>  
>> +	reboot->driver_name = reboot->dev->driver->name;
> 
> It seems unlikely that we will have multiple instances of the same
> driver influencing the actual reboot mode, but we could very well have
> multiple instances of the same driver calling
> devm_reboot_mode_register(). E.g. on a board two PMICs, both with PON
> blocks (but only one considered as the source for boot mode).
> 
> In that case you will end up trying to create multiple devices with the
> name "qcom-pon", presumably that will fail and per your error handling
> you have now disabled the reboot-mechanism for all but the first pon
> instance that was registered.
> 
> It also creates some asymmetry between devm_reboot_mode_register() and
> reboot_mode_register(), in that the one API the client driver decides
> the name, in other it's hard coded to the driver name (and if the client
> did specify a name - which they should if they use the non-devm one- it
> will be overwritten).
> 
> 
> 
> On that note, I would argue that aborting the registration of
> reboot-modes, just because we failed to create the convenient "debug"
> interface, doesn't make sense. I think it would be better to just
> continue even when create_reboot_mode_device() returns an error.
>

sure i can modify this to continue on error.
 
>>  	rc = reboot_mode_register(reboot, of_fwnode_handle(reboot->dev->of_node));
>>  	if (rc) {
>>  		devres_free(dr);
>> diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
>> index e0d3e8a54050a76f26846f456120b4c7e371d284..81c149edf40fbcf0d3427c2e12eb415199cb153b 100644
>> --- a/include/linux/reboot-mode.h
>> +++ b/include/linux/reboot-mode.h
>> @@ -7,6 +7,8 @@
>>  
>>  struct reboot_mode_driver {
>>  	struct device *dev;
>> +	struct device *reboot_dev;
> 
> As suggested above:
> 
> struct device reboot_dev;

Ack.

thanks,
Shivendra

