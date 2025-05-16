Return-Path: <linux-pm+bounces-27231-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4BDAB9B1A
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 13:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5329B1704EF
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 11:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F234D238172;
	Fri, 16 May 2025 11:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dRqR66ap"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6748E238142
	for <linux-pm@vger.kernel.org>; Fri, 16 May 2025 11:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747395122; cv=none; b=pMbWvP0PEAI/XghtZOHzuwmCIv50cXtajOD5Y+r50Q/2VyOxxAS0nRLgPcLvXHxdtmUC1txWziVo6oJxLH4S/M6CLpzEP0jM7q1XWCISDU468zHHj4NyAedIEMK0iokGBLEIxsKhgLjEvDXfoR0ZHokdi3PW3KhzjUnBvMt+2As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747395122; c=relaxed/simple;
	bh=FycK2ZODVKZ+lpAYgjUK8m4GTFrVQc0AVRZfmvA+wIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hbc7OUsf7rpT3m2iXqfwL/2ytKF2TKAAVm+v5jIMzeaDHGQVxgr6XYgZ140OfFltzYfKXeM78h/Z9GryxdZRAPc1zRpXkvAck54dV2ROP1yX1GWvH4x8Pr9CgFTUnRvU98T/z/z0BnQQdQto9oawjxkPwOp1W1isDYlZUw4GcCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dRqR66ap; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54G8v4vq021960
	for <linux-pm@vger.kernel.org>; Fri, 16 May 2025 11:32:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fnzC285t3rkaZwxrXZ55mpC+N/Zc/3Ny+FfdlNU2kLY=; b=dRqR66apEnvPjJPH
	yeID3G5+Rg5NPfrXuFh3aGQIqGG5DIuplLekO0sl+RQJkooeU4ONUMMXJ0X3RCvW
	3ktUwywPWGnVeY1XUpZknIlM92ZBbQnmZ/6Qiwd3kftYppZep6jrqsPQPMFWhENh
	xEzh2sxpEvSN384z8sFftn/0k5TDMkA28Seumy3ILgk4y47lJP+qd0EDaFDHkDb5
	9Y+Sxf368DK8pHZPpczNgJCcuwn7tuICBNS9tbuEEVrD+4iITgb9J6uAK3pKCwcz
	cwcAVUEcDhUXO3WeyLd1zzUHSvWV5Wo64a2CFcFCFV1fFgZbE83sbPvkwxzo2cnM
	lbLKNQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbew9m1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 16 May 2025 11:31:59 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4775bdbcdc3so5565971cf.2
        for <linux-pm@vger.kernel.org>; Fri, 16 May 2025 04:31:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747395113; x=1747999913;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fnzC285t3rkaZwxrXZ55mpC+N/Zc/3Ny+FfdlNU2kLY=;
        b=CFzDSV1jxiWgX3v4GIx3R6W87n9e0g/ytXVmdJ14qhdcqEn8A+h4nwJukBm0pg5ic7
         560G13ADz9TWslNe3A1gcPKamXEdXtv1ed7vMmeSZSVgQvhHf7Gy4/I4uV+zGIiD/89z
         mEbYFkb+8M74SRaP2HgF+SWtS8AaNfkqdvb5RcFNGEnyClcqJE7qDCFfj6fsEIVA6UUW
         l42UmZDfhNR0QtVSz8dfm5TtlUTHUPqQ8v6mgExm/gvCQyVkSnmjSddYznM2R3bi86J0
         RO/zdTQc1OGcUy+VFKIqXwe/y23TUl0d0KBA3BoQSqEXZdED7nlcS9GmLVJr+s9fXvYs
         e3WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsyF94RuVXJnruZoXW/tGw/ZGxtXwzcLa0rDth8k69Q0oK3xKzNT70V/KOY21mw/qUlvNAdopGEg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzws3G5uTJBSZdZFo0ZobHpKMrB+OQ5r3VNlGOaxY/vVD7PmgB5
	uD3geGLDmWm6Z7zgWBRpZbQNgxQFHIM2aQrLxp02ZD62THaL3InNpWKQchgTWruQoXw3Aqgfq07
	9ubp0lZglXcFsp3FXUWykqBL6RAXQ1nUMKTegFz5o32fTPFif5OEe8TMdl4+JiQ==
X-Gm-Gg: ASbGncvswSi2/ULj3F+c4Fi8T9c/vNL80bMipg7XGzzZoN3h+r4SfMqVLmF8AojWPzE
	hozr2uX6HI+ftEVokLNMdt4oD7Rt9Z/9BBVDMze9JrvmUyZZ3qqxmbINwjF654nhgSdA3zW6k6N
	3c3SdZFD/AsSUNfoVNVc4Aj6nA8p9S9x8R6FlU6jOMQBSYRFfosLdwRHO0kSdOREPol6IhrcqxK
	U+g62HN5foNP9fNTi4wLxyBeOM07DmPfJzQ0zGGUYxB6OGTYPxss0y9dIweG377WmJ4WqKMo9Ti
	9mddtmFEDI6NLf/8GM27OsI+oqAIwpx+/BpyZqA4HiQ1IBH5Hg0hudCi0KvQ4pdqBg==
