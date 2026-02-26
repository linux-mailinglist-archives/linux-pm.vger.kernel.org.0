Return-Path: <linux-pm+bounces-43237-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uD9zHE8QoGnbfQQAu9opvQ
	(envelope-from <linux-pm+bounces-43237-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 10:20:15 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E911A3467
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 10:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 562B83044DD8
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 09:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9D239B4A5;
	Thu, 26 Feb 2026 09:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AS8rrut2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Nl3BMdDM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3C23A0E86
	for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 09:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772097448; cv=none; b=SxCr67/WmHHtyrGVb7ZJW6RiBQeMROjRVSxAvPniokjwfh0FvLwA07xbYBGnyabs5qImfx+Otur/I6JfVv36HBEfzOeO0tI8YEqSucL8e/ifnY0CvgxaLNARkB3H23j1Gy7VuOGDoWoyCx062Inm6Lz4NTRMrKx+PXxVk12xcjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772097448; c=relaxed/simple;
	bh=z5l36k9MMFmzkzQz4i6ScUMs2z9EwOb5JAqnuGLw63M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uYNgFEdhUdwD61IgqjUjeDeWvvuGeIcMtxf5wxSPn8YDZKyLqRVrX/+spa5d0FVK3wpNjOPNJwb96RjHl9/Z4BE/WaUSG8jiVEw4Ps9DCeNZQktPYPnkmivLkH748mtp/82WYAFiiML69mMS84HIJZc3lZilLPt1v9y4WmujuIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AS8rrut2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Nl3BMdDM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q4VWX53721997
	for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 09:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mNpS69bTLdqyNkegk7W5G8tjQ+f6+7Dj/MgdZTAfqag=; b=AS8rrut2Ults8gop
	CkzGzl5k38QyTgCG6eKl6iLPu/ZRP8I66h7fZCsGfsscgn0qzbcuaSHQ0ECT9A0E
	OAB/kMnqbpF4D5XXVkH9fCci4IUdnnCQaydRGdPvKFmIX/xTXb9xUtwh556pPqns
	jcvGJDftf+cWZ2HlpvFRKVLkcrV7d8bKeP6TKkwLDZC7969UuCjWeB3TePOnZs+N
	SkeF7kBgPDLsPbXJCHnelqWZWjpQcoY+A1UkSHFbxDkwonYT4Gob5pMdMTaRSvHC
	SEEUAuzqGB2su81rwm3kadmy3DUJJiPLhoal0qCooPPpmunsfHop2XHDtPqX/nfA
	EJ8wag==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chyvf3q7j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 09:17:20 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-358fc09aadfso278247a91.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 01:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772097439; x=1772702239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mNpS69bTLdqyNkegk7W5G8tjQ+f6+7Dj/MgdZTAfqag=;
        b=Nl3BMdDMkBDcgr5QJSCm3mz2AGVLWCLozpPndvRAJ1ct+cfyt3wUZrxTrI4PSLV49J
         mD6PEEYpYQqNUVRhvLhaGQIeJckNMubUgWY8ZHQt3HIay8q0QWK8u+Voa1y6JyjsveVZ
         WHnb970umu3UvkPZOFB7N1gwKzsgz92H//cPuC7NR0fq+HEoScjzOSI6YuWxCarO50lI
         IEnMZI/wCJ6T3bnA5Y07jyTtqcjD7OquTIGQMpbyMUVm7+QeQPE9VrcNT5mIW6utGfDW
         q+9WHSOmytqbnFk9NyGBzqOIHOovNZnZb8NPGVaUopOKP1gAWUX7DbrC908tajkDv3qo
         GX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772097439; x=1772702239;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mNpS69bTLdqyNkegk7W5G8tjQ+f6+7Dj/MgdZTAfqag=;
        b=fWDZhCqkA+8ckyHf8B7vZYJClvD1DSG0eqxx7XqaremFfCJZlOLmPq9pUwRFehjDIu
         ljMeQwHc/Z9c7rutzdy1cfB1JlmoDnoM+5CG2kJrWFwyaojh6SCo4QWEaMl8FzxMgMEy
         EfEseWC76dqvTabGCXhBE+1gRYzc/wjUIYBnPoVMBPeP/itHpbX10JiIvuuIR/4e5WQN
         XODb1W80jVketioZVKohbvtG7XHcuNF6+5vLBkt2C0BczZVQo794HE8p0kNbOf6Jgz7e
         e4V0v+9X5pe+XuAf5keh1vLemgUfdVg/n8I02Krj5/QutixkliwitE6Dt/2RPKESCfvy
         Stxg==
X-Forwarded-Encrypted: i=1; AJvYcCWK8j13hwh4xYJgECxe+b+TGH3dXRN4dbhKKjOChAI4885UaD2v9Om3HnpvP1Uk1ldygWKHRlkR8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOIko2F6pIR21clHI95fFjFOQ34lAfRsE7XHM+zgQdSkdEKQAz
	cdXIhDsfZmZOJq/P/OIE5ECJf4pgqlA8T51XEVd+9ICQRzGPSj+U9iL9q2d4Aj4UqFiL76Yrq4k
	GfPDOU4p8suVOrbGYaLkFzNDPpKT19ZeGCxr2FCykrrA1bN9iQvT48rpbK6grKw==
X-Gm-Gg: ATEYQzwAMQiq7/SUdBOb/AIAgkbiEVNXQ3WJyDII1QDH0NZlPYz6FC3OG+E4ELNW1oP
	QLulRhaf/GOGO6DURqoTKNSFvuJtpQw/32ozF3mWXAX/AzRoavng99N/o8JnDF+VaBXeQ7EWx59
	WL5J0PB/tvszyv3ixnh1F4KJiDK8MXh6f45Xpdbbjv6kJmum0KOMD+MahZY9+0Gv0LTQE6pJwg0
	v954WOY0/jsrq4wmL6JXfJfeM6TMxQOV5h78GGkn0rHih81lya9abqFiH5Q2AHhfi44Dljr1bH7
	wvOCHB43+tWH5acn3aS3ijwBwgfq6rloPB7ajgX0Qfmi73ZonJSBJJI9TSgU+eajvILhU9K+FUw
	tXZEfhUfvhhrVYkgmcQdJow/FjEhsc7QWU8zqmkGCBUKL
X-Received: by 2002:a17:90b:5624:b0:340:bca2:cf82 with SMTP id 98e67ed59e1d1-358ae8a8df2mr12609989a91.4.1772097439133;
        Thu, 26 Feb 2026 01:17:19 -0800 (PST)
X-Received: by 2002:a17:90b:5624:b0:340:bca2:cf82 with SMTP id 98e67ed59e1d1-358ae8a8df2mr12609968a91.4.1772097438686;
        Thu, 26 Feb 2026 01:17:18 -0800 (PST)
Received: from [10.253.79.190] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35912fbc363sm3116715a91.2.2026.02.26.01.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 01:17:18 -0800 (PST)
Message-ID: <860de709-2eb1-407c-88e8-0cc5ee96cd4f@oss.qualcomm.com>
Date: Thu, 26 Feb 2026 17:17:12 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] arm64: dts: qcom: qcs8300-ride: Enable Bluetooth
 support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-pm@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com
