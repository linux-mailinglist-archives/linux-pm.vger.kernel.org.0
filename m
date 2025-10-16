Return-Path: <linux-pm+bounces-36302-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BACBE55D3
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 22:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE77B5E3FBA
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 20:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CBD2DCF51;
	Thu, 16 Oct 2025 20:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EQ1Ca7B5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218FF1C8629
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 20:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760646139; cv=none; b=tAMzlAhlb8ECgTF5vkh2UNBJtbqrWPbcXmnnfYo0029sVq786dSWkGrL+Ng3pWgHsB2vRToFk/W4VfxtTQcsP3rW1R5UogbpPjJ5nABCZELArtp4mxrBPJev2fsTzgbd7KyB0M95no+mdC7gMdIAdgsKgJeFfoQJHkgxAY7suYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760646139; c=relaxed/simple;
	bh=/BnkzLG7iF5vjjsEuhMhpnk3gLf1GEWGWf5wGNVMGhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2o81rGJEMtEktVn4ODhqEHmO0/dh1XxZxCn8uE71LAgQ93j7xo/t6SC2WkhSp0X7mA03GAXC2vSVLeTztjvmIdc8frIQm/3Hjt78551Hqltiy/JCMPvjKdcOF143As94rpBWdqtSnQpyJEsRi06lywKHeu8nLPHp3FFxoVIxZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EQ1Ca7B5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLOCB020186
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 20:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=t4XeRTtk1HhmwuJqivoNSUwm
	vc5y3nht6ULpzG7FoOU=; b=EQ1Ca7B5u3ErYhxM5XM/jZbhsVuk/QMCZSm4CVyc
	xvzCG8WsO7+QXMbVhlvWscHFpQepb6mr97s+9iKjaEEr+/0t/HXRNd9xEXXftf22
	tD71PbW0BQKQSzSycxYvagZ6q4t+B037vCE+8K8NL4YqIyQH3CIoPDWgd67c/ZRZ
	IGt754YNOSQsPQCLqSa/pw23WZcU0QrosaE/67i1AuFLUUz44/Jw0e50DW5TQ8eu
	v0nZJShbWqeG3lgcvLkPEXQxenDkMw90Vhe8fgx3hCKfcM8rYFLFp9YWGPSf9nxH
	iuOFoYwooRrICLVHlfLzpQ6axkIXcIyRUPvj0vSfZEDRIg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49tqvpk141-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 20:22:17 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-87c1ed305b4so20510866d6.2
        for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 13:22:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760646136; x=1761250936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4XeRTtk1HhmwuJqivoNSUwmvc5y3nht6ULpzG7FoOU=;
        b=AvSuJF6uOxJvrakC8nCQ814uDrYyk1VX9y1Yjlo66Is7XIPCHkpmaljyFMmPjZpfZP
         mr9SyMKaBFp2LHbUvJy07n4wzrF/0RLDC2tfZmPNVZEmRpEWrF4fYg7ZF5t/UcjdTA6a
         sP28hrc6ACGcp/N0DhihHmfnUvCGx65N/GF5EDoriuE50bbPEw8LhZL1JDguTeG7i3H8
         ntgaAfYYo78bDerxIbg78A4c2jLhOUDGsJrZqyZ6UoBcM+gtjPHCU5MNind0QUT6EBJr
         FB0Alz5HUKDZ5naucBQYhhVIbsXfR5sgdgvV9yoQKCTDv4S1RnNdsuPgpagw4MfEp8AA
         bTVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbS65Jgu8uEqxYoYzOxvBbnas/+PSoy1Dm6syya027FOoHGRr+/lf+vg8soiJ30prHhtzV0d95vA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLisZSnQfxFcJ0wHFX8ZF39GU+EvNBJZiM66yxX89AnB+EiaeM
	8/6f+ckWeahrA3jRmd/si6l/CwpjIUFnDwCWB2X0luAviDTb7UsTCwuw12SFYP/q5U5Jmtt0HMB
	FrJGbV5fk5eqyZLn5ItPwcbG8JphyuEOxbku+qoGkG6opm8/7SiJwjav+oyO0DA==
