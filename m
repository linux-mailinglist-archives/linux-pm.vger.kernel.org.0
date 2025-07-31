Return-Path: <linux-pm+bounces-31708-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 057F8B17732
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 22:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A331C2775B
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 20:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7190264A83;
	Thu, 31 Jul 2025 20:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fZL82j+C"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D57262FF1
	for <linux-pm@vger.kernel.org>; Thu, 31 Jul 2025 20:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753993898; cv=none; b=knCeue6P2PL2TwdyG22pwxmwgcTiArmuOcVKJ8l8EanSPyG7rIX5EHStZkm3t8igZhR2pXfZGaSYecc0bB1t3znAaJuESP5+wTCMgh229Gr2gLeuM7opOfa+JQ2p/4vpMjLc5/7xaSpaiFTfbwRFGvsNQV7D3yGkoatKnZJPhFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753993898; c=relaxed/simple;
	bh=xTvLJuW/ApOSDzwWfLExf2bQhoNe2yXXWNBZO3mi21g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=furzHUQIkiEYBWy9oeR/5QQWFbgonYHTCvzlRuz3qMiO/sc5CWQtrxiHriKRN4C3NJqMi8DOYyrJwhc8lJhOfrMhrY1mys4GiYB6ukQLDz253c0wQdeUrpAH+rOKNwclg3/M0oqm7zGHjFCAIGtNKRhpG9K2Zpa9BjrbPJpSAuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fZL82j+C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VDf67Z031981
	for <linux-pm@vger.kernel.org>; Thu, 31 Jul 2025 20:31:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QoS+iD8VaUIgyzaqV2nW/wnh
	QVOn+KPVj5CIZuJUF/A=; b=fZL82j+Ci6kud5KtKv4vtcFoXel+2g4Crv6XPIQQ
	N/jcSiuABaqZxlEt4ogI3mtZKAo0tflGcZW6nb8S0IUHClc6hBafk7MBzpYl7IZ/
	McjEmYuaQ8xG7QcEwii7+KBVPtWPidFn+n0CpufnoAOBhTjOjEisdPmxe/o4FTjT
	RQUyLX4voRfXUmK1CBAha9vUH4alBgnMxML8cm8JS0OJSbJfgew9kRTMb3mQm/kb
	MFRqRrAf9+SFX+1hHUsL9fEbFU5N+UEd8bdFEeERDI/oqm9SPYBFcEaYZvkB8s4a
	U5OM/43kz92D66QO3m9JidUD53JmQ5WrWC9bn69P29/Bhg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 487jwewna5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 31 Jul 2025 20:31:34 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4aeda8bf2c1so2468861cf.2
        for <linux-pm@vger.kernel.org>; Thu, 31 Jul 2025 13:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753993894; x=1754598694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QoS+iD8VaUIgyzaqV2nW/wnhQVOn+KPVj5CIZuJUF/A=;
        b=AVfjHNLV8B6BxYdbBjrH7MQC8R3soeHaFVt6tGG/XoQJXShrSBwxgEiKKlgMmlZeJb
         Uv0BWK6r9SsLeRlMZA4vO3cSY6W+fuMxWRBBlDBq1x/HLNXrsrSIbryUk7ds9lvIsL2+
         1cYNugPG+x0orNkj1DQlxsCLxkunPiy/O1Aqa2FCuAoDlEHMrd0vzTa1oaYd9ocJc6W0
         B+ILadi+BGlNkYHzKt4HGFRCApGYPZbZp+e/I08lBO8bD3q/5Ai0dlwcxSW/dJcFfwka
         snqR9fQ7YOT1yfHm1M4mszPbfBUbg1XjaNx8QnvHJY2HJWLcTHWFDgHekBbzrIbIWytJ
         wE2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXA9FZm4usWR1ceFA5EEX0pzrHhYo2g5fSkQ6QJs0aiHzXdVM6RGHUlHC5XZFJH60dEbQrHHJKClg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDjENukqxyKJRY1gkz7slmIJhy1Jfaezzx9CzHTFu5PlgK1EmX
	jcavvqy7jSNO1muPY8wAdXsRABFG6o/HxS7enTNKELzZI3CwCg4Utz9vnNt+jQg8+aG25tumXus
	/8dJBjp8PKiVRRNaDaL8WBCuwwtqeyGGi7YX5oilzgSRoY8uvrPJ18Xv9PxVHjg==