References: <20260225091700.286108-1-wei.deng@oss.qualcomm.com>
 <xuhr6wicgyvc6f3ejq2qnhpb4wk25larvr5frivkwojkq5o3ny@pruh4twsloiu>
Content-Language: en-US
From: Wei Deng <wei.deng@oss.qualcomm.com>
In-Reply-To: <xuhr6wicgyvc6f3ejq2qnhpb4wk25larvr5frivkwojkq5o3ny@pruh4twsloiu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Y1PydU6nP9MO87jxYrq3m2PIY9JKcnQx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA4MyBTYWx0ZWRfX3hzOevBo0gnT
 N16YP05epSKfD/+ZzF1WPHzpr5IDlKU+JuYUSWqPfM0Xup8PVpNxzt9hnIOi1CtpclreXukbJKK
 5jpaP2KJxSaNraIUu0No6O1XQr5K4JPfJoj0VPpVFNJu7FeAHtoJCWR0dkjphbHM8YJh89lE2Jo
 xYSnvCMvrXtoa8CvW4VxH2IcE9iCU/kgOBsu6/67KreOporSrt9+6hVaLgr1B26h0ce8vLP0YeZ
 R6ZSS6uds2gjEvCwm4bZwTP/3o9tMuvdm5E0zK8kkvHcwTZNfK4RBrNS/CXKR/bOAMVevoxDOa4
 95c9X0k5GqJnx80g4YYfsaBFLp+8sE5JHQniuyg4YDJDFiTHHT/oV1K2CpV/GKam9jLRsglnuZA
 2UEC6FwHJFtCaL9+Q7v4VyuJfvEJHpocV9KTiniz3erSp2xhaqVleDW69qToQhp0xycNl1FZGZa
 XN3mBYRnSxQd7cC30jw==
