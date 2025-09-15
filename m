Return-Path: <linux-pm+bounces-34663-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 988A6B57619
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 12:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9911C3A1D79
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 10:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A202FB0B3;
	Mon, 15 Sep 2025 10:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K+s1jNkw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA8C2BEC31
	for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 10:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757931565; cv=none; b=i9u0laNXMyjnUnNnPEom7T/OSBa3yk/YTnIvOPEBcsq8h2W+gdCz80hoGP4IducMw680S9KHH2oeM/j3Z+tHf8VX71SgG4k9Md9Vn9EU69tvgcfBhfAv/WFI4nvRy3GeZQoKFaC0dKWxfTqrSAuIuGQYUMKa3VWHnBQOLP5Cks4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757931565; c=relaxed/simple;
	bh=GAvNiOwNLiOuGEpGEUrLWK+3lyHdXQJWYPvsInpu3LM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ds8evZnBbh9SHaZt0n8A5lMgW7fJ4eC6Dl6jnBq0HILTTj8Wfaaja50GDYlPXj0UywAU2hhXXznVpQKWTLkCb2XNyOohxjgVz379yutF5Gb1q03/6MxoH+nafHCoVjnAlAJlEkIS3s+TFqVqfkM7hGr6mDHYBn5Q1mSM321eYu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K+s1jNkw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F8FgMO031661
	for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 10:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Ge/q8lJD6Zf1XgGE/wTrOzdR
	wImk+MA4Q8tIDE6bFjc=; b=K+s1jNkwlUVxTPUGExGvCnuguYqROv5q6NYchZ5A
	zFWQdyrpLqSJn9SA/OVxSPSBXVXo3YMQJDI5sGDZULn6rxPZlMAgqW1achPvd7ac
	VSmeXyNK4V7NjemehnIFmyBlqmfLmgkP5fyVsokav7s3jKXo6DrRmw5rtCgQE/cy
	9xTKJ+1oaIz7rOV0KNUIOc4jrvKyR7pGRbf1tvAKxqknRx2zDHPkaO2AG8oDJlQv
	z5WAykYlZ6XxLWJ4oSSf6tQN3CWD6KSuJUXBxGhMwcPY1jpE/NBIWcX2WFBVH8C0
	Rl1jvkLS/BRRDcGyiS2vf9r7oFzOHqb6GpB7Tdg/JflUmg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494yma4jqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 10:19:22 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b47b4d296eso107374131cf.1
        for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 03:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757931562; x=1758536362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ge/q8lJD6Zf1XgGE/wTrOzdRwImk+MA4Q8tIDE6bFjc=;
        b=FdLMkSQ3VVnR8feBFj67pwjzc/Suf3682GHcoxdKU48hzRQS4lfWpfMUrJP2bpvfpL
         vZRZvlu+gQS3wxLuBT3EFzydxinzRulTLHMg6BgXHfvPjM9+4LT2HgyOnbktkspo77y7
         llWJbOYGEeHpYgQt/D5zBaqPwxOKC7WU7ceDEwccVbxD7xk5Nblf3wMjXQqxGKGjxlHW
         +K2miQ9TLCQmV4/0PBf05oMg79ThTTssoUE5aVLTfzED39EW7RdWHvoKHPEurPHsHZ2Y
         Bv8lZ+JmvhjS1+ZAzfQhLXBdFJB4JWGarJpsFFuC+F8hSxolrpxkpoaU3qb/ZnYKTOP3
         vd3A==
X-Forwarded-Encrypted: i=1; AJvYcCV8CdCqHZeFweFIXpet7BFhIYVJ3m3CHeQTYSO13/uTxJgnkBwTiJvOQ7Zx3snHUBvYDCsDxjCBhw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz68tbQsSOOMYl1qsyOFNtJ5VnlvjhKRBpKGDkFynczw9gzzXrG
	2A9W6zl6pr+JPqVu4xYSQNlTbSSb6RNp43paaWe1fZ2iIqJ6TDHPSEI/0v1nHp2Mn9KUvC9dJfb
	PJUqwC83ku9lV/Gmf02GsTFncnZ5uShrPjNEXxIRVLQsSzRI4Nfo1jego/7GrrA==
X-Gm-Gg: ASbGncvW76ePOY0/w2fRzrjXDhBp5UQrLMUerf0scc0ZW0tLFV6STu5AUyoYQKRPhsu
	bhfZrWcLVjnnRLFkqHb498PQ2A+A8gUJ9xkkDDGqjngcaIq+B7yBqmNrjjHqA5DcsSfzX/ety1f
	qGS0uGNMvL7GixKYZX4GCFb06xt5hyDKb8qQYjuU9iPXj3KjoK1kWNgKJf0H2ts7GZg8chEOm6Y
	jN1nwxLIRkKgYlTr/0cjpUA/vC7PkHiw1/fWcKLmIBUz/YWwLyWMTQkAoopP9XhEcJnsvtZbSmZ
	0qQDyuygYo9lX59ImePnJjo89PGYWwEPlKKXsUMaeoCKZaTz85RCVzbABstn+LoBULfr1PjYiCZ
	FT3fyL54/bAbeNTF3StqfnPOctueDnVsEOkjws0Mu2VDKcxAn37o8
