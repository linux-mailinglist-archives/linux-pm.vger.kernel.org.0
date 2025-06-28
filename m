Return-Path: <linux-pm+bounces-29727-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7006AAEC3FA
	for <lists+linux-pm@lfdr.de>; Sat, 28 Jun 2025 03:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67D051BC5589
	for <lists+linux-pm@lfdr.de>; Sat, 28 Jun 2025 01:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEDB1E2823;
	Sat, 28 Jun 2025 01:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kYtymxzi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B722F1FF1
	for <linux-pm@vger.kernel.org>; Sat, 28 Jun 2025 01:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751075915; cv=none; b=gy/DOei6FOYlae/SK2l7wXuL+tCEs21D/V2yJL7BcOPtReJbV+tVJSufC179A5xvXaKKyyxcCH/BF/9L46EoQ705ECaIVR3VBHhBz1c6aw+fNhmm+y1KEphHcsgwl4nSGQhmMvfhqhrwpq8NX446O0G0Mxv0XtzvC0fRpVyybMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751075915; c=relaxed/simple;
	bh=pWpDZVpcpfLHx6uhsAoegGUK8ZMrlwyUKIRW3dlh0Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Urfd2hFbnxNqOM5UpZz1bHA3aMkcwuxzgjO+/rNbip1Y0qz0YG3izl2JETPV4GUMjYdydXOK9EQ3TCi3yoJ6OSsLSDMQJXKgxGozuH/CFpBWeYoPN0VcSgT7wmjOeW0FkaS60IhYUKFWs3jCTcmgoX/1PcgBtTUdqVmUQc94pag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kYtymxzi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55S0DFxH015454
	for <linux-pm@vger.kernel.org>; Sat, 28 Jun 2025 01:58:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+pXUtk7h/e9fxB5NYEsdbDb8
	SFpEksY3oCoSMDT5xBU=; b=kYtymxziEtDPUR/DR06fq5P8BiGNvLLfHjXM4qzX
	oq4YCWrtuEIxDA+Rl7mt5CPBs0GWk7Bi3UIMFIDNdcNzREw/NCvFqwYluNHxOpcr
	+Z1I+3r48v3NY3SyuqMAby9eTl6GC9vX3hcN9FpuGSQmbdT02fm6Li8lrRLtQOiC
	StJt+vkddbFxPD0J0aimDPx4rD5iv4Skptrx0Nb0TglRt3yTGMT94hsONN9EUUGn
	gMJrL9WwHc8LA7EhvtpXoUGgX46VAC8Xk8fRU5s0+11J+zrG8i/QKVwrm6IDsEm/
	fHhITWO4azrHqNIMgElZiQfBApmFO3LwcAc4uEgGY5jugw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47fdfx6qaa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 28 Jun 2025 01:58:31 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7d4133a2081so389974485a.3
        for <linux-pm@vger.kernel.org>; Fri, 27 Jun 2025 18:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751075911; x=1751680711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pXUtk7h/e9fxB5NYEsdbDb8SFpEksY3oCoSMDT5xBU=;
        b=ASKXXnLSG7MDNDdsIqj1iz/q90JzfOXyGS+sQw4hDUH3WsGN27I1UH7wo8ZWzcpVW3
         BMcLx3f6KUTxxajm4U/PaxA0yEakWaJiIiCyKlRy9srPNDlIllZa3UNkw6+7fcxIaegH
         fUwokG5reUl88zpMeLD2/zawzXg4f1Jzv0TCC6C+dYOAdthdSbKfWautlDpT7pslNnhr
         U1412tHjozpr4PGMzIGj6j8TMCO/UY/3oWwlYVEPaRgV+EptOHmbOEa8V6l2GmL6d+nw
         aMqki0AGByfFENNAd3vGLsHtmMyalPQ6uKCJbBJY6mqKg+lRm0KfhkJNQwvGdrMJcpqr
         zDDA==
X-Forwarded-Encrypted: i=1; AJvYcCXNqqnyBrMi2TnmJvgQ1f75OMs1SsAdVjwRMwRftOsBaVZJxRARkRnoLeS178/KuQqsXldTN9trsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzufAJhZmwSG+KgbW4w+ERX+kP5pAvtMvftCqcbfnbD8WsMnZTW
	kretFHE07YX6fuJUwa/oBEruq3/BOsz77BV5DfQssoRzoSJTWDeiq5kZEozO/FnuXJth1N7S/bI
	fHMCLfYVu1NvnCMQGuj5JbBya2PK5CKW5JTX6ardpHl+7fsYh44v3xJWoXerBcQ==
