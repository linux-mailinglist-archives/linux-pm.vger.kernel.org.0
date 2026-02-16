Return-Path: <linux-pm+bounces-42696-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id rwp7MxgTk2nD1QEAu9opvQ
	(envelope-from <linux-pm+bounces-42696-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 13:52:40 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F1C14374A
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 13:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28D273009015
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 12:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A7E23B63F;
	Mon, 16 Feb 2026 12:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o6KRUoL5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XbqLiaQx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D3386347
	for <linux-pm@vger.kernel.org>; Mon, 16 Feb 2026 12:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771246358; cv=none; b=kgnHGWLNESK3MOO7QFF5WjspvEK6w7rgemg9HV8QyetIxOA6fBkGf7HqWLX4ZTzn2BNCmyghcnwwBX2vXgZDcnBVIT1uJTQh0siEnbTdZ+GkZ4a16hy2pgC6juAhyJ0k1nAY3oB8qiR6VizyLnrMXxcjUM5IIrHNnO2l1gk29pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771246358; c=relaxed/simple;
	bh=yAQOVm4CsLGoOpTthNQtptFK+zOUObZvtTSs9udM+ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dI33T3Y3LXrJzyWrGFED3EoIOVUTEIn2kNTiUDekkKh2oVdpgl1uEKV/G39qtV8SSAbAxgAqY7kn8PHWqe/hvzELSWI63IoJKaekxGLlZzGjgV0vDTAGVNtMdg3kKA+RdltKOaG0FmKn5JF7b/8qXs6vAEztclzILP4VRl5fjN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o6KRUoL5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XbqLiaQx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GBJd6w2307173
	for <linux-pm@vger.kernel.org>; Mon, 16 Feb 2026 12:52:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mFOemXEfU4qyefImBX8oJkJp/1pm3QQzq9FUO8gvu7U=; b=o6KRUoL5/r1P3gR/
	PGLe4q84lTbQ0BYk350EBsTmi3l+r+Thyvc7nlI1wYWaCuJVz4ctrI3RYotUfa3v
	3bFM+/rJZSRQ2aX1uTWu3usvqyiUbPbjn7thXVya9orc8q1iJew+MP5eomj7szu7
	Jdr89qXl9k2ZxdOuj8/k6Of4rzWt4fSVt6Ok2B4MDIR5YhBRh0C1HEiLA4ZY6Fwd
	EY2CjfI+6Ovq/jSPOyC2aMNcNbfkzxx0vQroCfl5Q90LtGrwBZTOCuW88rfwIOrK
	GiJ2s+3diFIDnq7rt1V7908H1t7XEJjz1upIO892nuoqdm420nvDR0vWO6Uz4hP/
	tiWzlg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cagcf4m1v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Feb 2026 12:52:35 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50340abfc02so18782141cf.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Feb 2026 04:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771246355; x=1771851155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mFOemXEfU4qyefImBX8oJkJp/1pm3QQzq9FUO8gvu7U=;
        b=XbqLiaQx5p8ajSCTim+runi6Rd6oywMDEwdiiBRtUG+sI/KAtbF3JkcfpcH/B26kSl
         EPnFH4vsT+MZECzLWuS1nfkJMlBlcl9q/kQuWPxH8Q6wmxqmrEQKCf9i9vXmCr6WLHaa
         RhYhFW01iuRY1AijVsCvg4Y8sWcN+Pk7th9MReaWTJ74i5Py7W1QBmY0oNnPOcbfy9Sk
         D3H1UndqdVMz46h18OyoPKZvlbVT7L9014XNhG0CCaYLd0s7Rp0BPU+Yl0JQIG5Oz8pw
         jO7+a0A4x3U9xV9JZWf/N45gaeUVMyhCkVUj8AyFDpuje+u5a7FHdzIveujY+E+cd/WV
         MSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771246355; x=1771851155;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFOemXEfU4qyefImBX8oJkJp/1pm3QQzq9FUO8gvu7U=;
        b=mdqlontwSBaVV+7VUBvNyItRiHQbUJuiUmaqtnJD/QddtqG36Fs8yQMLf6JrRBss8y
         6iZr7R+1PxvCooNcwwsaNULo5MUww3sUoD+6s4J9I/7dBPPxiZSTGnTCzaad7u5mzqaT
         XjCVpjJ5w3ImME3abFFMX5PG6d5suxtkS8Iv1cvcrW9zhtR+hH3d6U2ue+dWhyTqCHeo
         EtFt781CdJ09QR2zW3FsRw5nkKAZFFzvw0138T5qto+rH6pkPWXHoVADN06MqM/WHLXW
         0lBO1zCPuAhaEw8xtY3HMc2MjAEMs3k6+BuqvdFubHtVQVqEm/ENRu69eUq/wsLlrhG5
         2miw==
X-Forwarded-Encrypted: i=1; AJvYcCUZbbnJaBmtNN3ZQcQiL+Os2wUO2YhqBCee4fvYow/8y+hMBXn8Lo5fetpx53z+9n9jZIpYhNLPCw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWMCccplu03gY2fkaABLpRHxXll+TqZeS4HjLCXBhJ5mUA/Of7
	5a3S3C1TEHFCGLvsWaUz20EzFbRtzcMNS6syclnczadPcfbEpwUXD2IvpuyRkKB5zSRopi5v3Q4
	7vAheEr+LPB1AUB1lB7jcMDe/xKteTtNL1f5mVXjKLDZLOLTkNxlddf/D/ATuWw==
X-Gm-Gg: AZuq6aL5T8gbbtKgHChzfFizSEAXQIBQ8v7h2Gvh3qCXPN+xRlO3+ACEd7RoJReeTjq
	WDSg+Z+zl7t7HMXj/cH5SEaY1++r/9QYf+YH+pWD70nNobt1SFV5MnKceplgRLfN2P2xsu+tynj
	0qApTdOmJtzxCazTfr2EFKpffdy7Vl0qgjHVWXqKaHcgxyile+po97TeYXiw9HryYXoqOrYNQ+h
	RiP3C9xvlIT3uqGviH36t5kb4FaZGFKAfVXqdNSlSRSwaFKMGloHg5t2xBWGCkmwPZlqGletN4c
	oholIAUL+RbfjPPZ293dRjADPyNkFSwrRtmPKRdWy2ar9DdWlYB8RDL7qigMAZtTjAmoztRb8t1
	8QhWhKbgIpgTv9Dpa0riH9BkfYjDgzTzUa9QbydyNMYfatJn17cagOO6cYwsxoDhSEpVinV/uWc
	YG0Pk=
X-Received: by 2002:a05:622a:148e:b0:501:4ba0:e06a with SMTP id d75a77b69052e-506a6a8ad5amr112911751cf.8.1771246355305;
        Mon, 16 Feb 2026 04:52:35 -0800 (PST)
X-Received: by 2002:a05:622a:148e:b0:501:4ba0:e06a with SMTP id d75a77b69052e-506a6a8ad5amr112911481cf.8.1771246354796;
        Mon, 16 Feb 2026 04:52:34 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65bad3e356asm1849577a12.16.2026.02.16.04.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 04:52:33 -0800 (PST)
Message-ID: <dcbe3388-a074-46ac-930c-e7c143f47513@oss.qualcomm.com>
Date: Mon, 16 Feb 2026 13:52:30 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sdm670: add thermal zones
To: Richard Acayan <mailingradian@gmail.com>,
        Amit Kucheria
 <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
References: <20260210021607.12576-1-mailingradian@gmail.com>
 <20260210021607.12576-3-mailingradian@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260210021607.12576-3-mailingradian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: IQmFQAO4mo_8pc_SljdaaDMzjB58GiNf
X-Proofpoint-ORIG-GUID: IQmFQAO4mo_8pc_SljdaaDMzjB58GiNf
X-Authority-Analysis: v=2.4 cv=Sc76t/Ru c=1 sm=1 tr=0 ts=69931313 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=pGLkceISAAAA:8 a=kiNorpxd_LLC9_ghbWkA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDEwOSBTYWx0ZWRfX5npF2gZUAkQB
 Ig0lBoLmvugyVsFcmINZ4adSA3u7T5AVTbWpTTkUV3jLKMiDgc00X3o3cO299g5VPNBXH7d3r2j
 vtiYOcQne6xKg0d4MSdGxIEKlo0IY4Ic52ItMQ63SGEo4IYJv8gTF/BEu4ni9BnfsJ5t019SB5D
 zvl4tLz1aotULtWw//AVps6cUVyqQ+1rfdT6Ci45YV3hsSyyF5TPdmQRhV8SYZWvgW/fVTx2CEo
 ge+39kEmLvghCLKh4ASll2XdKlApm5JC39rCrloShqvb98nLm6LTEU+Scxgx2sH2BWhWgztFjlX
 aJDWB20FokoEF6mS0eCWEW8q3t1eMkjTwn/snuZCHs0KxoEiKL41JQkpJ9ZFsFfEUK+JhdXWJH6
 ACQCbFciINb7TVUKKmHlNQqNbZGJoJ3hKhWx7pKbaNgFujz9PBv5LUahkd74rryFqncgFCAY+S9
 dFOh9nh89iTixS0E9bg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_04,2026-02-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160109
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42696-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,linaro.org,intel.com,arm.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.0:email];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 40F1C14374A
X-Rspamd-Action: no action

