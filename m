Return-Path: <linux-pm+bounces-32078-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DF6B1F2DF
	for <lists+linux-pm@lfdr.de>; Sat,  9 Aug 2025 09:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 814141C22202
	for <lists+linux-pm@lfdr.de>; Sat,  9 Aug 2025 07:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B265F26CE02;
	Sat,  9 Aug 2025 07:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZTh+RC49"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC4521FF36
	for <linux-pm@vger.kernel.org>; Sat,  9 Aug 2025 07:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754724946; cv=none; b=Xn6OTpXaW/polSZ74cmIjhvRSDCXFgReD+582dyCyBDEGiFH24SsRjnkJuVbDaR6FmaWRB1bai7i4M5kXOmjgHTea2T3bJWIpHOmPMqoLpKUgL/tOJd2Br0adJQDMJ2RNLxBMJl8Cz+jEY98q0ffyGjvVDLUpXrm1CI7/lqyUug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754724946; c=relaxed/simple;
	bh=E6AUHyZMMF/+zPZS44mF8zqFA4Pv6VLV5G4A7JiW9ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uN8Mujp5VimiCauqhZ1iW5MKLK2f4LQx2SVvKHjx463EaUcY1z4OTdChCLjh6MUnDfDzz3T7DYzBfx58d+L90cyi22Hcmf9tismODODPuClFfbR2jTMbCSWbuTzn/9QxhIIoJ5xipDNOhQ0mjAYuwzBQs1BrnMYlDakJ7ZqHNpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZTh+RC49; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5793Z3Fa012597
	for <linux-pm@vger.kernel.org>; Sat, 9 Aug 2025 07:35:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=793ppZWsrIij77Y1OuUluZp4
	P0smE2E/QLjBMEM3Awo=; b=ZTh+RC49HHbXdonFVTRS/yBg5wK6je48hIaNoPuW
	qoHu1xemBHvxwbSXjRFBSrPQqWFyfBAiLgRvly0sP7NgrsnL6ZNUK0c2TOp6grOc
	v1ffoKlsvVfrIBeR36UkTPumPQ0IFiWLd3LJzFXrVfSpHvMUsep1L+Li4GnWvy7H
	d9tIza/J5l/ZE1WRNA3cuxf9MTrbxaxWEuv61WCMAe1x81Nv7Q4GUr1ayRUDw6Zm
	9SWsiE8vXoH0gy59mUvZFyhwFYsdhOvUlD5mbsF2UXgHSOxOFgKIEgd0YsWYYZwJ
	P1shnX4tfyJ3LoZyVk8DblEzJgrTkDh9unHQtS9HRjSQ0Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxj408rx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 09 Aug 2025 07:35:44 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70741fda996so52549156d6.0
        for <linux-pm@vger.kernel.org>; Sat, 09 Aug 2025 00:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754724943; x=1755329743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=793ppZWsrIij77Y1OuUluZp4P0smE2E/QLjBMEM3Awo=;
        b=D3o8coREJ6InP6WmZKVA8Rqgmxp04bvjpnT13Gd/Kkg2erKdh2OHy0uqhDVS+f+0p1
         lGcHd2faKeB1qhEUzFZs8wXG+hcdMg1p5oraViwheyNVNZ29wdAnruGuWf/yZW/Mioy5
         4pJvdD9OOQPlWhmG9srWQZ/2KDgTW2VDScLY1CnlDHnzaAxpC+7l4AafsnHgzPnjcgrd
         oJbiw+yU4V9OBnatB2k5mDhtSKeUyz5DyiQdUCGNbNxPvXafYdLMesfLJ7rsosaYlstN
         Shfrw1/yH2BDn39NJDC9Nt6yMf27cKMHx96ZYgdMkHUXQtUx/AyF/gtskgWe7NLBfr9h
         sE7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWouOqAXQ+fFFE/jFBoCReax1oDYRd4n57tEjndsCzomd3lgWmANQoaKdlx/nB87flwawUiPSAwmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWGxPhB3ay0eNxziVPkDJSWUX6s08nguLsXnWVvY8Tl/nlD1Om
	NXl0cENUPG2xVYb8aV/1sXT1X8Jx8h9R3+lYj/NPpDZ/iuu0si7muVy9LpB9YsXVUFLBboHr/NY
	+DzZkR8CHjIsfeTVujOsqlphswTcEBtLA1RZsgdzMaGHILFiNnSXU8HJ1zDMWBQ==
