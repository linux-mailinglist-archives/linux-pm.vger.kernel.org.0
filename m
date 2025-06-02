Return-Path: <linux-pm+bounces-27950-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6E5ACA966
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jun 2025 08:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5DA189E133
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jun 2025 06:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2901D193436;
	Mon,  2 Jun 2025 06:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="euq5XaOu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A370A29D0E
	for <linux-pm@vger.kernel.org>; Mon,  2 Jun 2025 06:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748845068; cv=none; b=WbBbcC5c2RbkfHKHrZWLzDoOPLXk5mmkqIdA/YuKi7BxHu7u8vrjr2VkuADg+TbA/6eGtAoa/BzO4dgKWDc8AX/35E+k1ytL4DckgOxY5XwJzSFg9rHg06LYGOT4XJ6PeI2WDQK/onHO0ez5YdCyTV51WReMJR/T7UTLxYnpfb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748845068; c=relaxed/simple;
	bh=CPZaR4EI368+qAI3lHWNS2wXQVdHRdGqRCZIxygqlUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GpY4JqoqR/6kdkW9HVmBflpKoNH3+2ITDN1Fm2zCON/QmXb7Xk0NmNRG+imt9ghU1bNUuYF817vIfs4scQ1Wi1ohMbBhHcKdJA8rQdo9cxXxbt4SfWB5FJ3iXICOKjrcaU3dsdeKvWKwSvKNMTc6/HAWw52yOrSNxAueo0z65Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=euq5XaOu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 551NrwaE002855
	for <linux-pm@vger.kernel.org>; Mon, 2 Jun 2025 06:17:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=uWhhuDrzJ7payPyIOKXiW673
	AvOva7B7U3C0U9pnehA=; b=euq5XaOuYWh86iSwhgsrlsNO+OuI8kL5F+GKjV3n
	mXv+Pn8XGh5G014Z0gKEkLqTpNe4rdYWblFrUl4ZPYsaOxnJU9pfIVqQ+8+0oFIw
	E9SkRUU8abO9Nn2ECJ9/26keA7WuhrUFBV9WANWBqg7V9Tef+kot032a3D+/GHHQ
	pXG314+MxTJUAXlYOoFQcW6Bu3Zq34ecomILrMZrVMMYW7mkXJSpnq4nU1aiUVpk
	D0/OnHMbwCtJhJyJgNx90kxhh9xzDHYSUCtTJaOPk54wovX7oWoBEFnZIZmOHGGU
	YZF3pMYZM0RL4uGchiaxBuZc/HKQM4w5i3vBeDKmYT6XLg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46ytkr3hj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 02 Jun 2025 06:17:45 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7caee990715so1237026085a.3
        for <linux-pm@vger.kernel.org>; Sun, 01 Jun 2025 23:17:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748845064; x=1749449864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWhhuDrzJ7payPyIOKXiW673AvOva7B7U3C0U9pnehA=;
        b=rtRIlsWSUDZgas8gqttkYqpv5l13U/VhVS2YpdVpLqZm76RkFyXWW9IghKX1Ey6sHl
         k/9di5EH1DrM9qL0TujY7Y/SO9y6rz61hdVaOrm5ZZWCiDSJsn9c2GzzIVimzVPbqAPr
         zgGThuwEtM8maDw9JCQ2AP4KV/OUluwAsvd1qVg82G5lXwtqdg6h6RhcHBzFpjFJ4pIs
         B2FsZoAs4St0cet9V1globEeAdtHvy8XOWRXkyV6Vw7GfsokpkUL6w3q3BLF+4tSgkzW
         8/xYM8DpmyxPQj3F28Of0Tl39Gdxh6bj0/44eDJVFRtFwKgTCaZXb9Re2to9D90VObbu
         QL7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOUOLyE78BnOPr+jAbnRMSqRYdf4HrURGCgZ4Dyg5WfHbwg4420Lq2TLE0eSuRQD9jeq3sA4N6XQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YymfT7sz1DaaTm5ZYG/wGRiKzM7kRHuYwP1VPP5wfPpG+z2IJ5b
	+Pq9CCaIjFn1LhfS+JLZB+Z3joDIce1UvCT60FCRPtAiv1NseS6G3+9C4TNJXcePJirWzBU7k0y
	ZFFsBwqtn3kLa+ORdUEGZBA+ZY5yWJtsVnbQ4Oq0Ngg1njrm6ILnsWPoEyJQmGg==