On 2/10/26 3:16 AM, Richard Acayan wrote:
> Add thermal zones to safeguard from overheating to high temperatures.
> The temperatures are very high, but should still be safeguard for
> devices that do not specify their own thermal zones.
> 
> For some zones, do not include untested cooling devices (although the
> GPU is untested).
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/sdm670.dtsi | 558 +++++++++++++++++++++++++++
>  1 file changed, 558 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm670.dtsi b/arch/arm64/boot/dts/qcom/sdm670.dtsi
> index b8a8dcbdfbe3..70f8a0a0aff4 100644
> --- a/arch/arm64/boot/dts/qcom/sdm670.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm670.dtsi
> @@ -20,6 +20,7 @@
>  #include <dt-bindings/phy/phy-qcom-qusb2.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +#include <dt-bindings/thermal/thermal.h>
>  
>  / {
>  	interrupt-parent = <&intc>;
> @@ -62,6 +63,7 @@ cpu0: cpu@0 {
>  					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
>  			power-domains = <&cpu_pd0>;
>  			power-domain-names = "psci";
> +			#cooling-cells = <2>;

This hunk is useful

[...]

> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu0_alert0>;
> +					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};

This, as Dmitry said, shouldn't really be

And apart from that, I can confirm the sensor mappings are correct

Konrad

