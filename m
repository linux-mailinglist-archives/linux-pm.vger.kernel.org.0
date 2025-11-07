Return-Path: <linux-pm+bounces-37618-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 68888C404DC
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 15:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 24C664F1173
	for <lists+linux-pm@lfdr.de>; Fri,  7 Nov 2025 14:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FB32550CA;
	Fri,  7 Nov 2025 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D3EH6cRX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Cfempim0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAD52222CB
	for <linux-pm@vger.kernel.org>; Fri,  7 Nov 2025 14:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525397; cv=none; b=AmqyWHskRf4Y+rGMR9BZ9uN7Z2z0kbMzZPTuTEeG2ilaY+ics/+9/7ilU1MV4I6k/vPPT4IsEP1ith3L2XCHWpysoUBoottGCiIWrp0zRVq84v7zfyfJ+zgCzKx+wVfOJngemcKSMGQzqd0BWEHvgwFAJohZL0eDHrPugsxNT5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525397; c=relaxed/simple;
	bh=4WF2qF+JmlZqW3TfWhi4guCSTWxjHU+MiXWc2g0vVfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnh4VxSBX2W9yomqNwcGqXhgorTwlj8pvCbUknmSesuY6SqlBV7BOT6yEpFf5deIrsCgf6oWMYL2pI2xo8DX7FzQPQzX6qLvdWUL1oKzpcPQU9qo6Zgx3S6OqD3cvEUGnakY1EKPgDUoR3QaFWad/qd6IatT5ZPWTbDKFBJVfMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D3EH6cRX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Cfempim0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A76jeBF629531
	for <linux-pm@vger.kernel.org>; Fri, 7 Nov 2025 14:23:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+a2S++AQUY0fS2KV6X2nQwoI
	E5xNiyzvEu1cwp1iZQ4=; b=D3EH6cRXHXlqi0AUa8ErSK/1mhyPS4IsS0+Tsl0e
	AbK/mcejq0gjANtVa4azJivGnL2Q6QXA0LKdmVrCcTHEUsZZj9DhP2DJ6CjF7UQ0
	ggTA/C1rlzOT+9M8Pa2aJF/tTaY3rMqzqrbaXWNXNffmJZcdi/nbXAd45omgtYwJ
	uv3MM6iBu5guuFBv2pXBhTNlOVL4/v8kH++WkUj6/E4yhEitVolHsiuwVWcRyXO7
	GVfkDkLpnBa0MosX1l5y5Lergwe/TQqWUDaAuq1aNkmZ0TmyHsr7V2FiODeyP4BU
	SXfH15gbaOb5W9uXsL1bFgonRW5+jez1Rf7aH8eocyMmaQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a92232v0e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 07 Nov 2025 14:23:13 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8910b0fb780so133963585a.3
        for <linux-pm@vger.kernel.org>; Fri, 07 Nov 2025 06:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762525393; x=1763130193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+a2S++AQUY0fS2KV6X2nQwoIE5xNiyzvEu1cwp1iZQ4=;
        b=Cfempim06B2R4exb9WNSitqZQMMQhqnV4geXcMNhEVt6NBvo1XxXLzOpGWxGDoIg42
         QShlVxeHafusTYc2YB0MJFfP+CX6Z4y9t+iIR/n+utX9EOntqDaeja8GtHYwhTzTf42m
         N016EXMM2tIcDkW0uzaVV4RsM7NnLK3Y5pnIN1+jwGeWZq5Cfz7bohw08rOUqlGgF7Kr
         mQ90zLymz7qDWsCRwhaF2amczbEapfC5CO7g6cY/9Euzwr0vrSwGb0OCSbsa7sG6HJR3
         CfvTJJqyZ9+GQreWQ0Cqpx9X2dA/JP+/Vf4Fab6ds5BFcbYndeS63Vj4UQSum9vCxWZF
         j9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762525393; x=1763130193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+a2S++AQUY0fS2KV6X2nQwoIE5xNiyzvEu1cwp1iZQ4=;
        b=rfOeXeZFiVgcVbcxr3v+CtghX92FGSmtOoso0jfNum+t3fSbZwnK8kpn3OdpkDsBx9
         85wcU3vGnO8k5oRCQGU7rEpYySJzjSl+YL5Iak0MopphrB8BIVplqpFDMuablnIjCpS0
         Hoef/oOFDNU3bIMKHGxKxvqBXsHKUAXmtLeRgLC2cJlx/tGp2kR0QyOwBLlyPs62pumD
         0MyRRjkXAIZ2vLVqik9emle5nkwp/YxH4P5pZkXxom4M/UhaHkMbR6lvsq4fxkh7Xh6m
         w/MxCdtyOlJJCPIUsIKV2cGgQCo8mxmy0qz3J0EiBjl0KKZ+CHUnCjibDL4u/jUWs2Y+
         Ne/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX/IIB+l78aQC0HXiS8IOSY5Q3b53w3YGz/CbmdHCByBF/r3DHlR/1vFJjIO8XLucgLcgwRw1T9wg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUnMNBgMhDP3Z7qlrL8twrNI90YC2Li1nFh7lM0mYsKDUs1hLa
	0rLGczc16ODCMMCwnMtTGq/+rte+zd4MhdJdeTnycMscQSKMCkzquuhVWFPgtixypXDR2T+ofMW
	yVfunXsDHhBfPpYhoVFClZ4fnj1QUzw6jcW2vovJV3lKulNc7UCZoEvimPZsVzQ==