X-Gm-Gg: ASbGncv2cCS+gL71cfr8FkQTZH3Ywm/4WlOC5ms0pndLJ5G3BM7Kzm/oDUfiiYdt/TU
	tj+5Cj0ZjEGvVMEtrH3IsrrKBu9h35ZmNLm+pVXmtcH4nK9NhpTY5x8eSvZF5JUoMo09WA+dy26
	r0N4yLfIH4jLATw5vONQKYA+YSnjdrz9RvdXsyDRJD6sg7pr0OMqqPrfD0xw/dIT3peLhH+/Lpl
	7T6mQU93TnyborumXErILdfqRny/BUupXXS6S8/Z7GPA+Iw++KUYAplAyCOYN21C7ym3nbD2Qgz
	Nm5ORsggkuhKFH+wijzPEnE3c6uUTAkE7hrWi2YHINj+HETGyNr5MVPwCyGpeYiIpAtoi8MV37u
	kZ6hB+I8W1Snj2NtgUZdTOrawJS9nlvtiIAOWihRl0kQTUIeHFvtu
X-Received: by 2002:ad4:5aa8:0:b0:707:6977:aa9f with SMTP id 6a1803df08f44-7099a374e7amr75943636d6.36.1754724943140;
        Sat, 09 Aug 2025 00:35:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+V3FN8kp+AjaeE6KYwRPxZyM6Hct2o3VLDBaJ/JP9bICpHavNGCU00WGCKhqaasJHXQECEQ==
X-Received: by 2002:ad4:5aa8:0:b0:707:6977:aa9f with SMTP id 6a1803df08f44-7099a374e7amr75943476d6.36.1754724942748;
        Sat, 09 Aug 2025 00:35:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c9904csm3407575e87.112.2025.08.09.00.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 00:35:40 -0700 (PDT)
Date: Sat, 9 Aug 2025 10:35:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: Re: [PATCH 2/3] interconnect: qcom: sa8775p: enable QoS configuration
Message-ID: <sdp4moiiii5zjz7m7ysds3je4h66biuusilc4fx4bq2j4dw7ur@5d3c6gkk6wb7>
References: <20250808140300.14784-1-odelu.kukatla@oss.qualcomm.com>
 <20250808140300.14784-3-odelu.kukatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808140300.14784-3-odelu.kukatla@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNyBTYWx0ZWRfX8qvueuh39TJy
 l2Fs0/z42Z5EEHycjhwSQgQJZ6FRJxy+3BXAmIlFBZw0cBr/+jFGh4Ah/cMKKI+x4oGPYNoqwuP
 OTBrev4SwtTRkiCHjzPL5e1AHUGWICkRPHjd4DYplTYQHsGIzKxzkLNd/aN/GIg4sir865LIzn/
 HPPnL3pb5QHhfWrTms91o9jOr2C2Kklx1+b4TwjdK77TLHE3sSEDAcbHLVkYzRgpMhv3JZr4FvI
 NnW0rMfB24KFZv1AKpPZFT+s4l9XgtZNhtchpCx5avDf6oNvRZiOlK5/bYgrH3b/5IbOJgX+OS3
 fKVxeuqw4Bmkf1OHIbpQoUlie0O+VXxYD1O0tNRZ9+v3bZhe0jlAN1Qrev+NHMTe3ytYc6l1bOX
 qWqsomZM
X-Authority-Analysis: v=2.4 cv=fvDcZE4f c=1 sm=1 tr=0 ts=6896fa50 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=t2WmfeA6w6qF_8Xn0-8A:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: N0XkZHf6RKR5We8r30muTQGFY9hIKBw4
X-Proofpoint-GUID: N0XkZHf6RKR5We8r30muTQGFY9hIKBw4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-09_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090027

On Fri, Aug 08, 2025 at 07:32:59PM +0530, Odelu Kukatla wrote:
> Enable QoS configuration for master ports with predefined
> priority and urgency forwarding.
> 
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> ---
>  drivers/interconnect/qcom/sa8775p.c | 439 ++++++++++++++++++++++++++++
>  1 file changed, 439 insertions(+)
> 
> diff --git a/drivers/interconnect/qcom/sa8775p.c b/drivers/interconnect/qcom/sa8775p.c
> index 04b4abbf4487..5bf27dbe818d 100644
> --- a/drivers/interconnect/qcom/sa8775p.c
> +++ b/drivers/interconnect/qcom/sa8775p.c
> @@ -213,6 +213,13 @@ static struct qcom_icc_node qxm_qup3 = {
>  	.name = "qxm_qup3",
>  	.channels = 1,
>  	.buswidth = 8,
> +	.qosbox = &(const struct qcom_icc_qosbox) {

Please follow the design on milos / sar2130p / sm8650 and add a separate
struct instance outside of qcom_icc_node.

LGTM otherwise

> +		.num_ports = 1,
> +		.port_offsets = { 0x11000 },
> +		.prio_fwd_disable = 1,
> +		.prio = 2,
> +		.urg_fwd = 0,
> +	},
>  	.num_links = 1,
>  	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
>  };

-- 
With best wishes
Dmitry

