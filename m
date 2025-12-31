Return-Path: <linux-pm+bounces-40091-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB28BCEBE85
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 13:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49DDD30697FB
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 12:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BA5311C2E;
	Wed, 31 Dec 2025 12:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JYYetMHs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QKZrAVf5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A70A322A2E
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 12:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767182891; cv=none; b=jX1NDIwkS/AZcXNyz52+2JYBFqsciiUA4y5vxR5S+cuZgHfDndQHbX0iJ15I+/lzu7jaSbRg2CxbsaZVrJR8J3eb3FZqdmJxrPMJLBx9sl9AgjueVtCAu/hTkXz78CNC21PTupMUqM2euUz8tFcyZtl5GLFJ8Ni8oSqbpD1fnhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767182891; c=relaxed/simple;
	bh=UmgVRndD2m6Wy75Clz1eg4Rh120+PEWhxXfNEPFzvJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cE2o8IUUNJQhZB4Q6+7xFN1vocXnddZ9fFJhhspoz8QfsarNNDHf+cvG03Zi0QKam5KcTsI7IEhBD/mUIVFmcysJSSMiAqQZkXJu8OSjBfpZKVshH4MdjtfdjL4tXpy8PMAwbV9aO46ukOfYoyYpe71T8c1hN0fjgzpissBZ0ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JYYetMHs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QKZrAVf5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BV62sVA2051717
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 12:08:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UiJtaHWpT52Ir4SAEeA1tuRYvR+ztp79Uz63Q9MOA7o=; b=JYYetMHsA9nLPALh
	XQ8f+wUf9nxQMuIwnd38JtG7hDZLzN4o4+TD/ckycxr+7gQaMLh50EIYQKZ6oATk
	qcll+ywSq6o0u/AHb9VB99ttFSGI3DUhoa8R31nuG4UeSmyecQ4+sHfamSDb2oh7
	LIjvbTcCuZTBVs6wArIevnxz2V03nrzDOuG8pddkbTUTiq7OfvnjZ6EAroF9TAMw
	XdYPvKFGP7jWjy8WS7i8AGO9p1sHEpzj14B6PcjsKtB0hXURCwzqKuXTcoJAOXXm
	psWe8wkK+kOx394c7HiWsu5MF1nkkvBcWBg1ArsyrKiYAAibjHW0/kZdckgMsM/Q
	TWuPbQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bcx748kbm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 12:08:09 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ee23b6b6fdso27737871cf.0
        for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 04:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767182889; x=1767787689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UiJtaHWpT52Ir4SAEeA1tuRYvR+ztp79Uz63Q9MOA7o=;
        b=QKZrAVf5hvKmajwsCxVN2iVLFGjus7hhIwXX3SSjB1gnkXQK0xkxvIOksrP5I79YL3
         mhEl+4UBUAgOUdFspf7RaIMuBLoBgxu3hb9NG+L7HZISkEx9uMBsVSxhcUBQcqx3uXkU
         W7nzdFtTTRW3+vcbE/BxHZhXv6/2gThzdsxb8kK3lzwb0EGEbJcqXWiggxu/74c7zkY6
         vl/ChihIXmHAGoYBCRSKw1JOG4b6qGH41UkjKl5N0Gc7MW2/sTDjUwILpMHdSLK5JdJJ
         gzydSeoChYkxSfeQiZXkN3tKUQt/HNwPo1KsQ64FbgGZzR9RnuTbcU1X9TcmkPEG0ErI
         bulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767182889; x=1767787689;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UiJtaHWpT52Ir4SAEeA1tuRYvR+ztp79Uz63Q9MOA7o=;
        b=a6zxLQbwL64tnXZBNnPWRl5KC8NMkJDDCAxSq1oFPWLHAaYnXymk1U/1Ke/fHu56iK
         yF+n/hSAG6UgiqbBs0lFZX7HKENu3y+gyQpYW0tywScyc+9Zmx+uqG3XQw8qijNJG9En
         4OrJVZOGejgqtrsduZQjm0OTkfXBGuc8Bi4s+mLkyhzUigQiWFqyernr6ZxNuVsXOZsM
         ZueNc5vIk8cUT5uLSuptANwCREVL8sWGCwgkacGap1LTfohqWGoKtS+pYSoaQbv6N5Yo
         KIVKMVSjl+MqzUuv7xoMEGpVaGAITjg38wKMO2QcWbPHVK8W/N9eHzBgcETIbe+ptuJn
         QZ3A==
