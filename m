Return-Path: <linux-pm+bounces-37582-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1E7C3E54C
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 04:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDA77188BD8A
	for <lists+linux-pm@lfdr.de>; Fri,  7 Nov 2025 03:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4F62E1C7B;
	Fri,  7 Nov 2025 03:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jBHaAfNA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZNjE/cKF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D969D276046
	for <linux-pm@vger.kernel.org>; Fri,  7 Nov 2025 03:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762485580; cv=none; b=LgcOg2H3y62k6OD1+TDNqqWXqD+2YPEMh5tfSDnUxxQtvpwYUyOYBzx7YzTHip2E3L421E/y2FuAYGx5Z/kNXHYmtNQCwV8pZmyOMlH9N7pwiqXH+X2KhntYB5rxqehnq94G8KXDK5Rp80v2d8ZsX7bVqcO1hXyVLjx8Dix+3IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762485580; c=relaxed/simple;
	bh=fJDNuwwAh57qHVcxO80jNFIvDtORwu03rxT7N4ZqhUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sW9uKcw5EMkVuXfOjnPtpgEdvIwV6Zz0QW/WTzkwIM8LjWNYqW7Dqdku3P01tX+Zo54aTELJfVMTCF9VInEgJLzcoWLI2i/k6AER6ab/If976wS8SSR7/Sn30huw/HBqlBrgsjqE4QngOZV7gU6aRQUnktXjIpq2nLuOZ66i3eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jBHaAfNA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZNjE/cKF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A6HWSkL567792
	for <linux-pm@vger.kernel.org>; Fri, 7 Nov 2025 03:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=BrpjAWiwCyBIR4NqBN1fG3lV
	zpUvOEKnEsnydrbcid8=; b=jBHaAfNABCQzblEMPABGZ6Ayu8XrzJog5gBepCx+
	d6vBKxEi9ASrvsstFwGiM5jziNcsyNixWVSXOvvfTqT2ssIzJ1xMbg4B4uJU1J2l
	3rJlsUgyLpK7kqRPTn5mg3/au8PUDOZukxF49NQd8vt4crfiltFLpyghFZ5m+n+V
	bqAjxvVeLlzX3R9hah2xXNkbxy6+D9AMOOKf7J54dQABmhEYA9XOeTuCmzzh2Dx3
	d+iCR96epD5azDtJaj04sY+ClRIH5GN07VxSJ4AKVJYx2+7UOEX9y2nhXHxjyra9
	IkhtI9n40Lm6Gicu8VxJXaAdE2+gprK5qZZp+m/mZ/DFvQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a905qhg45-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 07 Nov 2025 03:19:38 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e88947a773so13107531cf.2
        for <linux-pm@vger.kernel.org>; Thu, 06 Nov 2025 19:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762485577; x=1763090377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BrpjAWiwCyBIR4NqBN1fG3lVzpUvOEKnEsnydrbcid8=;
        b=ZNjE/cKFT/tY9GF+mNcDe1QDhPGFj106d3oVjEk/FGhGtQAchV6spvjWupULmlwfVm
         g0TesyFY7WBtchE3aP6Pz62mBsN/E2V2rnEUtAoP2yv8hi7AQYH8KppJAAkGJ84fbH6x
         FiXq/uc84TDaiHc12IQOwpgk9ooK4d2xMzoMF8VPXGJnm6zhmrJeLfvTz4ZYRQBPB3dB
         NCUeb6loNEAsx8EwPq3ZAQIny+eMQ0L2kuXRk+i4f41ThqldIWdqhezc27tMGvjOWe7Y
         unmrR51xqfOV4kc3xkwB6xV7f//QlFWaSFicamPGhj+nbG5hnJwakRCLJgWX8GJJOZ4a
         OF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762485577; x=1763090377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BrpjAWiwCyBIR4NqBN1fG3lVzpUvOEKnEsnydrbcid8=;
        b=wMJks6OvAQm0RhmQ8SeeBCJjDNIcH8cae6ACoC5CvfzUywvI1oQvrw9bmw+lYr/mTE
         LoKXJ21La+lVHQbLeu/tscrq9lblryabU6Nusk/iEegfzyY2K0ARXICYP0pXGnJdyy95
         ol9t1R30w+3I8n8bpIcoKynf9a2eTUTVl9zlNL4d9GK1AG/aMoPMOijNgxKea0tI/7Zg
         qxnjH1FB+yxwhYsVWNvg/5fUSGr8hQ3OMs1riv5s1tbZjPgB43u/rAh7S2mrhLnG890n
         LrdpzLCfKGhL6YV/Ty6XudY7O9kZje/H1hIMXHAnJ3I2tRJDB9HTuesdh5CeC9s7l4Un
         aE8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYThyVbrK/ZBvRnXMHaWCgoWdPN5JFCQnDnCjHq1t10w2TJMn1MP7dkW2MV3gq0A1nWuxrZJLrgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPKZG90w/lZyVQIy6l91bsXPajTz7Gsc3evrSR1BVPnPHCFPrG
	Fh6Xr0tVeX0X55z8uJmR0Qw5t0h0hQkbW3yJciMJpo6hXPlNFRXUZb+nEQBTcGSG7iM15SCnTVH
	nH34YMR6zgF7aJh5KdMtlGdnrXuYzlR7c0jjOlSryZ46rZSgzkyle+sEdNcmhew==
