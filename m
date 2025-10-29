Return-Path: <linux-pm+bounces-37061-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 17664C1C97A
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 18:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 79E314E1F0A
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 17:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46012350298;
	Wed, 29 Oct 2025 17:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XfBHCnkZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fzOOGm9J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC07A32BF5D
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 17:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761760150; cv=none; b=ox6RQfFXGEufkR36+HKok2YMZGYXJL1ZEUC52+cUr8WpnIkUgEMX9ydZ/YymnCift5My4gJ6Smvs8YtgQuG1PMITF0z/onM79Bi9Jg3yWAZmgmQy+6O6D14tWz6fioBlqHn549HNATyS+tOlHf05CgCHVtkUXP54U7UeLOJdrbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761760150; c=relaxed/simple;
	bh=s3xBk+WH4G9lHuayprGFgPbsI1G+D4ZgrNl9qI03RLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UVufBHKwOYEuglLb1c/Q1k8b2RcbdR0ONFaxKs9DQxcW6DnLqYIZjI2G7ib4W77gc2oa8D9iv3TCwB6HPFzUE0dY7SqyiQpIxsb4GAX1RsleAuHqLT/JJos4esEeZjzZTVnrzuViGQHmBZnND0EkHlgIu131AmdQFG+Khs0brrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XfBHCnkZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fzOOGm9J; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59TDdWK8570118
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 17:49:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zBBOWdMy0EgPxsuEOw/+fgZm8ur/jhP/dUsIn5rcIuY=; b=XfBHCnkZqZCpX5+4
	3XL1BDMC0yRIVhFhvx9ni80s/OSQIxl/SHDpwMLzGrAV9qYYcOst84ikZxZRMlxc
	R9Kihscce2h9DuJ6Vt4osioH3iSnlLIQlO13S50u0VPL/GB/aLVaBH9+HuLjQmUZ
	cCLgeLaifXa01vvgwqKymuKpRkIewGcVK0xHkswlOenMNES3bLp5o1X3u5lKXPG0
	LYwj1RZtyPpHGZzpAdAjZLGxBQdZ0OKOraZeqtoO8RiVmhmHMRMWlfYryHOfLp+d
	JLtFyU9XOgnS9NwomeF6f6pkIktAgWX7ji1UvHH3ZxlTlRV6k7cW9RYtta9d3dzj
	zH4gEA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3m0bgute-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 17:49:06 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32eaa47c7c8so136986a91.3
        for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 10:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761760145; x=1762364945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zBBOWdMy0EgPxsuEOw/+fgZm8ur/jhP/dUsIn5rcIuY=;
        b=fzOOGm9JKUjSjVS+7mMqu8lFCmw3k5h/8gl9R/lB6I1SpnRPLlgkOcxCc0ho7ZS/sm
         Dn8vRmxM+NVMxfb/ie873zq3ZBgZ1RfsL0PNaM04RdqsAeeCG3blloLaNCUD9ik5YMDf
         4qp0qFPPSioIMSruUWVSJyWGw46f0UZ3i7+6mjc/q73h4T7DbyadGzRnpOht/mUDNilN
         qQuCCPJ7c/KIDQ1fVI8N3R4VvQEo+FXGKlJ+aornOc4UlbzQMta4Gol0QnHGdTwHMwAB
         jgaLZdBiyNv6UXd5vCUD2q5p7Du1Qpwle0L9FPvfvT3I2xJ66wTub/PccUJONa/mlkOi
         fvbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761760145; x=1762364945;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zBBOWdMy0EgPxsuEOw/+fgZm8ur/jhP/dUsIn5rcIuY=;
        b=HP0ePYOuP/60Pn0Tdekt6suNvjXUZc5Gxgke3nUjuRBBF2i7yxH3WdHmcJwtfzclFS
         ogDAH2qpNW4Sih7yZdcEtma+430CB8aqfostgXHPUGXkA30ZopHZEVlnjYEZEYI2RjiB
         2MF1TmjGoJIeoCUuN993UzdO4daakAR/Y9jigmoWdCNhBPIu1Gps7DgIrL4wOOUNcoxP
         j+C2LNCIrAXV2n3cZstzoBFG3rS6TwcP9Uitb87en0gZQ3UV1UlJmhdbOHS3MEUWdmDK
         CwBO3XHIEItWi/yflYL0+GZONWAkCO7q+7mNKPnnyqXGRNdAmMK8dkk7Z+MtSWu05KUW
         9IFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFJmfizdnTlpI71kD3XQevay/pbkv+aS/dz9AKcqvsXsITUT2lwBYGOhnMUH3OpeTdlP1YHv1BMg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb7NKsj+wf2xm+k3uHBaU595pTjPwiQtEmWI2ewYK9FstuJtOH
	CDFNRQRwFH6hXuIgZsM6prCavqyxqMfABRCRSyX6QDQQPjb7rIrTYbUI1JcN/Op8mUxFGit4hD0
	NY6OlW3ys1jH2rkcic8NcZFXQdNs830hpXQWs2fRfZntdlXeFGeYJkKk4j4I0Pg==
