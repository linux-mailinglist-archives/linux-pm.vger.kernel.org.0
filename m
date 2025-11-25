Return-Path: <linux-pm+bounces-38665-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B4DC87835
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 00:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E4D9A355E9B
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 23:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C632F618C;
	Tue, 25 Nov 2025 23:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RS7Rlx16";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MIwgxhs2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1708A2F0C66
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 23:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764114525; cv=none; b=G1z6zjnAmY9X7gsG3ZUe64uy7Ezvv2UHaF43Sld39zj3fPa8sc9TYMC0Z8soarAYdVxnvYTDi5aZz1KbMvl/FYAyALydyk5nXyaqo+TTzPaS2LZf3tMNaxpZzChX6ngYZR+VbbfkL2hurIIF7Ha8XyhxOEvINUMuW/+QyoJumDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764114525; c=relaxed/simple;
	bh=0Mlyhx695BkVTyiblfoWvSYhVsoxNzGhcYR/1u0Vwps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqhFKgDi6QHcZWIfs9AMKXoXaGP1BsId8nyqfS5FQjUzju/OGljMpkXPVWQfdlfaZDTC0qCFrzEDlGfj+4V9LNhfFqghBduv6Hbpl1aW1e3VAwPu59LeCIYXOKXBxUvOz/L5GETh2FVYYXlmr5W8/wRZ15d6o9LFG0DUVkmi8pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RS7Rlx16; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MIwgxhs2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APD7vjG3317496
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 23:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=k5jDEGG25I4fC1NOVLJpbEU6
	TiEXOx1Y+8hrvGoC+dc=; b=RS7Rlx16a02VrUIvd5ojRZi43FxbiQJfJ2jlUXyI
	IE59OhamC/V8eqRUFB8ss/DwbQtQH1JEEhYn9Grcr8gVlQrp9lm/LpFUGmAbKE9F
	QKcbcAJbLqPQiMDNd9ncpf7PYLLaI/bogue4EgDVSKK6lNbfYViClxMgRBA30l9a
	YEIfgxwiuwhohQFsJQu0/DGkuOWWB6Hl6x0bYqdOf9+Gis+iw9xD0dga+qL7aJBr
	wQyBRjm7q8WxdXcFkeRWGc5cMbQsUzAGh+ruChgpNR2sbOsbmAVVBRZDHY/3sVLw
	EjvWo0ElbnDBhmYqBHQMBfABzuZarYIbq5sK0BiOTlFuNQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4and2qhn54-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 23:48:42 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b2e2342803so1596084885a.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 15:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764114521; x=1764719321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k5jDEGG25I4fC1NOVLJpbEU6TiEXOx1Y+8hrvGoC+dc=;
        b=MIwgxhs2vpUjNctbMPzOXwWoi8NfTOTSV8GsWQgTSAwhPwAMigDhv0ivT0XaOmXkuX
         uJHlVB4/tZ0LoraRIjDVjiRkFtERPh9P1TJnGan//GKfY1djHO4Pvr/Vkn/fz4xi1QQo
         iClCPJJwPF2Pyql5GoxkqJ43P9F5rCY7R9W6vFDvzYcP/neD5UAdime6bD4vtr6TkMIV
         kXZayx3yN/e+YEWw4hpLzkbYGNC2iDNtDpD3MaEJYDqsYY8quFHHKufAty6C+uddbGp8
         I+DAH4CjVZ3UPznvgrIK1JtD9KUA9W2/9JlJMnGMefg1XwQCqk8l8oEDLMh6mn5UjWbS
         Ag5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764114521; x=1764719321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5jDEGG25I4fC1NOVLJpbEU6TiEXOx1Y+8hrvGoC+dc=;
        b=ubEb0DYwZpB69K/YJz3Y7GsvRzkigq/7rOaBagZY8AZwgLEsmPUHs20y1a9Li5A/Qd
         hiLZaVwLvD2+tkgoPD0pRdckEexcYYZ6KtV9FurLLiqlsz3fa3zjiVDGYCjieEmHBX1f
         qL7NYS+pPAkbARZSdfq9ZGYVajX/tWdmZX+jK+PQ4GM7M1q7VPBVzKPJue3BJLZa9GsJ
         eqSZT2NmjSiUkdNDKXWq6hFXeNfV0zaEGxyJDgiNG/nGwJikeWRgsED6uU24jcQE3tuF
         BKggmvg1fTTjgA4KpiYUXNmWqwVqUu7AhNv+HHLYu4EI0YyFKX0UwekvQL0whyPkYlT6
         iAUg==
X-Forwarded-Encrypted: i=1; AJvYcCWJjJB81unXQGZAxHJyuZYEHvfl4fXCicWyTkP2pYaHAfHycY/2bXyav+yLlke83HxmO/VwCSb2bA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzC3VAH4prOy//e+ao1kT++ItgkBl83LUunHrcP92YlvAZbKTTx
	WjZxmf/ELEidcb8zpJ/P3yUwi7M3/TeORE9RkwQ7ihVXAEKgerK/lK42wRqolbpYrVGRMIsPQm6
	B9UylgRaJTfRJvhMQulFD+AdOKJQDppwXCspaOPZqLJ9Q9dDyVdHrrgcTRBLgXA==
