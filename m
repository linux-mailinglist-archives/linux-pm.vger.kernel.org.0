Return-Path: <linux-pm+bounces-34664-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C56B57630
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 12:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98354188B4A1
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 10:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E5E2FB0B3;
	Mon, 15 Sep 2025 10:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E4RCjceu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC252ECEA3
	for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757931632; cv=none; b=XFgeX0kS3B5oje0ILMq+VFwi9u/iLcMWMOqbJVQBTQOUYL6TwMPfXqfy4peAlFc4PZDL+SmAqWh1rs5HFipqFmYgeZgTNKfMH7Rid8W5r3rhJUF5VDPzGoQzqHfZSUPaSWGbFGzv6a5HHpEAVqGLS60feI+nmbN05wUbxOLDmBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757931632; c=relaxed/simple;
	bh=bUNuwE669bXdBGZ1MzmOAYXT/EucREWOdEjUe5wgwgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzLcTsDBQaTnMa6rgNKkkT2nNPhM5+RZj+0M/9gGj/eshp8kgxjYuTm3ADT6LzpV36e9U/WIENUsy2NTtJI5P7hqjAau7i9KuE+aJi3oCIIIcvM3dAlc9D+ovw/3NA4XdKWeDYxH5LST25fWisYqhYfagB0RmJZ8QHygXnoRV9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E4RCjceu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F8FgRv031669
	for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 10:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=RGYbORxiyAr6c96vlWyAJgN2
	Z36YAZvrHJKPyVLUETk=; b=E4RCjceuFjWsbeoW71o7Gi2o9Qwx9dCDHrhUEuzG
	cazBLKeTmU2MkLNrfYz2Y4SeLeABqUBt3K+ye5c8V43Nr0aVGAtpUOfbsrJ8fP0+
	hDARsTh4t7+fETwJLLiODO2LNRUIG6wWbwtea1bDCrLL4oXQqEPBM/2UD5Z3kAPu
	9Trq3hB2XZ3xf2L6fjosW7c+aqISWJncf6OJmryXpxQX7KA6ZArqpAg9qbxK+hbp
	cqV7Lhgj+FzfJtAfIGdRFyjGK/N8lFcp39j/ssVlQlGIMMrgXBoXHDMXsnIOrhbp
	ylV5cIiWmfru6FFKXC/5tM8OfAZ3CT4btFxEQ92zY31xkg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494yma4jur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 10:20:29 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b7ad72bc9fso4303661cf.0
        for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 03:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757931629; x=1758536429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGYbORxiyAr6c96vlWyAJgN2Z36YAZvrHJKPyVLUETk=;
        b=U5kreyyGlmY1M9yiZWsVmDJKw4LxY+EhnVlNNeWGuBi+SuSCp6KLmnIRKyUuxd60Ro
         Y0+0M/OysxhKKTsk3bVWFHVu/9EpHWnxyNmAhW2AFcMlfbeWqQKZKH9I+WXJ01GgPUG6
         s3RKLoQ0JOw6arLkiIpQv9od3RFkKKjz9pt9uLhtrv/S3AQOcqZSlUoB9aamOWVWBSek
         mSduWbaHPVKQZOdntN/7kEgTUUmy/lGygBxPBhWuokNij31JOg7Pe5fb5qtkTvGH2hs3
         B2RhwvuD7SVyZcH6Itaf7+sYfKZPAiEbK7rT5YILRy0Ur3mawphScgoTHkukVQy4/MKv
         ZEgg==
X-Forwarded-Encrypted: i=1; AJvYcCV/X/F1EQZ4vPtj5NSPoGN4XKnUD2HqCxg3jjrTnXQ/UxMFPHdhCnkFOMU9t+MXj08KTgZk+AjGQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKTLkVpIJ5gb13jcXILfIv/R4LT5D5Jom6p9K/s8OpMBzfzROm
	Wqz/BwctZC1lnNTLhmY2YPE9kBy/gI82DLmIzjqGYWd/O/mK7xD2gYgvYeFin2Jxr1ydRurUInP
	ESvtNishizViXPySuZ6MOf0r9O910fVQhOWc7JSL/HiZ1hPOX+/BaXmQ16U689g==
X-Gm-Gg: ASbGncsF2N3w51jBKX7b+PC6s47hHE+rtq942tNln7iROIPL/RZ8F2+azMzyn3KeAqt
	Pse2QfpHC76ZPb3Qwu5RlsMWOOlQkG8YScYjJ1w90y5UYmgSk6CRWSEdLjX4ROCJSMZ1mV8k4Xj
	og+3yndxPaBB467Jot4fbXlSNBF5548T/DBy1jt43aIyY9VE5RGTNK4/tAMJXMgJ+u0yZSTA9+l
	FGelQVmFec6pvoqR/rXJMPJgskc7Lbn4gXDw1yDtkmF8m/54ljw8xtHZU5svC78B585QLQaNvvG
	HCTNnZ1jqUARMPOPsFtxTU3nWn8cI0TKhXiW4+oGoQ/PbPWJEgP8plVPkKO335U93Z5NzCItngd
	GMi22bdzHjzpCokVnV/0vupbfXIcOHuxBZQIL9DTcAfjPVQu96JTA