X-Gm-Gg: ASbGncufzHTGPuUspr2DrR22eDDL/pZFYYDZcCymiO5aFvbtfeyBXUArdvwysJ6/szD
	YFcm/G32dIZ+TtEO6thmJA8vNd6VCDYIJ2MkfHAafBRxqXV3I2kRGt8rVuZhM7/viq3dvybXpXE
	EFq3Zem1jjR4wLczTK872aXF2foQMKZkZLoRXkmrjuRDNGOuryHEphhX7oqa01kCPqVfvB+lteJ
	cBr0pxUGb4SWcDdhBRkItqycfFPElJYxhzIct7kFvIh0LW49RTZLnR7ZgnAT8GO9vF8tC06Fz52
	HcpKInXff/Ehjefbu5lTSfFchhVn4q+rcDrjf8912dhyl0LcJtRSPd7DEL055DHGqRE5sBK8Ac4
	pYNjYrmDsPxaf4WdGNi/hKeO2Ss5WAxj344iWV6Ji0eGu013IqpSLN+PTo1E4TJX7Cz8l90s4cJ
	D4Sv8r1vS70umB
X-Received: by 2002:a05:622a:148c:b0:4ec:f477:60e9 with SMTP id d75a77b69052e-4ed94aadfc9mr39449511cf.76.1762525393101;
        Fri, 07 Nov 2025 06:23:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+3yaL/5/mqUrpztFbYMzYBN6uO1ENGma7JKY17KMFkOU2Ru1L93K1rV93BVrdOZy//IT/hg==
X-Received: by 2002:a05:622a:148c:b0:4ec:f477:60e9 with SMTP id d75a77b69052e-4ed94aadfc9mr39448991cf.76.1762525392601;
        Fri, 07 Nov 2025 06:23:12 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a014348sm1514752e87.7.2025.11.07.06.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:23:11 -0800 (PST)
Date: Fri, 7 Nov 2025 16:23:09 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
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
Message-ID: <rxhmiudlnrn2pexqtwuuv2jrenrl2ezepknvrc3o34gaap247u@2tsfw6g33rmr>
References: <20251106-b4-of-match-matchine-data-v1-0-d780ea1780c2@linaro.org>
 <20251106-b4-of-match-matchine-data-v1-11-d780ea1780c2@linaro.org>
 <odmsib3dsxzzggq4gcx7gmh6vq3crlv25fz4z2l2ntezvx6gbi@uelqojwjjait>
 <a8952b46-94b6-4fe5-a5be-d69aa41d44cd@kernel.org>
 <a06ed143-c497-4141-8b4d-98fcb322e130@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a06ed143-c497-4141-8b4d-98fcb322e130@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDExOCBTYWx0ZWRfX/IcZeEyRKUzi
 /6lsB0a7KdS6IcKwOCe0Id3KMcjetzOL0XQ38IXkam8at2G/2tfeOSTA9e3F1id/IYEDg2CGwoC
 NOLTXnphSoY4ppIK1/z91mozsuXZjCjzja1gLlXtE1TSB9ZroQsuThwgCNz17tk9/RnFJN83rhl
 ZTIeMs9tlSXMPZXn34xnDyG4QvzrBEfFvryMpDQW+wNF1oYWh4N759c3G7eHknTCop9ExyhekL3
 Mx+PxlU1XzXKmQXws+tn/2QlqRt8FQn9i4qMj7Wbn65SQqSPUd5O3+Tzk8o73vJ/FBN7x6EV0cO
 KWOpT6bGsGaPTSvch5YGuqgvaGKx09UOqNSYK2B2qBILETgCjfeVAI+QY1aRby+om42hCdAZQC4
 QlkwhWvguxbU7vOozbyPrSamTVA6kA==
