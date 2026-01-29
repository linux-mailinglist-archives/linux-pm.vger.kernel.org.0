Return-Path: <linux-pm+bounces-41658-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIanCjutemmv9AEAu9opvQ
	(envelope-from <linux-pm+bounces-41658-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 01:43:39 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 589EAAA52B
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 01:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0EEC5300609C
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 00:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1716D25A321;
	Thu, 29 Jan 2026 00:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V3GZ+HWL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fCgc6Eg/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42AB2494D8
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 00:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769647415; cv=none; b=VgifJyaVAl2x9Lp4oYrEOTV4ZSy5a/zir5aCXJZGlPO5bwugi1/wiJRwaYBoLN7mpqIcW+nDyGYfPi74Ee5u24vXvo0iaoVWBx6jDF4YlRfozUg1uDQfw3jPiuVmeSrRQ6zym+/cvJfevum0CWkcLusoYSJBk3LHtpfJJVgpGos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769647415; c=relaxed/simple;
	bh=NzMQri6zt8xUTjE2FymoITkNiCbu2IOthjmRupTpRMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNn3hCj2pCN22tXlP8lNxv4o32eDdxndRAC7etBr3Wg+d7vn/AwV2ERwBOrAOyBcJ0lonfYOqcCi538E7mbHx08LUZQ6shRYNs6f+rlIBqxEXvIqQETrQDEHU9+LqpdgMG/O3YG8b1xMntn3N7wz7oti6rFr1u4gggeilRa14YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V3GZ+HWL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fCgc6Eg/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60SIO0P22081910
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 00:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bX7afXRfCQDK+en7SrtIzGAhO6+OT/6JRMev9l6gCus=; b=V3GZ+HWL9HvvHACU
	f8YG/kPegfK2prEbz3GJFSSp3SlwoDEQFSqeaGoQHc7UcDn3DKqt8V6mafQzlqba
	tbVV3Sym/SqT+9S8UiPNqPTkiUHJcMQ4QmycEtXxljACxcdzAZPHTME045hwPoSb
	xyZSd8MTGkK2+bo4g/TPgsUdS7e+uB6WknDMobJZ8IdTUh1DyJQ8LfHt7tUbTT+i
	6P9x0Udv53ywCFJFAVGeWeLjk0Mn2Hj7ZpgvikIjnfBRZyR950lmP+eRR0eE+S/p
	qJdCfp8+yNN/LJWkNXVPThwWMLodS+U12627OUHLYHrfnt5LlGuMXA9lrt0Lxa9f
	cakQTA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4byqpxgwc7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 00:43:32 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-948476b92e8so528477241.3
        for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 16:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769647412; x=1770252212; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bX7afXRfCQDK+en7SrtIzGAhO6+OT/6JRMev9l6gCus=;
        b=fCgc6Eg/z7xfhL3Ds9klMWhlta8dJjznDWOFn7KaxERwTWJit2zBevLUXJRYKnFeMf
         jSMHEYD8wI+ONhPmvJSscvgNtzxmyzgOto23ItSQExvNonfD3vd9ogSDkeC+8Vm4qyxM
         GydCf5yhXzVaq32XDCPqeKyPcRosHkGtau4sxKeOKohrOp5As3fR9a7Ngk85AmbCkqDw
         COj05ie/2bX0/Lof3ayEf5+DhD3r8BylT/XIjzs/zfPpeeZHqn9WBerxpWdJUHQrawkt
         dLJRMeOoJ5hYoD/46qA0DRqwhIGJeMDF6ehLsm7nVR6W/hl0lJri30qk9B5REH5xFTR/
         B8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769647412; x=1770252212;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bX7afXRfCQDK+en7SrtIzGAhO6+OT/6JRMev9l6gCus=;
        b=krVHcU4O8PGoHFnxx3mofAB9rOT/bW0m9iqsxu6ySRsGFmVkCpp7bTTnXdOIJDvzqU
         kGswGiVyTRZtYqnmKFfUGx6aQ1SFK632CAjBbbNz4ncD92GyJuvcNEfUFxkKIOmjkGj7
         dTzomoOe0W9TbTxlEa4vm4J0qv/yFPq/LwHNa7RiDj/ZIUw6hhRQ1U1/pGatXiwtqMJ0
         /wDbCFPE2+93p/dbOpbcTcMQB2p851rYF2gck/Kq7hS/eATMuJOfvgXTUBQYfKq9f3rF
         jrStysPywwVOVHDZGn0CJg3GyV9l3wpGOtxYkOfLe2N/b7dKacAROHjK2/owhHP9g9WY
         M/MQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGqMGVeUZPGUYYgJtcgaKRhOv3qJV9Qi+gRrsccTX8KXrxXQYHhYb1DoxSXvDst2Af3C40e0H0ZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPC1m7fA6cFrqPGgiHPkh5VCHXFz2ftcH8qZ2Ml4Yzksd1xWdW
	RcyEZnjVQY1Ms6GvMNtKEt/L7YzZ1jYS4x1UXZaK4ybTjWzT21Ux1FIbgCi3dbp3gfRldm79fJl
	Sge578qFdxfprS/veLwz01i+pYibhCc8fNOqthvW2R6dHzJVLvbAKNFQniaVMbA==
X-Gm-Gg: AZuq6aIySnZgExf5V44G8IClbIIhsSjelrpEIf8ORrG3dV3eXg+wtaRjXZzlcUq0a9t
	+X1t8qzg5P0dkP9tStyVW1mvemJZ0gRPzVbAQstHBXcIz9V1PEfzRS4BsLVFfZGWliYZxsj7VqC
	uWXXzysKZu5tvB9aB4IiWdh0CQuHP7MnmMw5T2cj/Mwr3jGZRGvMUw6cfixQ9RUe1kUnL0DzxqO
	+kaAs7+XnMjwYoNxlds5ZVEf3IXsE6QOU0daYJALK5KhejfyC77MR51MkCjklMD78EPZGzY+6oh
	91she+5Nw9ElyJ5gS1qlbAgb3U2qSeKm1BOG6gssHvl3Fbt3pqQoeMOz9xB6Q9X3Lptyqd9KsRZ
	BdLzA3uYR0D3mpVWndWG1yCpAOVm1NTOe2OJ39F5/s1DgGk5xVrmf0EMfbB2wBBg/W7ck69mvk8
	FALJ8fuJeIo9aiHKw2ra9c/As=
X-Received: by 2002:a05:6102:290e:b0:5ef:5387:ca85 with SMTP id ada2fe7eead31-5f7237d2386mr2063516137.39.1769647411535;
        Wed, 28 Jan 2026 16:43:31 -0800 (PST)
X-Received: by 2002:a05:6102:290e:b0:5ef:5387:ca85 with SMTP id ada2fe7eead31-5f7237d2386mr2063500137.39.1769647411132;
        Wed, 28 Jan 2026 16:43:31 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074819b5sm832104e87.14.2026.01.28.16.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 16:43:28 -0800 (PST)
Date: Thu, 29 Jan 2026 02:43:27 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, konradybcio@kernel.org, mani@kernel.org,
        casey.connolly@linaro.org, amit.kucheria@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com
Subject: Re: [PATCH v2 5/8] arm64: dts: qcom: lemans: Enable CDSP cooling
Message-ID: <o3gdovqbkmclpmrhjtg3lknhqcecwfrp73bpbv6nsspzvkjfm7@qqkrzte3cdy5>
References: <20260127155722.2797783-1-gaurav.kohli@oss.qualcomm.com>
 <20260127155722.2797783-6-gaurav.kohli@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260127155722.2797783-6-gaurav.kohli@oss.qualcomm.com>
X-Proofpoint-GUID: l3q38R0-vjfo0JzELB9OOTJXYYx7lVJs
X-Proofpoint-ORIG-GUID: l3q38R0-vjfo0JzELB9OOTJXYYx7lVJs
X-Authority-Analysis: v=2.4 cv=dfSNHHXe c=1 sm=1 tr=0 ts=697aad34 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=TbTdv1u1e-S373k040MA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDAwMyBTYWx0ZWRfX44yZTMql4rnv
 AIdIkop0Ov4gxlKc7cr72mBwEzwyRySerlUDXUus9imYKH5TvIbkd15taOOqc2qejd3JolJUgJy
 Z4UMgTmabx2EeGq+twmvnJk0eqnbcrHvqGZy4j0QfKDbp6lsGMqhsp/kIcdJs5F/+ctQJOT0R4n
 APPmHjYv4NHq3YHjMOqt79BoTPB6/ykac3gWEh2MWuJntAyQUr+4kgd9ynpPC0iTpVydYCflEw/
 eWloF6Pn2u6B5v/XL+hMtjnOQl2HJXr8VOT/CHOe1Fw02NXPtbYPTa6Py/nWLQj4QqpVg1BUOok
 slMOtGV1gy2BG4+JWU36Rm+0U6WyjRpQh+cOJNuJGTdcNEoeEsziTbG3ImHTU4hMSBfG9B7Cb0W
 thT827geKvZuh4p7T2RJwV1elG5l/LEFkOQDXLSzzpQJa4IXidMLRNmNHs8dgrTsxaks/FEeVCu
 1RHq8I+cE3DNVgGym0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_06,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601290003
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41658-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,0.0.0.11:email,qualcomm.com:email,qualcomm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 589EAAA52B
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 09:27:19PM +0530, Gaurav Kohli wrote:
> Unlike the CPU, the CDSP does not throttle its speed automatically
> when it reaches high temperatures in Lemans.
> 
> Set up CDSP cooling by throttling the cdsp when it reaches 105°C.
> 
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans.dtsi | 138 ++++++++++++++++++++++++---
>  1 file changed, 126 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
> index 808827b83553..c747dd534caa 100644
> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
> @@ -7281,6 +7281,15 @@ compute-cb@11 {
>  					};
>  				};
>  			};
> +
> +			cooling {
> +				compatible = "qcom,qmi-cooling-cdsp";
> +
> +				cdsp_tmd0: cdsp-tmd0 {

This question was already raised. Are there more than one cooling device
for the DSP? If not, drop the subnodes.

> +					label = "cdsp_sw";
> +					#cooling-cells = <2>;
> +				};
> +			};
>  		};
>  
>  		nspb_noc: interconnect@2a0c0000 {

-- 
With best wishes
Dmitry

