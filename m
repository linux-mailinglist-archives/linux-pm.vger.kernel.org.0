Return-Path: <linux-pm+bounces-41934-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOflODOpgWn0IQMAu9opvQ
	(envelope-from <linux-pm+bounces-41934-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 08:52:19 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C5ED5DA3
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 08:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B53943019140
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 07:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC21392C3A;
	Tue,  3 Feb 2026 07:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HJQr9k8M";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WLMXkWMW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC03D392836
	for <linux-pm@vger.kernel.org>; Tue,  3 Feb 2026 07:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770105137; cv=none; b=opYpeai6CRs11+tbmorP8m3KniUhwRzm8PCT+NqMzqobwAbDGk8WJuBaD7N17jNg0gmav9DcTR6qZQye/aFkc7sqJNYPMZBVf4UQGjkn4ZVgScWH5mKdDGuvsUNLiwhqCjxX3qhqXOrnB4XDr60spzzPQom/oHUqTMWZhcuwEf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770105137; c=relaxed/simple;
	bh=3EtoTzrW1DsIQaN/sP+sMHlPYBvLQVVaSwu63f5Kj0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K+fA+zeWT28lwIe3KF65QDAGkiLBO6aoemM5BvEGkVK7XEV2nXwbG7q1ZL400Xr3HJSjfW9VgEhEpClr7Z19bUGosa1WSvNqaQZwETST1ttf3h9ptuCtQjTS1AKQImEImGrcA0j7uZTMqexSvrGVO5wEJcXCvoAMmvzh56q0PYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HJQr9k8M; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WLMXkWMW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61367iI43459105
	for <linux-pm@vger.kernel.org>; Tue, 3 Feb 2026 07:52:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mUlDuuMzC9nA4znLWFYd81AovsEM6ryHbDISxdNVVsU=; b=HJQr9k8McwV1lG4O
	IJDEkzIyYz78gEYdQtAyg/ycFG+DiZCGYkHUaGu/Qx3jih1sAN7xgA4B3MSfEqXQ
	XZTHNQpjZaYEZgtDt2+OhW5vuVj5k4cVBny3Cj+5vp4bupcnCBPGkHSMFn5SomYV
	f5IdotSy2h+QxI/CI81B5RO2bZrfSfyttQCoMmiyNkK5G4oEWX0S/1Jb9BIXI0Kv
	5NNqhJEyb/TRLnbyNUsuS7Ki9SvCunzUIxbIOZpALt6W91STtFui3/5QE71UNzvW
	6qHuLj+RWJiZnBf2Gq4lxkuz2LDykzDcYb23A8Mh//nPWDSmhMkx3XkORUSCiXfg
	BHWDkQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c2trbkd8j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2026 07:52:14 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a784b2234dso148130705ad.1
        for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2026 23:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770105134; x=1770709934; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mUlDuuMzC9nA4znLWFYd81AovsEM6ryHbDISxdNVVsU=;
        b=WLMXkWMWlO6dhrqbjrw3t5ojDhly23rS/N+3FhtuLrF4xL20wDp27oV035jGD8khBF
         0KffYQxXDd1LGvQWXCYu2IzmHIdSDKtjD8XgUXA07nELl33uiFrfU0QA8aME4UHQtnNj
         69mriFbYvbZcr68qpq3hOANplhciHKSzQvEmFpg/v/pYUC/VYikici1ScdB3vfiTy0xe
         UuKiYCYB2x2njdeDzXng+yStPcjhMna8hLRLQffT6RDlquJidL0B5a/mPZFRiAkg9wPM
         fzk+N5gNklGNVHN/kT1hGekh0hNp3vPdnVql0Ul7y3MC4nYVZ4XwVWW3v7d/ihxQm1Ie
         RIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770105134; x=1770709934;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mUlDuuMzC9nA4znLWFYd81AovsEM6ryHbDISxdNVVsU=;
        b=sG1ciQbAX4R4A273DH38Q+3H2viAAmrYgu6gh4dO+744OaZor21IIoeIQq23oNyDCx
         UHGBucpgU0iN4OkbC7IIm2za6ivOXNvnhamTLRkjdG5ZFMhO6xq3rb9ld6ZFTZFch8kT
         0xy6zjMcxfFTd2NTXVPBhmxNPSsXvjmOgewG7AR/oFuSVzxfwn7OZM7fouuW+YCNfRFE
         xsHnu1sIYuBiIevJFKSQbhDKRQsWOqYPL4y82ZG9/gDAue/Z9Xry6rHuBzyls+kEOL/C
         QCLEv/0W0SBUGrUPy4loHfvplmH6Ut2inxmov/JXySj+x3sihWugPsb2nC6kRpF06dI+
         eaeA==
X-Forwarded-Encrypted: i=1; AJvYcCUnNuW1aTae7tdBfmcoJZeWIQC6yZ6GA9E+Z8YG7Y5oK2OKk/tcFsGoTF2BekYQiZBWN22s6qaNLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXkznvqqWpUVxLDyAGDg2L6/HqUzLmjwWTfekdrfV/TR9trvh9
	i6mTar6RyGKFuVhribphxVXPDdpGpOZ2ystLEM1mOl5c6Bx92BC+ZRRpkHMl8DzNN9G96ztkx8B
	icw39Cahixzf4xgKKGZEzEe0TZfPdxgOyxmo6YV+6Koa3Li0cURVgOCbniofJwg==
X-Gm-Gg: AZuq6aI6eE20DE+YHVDxKNnV4ZhdhrghxE+37b9ztdUrAsuCybJ5n/SvvXnm2BaH8PH
	n2ioVJHAX7i6C8QPxwFTEFTfqNMT4pBFYVGOpr5preJwrXmA9iKqgUVdRk0W3kCrk4btXraYBcI
	KTkps3iuE6bmgru4yXZysoNgTio1LIZ6VQAhF1hlp85CTDxC4A4iP16H242PZBkEtIYz3PF4hb5
	Nmhtnkh12oN7QXtgXLl9h0Kee5lgfUhaX8qdO5waCsnq4OpQXE2C9wFjk47ZtAzBLhcsI56wdHI
	bfbjYAkYb61H0H+yukCRNkfSOpLeYYfYlD0UeInAZORzwovmOpy3C4S1Q03v842KSG8lT+j96+f
	jOEEYeESdte4CZdfYeyy9Z4ed/JsmZE4OQYIILx9cCN0c
X-Received: by 2002:a17:903:234f:b0:297:e59c:63cc with SMTP id d9443c01a7336-2a8d99370fbmr145075495ad.35.1770105132556;
        Mon, 02 Feb 2026 23:52:12 -0800 (PST)
X-Received: by 2002:a17:903:234f:b0:297:e59c:63cc with SMTP id d9443c01a7336-2a8d99370fbmr145075065ad.35.1770105131536;
        Mon, 02 Feb 2026 23:52:11 -0800 (PST)
Received: from [10.206.109.90] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b1ee89sm18645334b3a.14.2026.02.02.23.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 23:52:11 -0800 (PST)
Message-ID: <ca5b0a8f-fa0d-b7de-cc2d-0615ba4745b8@oss.qualcomm.com>
Date: Tue, 3 Feb 2026 13:22:02 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/8] media: dt-bindings: qcom,sm8250-venus: sort out
 power domains
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>, Jonathan Marek <jonathan@marek.ca>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
References: <20260201-iris-venus-fix-sm8250-v2-0-6f40d2605c89@oss.qualcomm.com>
 <20260201-iris-venus-fix-sm8250-v2-3-6f40d2605c89@oss.qualcomm.com>
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
In-Reply-To: <20260201-iris-venus-fix-sm8250-v2-3-6f40d2605c89@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: HnPdOqtCHwKunuLiSSvP1Zbig9SpUo_K
X-Authority-Analysis: v=2.4 cv=dcmNHHXe c=1 sm=1 tr=0 ts=6981a92e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=6p_0Lpb7IDiqYsJo38QA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: HnPdOqtCHwKunuLiSSvP1Zbig9SpUo_K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA2MSBTYWx0ZWRfX4l/wfSSEendv
 Wgal4H6adGGshrjNG0/zHS3iC69fZ/+mkrRTdhW0agT/Kg8O/BUG4gsgc5cC83RGs/SxCdPk636
 YCWFyigltBW4xfxlPVEyHJ/9AJUppxmoDFargV39+BZPv9nOBlBYYn3Ukij/TH8wgvB4uE70AoK
 1K1tItc5R7Yd12hyicYP04GvRn4O86uSZpA8NlFEd2ghz7N343eT03PoNs746xeeb+543+usQId
 FSq9lRsL822L0Xoovuv+6WPyBKZXyPgE5N11uVDUKqpzL0dNn27gF2npBizirlMqoLpHz+yif7O
 iEYg6gWCCQ3Y0a6pnjIitEHcA78VLRpGcOrnZvWzxVS0jvpzPyRKOYimDI2talRF8ckiN+RKahn
 BuCwFdHbGJlEunv/1c+pdK9d4AeXi5H4MqKVRI1x7nZk+p9rvqqNvzf8RJRE1v+fRT+d02pUJ+E
 XUhWyfpA5O+yJ+Fd+mw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_02,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 suspectscore=0 clxscore=1011 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602030061
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41934-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dikshita.agarwal@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 85C5ED5DA3
X-Rspamd-Action: no action



