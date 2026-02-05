Return-Path: <linux-pm+bounces-42122-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAD3JwBAhGns1wMAu9opvQ
	(envelope-from <linux-pm+bounces-42122-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 08:00:16 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62938EF348
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 08:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 552AB301DEC3
	for <lists+linux-pm@lfdr.de>; Thu,  5 Feb 2026 06:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E683570C4;
	Thu,  5 Feb 2026 06:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="coBivwoI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mi40DIyu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CBB3563F4
	for <linux-pm@vger.kernel.org>; Thu,  5 Feb 2026 06:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770274764; cv=none; b=rdoi3oQgfmC4pwhUh0lb/gxDsV59KOMyj3eGY7wmtyvLE8J310UedL2opV7C9iYlgbORZJ9qfu1/Dkqpx5jGkYNEeZIDPMHspTR5oyE421BwYS8bkh0dvlEjr+vcLvpsoHJXViaCGp1tvcWC9Hfx32FekNWtVOwWu4E49vh9R3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770274764; c=relaxed/simple;
	bh=9aoSev/tVFpXZHbFBD3F98FagXJcrvN2ig73gyRylUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O3Fl24zW30F6Ni3WumWGFRKRCN0F+4BS+AHxRDGBL7KpZC4g4FcqT4fc0/EqgbUuglipy408LieWjmvVC/e+Vwuk2O2m6rVHGxs1bIJMNoxFCcfy5/IQvamMjFTWolSTx7JOAZZC1Qkd+wItU8L8LEN30f/nji/aYcVmF0z48UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=coBivwoI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mi40DIyu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6153dka12073182
	for <linux-pm@vger.kernel.org>; Thu, 5 Feb 2026 06:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tNT4aI2gU1p3r5AicwN97ckWVLi4rZjcqz7s3mLymew=; b=coBivwoIG4EzqF9v
	01sO1ppogOODayv1dFOH1qVXWql4WXy0hDxgGVH2Hvn+28weuzAkNN+OPTg5S1V2
	/4ufknxY63pIaf9G0KXC/lHnp/ZJ2qigVPwJ27GwOh6rgvphmOrmv8e6oqWi+53a
	zV5Dg898J2P0/V2nOkf+0LcSZvTU8BoccC7G448iO12OVQaAkf2DVQhRn+t/kZyr
	vgnCbN4GhVxSeJCRSfAUDHYgnk0srryY0y517Pnr19BI8AkPvSpIO6bc7GrLY+cU
	hKJKNZVnq4ac7yAizipwaiFjqJVEFQ8UOgAFjysmOYHErmoyMotMuiDzbNOVPs/N
	cbzTpw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c44kbkbmh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 05 Feb 2026 06:59:23 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b630753cc38so1324473a12.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Feb 2026 22:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770274763; x=1770879563; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tNT4aI2gU1p3r5AicwN97ckWVLi4rZjcqz7s3mLymew=;
        b=Mi40DIyugpzU898/Hx4rijQVQl2Ah596FRjLL12uJkWtkXnLTXUDyiF18o2erNIXnO
         B6n/c2cGWdUwb3hL2Zh3BvFTLa9UipsVSgBYY0fCig49hDoQlpW5uYJDigaCozXYg/AJ
         cGcVVcbPY4fClpM/lWU6wZeZMvFV+Q3sBotJpXDC6RD0FwBtpjyG8GEY/SJjmvV5KQHK
         h+fxsNbVpKl99YgzyTGJaUt3U7sYtyZBsM39yetKfEgyD+VDQ5aY2RCBjx3uZg9uGCYq
         cFzgfklUV8SljKTRbFt4WnVU9dUFw2uRP41SFiBprCeV0bFvxk0GT4vKX/3x0+yDsnYU
         rB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770274763; x=1770879563;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tNT4aI2gU1p3r5AicwN97ckWVLi4rZjcqz7s3mLymew=;
        b=bZ5qwDIG3llGKciI/yz9qEYB9WC1QWCPr3twPQlgAlSX/Wab7Lj3agOB/19tjcVIQE
         Hg7m3N5P4zcX0e09R0ABGKGiESdC3TlkkUE7bZn3zB/wkYOyY+KRHdkMvrRTDMACXxtC
         98P3hRqQ/d7zv7bWxAV188LH5K91BmaGI4/0tAsPh/ll8kvsyrMJwQRjN5yj38OERkUO
         AvkePFHO94l7aP4OFEbf05Kmr0a2Dt4rHyHO1UP3z7cSg41BVAOKm2b6NrSGJjv4Yq+c
         qKYicN9Eqkf/TuPKiHsUD0WWqSW8kmO6lQclch+0glHTm1veLxPxy/x+MiHtan8l63Zj
         imwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuKkSLa2VxERdnZQyXY+nDcADaXO3+bfYM1Hrfj9cHTD+CmpdeKg1TPVq/tbuUv4f3Q5gKgIQ4Jw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/1oCIGffSC+Av+gaaM1lVsEeP9r6QR+YCAHVnFTqVNg3p9MPE
	ME8G3ECgetfc53YDfOSAH3h9opGCdwGDJGoMECHLZ/kQVn7/KFiGSwb+1rKatx2ymnhP12Fj0DL
	F/nBrKm3P+iBoaksutELrUS0j+rm/fxBx2DQ6qabx2aUbakMNGyyA79Nr/mq0qg==
X-Gm-Gg: AZuq6aKW6YnyCWdOfAY/W6CjbBCoG1wZivTj3iC/TZmNS9c+o7LdcgTQtfNgW/4s5QU
	irG1rhxtOfPD0TVbrDdqxD/8MLd+y8dzl49wO67PeVp5uz9D7WSNt6s1NXx+xVfooyo6IMT/Zy3
	ugK2hCTpmE/a+EkqD3e1R0rZJlmfzY2RpFeGLkZNRUUEhO3PGRJIzk8p9eFC+WxBxQSt2CookKJ
	THJkhhq6jhlFXgv38XsizHJeCztLTCcwxm0r3S3fi0YIy1O96IGf78dzbkq1nwAZ9BxrTkUlTXF
	+taBHfGTajX+8S8/LmcxC+0Fo24oCYaFa3aQOuNYWcJ6zwJHMAoVDIBTmc022O3AxCUEroTWOo/
	4WaZ7/yZ0+d6gkghncu1n2GHOphzMLgokExRj8Jhlm2pO3Q==
X-Received: by 2002:a05:6a20:6a23:b0:35f:cfb:1ee3 with SMTP id adf61e73a8af0-393720dd098mr5487340637.25.1770274763111;
        Wed, 04 Feb 2026 22:59:23 -0800 (PST)
X-Received: by 2002:a05:6a20:6a23:b0:35f:cfb:1ee3 with SMTP id adf61e73a8af0-393720dd098mr5487293637.25.1770274762615;
        Wed, 04 Feb 2026 22:59:22 -0800 (PST)
Received: from [10.204.101.146] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6c82e342e0sm3986988a12.6.2026.02.04.22.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 22:59:22 -0800 (PST)
Message-ID: <f3706cd8-f3e9-4ca1-790e-a8555bd1e976@oss.qualcomm.com>
Date: Thu, 5 Feb 2026 12:29:13 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 7/7] arm64: dts: qcom: sm8250: correct frequencies in
 the Iris OPP table
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
References: <20260204-iris-venus-fix-sm8250-v3-0-70fa68e57f96@oss.qualcomm.com>
 <20260204-iris-venus-fix-sm8250-v3-7-70fa68e57f96@oss.qualcomm.com>
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
In-Reply-To: <20260204-iris-venus-fix-sm8250-v3-7-70fa68e57f96@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: TQYEbZVMJYh85FMpmQOMukDKs4GBfPhM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA0OCBTYWx0ZWRfX24yTziHejgnd
 EfseKMVIxsbffUosjHZaLyJcI9Vjpo2GZsvePCLdK8A/NGfIq1P/BtGBZkWaszaeAXCen82vm0i
 gJ6B5+KsJGaqdNLwX7xjBq/BgTgGw4bBqCUqWf4YXBjHjqyUacIuwPwMRxE7lRZNdfGXMkSwOKK
 /LhceDxr5NePRsYIME3oRoJ3ilfrNSfdt1Phcr6R+4SNP3zoRT7vS7ZgAYj253MwQWNSCBJATHY
 ioz55pwQpsuzbDpndmtYGXKS/HFN7YTCzZLD9mO1dzmiL+trqIN9RjM/K6lUWxEnC6kjy7Q4idA
 vgxbWAw86LK1aVqW9rCKNGeWgDlih+yg//BvsxhLD3DSt7isLzoqVEf2mbc8V+EROy36Kav9cOk
 7bxb4xPC6P4t5OQ6YddS5fRUqv5AYP0NiOInWVc1vrFKSjvNZu/wgNL1d/DrbA+8kKxcOWniDBO
 l/sZEdU0vP2kFBhZukg==
