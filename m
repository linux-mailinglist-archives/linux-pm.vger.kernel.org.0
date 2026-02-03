Return-Path: <linux-pm+bounces-41938-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIewDtm6gWm7JAMAu9opvQ
	(envelope-from <linux-pm+bounces-41938-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 10:07:37 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF794D6935
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 10:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7485E302303B
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 09:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FED395D8C;
	Tue,  3 Feb 2026 09:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nN4n160/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BRyIGOJx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA006395D98
	for <linux-pm@vger.kernel.org>; Tue,  3 Feb 2026 09:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770109651; cv=none; b=Q8UrsGkAF8nlPJEIhHIOz6PdMMFzJ9cJiSxza/0ZlBVMEOG9pRJHKQdFpQsJ55E7KcMn6M4bToPJUcSFnsKIdXlyKAQJi6HpGJe/vXdt0m4ikXU/5E07LxfSV9hMPyEiqR6TuapBOxghO6A0FVUoN3H2reQ4G8JwL3IuHA+vj/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770109651; c=relaxed/simple;
	bh=r7zBYTBwI/33M4f7vzrEMy0LPJOX7EFtuoJ8V6TwbTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FOWZc51L8N1U3Fe0ivyPS79E3GmDqXFQmTjAJGddDBx5lAQdDIkYn4voTuhkQ4rgfUOuWVqyZwCZI3PBvfL7IsRgoiMtJunQe5Q9BFjtXY8O2Qkd8CYtTFfjHmcuSYQJaMNHbTqPcmTlbXgo7gVY3au/3BJJpfL61JnOXkgJv+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nN4n160/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BRyIGOJx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 613622j02848656
	for <linux-pm@vger.kernel.org>; Tue, 3 Feb 2026 09:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dowN0l8PG5L77f+jBzl88Eb1rukCALYcJhjeDvDYXuA=; b=nN4n160/dKBL0mzT
	LZOmEfDBC9mI5s+KCqHbYy7k9Ud8OGnovFfAeQVQuoofwILVToCBFkb6Bw1kcnpG
	mLwNq0bbvtTs1hEjRd84gmWsj0wzOKOTzW+qT23b5+1cBYlxW+zk8M/7xKC2SNDt
	1naPjJFy2R/6cyHe9/JzmciMLdH/3ktuRmOBqRhvZUHXDg4oIr/Xe+E1tmZphRnn
	bLRN1ssjO4LJR5LPkX7rf8PTH9+CPwULLU1bvyMC9lN/bU7WNEfv252eJlEX8IFp
	tmSE2iXvAGa0oQnXup9Mnd8ZP6zPH07u9BOkXXIBwkajlFQC8Ka1uJ2mug3xZv4/
	9p3MOQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c2tqtkrgj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2026 09:07:28 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a90db74672so21275185ad.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2026 01:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770109648; x=1770714448; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dowN0l8PG5L77f+jBzl88Eb1rukCALYcJhjeDvDYXuA=;
        b=BRyIGOJxODAr1Qds28i2KJ8BNZVL3s57bGDf1AEkcloQxweMcTYWgNL0/gnpUt2pYj
         5uP7Vkf4Q/Nl+QGuVniUx3GPtvvyaEzguYNR1hNu0moUA48D0tnL1QN+sE7eeFc3iDJ1
         MpdYshADh7rtRlTGRe75nQpmGCkGKBxJ/Nn3hxsYchNpoVA5IlMnXeMXOUE5yAzjZkrZ
         0DM2hDzmr5EB0QquvKJI2sxYO5JDudqPMhiT2vzaaHFrO2jagPB0d+6swRStKFzAuxzp
         v3UmkrZ0rn0ZRbAHnX4IA29s3log6fvhMNSFhlmMSuK26ppG+PFx5BW++Ah/SR1LT4nT
         0kuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770109648; x=1770714448;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dowN0l8PG5L77f+jBzl88Eb1rukCALYcJhjeDvDYXuA=;
        b=WXQoYw964icNcguX/rrbWv2fh4DtLjEvxZno+z+vw7CKiB3yx/bGxZGGNCXtEpXcaz
         b9nhkUYLGGesrwROfn3Itg8SmhIyWVAntuhj3lvIaT6oKXOHh2w1yu09rX2h3sO797/F
         Uyta0G+CNTFU2Ycvibs89a5W7zR4D33do6z/DwxU17eml/9rjoRAJfzwfoWjccia6i97
         oLQv02RHbSieSttog4ih5ZEmkdzAXixCRvcf+2LRakvO+r3FBsUitWqvY1rARgJDCjqC
         cAl+WGgJBAlkeRVj72+q8M5F3+cj4eUb9dNnK8flgsDVDC2vW6swzwT2+eLYiIcUxkV0
         uuOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUNo2M0ZxogEM2KgxASeJ1QyL5fNt7T8xSlDx1ELmXm0DBYzlu83SpbKy+iapVLlbRPUfPUexeHw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Ln1rP/DbL1nsdYbM0Nuua0SOV+AoiaDlNhMOeitI+5XYLYkK
	H9lnVge0iWyeWi8I0v/EkX4WXGvfRbBe4yXucZOWhO8Vkqm4ICER4B9yxOmBwzAS2G9pTf/69AT
	dslFvoTFeoI1yLLGMrxHfLdGtNd0jeBIG/hURwlFKFsf+6hMQbitXGAxfOaVAgA==
X-Gm-Gg: AZuq6aJP5XDLIs6XXo5S8/4kOUTl+qvKc+tBtDIMi31UcIGocsCxXxS+hztg1BGmEu2
	QzAoLDB4JHqc6K0nDN3guYNyhoDLxP/jrveFhe10CNAt9Ixcdrx3uunjwcd0dH0r0ofS98fnHOp
	RXELBm/B8l2nCCET7ueJhCsBcXiAUp5Zq9R5ZPKRV/Qkd2E90kixoiA9jfdTcqpNI6nRyZAQTsI
	vEuc9D1QuEh8yjKVhcybt+21ceLDgn9yrl8SpNP+1/Sj/pPpATQZR8rnHSz861g/calDsdvbe/z
	b5669mBOjum5mw99xWgwGAocLH4mw38SIX+TtLvMZ6eN9f6qBuXQadfMhJlFqLLnbXEQ+t6q9Ff
	/GPizfyb1DA/06xfbRBRIlk/KyOZ2evdVlA8S3iX8KG7r
X-Received: by 2002:a17:902:b949:b0:2a8:7827:bb32 with SMTP id d9443c01a7336-2a8d96a17c3mr95174955ad.15.1770109648061;
        Tue, 03 Feb 2026 01:07:28 -0800 (PST)
X-Received: by 2002:a17:902:b949:b0:2a8:7827:bb32 with SMTP id d9443c01a7336-2a8d96a17c3mr95174665ad.15.1770109647553;
        Tue, 03 Feb 2026 01:07:27 -0800 (PST)
Received: from [10.206.109.90] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b414071sm160847725ad.29.2026.02.03.01.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 01:07:27 -0800 (PST)
Message-ID: <95d2ad4e-082d-b399-3a35-99fd6a3e78c1@oss.qualcomm.com>
Date: Tue, 3 Feb 2026 14:37:16 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 7/8] arm64: dts: qcom: sort out Iris power domains
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
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260201-iris-venus-fix-sm8250-v2-0-6f40d2605c89@oss.qualcomm.com>
 <20260201-iris-venus-fix-sm8250-v2-7-6f40d2605c89@oss.qualcomm.com>
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
In-Reply-To: <20260201-iris-venus-fix-sm8250-v2-7-6f40d2605c89@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=XP89iAhE c=1 sm=1 tr=0 ts=6981bad0 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KaDJ12nNnFZpivlZOL4A:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: EpyDOr0aly1ZsH9fY4Tgo5_lxLW0cYwq
X-Proofpoint-ORIG-GUID: EpyDOr0aly1ZsH9fY4Tgo5_lxLW0cYwq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA3MiBTYWx0ZWRfX5M8E6Dl7lazJ
 ygfHlKb91ea/XJUSCQIyyODy5JO63I8Zw+Cz0nbOxNZvOK5By6r/EM4GfNoKTOxmGAPh4U7odFk
 HiCkJiBuNmZy7ePL7NNYafYmWJO0iyFTEkOBhVFmzl5FVn+9tWT3LlW0ShsLZONmY0F0ny4t6TR
 jrJGQ1R2XEazY9TKIQnrGeguUvEGRUHjSTA2fWcaVzygrG33nsKuhvmyFxGkitBs1D6gkeBSJPn
 cO0KFAQJCV7LJKpuMktiLnQA1SmJFlK4CKXxMkeGX6yAaxpebO9VkM5Q052J7wVCEbr9oxrJ1vp
 l7iw7VjPcSMJ5/R4jEjW7knZHrfouJjIzSwGJ9P8lMZ1iKXrhC0D83W3R2o+Y+BgVIrxizyZnRO
 A2P18HekCw+KZd16E20L1wnW7H/+QTfr9OZtYnq3WX0SLDQkJusgpzolxg0VpF9aI0D2SvOqpLX
 ziTkpVNwCp/7Kv6NuPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_02,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602030072
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41938-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: CF794D6935
X-Rspamd-Action: no action



