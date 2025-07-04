Return-Path: <linux-pm+bounces-30172-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8806BAF9951
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 18:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6040A7BA971
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 16:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6862DEA61;
	Fri,  4 Jul 2025 16:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W1rkR00m"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736412D8362
	for <linux-pm@vger.kernel.org>; Fri,  4 Jul 2025 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751647702; cv=none; b=VSqipCAYHnJ9qQwWCMsBVKf9mhEtZcZAe3P4sC2BF6vthoG7wO8sTzxBPDrPtrTjqNt8itNCHbYHwPUBioYhhbI2aEevvhpAlUNz18YWT9R0OuAtcDz8EiCqEtzAxc3OQaM3P2XGjpqCwwcEQNqrPxNDRzyxjkmeZAKwo5p2Qq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751647702; c=relaxed/simple;
	bh=M+Xmi4lwtsMazAKYGSV8Ut3Pp220PPmHBgKKq2jnaWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brCfSUpYoMrxBFhdZiV020Mtysl4k78YWaYWHe79ja2mXRyRvVlQ8jvRMj19M6hBcz7sVL80AgWeI+XwwJhkT0xZ4wMT8yJinjHZeiTUz3wDthOje3LXY6lGVat0GsND50cjzq3orp819SgfDFMLCpumbrDYTT7yVT6YOk6w5DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W1rkR00m; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 564Diq48028664
	for <linux-pm@vger.kernel.org>; Fri, 4 Jul 2025 16:48:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+ZA3Iaf+JIUQxzbRmYR7aqyq
	GxiwIVe/fI7bAKvTQkI=; b=W1rkR00mj7WYF+MQpjqTnCwX1XLrTbgL7qh3MEoW
	1ciMj7rhD1m/eZDUdTWj2TjihPjMO9v+P/8zaF7LF1lyMYTMQ/hiGyzfhKzitpLX
	Q8mUU/RgE54xxZ6nIq7ysv95av+Q/Fh0mutwqOCv5+Ibzfy4qFOh7abCJwtQAapa
	VzPpe56FFqodaVFVlZ69JP98Yc5P++EH1Iz3JQjzoCGmVeeSmpJf63JUptrD45ar
	yG6tDUXMN8hwbRJuE3OPk2D2TzrGln0gvyftY5Ae7ALJCPz86+Ev7fXyhhTIR4AL
	NFy4niiXWZHM/H1ZACLJmcH+9XkqDQDMYva7dtpU/lBcQQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j7bw4q9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 04 Jul 2025 16:48:20 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7d5077ef51bso137672185a.3
        for <linux-pm@vger.kernel.org>; Fri, 04 Jul 2025 09:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751647699; x=1752252499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZA3Iaf+JIUQxzbRmYR7aqyqGxiwIVe/fI7bAKvTQkI=;
        b=Sv3toudSbU+MKftm/ntsAfjGUoT7CbRCdVQSybmEnUfc75o4+wNeAfgJV6qpVQjO0T
         BdSwY2d/JIvR+zGwU3Syb8VIGATEbu1NkpvSS88Q6bqTbBn98iWY1Dk2dQQJJlJWVzdk
         +fIVFJqYQp2KsH+UFJ9oKKL0ZJUtwZ6suvTkqIOQrJ8bzAiGiXTvMUyVXrswGvEpwsfY
         ZFs8FopnZ3lnHbq1x1IXQUDT9qfefLJc8qbO+rTG/CCmOIHaInwnxN3wxAqnXwcdMriD
         cNNpN4gLKSNK66UNbrgKgw0l4xSm/qJR1Z7Zu1P+sNiTqx63mObU9GKPc+SF+/bOAfbF
         ZcNg==
X-Forwarded-Encrypted: i=1; AJvYcCVacX+s1d7lCrXTMH1BA7xojl+QV4mwJg6KB+CfVPMLCsofZcZfp/Im8sLgY2ZSq/2hwZhRVMsVzw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3oRsLK6uc7HOW4svBY7xC4KzlucXwcbr4+0QYYHeDf6NK81Zx
	e7myo0QgIt4nxAiR1pT8UztdPFrVlCfpkjeTQdqkOWWEzFSieiTmt+U8tG9e2Eoef5Wh7eipYeF
	TcMIfW+bpRF8uJ56pw97L39zCHtRyhmltTcPtvv+Jf4GNUsNO2lRNyvjtdgJvAA==
