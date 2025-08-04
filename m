Return-Path: <linux-pm+bounces-31846-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C28BB19B0B
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 07:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 339721896059
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 05:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B36227581;
	Mon,  4 Aug 2025 05:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DFZ/CBCY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1FA2264DB
	for <linux-pm@vger.kernel.org>; Mon,  4 Aug 2025 05:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754285263; cv=none; b=sSJkEzXSZID5Z1ZHBRBeyfNU1MmT8Fo5TGo23N9khWCGQ/PPIiu6Hq4oLHNxvroTmYE0s7fuD/6nUbsPslNA0z91gEXjbO6s9qkAMFfYKA37Tb12oe4+gJwYqlfvHozklfrIDKj0I6CmEh2cl/FLOnNdMlDnnqPkZfqwx45x/7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754285263; c=relaxed/simple;
	bh=ZYomnzTI/gqMaAWNJDB56qa6PtOYj1KGLdXceeY1XL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcFiS0te66AoSHGqWemLZXY+DWInwcwNLw8ef/I1nX1/fKOSBe3xKwv19+4dTrnZkrNoELuWS3RUvHeiDdFaulGCycrwyAj/WuxNTl7q5RKKq4SLPFu+LClgsKsunVT71RufJxFeXkzukzcrfOmBJxP1WQyidKu9KFb+xEyLX4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DFZ/CBCY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573NmhK1032122
	for <linux-pm@vger.kernel.org>; Mon, 4 Aug 2025 05:27:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+PcTXtqzA8go/oZD84ti/MPc
	iAxuBsczUeBgnZ1pTWA=; b=DFZ/CBCYzlikPei4IMoDe1V5c0bih3np3LkDKmt9
	gKPZirVsMp9wvIf6hIA3tkHmbXlC5InTlqX3vOwGyZoTHq6qb1t44HKbAAzQU1Ay
	cWZYA1l0q5R4BS1e5pyqDppXp42ahRxihq/rH8IBMbl7P8K0YSPwErpI4KhtPSku
	ny6Z5gDR1uRLn2E3LVoq2HvB1KXK+d8Re/z5Nt5T4LkuwNLPF6yEnfWQGkWHRcl1
	Z2Kz8GW6T8oCjLHPam727MELMhn03H/WlNBj7rTz5c6OngqvmzQElpZEDY6Cv0iu
	/GfgcTXu8XSBSleL+RGI4xOpgvbi9k7IPQ4NzRtDgRRBLA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489arwkjtu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 04 Aug 2025 05:27:41 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e69c14e992so262646785a.3
        for <linux-pm@vger.kernel.org>; Sun, 03 Aug 2025 22:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754285260; x=1754890060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PcTXtqzA8go/oZD84ti/MPciAxuBsczUeBgnZ1pTWA=;
        b=okxZZVLQ+Rm/WAPDRZ1ApOnQIU9I50u+CSSFYNLdRnKs9aRnYvncrCDjShVT16OONH
         2BRgm4xb3mHzoWzeoj2H8CfLwe1r2mpE1N7h37NJ0P7riGI6/Dk75FIdGqk3UXMVUN06
         RbBluYCKqQmhmwDtxREVo5zutcP9eZ9wSDSIYMtLTF8Ykw9zA0rOhvKgs790kogGoBO5
         nMws5KN/YI6JhyrRLYoFrd88fcHK6j5CmRKNiHw3H8IU3I9XsbxwFkZvK9MJwouzV8jb
         ZN7ESBfh570aUR7igWDKrD1I5VVpf6R/Ifq2MHylWmbTMcwZjoo0iboeRViRWKmO9WoC
         5Ujg==
X-Forwarded-Encrypted: i=1; AJvYcCVGOvibfzubwsKk0MmIfOPCk3u5XC/YMrEzfMlVWfPTPdoUd8vqBsqj8Ysk3F4XNAw8tVvorwgD/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwA+kjhNlONq4Ppiy4b6ocqgdgI0r7v3NpYdU3LAY90Wg10kBVJ
	IcrdIaLdMRODvsTS38DAUDHCZh1jiKFHNErKhbK6vVws7326jp4opMXjxg2u7jDwcz5kafDC8Jp
	b8lUfeNsyYpbNAp2DqikG9JLlNPs4dTu/G86rh6ELVg7Wzw5vZtYMV423y2XF3A==
