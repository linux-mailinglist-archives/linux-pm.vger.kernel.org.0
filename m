Return-Path: <linux-pm+bounces-33640-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F254B40031
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 14:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C19CA5E190E
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 12:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93B42FD1DA;
	Tue,  2 Sep 2025 12:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eeyr4qBs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1712FD1C2
	for <linux-pm@vger.kernel.org>; Tue,  2 Sep 2025 12:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756815111; cv=none; b=THkQ8tTYMuvv0XkzktBozbQBQIUdm+lTnddgnqhTzgqwiOUf1MjpSy8UoZlXhlbcc141+ZNrsZjkM90qf9FrmanF256egOiY5WWNlGOToR2BA5RhPMZYYoqP+WQV3dOE9Rwai0+PTWp9tqHFtuMAOEVNFg3hvPVPRQxac8tH9hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756815111; c=relaxed/simple;
	bh=VKPh/ct5Q5m08hxDCp/EDthmOiS6ucPULO1VHGN1G3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CSHtE87kpH1zF2bug/SlTLpOXPBS4Q4IQbb2qpskiyhrVXxgJ5cpgecYpWtFHSsux8ufCuQ846i/cmk/Quf1Nsw7Q+C1q+5tThUjOQDpAYdMkQGvmr9ZiO9n6ojowgswk+VEOY5wg+xqJ8wy0+h3uX7yOC4ePtF1fkLoHiqQHrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eeyr4qBs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582AGihk021595
	for <linux-pm@vger.kernel.org>; Tue, 2 Sep 2025 12:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R9+3e9dP2WaVs0y05qgMULMfCunUKyox0pXutflnw2s=; b=eeyr4qBskZ6+frZT
	07ReQadFBKOtqTEhsmyQ9kul7fEYeJO+8J+mQQrnwuO9rQRVpNFrYaAe64uu/GEo
	6/5vGMmjfknMejSA6PujLNvCS6EFRzRGKZqestEKJJa/sn9048M+hHwnRTOFHwAy
	E6Er00oehkoLqYqQ7+xhusvQpk9CZjTw2AxrXLBpj7XC57NlJtCG3EUpc+wzZGWl
	UvM1H/10mMCF6qEEBcDTql2UJQtV8v4MUJ0si0QCTMQcphEJy8Egtbsj8tmbJyh0
	ZGoavm0dRVgWfvUM70fAqplEaWxM/mMs1p5punMdgb1qB9AIRCyAf0tLumVPfaFP
	sw1wtQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8rysq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 02 Sep 2025 12:11:49 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b2967fd196so16301211cf.3
        for <linux-pm@vger.kernel.org>; Tue, 02 Sep 2025 05:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756815108; x=1757419908;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R9+3e9dP2WaVs0y05qgMULMfCunUKyox0pXutflnw2s=;
        b=Gucy91+y9NJz6WJjW8lh1UnCZsGiYFeB3dXRHTnlbub3KGQ0bc0qDknA9BkXCDD77+
         8KmSlHlzUQi0lSivWJWdBU5G/8N/+iQnjGk0olO4uXGKWr57DeklLbPifu0PpA/hZQqs
         0mDd/k7atXNO7Qk0bncFFPiB0I7vs8NyiPqQNvT+fZMgVbGp4Xec+bAg/jy4ZLoEZdLq
         ctAyEqhCZu5JMSuXIhaBVoxdnZYki8vRHHpfPJroB1KdCkiyUAaKQISgdCjOZNiU3K90
         SavFBH9G7IDu/i2AJCSP29Qi4Whm9nHhNSPfbJkjS9yZVJQCdEG9old45Am65771NTuf
         jhnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuM/OvZiPOQbtbdVBksQIGU3UtsPmzQZoSlI/3jwDZn0X5pr5ZngidOh76GlRMOy6bLWidFF8egA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdOmDmhtpLv5ek8Ty3N7uEAFIgRA20PosuyBzOxaYSwNv8n3Dt
	nSaULjM5m+i+5Kwyf00OVMmmoTO7zxiDZQia3xmr7IygDTu6ZpBp/S2aLHNuBio3WucPEch1r33
	SsA5Dj09W+mYZY6j6HGWlq9fq031jDcsH4JCrroec6yf5BFqFdL59bKJdDVDU5A==