X-Gm-Gg: ASbGnctpvlFmrXwHYi0XGu4wquWe453K7AcA386LJwtNAVfh+O4DD0zfpq/5ahdiqDO
	RBBuirDzhqJ7GKq94vpjdTikpPbeJXJhb3TFPFVjFl9VrDR9olZYXyR3qtkHUdPcuWX2wuIRAIn
	rp/Ps17BnPT37zQDQechdeIP3zLf/DnAi/LIw/L0hi0KGemnT6jAG85fVyUdRbOLyn5tg4RJ/7r
	9/H0KhZQzuQToUDDvZ9lXj9OWfpfwyB3AqQAFTpQ2s63cFliSbzWim3qdEnqcxSvOlBsvki5//k
	IH2dMzrADXIdQe/5wBK2dz0Jg9ZiibrzaVZPew48Msee2xD4yzjSPi+WRVFCu+IgbfjmIp6ge66
	M9SwX2n0wJSyedrr5855fSZgK0xg3e3Ql
X-Received: by 2002:a17:90b:52ce:b0:32b:6151:d1b with SMTP id 98e67ed59e1d1-3403a160f49mr4241478a91.8.1761760145294;
        Wed, 29 Oct 2025 10:49:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVJJ72rkoSQSQ2NSo1xC7KWX04uCUKN6W0tdBTOXGaqbvhURfKhLjwT83FJ6lFL/2Ey+77rQ==
X-Received: by 2002:a17:90b:52ce:b0:32b:6151:d1b with SMTP id 98e67ed59e1d1-3403a160f49mr4241443a91.8.1761760144652;
        Wed, 29 Oct 2025 10:49:04 -0700 (PDT)
Received: from [10.216.40.51] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f604dsm16430255a91.15.2025.10.29.10.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 10:49:04 -0700 (PDT)
Message-ID: <efb52d01-0430-8bdb-e0c7-86c5a2857ef6@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 23:18:52 +0530
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
        Srinivas Kandagatla <srini@kernel.org>
References: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
 <20251015-arm-psci-system_reset2-vendor-reboots-v16-1-b98aedaa23ee@oss.qualcomm.com>
 <5l2tcjbdtikkhkuhuz64ymk5et6wtl4kwf2mc265su27oh57rt@3shmo3wfx7fb>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <5l2tcjbdtikkhkuhuz64ymk5et6wtl4kwf2mc265su27oh57rt@3shmo3wfx7fb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: tvaOWbj2oDJrbNX-09scbGF7kxFd3CoD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDE0MiBTYWx0ZWRfX5/1Ve6KeChd2
 ix5tLsAytItZO7LFiahePSe4JNXUSgKeIrcQNEGNhKjB7ScUYV1wkQ86SwezZv5FTpPAS6JjM/C
 oQzC9nr+qrgjfctUIQEcvNA6/GiXR7O4+9HrLWQ5OExhgCsbX6FroGKuIpg9K48nyiQju0VrdMZ
 LiR9vilq4qWC4t41D/pkRj6GyVCw4XIACqLDEWb0f47b3eo/ytj9H/Mpp9zpRRBbY5klJXh42j5
 F66qBLG06Y2CsGUmnYifhF6hufUSkUHqbJ9MkzQEzL+ctuqlrsX18if5Eo0UQIqgvAy8tP0eP8o
 ltH/Bq269FwHRo3vKQ1W6GwWA4WR2LvqJpNOzAdTG5+pXSOoIfTZ/TOmEl1ShdKW7eYcVhtZimi
 Kf1AZ/oSK1tlHdvtijLaL/gOJfAOIw==
