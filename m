Return-Path: <linux-pm+bounces-32629-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE38B2C0BC
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 13:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A38EE3AB3D0
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 11:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E463E32BF42;
	Tue, 19 Aug 2025 11:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="po0PNZHK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D62532BF39
	for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755603622; cv=none; b=J+3UHbR8y7x+BKWl7nCy2AMM9MHNUz8Jkr4KYliygr4a197MXUQDkoIwvLYfRskIFxmywTjRy3Tj1i8GOoo42fRXzTTzNDLpuzvfnNHsj+fpSWgrk65m/I+hYdCuETXODbZPvZ6h6+kr1Tdtn+yTTtSkpYnkN4mjrDGg6VOBBxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755603622; c=relaxed/simple;
	bh=zlUEJfpYmR4tX91EugAHvCUNzFBmNgD4zi112bP6hAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HV/MY8RMUkl9zfKf/Ascldb/P3gzjrqwh4+TK01z6dAPN1j85ok+8Z8Ho6R+0pl/a56aNfXRXd7ictTtou8onhr7y+gIP34KKUunHQnvysqOTk8Qmyvvp9IV/imi0IAOCrrUw/DaDPOtDaXvln0VLR5WR+xzFIkpowrYm1CSC+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=po0PNZHK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J90XIK028213
	for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 11:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=WUZCKijWjTUZrQrretf3iRXu
	z+Doo912w7iRSB+J4eI=; b=po0PNZHKBpmN24jA2AxvSrxpb1J7ZjMYLOJM87yR
	BryFWpsT0iAM3Vx8sOC2ZPGRRZ31x7ZNgroMgUzc7IgWCq1MBW0ZwxvAVBTjQ03d
	JOMHYwk/DhZBLs6v5huI267841cKfLejxg1l1sS4yWJAyKV58VVyffFpy2YGpduY
	7PAoLjWWpfTpyRMmuJXmyCWHGBktS052IvgGKyZDdqWnqAZSN6pZqiypK7XFdVZ+
	ow7hWTgtpQY3TfQjjdX6ECS5pPSWWiRl+PVCqUAmykzp9QNpvMCtbqU9wTai4fPe
	Yrm7xk/RBTKrVClh4TsG0wG4BlXgOVYYp365dBUsQzV1DQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jgxtgj7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 11:40:20 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b109affec8so149478541cf.1
        for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 04:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755603619; x=1756208419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUZCKijWjTUZrQrretf3iRXuz+Doo912w7iRSB+J4eI=;
        b=tH8ojbKcEHYHV1nfPc/cfwjW+dyI9Pj6qZovsk/TJtbt5/PEjFqiGPYkYWIJINc6ZL
         SF1hx4jAu1HrazshlZM1WwpdNjBwl1lzpa+Z7KaP4u+wWJAr0INNjTpQgfPiawJjstrA
         5eGpoObelee+rKexVXEY1UdngQ0ex5fX9x631S+8nn4QxP+UGZsnytFG+NANaivuOPmA
         OGKewZ5zrPGtdXzmMIWWaNHm3FEBWwmibaq3CTZfBd+n3uS2mVS+ZAjgariHBlsZY15h
         EnLQQKRI9oPLZ6BH3Ls6kOMZcOgz5CnZlMKJSSm6O8taLWGHNbPbwVW9Y1doxqSgrnxn
         i2WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDf9fHhzEefYnRBiYxyUMIUi2xevWxulJQW3DPpsusxlAxMnmdsoEDJiNugzIeDzP3KZVszPYKwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjVA4Wpf9jXmjL5FaqfMkRDmb7lDM+CVnAuwzYWo/aJLDWknl3
	vicGEECC6td3tOJ6rA7ndGxbvnAhZY0FH9NRxnGMEXUGJTIB1s3RXAPMD/eU+FeG2eD/vmw7C/U
	WIV5zCLLXfyg8TQErZl6bXyXN49lBc4N/yecS6Wc1rbbfFFqzDjc5WoXvxzF1Dw==