X-Proofpoint-GUID: Y1PydU6nP9MO87jxYrq3m2PIY9JKcnQx
X-Authority-Analysis: v=2.4 cv=dZWNHHXe c=1 sm=1 tr=0 ts=69a00fa0 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=vHGxhxs0A9wySq8NOjYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602260083
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[kernel.org,holtmann.org,gmail.com,vger.kernel.org,oss.qualcomm.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-43237-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.deng@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 95E911A3467
X-Rspamd-Action: no action

Hi Dmitry,

On 2/26/2026 10:27 AM, Dmitry Baryshkov wrote:
> On Wed, Feb 25, 2026 at 02:47:00PM +0530, Wei Deng wrote:
>> Enable BT on qcs8300-ride by adding a BT device tree node.
>>
>> Since the platform uses the QCA6698 Bluetooth chip. While
>> the QCA6698 shares the same IP core as the WCN6855, it has
>> different RF components and RAM sizes, requiring new firmware
>> files. Use the firmware-name property to specify the NVM and
>> rampatch firmware to load.
>>
>> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
>> ---
>> This patch depends on:
>> - WLAN
>> https://lore.kernel.org/all/20260122053624.4068718-1-wei.zhang@oss.qualcomm.com/
>>
>> Changes in v3:
>> - Rebase patches
>> - Remove unintended 'output-low' from bt-en-state pinctrl
>> - Use prerequisite-message-id to replace prerequisite-patch-id (Konrad)
>> - Link to v2: https://lore.kernel.org/all/20251118140406.1551669-2-wei.deng@oss.qualcomm.com/
>>
>> Changes for v2
>> - Update commit message, add firmware name detail
>> - Reorganize patchset
>> - Link to v1: https://lore.kernel.org/all/20251113130942.2661069-1-wei.deng@oss.qualcomm.com/
>> ---
>>  arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 26 +++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
>> index 2ede6efd1afd..03c01ae630b4 100644
>> --- a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
>> +++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
>> @@ -18,6 +18,7 @@ / {
>>  	aliases {
>>  		serial0 = &uart7;
>>  		mmc0 = &sdhc_1;
>> +		serial1 = &uart2;
>>  	};
>>  
>>  	chosen {
>> @@ -107,6 +108,7 @@ wcn6855-pmu {
>>  		vddpcie1p3-supply = <&vreg_conn_1p35>;
>>  		vddpcie1p9-supply = <&vreg_conn_1p95>;
>>  
>> +		bt-enable-gpios = <&tlmm 55 GPIO_ACTIVE_HIGH>;
>>  		wlan-enable-gpios = <&tlmm 54 GPIO_ACTIVE_HIGH>;
>>  
>>  		regulators {
>> @@ -559,6 +561,12 @@ &sdhc_1 {
>>  };
>>  
>>  &tlmm {
>> +	bt_en_state: bt-en-state {
>> +		pins = "gpio55";
>> +		function = "gpio";
>> +		bias-pull-down;
>> +	};
>> +
>>  	pcie0_default_state: pcie0-default-state {
>>  		wake-pins {
>>  			pins = "gpio0";
>> @@ -633,6 +641,24 @@ wlan_en_state: wlan-en-state {
>>  	};
>>  };
>>  
>> +&uart2 {
>> +	status = "okay";
>> +	bluetooth: bluetooth {
> 
> Please add an empty line before the subnode.

Thanks, I’ll add an empty line before the subnode as suggested.

> 
>> +		compatible = "qcom,wcn6855-bt";
>> +		firmware-name = "QCA6698/hpnv21", "QCA6698/hpbtfw21.tlv";
>> +		max-speed = <3200000>;
>> +
>> +		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
>> +		vddaon-supply = <&vreg_pmu_aon_0p59>;
>> +		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
>> +		vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
>> +		vddbtcmx-supply = <&vreg_pmu_btcmx_0p85>;
>> +		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
>> +		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
>> +		vddrfa1p8-supply = <&vreg_pmu_rfa_1p7>;
>> +	};
>> +};
>> +
>>  &uart7 {
>>  	status = "okay";
>>  };
>>
>> base-commit: 7dff99b354601dd01829e1511711846e04340a69
>> prerequisite-message-id: 20260122053624.4068718-1-wei.zhang@oss.qualcomm.com
>> -- 
>> 2.25.1
>>
> 

-- 
Best Regards,
Wei Deng


