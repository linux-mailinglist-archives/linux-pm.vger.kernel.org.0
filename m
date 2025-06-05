Return-Path: <linux-pm+bounces-28138-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35ECBACE9CB
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jun 2025 08:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF5883AB38C
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jun 2025 06:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE681EDA0F;
	Thu,  5 Jun 2025 06:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HdpBg1Eg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E161B1E521E
	for <linux-pm@vger.kernel.org>; Thu,  5 Jun 2025 06:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749103727; cv=none; b=EbUYKwr+X8QwuQMyauPKABdY+QDgiKU9ABPYjTLzBokenU+AU9ZeCU3pPFWKrx/x+OVKpuc+Fn+Hj5G/FmqsuhvT2AXJaUhS6s73Y+iFZj0Lolh1oh6pTHXnzlp5wL23C5a8QWUB4uzWfHek277vPN2RvNHLmfg0IjF+KwWOujo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749103727; c=relaxed/simple;
	bh=obxsLj+ybBp5DKxbHvEzq7j6OJDIdAWkKYrH0UW56Ek=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mNO+NyDpUMywbRCb3V3RJk3z5jXa+49Jg8nH5mSHvrVdZSJS9UXRsNR1clHLCEmkHvCw/mQLL+YMgQqM5+W7+eXxNlAX0UKJOKmCuMMTq87ujocJlvFagdmfsAm/CfpDAmsYgJOMYbI+8bz34Vvv+WCKeP++byO47eikgqXjVTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HdpBg1Eg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554HRbS8004261
	for <linux-pm@vger.kernel.org>; Thu, 5 Jun 2025 06:08:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yuUom1uLViLFA95wFkHWrXsNJPx+f0un14vZ3UUQFxc=; b=HdpBg1EgCCkGTopG
	1I6U3YnyLIXjqCHAHCBALdMKIhi8SopUDmIeIrQRUDIlNqP9gNDdxrqobDV/RjWW
	GXlFKNG5UzrcO53a99nd2WxgUG29iPXdcEyyvmSziUAWk5M4GEzWi9xR8GIvWNU7
	8t0I85Jp6GxzSkFaOFBV9kmZM7YMhNAVArJQceNfI1mwv65iqGNgWKaGkkKJJSx8
	9VbwXsa6txAajJXK5xxvdm7wZ1qckie+8Y8bNIEeMOpy936Aureydwovn0fA158j
	7syJ8SvibACynGseQowcg3acKMUPn2mIU7jTMIdcz1Gb8EUIjN3viw4J5ONyTSeB
	0uAFmA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8s0apj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 05 Jun 2025 06:08:44 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-73bfc657aefso499371b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Jun 2025 23:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749103715; x=1749708515;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yuUom1uLViLFA95wFkHWrXsNJPx+f0un14vZ3UUQFxc=;
        b=vfgKM0qa35mAbcKw2jvf/AmbG13CMnEfslb2ez6ZCVAzMTaEbcwcUOlhk0pnAEAsIO
         UuMAoEEgnlPAzKVEcLQk69dcsStqPjQLVHaXnPwXhtxXrc4+9KmGZtQbtwwQ4qPua482
         PEtWGOgQDzafEHF89JT6lrPgEn2FTnLIGXb3jP/iDupWCIVdU0U8U/+oa8xVefJuINFN
         h3yd0N8beZ5ERZk4JNxXc2Xc4CwL2FWvf6PlMEyybhXSFA/ck0447ZWjmV1qyFDaOXFL
         RZzHBg4eSBBICyPNxZMd5Y683kKoB1MmnIcgrY5VniBh/tAD0gyRh/aILsF0tFS4YAfl
         yrFA==
X-Forwarded-Encrypted: i=1; AJvYcCUlI7Q4pxvIaDhdl+wnAFkt9b/z8zApXoFurTJ5B6Zkj6+9YAKleim6c0dveZV1acEEOTb/xRqt6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLdpKBbYdTukxzumdkNnF5MNwj/nfxdFnKU02DmE90HqWrH974
	eJ+VcKjx+90IafQHfqsDcoUo5VfKLz96t1KX579E5OuYavfGognGdCiijP4UTXe3KASex5LN6o/
	/PRnmLE1Jnd3RXRAuAnp3lFUE+SapFM0W6n99LM9QT7yfrnJzKLHe8A8E/UEXUQ==
X-Gm-Gg: ASbGncvfjqtZJCmoXkowJBrwQzPznFxM2S1sHyTKpiQWp1cavMYQEEj6gKcvrSE1t+u
	NZEYS2u0eKlfKN38MVegHj7HB8TLreYTJ8kmfBIMXT350DYvg5x2cGTasDkFTlg65naos2jvPe4
	Q7At4K5EMilnMOS7PmczpsbOGS3TRnWoRmVo3CpS8+eycw5zYLKhTs1zZZZh1zodnHOzrxhIOiS
	xEsXAlhL3OPKCCEQMKqP5UhJwVZSSSYDS1RcEN5/9YeJ+1AepRptWpzR31liE4gJVZ2ZZcwvnUb
	xEYgp2C5V/Yo1PIzSxj3Mg9CuKyqmJ7QCoNHu4GNtkVGUcxwXJzs1RD4hrTQ77S/fwndZ5FIWac
	U