X-Received: by 2002:a05:622a:5e05:b0:4b7:81df:95e2 with SMTP id d75a77b69052e-4b781df97a2mr99062111cf.40.1757931628744;
        Mon, 15 Sep 2025 03:20:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYwTHXV4KtjY7Dwk60uIzpz5mR+OcC0Kr5EGu4MjShIIx+gN3rPddQUBAx2RB7YbhW+OgitQ==
X-Received: by 2002:a05:622a:5e05:b0:4b7:81df:95e2 with SMTP id d75a77b69052e-4b781df97a2mr99061901cf.40.1757931628303;
        Mon, 15 Sep 2025 03:20:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-573c8330eb9sm1049638e87.60.2025.09.15.03.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:20:27 -0700 (PDT)
Date: Mon, 15 Sep 2025 13:20:25 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: fenglin.wu@oss.qualcomm.com
Cc: Sebastian Reichel <sre@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        =?utf-8?Q?Gy=C3=B6rgy?= Kurucz <me@kuruczgy.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@oss.qualcomm.com,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 8/8] arm64: dts: qcom: x1e80100-crd: Add charge limit
 nvmem
Message-ID: <vezlbc5onvmg3wd6tdr3cxhlvtmp24ca2e3vp6inqeegjhm7eu@viuurujdofvn>
References: <20250915-qcom_battmgr_update-v4-0-6f6464a41afe@oss.qualcomm.com>
 <20250915-qcom_battmgr_update-v4-8-6f6464a41afe@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915-qcom_battmgr_update-v4-8-6f6464a41afe@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxOSBTYWx0ZWRfXxGenQo5UBIDU
 g85woI58NqX0kkcAYzkFBSMCriVIuunHTQMQ1SuqTWpjuZYawmcleszgnklzWq1vRvc0mj7U7AX
 hrW9jMgPzn0caLirqcL5I7hcKHxfkw7a8YKudV/YZSioUV+IO5/01fa3WgW5RMF90N2LYYoc+vF
 rhyXqqJ+8+e+ZRiLLkYfWLcFOdHnd/L4nIUdoMS3KlMsCgRDOo5DeqT4oyXHNZ5UyR0UPw7SoNB
 Ycrf+zMeeB1rzjqRoqz5rEjBIa2PMAM5J4+feScHqUASVhToNbYDeavQLemnySKUxQFHKipJHJS
 d/7rpcoMxKYaiQRtU7g1Rb1NxqivR09wZQ2Z2CKCe/GHHVRoYe2OYqnpnwxxDO16GX4POtnfSdJ
 q4w9OFzp
X-Authority-Analysis: v=2.4 cv=cdTSrmDM c=1 sm=1 tr=0 ts=68c7e86d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=2ejD7e4gGTxI7fIsllgA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: S42Dww4gXRwU--8qkqBObxKurDI2ayoP
X-Proofpoint-GUID: S42Dww4gXRwU--8qkqBObxKurDI2ayoP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_04,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130019

On Mon, Sep 15, 2025 at 04:50:00PM +0800, Fenglin Wu via B4 Relay wrote:
> From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> 
> Add nvmem cells for getting charge control thresholds if they have
> been set previously.
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on Thinkpad T14S OLED
> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/x1-crd.dtsi         |  3 +++
>  arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi | 20 ++++++++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1-crd.dtsi b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
> index c9f0d505267081af66b0973fe6c1e33832a2c86b..fee65391653ae9c2ee23f9f3954d9ed018c9aecd 100644
> --- a/arch/arm64/boot/dts/qcom/x1-crd.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
> @@ -82,6 +82,9 @@ pmic-glink {
>  				    <&tlmm 123 GPIO_ACTIVE_HIGH>,
>  				    <&tlmm 125 GPIO_ACTIVE_HIGH>;
>  
> +		nvmem-cells = <&charge_limit_en>, <&charge_limit_end>, <&charge_limit_delta>;

One item per line, please.

> +		nvmem-cell-names = "charge_limit_en", "charge_limit_end", "charge_limit_delta";

And here too.

> +
>  		/* Left-side rear port */
>  		connector@0 {
>  			compatible = "usb-c-connector";

-- 
With best wishes
Dmitry

