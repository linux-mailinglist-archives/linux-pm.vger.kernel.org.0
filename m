Return-Path: <linux-pm+bounces-27951-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A402ACA98F
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jun 2025 08:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E51C61897FF7
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jun 2025 06:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363481A2C27;
	Mon,  2 Jun 2025 06:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c+2fSjoF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09631A08AF
	for <linux-pm@vger.kernel.org>; Mon,  2 Jun 2025 06:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748846339; cv=none; b=kFjSLogrkQ3cqPcYkg/I1vvcm29TxBPEuecohvvLX206gDhpvO/LguLo1ogUbLhZn6m/P5TrZX1BM9PZfnRf64GxQM7zQVmBXKfGdI7ouroqAkK7zw4Xd1H4Pq3BbUXI8bZr8mcxh6+sVo5r50DyQ74bmKkRLoSLC0vXHsBnadw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748846339; c=relaxed/simple;
	bh=H+8hGcc842VAoSFMkYka2oWdV8tk0M9H+OQ/c5+ATvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/DeToAUhgj1DjSEgKV4lA8OkjYRGg/ACxBvTqTXMaDXqAKzLhMEZ+ioJjxJY9e/dZQv4xWI7XPf/1uv1xudtlQjxAdHqQxevzJmFhZ/EGeS+oDO8MqMeYB9Egw9eaR8M/LEYZcvayvtc23YUSLsUH7PSfV7TUicnwn7CXsDAwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c+2fSjoF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 551NFYRo029496
	for <linux-pm@vger.kernel.org>; Mon, 2 Jun 2025 06:38:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hgWpVsIqocxgnFNmFrMMXpBx
	7pW8ByX+8nWPO0pYioI=; b=c+2fSjoFh7WeBjQikGYXsMtaxntSzjiLRWVr0Ujr
	bC46VWaexDO2BlDRU2QMNVLfLXw98WJ8XcONky5QbZha/BhapV4fUfN8eQMWTb9y
	AaKk8VA2EbymeOFGfxPN4+6BieDeXGdpxBW6KKmf/ThOLaHd0tlT3y8E1+rE7fFD
	z7SXJNkGkUG4M47vm4cyC6jAUhodtw8W+Gmq37F1PdHjhI65yO3jxqtgRU5Shlln
	p/Q7jm1qkqXsGM2asyaXvgIvj/MTi0aUGCDz0zt0VCWvNcHMI7IcWTCI/JrNsCiP
	2C6hhkHJWHzmcmp7/M5xaMBGBMlo2Z+irN++40giZsLuHg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46ytm4kj22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 02 Jun 2025 06:38:56 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c5d608e6f5so1100162885a.0
        for <linux-pm@vger.kernel.org>; Sun, 01 Jun 2025 23:38:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748846332; x=1749451132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgWpVsIqocxgnFNmFrMMXpBx7pW8ByX+8nWPO0pYioI=;
        b=tDEgra8AAFm+I9mPjS2F1H8xVZ9y+4P3NRECVkWabrV1zRgYcMCz9ehYKZ5DkDxRdd
         vUBYY2KynFZtVNY0roqCTYHHKPvG94tOa6a+2rXf7nDcdkw9Q5aqJdV35W2qLoXVRZ14
         Mh/yXK4gn2G522wngkIkjGHMYjNcI8UhZxGMCbRaa7hpYAsx5yFhXD5aVz6Rq91S4lhq
         AD9PX9Nw4UAALMnjAvSkq6eJeShL82FaBuS8mHBqRJSu3W/hRSQkfYGTqR/g/OKOgEWL
         G83ns3KjrPHUVcobrSwLPQYY9rJcl1MqLjvi2h+QymcKM82QNE4DC09QNaythWIlx4CR
         OOmw==
X-Forwarded-Encrypted: i=1; AJvYcCW5Ttuv7hlLorLgUg+LZsL90DglWdltiJVYurS2l3x1tkdxL3bLxtglkjhIpE/1D9NebmwgHCPQ9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxE1nxVVVbaSm8m3R0n3iKFE/1RE8VIlKtjE+v3NTTC9jwhPDth
	OySqxka5Ptlouz1grq5gRbPcg/5ujm4S3Xx1UNsDpi8D1NWPkc8tkgUbzoy/qJc38J1z70V4HeR
	bjibuDVxK92f/Xg+Mt2WbKNH9lSk7iX8rDatF3JuhapXvjsSpY5+T2x18p5cjXg==