X-Gm-Gg: ASbGncuyKWKklaePgY8V/bM49E/quPgu8JtlRHw8zaMk15OQgP7GJWTSvbpi0hZAZ9E
	wTDV0QqFSrzlf8JqYK8jzvae/lMEU9bj6BJLyEAwArCZRqnT19tZEaA8D6FYNyBl9t0ZfztlQYk
	la1sZ1J0ZAs+MjxA30Gms61H+3RMyxvcmFW8VK2p4J8I8yIJUm7ZvLOuUJdPq3rSGmMc23yOHYD
	EPCAU7GsC4tgArrd2LkgHeJthIBpf8xBrikjGmsiabDvbGPIZCSVHkBr4dWDMU4w+L0HL4bvQk6
	DSmqoReC8DtESJEDrdXCclwc67ODfINVGsHKJYfTxEhegDB9r++/waDFmuS+UVEvPdOXU7RsZvX
	bP3iANFYVLW9LSf7iym6seVNnRDB6i5Zkwf0=
X-Received: by 2002:a05:620a:1a08:b0:7cd:3f01:7c83 with SMTP id af79cd13be357-7d443988efemr792723685a.39.1751075911015;
        Fri, 27 Jun 2025 18:58:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPx2U8tFKLDmMfH1PW9cHmmn8qdEgd47qN2RxSezRNQHmEDme59hKTrXVfH0mUq2+T6/o9WA==
X-Received: by 2002:a05:620a:1a08:b0:7cd:3f01:7c83 with SMTP id af79cd13be357-7d443988efemr792721985a.39.1751075910633;
        Fri, 27 Jun 2025 18:58:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2b95cdsm639619e87.130.2025.06.27.18.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 18:58:28 -0700 (PDT)
Date: Sat, 28 Jun 2025 04:58:25 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-clk@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 4/4] clk: qcom: rpmh: Define RPMH_IPA_CLK on QCS615
Message-ID: <i4l5dbqrs55e5ydrwpuxjigxsa7esevujhgwpl4qwsgx5sawmw@brcbhbqltlr6>
References: <20250627-topic-qcs615_icc_ipa-v1-0-dc47596cde69@oss.qualcomm.com>
 <20250627-topic-qcs615_icc_ipa-v1-4-dc47596cde69@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627-topic-qcs615_icc_ipa-v1-4-dc47596cde69@oss.qualcomm.com>
X-Proofpoint-GUID: ZEzYMOiDcHBaZNKuLUqVSKrphy338DTJ
X-Proofpoint-ORIG-GUID: ZEzYMOiDcHBaZNKuLUqVSKrphy338DTJ
X-Authority-Analysis: v=2.4 cv=MtZS63ae c=1 sm=1 tr=0 ts=685f4c47 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=RBL-HKAeo4RFQYj-4a8A:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI4MDAxMyBTYWx0ZWRfXwTyAODTkTlOZ
 7gH00bMM3z7tLoJhkSwFPMpIpOzfgM9oM/tRbRZMo92wht5Z+BEf3Afp42SB5BabGS1jR1DbDI8
 ZyMpSolWwpUFqj4H0zGQCQ1IFy9ai9Om/a+tV9TsG33M/hl4Rnv2oI1yI9831KY4s8OOAo2xELs
 XRyENVLs+Phh9ILapRqNPERw4hCKAsHnT0SABXft6a/5AvhwAgRkoJ6CNfdxdwVhSymza4+ylUK
 z/z2PqOiLusSFk0BiMTXqsvt2lW6qAVVSw/Pw+EeYm4S6z8GKg8Bu3ghd8gvVSd838Cm8C42Rk6
 arNgi5HY7iwDZH6MOoR7khTr9LlTwvtWbrDdnmg6ser1tsOuzmZzK+Eq3xQuBn+1pg1xnRTEBZQ
 WK94TLuLEXQHcMrVM2Dhkbq+XFXO+vmjDPbR6LGH/GO1P5zz33UV6l6n7Pz0hasdQbmGG8fn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxlogscore=847 spamscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506280013

On Fri, Jun 27, 2025 at 09:37:58PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> This was previously (mis)represented in the interconnect driver, move
> the resource under the clk-rpmh driver control, just like we did for
> all platforms in the past, see e.g. Commit aa055bf158cd ("clk: qcom:
> rpmh: define IPA clocks where required")
> 
> Fixes: 42a1905a10d6 ("clk: qcom: rpmhcc: Add support for QCS615 Clocks")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/clk-rpmh.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

