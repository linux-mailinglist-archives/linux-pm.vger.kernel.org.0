Return-Path: <linux-pm+bounces-38138-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3B0C65A88
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 19:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 622044E3ACE
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 18:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF913043A9;
	Mon, 17 Nov 2025 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JTDQKjET";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ImWKMEPc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55922D6E6A
	for <linux-pm@vger.kernel.org>; Mon, 17 Nov 2025 18:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763402760; cv=none; b=jnDL9T3ZWepWj9a5bNXMrU6iBM/xWdAAM+kv0R0XpP8QSl8FafcTgMYnMpZ1L+djVY/VXIuZRXTFDved3d0Gf3NycBxI5tiFyH5SNDtipLC5/5hShyvk9EEkAZPngB7dL29BeNIme0ALWtDoaA0+5lg0dQYPpvZC5UyffvyuJpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763402760; c=relaxed/simple;
	bh=Utq/o/IsaQ+xiSfOpL3Pvg0/iShuD4xCtX9S6nlhtRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N9UT6ED7CTW4tYin9Yb6vaE2kKCuXv/YkBTxR7To5gg7r/vkVy6LO/OcWatsEFMrD/44dh1+bMio08VSYrXcrONcyVn653yK0U1ZtJYjG4+a8iE7Q1X7phOUeXudUR7/XPRlfwnLBjdGExBMWec1yWXN638LtexIPY5Ls1JzltI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JTDQKjET; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ImWKMEPc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AHB2ogI3671224
	for <linux-pm@vger.kernel.org>; Mon, 17 Nov 2025 18:05:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CtZqmPr4nyYBtMaWQ9GcC5E+xfZSvgBJzThmf7k+gIA=; b=JTDQKjET50SCW1Ui
	2G6vRyZF3EW34cbIqWWvbI409nB8iUc9TBezeNNXtx+sW9mNfncu9wHBwdbKY6zA
	D6uFMrak8wA+qh8exAIQLhUVMArcrmwPIPcpVtGF55YzRgGn0v9jmNrTzoofLyH+
	NOFi+wnMnsL1hgtyR+oAl6NRg58p1dr954j+DAoOD/0ZOCE8/V9nKHrbGWs7kxB4
	eI1PymZzhKIIp5zTFNCmBzOXZq2Ok7c87VkFdY02RyDGBUH8s0vmni7nPki4CrCl
	88OuGDxfFgeZFYzcQrDr5Y8Ih7zlhraxATAdTcBI2iwTiRWhmVx+bEf+Ur6UMwF1
	Rsy8yw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ag2g597xj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 17 Nov 2025 18:05:57 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3437f0760daso12796311a91.1
        for <linux-pm@vger.kernel.org>; Mon, 17 Nov 2025 10:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763402757; x=1764007557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CtZqmPr4nyYBtMaWQ9GcC5E+xfZSvgBJzThmf7k+gIA=;
        b=ImWKMEPcbPy3rE658lGjHCqPqDCO3rGo5+10eXYLoesGZrGgg5LUz68EuK9Zq68x0j
         MAHONPN5ALqwd2+AH9axECU+OIHmX7FrrAM02DWBZS+hrD2pelXMQCfwqKwt6jE3vCX+
         dbA4t7sRyBx7RLw4inRv7BWovf96WX6yKTIT3I74hCDJ/43clWTtHgkCqZ0X6w+Hhzd3
         Q55b/67S1qdsUB6SnyA5ZM04x86ROqkY3aam4eW/oEtMIydlIeoC2Pj3IdS6IkYt1DzI
         MvlcL4fwkqoA24Lb3u8THFAI9ssJkYsULo086Yk87pNU22RInRXb+k/hwDr6yjyE8Ir4
         dN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763402757; x=1764007557;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CtZqmPr4nyYBtMaWQ9GcC5E+xfZSvgBJzThmf7k+gIA=;
        b=r208LySc0SURGna+Z6Q8d+E9lp4ajkeDcuJ/KujAc5nqcIfRO7F5pBj6neEubj4lZp
         4n7GW3zebVcIiLEKMRm5AZ955jPPOVuH1bodbFxc97+IpsLPWM6D9g+RT7viH0rly3rI
         1DVnHurcOYwyiXcuuUg8vRphle+UHJQOOD/pEJWFo7KCbDG9bm2yFjJ8RxILq+WVseQ5
         WR2hMRWxlr5dihV4nVXyHh9O1bGX842IIuM+Usjld8Ohbo842Y7F3OS+OlML7jtaSgYt
         PKxKOhIti5btgsL9UlVpfm+bM8X3UCS8UIwnzha+xZzJdPqXMs7+rBawLRbpnb3jOSyF
         /U9Q==
X-Forwarded-Encrypted: i=1; AJvYcCX1NQMthLL1TOGw9KgpZW39Js0Lgu/pytB9O8D2hWornwFOKANpLyDiXqSXKpXEACP9R8M3+gQSNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKS+YrqqLVSWsVhTCT/GCVfq3zmXyAjV78GE2Iedr9BgHPxEtl
	KQZD9VjTAcaBd/lAQPvZzfctwX21qAUmXWQcXgs2niuBLtV8TLCPe6ETREtdggFI2ru8g44wIjX
	6mM4R4M2aK/iTkKhyJl6TJbAjFxGLeU4surxzhr2jGDO5ySbqfd717+OrGBvV9A==