X-Received: by 2002:a05:6214:f0f:b0:780:24d7:fd35 with SMTP id 6a1803df08f44-78024d80119mr41691826d6.43.1757931562014;
        Mon, 15 Sep 2025 03:19:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1FfXw0j6mkQjJ9r007AeakGY/pEvt0j/darfeawFeiMBnS9aGTLYNeE5U7vTUK75m0TpsgA==
X-Received: by 2002:a05:6214:f0f:b0:780:24d7:fd35 with SMTP id 6a1803df08f44-78024d80119mr41691366d6.43.1757931561502;
        Mon, 15 Sep 2025 03:19:21 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e6460f21asm3476750e87.106.2025.09.15.03.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:19:20 -0700 (PDT)
Date: Mon, 15 Sep 2025 13:19:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: fenglin.wu@oss.qualcomm.com
Cc: Sebastian Reichel <sre@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        =?utf-8?Q?Gy=C3=B6rgy?= Kurucz <me@kuruczgy.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@oss.qualcomm.com,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 5/8] power: supply: qcom_battmgr: update compats for
 SM8550 and X1E80100
Message-ID: <f3s2srlmvuj7wmh4rndffmbfrzylbuq4rsu7pqqrnqa5fgsmch@t5f4dgmqtgys>
References: <20250915-qcom_battmgr_update-v4-0-6f6464a41afe@oss.qualcomm.com>
 <20250915-qcom_battmgr_update-v4-5-6f6464a41afe@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915-qcom_battmgr_update-v4-5-6f6464a41afe@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxOSBTYWx0ZWRfXyf7YZaDGpuUx
 IAEYE3oB4DBN//QZGX/Qi57yHW8hDXu4/eGJ7anbxE5NFsrsAw1cUGJVhzhaf9Y1woz5XJtfO6i
 Rv3VPCoVllOEtVsYFjp0Ii5NdYIN+bR2ymQwJk0cHRNcR77YUzHHZAz3n/CKqSM72swKjO7+wsC
 6PiVA3GKMdrsXjsJOMHB2xQh9/cQfYiNrnag4opA+4EHoUx+JN5sfzHBUI4STQdD/TI9vEBnoG3
 3tKAWPI/P2WiwV1LWWjBII+sgfclISgXaqDUfydPDySRywAjyZcopGB3UuhGbd+I60Scvs+ZD7W
 gZ4dSG0WPR+TrlhI1kK7q9X2gtf47LP9tCzo8y3K3+6AaoNyItuZZ3mol09xGmLMCzY0M7C25/7
 QXx5ahi/
X-Authority-Analysis: v=2.4 cv=cdTSrmDM c=1 sm=1 tr=0 ts=68c7e82a cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=q0q343tyEA3zizLlqU8A:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: sOMrwb59jbyPQtP2fi2DBqDpWnzKaTRi
X-Proofpoint-GUID: sOMrwb59jbyPQtP2fi2DBqDpWnzKaTRi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_04,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130019

On Mon, Sep 15, 2025 at 04:49:57PM +0800, Fenglin Wu via B4 Relay wrote:
> From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> 
> Add variant definitions for SM8550 and X1E80100 platforms. Add a compat
> for SM8550 and update match data for X1E80100 specifically so that they
> could be handled differently in supporting charge control functionality.

Why?

> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on Thinkpad T14S OLED
> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> ---
>  drivers/power/supply/qcom_battmgr.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
> index 008e241e3eac3574a78459a2256e006e48c9f508..174d3f83ac2b070bb90c21a498686e91cc629ebe 100644
> --- a/drivers/power/supply/qcom_battmgr.c
> +++ b/drivers/power/supply/qcom_battmgr.c
> @@ -19,8 +19,10 @@
>  #define BATTMGR_STRING_LEN	128
>  
>  enum qcom_battmgr_variant {
> -	QCOM_BATTMGR_SM8350,
>  	QCOM_BATTMGR_SC8280XP,
> +	QCOM_BATTMGR_SM8350,
> +	QCOM_BATTMGR_SM8550,
> +	QCOM_BATTMGR_X1E80100,
>  };
>  
>  #define BATTMGR_BAT_STATUS		0x1
> @@ -1333,7 +1335,8 @@ static void qcom_battmgr_pdr_notify(void *priv, int state)
>  static const struct of_device_id qcom_battmgr_of_variants[] = {
>  	{ .compatible = "qcom,sc8180x-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
>  	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
> -	{ .compatible = "qcom,x1e80100-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
> +	{ .compatible = "qcom,sm8550-pmic-glink", .data = (void *)QCOM_BATTMGR_SM8550 },
> +	{ .compatible = "qcom,x1e80100-pmic-glink", .data = (void *)QCOM_BATTMGR_X1E80100 },
>  	/* Unmatched devices falls back to QCOM_BATTMGR_SM8350 */
>  	{}
>  };
> 
> -- 
> 2.34.1
> 
> 

-- 
With best wishes
Dmitry