X-Gm-Gg: ASbGnctS9WE35PjSKOE38dKOIfbnV/1C7eHZj8GolMGc7kDpkK5EUmpZQakeiWlJXHr
	PdfG/hn4pIXUDprc8jDczrtyUN614Mky4hFqY+37hnrCl1Bru/3VzBPXLSOFhQsXM15PEGmtbJJ
	dLO4yUQAcAVrsRV90JI9uMtAQ/Pn55DsRM0Z4Q/5qzaWXtDga1FQd03RymUozZmqLlWa4LkJJlk
	qqNTU1BBlt7QgXkuvoWpoGHpwYr/PMG1OJelaAu0Zw75VaxzyFBCcABnDQqtvVh3hxbo7Trm+Ou
	gINtK43Mcit2ebds75YaIDRRBpRxQOGPteu4aaS0ABjm/Voyjrei1BaLk+Ke3V8p8Xx9KsOQn2S
	kfLm7ri0HHuocJq6EKRBs0XFyCyE61ZhrcQ8=
X-Received: by 2002:a05:620a:2988:b0:7d2:fc7:9572 with SMTP id af79cd13be357-7d5ddcaec7amr434043985a.57.1751647699300;
        Fri, 04 Jul 2025 09:48:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZV9Tkpiv5v0m5nwKUeJs1ptVFEx2pDtiPHeAB7ZT3kzhlOjIW650b3BM5UPnwmVpnu/SrTQ==
X-Received: by 2002:a05:620a:2988:b0:7d2:fc7:9572 with SMTP id af79cd13be357-7d5ddcaec7amr434039385a.57.1751647698851;
        Fri, 04 Jul 2025 09:48:18 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556384c8f24sm292469e87.238.2025.07.04.09.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 09:48:16 -0700 (PDT)
Date: Fri, 4 Jul 2025 19:48:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Taniya Das <quic_tdas@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 3/3] arm64: dts: qcom: qcs615: Add CPU scaling clock
 node
Message-ID: <2vd5wge5hig2ilcih3gvvmzphm3ptkqfklg4ctsxd2pfqdd7gx@trzoqq2qk2qk>
References: <20250702-qcs615-mm-cpu-dt-v4-v5-0-df24896cbb26@quicinc.com>
 <20250702-qcs615-mm-cpu-dt-v4-v5-3-df24896cbb26@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702-qcs615-mm-cpu-dt-v4-v5-3-df24896cbb26@quicinc.com>
X-Proofpoint-GUID: FApaIvNjhLojhf3YRjoTqIiPfnr5ubD6
X-Authority-Analysis: v=2.4 cv=RJCzH5i+ c=1 sm=1 tr=0 ts=686805d4 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=2bv_n5k-JhLVcNsY_rQA:9
 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: FApaIvNjhLojhf3YRjoTqIiPfnr5ubD6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEyNyBTYWx0ZWRfX8GJ40Kv1XjOS
 ClYv1yKrL+3Duy5+K1vRwg/D/juen+0qFZ2YEsPhpIYMN/gqPGnKx6z3dHBmppbfYzzHebf1/7V
 o4xBobWL1Iq8cvVeuZjvl2t9s25/SIb97uUmfz61f2jjSMop1hMvhXYFyq+8dYVrceMNuWAMZEk
 LwlYXyqsoL3eowdEPkfsZ7q0RIHVtPY/5QD74fFt6EN87JKbILCJjL74RpQUqWE3NBYUUpXJq+V
 DwyY2+VbRcE8c5s5s+RgRZRGmINWeREB5HFotBYqAq0OzhS0Llznr7ltpc0A0WxRSAdPBQtwGZQ
 0qWSImCPazO2djuVMFn5uUkxlURdVRZDkHMIN9Zbnm4NTlrsFfhSh0bz24pYfiL+GCOxtdhVZso
 gsjLNzJmyyjUK43Gy7p80Qv43m9dBdW99asrE7JKV0MGVuDaRDK4MngsEWmchaFwcwLNJ2p2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_06,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=898 adultscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507040127

On Wed, Jul 02, 2025 at 02:43:11PM +0530, Taniya Das wrote:
> Add cpufreq-hw node to support CPU frequency scaling.
> 
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615.dtsi | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

