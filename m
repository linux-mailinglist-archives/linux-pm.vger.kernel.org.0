Return-Path: <linux-pm+bounces-40094-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 847DACEBECA
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 13:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3FF43016EE6
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 12:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10FB2E7F03;
	Wed, 31 Dec 2025 12:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RMabYfAV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W7dXQZHv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4778928C849
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 12:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767183398; cv=none; b=o6K2y00AOfoBwyEHZD4b0FnMmG9vBqONeoPmMIYzrKVQCr//haOxsTsclw1R2BOZ7FLQm53ELjoyH1km/1r6LXMxpprrTDXiXFE6ET3JgBv+P7jPsm7oynDb0sI9lurJpPzY1SGEUXMMM3wAUBfbZX0rce+N++9R6Wjx76ET5EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767183398; c=relaxed/simple;
	bh=MR3AmbLZ5anPbDIh6appxGPnZYKMJT7zJ1pCI1xBgTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QrmBUTkYbzSbfIv87vvlXKZLfrFe4stv6eBOcIO46XpF74ATbRMgAvq8qozKUY+8d/faAO2L9Gw4Qe7pDs/qnvnKAg/YuagJvKCd1oQ5sNwiyd6O6QAUya2/kHcNf5moTc+Osf1nitkCeFFMEc5FZdFBhkhC4UqQ1YnoJgQMlzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RMabYfAV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W7dXQZHv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BV12Okb3971194
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 12:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FmHPQhUPWUftI1dUKYWlCg7G20zAEVRZRn28G5U5nz4=; b=RMabYfAVrgVgQTB5
	9jkiNcMhmfzvt1CSh7z1Axyb6mW+0bqqcmtggZmOWYa/utb+nWBPPsiZ7xcHC327
	XbHmlAJ/MnA2N+K2RSc1OLJbAcdzUnqnNtlhsKJmRdQZohVdBVlQLeYG7JsOQetd
	gFmqFGsn0Haa09YG2izW2il4W5EWV16fZ0OQVE05W2INkTTk8zhl5nKDVWEn2TCv
	pDOdCFr9gHNXeoY7OiC0kN/qXK4n99UXuQed2k/0MHBkag76J9zPouNUtPpjgMnH
	N/ckmQpVkhrT+Ny1VlqviW1zz93M7GiMRg9ZadfFmFxABY+Ylh1G5fuETJJg4LlX
	SvZk/w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bcdky2mnp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 12:16:36 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ed83a05863so35873671cf.2
        for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 04:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767183395; x=1767788195; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FmHPQhUPWUftI1dUKYWlCg7G20zAEVRZRn28G5U5nz4=;
        b=W7dXQZHvmYzBFuZF4NQ5uhFsFkvCPaIbPzbRF7J0CDUoMKmRvfbQp0oYnFI5OxXZpw
         i7rePM67lZfoLB00AVtQaBnkqFkDsXhIG5x9OlYxrpS4SF01HixeWTID2PBipPOdf7EJ
         MMivgsoCKKXaX0eHaEDGre+Z/QqeEHf+6ptQsZXqszdKbX8DXS85MMZIqL1JAUUpdR7Y
         u39Ac53l/3Dp2SETqT2dREFNwkaUgLRZ6gMcjRE6OtgXwsuQbmt21QjG4mev2qreuDT/
         lVQMIwpgv3SM+EC68TcJKPMj+LqJZ607miNgeIUGQ1gyb9f5J3yuDipfleWyfYbY39/o
         L2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767183395; x=1767788195;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FmHPQhUPWUftI1dUKYWlCg7G20zAEVRZRn28G5U5nz4=;
        b=LtmjOCBQ6o+7xSJmrg8vj4XUgFCh9ksV8ji6o3XzJw4ecL6q6SYYnnzjn+kNMMseCu
         h+9RSgSotN9PM2OHMM+8QSwByLu4KLCUGK691/2XKBAD7COABhh1oRxL+CiTevAQSjvk
         wlWcisjfKlr9JDM1JLBFv5F6H+RWRHsu5QxE5LH3lrYIdrN7L+YVs3AmDF5Vq4XKpsFT
         XJEPEnxp6Ih5VAEWFzKuuu2gY2cKqPfFM3ssj4Pvv3gjcH5jbZCpqCY5gruTa1EKP7VJ
         e/3TMKPox0AsnAg83z7L7g99fNdRAjETcbcoy/qStcZEOXIcpBieNQqflctLFSIYqOcP
         0X9g==
X-Forwarded-Encrypted: i=1; AJvYcCVeq8IBfPn7xYZguzc9vSIj2xDzE5TrmW/vMuFDiX9uISFs416AlnqKSeSSzVNGAG6EW6yqr6e+og==@vger.kernel.org
X-Gm-Message-State: AOJu0YweUP1NcVFp4l9b+p1p0wYw1dJd6vWxEsyzzS/Tl3jcsXacwpBK
	p370nB5FHQZ+w4W+xfC+wYPsm5jdtbSeA8LK4Ydi701uszCiPxl3aKYwI9HUNaI1p4k4kJ3XUdb
	+HQqxAgCSy4EoyBBFEbRZ581u/1SLWkWi7sj1nskqNz8TP+NEtr5FtQ3XUkuHAQ==