On 2/1/2026 4:19 PM, Dmitry Baryshkov wrote:
> First of all, on SM8250 Iris (ex-Venus) core needs to scale clocks which
> are powered by the MMCX domain. Add MMCX domain to the list of the power
> domain to be used on this platform.
> 
> While we are at it, drop minItems from both power-domains and
> power-domains-names, it doesn't make sense from the hardware point of
> view. There are always 2 GDSCs and two power rails wired to the video
> clock controller and Venus. Disallow passing just two.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml
> index da54493220c9..04cbacc251d7 100644
> --- a/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml
> @@ -21,15 +21,14 @@ properties:
>      const: qcom,sm8250-venus
>  
>    power-domains:
> -    minItems: 2
> -    maxItems: 3
> +    maxItems: 4
>  
>    power-domain-names:
> -    minItems: 2
>      items:
>        - const: venus
>        - const: vcodec0
>        - const: mx
> +      - const: mmcx
>  
>    clocks:
>      maxItems: 3
> @@ -114,8 +113,9 @@ examples:
>          interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
>          power-domains = <&videocc MVS0C_GDSC>,
>                          <&videocc MVS0_GDSC>,
> -                        <&rpmhpd RPMHPD_MX>;
> -        power-domain-names = "venus", "vcodec0", "mx";
> +                        <&rpmhpd RPMHPD_MX>,
> +                        <&rpmhpd RPMHPD_MMCX>;
> +        power-domain-names = "venus", "vcodec0", "mx", "mmcx";
>  
>          clocks = <&gcc GCC_VIDEO_AXI0_CLK>,
>                   <&videocc VIDEO_CC_MVS0C_CLK>,
> 

Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>

Thanks,
Dikshita