X-Gm-Gg: ASbGncuK2vu08PojyOHE2AIIL+Z0L13MWwNSf0g95doekRRF/JVN+gdG5ZBiT2IgT27
	I4TicGkSbzK3SjmOqMoXUwR6B1srU/L8BibwVjDnT9Liap2dbyAyc7NjwR2ZZERzeRJaCAFRsRa
	8iQC5vRRTrdLpmPZfCkNDWmX8MhaB655AI/rfUcRiTPaPSHd/QvD8lkmSOf3cXHi8x/z7mbADpq
	2Dk6UwEi1QVoKaWUBIVZ8+E6GhZdSLU0QAMhQnXaO8q0FHAfz5c6lAaS0KHaHBICtPQCOyGG0Rj
	YiqzBhVFQmeAm2ddiyCrvjO6pcV/shYx6HY5Seh+bUwaOqjaFkI1RenR/OjV+0CvxdizI11NoRn
	DjHs0ODL2BzQoi+2z7bXlvOdrLPLLZ9XfU6SUQXMwp4S5e0loBPOMRLoTR//KRzWdrrTPPgg/jF
	H2rwxb3prdMWY=
X-Received: by 2002:a05:622a:1101:b0:4e8:9601:37f5 with SMTP id d75a77b69052e-4e89d05bcd6mr20995831cf.0.1760646136061;
        Thu, 16 Oct 2025 13:22:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrcAdKJUHa7P+g75kVAeMcu1GBVw0vLJXNi7Bmcd+TwVbNriITJu0bKiz1xjIXDkX2pPHaqg==
X-Received: by 2002:a05:622a:1101:b0:4e8:9601:37f5 with SMTP id d75a77b69052e-4e89d05bcd6mr20995271cf.0.1760646135519;
        Thu, 16 Oct 2025 13:22:15 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881f9148sm7376487e87.44.2025.10.16.13.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 13:22:13 -0700 (PDT)
Date: Thu, 16 Oct 2025 23:22:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luo Jie <quic_luoj@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Devi Priya <quic_devipriy@quicinc.com>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        netdev@vger.kernel.org, quic_kkumarcs@quicinc.com,
        quic_linchen@quicinc.com, quic_leiwei@quicinc.com,
        quic_pavir@quicinc.com, quic_suruchia@quicinc.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v7 04/10] clk: qcom: gcc-ipq5424: Enable NSS NoC clocks
 to use icc-clk
Message-ID: <yegaz22k6jpn657tyuiavbchgc2unaoqgvsjn54dzdhnb6rr4s@twg5yrmxx7ot>
References: <20251014-qcom_ipq5424_nsscc-v7-0-081f4956be02@quicinc.com>
 <20251014-qcom_ipq5424_nsscc-v7-4-081f4956be02@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-qcom_ipq5424_nsscc-v7-4-081f4956be02@quicinc.com>
X-Authority-Analysis: v=2.4 cv=aPD9aL9m c=1 sm=1 tr=0 ts=68f153f9 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=DdE-_dUAR9VioeaCo_UA:9 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDAxNyBTYWx0ZWRfX1JopmaPfholP
 VVPMGPxtLZdQ4TOX8EqJhXY7pzSWSs6d0kAlUe3yoTYScOXDDt9wAiecW0NbAOCCQ/93jknrhAA
 cv8IOGlTxpQ2T3qrEnhQTgBGGF9jjmLhMaULa1QjHgmOb5BR33dU9M2+Y5dxzc1N0LRhykzyT/X
 SpGXFuAA1tko3z+i/eet+ty+t23RcCNVG/GNU/mXItlYMMDE9mRDQOVrLCgoqm7AyaksUoE+SlJ
 2SinPDg294YOSN2IJwWCEPPg5DKfyMwNhyLcI1mwyWzhr4RKwsTAZmNdE4TMOPfiTw5GWA446yn
 XRLR+ieU+fsYTQfoQvEJOe22104cbJZ05pSPzmvpsWIFtz8MR/dqIDNLkYnmrGPAFJvpuBYq9pY
 pKdsX7tQMm84ox7fNmftpud3eIdNKA==
X-Proofpoint-ORIG-GUID: pa7JpvOl_JjR6Kn25xfk_ljb9n9Zisel
X-Proofpoint-GUID: pa7JpvOl_JjR6Kn25xfk_ljb9n9Zisel
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510160017

On Tue, Oct 14, 2025 at 10:35:29PM +0800, Luo Jie wrote:
> Add NSS NoC clocks using the icc-clk framework to create interconnect
> paths. The network subsystem (NSS) can be connected to these NoCs.
> 
> Additionally, add the LPASS CNOC and SNOC nodes to establish the complete
> interconnect path.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  drivers/clk/qcom/gcc-ipq5424.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

