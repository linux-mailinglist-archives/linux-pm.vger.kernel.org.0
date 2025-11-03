Return-Path: <linux-pm+bounces-37285-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE46C2A965
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 09:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 016604E1E86
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 08:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2D82E093F;
	Mon,  3 Nov 2025 08:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bZF9dkzB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AHaI7sJb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194372E0914
	for <linux-pm@vger.kernel.org>; Mon,  3 Nov 2025 08:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762159035; cv=none; b=db7dugGPosRt+SPYydcrtJpOShg8P7ki+aI8sWf1jA64PiQtJQ0GdJ8YByEwNP+CiSrBYafOtPmmSs5HkuvK3WLt+TBJ8wYyvwK7a9S1YfEKFbpYAtnSkT62Crlo1bhBMIK9I3XbAXZZ8gNKeSMvLQQ9d6g0cew/h62InuqT9f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762159035; c=relaxed/simple;
	bh=skm6x5d8I+uSY+fxLrqtLL7d0aBYYN0h7FQYty9btHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oaoKWWMP/Ge9jlnUSi56aFSW42Rlq7LY0DzZljWcCC/y4ZqtYaIo36qjc5uZnCN72vF6K1Hms12ky1DUW9hW2fCehp84RNqutnD58XoWBlBPwDh08KbqThKrShWg1NO8KKKhOP56ps8QPY2aarPtLxt77xxwvpgx3KCh1nE6dDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bZF9dkzB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AHaI7sJb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A33DH8C1940955
	for <linux-pm@vger.kernel.org>; Mon, 3 Nov 2025 08:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=nxfYEmYqkxe9I64Jt37v1r1L
	AgjhaDXjQTd8b8LMNGI=; b=bZF9dkzBty7u8M+wJbp6L4YSEjUQ/5sUI9G7pac/
	GvXEiA3Dell9aFb1bodE+LD4Und4qEud0c/7ucYodn+48YiVBKgmgbyYUCFnAmTW
	eJgtOj8wF8rVOrdPOeWj8J+BQc6D9UsFndjGcePSQvest142NVewahDpi+vV2txl
	86QjwLqLv36UVP+AF3wqlRU72tiUUP26mfOI7V7r4NngvKtJ4Wjj+lSYRHpHRVCA
	8BlrD7DyOFhNtJ1e4HLm9nck6C1YL6jv/aHwWkpQrAb/JSTwsDGBO/wZzWMEFdQj
	ki1x0Fm5UGdF2MCgfKgqmTxGBcFw1oCA4uiNTdzEdh7YCQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6m9w8syd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 03 Nov 2025 08:37:08 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2930e2e8e7fso40808545ad.2
        for <linux-pm@vger.kernel.org>; Mon, 03 Nov 2025 00:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762159027; x=1762763827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nxfYEmYqkxe9I64Jt37v1r1LAgjhaDXjQTd8b8LMNGI=;
        b=AHaI7sJbJUhE1bf6Yy5bjcFHmDex9HXpmbN1gIUtReL/mTC1jNwdCFMLBTS0gQ0C44
         nppPD9W2yaY5NNDoq+EtbzY62GOF1pgx+1HNZi84L6ZeJqD2DoFgnRqjgHv0HyEtpVwW
         eC/NPC/4SU5rs81hP3nFPFzRrFzjtwzegwvs2VRqscaw0JuYtyg9Z8E/HTtFXi8vwPSR
         mA4xqL+uG05aijC86nTKFBPq319DPXH+Rmd30k/G5LjzlehPrK2FfpeRGUJz4v4VjSAL
         St6dQ+VE3LipTfI8CKFJrBqFo1RQo2kTcKwCG6fFpTePKAWWl/2VathUvhJSJtweZ9xf
         5PtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762159027; x=1762763827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxfYEmYqkxe9I64Jt37v1r1LAgjhaDXjQTd8b8LMNGI=;
        b=SzD9JWV0JAfpyOSagmIn+jVo3QG27qwSEzC5kg04CpoYUPyR9BhGpX3oD1u8/xA8/u
         L0W9zuZ/KIcGFFdHVBq+nvofhvnAvkLLYyR26ihjYWSiv4vTalrL7vWKDXq0CsbDizqL
         Plri3pcfZs1o0OveDi6G9haJW+Gs/mxddYEHVSBjVaCIudCT904NVgt7EvZl/qWsYhg8
         w4QeHGsQC1+BmFLAmv+jEwbmARgHb6k0t40x8k74K4hiZ8FFJl9Yu3dwRIl0QsZ8hPju
         M5qg4lB64gZ4QI93E7vVHy9Cntyz090Q4BJgSaXBTw0KeKb/Eq1Nr2NQ00nXKZyp66nw
         puqw==
X-Forwarded-Encrypted: i=1; AJvYcCX5ZPpZKTZUUsAobaJSYfCzqGWY+RWfHtejMtRfHiSenAQZmOp5V97dNccv1E8VpX9FUnlrKEsHRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwY2nP4Z4J2KRQF2+Szl5SANyETbKB5vCsomuCbsNMZQhrY4/AJ
	TMYKmZAcobTGUjJezkNiu4m2EuZuRiokGfOn5UfqwgkGcH1k+K59gQFHU00e9B9XEobpL/R5TQ2
	GxGFTijn1YdS3B5RBjyoDZ0XGVMtJ6iBijIYq3pTzbLZ2Q8GQDAR+zgS5vsHO7A==
