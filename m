Return-Path: <linux-pm+bounces-32079-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A65A5B1F2E4
	for <lists+linux-pm@lfdr.de>; Sat,  9 Aug 2025 09:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62283625FE2
	for <lists+linux-pm@lfdr.de>; Sat,  9 Aug 2025 07:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC8727A446;
	Sat,  9 Aug 2025 07:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fq17dNGB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1963321FF36
	for <linux-pm@vger.kernel.org>; Sat,  9 Aug 2025 07:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754725000; cv=none; b=STHLE6wdB2tQ+7ldcaO7Twssv48yOXweOgUtIF5wMTyKqvqb39yvoN+uqktgxgX7xdD6TI9MNsSHgvWyHUJvwlAQnlYelu6fy6YWHQo52Kxvccreqvkloi/bz6b+mm2+lT4oByzGEmP8MJZShE0eDtYY5zS0uNKM1WTdjG6ShWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754725000; c=relaxed/simple;
	bh=KV+nbotmPaioDUnvPXisviPPbgOFzIExIt4xbAI+QB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oA2+tlwz9z4Ulk+ty69VweT1D9UPTe9A2nF7dD5p3V4QKFPttQzOoly1frfjMIDWsKqLJgqnbjqETu1qbfqhQrQfDkkDHdr8TE942XfwgDbU8HMxSHWe5ujyTaT11A1rgN66LO2FlPKGnMVtvVgWrl5PNV/rYSCZACevUZgz/TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fq17dNGB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5794Bp5U029633
	for <linux-pm@vger.kernel.org>; Sat, 9 Aug 2025 07:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aFTb545D0EnqrmPmVub6t9kx
	Cv83ILSV+GDMnaszhak=; b=Fq17dNGBacqviGWaJFSjXGQRQfwJ/Q/jYxDp3HLs
	nyTcCfLkOck38U9EreOOEv/8r0yXm2yQ+b2H2VS3nnm2h0p/JFJxbkqdnGXirhc5
	eoG3zV4VBm5Bo6c7HbcJkx/PUZSveIRy8rvwqwO0OfwFzCwe0wcayohuBQwzlfwC
	FU+D8P9RjW2qJcvHQQCxtLyjihevvDUV5RaSmor5u09jyxLcEFB9AzxmFS2xSwZ2
	R+gA/u3xKW0EbcIMReykp+O7DfaCNALn/OF6sOcuHjTqxD5UFgmd1tpaV61/PwfT
	J2VLv5JUukQ/7A//Ig6QJ4K/szHuwf5V3WsPsr0WciMD6g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dy3g07g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 09 Aug 2025 07:36:37 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b08b271095so76363901cf.0
        for <linux-pm@vger.kernel.org>; Sat, 09 Aug 2025 00:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754724996; x=1755329796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFTb545D0EnqrmPmVub6t9kxCv83ILSV+GDMnaszhak=;
        b=IZBlDQ9ZqvJmShqdHRu2g2En3ziIpPlfstipfwdj41ASTDZ5ochx90PgEElFzdfoNi
         5B0B7tEFzSvIRVq8OtjWeWSDXe6krDQxQtOIjc45Pj/oKq1gZ0qLh3vARvuHLEnsZBqK
         nYiI/8V15IWr743Auj+f6WyszN0sQzZPMGa885F8LCO4pvKYMuPdacG/uf+7OCGyd2+0
         b+hBiY2L0Ky4KqKdM85cUGpt/5l7+DePKt7NQNkfnKih6D0UcT9x6LXZRALL6p7cDKxl
         mtMwwJrSVDsgivgFPjwqGJs5yId+vKzukeBgSCm+0WDNwVpAihrbILk6R9cfrCL71xyH
         PnQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXG9o2N/PJKcnYWlsROmk5+o01ciGApvZjTD5aKXd/+L4id1dXqdHJlBuJtNNI2OFZIUpu4dttuYw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXY2nYG4xvozoDpYPpFHxVmxUrfuWtO2LOk4QewodHnMI2XKib
	HSQ8foM1qsbA+f67UT1IUZNbDTb5z/hVn2UcMAJvlwb4djmY+PW+v8VfOuMFQtmrkC+eEMzQKV+
	5WdJxjROQeL5zX0kvgZsrNdpACWDH9l6eHn5KJekks0cX7uytVXBIG5pseu7A7g==
