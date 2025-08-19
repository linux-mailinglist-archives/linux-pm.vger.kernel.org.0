Return-Path: <linux-pm+bounces-32657-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD97B2CC2A
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 20:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EB6D1C251D0
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 18:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97F630F522;
	Tue, 19 Aug 2025 18:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b6VzpCZf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7761F30DD37
	for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755628563; cv=none; b=I3giwnIw54B7KlOaXCHFnp7YfGYGJ+W2ak3y+cIpeKujNATtrwyi6Xg7xqgCFcTHS/gZdbnpUgV03THs48MOsk+UZ3jcUAci2z7UDtfGsLc2ojDcHursNhmelSe03QcDW/V6/aEjGXzHqpszov/ViiTokbJYPGs2BKn5JlPKpRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755628563; c=relaxed/simple;
	bh=sTgf/CNCkxGhEaAwMV5unINPuICI+staVH3F5LIk2ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckIEEIIAXS48weTr7tor9395LsOzm5ihMWe70cKE9a8rxQwWZp8FZ6aXcn6nR1XH1br7ZTd4ziC4wTjUIabks0Ta9gSgL9/VMAnHYcTJi6HtLpg6+brOvX4fqPKi7Ined+grx6lc5GMxxQI5U6uddwfR9MNx/F1zNqCdKVgpeqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b6VzpCZf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JHOwfo021802
	for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 18:36:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=o240rpXb1npe1ccsIe0LIiBv
	/L8C+NSjEqGnuz2YrN8=; b=b6VzpCZf/0uYO01WP/f9h+p02aXCBYd+sRRaZtT3
	C7YQEOhHbR0zykWWrlqAOKk0UZ4UbaP0XQIUDgxf1D5g8MCP7QK0qtrgxldGqMFc
	VT5Ywg8FHXTLEvcsUh4+jUYU5+B1rETKver+48vO3KuLqZbEmcJDS5ftHSC4GgPZ
	bKCIhEOGiIcoYt7E2iEJ58RUkMgrdNGaIDNQXkYTIJxoKQrOsKSelhz3dAvxLESm
	gBW/3n2e5NfC+95lKeMb+yQ+Me+E3909Mb5cOMnPCttWMOOVizhYdmCCZF/B2dv/
	4SQ4SJ/lvBrO1wSsfMj9Pz6tKssgpOPPIj2ejj63nnPk0Q==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48m71cmc3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 18:36:00 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a927f4090so128861106d6.1
        for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 11:36:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755628559; x=1756233359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o240rpXb1npe1ccsIe0LIiBv/L8C+NSjEqGnuz2YrN8=;
        b=FAIG4DuEA4nDOx1yHNh8wAEdxDRgNtaWre6P8v6ruLjjQ5+HzVx4iiNNQrPOETkiQA
         ar5YaTWcfRPbfGeKU0a/gjoa9zKQOwVwNkzgMaUy2/3o6ioKziqbKHt5UrwFyw+UrWIs
         LDKdJzFV3ctQLjhcc1lbsQDKpPnHOudrJIeA4rxH3v0Oshh0sGBkQJ9M8khFu1NdHb/r
         lgzz49do6an2tAXDvAsgT1TiuSLv/mgmSJG8BuRzX302QEtoZ7npfDcGP4bVAzRwbhHv
         IBI7DEVsh3xS0Ru71Ky/gAH0z/LgvwsXdWThLezF2+OOkAyzqSzhhGB5h3kudiMQOkt1
         xBNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZvEE0Ta/3luV+pCyXrhxcHLF4g9Cm0EVts8u88InKnPmJ4EjIo3jGwYqil9Bf9ajFp9+3mEDMQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8+D+Wlhndav0xn4rjqsksxC48XRhhFFV5R076mjxRFXAaZGIO
	UgFV7ALn2bk+HpYPVAFT/gIyRYAoIEZHNViurRqfJArY07h9iq4cD9jTzyQjudbQeNzpkn++KHr
	FrXiOQ2BWtW/j5Lu+vsW3D5wpGUVwDfz7Xpds3Qzr6/DxEOgiDvrRD+C8jCQubQ==
X-Gm-Gg: ASbGncvQ4D+cOA4nk6t7NCXzHMm18Ds74QPcw+x7Scu2YMr5uOy0S5W/NCgXB0aph38
	SPR8LRBJEKzj5o6H18RcSpfHPH5SYi9gGTvBtihtYtt+8Njzn1I8on2XEs2PhMe7tNtJYoQBQLl
	TZl5rngsfoW+bh4kuRVGbXsEDF1KYzu87VHHQUnk4Ja0oSEYhNYAa6MQlsLlX9RkiRKUHAHfbtW
	u/J4X2VhZVxyY/D1wQKAIM0qUDHbnrqgWVQ6BQjGWJIaevKzpjECQpNMxy2ZGeSe5RAfOVqfPMV
	tEF0FptyDSqlVcopJsqjRJyAiQQGiM0UZbDdAM8ISj1QJRsW1cZUTtgsltOwqVhUzsL47dBPXJR
	gHY32GZZEKS3HPulj9drhT6W7dEugL/YuIFxZtAuHSImCI/JHSGOS