X-Gm-Gg: ASbGncuVaiZVWQQkOmm3fNyDKm+/mKR9jEau5IFn1F7/V/ZrWl9s2MxOVW3VCA7vvx1
	z4DEA5ADYxa40NeptCFbtBi+231Reixl+Pujq1r6/0cfT8fdbwLXxqNJeVhvsF4KNo/cS1vnj9H
	Xjky8HUV5IepQDejrx9mAK//5ZCut3YehDo48MZZVpXjk+dT8dHybBvkeuKYR1k/uFV4GWvblOO
	ZM6P51h3aY2gzGxdMr4rlCYGySAxUt4AUQel3C66ENmKEcMjKXscFlHC5fapBojlnPdIkI4u3JL
	S3b3TYnJ088ytJ4KL0iaNB3zSP12ldkHGvdZAgKmmnB7RGfqGCJR0P9ke2XkuntD3voK36Ue0E+
	nrxQNSR0DzePzcMyRKKaFBDg/AN806Q7wRqydHQ2moDRP54wtG6kq
X-Received: by 2002:ad4:5f0b:0:b0:709:650b:914c with SMTP id 6a1803df08f44-70c35d30e23mr22234246d6.40.1755603619220;
        Tue, 19 Aug 2025 04:40:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoFttiRUeNCxJ8KFAt4cgTqEKpI9DjnbmEteHB0Sc6Ed6p67fuNf3H2ooC03R+rgzCqqtrhQ==
X-Received: by 2002:ad4:5f0b:0:b0:709:650b:914c with SMTP id 6a1803df08f44-70c35d30e23mr22233866d6.40.1755603618669;
        Tue, 19 Aug 2025 04:40:18 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3cca16sm2088342e87.92.2025.08.19.04.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 04:40:17 -0700 (PDT)
Date: Tue, 19 Aug 2025 14:40:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: qcs615: Add OSM l3 interconnect
 provider node and CPU OPP tables to scale DDR/L3
Message-ID: <le3xcbnebjgkhzmy2xhicnn33prstewg2wymwc2nfjombxgg3z@ucsmlowzzd3n>
References: <20250819-talos-l3-icc-v3-0-04529e85dac7@oss.qualcomm.com>
 <20250819-talos-l3-icc-v3-2-04529e85dac7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819-talos-l3-icc-v3-2-04529e85dac7@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: G8HLH5fPot6satwO0hKcBHXCPkFWlT96
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyMCBTYWx0ZWRfX7HQBr8PjDnf2
 qp+N0e0mcC5SyPuk14tT1Km+S9ed6/c+4Ayr4FdmRsY7c6CvaqPp8Wa/UIkZR3Ybn5wP8vHMbbM
 ciXdYCrtk+UACT8NOln/+JO+jBnNLgkGhCYYssskNLUnsJ0YQbNX3EXpM7q3CFZzYwnoLNFJATV
 bdTHbUZsQ8dl8Sg0tzxEl1PKvy3w9JDUfoUtP2R4W7TddpfV3Dfvb04FHHgabKLvwgicyAA9gQt
 0HXWsZNXnvJe0hoM2rzw2IyBcJvqZn4qA3Gm9gRq/nQmZVFhaJZJG3MvJs2A1pRxihqAdjtc2x3
 kbxVlkKcR5/ukX+50LTshl6VNf3hz96eF4XiI4r79sN0qL8XndfxOvV4jBe8b7msSZysl0kFgws
 8pkq5brm
X-Proofpoint-GUID: G8HLH5fPot6satwO0hKcBHXCPkFWlT96
X-Authority-Analysis: v=2.4 cv=V7B90fni c=1 sm=1 tr=0 ts=68a462a4 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=cd8PGyEpGUmkB33UepYA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160020

On Tue, Aug 19, 2025 at 11:24:47AM +0000, Raviteja Laggyshetty wrote:
> Add Operation State Manager (OSM) L3 interconnect provide node and OPP
> tables required to scale DDR and L3 per freq-domain on QCS615 SoC.
> As QCS615 and SM8150 SoCs have same OSM hardware, added SM8150
> compatible as fallback for QCS615 OSM device node.
> 
> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sm6150.dtsi | 148 +++++++++++++++++++++++++++++++++++
>  1 file changed, 148 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