X-Received: by 2002:ad4:5765:0:b0:6f6:d4a8:1a6c with SMTP id 6a1803df08f44-6f8b0806decmr20294346d6.1.1747395112935;
        Fri, 16 May 2025 04:31:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCEBLp3n/whIhi4REkgwi84pjCbz7w5PCZVecxxq7YLAuV1dBIWRpjJYZo6uKW+5BD+6N3Pg==
X-Received: by 2002:ad4:5765:0:b0:6f6:d4a8:1a6c with SMTP id 6a1803df08f44-6f8b0806decmr20293946d6.1.1747395112304;
        Fri, 16 May 2025 04:31:52 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6005a6dfd41sm1294532a12.35.2025.05.16.04.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 04:31:51 -0700 (PDT)
Message-ID: <f8e44e19-0c86-435e-adc0-b9cd5b24b1ed@oss.qualcomm.com>
Date: Fri, 16 May 2025 13:31:49 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v15 5/6] usb: dwc3: qcom: Configure wakeup interrupts during
 suspend
To: Krishna Kurapati <quic_kriskura@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
References: <1651740973-7944-1-git-send-email-quic_kriskura@quicinc.com>
 <1651740973-7944-6-git-send-email-quic_kriskura@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <1651740973-7944-6-git-send-email-quic_kriskura@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 3GpA2De5--eSMf_9t0N4XUjbu9jBQygj
X-Proofpoint-ORIG-GUID: 3GpA2De5--eSMf_9t0N4XUjbu9jBQygj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDExMCBTYWx0ZWRfXypfSfZKG6Dqk
 CDthmKfvvB6EGljbL/Bz9eSkGssekvlfaVmLhb1tvb35SNLS5tp8iywVdnZq18g9u9f5WSiQmDB
 E9uckKVOcbPny10fclAqH7EOrjxHq6SrTDYnHQba4TAUGJg5M2BXZEl+YUZzF6YpoAvMf75r1rS
 H3lA/3Zro++4IU7Wqrmfs83zRIpxbz2F0uEVc6/uee33WN/Fc6YmnIR5qyVU/nXqtGuNOgcD2x6
 4biaWjZdcGDD9nUcsocKWQ6V2Gie4NxUL5VQLAYrQpu05ClvH//B27mFtSUjb+PExOLbwnXd70L
 uZ+6lM8GLTY+pLZrJhod+BYFCm/UPUIqs4Tun8aIduOA8Uyq98tCyYF0bylgoRjOF32sMAE/nUK
 lWh3VqyqjB1oRxxZc4NATQmbqMDK6gfdrRs+WqYL4BmJ0mtdVI7KelNWc8lyIeUnT51/oxjA
X-Authority-Analysis: v=2.4 cv=LOFmQIW9 c=1 sm=1 tr=0 ts=68272230 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=bXvnuBKqF766Z0xgLQAA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_05,2025-05-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=998 impostorscore=0 bulkscore=0
 clxscore=1015 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505160110

On 5/5/22 10:56 AM, Krishna Kurapati wrote:
> From: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> 
> Configure DP/DM interrupts to detect line state changes based on
> hs_phy_mode. Enable the triggers opposite of what the current
> DP, DM levels. For HS/FS mode enable DM interrupt and for LS enable DP
> interrupt.

This is not what the patch does for FS

[...]

> +	if (dwc->hs_phy_mode & PHY_MODE_USB_HOST_LS) {

to do so, this check should cover FS too

Konrad

> +		dwc3_qcom_disable_wakeup_irq(qcom->dp_hs_phy_irq);
> +	} else if (dwc->hs_phy_mode & PHY_MODE_USB_HOST_HS) {
> +		dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq);
> +	} else {
> +		dwc3_qcom_disable_wakeup_irq(qcom->dp_hs_phy_irq);
> +		dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq);
> +	}
>  
>  	dwc3_qcom_disable_wakeup_irq(qcom->ss_phy_irq);
>  }
>  
>  static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
>  {
> -	dwc3_qcom_enable_wakeup_irq(qcom->hs_phy_irq);
> +	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
>  
> -	dwc3_qcom_enable_wakeup_irq(qcom->dp_hs_phy_irq);
> +	dwc3_qcom_enable_wakeup_irq(qcom->hs_phy_irq);
>  
> -	dwc3_qcom_enable_wakeup_irq(qcom->dm_hs_phy_irq);
> +	if (dwc->hs_phy_mode & PHY_MODE_USB_HOST_LS) {
> +		dwc3_qcom_enable_wakeup_irq(qcom->dp_hs_phy_irq);
> +	} else if (dwc->hs_phy_mode & PHY_MODE_USB_HOST_HS) {
> +		dwc3_qcom_enable_wakeup_irq(qcom->dm_hs_phy_irq);
> +	} else {
> +		dwc3_qcom_enable_wakeup_irq(qcom->dp_hs_phy_irq);
> +		dwc3_qcom_enable_wakeup_irq(qcom->dm_hs_phy_irq);
> +	}
>  
>  	dwc3_qcom_enable_wakeup_irq(qcom->ss_phy_irq);
>  }

