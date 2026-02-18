Return-Path: <linux-pm+bounces-42820-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCfxFr/4lWlMXgIAu9opvQ
	(envelope-from <linux-pm+bounces-42820-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 18:37:03 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C97471585AD
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 18:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BEA5A3017BDC
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 17:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295D6345CB2;
	Wed, 18 Feb 2026 17:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ebyJ+cyu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SDw6EuJw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DF7334C09
	for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 17:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771436200; cv=none; b=Z5W7u9ft41KM/aB/5JXgEQlpschocg1ejyR3I/3VT/jHdcmJfAdMPkg2Zv1aSGA8WOuUBYQzSFNmKTW5oh7bYh3GBW1a8CVYUBD4lVM6uhobzny0Cj64AP7zHaIVFtC74qb44A2/NcvQontT+0svHBSYfUE+Eo7CBan3K0MYjGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771436200; c=relaxed/simple;
	bh=K/xPo6jErXDjS2H6F35+o+2GzhJpN5QOZaOO3Mw6si0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NLbMBm8Q14vth1n8H+LlY+jIOwZVgWrgxrxeDy4MUfFwPDimptTCrZ2saNu2dynGQ3+dviiXeLk3c/K4TautPgLaMTjsoeSyzhg1Knm0xNXgwFcXK5QAIqCqbFC3PPnsAhx3sJr2axvLKnvSKbmE6BoXbJfhAO1xvhWgsVD4W6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ebyJ+cyu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SDw6EuJw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61IAeqjU420080
	for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 17:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gUA9mV8Pw/RXrdZSMzzTtbtHdDf7o9LoUEjvzb8m0xc=; b=ebyJ+cyu0GZe3Jc7
	1F4LM1EtL3A/DC5QPdV9fuV+cstPB8h8WZkLA4haScXVUYuW6p20WuVZmwUkuIwm
	EiUgl6xx4iPLaLG0Fm0NWnNLrjvUe3vr4+PR9U9+xj0vrrkqKX73ZrpjC4SVSYWq
	wv0aEw1JJGU/af5FtB7AZXmgRezOvaviuWhQ0E4ayLb/MXKBaZlfSQ3/Mfd2P8Qu
	AKGbmCoi1kI4TaHpjaVBE9QeeAytWCB5Y7WcmwgOSWsJ+bkEVfMAtmfSvh6x3qd4
	vMurlirFDVSUK4p9QJguvi4r27tB+DU/dSbI90VPZjCoVuk2NIWleSSfcvO+EZE0
	m7lXkQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cd0k5ju9a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 17:36:37 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c6b1b22b134so5332a12.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 09:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771436196; x=1772040996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gUA9mV8Pw/RXrdZSMzzTtbtHdDf7o9LoUEjvzb8m0xc=;
        b=SDw6EuJwAR/Srdr4zLfbntjdAt5eFWR+vE8HJcYCQVIYJWPj7Lv6qBNU8JmFXsSBdr
         vX022PM99GUmTd5eaGZwDm30lijijroTslOV47EUTOTOa1YQIniGRBALMWgA24cPyn3M
         NQr3xM8KpGg+NiL7FBE1caRwtg0cHGoVmw6pZ3lPPsXJTO0enmdLUqYjLpfpDTiat2Zf
         XTSs1fdra88dgPffWWm7381EKquTH6LtlfyuDHZSrsXtakI+oZiqVQnNuqRRiBCgZEM+
         32dyiEVU5ygBFBrCON1dJhj1hEUj/ykNm04htBhwGvlvJQhLHLtuOaVMhOQi/us4zRs4
         NsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771436196; x=1772040996;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gUA9mV8Pw/RXrdZSMzzTtbtHdDf7o9LoUEjvzb8m0xc=;
        b=xHte8qOIDAKYFEIyME1xby/Jg8tyPwXcbO0SoghnWNn1OkXjoEW4tgBRE6hhgGDT7a
         TLTUXYML2hGC6uKg6yxz+rruc5hkWkWCIZUfRJLz2zDZLCbDNtj3iMxw/PfmgLgYjTSW
         dbBnw50HP/lt0T2PpbISolhdQO+P9MPzjdXyBGDubQ9gLYBM+TiO5pAq6G4x5ubSh5pt
         W1hjaWIsjKliDi/K3EpOhczvzU5+Z3HJFPYLFAUnc+/NMsyQJ0Jtlz1M5tmPuvVEpU2x
         Do3gETUa/wH+onVpDqlkzjdS+XL84iA30cK+ISHM9VnKQLHluCwoYX+FmDVeGPA7oDZx
         0ksQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsAzELYlVpViKDS60MdODRpJR3taOTBAPMuZLKFc+oJvBj/jQSRbz9+Hvxw4ZkbdA/GxFgDKaxnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgyalVNvv7f9HSQWiCSXXQCRCM6+/8codM3J1MW5hdzlXAi+8l
	mV3aPXzxXT8eRpWl6gQ53woQRDV8GylN6/yy0vY1AbMcpkXW6+hYoikcIVCRT36F/K0pX57ISbn
	jlj+dEKq/Cvmhub89AIhLP37FN2Ybkh578MjKsaFzX3OPhmvC74V/vhi/kqLb7w==
X-Gm-Gg: AZuq6aL4gSiGzF9+yQbLZEnj4h1YzuIQTCKrltKjI8+nF33CfOtkH6KTRwkNeT8958m
	oB0AzvkxVHGGbwp6s00tk0qx59tmCA2QqDRTKi0e5QvQayLGCSfOkA2OnClgNp6Q8r9NwYoktyz
	DBBIhkUywbrW1zV3EUeAi7eTGKBVFmK3JquHyYBA92AElHclSE3vx7m48w6N4bcDG95mSqvlwed
	sNF/HbpsVvNCgL5bq/MsMPdl97Z5O340SO5DOULSN2Zlm0V+I0Py7LPtxizyQnSaGMN9MeEJfd6
	VflXKEcKTxmSCwoHjEtTcJ652IMtpFGyB/8oE8D9Mxyn68nLappFeuypdP9Pf3y/Jxjf1NS5Rtz
	L2M5OnhWaHCltzrW7rArsWSJtAp9w2KHq+gsd1+O3RFrfmEVcvQ==
X-Received: by 2002:a05:6a00:8005:b0:81e:81fb:b392 with SMTP id d2e1a72fcca58-82527489002mr2108291b3a.11.1771436196057;
        Wed, 18 Feb 2026 09:36:36 -0800 (PST)
X-Received: by 2002:a05:6a00:8005:b0:81e:81fb:b392 with SMTP id d2e1a72fcca58-82527489002mr2108277b3a.11.1771436195547;
        Wed, 18 Feb 2026 09:36:35 -0800 (PST)
Received: from [192.168.0.195] ([49.204.28.145])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a431fesm17953696b3a.20.2026.02.18.09.36.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 09:36:35 -0800 (PST)
Message-ID: <da3d08c0-b433-4b42-8f7c-fea9288be9bd@oss.qualcomm.com>
Date: Wed, 18 Feb 2026 23:06:30 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: interconnect: qcom,glymur-rpmh:
 De-acronymize SoC name
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260217130035.281752-3-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <20260217130035.281752-3-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=JqX8bc4C c=1 sm=1 tr=0 ts=6995f8a5 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IXbkkVN8uJs8XsqYossUiQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=qt33lqOf0HS-XDKnBJoA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: FFBYWW1NRvRTXwHhVXgR79w_Rp9pAOCu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDE1MCBTYWx0ZWRfX7q2umE0Vz2tw
 UsRGKqL0qU6d5vmAmZ1LQ9Tc7kzO/DnGil2zUZ7B8aKrfR2ORiP1dEma5NIR76Wn+amfJwHxbDp
 b744f7GdkWHg+hhTVXn+56O6sC7SssMArNtGvSWPC/YH7Pv/VpxGH0sz9s5H+X5MuPp+ck8PUaL
 9DplJ5Os8aK1kFGjbBmdIep5sgHxfr8FvgEqPuUyiS6pHV4vMDEvFRe5gR4O7eL8v8ZL/lCtQ9f
 ydnYHFIMyiClCFRSCE8hopKPrUf97CIG8FRE1HPdLkWie86+O1sXoT/CQDNdepc60eDLnGXnyu1
 +hk2KMHjc79SzJYkn4vqfKGmfad7B7y/MchX1vOS5/j18HkOGrBJj4ito0ki6kzgAVgm5BbFHWt
 Psm1NF6HJkCuESZ2yATmxh6HOOgj0nanvPkSJIu3j+IPpw0lxkQrKLTQphfUThOu+Mlb7CTnkro
 cNnhlKC+h1DUZmTMmsA==
X-Proofpoint-ORIG-GUID: FFBYWW1NRvRTXwHhVXgR79w_Rp9pAOCu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_03,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1011
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180150
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,devicetree.org:url,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42820-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	FROM_NEQ_ENVFROM(0.00)[taniya.das@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C97471585AD
X-Rspamd-Action: no action



On 2/17/2026 6:30 PM, Krzysztof Kozlowski wrote:
> Glymur is a codename of Qualcomm SoC, not an acronym.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> ---
> 
> Changes in v2:
> Split from previous patchset, because I messed up commands and combined
> wrong patches together.
> ---
>  .../devicetree/bindings/interconnect/qcom,glymur-rpmh.yaml      | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,glymur-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,glymur-rpmh.yaml
> index d55a7bcf5591..65b0ff2b2c85 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,glymur-rpmh.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,glymur-rpmh.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/interconnect/qcom,glymur-rpmh.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Qualcomm RPMh Network-On-Chip Interconnect on GLYMUR
> +title: Qualcomm RPMh Network-On-Chip Interconnect on Glymur SoC
>  
>  maintainers:
>    - Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>


Reviewed-by: Taniya Das <taniya.das@oss.qualcomm.com>

-- 
Thanks,
Taniya Das