X-Gm-Gg: ASbGncva+5afxOrzRDqAMzddws4urk6X+7hCiY2paCNkpmOM61uBAEuSLGXFw5pPW+Z
	5TdGNuvXENxvHMoXrF6a+w9xariIu51rv46wjK/yBzHV2Tr40yYQglys3K8j32UElxnhk9UnfLL
	NS7DnJ5IaRV9CXWtNVVYwrKQOfQrAzSTd5qJ0IijE+zjGl6j84pxtrbo76t9hcPa+5IOUw+c9Rs
	FobTS9GtY/+gpKi1ozSdTAijD6ftnTL9gn9Gpihdvg5nPrlAYiJB9om/eo+wyCjcdSoD6pqzgSq
	IvJ7LAqYFICjrwnKkUbdPdp31jBljqA3dApGKghwoZF/7DWn18XpN3dTK/IZ2a4cgvNgMWNa92D
	JJFAabgWileT5zWW2F7GqsA==
X-Received: by 2002:ac8:5710:0:b0:4ab:723e:fba7 with SMTP id d75a77b69052e-4b313ea00camr114049051cf.7.1756815108097;
        Tue, 02 Sep 2025 05:11:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwW4G4jjkaUKtXkdS+GHMSUK5ZRdAh64PysqQIkVPG7KSVbGILFSKErYbYiYkdMuTYCelzhw==
X-Received: by 2002:ac8:5710:0:b0:4ab:723e:fba7 with SMTP id d75a77b69052e-4b313ea00camr114042341cf.7.1756815097447;
        Tue, 02 Sep 2025 05:11:37 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-affc2fac683sm873825266b.83.2025.09.02.05.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 05:11:36 -0700 (PDT)
Message-ID: <84c48543-815c-44fe-9334-ec1f688e9639@oss.qualcomm.com>
Date: Tue, 2 Sep 2025 14:11:32 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/10] clk: qcom: gcc-ipq5424: Add gpll0_out_aux clock
To: Luo Jie <quic_luoj@quicinc.com>, Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Devi Priya <quic_devipriy@quicinc.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com,
        quic_leiwei@quicinc.com, quic_pavir@quicinc.com,
        quic_suruchia@quicinc.com
References: <20250828-qcom_ipq5424_nsscc-v4-0-cb913b205bcb@quicinc.com>
 <20250828-qcom_ipq5424_nsscc-v4-5-cb913b205bcb@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250828-qcom_ipq5424_nsscc-v4-5-cb913b205bcb@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX1Lr/nj9tiejD
 HwXlE9N7x+TH87wkSdU74KsFTaHjsAR2sNgYMQLV5VcDWboednO1WgluwUwY3r4vOLOrb3f4gLY
 Dtik1CViSlsXP4tac6PFj34NFWo4ENSDAhxFwgYMk79WaIE68drmNpQ5B5MJR/nwTJshjpLXwHN
 NwCwT0+tf0Qjj6C45XQc+SAUUoWk1pWxgqUT2VtuFFi9cimbLFScErl79d6GbSwZkgrNR+DXXn/
 T3ghlPKLHNhCqhyZb4f+9J8exsL5ndURjCGvrZ3ROxuA2xp7k85dBn/phDquTauw8stBZef3w8A
 7FkEqAiP3hZhFLIzRUFv3MKzqvNoDi7y57nQ2mQk2KXNLBxZPzyxAFocwfi2EU2WVtyZVvM5X/o
 Bsx1vLHj
X-Proofpoint-GUID: BOdkjwVSj79yfNIVVV3fmvo2xOnsKNAD
X-Proofpoint-ORIG-GUID: BOdkjwVSj79yfNIVVV3fmvo2xOnsKNAD
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b6df05 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=xy1T5CxqftMPibTtt60A:9 a=QEXdDO2ut3YA:10 a=jh1YyD438LUA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

On 8/28/25 12:32 PM, Luo Jie wrote:
> The clock gpll0_out_aux acts as the parent clock for some of the NSS
> (Network Subsystem) clocks.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