X-Received: by 2002:ad4:5cad:0:b0:709:e1d5:2470 with SMTP id 6a1803df08f44-70d76fd26bamr413876d6.20.1755628559259;
        Tue, 19 Aug 2025 11:35:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGmlAw5ivpCYe8dKVhVWxeKp6uuPutspQzTTRywH6aArEi8XXmLCe1KM8UMGq0ZEI0zbNZ8Q==
X-Received: by 2002:ad4:5cad:0:b0:709:e1d5:2470 with SMTP id 6a1803df08f44-70d76fd26bamr413576d6.20.1755628558770;
        Tue, 19 Aug 2025 11:35:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3516bcsm2227934e87.24.2025.08.19.11.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 11:35:57 -0700 (PDT)
Date: Tue, 19 Aug 2025 21:35:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: interconnect: document the RPMh
 Network-On-Chip interconnect in Glymur SoC
Message-ID: <phbil4fflttlcp7s4nxyceyb2a277eablveozggloufowwzplu@c4a2mrtnfunf>
References: <20250814-glymur-icc-v2-0-596cca6b6015@oss.qualcomm.com>
 <20250814-glymur-icc-v2-1-596cca6b6015@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814-glymur-icc-v2-1-596cca6b6015@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 6Ui3yx6sbveDHzRGmfq0MMFenEauO4H9
X-Proofpoint-GUID: 6Ui3yx6sbveDHzRGmfq0MMFenEauO4H9
X-Authority-Analysis: v=2.4 cv=IvQecK/g c=1 sm=1 tr=0 ts=68a4c410 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=pDoijQcVg5aKu1OD8A4A:9
 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDE0NyBTYWx0ZWRfX/GiexxBWt1S1
 9+x5mshfXKkqzZJl1j76Us85axLYBYzbNIF/PlEvLdz9O6YsYPWH13H0Y+suolBVZo6LSdOgx5l
 zCYmfn1wPXqoOgqnckoPZ9xDjnLz+/TOsETfxqeN9+lkp5cT442GVRPmu3ODGdJhs0ub7tVZRVN
 fzy8U+8NCfknXCALsReK7bp22pbGLN16qy/eBPkRF07lFTEFyi49a5ToZgKVlg2mjReYMu57N+V
 omJdxfMx4fmaqqBE3hDyK1bBXBXcfm7j+0QtZEegjb2dUYWZiT9DR3+S3iZiE4pA4CoflCudKpV
 w5xsuROpZvwi71qsGZsmVofpzcMNLto2hG7jUe0ZsS//4awIutI4UbOul22QTAuKy4Cr4uGo5NT
 HSFSCZIL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508180147

On Thu, Aug 14, 2025 at 02:54:19PM +0000, Raviteja Laggyshetty wrote:
> Document the RPMh Network-On-Chip Interconnect in Glymur platform.
> 
> Co-developed-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> ---
>  .../bindings/interconnect/qcom,glymur-rpmh.yaml    | 172 +++++++++++++++++
>  .../dt-bindings/interconnect/qcom,glymur-rpmh.h    | 205 +++++++++++++++++++++
>  2 files changed, 377 insertions(+)

> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,glymur-gcc.h>

Please drop this header and use ephemeral clocks in the devices below.
We don't need to point out particular GCC clocks, using
<&gcc_foo_bar_baz> is more than enough.

> +    clk_virt: interconnect-0 {
> +      compatible = "qcom,glymur-clk-virt";
> +      #interconnect-cells = <2>;
> +      qcom,bcm-voters = <&apps_bcm_voter>;
> +    };
> +
> +    aggre1_noc: interconnect@16e0000 {
> +      compatible = "qcom,glymur-aggre1-noc";
> +      reg = <0x016e0000 0x14400>;
> +      #interconnect-cells = <2>;
> +      qcom,bcm-voters = <&apps_bcm_voter>;
> +    };
> +
> +    aggre4_noc: interconnect@1740000 {
> +      compatible = "qcom,glymur-aggre4-noc";
> +      reg = <0x01740000 0x14400>;
> +      #interconnect-cells = <2>;
> +      qcom,bcm-voters = <&apps_bcm_voter>;
> +      clocks = <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
> +               <&gcc GCC_AGGRE_USB3_SEC_AXI_CLK>,
> +               <&gcc GCC_AGGRE_USB4_0_AXI_CLK>,
> +               <&gcc GCC_AGGRE_USB4_1_AXI_CLK>;
> +    };

-- 
With best wishes
Dmitry

