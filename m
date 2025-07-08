Return-Path: <linux-pm+bounces-30390-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 692F2AFD283
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 18:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935E41884DEC
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 16:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AA12DEA94;
	Tue,  8 Jul 2025 16:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cZv5I+E2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17442E0910
	for <linux-pm@vger.kernel.org>; Tue,  8 Jul 2025 16:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993052; cv=none; b=WTo/GJ9FojY6qJ1ouEWX78jRzcZTVaZ09VoMbXG58HnuULsmU9tgyFUSl76plCYOdeX+UxwX0y9WTjVFvT9gK/TDOyk5uIpbtS8BNqMa8ODlTD16p2BlKsYn3ofe2gtlUdMx1AxhGfUsuIzCVCID4yVED9QGL+sKEzltHiCgsJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993052; c=relaxed/simple;
	bh=ukiXSSeFVFMhOkjxWVniUgNWUQsnFXBIgcndaWPz2Dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Di94WYSerE/CzEL6/X1k1q0hfyKtMdNnRJSFY3pUbm8O3BX/CAQB6V7v5CtGV6R1wX84xO9kr8AW7/oBIUkGS/ice1XFMLaD+Brpv9jNFMpRRweS2Pv0u7dDk4HFJ0mXOvpuLiRay1GFWwggdpFtLcpLi+miJ1njpsuu0LbiuS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cZv5I+E2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAO72003435
	for <linux-pm@vger.kernel.org>; Tue, 8 Jul 2025 16:44:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3VZKuAlxi75Rn12eGDb5b2eYwjOnft3owwU85zuZnE4=; b=cZv5I+E26G1+HoVo
	V5uqZyC4u4+erCE9R00CfrGbacdXRIwMX7LEXm8Y86dOlrd2A9VF+fKPywJlvPmA
	7Rn4gviyW/OpblntXarNb0kxXr1GYr+t6ZnD8yF3cS+Hr1M5fFze7/HXE3/mnMXA
	aDbFc0X+/W2NjMCGVg/s0qwY+cq3kcnwlicDlNtzQ/RYpPOrJyyfS1Pi72PZf4Is
	xNjEb3c9CQWgNO3f+kdOiU7W0VDhU8reyRLKfmzX2plp5s3LQvo6Whz+kJ34JHLW
	Q9dtihlATF5n90jV3xuBKxebSlpo90oE80+X3rdLT4ceFpTmexCmML5rwtaKyWG3
	jIL+iQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pvefg73q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 08 Jul 2025 16:44:09 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7d097083cc3so73121585a.3
        for <linux-pm@vger.kernel.org>; Tue, 08 Jul 2025 09:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751993049; x=1752597849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3VZKuAlxi75Rn12eGDb5b2eYwjOnft3owwU85zuZnE4=;
        b=XBlKEorlYgY3SMD+OOdPsIMNC06s/2/3DeKmxXyY2u+GVYhV5fKnbE5dFB/ieU/Zr0
         G8Y3sbRccZ4lajUwwURmQdIL3TSTz0RqkLbr5CDbzrR5QCRor3QFlPAuY+VAaKQGi14P
         XUl1pfYlS8jsM4l+vY9J/bM/ymadVlhbIXkXLTb8vjHpbrGsCy5Nb5IMpaJ35/VNmngE
         wQEQc30mlI/R7bHAwMTQguF95wNH3ZXcYnZR5Lkq/zEjmTxy+QzbVydrgsWWXdVmCyaq
         fkXQBRZ0a3Rbylf6BPLDqjuFeqFxZCaSCPdRfKqOrBHXG+jNRP+kDRNJyrQBYXleLYA1
         LUOg==
X-Forwarded-Encrypted: i=1; AJvYcCVrdUYipKV+3kqFMZFcHaKpigvgQ1Wj1xYjlbe+Q8tHY/Nki9CHDCWLi2DPTZvjmR24I+SFJDgtpw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkcIDJJnbXuLt6o6sH269H5C1U1JEPC1Asp1hWOfveWOtZ/3Ur
	qQaJaJYIOVqt7W4Qt7TEvQto4IL+gGAMs6INQfzm2apVkPJWANKGIkAqqPlv6LdUH62mmsCeICy
	+EIE1vNJ6kg7KayVKK84IwQgTszj/12ZGLVe4Z3E71Mx/9rcg7jfL5+DjJwPOSw==
