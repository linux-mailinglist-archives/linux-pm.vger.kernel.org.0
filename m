Return-Path: <linux-pm+bounces-43676-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Ku7JDFqqWnH7AAAu9opvQ
	(envelope-from <linux-pm+bounces-43676-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 12:34:09 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4E92109C8
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 12:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9682A3015480
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 11:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDC936B07F;
	Thu,  5 Mar 2026 11:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fQYop4yF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IJNon9ps"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4252EC0B4
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772710446; cv=none; b=t1crpP8JlPNPwP0YbkHr+R339LlZfwPSMOM25p2RIANYWWpvL8Kh4euqhP86G27r1L9tR6rlcWTlp7bYZfAiTTDKZZEbM4zCjnzkNmnr95+yeS4aRpShWtHKmCPnZrUdqNl1Ln9QVClNuiObcWU55L4iBrmN4J3DVcW9X0EReYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772710446; c=relaxed/simple;
	bh=DK7rbmt0fdJaJXwujoUdrzNkqZH/Axad7pPvocVuokE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dEefnnsyVhz1l3L23PvI4Vmj1EOfC4U5Jy5g2ti42X3uCJOAygpJqetq/1t3nMFNA9+RHkCkXWZ1ykqw961rHCGOexAVLmjPbXmlXOm/xYlE0BNiFXkt2w89R+KgbPWqZqGK+tr1dxqYO3Xerqu3OGvj83/qrwN7upxCvcbFp5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fQYop4yF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IJNon9ps; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625AVZFF2400519
	for <linux-pm@vger.kernel.org>; Thu, 5 Mar 2026 11:34:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cSJ6/gnzvyp+MqZzEwrFuS8ohF6YfunLzHCMX8kNpaQ=; b=fQYop4yF7vuy3qOe
	SQNlA0GzPEYBIK6g9wicUqQfdMGRMSN4l0hcBfQszns815TIMW21nTuryuPvFAVe
	2biFBZXeMbsr1ZNTHbusT3vq8LyjivAAK4J/exGhVOuIQCdFeU+t/Oi4Pzi2acKw
	MiimDKLV+OEYf1f6mpsZ6V/FaAtwV75PS4ABZG/m3hVFfx6UUra9yrrIi6nyPTK4
	3dXNhKeygP/VjS5+9sbbtFiJV9Mkft0Nm9o0Cwa3DbneVjpYcenNDfVGZhEOVGPR
	3CqqkmAhs4w3bLel65Iv49QkRfVlATTtWjEA67k/O+tHXi42QH+hKoPD6wCJyZAN
	vVw7kA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq85dg4s6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2026 11:34:04 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-89a086578c5so18998576d6.3
        for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2026 03:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772710444; x=1773315244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cSJ6/gnzvyp+MqZzEwrFuS8ohF6YfunLzHCMX8kNpaQ=;
        b=IJNon9pse0WqWvY1HTJYlLLdlAb1pJ+MMuxngNQ4snwNFa3XGd/vMDPLrm+W8rKE6b
         FVPJPkxL+ti8aloDEoYAsCvCsWpz9/ec/VTSSE+vKAKbvJxgQSiOftb+JdnyAl9qQe6L
         KHAczCwvoMYJQq9Qf/vbR+M+ITuQRka1C9KH2qFJfQ56X3xCEpis1vbAQgrW7swGWiNK
         6lPeFhaHqSP3crbjj255+z7nRyTOejB7nC4skWMUBIusyOVBdbwNqsRPLaTyGmjsvbVV
         SFn3KYToPc8x+CVznLmQ79hACb86X9nNE4WRLuRkoUZgv4DXd62WClw/SGbiuA6Ly1aF
         qkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772710444; x=1773315244;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cSJ6/gnzvyp+MqZzEwrFuS8ohF6YfunLzHCMX8kNpaQ=;
        b=oMXDJfR2iTtSUd46yqXPeoT14oBJmXNEFbMDgSQDt67mYlpmTvL9D4K7swyf3HLYwI
         s6Ys7d6GzN6KFZTJu74SoN38MFiq10YU9v3sY/PMrIMwlVmJTik2NIjwkvXGXQW4i1Wr
         VyP/p2JGbm2nCNCXO/6DDypYXpLiDGy0eUQ4P0C8PZfG0U1JgoyRFnoRdbWr54qPccr9
         Bh3By9kgPJQwQ7qr2QIdzVfrlCRX9hZcTLV8yrYPlsPrHN/RNdVKic6LxDJ45SGfmgzg
         9Wm/AzBLUFZB0FHp1ByL+mkT5yzBwiPBBaikg3BUPi2ugdfuNwecfgzJOt/BZE4U7cyk
         q6jA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ8NMlK8UD5D9Nbt+xa4sI3o2bTFIyuAGsaVCgQzMWumeV5D3bJ/0C98S54MIZXPdbQk+LtE3K9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJL1h6G8FeTOnDiiwhZCpMylNCxKeX6beq5El7j3VONbIyqgxh
	tixVCT4fxezyM2knOWUkPSLgWAwBr6E6W0TUGsWYLpPtetWo00FCvo0pRVELTpzgDy3yUK33lT4
	QQsLNbyf+EsxKp8/dkOYosAeY41ypfteiczjtX1tGKv1d6WNJsaGq+2krGBUNqg==
X-Gm-Gg: ATEYQzx6ZUIKqQE6UkoNe638h6Myl2IP4hqE+fcdlEM+HaQE05mD0TX8t6/0iwIQ1fQ
	gJEfaAbpUF9+ov7V/k53Uq5DUnbPS3UFO/MntXLQSs2ihWyuDiUqs6Q3Wa8dAVpquQVc1KCNG+k
	Ku9QIiuBkwPW7yNr/CWOecp5kB1a9UVmzjqb8oWAiU62KXGfHxhbw97bbelUgSKTr586ZVYOYuu
	6WEIEkShITYN9tUAW2EVWkwSeLt3hfTyTnr6A17J4byzl4bc02CGyhZHtZmKrGLQvC8lkeJxtcT
	C1Lez8PT1YcLcDa0jE7LW8TgIh70quvBwmxBKJ5JYH5q+hDGzhg3ptDMQTuz2myDvtagEneXedu
	75lJNCzGJ2ASti1+uQP+Y7IPVUOrrN3RMAiT7GTgNdDPd2OoHXV16Dn9DO06yCEDFg7jXnN3MtC
	wHExg=
X-Received: by 2002:a0c:f103:0:b0:89a:f84:fdbc with SMTP id 6a1803df08f44-89a19d22811mr51378746d6.7.1772710443718;
        Thu, 05 Mar 2026 03:34:03 -0800 (PST)
X-Received: by 2002:a0c:f103:0:b0:89a:f84:fdbc with SMTP id 6a1803df08f44-89a19d22811mr51378356d6.7.1772710443302;
        Thu, 05 Mar 2026 03:34:03 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ac546ddsm895276666b.20.2026.03.05.03.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 03:34:02 -0800 (PST)
Message-ID: <4d4cb697-17c0-4610-b498-04a3bb252923@oss.qualcomm.com>
Date: Thu, 5 Mar 2026 12:33:58 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 08/10] arm64: dts: qcom: lemans: Add psci reboot-modes
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Yan
 <andy.yan@rock-chips.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        John Stultz
 <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Srinivas Kandagatla <srini@kernel.org>