X-Proofpoint-GUID: tvaOWbj2oDJrbNX-09scbGF7kxFd3CoD
X-Authority-Analysis: v=2.4 cv=YLySCBGx c=1 sm=1 tr=0 ts=69025392 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=n0NvOUcOdHF0XYJju0UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290142



On 10/28/2025 9:04 AM, Bjorn Andersson wrote:
> On Wed, Oct 15, 2025 at 10:08:16AM +0530, Shivendra Pratap wrote:
>> List traversals must be synchronized to prevent race conditions
>> and data corruption. The reboot-mode list is not protected by a
>> lock currently, which can lead to concurrent access and race.
> 
> Is it a theoretical future race or something that we can hit in the
> current implementation?
> 
>>
>> Introduce a mutex lock to guard all operations on the reboot-mode
>> list and ensure thread-safe access. The change prevents unsafe
>> concurrent access on reboot-mode list.
> 
> I was under the impression that these lists where created during boot
> and then used at some later point, which at best would bring a
> theoretical window for a race... Reviewing the code supports my
> understanding, but perhaps I'm missing something?
> 
>>
>> Fixes: 4fcd504edbf7 ("power: reset: add reboot mode driver")
>> Fixes: ca3d2ea52314 ("power: reset: reboot-mode: better compatibility with DT (replace ' ,/')")
>>
> 
> Skip this empty line, please.
> 
> 
> And given that you have fixes here, I guess this is a problem today. In
> which case, this shouldn't have been carried for 16 versions - but have
> sent and been merged on its own already.
> 
> So please, if this is a real issue, start your commit message with a
> descriptive problem description, to make it clear that this needs to be
> merged yesterday - or drop the fixes.
> 
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
>>  	if (!cmd)
>>  		cmd = normal;
>>  
>> -	list_for_each_entry(info, &reboot->head, list)
>> -		if (!strcmp(info->mode, cmd))
>> -			return info->magic;
>> +	scoped_guard(mutex, &reboot->rb_lock) {
>> +		list_for_each_entry(info, &reboot->head, list)
>> +			if (!strcmp(info->mode, cmd))
>> +				return info->magic;
>> +	}
>>  
>>  	/* try to match again, replacing characters impossible in DT */
>>  	if (strscpy(cmd_, cmd, sizeof(cmd_)) == -E2BIG)
>> @@ -41,9 +43,11 @@ static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
>>  	strreplace(cmd_, ',', '-');
>>  	strreplace(cmd_, '/', '-');
>>  
>> -	list_for_each_entry(info, &reboot->head, list)
>> -		if (!strcmp(info->mode, cmd_))
>> -			return info->magic;
>> +	scoped_guard(mutex, &reboot->rb_lock) {
>> +		list_for_each_entry(info, &reboot->head, list)
>> +			if (!strcmp(info->mode, cmd_))
>> +				return info->magic;
>> +	}
>>  
>>  	return 0;
>>  }
>> @@ -78,46 +82,50 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
>>  
>>  	INIT_LIST_HEAD(&reboot->head);
>>  
>> -	for_each_property_of_node(np, prop) {
>> -		if (strncmp(prop->name, PREFIX, len))
>> -			continue;
>> -
>> -		info = devm_kzalloc(reboot->dev, sizeof(*info), GFP_KERNEL);
>> -		if (!info) {
>> -			ret = -ENOMEM;
>> -			goto error;
>> -		}
>> -
>> -		if (of_property_read_u32(np, prop->name, &info->magic)) {
>> -			dev_err(reboot->dev, "reboot mode %s without magic number\n",
>> -				info->mode);
>> -			devm_kfree(reboot->dev, info);
>> -			continue;
>> -		}
>> -
>> -		info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
>> -		if (!info->mode) {
>> -			ret =  -ENOMEM;
>> -			goto error;
>> -		} else if (info->mode[0] == '\0') {
>> -			kfree_const(info->mode);
>> -			ret = -EINVAL;
>> -			dev_err(reboot->dev, "invalid mode name(%s): too short!\n",
>> -				prop->name);
>> -			goto error;
>> +	mutex_init(&reboot->rb_lock);
>> +
>> +	scoped_guard(mutex, &reboot->rb_lock) {
> 
> I don't see how this can race with anything, reboot_mode_register() is
> supposed to be called from some probe function, with reboot_mode_driver
> being a "local" object.
> 
> The guard here "protects" &reboot->head, but that is not a shared
> resources at this point.
> 
>> +		for_each_property_of_node(np, prop) {
>> +			if (strncmp(prop->name, PREFIX, len))
>> +				continue;
>> +
>> +			info = devm_kzalloc(reboot->dev, sizeof(*info), GFP_KERNEL);
>> +			if (!info) {
>> +				ret = -ENOMEM;
>> +				goto error;
>> +			}
>> +
>> +			if (of_property_read_u32(np, prop->name, &info->magic)) {
>> +				dev_err(reboot->dev, "reboot mode %s without magic number\n",
>> +					info->mode);
>> +				devm_kfree(reboot->dev, info);
>> +				continue;
>> +			}
>> +
>> +			info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
>> +			if (!info->mode) {
>> +				ret =  -ENOMEM;
>> +				goto error;
>> +			} else if (info->mode[0] == '\0') {
>> +				kfree_const(info->mode);
>> +				ret = -EINVAL;
>> +				dev_err(reboot->dev, "invalid mode name(%s): too short!\n",
>> +					prop->name);
>> +				goto error;
>> +			}
>> +
>> +			list_add_tail(&info->list, &reboot->head);
>>  		}
>>  
>> -		list_add_tail(&info->list, &reboot->head);
>> -	}
>> -
>> -	reboot->reboot_notifier.notifier_call = reboot_mode_notify;
>> -	register_reboot_notifier(&reboot->reboot_notifier);
>> +		reboot->reboot_notifier.notifier_call = reboot_mode_notify;
>> +		register_reboot_notifier(&reboot->reboot_notifier);
> 
> Once register_reboot_notifier() has been called, &reboot->head is
> visible outside the specific driver instance.
> 
> So, there's no reason to lock in reboot_mode_register().
> 
>>  
>> -	return 0;
>> +		return 0;
>>  
>>  error:
>> -	list_for_each_entry(info, &reboot->head, list)
>> -		kfree_const(info->mode);
>> +		list_for_each_entry(info, &reboot->head, list)
>> +			kfree_const(info->mode);
>> +	}
>>  
>>  	return ret;
>>  }
>> @@ -133,8 +141,10 @@ int reboot_mode_unregister(struct reboot_mode_driver *reboot)
>>  
>>  	unregister_reboot_notifier(&reboot->reboot_notifier);
>>  
>> -	list_for_each_entry(info, &reboot->head, list)
>> -		kfree_const(info->mode);
>> +	scoped_guard(mutex, &reboot->rb_lock) {
> 
> get_reboot_mode_magic() is only called from reboot_mode_notify(), which
> is only invoked by blocking_notifier_call_chain().
> 
> blocking_notifier_call_chain() takes a read semaphore.
> unregister_reboot_notifier() take a write semaphore.
> 
> So, if we're racing with a shutdown or reboot, I see two possible
> things:
> 
> 1) blocking_notifier_call_chain() happens first and calls
>    reboot_mode_notify(), blocking unregister_reboot_notifier(). Once it
>    returns, the unregister proceeds and we enter case #2
> 
> 2) unregister_reboot_notifier() happens first (or after the
>    blocking_notifier_call_chain() returns). Our reboot object is removed
>    from the list and blocking_notifier_call_chain() will not invoke
>    reboot_mode_notify().
> 
> In either case, the list has a single owner here.
> 
> 
> As far as I can see, the only race left is if multiple concurrent calls
> happens to blocking_notifier_call_chain(), the behavior of
> reboot->write() might be undefined. But I think that is reasonable.
> 
> 
> Please let me know if I'm missing something.

Thank you for the detailed review. Tried to summarize below:

The mutex lock was introduced in v13 following earlier discussions about
whether the issue was a theoretical future race or something that could
occur in the current implementation.

At the time (prior to v13), we concluded that while no race condition was
observable in the current code, there could be a potential in future
changes or usage patterns — making it a theoretical concern.

During review, there was further discussion around whether it's acceptable
to leave the list unprotected simply because no race is currently suspected.
The general consensus was that it's better practice to protect shared data
structures like lists with a mutex to ensure correctness and future-proofing.

Based on that feedback, the mutex lock introduced in v13.

Later in v15, the reboot-mode maintainer suggested that the patch should
include a Fixes tag, which was incorporated accordingly.

So both the mutex addition in v13 and the Fixes tag in v15 were made in
response to upstream review comments.

Need some guidance on how to take this forward or is it ok to protect all
list operation, as done in this patch and keep the fixes tag as suggested
in earlier reviews?

thanks,
Shivendra

