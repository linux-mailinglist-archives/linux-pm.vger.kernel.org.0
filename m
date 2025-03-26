Return-Path: <linux-pm+bounces-24532-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF28A71D8F
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 18:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0738C189DDB7
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 17:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FA223F421;
	Wed, 26 Mar 2025 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nOTC9XqJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2F623F299
	for <linux-pm@vger.kernel.org>; Wed, 26 Mar 2025 17:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743010926; cv=none; b=uK5R1XTi7dphVv11G2KGW4m5ZDgg9KooO9f1TX62l5bOaxSgDkv3j1XiaT5XPnGJM5CJSI9EEhAP4gSwCNxxPeupt/1We9YVYStz+NCS8hiQhCQFQgc1ZP9xUOXBbQetUt6mD7k3cNJf7EdKh4ECFfZypg1ad4uVPHUFTWJsKlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743010926; c=relaxed/simple;
	bh=xy/2rzsOh+trLOCmWnJsm2IkbvXJ8ayuSunPg+ApXo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pbsm7LMY78e4PaORBq1l6WtGJcSiQ/M1T667lYWn+Z078Jwd2rrHrBohouFTMYDrPEWvnw8p+Lt1iW5/W5A4Mr7WDNSEFz4zSBXF2ms7VJUkM3Esr6Eh2E+5n1YF44gIeP0s16M55KnTWzw4fxpLeeKwuqFdo/amPLGsqAq1YXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nOTC9XqJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QElxNd023564
	for <linux-pm@vger.kernel.org>; Wed, 26 Mar 2025 17:42:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=1whyNVe02s5jo4EwpJiW9RED
	EE8MpWJ5TWtU7vf6DK8=; b=nOTC9XqJoGDPy5O8S+vITzRqXgvTtvRlw6JuhcUf
	bB/ITLmQsQhCl5HGEWRKstUoJvkfOFqRQmDN8XlI/6Piu0lubYL8cD9NjvBKikBK
	nIX72UOgzoQwRZhCppGt/BhRYqvEw5+Gm9PGgLIpZiURaz+xhTHlmK+VX3RxzwwV
	CjApa+671YwHukps6Obk5nN5mx93SQKNm4sugSnWce8I+a8S0zqlzjTel2uyd+Fs
	uvJQ3XCJbsChw2f9CutrHaTlYelQmemMaybabHX68xid7p2yfLgsdtDk5khxQxer
	SOuPAEYJ00i9rzzvMF2sTXIa1AuXtz2eV5CZb4etcGsLrQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45m7nf2kys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 26 Mar 2025 17:42:03 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c3c8f8ab79so20421385a.2
        for <linux-pm@vger.kernel.org>; Wed, 26 Mar 2025 10:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743010922; x=1743615722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1whyNVe02s5jo4EwpJiW9REDEE8MpWJ5TWtU7vf6DK8=;
        b=kJXSe5PVjgWREIuEGxsjofW5k3DlV2LcR8m2I9PC3LklxVjAM38x/DRmHFY51tJSxZ
         7b6ghK5EwlU4SNIWJAN1Ea/d/2e0GcktcRfmnqQXWb0DN5RAD0htBNCK191XITHVZ+kV
         h67ukFIH2WUeSHv1UDAkRYVBl8Jl2FTaQImLSTqDBJaUjkxWXdijtrtOkf0aDZjB/HfM
         3xeAowQEfo1zETVBvljBxVhHkwfB9f2SQqarMAudslNAMpS26oHkJ0gbw/fDUVgUPXFH
         pp0J5NGtHsQ3t6dxdu7gkgx7NDd2jQK2XMiJSMhtua5tXRmU56nDO0bSjy099xBH89gD
         TNxA==
X-Forwarded-Encrypted: i=1; AJvYcCXi55wO8pYh07AEfPCb9pB899qxr1OHopol4Ubo/NGTelU+FITQDnNnD1uWgpLfA5HlDp4dpcyFqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc6ofyuyR7IzbBP5yf/6z133jEwYl6QrxWmK7/mfciDPTkhmy3
	td9c2nOVj7kiCkEXtUhDJ6pHujX/UC14S79Wul0SaWvfSe9DttbDCe+UrVL1OBapW553GdRny1d
	5L7jNQZPGibW2BKqbZqyWqyEkfgMZbtG7OdoKaF61N8DcRu7Mr+622gKQcg==
X-Gm-Gg: ASbGncugBfpOeXB4PIiYA4QR2pWlEM+t7K2Vr9CQw1wK1tTPRhUZpRO2MABeMrg9Tfs
	vw8oDRcvzjS2TV5b52cx01K+lcKAvADdUrI1BoPeO/k3egT/l25MJ9nM72d3al44IulobYAwyX5
	xpZCvwU4LxY9hbqMDwbgerinMwlrs+pObECBZSrwyUSs853W9MK9wMetihXSguzL62trYJ4WkoS
	5GBb5Bf+HQ90J0Dwf+4IRw0lf+DjRVwDUyQ5RBA1pdyXIiym4ahApduLMKgjbNtbPMStBLGdAS0
	S0n504jNx5HbaCq16K1wYlQ2xI7YTUzIrXMrXl8jxmNIGVxzaW0CxoZwA80S3AO9CjiguSKaYC9
	AoFI=
X-Received: by 2002:a05:620a:1a03:b0:7c0:a3bd:a78a with SMTP id af79cd13be357-7c5eda61631mr71561585a.41.1743010922120;
        Wed, 26 Mar 2025 10:42:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGHUNfQ1l6wNqR9JpGezxG7QsvvjX37Da6MaMIZlLcrxsIc64vsgldMpySbZGofIgFHJRWfQ==
X-Received: by 2002:a05:620a:1a03:b0:7c0:a3bd:a78a with SMTP id af79cd13be357-7c5eda61631mr71556885a.41.1743010921656;
        Wed, 26 Mar 2025 10:42:01 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad64fbcffsm1849438e87.119.2025.03.26.10.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 10:42:00 -0700 (PDT)
Date: Wed, 26 Mar 2025 19:41:57 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH V10 6/7] arm64: dts: qcom: sa8775p: add EPSS l3
 interconnect provider
Message-ID: <qcvz3t55bu5zok5up5nxk3mxstzkcpmdavsm6t26pe5dwxyj2a@p6nkxe2fhvvv>
References: <20250324183203.30127-1-quic_rlaggysh@quicinc.com>
 <20250324183203.30127-7-quic_rlaggysh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324183203.30127-7-quic_rlaggysh@quicinc.com>
X-Proofpoint-ORIG-GUID: N-fx8iLbhVjlCPeT6dE-Fjy_DtcAKSVg
X-Proofpoint-GUID: N-fx8iLbhVjlCPeT6dE-Fjy_DtcAKSVg
X-Authority-Analysis: v=2.4 cv=IMMCChvG c=1 sm=1 tr=0 ts=67e43c6b cx=c_pps a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=TedthiWShpgNw5UeFFIA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_08,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 clxscore=1011 phishscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503260109

On Mon, Mar 24, 2025 at 06:32:02PM +0000, Raviteja Laggyshetty wrote:
> Add Epoch Subsystem (EPSS) L3 interconnect provider node on SA8775P
> SoCs. L3 instances on this SoC are same as SM8250 and SC7280 SoCs.
> These SoCs use EPSS_L3_PERF register instead of REG_L3_VOTE register for
> programming the perf level. This is taken care in the data associated
> with the target specific compatible. Since, the HW is same in the all
> SoCs with EPSS support, using the same generic compatible for all.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