X-Gm-Gg: ASbGnctI22hinsNgLBr/tPYcPYxQ2KW84fG+AjdMQ18gaVwawVZugWtVrOoVR9iBXvN
	+q2KZbwVT0czDdRkeeQwecYCs9MVcOQeonqfq/Iv2o2vl4SbkMNZiLPmJJe2XQbmODuHYUwAoTK
	jZmOC24D9Dw9G9Vx6lacOAaBFyAHnbSLeWpYZ6SSID0e6N80DrZLnOIfxK4NoSL6hFIf2EKE3Sp
	qq3SJ9nFZDLkVw5rAnKrD6IzTVEhTb8OHKizvRY73jxNC5jy7avNrBKIjGFedeTq+8q6ZDJTfnE
	FpGNLofDj6Es8rnGbv/m3tVeUMuEVUimvKEkuCsEgHxHALzliy96YPwBSpa6wp7PCMsoyNHZQGT
	1/0Ef6cQVQhBM7gGKhiOfNMQoeqA7GeEpfNaUTlMrLETNQeMj7CKX
X-Received: by 2002:a05:620a:5ed7:b0:7e3:30f4:fcdb with SMTP id af79cd13be357-7e6962dfbb3mr978589285a.18.1754285260393;
        Sun, 03 Aug 2025 22:27:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMxoOfzknCZ8uMmy3YY6kqSkPaQ9xTlPrcxG3f/lbgV0kvxmrcKW8Du96Of7dM/xfXukyUdA==
X-Received: by 2002:a05:620a:5ed7:b0:7e3:30f4:fcdb with SMTP id af79cd13be357-7e6962dfbb3mr978588085a.18.1754285259948;
        Sun, 03 Aug 2025 22:27:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88ca3214sm1541878e87.126.2025.08.03.22.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 22:27:39 -0700 (PDT)
Date: Mon, 4 Aug 2025 08:27:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Imran Shaik <quic_imrashai@quicinc.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: qcs615: Add OSM l3 interconnect
 provider node and CPU OPP tables to scale DDR/L3
Message-ID: <45oycvzjogctsoi4jiumxtastsrjzqrls3wc2vap2eryq5kcgq@leirtq2vfvxi>
References: <20250804050542.100806-1-raviteja.laggyshetty@oss.qualcomm.com>
 <20250804050542.100806-3-raviteja.laggyshetty@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804050542.100806-3-raviteja.laggyshetty@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDAyNiBTYWx0ZWRfX6SoPdWt+R6wk
 uKOn1x0R64oxH8+UI4UIPXyx1yPWnF2cidTZCiMkZ6RnkfyMqjqPZ+7k8EjCwo3ZaOG746NEe/N
 zCk7prJeSUsHWJrd33PgLs7VtDjUtEnSEcnemaDq0UaW2BtidqRq3iv4P4junIHMclZ4LxdLgSP
 MXwioFXe7llPo0lWKZRGj8vNrmFblqhLaSRK4Vd1yJzVQAIFasl4TYbK9O/EsjoKK4L5ZDN+FOp
 QlhDGOdU5IooRUEzahvCH1t+J69pIqnwHKKdN1expAjboH4GAg0Sa/vyeItKO21i30SaJ6rGreZ
 bkNeXcqTWfay0JjTFhETbeERW7wUJiXXk8Wvap/m9GiAmPkmcx+pBJ4/XW4RB4C/kaGQ4W48b8y
 jZXj9BlBt8aMO99zO7yt7UdFymiq+1/93eq9nrjdbgAelnm4I0Fgzor84MTSSzKQ/hoAGHMQ
X-Authority-Analysis: v=2.4 cv=We8Ma1hX c=1 sm=1 tr=0 ts=689044cd cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=qnWTwb_pmrVv18jEe2AA:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ZzsUoPcTrWfwl_DMHKfZp0qwP2HGQK3l
X-Proofpoint-ORIG-GUID: ZzsUoPcTrWfwl_DMHKfZp0qwP2HGQK3l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_02,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=874 malwarescore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040026

On Mon, Aug 04, 2025 at 05:05:42AM +0000, Raviteja Laggyshetty wrote:
> Add Operation State Manager (OSM) L3 interconnect provide node and OPP
> tables required to scale DDR and L3 per freq-domain on QCS615 SoC.
> As QCS615 and SM8150 SoCs have same OSM hardware, added SM8150
> compatible as fallback for QCS615 OSM device node.
> 
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>

This SoB sequence doesn't make sense with you sending a patch.

> ---
>  arch/arm64/boot/dts/qcom/sm6150.dtsi | 148 +++++++++++++++++++++++++++
>  1 file changed, 148 insertions(+)
> 

-- 
With best wishes
Dmitry