On 2/1/2026 4:19 PM, Dmitry Baryshkov wrote:
> On SM8250 Iris core requires two power rails to function, MX (for PLLs)
> and MMCX (for everything else). The commit fa245b3f06cd ("arm64: dts:
> qcom: sm8250: Add venus DT node") added only MX power rail, but,
> strangely enough, using MMCX voltage levels.
> 
> Add MMCX domain together with the (more correct) MX OPP levels.
> 
> Fixes: fa245b3f06cd ("arm64: dts: qcom: sm8250: Add venus DT node")
> Suggested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index 980d6e894b9d..531470506809 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -4321,8 +4321,12 @@ venus: video-codec@aa00000 {
>  			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
>  			power-domains = <&videocc MVS0C_GDSC>,
>  					<&videocc MVS0_GDSC>,
> -					<&rpmhpd RPMHPD_MX>;
> -			power-domain-names = "venus", "vcodec0", "mx";
> +					<&rpmhpd RPMHPD_MX>,
> +					<&rpmhpd RPMHPD_MMCX>;
> +			power-domain-names = "venus",
> +					     "vcodec0",
> +					     "mx",
> +					     "mmcx";
>  			operating-points-v2 = <&venus_opp_table>;
>  
>  			clocks = <&gcc GCC_VIDEO_AXI0_CLK>,
> @@ -4348,22 +4352,26 @@ venus_opp_table: opp-table {
>  
>  				opp-720000000 {
>  					opp-hz = /bits/ 64 <720000000>;
> -					required-opps = <&rpmhpd_opp_low_svs>;
> +					required-opps = <&rpmhpd_opp_low_svs>,

should be rpmhpd_opp_svs for MX for PLL to get voted to 720000000.

> +							<&rpmhpd_opp_low_svs>;
>  				};
>  
>  				opp-1014000000 {
>  					opp-hz = /bits/ 64 <1014000000>;
> -					required-opps = <&rpmhpd_opp_svs>;
> +					required-opps = <&rpmhpd_opp_low_svs>,

should be rpmhpd_opp_svs for MX

> +							<&rpmhpd_opp_svs>;
>  				};
>  
>  				opp-1098000000 {
>  					opp-hz = /bits/ 64 <1098000000>;
> -					required-opps = <&rpmhpd_opp_svs_l1>;
> +					required-opps = <&rpmhpd_opp_svs>,

should be rpmhpd_opp_svs_l1 for MX, SVS can only go upto 1066.

> +							<&rpmhpd_opp_svs_l1>;
>  				};
>  
>  				opp-1332000000 {
>  					opp-hz = /bits/ 64 <1332000000>;
> -					required-opps = <&rpmhpd_opp_nom>;
> +					required-opps = <&rpmhpd_opp_svs>,

should be rpmhpd_opp_svs_l1 for MX, which can go upto 1500.

Thanks,
Dikshita
> +							<&rpmhpd_opp_nom>;
>  				};
>  			};
>  		};
> 