X-Gm-Gg: ASbGnct3MKBaT9CxEqRCqXZHHD0nN29j0ava0/S99OQnJ3SCXzv2J7uA6LqEOA/UQSB
	cYfF3Mln8rVJXqIPWZ2b4hfuUKI42jYIhhPSadsyIHLwaS4aOASuMDhY8MneU3XlRy3rLGDuaLy
	yY0sgz83Ws8j4tVyIy1nS4gHFtU9oZnmLxkNy/dGL0ooHH9DqxPEi1V5xzotqPlc5ev1ZZ3wy8J
	0PsiqmgeVumBRZ21W4/ysFFkO8M4Tl+QTD7oQp5ruSAbF7a6M7TsZGkQPeYOrY7Hl0UiuahS8Z+
	4lEFO1jaMK8RoAB6reCmqY+dnNukhkEsaW2bMNe4TldPaZHGhsk9wEW/MhT6DHbqM8fkSc5sTKV
	01G9pu9wjZy/TXs4yTVzTKy5tGmbA32jAOA==
X-Received: by 2002:a17:90b:528a:b0:32e:7270:9499 with SMTP id 98e67ed59e1d1-343f99d60a6mr14245213a91.0.1763402757185;
        Mon, 17 Nov 2025 10:05:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjMctP8U/bJG8gfCxZTBmL2bEtbZ9moSbknYP6XJxJcZzkUI3X1sLpoM/QNqSYptxk6CUWhA==
X-Received: by 2002:a17:90b:528a:b0:32e:7270:9499 with SMTP id 98e67ed59e1d1-343f99d60a6mr14245178a91.0.1763402756641;
        Mon, 17 Nov 2025 10:05:56 -0800 (PST)
Received: from [10.216.14.226] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3456516cf7esm10918337a91.12.2025.11.17.10.05.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 10:05:56 -0800 (PST)
Message-ID: <8b6ba46d-ab64-dbc5-8f09-e810bdef724e@oss.qualcomm.com>
Date: Mon, 17 Nov 2025 23:35:50 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 0/2] reboot-mode: Expose sysfs for registered reboot modes
Content-Language: en-US
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>,
        Bjorn Andersson
 <andersson@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20251116-next-15nov_expose_sysfs-v1-0-3b7880e5b40e@oss.qualcomm.com>
 <CACMJSeuiL5XEZjh8mOSj7tUnR8wEYSJ6FfZA87v8TSu8xM8_JA@mail.gmail.com>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <CACMJSeuiL5XEZjh8mOSj7tUnR8wEYSJ6FfZA87v8TSu8xM8_JA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=F7Vat6hN c=1 sm=1 tr=0 ts=691b6405 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=eCt-5-1m6m4SF186z2UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: zDGct35LgBL5iQXi9wH80nTXYCywJrlF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDE1NCBTYWx0ZWRfX0Fn20VEA6SJ4
 0N7OMZtCxE3idMKiwiezgaBMGCfeIv8759DfuL/seuZLL9H3MozfIoE3vnJq/EmgX3xfAg4pl3P
 U0G9YyeT3OAyfmG21hEEthCzl09P+Y+wJK7c4Qxx3D3BOQUvyxELysLt9H5nKtF5fvvK746veer
 vnXa0UFE2suP1jM0KKuO5LEuyxJybC5qJG2WSQexiZjIrdtXKNtt9mRFydk7hbH7ZuZqoT0155p
 /uJkCox6UFmv4tPieLkc9D9P2JTTH4719sZ7xP3QPb6DET3fl/A9q3fHJmJBFQm1aLZTITrv3Ko
 VdO56hKZBEfjNISe5p5KEihmQrukHTS0SVVtI9FM3OBwbjOdJzZw08QQ7tDVgTMCGT/Ty2Nl+UF
 pVGT4hglRglfZKdCZc6GgvUfv8SJpw==
X-Proofpoint-ORIG-GUID: zDGct35LgBL5iQXi9wH80nTXYCywJrlF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511170154



On 11/17/2025 6:33 PM, Bartosz Golaszewski wrote:
> On Sun, 16 Nov 2025 at 16:20, Shivendra Pratap
> <shivendra.pratap@oss.qualcomm.com> wrote:
>>
>> The reboot-mode framework provides infrastructure for drivers that want
>> to implement a userspace reboot command interface. However, there is
>> currently no standardized way for userspace to discover the list of
>> supported commands at runtime. This series introduces a sysfs interface
>> in the reboot-mode framework to expose the list of supported reboot-mode
>> commands to userspace. This will enable userspace tools to query
>> available reboot modes using the sysfs interface.
>>
>> Example:
>>   cat /sys/class/reboot-mode/<driver-name>/reboot_modes
>>
>> The series consists of two patches:
>>   1. power: reset: reboot-mode: Expose sysfs for registered reboot_modes
>>   2. Documentation: ABI: Add sysfs-class-reboot-mode-reboot_modes
>>
>> These patches were previously being reviewed as part of “vendor resets
>> for PSCI SYSTEM_RESET2”, until v17. Following the suggestions from
>> Bjorn, the reboot-mode sysfs patches have been split into a separate
>> series here, for focused discussions and better alignment.
>>
>> Previous discussion on these patches:
>> https://lore.kernel.org/all/20251109-arm-psci-system_reset2-vendor-reboots-v17-5-46e085bca4cc@oss.qualcomm.com/
>> https://lore.kernel.org/all/20251109-arm-psci-system_reset2-vendor-reboots-v17-4-46e085bca4cc@oss.qualcomm.com/
>>
> 
> When doing a split like this, please keep the versioning going. This
> should be v18.

Focus of that original series was "Implementing vendor resets for PSCI SYSTEM_RESET2".
These two patches have been split out of that series. The original series will
still continue to its next version(v18) after addressing all other reviews.
So i thought that these two patches can be split out to v1?

thanks,
Shivendra