X-Gm-Gg: ASbGncuGgQXi1KBq4hwzhd5ZzIWHIjeKIIBIJGKhObl8Ypmb20Q7fLZRsR3j04HfzhU
	MaBjQ1LaCroG4Cm0kprCzSlz3W3Pmg2SwH29L+riMirEdREHxZGrRS1kQnVUG8SaFmu3LmGScon
	+WDLbMBvt5umm1Ib4QMiGVx7f9TyP2gLgPpiidyrx2jP13LDj3IB0BASEZq1rGAUiA7EYYgYxyC
	qIlIOy1Mk2civ1jeDnKyQkGYe9dh4a83qvS6ate5dTJzgozTwlk5OVMH6zpjLyv2qfhuPLDsm5n
	pGsbtbgH7/lb2ycKV7usVJ8iFqRlwK076t4RL+hin30Or5p4ZYYcXLY1sEWNCm9q9Ux8IhUijVW
	d18p6rW74/QsJilHvAS1LXTHyPNf2hQLg+/WGrJVsqO6p+zZndqpg1phAvtRc4SWoABuWJnJFfc
	UxDwiDyRY8PzubetloTRfY9SI=
X-Received: by 2002:a05:620a:4402:b0:8a3:f8c2:5ee4 with SMTP id af79cd13be357-8b4ebd821bemr613778885a.37.1764114521452;
        Tue, 25 Nov 2025 15:48:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFd7T6aPJkSDHrzf/XM/oH9ZfLFa60qTGg28nQcNctnpUzmJUsrOR97i7a4b/c9x3o1jjM7qQ==
X-Received: by 2002:a05:620a:4402:b0:8a3:f8c2:5ee4 with SMTP id af79cd13be357-8b4ebd821bemr613776485a.37.1764114521011;
        Tue, 25 Nov 2025 15:48:41 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5969db756d3sm5568378e87.14.2025.11.25.15.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 15:48:40 -0800 (PST)
Date: Wed, 26 Nov 2025 01:48:37 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: david@ixit.cz
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        Casey Connolly <casey@connolly.tech>,
        Joel Selvaraj <foss@joelselvaraj.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Martinz <amartinz@shiftphones.com>,
        =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Alexey Minnekhanov <alexeymin@postmarketos.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH RFC 6/8] arm64: dts: qcom: sdm845-shift-axolotl: Enable
 fuel gauge
Message-ID: <eysmjuxmvl4nfn34hfiqw4pwfptepibo6ez6tlunegk6dpmc4p@hbzex6w4dxnp>
References: <20251124-pmi8998_fuel_gauge-v1-0-dd3791f61478@ixit.cz>
 <20251124-pmi8998_fuel_gauge-v1-6-dd3791f61478@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124-pmi8998_fuel_gauge-v1-6-dd3791f61478@ixit.cz>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDE5OCBTYWx0ZWRfXzODoXdINSlyI
 zf/HkGy8WeXYqeqAvObNMDOtZjZNHlGOP1L7UgAHa8ARQNo2Nl9+ENAXYMeLNO4e4+Aeez3lUnF
 0Q8N4ji4wW49y4iAG/Juha0dVPe7ci5oC4VUpGybOMPl3PpXpeO1ZO/O1jBsqYqRikkEOUiFKp5
 NpNkyRaABMW2FJ8UcVB2p9BhcilffUA2RYqAKxJnVyu7R8uWBt7YIKgqzwVXFUgjdC+Uy1NM3kR
 0S7499K3SoEYzCbUjq1nVOtc4dE9udT2y83ElScEnMSs4mlI2ZHA3FjeorOPwnVDhq+jonMVQdu
 e2q2Ba56x13I8r+FhE++e6E6hTMLeWY3qtLttaAy1njThmHcfTTEKsYC0TlcqLUNyRbdQWJ27OP
 HC5BFUDeDfRtEX8DsLsXZrYwE1Reqg==
X-Authority-Analysis: v=2.4 cv=dZyNHHXe c=1 sm=1 tr=0 ts=6926405a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=jB8_oC6jW5EHyFLWiXQA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: RSTbxjmDunL8ACtW7Kadlgyh0HPDQaWJ
X-Proofpoint-GUID: RSTbxjmDunL8ACtW7Kadlgyh0HPDQaWJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 clxscore=1015 bulkscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511250198

On Mon, Nov 24, 2025 at 10:53:39PM +0100, David Heidelberg via B4 Relay wrote:
> From: Casey Connolly <casey.connolly@linaro.org>
> 
> Enable the fuel gauge and configure the associated charger and battery.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