X-Gm-Gg: ASbGncuN/U74ZdRu1pqa9UAqo3LQsg83ifLRleyRzqB1po3UQ+Qr5fgmlUAnuB6XzYB
	KEbTclKsaNMVjEh8ceiVmuIFs20m9hFrHc6H8kPOmduz28N2/TKzaVSHudiWd46nMfVbAHi9tSz
	YRgOZ/AbFUEYkOn+2YY4MFIYW+xYyqkFXgCfJKFAqqnAxK5s8y5FMLpuV3WfjC6vS0Igx72XAVD
	AJxjEPmVOgQAt8pdmHo1xaLpFJYgrjfQlyPrO3bPkvdBpbrMIVGW9IxPJwZp4U9hfx8iKab4/uw
	edF6o2EyE9y3ji/IRAUKslUs2iFckSllFJEmsWAZHrHhh9jASOhDKPe8d8cw2KXHL3gcHP8KALJ
	8S/8kVL3+OZ2kqxXq+iavYHTdcg==
X-Received: by 2002:a17:902:9a43:b0:269:8edf:67f8 with SMTP id d9443c01a7336-2951a51115emr96421705ad.52.1762159027257;
        Mon, 03 Nov 2025 00:37:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEg79jBe83qZ4qcFrRUL0Cs4zucPSebSAbF6GkYrqF3XDiBJBW5qwOvoRCXhg+yjXEA3w8txQ==
X-Received: by 2002:a17:902:9a43:b0:269:8edf:67f8 with SMTP id d9443c01a7336-2951a51115emr96421055ad.52.1762159025910;
        Mon, 03 Nov 2025 00:37:05 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295269a66cbsm112235015ad.89.2025.11.03.00.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 00:37:05 -0800 (PST)
Date: Mon, 3 Nov 2025 14:06:54 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Elliot Berman <elliot.berman@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v16 10/14] arm64: dts: qcom: lemans-ride: Add PSCI
 SYSTEM_RESET2 types
Message-ID: <20251103083654.a4u5vapgk5io4cr4@hu-mojha-hyd.qualcomm.com>
References: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
 <20251015-arm-psci-system_reset2-vendor-reboots-v16-10-b98aedaa23ee@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-arm-psci-system_reset2-vendor-reboots-v16-10-b98aedaa23ee@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=P7Q3RyAu c=1 sm=1 tr=0 ts=690869b4 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=_kws7oYgz0zWIvm8_ZIA:9
 a=CjuIK1q_8ugA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: BxVNqfVmEKwB-6hal9GrRPiWboH9zFO2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDA3OSBTYWx0ZWRfX3F79pKRhMXOl
 WEXJde8DmbdiGJb5IT/zr0ab8OxwezzBid3ta3c4HmNS3vssJOuyps5VYEckX0dvQ1WlRR6p1HW
 W8M3Yqr8x4CYsjp7hJ0rvk+GJfTMPy7jdyjhsZmAHyXkel2G09w9Kndp7gV18lh955OfFRSgQ7q
 4zzLFXYogS/LIjZbYszy0kJ0cm425mgCU566tVb4E/FmePqqJ1CKpn5c/4F5QoC1GO7NghqZB+h
 a9wJ4lDib3ofpAqve6qKkYyjRjA/fsoKcqw5+IP7JCbPYEbDQLaOAXxPMy+rNxt2b6Mqag99EIQ
 UQf4Sq+La8uR0PHL2EzHQ6ZVDqxfFyogMAPFJu6Wuj6RVwUIwU2iI43e4EMNzzAkKxJtYNDC4MD
 P7Ag/fViC5HUx2igrH1wX9BdZ9hs9w==
X-Proofpoint-ORIG-GUID: BxVNqfVmEKwB-6hal9GrRPiWboH9zFO2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1015 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030079

On Wed, Oct 15, 2025 at 10:08:25AM +0530, Shivendra Pratap wrote:
> From: Elliot Berman <elliot.berman@oss.qualcomm.com>
> 
> Add support for SYSTEM_RESET2 vendor-specific resets in
> lemans-ride as reboot-modes.  Describe the resets:
> "bootloader" will cause device to reboot and stop in the
> bootloader's fastboot mode.  "edl" will cause device to reboot
> into "emergency download mode", which permits loading images via
> the Firehose protocol.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Elliot Berman <elliot.berman@oss.qualcomm.com>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi | 7 +++++++
>  arch/arm64/boot/dts/qcom/lemans.dtsi             | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi b/arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi
> index c69aa2f41ce29f9f841cc6e6651a8efc38690e19..41ba0f4d437727cfe0c51e3d355427f37dce7f46 100644
> --- a/arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi
> @@ -722,6 +722,13 @@ &pmm8654au_3_gpios {
>  			  "GNSS_BOOT_MODE";
>  };
>  
> +&psci {
> +	reboot-mode {
> +		mode-bootloader = <0x10001 0x2>;
> +		mode-edl = <0 0x1>;
> +	};

Why is this reboot-mode mentioned here ?

Can this not be directly mentioned inside lemans.dtsi and similarly for
other SoCs ?


> +};
> +
>  &qupv3_id_1 {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
> index cf685cb186edcade643790ba22f6a900beb85679..5bb27665cfa95954543f7a66ec424452ddeb24c5 100644
> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
> @@ -622,7 +622,7 @@ pmu {
>  		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
>  	};
>  
> -	psci {
> +	psci: psci {
>  		compatible = "arm,psci-1.0";
>  		method = "smc";
>  
> 
> -- 
> 2.34.1
> 

-- 
-Mukesh Ojha

