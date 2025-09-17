Return-Path: <linux-pm+bounces-34905-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 916FAB811E9
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 19:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D085487C47
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 17:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3502FC881;
	Wed, 17 Sep 2025 17:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TUEtssX0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981D32FC87E
	for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 17:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758128796; cv=none; b=FIYhqDHq3UcER1PZR5Xt/deRdvk/Tt1SJ6ZQL2K/sZkrLOruxUEC4YXyuAS8Y6Llq0JsHkftqYKnwRZKRueRjBRDYQkefNph2q9JcSB0ZVsZwUZaWENx4rWi6DQWM0rJ2d7DutRVV2mvD7I8sulxUzqLm0Fja7NHUlCM7thLnb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758128796; c=relaxed/simple;
	bh=76CbFOoG7fO8/knkAO5zHOpDO4lOmZ2qmfgZf2rMkng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RBNsRBLPmyfxN8+YrMOc9Thj2TvMIfJv6SLePaUEgxOACZxS0z5tCrR+QVupH2n91pvCDg+I6Ih4gsvDPM1/LFTAkljg2LGRa7bjhxJXGR9aU/LCY0F9GEK8OxpqDUZ6m6ujg/EnMzC7EoqJbkU4Cu0ulhmmocQ0d/RIWhuHxdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TUEtssX0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HG4d0Z029815
	for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 17:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CldjWF1Kec39RRy7IefPImhF3OKmtV3emAzZ2/VbBsc=; b=TUEtssX0LEp4+Yxj
	JKISkX+yfP9FaUzYI7MnA84nLIbPhWzkDwswuy06e9tZtu1ufEXn9TY5FHq5KtEQ
	QOk2Sj2p4JsG31ZA20mZYG5t9YHKpHhhAVoVeBjdF/eLpsxoUHYoORtpDBHE+DJ0
	8chO+dMThHKCxYrIZ61qXJLb84+83OE+DDc6ZvHWTGHUKtyQ2molI6e45D4FmTWh
	KIlhcFt37AQzo8ZA/XrIFFK/5ZM2U02MzhYZUWb9D1ATL8BYQ0P/S3RVy/sWfa+W
	MaBeAURM1jxhrpN+VzmWeh1tOj9sGaKmamNMjLTXLuk+1nyG7hkXQdrphs2VQmIx
	7Evx6g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxxk873-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 17:06:33 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2659a7488a2so245695ad.3
        for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 10:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758128792; x=1758733592;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CldjWF1Kec39RRy7IefPImhF3OKmtV3emAzZ2/VbBsc=;
        b=FqtC/4jiThI2ADeSlbtphrYFOk0nk3sgYgeIzfeNKxLsQSCNM4x3B0I4R4trskoK82
         vs0zUhv63Z7uiB8eA3Z/tBXuThaknWxvfKZbnnyaRpMUOoinxK6nrNSqcEcY3Vj2Xe93
         TqBEYgRgUb4Rn6vNimPVEHzpZF5nYC3m9UrZ6LLKgjDH8CRkmmd3kcT4Su+AX+xYN3Xx
         gOTaOkmSNg8lQwfv+R6Lhn/Bo+9tlEWYWcg1WEG3HQHgvjL7PqAiZ3HP9Wz0f9funmiF
         3d7EPpAD5EI7ozkQM2vsHHQJFKrU8sVK8LQjfDnySomNGUP2W7e8/VmT2CTBo3ARuSpF
         9Qww==
X-Forwarded-Encrypted: i=1; AJvYcCXYLO+rveHS5LdHip0cUXu93GXT3P/NVIyxqqqfNwUY8uXOUTxzQYJJrvw/b/NcfYyEDmeop6aCdg==@vger.kernel.org
X-Gm-Message-State: AOJu0YypFJGO2Cv30DwRIFwFpPsrLL8NP0lT7d/j3u4j7MO1aRxXUVOv
	fNJZ+lj4KnfNMNTuxSfem89r1BRJgnnF0sAy8T7c74VbPNHabF07JPeDOYimF7mSlqW2ZpVxKo5
	p8N3ZgzVovNGZvXJpfki1euhoTVOg1HCjStkAvFlcV4v2ftCQR/6URJDFWb9NOw==
