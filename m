Return-Path: <linux-pm+bounces-27986-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2442ACBFB8
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 07:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02B3F7A17D2
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 05:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911131F0991;
	Tue,  3 Jun 2025 05:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PMMeDjDY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232021DFD96
	for <linux-pm@vger.kernel.org>; Tue,  3 Jun 2025 05:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748929699; cv=none; b=gzSGQvFCZZfYVjUeUHFZojg+ioJBiZurMZzi3k3MRd1pNsbmlff2U/o+94OlyCB9XT79lc+mSPM4dN0MaJ+S4etBesVsHxhp8IMcc1X8rUPVfFsR+/7UnSD1M7eyKQrDalOxn03Ph0PcDCn/8B9V6Qpxg9izRqUjP9r9Q8/041A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748929699; c=relaxed/simple;
	bh=aKj4GZ6PPp/Nz5rkizthBgyRPAg8m37h2Nts/v5Lkpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UEHJmKl8eL2z1xolId2J56b2+TSNkB/2SOJDPlZcadRtXpsmcpQ0twCZe08BmRW3YMa3nLiNm5GBrkrCLsvcYSNM6TTaRoepv10npIKFlmasC1gFa7B9sDgJIFk5H0bNte2zWwgJrR+ErfKFXPmTWI1eK2UtFiVZ2EDU4NHM3P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PMMeDjDY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552HK4jI012233
	for <linux-pm@vger.kernel.org>; Tue, 3 Jun 2025 05:48:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x60maCMmz6HZ7Ug8+bGFKM1JZXBpI0KP2xH2KVmpU+w=; b=PMMeDjDY3puQMxys
	t1Ii+iOdBbmKvmXBEdyK7nxAO1FI5EEy1lEK5F7d/3S+HNBMYgjxlJjGGW2XLnid
	mFtD4lobaqq2j8un3/a3hsdtZcZmOpkdkLNJKInyHbOdqilKPbZztW5sbfgqxE3h
	uhyo0uxCRH1yn6tnRcWn85vPhRklBwxGZWBsoFkymbgg++MVFN7D5qdaR1TbNC9z
	P/GtNcVK5v3p9XnxdpLILzQ4NkTKWqpgLt0nk5hScwd1TLpzB8BtCdMU5OwBt4GV
	nA5tT/7lcEtvzYQYo9xQnGX1IhGTryeCjD5F4jXfN7IVThU8qsKZcvoGH+0e8FQI
	2bUDfA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8ssfc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 03 Jun 2025 05:48:17 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b090c7c2c6aso3348024a12.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Jun 2025 22:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748929696; x=1749534496;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x60maCMmz6HZ7Ug8+bGFKM1JZXBpI0KP2xH2KVmpU+w=;
        b=E8JnkH0PdaigqYZDCqMXonzV4Ii9EWLYLGHAasIt7N335uMhI/83y3Q2ZWQ8cM8DM8
         Qo04jLFJ54IOA73Iq0pLOpiRY3CXcIbbJlJPc+yCp48oztzKLo1VMiZnHFOtGK7GtQgE
         Gt2E9/4MX93pS9ryHzGfJWLg/5xo+Xagt4h7+WUSQ0bSch6Tu6Of0YplM4K8XmD8+9sE
         mz7Q7PTdaRSiC8O3HSHC5zpEtEIkQLMCGy5Hq175S9tdGHUFyjlVpLy1fwc9QMQbgrP+
         +CUbszbyDUUCH9Oa4VT4RHs671+V6xl5qu1Ou0oZF0b6F/RdX4d9igW2bB4eJ02leqlV
         +kLw==
X-Forwarded-Encrypted: i=1; AJvYcCUuccKVoNrXw1ZDQRPQjfH/Ew2oEJhP+n4ixIO2ieW6SNGWY1sryterruWnjxmMjEIKJTJxm7rIXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDX0GNRVcriCj71fGkx5eADrLY78gdM2GLgakisWHOWOtQzBLT
	OyZIb5UShCnmVMDoixZn3pMGV/oORjIPo9wDx4/WBSUhnk5lBdNdDjwf7lV6yatEmer27+bcxP7
	VcNsHD6EqUU+bxQRf6k//CBS6eaMp4NoJ35CVRNfqgDYjRJlkBwUnWYeyQDGDtg==