X-Proofpoint-GUID: TQYEbZVMJYh85FMpmQOMukDKs4GBfPhM
X-Authority-Analysis: v=2.4 cv=HN7O14tv c=1 sm=1 tr=0 ts=69843fcb cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=2OYgVc-5B2WHko4x-TYA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_01,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602050048
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42122-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,aa00000:email,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dikshita.agarwal@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 62938EF348
X-Rspamd-Action: no action



On 2/4/2026 6:29 AM, Dmitry Baryshkov wrote:
> The OPP table for the Iris core is wrong, it copies the VDD table from
> the downstream kernel, but that table is written for the
> video_cc_mvs0_clk_src, while the upstream uses video_cc_mvs0_clk for OPP
> rate setting (which is clk_src divided by 3). Specify correct
> frequencies in the OPP table.
> 
> Fixes: fa245b3f06cd ("arm64: dts: qcom: sm8250: Add venus DT node")
> Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index d8be5c1add1b..7d11f1a28546 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -4350,26 +4350,26 @@ venus: video-codec@aa00000 {
>  			venus_opp_table: opp-table {
>  				compatible = "operating-points-v2";
>  
> -				opp-720000000 {
> -					opp-hz = /bits/ 64 <720000000>;
> +				opp-240000000 {
> +					opp-hz = /bits/ 64 <240000000>;
>  					required-opps = <&rpmhpd_opp_svs>,
>  							<&rpmhpd_opp_low_svs>;
>  				};
>  
> -				opp-1014000000 {
> -					opp-hz = /bits/ 64 <1014000000>;
> +				opp-338000000 {
> +					opp-hz = /bits/ 64 <338000000>;
>  					required-opps = <&rpmhpd_opp_svs>,
>  							<&rpmhpd_opp_svs>;
>  				};
>  
> -				opp-1098000000 {
> -					opp-hz = /bits/ 64 <1098000000>;
> +				opp-366000000 {
> +					opp-hz = /bits/ 64 <366000000>;
>  					required-opps = <&rpmhpd_opp_svs_l1>,
>  							<&rpmhpd_opp_svs_l1>;
>  				};
>  
> -				opp-1332000000 {
> -					opp-hz = /bits/ 64 <1332000000>;
> +				opp-444000000 {
> +					opp-hz = /bits/ 64 <444000000>;
>  					required-opps = <&rpmhpd_opp_svs_l1>,
>  							<&rpmhpd_opp_nom>;
>  				};
> 

Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>

Thanks,
Dikshita

