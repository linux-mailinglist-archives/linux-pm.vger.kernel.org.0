Return-Path: <linux-pm+bounces-42740-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGOcM25flGn2DAIAu9opvQ
	(envelope-from <linux-pm+bounces-42740-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 13:30:38 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE53414BF99
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 13:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0FE45300DCCB
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 12:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C6F342534;
	Tue, 17 Feb 2026 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lpvQK+Mn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z2vVqiyo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5D4340D9E
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771331429; cv=none; b=W+nfNst7RiR/s1MOth9dbL5WgNgLGKUYU3Cux0mww7qjMGZ/p++4xXRUf5HlH6MyTZIDsHTwDjhuMSWWMocraRb00JxX79kTCsXzzYRghW4F2+iurU4GeZ/HyaDp8XVKL+HxalUf41WZzelnZbp0bVVq0uC3fZgE10bd9aNOOkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771331429; c=relaxed/simple;
	bh=iaOjQh6oj22SQAOvuDXoKCh79HvL3yEC6boAm8Sbarw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I6BfgmRzk1OcZhWMYsUAtmbn0zD2f3XLdaM+T562hKa0lkY/NNbAFWD7A8q6Q/NIE7qNDndX25qr8H9mM6UYs9GijEeLJvQeRXE9ykw1mrgZkaEeAAkU6v3KG5Sq76WwKmV7qutNWZvOzUiybiWSEcEQT8NRytlgpCuLDKhFYm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lpvQK+Mn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z2vVqiyo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61H9FOTS1544910
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 12:30:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fXjw2GmP4lQdAtjniPE9MY2CqejpG7o6YmHO6qB4zSQ=; b=lpvQK+Mnpsr1OXoG
	gGSCb37+QAeYAHvYCzWdmMGX4kzOYeT4i9K1YtQRtonZvF6HNWv1bbdiiEmy+7WE
	ooIHyk0PLYeq1V1QnFCVODEJWJZm78gF6gqnlNkuP+3JcnGQomzqIytit5Qc93QQ
	Ft/3EQPgGIOHJgzSnzWEKk018nd+Vasq8hHWj9ZVjQC/Ao6RyrEN2zLTw+iGE5Si
	FiYGeXJUmEq+NOyitvYqdlvHRPxNbABIUoZfQbuUlTnoBhX4Ggowb8YcwHF+q2PK
	x1ZLfMGlXae+jwQhS1O0ChZcu/SM4zr0Ps1QhTUqog2mwpLfNwvl4J7STbrVvx14
	k3BQVA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc7ajt65m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 12:30:23 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8954ab64c65so42787426d6.3
        for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 04:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771331422; x=1771936222; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fXjw2GmP4lQdAtjniPE9MY2CqejpG7o6YmHO6qB4zSQ=;
        b=Z2vVqiyoHhajwwzDyt0pnqGQJPBcZj/7BT4h6RCRlSuv+ylWc/ra8x6caw6b/rUR36
         ZSIB3YQhckYFm8SYEo473Y8TWoA8GLDKQ0NTFU35/kXshSMAOzHR5Opr7cFmNtbL9aXC
         mW94RLay4rYzMNBCftU99WOpuqjg1gTP7echJCcFi9RWWIBhGVtvin+cMJwjy+uTi7ii
         bCmb26SFyFpe19DnbPjeULs7AtGHk/G9bNzGsnzb+C23f3kyzkZumm37E5k7UojAS9M3
         aiIB1fUJasTzXLNA9y/CSsp13C1KIpjC4XWELxF87yQHXoOvJGfTDyP4ESUEtw6F6JI8
         5AeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771331422; x=1771936222;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fXjw2GmP4lQdAtjniPE9MY2CqejpG7o6YmHO6qB4zSQ=;
        b=IJJZI7Meg7JchwSF+IldXt0W1N8xvJXt4PvKsfEvYrjRAEGOkMv3/RHlH7218jRJay
         7NF9MSaRYGlHLtZ1G74rn2Djr3+soR/iCx2gHUE8GJ7SxtcB/1YOifqym2x4xTNsyOQx
         gxgal4uVW/OYvXHOt1CyS2wwWmU9ThR1Z9hbFnxhVd7KjlBSu1SYPc09C1Sb0Gv71ENX
         7epZbI6r89IiQXjliPTr3eCpG42G1YOADHk9q1phdINyp4j3vo31flWpDTNdrr25BBU+
         TshiddbNGZMfYLGZYJglpb2bmwWsqazHVA3IOncIWcAL8ILvt8geDN6a/AEncxwd7XYE
         xehA==
X-Gm-Message-State: AOJu0YyS0/qBH1jzPRtv9Gx0nxEVBGBs3BR3/Aa4Fba//NcExU7CLEda
	OoRbp3esEOz+Kqdm/B5TZ3YuMwbELyDBhvIwKQ+ESZqpHMM1lfCDDx0h0nwkEaRIg9ltb8TACW3
	89g9VvzDUIPQQqfzC7BuYTtdeqabNiQR51FY/10Z/Q9y5ufFLERhNo8XmCScvXg==
X-Gm-Gg: AZuq6aIasFe1t2egPANLtq/CvtZ+Mu2O6/iZ34YYwKfYfVO9p1TSVahFmrYvX5RZIAH
	yxr4NNFG2Gt7U5gdjK6+uu0g5dGLD5t0DgJOcU3j78i121vZ93qqjhgpkKwwG4W+CUPi/qwXwgA
	yBOElKyZx1Q7QAUEaG7jNOEsBRWOcGLGMAT+9G7/c7uda0LMlfGhyh6b6vwVnFcFFGPbkbi6dhI
	bZvunq9qw11sgCvMihtq+gJ3eyk92mp+fhe/qspdobOBuJS1J7WoCvsvbVP4Gk0/VaMZWJJ17QD
	g+mpu3Mq9BsXBVjXFHdMJe+OjR6KQRYoF4CBSGu5Ih0sV707SD9sgsbOi+CSFp1+vay52t8svyr
	3n7ClG5rFUyKfc0b/iqktMleoU7e9XTfde1vSxym5qDoZAovxOmQGcY0LNaqIdlnTR0r2bgEOo+
	NCEX8=
X-Received: by 2002:a05:6214:4f03:b0:896:f9ed:be98 with SMTP id 6a1803df08f44-897347ce6f2mr139048286d6.5.1771331422405;
        Tue, 17 Feb 2026 04:30:22 -0800 (PST)
X-Received: by 2002:a05:6214:4f03:b0:896:f9ed:be98 with SMTP id 6a1803df08f44-897347ce6f2mr139047476d6.5.1771331421773;
        Tue, 17 Feb 2026 04:30:21 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc735d66esm336267166b.4.2026.02.17.04.30.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 04:30:21 -0800 (PST)
Message-ID: <253ca948-07cd-4ded-8e15-619589f2d314@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 13:30:19 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: monaco-pmics: Add PON power key
 and reset inputs
To: Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-input@vger.kernel.org
References: <20260209-add_pwrkey_and_resin-v2-0-f944d87b9a93@oss.qualcomm.com>
 <20260209-add_pwrkey_and_resin-v2-3-f944d87b9a93@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260209-add_pwrkey_and_resin-v2-3-f944d87b9a93@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDEwMyBTYWx0ZWRfXxy8QwVyAEyKS
 u/q2PIlRhU+VGMEugRC5TBm6pC5F4xLidcIfOGUnpatl1LhQnlsNcyK7OTNidRuNuhFAA3Ke2Jj
 piCUzHn8Q2+JB0BtGnAHL12OxxosCNP8teIgsG7P462kn4gqS2/YJPH+Qo6eAa3IySD9FD7xVVD
 5Wr4hTxcL+pd0K1cgOWdZWCBhpEGJk+v2Co91KKHxTbOhj8MdZ6IcuU9I8xmor2XVIMJbhA+hjO
 jeCZ1DY1eW8h5tAiGNVrkSajd9c+gtXVPIYLQjWAggbUwqdAenON1c6bZ72Tzb9yOjsjWd+zFf9
 jferlxOAkWTFIZ34fKtb8Nmu63nQ+TFEsYhGLSJD5rRWRWbQTVXltwwfoVqmwJ8TQOIi/C3eK1U
 P9rkhSAK12qy2J8W4PdjYjS6LtijgCtDNGxuBNs18+uN6SGlEgeiGoRkzxwED3U5UX7WbeyZ2Bx
 DTr7Wz9oOeoLzGg7L+Q==
X-Proofpoint-ORIG-GUID: 2sWaCY4WHD--kIGeMfrj4Aeo4z2s47O6
X-Authority-Analysis: v=2.4 cv=BryQAIX5 c=1 sm=1 tr=0 ts=69945f5f cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=1fdw4J3Q9qDLbzPSb8EA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: 2sWaCY4WHD--kIGeMfrj4Aeo4z2s47O6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 clxscore=1015 adultscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170103
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42740-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmail.com,sonymobile.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,0.0.4.176:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AE53414BF99
X-Rspamd-Action: no action

On 2/9/26 2:23 PM, Rakesh Kota wrote:
> Add the Power On (PON) peripheral with power key and reset input
> support for the PMM8654AU PMIC on Monaco platforms.
> 
> Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/monaco-pmics.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/monaco-pmics.dtsi b/arch/arm64/boot/dts/qcom/monaco-pmics.dtsi
> index e990d7367719beaa9e0cea87d9c183ae18c3ebc8..182c2339bb11af40275050a36c4688227e89497a 100644
> --- a/arch/arm64/boot/dts/qcom/monaco-pmics.dtsi
> +++ b/arch/arm64/boot/dts/qcom/monaco-pmics.dtsi
> @@ -13,6 +13,26 @@ pmm8620au_0: pmic@0 {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> +		pmm8654au_0_pon: pon@1200 {
> +			compatible = "qcom,pmm8654au-pon", "qcom,pmk8350-pon";
> +			reg = <0x1200>, <0x800>;
> +			reg-names = "hlos", "pbs";
> +
> +			pmm8654au_0_pon_pwrkey: pwrkey {
> +				compatible = "qcom,pmm8654au-pwrkey", "qcom,pmk8350-pwrkey";
> +				interrupts-extended = <&spmi_bus 0x0 0x12 0x7 IRQ_TYPE_EDGE_BOTH>;
> +				linux,code = <KEY_POWER>;
> +				debounce = <15625>;
> +			};
> +
> +			pmm8654au_0_pon_resin: resin {
> +				compatible = "qcom,pmm8654au-resin", "qcom,pmk8350-resin";
> +				interrupts-extended = <&spmi_bus 0x0 0x12 0x6 IRQ_TYPE_EDGE_BOTH>;
> +				linux,code = <KEY_VOLUMEDOWN>;
> +				debounce = <15625>;

FWIW we tend to disable RESIN by default, as it's not as ubiquitous as
the power key and only assign the keycode in board DT, since it may
commonly be reused for either of the volume keys (or something else
entirely)

Konrad