X-Gm-Gg: AY/fxX6B6k+UjcIAprHCYdhSfr5VaAmNCKEqe1C2MokCEn3fzHhMYrgAwL2U5vElqAN
	14YN7eS38SLw9iAmPWzUHoWc+3aygHn9woZJaljV0ptYvaiTUru+92nsecn3zv8C4aC2y18rRUb
	en4NM13B5Mci3i0IUZ+u86AgQh1Un/dDrtkQmZiWHgwvvqdtsxuXp5fIZyK8fNXLX5h2DLMaN3u
	N8Dz0bJScegRzhMid0QQTSzi2xb4whMN5oMaHgGtZiNmrWTCXZxFsyFtuGA7U5c8f+2rc2b+JfJ
	+xiEW78OuV1oRL2GGNbS7c4IKmOmGXGkOH6D2N786ihZUsnnPX84isDhVRvHrzi0cY95vciGYTz
	Np4H1C1z33dFGyfl/uO1GYq+6Wfe5ny4esrFqmxabtVFdxk1kEDnoHECYI+Cx/HDYFg==
X-Received: by 2002:ac8:5a46:0:b0:4f1:d267:dd2b with SMTP id d75a77b69052e-4f4abce1a3cmr428476551cf.1.1767183395131;
        Wed, 31 Dec 2025 04:16:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4Pfwh+egtxUj/QdUbBygykdOyCe3AD9kpBY9v2ldni3kiCg/sIQlD059WEMSwkll6E6T/RQ==
X-Received: by 2002:ac8:5a46:0:b0:4f1:d267:dd2b with SMTP id d75a77b69052e-4f4abce1a3cmr428476301cf.1.1767183394596;
        Wed, 31 Dec 2025 04:16:34 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037a5bdf3sm3954791866b.12.2025.12.31.04.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 04:16:34 -0800 (PST)
Message-ID: <59f3db15-77f1-42eb-97e1-31129fdf363d@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 13:16:30 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] arm64: dts: qcom: sm8150-hdk: describe WiFi/BT
 properly
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
 <20251231-wcn3990-pwrctl-v1-14-1ff4d6028ad5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251231-wcn3990-pwrctl-v1-14-1ff4d6028ad5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDEwOCBTYWx0ZWRfX5VjRp5NFxSWD
 TmaBPIe6ZCmgbrGAVo56LN+PeQOhPDSr8RCM04GiN8DlSgaZeIxXWeno925Er7SKpv5uvH5uOsz
 BHT7xfh/cC5nxt7dgvp9hhFf7GeDFn4T0h/Szp7xMplk9YL02SFGdqTQFvTSrOH0nByLbVwCSfX
 9088fYnELytj25Dx1bDV+Y4fKSl3OT1z1HLyobWjUw4z7cDr+4jHrXjflWi8cFwwziG9wGbmu43
 3/lwq+XvnI6PvvTWVzou/23a6vns/pxpzhj8ou64djTihSyCc08eGgQbdd150KVUl/mDFBFInlg
 rtJeN/IT+ciGCxm9fxLUy1+R++AC5I7dUalUKO+ryz5kTM4/xFzocsSU0E4//o9goFTYykfB0PD
 QSGpMVq+whx0gonty6JcfUoSQ3xENL8gOhMI3jWgcmUQv8UJyFCSWOD3EXF4K7kTtLtv5U3O6lN
 Lg6raB32LHyuLxt5Yzw==
X-Authority-Analysis: v=2.4 cv=Wskm8Nfv c=1 sm=1 tr=0 ts=69551424 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=83yv27ILqWWRH8MFNrwA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: Pr-LVJK8mhPwa7LSmxq7RB4zXUQ0HYFF
X-Proofpoint-ORIG-GUID: Pr-LVJK8mhPwa7LSmxq7RB4zXUQ0HYFF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512310108

On 12/31/25 12:36 AM, Dmitry Baryshkov wrote:
> Properly describe the PMU present as a part of the onboard WCN3998
> WiFi/BT chip. Enable Bluetooth part of the chip too.

[...]

> +	wcn3998-pmu {
> +		compatible = "qcom,wcn3998-pmu";
> +
> +		pinctrl-0 = <&sw_ctrl_default>;
> +		pinctrl-names = "default";
> +
> +		vddio-supply = <&vreg_s4a_1p8>;
> +		vddxo-supply = <&vreg_l7a_1p8>;
> +		vddrfa1p3-supply = <&vreg_l2c_1p3>;
> +		vddch0-supply = <&vreg_l11c_3p3>;
> +		vddch1-supply = <&vreg_l10c_3p3>;

Again, please double-check - I see UFS VCC is on this line too and I
would guesstimate that antenna supplies may be separate

Konrad

