Return-Path: <linux-pm+bounces-42924-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gP7aAOwwmGkzCQMAu9opvQ
	(envelope-from <linux-pm+bounces-42924-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 11:01:16 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF29B16692D
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 11:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68E4C303DD72
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 10:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3668F3370EA;
	Fri, 20 Feb 2026 10:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j9+1vcW9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S67XPS8I"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0087A329E4B
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 10:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771581653; cv=none; b=hMYotu1KIVieEb2CpTRqCu60M0Oxd5k4G0Qzx0nJZlvRg/Scwt9xGJA77mYncMSrj3/Zo2dNry/pbwAp8lVSZW9IUc03ABn4iSpJcuNDdO9NFOK6Plhv/dUG0s7S7NXSvlS2lzRCWK/MaprAcKr5WU0hxNm/WYnrWpvbVJon1RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771581653; c=relaxed/simple;
	bh=ALv+Y4MazO7kBQC/n25Bvu/WdhV9xJoS4dScH4XjcXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l+0Oe3yWqjIawXVoy/FCsAzK5WqWsAo8TNbbGuXIEguJ0Kd/Qnq/NroFcNJLn05nJADsBxONdp8tIhDTanMCqT8Y4VVea5EY8Kl2mUK31F5hTJZ07WJCJNa7Tj1SYOm/MmqBSZn3KIobiHvc7gv/Q0YuW48s7+agzsolw39JAsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j9+1vcW9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S67XPS8I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61K5RpMU3154710
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 10:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ddo+U4gF3xTQh78RUVFL3FgkhoVPcyhxFLNelU0/ITw=; b=j9+1vcW9GTqa1ay/
	BXhTEz6glwDILfEnCfWUGItTE1+SXCH8rLdVzkirf713jCD35xCTM5xG1od6XcjY
	QOP6grijJG2smmA0QmKzlARJDTRjNKAwPpzUjqKoyqW3ChiDFizLjCNt65hlgrKG
	6XRJnQaO7UeYK679pTA9/qrIbIbP+gIxoiRyyxP7zvxLF387ia0Vvdanv0FufmMo
	WkIi3d1HgYroHZdXpfGHL6jLYy8whGtwQFUZ9TxxoFAbMo23GcxDfY/KChUjYNCU
	7ytuSLny5E/Umy2N2ieBusd5+saPSWeFOzBgTnsqP8Hjb/fPVw0Ji6tdYK2KM9q2
	Sul2cw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ceh7bgn1c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 10:00:50 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb38a5dc3cso187209185a.3
        for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 02:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771581648; x=1772186448; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ddo+U4gF3xTQh78RUVFL3FgkhoVPcyhxFLNelU0/ITw=;
        b=S67XPS8I104hm+O+CmKQ6nhxIYHmOQ+/yZ35aNLvx9Q4KeW2L8f4wpf02xzhtb0nkr
         36zAYNcXXSq2SMS/HRvBA2RulCct/dFaDZeTCc7h1NudJ6f2ia1eTuE+5FgrN6MMwrtC
         csyTfYp8F48FMUKiDNxT53NQ7zUgdzp7zhUoqWwGf0aRAP/FVOgOplBFaODA5ebFCOKi
         prLvUnChxiJxXTFATLNjtqUnnciok5jRV8x8FAmSwB4jGnET31g0YG18rbbp7lUNOJ9J
         BJHsTzv5V9G/6MF9A+V/lxALIVVRPR3WEdmsoeWA97/j6diJ2sws8INjPpQh28RODHp7
         ZU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771581648; x=1772186448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ddo+U4gF3xTQh78RUVFL3FgkhoVPcyhxFLNelU0/ITw=;
        b=cm9tZOn2PfvyLL3iQ9dHKvG0R3p4lCP+Yf+pN4/yHAyzF5rz39iTtDwY2WYmAqYN8o
         5DxnFofjq7kp6XxtF7fJIp/05WDdWBa6jSVzwpCSSTjqhF/Q8r2egGapBi9t9d+/yGdK
         hA5YQbIO+NVg6/u0iHYvZQsJR5qZbvzepDN7Gny6GAaVRy5sLuOWjqw8wMI3EUjZhLs4
         NnGb89v4/JTDbWsCoSBh2mCsrmm2Jqi0QtGK6ig1HIWPao0csMOlHrUR6EN79YuYFGIV
         7+i4bbrshLHYaNCvXBtnVWHc6JRJ6zbi59+lZi8JoA9PiBJCCpDrYF0SKzYYr294HWye
         5biA==
X-Forwarded-Encrypted: i=1; AJvYcCW4j6wu3Xbrk28Ia+9zM7GDklaByBCou6Gtuv76NjVuflmUYjML1vCB2McHao3X09XRJ6kXYj+hWg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0cCqOAUDkbaSeD7jdqH7EvDtT59mQGeuNRSBEVpVJcOqdz9OH
	7jPwL3BYckVQ3//GWNFwPzTRn20zeXS9fiTTJZzXIwvhKfkR9N4LuSJMBVjQuJhf2dX0mKHdDut
	Wt8sDv2sQboGbR4DSPsyxSy0fpwVHp6fzHUy62AhsaEsEKaZZegbDcC0uVLqwLA==
X-Gm-Gg: AZuq6aLH0sSsH9fjO5s1ag5FqcepJnGfCRktD9JfNtzVqJjVfLxn1LTuwQ7Yd0CaAHA
	iZiXp1zAY0QcRe1/Yv8eDSHi+rvqFbaSMG4CFBsjLrQswDieSQD4AjG0ACQ8kUj1nQaEKFXoOon
	pK4r/4eJ0kaj+3W/PAdA9rQnTy/kQ9IAROzgkODpF+WjgqY6bSOqb50LFWhiNe9W2xtE3/R5mRh
	LVFw5dpCEsfljhZdtnpPH6oVLFQZsFSwq0+0c2Q67LU+50M/wGy57Ab81zC2QeRcYm5TDP3xINw
	uMLrVjMwcPo17jG0f/IK9Zir+Xi6D8kmOE2O84mhahwNOv8Rh4INRN1eaRpso09szwz9R2/DwHA
	4FwpD5g0c1+RoyWfWjUoW9h008pE0TeXO6WXZmZCldalfCahsoURiMrDLIVCKMSlw1gntfXUCxO
	mkx+I=
X-Received: by 2002:a05:620a:4809:b0:8cb:1c69:b7e9 with SMTP id af79cd13be357-8cb40869db3mr2446729285a.5.1771581647681;
        Fri, 20 Feb 2026 02:00:47 -0800 (PST)
X-Received: by 2002:a05:620a:4809:b0:8cb:1c69:b7e9 with SMTP id af79cd13be357-8cb40869db3mr2446721985a.5.1771581647140;
        Fri, 20 Feb 2026 02:00:47 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc735e579sm667828666b.9.2026.02.20.02.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Feb 2026 02:00:46 -0800 (PST)
Message-ID: <85ce1f2c-f5cf-4e97-9611-4aed03f69cd7@oss.qualcomm.com>
Date: Fri, 20 Feb 2026 11:00:41 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] arm64: dts: qcom: sm7225-fairphone-fp4: Add
 battery temperature node