X-Gm-Gg: ASbGncsErE6fSYjCQEwtM82BNKj094VkBiMl3du/JYfeK8X+8hSVysHWH5jmp4bq/dU
	fcMcl2VKsDzCLkEm172+xa5OKiaU0ukBsl0kTCUu3vaS3mqBiVHMIhnDKv4+1FI89VmdzvJMcMh
	tLUNEX+dhV4Vhi0oKO9HV1u+FPCZfLLc7ApzwliNV1sOgJBy90BOTxh5+/joeyTde8Knu6FDylb
	ammAdcIPQQPUmiwEi9mG9McnpshuNAV9eyrrbXdN7mwe2gr1J2LDkFMY0ViVQsyZS22xlHaAffM
	OuT2ukKF9rAiC8MYdKMDcr6aWZlH50cEOF4QnMmLmdUK7koNmCuWUyIpOFghUmbPqHeSbbI0ur4
	=
X-Received: by 2002:a05:620a:1914:b0:7c9:6707:b466 with SMTP id af79cd13be357-7d0eac3ef5emr994660085a.11.1748845064639;
        Sun, 01 Jun 2025 23:17:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCTsG7gNV2L9uzFU78EGu/HBkU6UsfPpuVFGPKTZpetTg4RTTOeadhiy1mD9FC/+Ns4ZATsQ==
X-Received: by 2002:a05:620a:1914:b0:7c9:6707:b466 with SMTP id af79cd13be357-7d0eac3ef5emr994658285a.11.1748845064325;
        Sun, 01 Jun 2025 23:17:44 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5533791cde4sm1476155e87.192.2025.06.01.23.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 23:17:42 -0700 (PDT)
Date: Mon, 2 Jun 2025 09:17:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: fenglin.wu@oss.qualcomm.com
Cc: Sebastian Reichel <sre@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
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
Subject: Re: [PATCH v2 3/8] power: supply: qcom_battmgr: Add resistance power
 supply property
Message-ID: <4jnxp3pnr4aqy6jaqxnh7ki3uhf7q3552jxs3ixd6imtqlmrei@snohn5bjyt5w>
References: <20250530-qcom_battmgr_update-v2-0-9e377193a656@oss.qualcomm.com>
 <20250530-qcom_battmgr_update-v2-3-9e377193a656@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530-qcom_battmgr_update-v2-3-9e377193a656@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: JjbpgeFdm9sPLryL3cf_pG4AOJ0aPtkR
X-Authority-Analysis: v=2.4 cv=OMMn3TaB c=1 sm=1 tr=0 ts=683d4209 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=zDes-GqUf9req-RX5QcA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: JjbpgeFdm9sPLryL3cf_pG4AOJ0aPtkR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDA1MiBTYWx0ZWRfX2oqoRZz9kIVd
 cVhwSOvnLipwZZQjLlHQA/mKJfSAKECD8NPWVKsGjjWL1D7nKMWtDpnN+BvoDlyI1upRWldOguT
 FUrTOiTBIYYcHfHMf0R9tU9yOBUVW/uLnZFc1eiLZE3hBz2JUQvesE31bEG6zqtD79rL9ko1EnI
 bmsZzYx5PubAGAjGU2QWLctKICfZHq6/qaaqGbqu4SldohmaHPVc5gs5fjzf3Pw91vwAT1UYi68
 Q2Dgm8WNCW7d+Tq8/4hbEbf/brpgvpjvFUflgOGXbXkeHfwPD9HaIVeprSVrbXyQOeOzl17XvAF
 yR3frXe9FohJL0NIidWwDqSN0BJzGYLInTswyNNcT8V+G0KIXXWv+rULecoVBPri94y5//lGXuI
 XJPLOghhxHQBpVZQSTlDV37FkxqpaF2A/kqP9eFn4Qn/vy3omyZMo9FxoJorr47jW/l8lWHD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_02,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=941
 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2506020052

On Fri, May 30, 2025 at 03:35:08PM +0800, Fenglin Wu via B4 Relay wrote:
> From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> 
> Add power supply property to get battery resistance from the battery
> management firmware.
> 
> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> ---
>  drivers/power/supply/qcom_battmgr.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