References: <20260304-arm-psci-system_reset2-vendor-reboots-v20-0-cf7d346b8372@oss.qualcomm.com>
 <20260304-arm-psci-system_reset2-vendor-reboots-v20-8-cf7d346b8372@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260304-arm-psci-system_reset2-vendor-reboots-v20-8-cf7d346b8372@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 5k4HjtZxg51pagrOSfh5-Vcrh8WnRoJb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA5MiBTYWx0ZWRfX9hj2LwLsFwNf
 0iFLk6mc8QlogB8JM2d3t/0B+KmfG0cXeknmXQ/C4mOoe3JsqfMDISkoAbVE3YLX/DOZfwvBkKg
 SD1g0GDHnjEUwHt7QtiR1AMFADVn3Ni2a1up2yqK/bjiN9iSJp9vEmV6wx/5HUOi4AHhr7AKhQn
 mFljgOzPge/rJXpsvsRWEezAgSRTx3xwrFYaOKM+VGSvS9V7F/hbzQX8xsoNAR5f0er6aNx5eyl
 ycw9qjoU6CEEDW0w6UVz5iTfo4GRqi90ea+jkl8h40J0qPjo9psBDkhlp8j7P0wUU744NXlZdKR
 9evcbhIQkpDU6ghhTfSgznhfVUplkqHMplxs279Sla8eiXF3ckPA2HynBI1OmXiHFSsoXIn1VAG
 O3vkfSnQRdwZrdwbvPoQbz+k0wdzxYLSR1mVN4qetHuu3363CUBfq8w0YPM/dDFSxykh3Kixn4K
 loSmJMJZo6j0uayH39w==
X-Authority-Analysis: v=2.4 cv=aOb9aL9m c=1 sm=1 tr=0 ts=69a96a2c cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=RY4SAwMzpmrxGTDjaQ4A:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: 5k4HjtZxg51pagrOSfh5-Vcrh8WnRoJb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603050092
X-Rspamd-Queue-Id: 0D4E92109C8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43676-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[f000:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,arndb.de,arm.com,rock-chips.com,gmail.com,linaro.org,ettus.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/4/26 7:03 PM, Shivendra Pratap wrote:
> Add PSCI SYSTEM_RESET2 reboot-modes for lemans based boards, for use by
> the psci_reboot_mode driver.
> 
> The following modes are defined:
> - bootloader: reboot into fastboot mode for fastboot flashing.
> - edl: reboot into emergency download mode for image loading via
>   the Firehose protocol.
> 
> Support for these modes is firmware dependent.

The previous patch only enabled it on a subset of kodiak boards,
the remaining ones do it globally, even though you claim it's fw
dependent.. this changed in in v17 apparently

My fear is that those may conflict with other methods providing
identical identification names, i.e.:

psci {
	reboot-mode {
		mode-bootloader = <0x80010001 0x2>;
		mode-edl = <0x80000000 0x1>;
	};
};

imem@f000 {
	reboot-mode {
		compatible = "syscon-reboot-mode";
		offset = <0x65c>;

		mode-normal = <0x77665501>;
		mode-bootloader = <0x77665500>; // conflict
		mode-recovery = <0x77665502>;
	};
};

will the syscon write apply and the (unsupported) PSCI_RESET2 gracefully
fall through?

Konrad