X-Gm-Gg: ASbGncs9j5xfw2fFbiGVo4iPFONCBJaDDR05Ybfj0jvQnEnRRXj4QJFHiu7MehF2gTy
	VcIjFRQXWa/ouLHd01dr8CIsCfvICt3xeXJ3TUBuoQByL/H3TeQPEKKhEhMMl1M+U7nzAwHZvF7
	Jr7E24wCa7jGTiBB1KN9A7wzuWnId9fIwfN6ecSwBBty0xFrg6TRdVNmFZT3K0hCufhULMhA5/H
	CxwMaRYtbzuBiO5P0dUPwM4B/LqKvICasi0ds4gKePrKy0WN1iElZG1+aQ2sMGXekS8OFfQt2IW
	NHWGFq/W+Y4vc9MonodbAC5cb+ceqDsGzOWuPcYZD1Bx9gyz79WCPdgjpn2r3zE=
X-Received: by 2002:a17:903:3d0d:b0:266:2e6b:f5a7 with SMTP id d9443c01a7336-26813d04f4bmr37704355ad.58.1758128792189;
        Wed, 17 Sep 2025 10:06:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiYS06pnxVlJyVc8usIQK/iQa6m8Xw/xXXNj5CZpC/OXWCWIJ7/dsM3zh0SSUhq8YicFepBA==
X-Received: by 2002:a17:903:3d0d:b0:266:2e6b:f5a7 with SMTP id d9443c01a7336-26813d04f4bmr37703845ad.58.1758128791682;
        Wed, 17 Sep 2025 10:06:31 -0700 (PDT)
Received: from [10.216.34.136] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053dbdsm1270735ad.9.2025.09.17.10.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 10:06:31 -0700 (PDT)
Message-ID: <472265f5-8463-e0ed-6386-f52478d4f2fd@oss.qualcomm.com>
Date: Wed, 17 Sep 2025 22:36:22 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v14 01/10] power: reset: reboot-mode: Synchronize list
 traversal
Content-Language: en-US
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik
 <andre.draszik@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>
References: <20250815-arm-psci-system_reset2-vendor-reboots-v14-0-37d29f59ac9a@oss.qualcomm.com>
 <20250815-arm-psci-system_reset2-vendor-reboots-v14-1-37d29f59ac9a@oss.qualcomm.com>
 <7eqa3rs3nvy7htvrkwyh5m7ok34n6c3h2dxn7xm2abdjzav4hp@i275ed4owgru>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <7eqa3rs3nvy7htvrkwyh5m7ok34n6c3h2dxn7xm2abdjzav4hp@i275ed4owgru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX7zKQzYPK+BaN
 TrqyMd+lJpwwuG3hjb9mesC/mIvfayEt7P4njVwvL5DSax9qnTKAcFtL0WdVJ5Cr60d+Rye58yg
 ehzKrH0FWHD7GnUvETJ4Sy8od7qwE74IZVHb+I2bfS1MdTpwOojtqHVQJ5uocGzKwUavdbkgb2K
 07rK9Dq4mAYGc8xvuuR6V2d1zjUjEPvh6RbM22ySb+zcOYW1ajTumgbt7ikxDsBIwzVdW5UqR9p
 n9naxg/JzLU1ULj3WZ7rKN5Iykz/+cqXNRiawi5iXbWeUg1KxFdPW+ENzFQbDrKeSikqVy4SveK
 L8Hk+Sote6tqIORY44bMRqhq67bWenvXvvVw+LPTfZFunnHSBSR9og190kequg360WBHQ8qV4zQ
 iD0e4zSQ
X-Authority-Analysis: v=2.4 cv=MMFgmNZl c=1 sm=1 tr=0 ts=68caea99 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=hMdzhsAlQAsAiGmCIg0A:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: MYJ09uUQ9-4_rtG2xbpYDwy2YS3Z3tuN
X-Proofpoint-GUID: MYJ09uUQ9-4_rtG2xbpYDwy2YS3Z3tuN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202



On 9/17/2025 12:14 AM, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Aug 15, 2025 at 08:05:06PM +0530, Shivendra Pratap wrote:
>> List traversals must be synchronized to prevent race conditions
>> and data corruption. The reboot-mode list is not protected by a
>> lock currently, which can lead to concurrent access and race.
>>
>> Introduce a mutex lock to guard all operations on the reboot-mode
>> list and ensure thread-safe access. The change prevents unsafe
>> concurrent access on reboot-mode list.
>>
>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>> ---
> 
> This should use scoped_guard() and a Fixes: tag. Otherwise LGTM.

ACK. Will update this patch based on scoped_guard() and add a Fixes tag.

thanks,
Shivendra

