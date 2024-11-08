Return-Path: <linux-pm+bounces-17231-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EA19C26C2
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 21:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EB81B23A1D
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 20:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02001F26EA;
	Fri,  8 Nov 2024 20:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="msVIlfGJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2A51F26CE
	for <linux-pm@vger.kernel.org>; Fri,  8 Nov 2024 20:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731098560; cv=none; b=G/yDle/oaENdPXBEmMkzDruy3EfekqOA/T7ipW2nGjvqH31Hlcc+TM/ndWl0euaERp8KlEEIHclHWZcuq7LNLp8Kw/X/17MdWwvkK7SaUbSe1yXE6+0FoTRBSiP3Cm1ABPaxP960We558rO/18MzF6zC8Jll2uROQmi0KNE+x2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731098560; c=relaxed/simple;
	bh=1pGppec8DWHYLSw8JbIxLQYVhHnp1a3bUK1q0iqJ0Ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CJI11qG22kqBpSNozucYcICtPOs0MSLHS6QyHwceLDNcZOdnfN9Cz7mp2JywXCyc4jL24QTgzh35EHxmxo+XUgn/2TDkQ/FC0oU0xjGselomdx/dEvvJ6yGUHewWr5ZNXYGEIEPe74Nn36gIrIerJhtl7nRWoZ3Yaeph/nTiBrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=msVIlfGJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8E8thM028587
	for <linux-pm@vger.kernel.org>; Fri, 8 Nov 2024 20:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Cs4riM3bHa8k5Bz+RTTdkcSvQ4WfTHc0avDjKefuDVE=; b=msVIlfGJmYYq4RsO
	Bts3cVJc41YLj/q+wQ4jlIlKXERWkayuE7XW7C2biT6xHcTD49tB5Qm0VvgNppsN
	6kAcfPGUPNydfjEiUVNOi98Zg6LNLNE3K0CN8hLinDzZ2d56mQLAzcgo2FqfZafO
	S7GU6Fo0sOUT1+QMt2gSZL3VvkrM1BrVen0dUHceH/UXTYbAjuIT85DWn+4a6+35
	0Yk6bxhuSU7wBD5GZ/mCmiF6cACO3TjAsPTH9tnxyAV9wdtytEymrwm+otESx4aj
	tM5uWjSLnGLdRZmlVLD58i0Z/GLnUi/Tx3MOAk7AQ5WMj9gunM/H1Xzfbfp7zzqx
	J5y1HA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42s6gdak8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 08 Nov 2024 20:42:37 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6cbe993f230so7533826d6.3
        for <linux-pm@vger.kernel.org>; Fri, 08 Nov 2024 12:42:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731098557; x=1731703357;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cs4riM3bHa8k5Bz+RTTdkcSvQ4WfTHc0avDjKefuDVE=;
        b=Fx9DKLqI1LnLNzsvIgprSv/yOtudoFS4vboijH1t4IfNvnSaHS3RYllVuKQCrk2HIP
         caW41vxdaXwxkYfHVuDENWEJr2zWPrWgR4gg4TX8lAFXUG7T1USYr45xGWRuok5jxLQ1
         G/Pc13xHf196fuuXSomWCX1zWer2613fV7tok4/B0cR3lI4XzIfNu7EHKfafCX9ImUxR
         SdQzWdlGf5TO6gAHBc2vueAoJhI3qftWUHrTaq9vs9hCaL60uSf7RloK80hCbUXFEPDB
         LeheFDrfG1Enf7cERn7CYjUybGrTiyJLsFSJ/Cwi3Q+HFWr+ceXl8NoACZuxdpK2H3CP
         MXNA==
X-Forwarded-Encrypted: i=1; AJvYcCWu2Nea4PSBCJRFtneYopIREWDJKTLj/bIwBXweqOfm7HldkYSTYpOk7du8zsb6YadZd5qAr2v8YQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuwoWlfAjjcMRzJT3asUl4SyRZLwjAHoqR39Jsg2Wp01eOFRGi
	41Y9oytgycaRsKclkxAQWfHxMbrLeRvz34NF2up2J0yVR+3geeYs/OEiZhKHWSVRzWLDTzrBElG
	vyyMUZVoki4dYEkneL9SJ0W+DDD0gbzs3jBVcAhROmii/ALxeotLlvhF23g==
X-Received: by 2002:a05:620a:2995:b0:7b1:aeb3:8cc8 with SMTP id af79cd13be357-7b331d473f2mr259703985a.0.1731098556954;
        Fri, 08 Nov 2024 12:42:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmGYROupge46jG1nBI6/BcoZ4PyhzcR055xXlljdy1aNTPHHNIcEdgg6Cg0UU3ilkctF1xDw==
X-Received: by 2002:a05:620a:2995:b0:7b1:aeb3:8cc8 with SMTP id af79cd13be357-7b331d473f2mr259703185a.0.1731098556608;
        Fri, 08 Nov 2024 12:42:36 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0dc56f1sm275188566b.92.2024.11.08.12.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 12:42:36 -0800 (PST)
Message-ID: <1c5b3bc1-0e35-45a7-9895-27e3b4982426@oss.qualcomm.com>
Date: Fri, 8 Nov 2024 21:42:32 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/6] arm64: dts: qcom: qcs6490-rb3gen2: Add PSCI
 SYSTEM_RESET2 types
To: Elliot Berman <quic_eberman@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, cros-qcom-dts-watchers@chromium.org,
        Krzysztof Kozlowski
 <krzk+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Shivendra Pratap <quic_spratap@quicinc.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20241107-arm-psci-system_reset2-vendor-reboots-v8-0-e8715fa65cb5@quicinc.com>
 <20241107-arm-psci-system_reset2-vendor-reboots-v8-5-e8715fa65cb5@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241107-arm-psci-system_reset2-vendor-reboots-v8-5-e8715fa65cb5@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 6d9rMv-y1TxRmXUpqvCXVqmscZgiiqRL
X-Proofpoint-ORIG-GUID: 6d9rMv-y1TxRmXUpqvCXVqmscZgiiqRL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxlogscore=892 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411080170

On 8.11.2024 12:38 AM, Elliot Berman wrote:
> qcs6490-rb3gen2 firmware supports vendor-defined SYSTEM_RESET2 types.
> Describe the reset types: "bootloader" will cause device to reboot and
> stop in the bootloader's fastboot mode. "edl" will cause device to
> reboot into "emergency download mode", which permits loading images via
> the Firehose protocol.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