X-Gm-Gg: ASbGncs2FWOYN27/hZX1OhWKGxvnaeVKATH8F94G1ZpjVRNboEhZxYN1sLHk44bJZwt
	GbkgSzfr4xHi9Ypn9vxmvn0NVKcrxCVxM4WVa+GsuN0FEIcp38QNNFqMXov3lldSIcyefUx9D49
	ldO6ahoMOb++DG9URvrByVMqd6VLrX7q5tK2Bqszy8FwGWWg9XnXI19GK/4t/0s1a+MolDW+Pzs
	QWhngJZILyxyUiXRv2107NhYyoWg07vEq6Xq9d3s/tU9UFZPm+ACmHKQ+uUr0FdEFJ9Gt2lU6+v
	aL+B26r+rOoVQ2tqmz4nsVB8Y9aPb4/itP5/JxHUU24+xz7qMdyoRvHA0MAmkCX1usbSSxREI+E
	ZhvOLLDNci0Gd9dTHC5+NwHcviYrrI86go/yH26XmoDxkXY8ITZ78
X-Received: by 2002:a05:622a:5590:b0:48d:8053:d8ee with SMTP id d75a77b69052e-4b0aedd7cd9mr80306541cf.36.1754724995877;
        Sat, 09 Aug 2025 00:36:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXEneZ+bObkvykBsZKTcd6gDIK9QejwdLRYsOVtihnF52Hii0pS/IlNMrVnQLjwaC1m/b2yA==
X-Received: by 2002:a05:622a:5590:b0:48d:8053:d8ee with SMTP id d75a77b69052e-4b0aedd7cd9mr80306271cf.36.1754724995440;
        Sat, 09 Aug 2025 00:36:35 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b889a03acsm3288206e87.51.2025.08.09.00.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 00:36:34 -0700 (PDT)
Date: Sat, 9 Aug 2025 10:36:32 +0300
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
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sa8775p: Add clocks for QoS
 configuration
Message-ID: <m7pqgeqzpqdal5yyukszzbkniyijiji3khzanwjfqxah3prgij@ucgndrn5smwq>
References: <20250808140300.14784-1-odelu.kukatla@oss.qualcomm.com>
 <20250808140300.14784-4-odelu.kukatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808140300.14784-4-odelu.kukatla@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=X4lSKHTe c=1 sm=1 tr=0 ts=6896fa85 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=M9tGKf1UEhd6l-wMVe4A:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzMSBTYWx0ZWRfX8qDv/T7ZoYxj
 ZOwNs+XM7N+qFfC+xIDuV6+KEGzcgayo0euP+7aVOKJJNYsaU8D7QFsVkpYfvUVocKDErDTL5v8
 OEj8usj3MaeKKURXkBq/tDA3UbGIUXn6OB1S3K3UcEDp3pXjxfX8OrP93nT6n6uyDiIuwEoX18x
 SnbVs8eN06FNz6Uphhvd0oAiJffoHtBXB8jpgysl2dIp1j1N0m0LRhj0QEh0/hCqQbc9zYkXYF8
 5hfKjZvD8AadW9EVhQCmEa8WRa6OhltCo8X+Nu9wGQi+1DKKT9sgIkUv3S4eX8XGhrNVsNSTWpN
 B1JcLIDlFfoyQqo3Icu3Dbm9je3rMIq0/HLEIxupzdZiEn39g7GdgEsfPtUyD9ojbXyEZnHs6Q7
 MxgSx3NN
X-Proofpoint-GUID: ALeL8YGtRVDdwbSo1XjRB-gJuYZsoTRb
X-Proofpoint-ORIG-GUID: ALeL8YGtRVDdwbSo1XjRB-gJuYZsoTRb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-09_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090031

On Fri, Aug 08, 2025 at 07:33:00PM +0530, Odelu Kukatla wrote:
> Add register addresses and clocks which need to be enabled for
> configuring QoS on sa8775p SoC.
> 
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 163 ++++++++++++++------------
>  1 file changed, 91 insertions(+), 72 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