To: Luca Weiss <luca.weiss@fairphone.com>,
        Jonathan Cameron
 <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Hans de Goede <hansg@kernel.org>, Jens Reidel <adrian@mainlining.org>,
        Casey Connolly <casey.connolly@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20260220-bat-temp-adc-v2-0-fe34ed4ea851@fairphone.com>
 <20260220-bat-temp-adc-v2-5-fe34ed4ea851@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260220-bat-temp-adc-v2-5-fe34ed4ea851@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Voguwu2n c=1 sm=1 tr=0 ts=699830d2 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=6H0WHjuAAAAA:8 a=8l1bqfnc6EbWCU14WoQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: sj0inRLRvndPIV1hZFxhXcFjg_HaLSBU
X-Proofpoint-GUID: sj0inRLRvndPIV1hZFxhXcFjg_HaLSBU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDA4NiBTYWx0ZWRfX0fwtpzQewVkR
 b46bNiusU4xp0V5U4LGhCNJtRzgVp+BVn+MttOAidU200/TYQjrz8t6s5gke0LJw9Gaw5O2iryp
 PmVS/JMdgOITCpv1Lp8jUx/lnijDksWlmrqmVH9DN/aQP0quTmph2VT0hOJwzZnVY8RAlBMdmr5
 cqXyhv3Qwb96WA04YobTD2WATaHRxftP9H8A1hovmuz1qaedgfnOAmw80NC1E6ztBVR2P8X+DUw
 svGPfCTi4mQDgGLgtuhr6MNUpucy/WHMAhMu50JYbefdOVbDqUqbYMqJ7xaGOWNVkGVUbO9Y4Ob
 UAB+o9AoPxH/EKCR97GTkHksu3m6IxCbK7fmR8Obh86Vyc3/NABnaaqhMa9lE3UBlDc9CEQ/Xnf
 L5EbBNn3leVnvTH4nff7JXxlM3R8odiW7Ui4RETLH7DYH69DU5L1Kzwh8oarS7pvzk3yESRLhjB
 zZ8AHLdA/9Kq9IJdQ4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_01,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602200086
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42924-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fairphone.com:email,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BF29B16692D
X-Rspamd-Action: no action

On 2/20/26 10:19 AM, Luca Weiss wrote:
> Add a generic-adc-thermal node to convert the voltage read by the
> battery temperature ADC into degree Celsius using the provided lookup
> table.
> 
> This will later be used as input for the fuel gauge node (QGauge on the
> PM7250B).
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts | 83 +++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> index b697051a0aaa..7857003099a6 100644
> --- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> +++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> @@ -108,6 +108,89 @@ rear_cam_sensor: thermal-sensor-rear-cam {
>  		io-channel-names = "sensor-channel";
>  	};
>  
> +	bat_therm_sensor: thermal-sensor-bat-therm {

nit: this should be a little higher

> +		compatible = "generic-adc-thermal";
> +		#thermal-sensor-cells = <0>;
> +		#io-channel-cells = <0>;
> +		io-channels = <&pm7250b_adc ADC5_BAT_THERM_30K_PU>;
> +		io-channel-names = "sensor-channel";
> +		/*
> +		 * Voltage to temperature table for 10kΩ (B=3435K) NTC with a
> +		 * 1.875V reference and 30kΩ pull-up.
> +		 */

I think this looks good. Is this data going to be correct for all/most
devices (i.e. is there a single battery sku)?

Konrad