X-Received: by 2002:a05:6a21:3282:b0:204:4573:d853 with SMTP id adf61e73a8af0-21d22bcbc4cmr7791381637.4.1749103714903;
        Wed, 04 Jun 2025 23:08:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEu82MVDHVKpp8Ta6NIo45ITXBkJKjQdLSDIXVXjZuHMYFztmtVjRfZs6jpP6ebX+etviRsgA==
X-Received: by 2002:a05:6a21:3282:b0:204:4573:d853 with SMTP id adf61e73a8af0-21d22bcbc4cmr7791349637.4.1749103714526;
        Wed, 04 Jun 2025 23:08:34 -0700 (PDT)
Received: from [10.133.33.140] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affafa64sm12497732b3a.93.2025.06.04.23.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 23:08:33 -0700 (PDT)
Message-ID: <994cb636-50b3-40f8-baaf-0b1afa2e7f53@oss.qualcomm.com>
Date: Thu, 5 Jun 2025 14:08:30 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/8] power: supply: core: Add state_of_health power
 supply property
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@oss.qualcomm.com,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org
References: <20250530-qcom_battmgr_update-v2-0-9e377193a656@oss.qualcomm.com>
 <20250530-qcom_battmgr_update-v2-2-9e377193a656@oss.qualcomm.com>
 <6oixvnhihgjucqaovkayzm6cpi35jfmtwmm67wa6h4nlmhr6w5@ggb7auvjzos2>
 <cd2964b0-e28e-4ddb-b319-9b65fb78b73c@oss.qualcomm.com>
 <p5nxjuexggzxttislcaum7vomawnq5fncos7itfib6ysvy6a4k@d5ywmfpqyk3s>
Content-Language: en-US
In-Reply-To: <p5nxjuexggzxttislcaum7vomawnq5fncos7itfib6ysvy6a4k@d5ywmfpqyk3s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: zLCZKn3CZRf938M-3A0otE8gliw4FlHI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDA1MyBTYWx0ZWRfX4awJGcK+ZnyZ
 ir/AmtL5/m9Ey+0lmrZwEDT5jzvrMGFIQz1+R/RtnACGP9LLKbY2fWNFYitu4p8ITeGj/DYHkie
 7RExqdao1V/c7M2j5irqtxp8O1v5szBBUGVf/d1yPWKOQliHjsGiQxOrNRHoKvvbQT3MSvcHTt9
 9apFb6TgFC6YtXQIOsfJ18Lyut2ftpOo7QULoMU8ASSFNmU5UyCPrNlZOJUz0thoyb14SNB22+f
 3IZVjRN+3GU3uiES5U6dfOr0HI9rmZHD6iGUTKZ5iH6jL4c9fT//SSF7DLGIxgI7DsgnD3Vi/Kj
 zJm+pQ95ff0UqCIf+OZTzk8BXzbv/nECWiLGZPnEAKuqnW4XzQYcAcGZY2+PI9LZyiT8IhYHE3S
 hWJmWZJVA696KaX3DYEDitZSbXFL1qRw+Sa6nrAzS+x6gtooO5bu6uX5i3x7VRHNsJzPcPv+
X-Authority-Analysis: v=2.4 cv=RdWQC0tv c=1 sm=1 tr=0 ts=6841346c cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=ocYFPldkPzyi_qN8VkkA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: zLCZKn3CZRf938M-3A0otE8gliw4FlHI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_01,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506050053


On 6/3/2025 6:35 PM, Dmitry Baryshkov wrote:
>>>> +What:		/sys/class/power_supply/<supply_name>/state_of_health
>>>> +Date:		May 2025
>>>> +Contact:	linux-arm-msm@vger.kernel.org
>>>> +Description:
>>>> +		Reports battery power supply state of health in percentage.
>>>> +
>>>> +		Access: Read
>>>> +
>>>> +		Valid values: 0 - 100 (percent)
>>> What does it mean that battery has 77% of health?
>> I will update this to explain it better:
>>
>> Reports battery power supply state of health in percentage, indicating that the maximum charge capacity has degraded to that percentage of its original designed capacity.
> Which basically means that we don't need it in the first place, as we
> can read capacity_full and capacity_full_design (or energy_full /
> energy_full_design) and divide one onto another.

Hmm, it is true in general to quantify how the battery performance has 
degraded over time. However, estimating and calculating for battery 
state of health is much more complicated I think. I am not an expert, 
but as far as I know, different battery management systems might have 
different algorithms to calculate the battery health and report it in as 
percentage. For example, in Qcom battery management firmware, a "soh" 
parameter is provided as the battery health percentage based on the 
real-time calculations from learning capacity, resistance estimation, etc.