X-Forwarded-Encrypted: i=1; AJvYcCXKP0BOA6cGxR1nUNJjdMmyhJFT9VYstZWUnU/9lYkCT3SRroZPuUkF7CH8M2lYqT2czVYrWXlkfA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywirp7D5QyOSC5SyJiHFGFda4LU7k6ot7sGQ+8RsfhWT1jUWKXF
	rmlKQZWSCdPZYl1FSZTE8XEPogsq2D2XRrphAVYGQ5aM2xjA5+H42MJsyIlIm3gh0GhVAmpUHDV
	cjuEJMyDiOevNsN266Aq31X/rtztXiO3VAltxGvHOcvH/Y5Q+vNseB5drSgxk2A==
X-Gm-Gg: AY/fxX4t31oJa5QIW4fwKxGCYR+AcvxJG9bYAQsaOq6sMGFkDkpdYK7QIv2o0LwzS4M
	pPKeMbRj0O3Cp//A8pKVSWdzrrBNBw7Wrv0aY3yuuTooNbe9kePJLkN2utF3mblZNxCUK73kE1u
	LfbfjHhLeUq4BVI5LpKNbkWFpBXdUn/R3AgsnuBEEX0oJJRoIcxGxBDA5/s/qmYl8YZtYt1yA8e
	aWP4jyUJ3rl0xSf6/Znua8xHvKAs+h/qGj15UsH55WrjjxEfQJFk0zOkasp0acBB/dnDDtGXtjy
	aCyEWntqvzbvFti80mHSCeY4NzjbTW76OkOWHelJV+qI2Upm0tTlvfoyV4oGrvBTiDuS8LhMSrZ
	GWCKMKd5HIKRlh3z0K6zDXcIHlGA5qaGp5/iEPb1mBR2Dspsx+aQWlqqBuD2hoh+C1Q==
X-Received: by 2002:ac8:7c49:0:b0:4ee:1a3:2e79 with SMTP id d75a77b69052e-4f4abddcae9mr410149611cf.8.1767182888643;
        Wed, 31 Dec 2025 04:08:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiPNC0oH8EFPcBv3otDppGjXcWFCcR/VT+vF4VQNNWa4RvyRS8nRSCSTA96lyQ4NSKnYSHFw==
X-Received: by 2002:ac8:7c49:0:b0:4ee:1a3:2e79 with SMTP id d75a77b69052e-4f4abddcae9mr410146421cf.8.1767182883666;
        Wed, 31 Dec 2025 04:08:03 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b9159a6ebsm37604637a12.27.2025.12.31.04.08.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 04:08:03 -0800 (PST)
Message-ID: <83bae671-3174-48e3-b9f8-412d21f8f18c@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 13:07:59 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] arm64: dts: qcom: sdm845-db845c: drop CS from SPIO0
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
 <20251231-wcn3990-pwrctl-v1-7-1ff4d6028ad5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251231-wcn3990-pwrctl-v1-7-1ff4d6028ad5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 2tJgygRoO0rlrH0uQLDGTSYRbx9HrWE7
X-Proofpoint-GUID: 2tJgygRoO0rlrH0uQLDGTSYRbx9HrWE7
X-Authority-Analysis: v=2.4 cv=HNvO14tv c=1 sm=1 tr=0 ts=69551229 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=wl_8aIJEU-qjyxFuvXQA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDEwNiBTYWx0ZWRfX93gtv/7LyV/w
 w7JfiUn30V75E1TAOs4Su9zhh+M+BMx17SkQwETIifWxL1cYTruM0RsfYX7YZjW4GA7y3M0Fobx
 H/rmGvCZGaUCVZh0svQzWGMJ43G1pCSj4UY7o/H5hwsAw/uRWlg8uHYZg7xgoHsJT6Q8Zcg+DGz
 ZYA8GQ5nx5WmFyybEveEUxtx/9k2S6rnzG7ydW+E/u5If22jko4qrt8zxaYCpYdCtPj6ISm9NZo
 eOoTqCcMKGamYWl6tQMIPVpQulbaaEIMYNxhK5hPhv1MlFsn7wotdl3Zvb4l1NUX0a6LxZ+EPct
 Z+zhjZL7Q28i3in9R/hKAuz3BpYkYf1wY3L22pxPftbAhRI5uuLhEAeFIw3nr6L8qKcemx+vP6n
 nAYqI98huzTqQHPUqtoCUlGeGtKXA3Awipd7EVmXhq+6vO9MqLrEps1+dKFmQtVaOtjHp1m+t0d
 5mQHzuFjHLuAiWplI8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512310106

On 12/31/25 12:35 AM, Dmitry Baryshkov wrote:
> On SDM845 SPI uses hardware-provided chip select, while specifying
> cs-gpio makes the driver request GPIO pin, which on DB845c conflicts
> with the normal host controllers pinctrl entry.
> 
> Drop the cs-gpios property to restore SPI functionality.
> 
> Fixes: cb29e7106d4e ("arm64: dts: qcom: db845c: Add support for MCP2517FD")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