X-Gm-Gg: ASbGnct3YwF3nm1z6iew0MOhvFEw6ftGqej+0dQViK8W8OiY8m32S7dK7qnA2xufvcF
	8BwkqnM8+0igLAAIun8i/ZkqlL5UeSiyTPS6cP/lFjWI4ahEmDVeo0/wMKz2zxPcEjdYUTaSvvT
	XMkVRRBgbfCJojUGfjOpVkQyv/oycZcJ6hpeOgWu20dn4z1h0pOXMzHBx0FGUAhalSLIksWxDhn
	/jHyE+x1A2Lmr5MtYlS2CFHhYK5bktkPqKaCMLBD5dSPNYmoaSLHL8Kfx8L5cgIRD6AJUbLMGPm
	zscZXiAi7rXLg9oeERjJ1+XAECiI/Vd9IWM8lYrhRiCYC6Tflubhn/HoUX869i30Xs8OqLiY0bs
	BlK7kZru84/q4Pt1IhBN6tLFGYmmqkk75k0p1SLZt+bhfa+HNl67p
X-Received: by 2002:ac8:5fc4:0:b0:4ab:3b8b:9ef9 with SMTP id d75a77b69052e-4aedbc469cbmr126720271cf.29.1753993893950;
        Thu, 31 Jul 2025 13:31:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjG4KR8sIlrrwmey+SYNZ6lZ4mSTtNpoyvhRvxc6f1Wla9QXCimOwryXTNV23PvNWNId87eg==
X-Received: by 2002:ac8:5fc4:0:b0:4ab:3b8b:9ef9 with SMTP id d75a77b69052e-4aedbc469cbmr126719751cf.29.1753993893446;
        Thu, 31 Jul 2025 13:31:33 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b889a81d2sm348386e87.59.2025.07.31.13.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 13:31:32 -0700 (PDT)
Date: Thu, 31 Jul 2025 23:31:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Vinod Koul <vkoul@kernel.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH RFC 02/24] pmdomain: qcom: rpmhpd: Add MXC to SC8280XP
Message-ID: <vebgxvaxfuohpy2ilwzquupezzg2obaekylk7kaiyroosrelx7@dzd2f6bpgkmi>
References: <20250728-topic-gpucc_power_plumbing-v1-0-09c2480fe3e6@oss.qualcomm.com>
 <20250728-topic-gpucc_power_plumbing-v1-2-09c2480fe3e6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728-topic-gpucc_power_plumbing-v1-2-09c2480fe3e6@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: G7wgW7aUR4GR-CpAnmU8wgqy_wgLkd7n
X-Authority-Analysis: v=2.4 cv=Wv0rMcfv c=1 sm=1 tr=0 ts=688bd2a6 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=KHzq8nhu3g8-aHLh-moA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: G7wgW7aUR4GR-CpAnmU8wgqy_wgLkd7n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDE0NyBTYWx0ZWRfX09rdg3w59kvl
 0GjtEQSXX5pK6hOXMl+delwlxug8r1eitxZPZZ+lsLIH/DBWe33ZuPijVzu2YyaRTAxMf1j1AKa
 /Ql55oPF5ETRJhrJiAhU5WzF1hp3uFlcWLaJDeg6T/cRbKcA2fCbg7DtDFQH8lKPFqROyxwsAiR
 RaM0ATmg7MkQdgCcU//rLRwQ4Qju7IloQ2XQCTeVi3bkbANk4iCnGUHKSkaI8MlyGzzLW+LJueN
 4gnLWoeY8n+17Zm+zND08UxrTS3aEnAf5pu2zb/xNKj9fgrL3XQKjSjxddrxpxSj1U53VRePGO/
 WXe/Ej3Nf+53g1Z5bZ7M7CSubZyE4CeUhdh8WJ8q/+LGJYtSNfcS64lI/D4tAsdICqEQYVQZGDa
 /7H9zeDatGdPrXIvwj1C3WfS1U4zm9/MokQZRgT1hwGJoAYrkBERAQKcdUJmM4dYodgd1lFR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_04,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 mlxscore=0 adultscore=0 impostorscore=0
 phishscore=0 mlxlogscore=975 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507310147

On Mon, Jul 28, 2025 at 06:16:02PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> This was apparently accounted for in dt-bindings, but never made its
> way into the driver.
> 
> Fix it for SC8280XP and its VDD_GFX-less cousin, SA8540P.
> 
> Fixes: f68f1cb3437d ("soc: qcom: rpmhpd: add sc8280xp & sa8540p rpmh power-domains")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  drivers/pmdomain/qcom/rpmhpd.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