X-Authority-Analysis: v=2.4 cv=Csmys34D c=1 sm=1 tr=0 ts=690e00d2 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=Pc_8zquyR68SUQC9iicA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: AZ4iHYeaePPGX_UDbec_YYJoeIm3qbzR
X-Proofpoint-ORIG-GUID: AZ4iHYeaePPGX_UDbec_YYJoeIm3qbzR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070118

On Fri, Nov 07, 2025 at 08:08:28AM +0100, Krzysztof Kozlowski wrote:
> On 07/11/2025 08:02, Krzysztof Kozlowski wrote:
> > On 07/11/2025 04:19, Dmitry Baryshkov wrote:
> >> On Thu, Nov 06, 2025 at 08:07:18PM +0100, Krzysztof Kozlowski wrote:
> >>> Replace open-coded getting root OF node, matching against it and getting
> >>> the match data with new of_machine_get_match_data() helper.
> >>>
> >>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>>
> >>> ---
> >>>
> >>> Depends on the first OF patch.
> >>> ---
> >>>  drivers/soc/qcom/qcom_pd_mapper.c | 17 ++---------------
> >>>  1 file changed, 2 insertions(+), 15 deletions(-)
> >>>
> >>> diff --git a/drivers/soc/qcom/qcom_pd_mapper.c b/drivers/soc/qcom/qcom_pd_mapper.c
> >>> index 1bcbe69688d2..07198d44b559 100644
> >>> --- a/drivers/soc/qcom/qcom_pd_mapper.c
> >>> +++ b/drivers/soc/qcom/qcom_pd_mapper.c
> >>> @@ -613,25 +613,12 @@ static void qcom_pdm_stop(struct qcom_pdm_data *data)
> >>>  static struct qcom_pdm_data *qcom_pdm_start(void)
> >>>  {
> >>>  	const struct qcom_pdm_domain_data * const *domains;
> >>> -	const struct of_device_id *match;
> >>>  	struct qcom_pdm_data *data;
> >>> -	struct device_node *root;
> >>>  	int ret, i;
> >>>  
> >>> -	root = of_find_node_by_path("/");
> >>> -	if (!root)
> >>> -		return ERR_PTR(-ENODEV);
> >>> -
> >>> -	match = of_match_node(qcom_pdm_domains, root);
> >>> -	of_node_put(root);
> >>> -	if (!match) {
> >>> -		pr_notice("PDM: no support for the platform, userspace daemon might be required.\n");
> >>> -		return ERR_PTR(-ENODEV);
> >>> -	}
> >>> -
> >>> -	domains = match->data;
> >>> +	domains = of_machine_get_match_data(qcom_pdm_domains);
> >>>  	if (!domains) {
> >>> -		pr_debug("PDM: no domains\n");
> >>> +		pr_notice("PDM: no support for the platform or no domains, userspace daemon might be required.\n");
> >>>  		return ERR_PTR(-ENODEV);
> >>>  	}
> >>
> >> Here you are mixing two cases:
> >> - There is not match in the table (in which case the driver should print
> >>   a notice)
> >>
> >> - There is a match in the table, but the data is NULL (the platform
> >>   doesn't have PDM domains). In this case there should be no notice.
> > 
> > 
> > Why? Existing code printed notice in both cases. Why refactoring which
> > tries to keep code functionally equivalent should change it?
> 
> Ah, you mean there was a debug before. Well, then I am a bit confused
> because table has entries without data (so expected condition) but old
> code returned ERRNO in such case - so unexpected condition.
> 
> Wail failing the probe on expected condition?
> 
> Unless it is not really expected and notice in second case is valid as well.

If we know that there are no domains on the platform, then the notice
definitely doesn't apply. Failing the probe is a separate topic. The
rest of the code expects that _qcom_pdm_data is not NULL.

> 
> 
> Best regards,
> Krzysztof

-- 
With best wishes
Dmitry