X-Gm-Gg: ASbGnctaLRkwIrwdfHDvvY0JBzPrCU5Gs0Zjve62E/TVIi5CADM8IZPiCj+MhO1I9+9
	S2Kr/3AR0iwzFACBdRcF9o2CFQIRSituolIpNuuMnVRYOtn38V3qjaZ51qTYpi2po0zI2hqWN01
	njYONe26WmACIRVkfW9P5r/ssZBPyaLTn4OhdUttfVDpTy7ECvGgBwMqA5aGaIH6wEOs0pyusS8
	P8O77D/+n9hFS2hID6ldukZWC5u/JCtW8KYExbP6njNR1U5QHs6tHtfVpzoksJJA9vuSxKK/6Da
	Xvo/2e4ZvgrxeRnb28KJ0R/shIp7ufehkbTjJq7HDc5kQQaoXMLJ3Uw+/eCGs3WtKDrXcCk1b6X
	F1wI=
X-Received: by 2002:a05:620a:2944:b0:7c5:9ab7:3012 with SMTP id af79cd13be357-7d5ddc50daemr801621385a.11.1751993048888;
        Tue, 08 Jul 2025 09:44:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMwGjIfNhpihUDcfvAlJkrfYY5TjG6OzWzgm3+25npy8cmSQsjF2jpVNr98fOmzv2zvx9/VA==
X-Received: by 2002:a05:620a:2944:b0:7c5:9ab7:3012 with SMTP id af79cd13be357-7d5ddc50daemr801620485a.11.1751993048528;
        Tue, 08 Jul 2025 09:44:08 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fca696480sm7566674a12.27.2025.07.08.09.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 09:44:08 -0700 (PDT)
Message-ID: <cef8c989-4a0a-44dd-b0b6-15454f98193e@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 18:44:06 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 28/28] interconnect: qcom: icc-rpmh: drop support for
 non-dynamic IDS
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
 <20250704-rework-icc-v2-28-875fac996ef5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250704-rework-icc-v2-28-875fac996ef5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE0MSBTYWx0ZWRfXy70ACpKXZO+A
 kY0rU+duDpSP+5jhC5tBHa+l+Qa++0IAttILP+v6jkjdGVMKIDrr0Zki7CG3FMGuwEXZ2TfiM8t
 fy8XPWgjx0gSlNp6gPyvKj74FHO6aywZLYhe/dbWR620JsmpgjzpAB8rZvC5hGDUjAjHXN3s+G0
 aXFCKDtyEE8mkYXKs4JUzxgaqk5jXrVj/JB8d2AykRyoHUSv6JqVKJE5cxX+ZDefo5PKw2KeE/q
 uBwBs58e80V2gLF97Ig+2ehXXvWne8Mi52INBUjS9RNnsEQZlmgRN3GUOLraU+nTpDNsAkGYrKj
 66MJGSSxvAGgFRI0IpcO1+yzmaWqz1acXPQxISYBnbEQPezXh+Cz6wN/gtTrs6ogf8VU1tux9jk
 3KVOSPyY7lwkFrzR7IPc/rKk5CZQ7UtDCzO18vLuYDE+NJs1IS/LRxXCRNGTslnAFdcyUq2B
X-Authority-Analysis: v=2.4 cv=dciA3WXe c=1 sm=1 tr=0 ts=686d4ad9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=SOFPeg2F_ukm4-QWM7gA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: tVfzXXcHtfWu_b4a2BfciJSMWzH6akkC
X-Proofpoint-ORIG-GUID: tVfzXXcHtfWu_b4a2BfciJSMWzH6akkC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_04,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080141

On 7/4/25 6:35 PM, Dmitry Baryshkov wrote:
> Now as all RPMh interconnect drivers were converted to using the dynamic
> IDs, drop support for non-dynamic ID allocation.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

[...]

> diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
> index 941692cbaf208c66a27dda2e6902b2f26f605840..796fba9fb316cf58ae2eb77af1607d6d00c38438 100644
> --- a/drivers/interconnect/qcom/icc-rpmh.c
> +++ b/drivers/interconnect/qcom/icc-rpmh.c
> @@ -280,14 +280,10 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
>  		if (!qn)
>  			continue;
>  
> -		if (desc->alloc_dyn_id) {
> -			if (!qn->node)
> -				qn->node = icc_node_create_dyn();
> -			node = qn->node;
> -		} else {
> -			node = icc_node_create(qn->id);
> -		}
> +		if (!qn->node)
> +			qn->node = icc_node_create_dyn();
>  
> +		node = qn->node;

we can drop the 'node' binding now, I think

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