X-Gm-Gg: ASbGncv2oTSU05mUaqwH5+jPnp+XImaomw1dbzIA1GG/sTC/0yVPg98mZxD6BAVRwKW
	S1gvxPEMIFOFV+mYvsuetSXWNtlUXksdiqSaNmkXbYqsokocpw36CvzQA9wxrokSFf98xWFt5/l
	OBiDK//c6ooCtOjpbFoPqzeAt/9MwVRgmjVRiIsvw6rbG6vN89uwajNQyYwtWtyZQhI/2QDYiLE
	sEm6dF1aAdcvE5buQ76DeRAJOZciTPpSEhbxb+v6V+jVNbmPuL4g7/ABcAW+2O1olzgt0KYJ30V
	Vn3Pzyo3dy5o3jr0BBATjI3AjwYPHottowGOqaFFoZjCfshSbbpw7GB8m0VgOFI/7l3mfAbhICu
	X
X-Received: by 2002:a05:6a21:164e:b0:1fd:f8dc:83f6 with SMTP id adf61e73a8af0-21ae00ce7bdmr25596984637.40.1748929696385;
        Mon, 02 Jun 2025 22:48:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAtEPb0qgjBapOIIc/FVtRuoOheBabfhP2QQGPgPqaMfCZMRqkfWJocE5Xr1V3SkSH42ofug==
X-Received: by 2002:a05:6a21:164e:b0:1fd:f8dc:83f6 with SMTP id adf61e73a8af0-21ae00ce7bdmr25596940637.40.1748929696012;
        Mon, 02 Jun 2025 22:48:16 -0700 (PDT)
Received: from [10.133.33.127] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afff7464sm8636060b3a.180.2025.06.02.22.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 22:48:15 -0700 (PDT)
Message-ID: <8bb3a056-c00f-4ae0-a790-d742d31f229a@oss.qualcomm.com>
Date: Tue, 3 Jun 2025 13:48:11 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] power: supply: qcom_battmgr: Add charge control
 support
To: =?UTF-8?Q?Gy=C3=B6rgy_Kurucz?= <me@kuruczgy.com>,
        Sebastian Reichel <sre@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@oss.qualcomm.com,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org
References: <20250530-qcom_battmgr_update-v2-0-9e377193a656@oss.qualcomm.com>
 <20250530-qcom_battmgr_update-v2-5-9e377193a656@oss.qualcomm.com>
 <f2e0f1da-c626-4cf0-8158-8a5805138871@kuruczgy.com>
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <f2e0f1da-c626-4cf0-8158-8a5805138871@kuruczgy.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: UydRRffqGLK9JVr6uvTRrezaIG9xeEma
X-Authority-Analysis: v=2.4 cv=EPcG00ZC c=1 sm=1 tr=0 ts=683e8ca1 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=g1VTAUynFBCLE_zrBTUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: UydRRffqGLK9JVr6uvTRrezaIG9xeEma
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDA0NyBTYWx0ZWRfX/Iv7Sb+latXC
 xLyfMMCA8/IV/sXoZ8wfvRJwbZlz/Z4IbB3xh8P/TNxQtkfqqFUi0IJUV6rCGFlZ1oQ+OX9u+5V
 /DuoSj+v0ttM+uTdiyDdzwsijoxNqxXC9Re1GBCvso6Ls8GUo/JN7okJMJKPwXYfnnY9im3yuMm
 n1QnAAPksYySiNLwjALB+D8183T+HGohz6a8oTIMhxV62WMYQVMlaigkFP534kvl9/djLrWU7P6
 Iclp2bkpKmF/I7hexDqTnlLJPDzO0tMe6onxlU8wSqkwVttzz7u43MJc7EOn6aVUQ0sZKgYZeKp
 WkEU0ro3mAKpairzDW2Gxx/j1UC5eIThQ3vwLLbH36FXwZuO2yKAFqvBFl2ce3jwq5XAE+mJ9c5
 GAew0BOTKaiV3LzchgBDMdA3xI3msMa77ie+RWSr0rcl5RDQOrZmiAKxf3P2a4d7Hg1Zy1Gr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxscore=0
 clxscore=1015 mlxlogscore=737 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506030047


On 5/31/2025 6:36 PM, György Kurucz wrote:
>> Add charge control support for SM8550 and X1E80100.
>
> Thank you for this, tested on my Lenovo Yoga Slim 7x, the limiting 
> works well, I finally don't have to worry about leaving my laptop 
> plugged in for too long.
>
> One small thing I noticed is that after setting the sysfs values and 
> rebooting, they report 0 again. The limiting appears to stay in effect 
> though, so it seems that the firmware does keep the values, but Linux 
> does not read them back. Indeed, looking at the code, it seems that 
> actually reading back the values is only implemented for the SM8550.

Right.

Based on offline information, X1E80100 doesn't support reading back 
those threshold values in battery management firmware, so I can only use 
the cached values for sysfs read.

>
> Anyway, this is just a small nitpick, this does not really affect the 
> functionality, and I would support merging this series regardless of 
> whether the read back values are always correct.
>
> György

