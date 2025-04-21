Return-Path: <linux-pm+bounces-25817-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D878AA956B6
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 21:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94633188E6B8
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 19:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35261EF371;
	Mon, 21 Apr 2025 19:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KyR8DsOa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723421EDA11
	for <linux-pm@vger.kernel.org>; Mon, 21 Apr 2025 19:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745263297; cv=none; b=MPne54pndHShn0DbSlQrk/lBgH482ijYrui4+z/z8Ka9kJJDBy0uJrYxWgIq4lzVLje3kPrXyNykvn7/L5hIgcb78dBds+xzhzwMzAIHdRMairZwVrTjOWsLb47+Rr//IvuEZTjR547huPa80z3FcwzxA7HnPwVsJiJIBx1+PMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745263297; c=relaxed/simple;
	bh=rk28eIe8cUsJd6JGPxM8wYcVeLlzBfqL2U6EcTaSL6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2EW05DdxTqDm3KNPnziFiL7ncxczmrtPrQbHpY1ZlYSivd8K2FPN0mAUsPmSNkVp9BHwJebXS4mhSXZ53iTVytGUcDAwd/kc2Rr/BoLtVRrdumrKOjoc85iQukJKT2ie8Euq9S5FVPLuVbe7iLuwkdBKjOOcUPSnqNHvf4S+G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KyR8DsOa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53LIgCWR018295
	for <linux-pm@vger.kernel.org>; Mon, 21 Apr 2025 19:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=GuwNQL7COdR6K7Wu0mEB7jrt
	g9au9uotOWdW3087MZk=; b=KyR8DsOa4kff5NLOokkO561Lhopgr669vN1aPhR7
	7pr7YTCCqkYj/zBzgEIFKPzRptdapbJHATcqJLXdF06N/DD4msmgVatevDSiZYof
	DIXP30+J+69GCmPj4nGoT+FGDX/OBsYWJVCHX5fnBp0lpa5D0YUF0cXlMzPfnE79
	HhgJFNZrjKOUZPMhUuRJyb92JLH+v23SfAp8hbWANs4ZVgoT6K0QiazTnwnKHY3n
	x9goIZs1sZD9DFIJmmhQBgYNinqQaSi3Y5vezPx7cH5aDnU0pShOwWRT+EBNr+GU
	Hj8v7uC3nXEP3+2VXCYT2/CtGnIGcvjmYvH4lgGnULii0Q==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4644kjcym4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 21 Apr 2025 19:21:35 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e8feffbe08so108349676d6.0
        for <linux-pm@vger.kernel.org>; Mon, 21 Apr 2025 12:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745263294; x=1745868094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuwNQL7COdR6K7Wu0mEB7jrtg9au9uotOWdW3087MZk=;
        b=oARlpM5J3xZOlX91IFnGGao0Ccvn0q1t81f3y/jz+W52Voqwg3MIptrkmdxeNymVbg
         r+xwFDAYs5bbBZLXgWUmQOGzlQKK45s7yZUexcX+JJwyje3lZosYzs7LtgC/sG0uNgdK
         AFAGdQhNQ2KtJYHduqtLdvIp87z9IjXygaK2TyV4gUnASfzI8MkwWASB6ZByn8T4rfDU
         pho09ROjGTZtu21Kea+2zHnbrf0b/+S9qbIT034b042+AXazrPylMjAHecaEXEGh+Ara
         jq0qjtTVj4Up6xFKgGzX5omvv8e7dQy0fKpYr+Z6cMrdBNGibVLVH9Afx6AeBGptd50V
         +4fw==
X-Forwarded-Encrypted: i=1; AJvYcCVvbAyt4GCWmmU0wa10UuPOO/lsWiRjCdKDCt7wTwidY/SJJ9XNwymJvbS2Ul1Pc7rp+4IyZRXe7g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/jQbf9jaaUPLzXb7T9EBb61bgUVOiS/2NfMOT00OUuOObi384
	riWx5nbxd/nrbdzOzwp/dfxZLHu7LQArI+51nbh6AG94L1moOL/pT61lvpbWtUOjMB1APz+mPRm
	y6VoBzCsa5ADmsFqkInfK+rbEnSL2h1sfdSxItPAqmkZgxo8KMEgu2hkuVg==
X-Gm-Gg: ASbGncv1/pknC0pBmynfzTlM0brG1YvXoB8eX43ehtmT9akCiu/J/yeXxS9p/Rd1y2v
	dSlmvKyOLDqPw8QyxNY+Dn+plzxalrmS+Xj1x25CC3JxcQNjwW8ndl+GhOkQS7njGXKa21d5boD
	MixiUCqUoZax2uxB/SamM8EW+7eqRr8BOJSo9AQv8uUbZYQbO8MuH0L9PA4r8SCKIQhnx4vk938
	jhAYlRe+xCsnF7Pp0R1xCwAHDTtpDGc5FSqRxd944ydqQA0/YkF6SfjRMy9ILgqEnPBKBxtSqlm
	ECu/Br5WrX+fFUnXzCHEkMNPcxlZop/0SdmHGvDTCGmpSKtu18j1bwA/D9mKV2i1mGE6yGAlANU
	=
X-Received: by 2002:ad4:5d43:0:b0:6eb:2878:e1fa with SMTP id 6a1803df08f44-6f2c4688548mr234091496d6.45.1745263294090;
        Mon, 21 Apr 2025 12:21:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHjCANftnq5MsyzBJlMsyrsIUVpzmaMDTame740xj5QASOSOvM3bIvntY44xJmDpLFkmTi5w==
X-Received: by 2002:ad4:5d43:0:b0:6eb:2878:e1fa with SMTP id 6a1803df08f44-6f2c4688548mr234091156d6.45.1745263293737;
        Mon, 21 Apr 2025 12:21:33 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3109075f28dsm12536521fa.6.2025.04.21.12.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 12:21:32 -0700 (PDT)
Date: Mon, 21 Apr 2025 22:21:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] interconnect: qcom: sm8650: add the MASTER_APSS_NOC
Message-ID: <xtumjcqontja5nuaalh2xqij4g7e3bxhlqxdwkiwqxbaickppu@p33ym2w3qnbm>
References: <20250415-topic-sm8650-upstream-icc-apss-noc-v1-0-9e6bea3943d8@linaro.org>
 <20250415-topic-sm8650-upstream-icc-apss-noc-v1-2-9e6bea3943d8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415-topic-sm8650-upstream-icc-apss-noc-v1-2-9e6bea3943d8@linaro.org>
X-Proofpoint-GUID: mjIxEUOaVljidcNYUOj5funjmz6pcNSM
X-Authority-Analysis: v=2.4 cv=f5pIBPyM c=1 sm=1 tr=0 ts=68069abf cx=c_pps a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=pi3gJ-yj7RBswzpYwZwA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: mjIxEUOaVljidcNYUOj5funjmz6pcNSM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_09,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxlogscore=832 mlxscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504210151

On Tue, Apr 15, 2025 at 04:03:48PM +0200, Neil Armstrong wrote:
> Add the MASTER_APSS_NOC interconnect node of the system NoC
> and the associated QoS configuration.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/interconnect/qcom/sm8650.c | 19 +++++++++++++++++++
>  drivers/interconnect/qcom/sm8650.h |  1 +
>  2 files changed, 20 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