X-Gm-Gg: ASbGncs9RfECiq31aiWl2LrKmT8kcjzcnkbbzAgIajfDAf2Mx2sjA4oyke6g2VFFJBX
	SXE3Jb+ROomtI6I0kKBCjMsjYo0kTEoB7X5AnNfuhTmgExNp54rpapkERbxj3s2MVk25v0m40AB
	l8Vg36d43BsdDYj5ByO/Lvy2Dmio9j8hsVYmiSFa9Y7ViDOqKZjkK/rvdUCqEVjnFrTO8gpGX6a
	HQVcYKjozqHsI7dDnmxvjksdgnY4O3lMRx53IpBJxZ1ncTZdG1KGvdxnC3C75WWF9x9sWzLKCPm
	2fBYCD/C44jwEXTlM2r9LChlb0G27DkuVaeQQBGaNU1s3C3h+f/V2XGQjmwpstYQLIddgeZ6pPH
	eyAwUVueG3ZO0O9SYRPfhluVvuevzEcTthFPcSDn5sxEdtHwWVh/TaYZDyVXqjGLDAbUiuffZyC
	Cnm73LE2PsmXMd
X-Received: by 2002:a05:622a:11c7:b0:4ed:6746:5c3d with SMTP id d75a77b69052e-4ed949432cemr23756991cf.16.1762485576971;
        Thu, 06 Nov 2025 19:19:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/3FjNRKucfvNXkDZbeGXLag2dCvNMAIUYAMoAD/S9Y8MWbIoOna+co2re+tgJ+a1VvKEhZA==
X-Received: by 2002:a05:622a:11c7:b0:4ed:6746:5c3d with SMTP id d75a77b69052e-4ed949432cemr23756521cf.16.1762485576496;
        Thu, 06 Nov 2025 19:19:36 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a019f09sm1147166e87.31.2025.11.06.19.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 19:19:35 -0800 (PST)
Date: Fri, 7 Nov 2025 05:19:33 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hansg@kernel.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 11/13] soc: qcom: Simplify with
 of_machine_get_match_data()
Message-ID: <odmsib3dsxzzggq4gcx7gmh6vq3crlv25fz4z2l2ntezvx6gbi@uelqojwjjait>
References: <20251106-b4-of-match-matchine-data-v1-0-d780ea1780c2@linaro.org>
 <20251106-b4-of-match-matchine-data-v1-11-d780ea1780c2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106-b4-of-match-matchine-data-v1-11-d780ea1780c2@linaro.org>
X-Proofpoint-ORIG-GUID: U98hWzVhZm6yXVh11jTP5xYCPOrTb2LQ
X-Proofpoint-GUID: U98hWzVhZm6yXVh11jTP5xYCPOrTb2LQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDAyNCBTYWx0ZWRfXzc0Agi5BATZ7
 vGs5Pr0lI5ZGLyRK/jHEsLon7JtnSCxUn9qHPevNtGSV0sWeO6p/nIM3pQ98XchKKezMUtMToph
 Ieh7FNjqyTeqeSHTIdzy7TmaRorF1dcJw1HUe1e2clcDzl0EdQMT2/4wXWbLiF+WoF0yVUjbvg8
 +2k3alMWt83TQ0Vs+UhCJze4tmpT+F3sgJuyChAcy/ugXk4m8X3GYxXfd/kTl6DEMzh+tWJjP0e
 i4XhVUT79fbAwsFBobu5L8xGWpcS1A2z+bAylHPzGv/6kOTmN3zw7/Hf7L5utIwWnkWBYZleprt
 f8fheZJFNZwKUWHZ6wJ0jpxYDLgZQq/3q9AJXyVllBbctZy+X8qn5bkbXTdZfji8jq34jAdw586
 VwVpjpClj6KmVOUrmpwG12xwzSTh3w==
X-Authority-Analysis: v=2.4 cv=D6lK6/Rj c=1 sm=1 tr=0 ts=690d654a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=e-unOtBAnIuy2i46bukA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_05,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511070024

On Thu, Nov 06, 2025 at 08:07:18PM +0100, Krzysztof Kozlowski wrote:
> Replace open-coded getting root OF node, matching against it and getting
> the match data with new of_machine_get_match_data() helper.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Depends on the first OF patch.
> ---
>  drivers/soc/qcom/qcom_pd_mapper.c | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/soc/qcom/qcom_pd_mapper.c b/drivers/soc/qcom/qcom_pd_mapper.c
> index 1bcbe69688d2..07198d44b559 100644
> --- a/drivers/soc/qcom/qcom_pd_mapper.c
> +++ b/drivers/soc/qcom/qcom_pd_mapper.c
> @@ -613,25 +613,12 @@ static void qcom_pdm_stop(struct qcom_pdm_data *data)
>  static struct qcom_pdm_data *qcom_pdm_start(void)
>  {
>  	const struct qcom_pdm_domain_data * const *domains;
> -	const struct of_device_id *match;
>  	struct qcom_pdm_data *data;
> -	struct device_node *root;
>  	int ret, i;
>  
> -	root = of_find_node_by_path("/");
> -	if (!root)
> -		return ERR_PTR(-ENODEV);
> -
> -	match = of_match_node(qcom_pdm_domains, root);
> -	of_node_put(root);
> -	if (!match) {
> -		pr_notice("PDM: no support for the platform, userspace daemon might be required.\n");
> -		return ERR_PTR(-ENODEV);
> -	}
> -
> -	domains = match->data;
> +	domains = of_machine_get_match_data(qcom_pdm_domains);
>  	if (!domains) {
> -		pr_debug("PDM: no domains\n");
> +		pr_notice("PDM: no support for the platform or no domains, userspace daemon might be required.\n");
>  		return ERR_PTR(-ENODEV);
>  	}

Here you are mixing two cases:
- There is not match in the table (in which case the driver should print
  a notice)

- There is a match in the table, but the data is NULL (the platform
  doesn't have PDM domains). In this case there should be no notice.

-- 
With best wishes
Dmitry