X-Gm-Gg: ASbGncuTJWXTz/agK0obcAWgmUCSZeIRTM8rk9jlb73vomhhvlLX1Fc1262oGRUmlxy
	YyC7ol5zypPvMw/izQ25xnQOzyW4/LhqNSG4vsDIYLSopMlPZlUgDsZF0qfpLMNsnLbwSy0cnlw
	GSZEgR2UtesKVQWwsyoZrLQy5vAGUJ4x1ZP+KOKzixUqHZtRXXZ0HoQIsjYbX7Janu4CppvFdc3
	8+YUgIPDKMUjr+U+jrod5wFWYO4JxRLB/yHduqZho/JHZ/+pUQJnTe8IrvSxO1kKnhNgwbmlMry
	c1GHm5r39U0Dmspa8MvDI2a8qdUa7JCed1oW2td7cntuhEJr3/LTpsGdzLfOHu3Npurcbnhf4VI
	=
X-Received: by 2002:a05:620a:31aa:b0:7c5:3d60:7f91 with SMTP id af79cd13be357-7d0a4aef53dmr1398543685a.15.1748846332380;
        Sun, 01 Jun 2025 23:38:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAH7lHJMHtm+wUmKQxUSIBCKgWZpMZBY9hHwWCQqMr0n2nY53V40/nig5MZ05K/Bkx/ImbsQ==
X-Received: by 2002:a05:620a:31aa:b0:7c5:3d60:7f91 with SMTP id af79cd13be357-7d0a4aef53dmr1398541485a.15.1748846331792;
        Sun, 01 Jun 2025 23:38:51 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553379378easm1498469e87.240.2025.06.01.23.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 23:38:50 -0700 (PDT)
Date: Mon, 2 Jun 2025 09:38:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: fenglin.wu@oss.qualcomm.com
Cc: Sebastian Reichel <sre@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@oss.qualcomm.com,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 6/8] dt-bindings: soc: qcom: pmic-glink: Move X1E80100
 out of fallbacks
Message-ID: <mdxfitbkyfwt7efjshygpjvg3s6mvlq75sa6hatk574iocd2nx@kvn2o66nppih>
References: <20250530-qcom_battmgr_update-v2-0-9e377193a656@oss.qualcomm.com>
 <20250530-qcom_battmgr_update-v2-6-9e377193a656@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530-qcom_battmgr_update-v2-6-9e377193a656@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=RrDFLDmK c=1 sm=1 tr=0 ts=683d4700 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=EhlfILWT9FdnabWGdsAA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: XRsAvZ2xdLZR4Yxq3x5fL4hPYrm8UW53
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDA1NSBTYWx0ZWRfXy35zE0llMPfA
 hh10n9KwN8FNy4JZftqCmH2NCa+eOzg88XPbMOMsWcwme4M65mrHP/I5NDOTzx/u1vL+B0zFQMt
 oN/EOjwZTpdNg1wOxjSV3OCbaofyo5Ir1lT8yZli57rkopKJ0/8NzWdbdS/58uERf9udyUEzWMF
 zD5giWyExsxQp+L2/nNQWdK9RoYXcxWh0KUiz9t6UbiGou5bA2IjYYTPK1a6TMmgINTXB5kfK6r
 BdiDWT/Nr4JV5/D2EtCRMJzHwTPC8Y8z8zHhdRouftDazxtPag3F8jlYeR0qaTRVRYUTX6xk+mV
 NF31zx6GLiCXrWkghXguhKcUd1A4tWfI7v4NVrhwTVtA3+kGg+hp2U0YcLl8otmMvYIgqWcHGnm
 ee0iwqOq7ggJ4oZSBhnkd4umQogn0HkzNVtOztoFoWujd4a8DfhbBkCSk2Kl/tyXh+egGDGB
X-Proofpoint-GUID: XRsAvZ2xdLZR4Yxq3x5fL4hPYrm8UW53
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_02,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 mlxlogscore=894 impostorscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2506020055

On Fri, May 30, 2025 at 03:35:11PM +0800, Fenglin Wu via B4 Relay wrote:
> From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> 
> Move X1E80100 out of the fallbacks of SM8550 in pmic-glink support.

Why?

> 
> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
> index 4c9e78f29523e3d77aacb4299f64ab96f9b1a831..972bec151118f2e20e1f3b4e0c0a8fbbbea7ab90 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
> @@ -39,9 +39,11 @@ properties:
>            - enum:
>                - qcom,sm8650-pmic-glink
>                - qcom,sm8750-pmic-glink
> -              - qcom,x1e80100-pmic-glink
>            - const: qcom,sm8550-pmic-glink
>            - const: qcom,pmic-glink
> +      - items:
> +          - const: qcom,x1e80100-pmic-glink
> +          - const: qcom,pmic-glink
>  
>    '#address-cells':
>      const: 1
> 
> -- 
> 2.34.1
> 
> 

-- 
With best wishes
Dmitry

