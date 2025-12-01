Return-Path: <linux-pm+bounces-38977-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F620C97F8F
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 16:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9E078343E79
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 15:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B9B315793;
	Mon,  1 Dec 2025 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nJTjUsNj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ayrfJ4T3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DF4305043
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764601783; cv=none; b=Hmhh2szNiPjKRS6ewDijl7AhwIhISS396AGYeTdoNQsJ0OURhZJFxOriT7MBcvduUIzGiuJNSY7mxd3EcHzY2m4+FMgWBGHB2UmX3UQIHJdfAam0Ow86XpE195vSoiz92Z/T8alIIJl+r8kFLAiLAcpmXwYUOh8ouQJ3fZF+wQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764601783; c=relaxed/simple;
	bh=YGSSDKFg5jrGbiSq4AkXaxodG2ZTxYZiOQtMhSy+4z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a9Jo7DOSmv8GVQ9wr8bozsqnnmwZUFpJRh02XZn+8f2yp4R1S0GJlGmZ4DYL2jT+dFN+STjnWaXgF1GqV9ggkWpZraBO5JrDkniKRbJcMlCPrqEzUH9xQAFZREDEs1I19NPOKcyt9UtTn2nVDKxToG07ZwivEcAHWPhAJFoJcP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nJTjUsNj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ayrfJ4T3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B18OWxr4062946
	for <linux-pm@vger.kernel.org>; Mon, 1 Dec 2025 15:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z3t1Xs6zgjRdXhFfVBguGwwnqAOk/Svbih2vGB4uC6Y=; b=nJTjUsNjRIHHpY2D
	J1AaiSet+6NiDLpnynoJhuerpyahkAZJTZUSrSvCFDRLJ6basaXXifhR4b/ibpDl
	WWnKwjiQ4x0TgMlfBwUJQOdqlHAt50McNg8Rlgk4FXgW1P+neRJEQezVWEgsq75z
	97tVh9xpLvOsBDHyuY1PSAcaijAGOEfqyVYs+LTP1rsgomLMbhCdBKjWO9AQ0KrO
	xSuJlcw7cKV8UlqRrrpa7NC9dancKajDaDNXuFnKF8WSnmWlbaWntE/CtY0cvf16
	SbmmZsj4wIYVFPSKWk+fvcJHIdZn5Lh8azZpO3xfJuWEMVeyAA6/VzbR68AiD0wZ
	wvNuEQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4as7fws5k0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2025 15:09:40 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-5e167b739d8so429617137.0
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2025 07:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764601780; x=1765206580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z3t1Xs6zgjRdXhFfVBguGwwnqAOk/Svbih2vGB4uC6Y=;
        b=ayrfJ4T3damwOmbo3ViiNKZNnRGh7XeqKJz4Bh715EnnwaY4+BhD/m5HK+ur74z8BF
         pwE1AiuteOUvZ/MKwkMr2LB/a90gNAipTIotiJuNBTX6YnHyRl61EhbrGpubPKF78c+/
         5ukpPnyAojiLjUWC9Ya2jBByZcryuwGLu0R6jNlZ31ZJMecEkFrpyIkQ5JKANxuZhXwL
         VPl/MpfI4JzOd81oTrfnRVMByN729jZFHw0okUCcDuB0NSqTl0xWuzbaLqinw1ToHk4B
         XE61cQpKfAfbIclwlCN9RKeUe8g82ODrvOApfF4Ckhr8y5wkK4hDwFglbk/Zi/B9j18e
         amGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764601780; x=1765206580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z3t1Xs6zgjRdXhFfVBguGwwnqAOk/Svbih2vGB4uC6Y=;
        b=qsS06xUZ4MCBOXOwE4rEvYGmu6Hr+NXrXvCZLZddwZCxeNqz72EMT3Pe0xNrzdsPDC
         1BIIQIZMG9wMZqfPYaoLFeI89heuSd3O6tT3nPBwTcjTnQZp7Hw82Rh0p9cpz2BoyClv
         Fr/LbRVRCJqPA3AuQ0HH9mum1FGo8HA+D3ZdmOD0zoAmyqpIpvFQ730bcl23cyKpDFyj
         c2T2hP5+Tk9CHFj3qu2XDEYXHbbkkUw6Bne3UScSHiK/HoB2WJKAg++1WZvxHU9j9Jw9
         8DRwhYTQjBNCraTzqIRFuEcyk8GGhSPfgI4VmZ84YfwByhdxuZs5S1jyos/ZqFFAT5Tg
         jT5g==
X-Forwarded-Encrypted: i=1; AJvYcCVOupfA59Sd2yRT+RYV2jPJb0HYKXvmQQ753fR/idtKSyyR8vvXs3r97n1KFQoRB7H2KeM/YTsWoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfcvMJpKXVKzVwkHNbAUyFDCdVUILiUOZCzu5wxoHi/QWB+zcj
	Ja8OfeTOWsccisHO0L5caR0FxEVi2I+OZ0ijzEtrQ+RVhOaOSUchVmj8u3jGIWeocvnJKye34vh
	mNJSsYSvlg7C41y4my9WYMJVQh7cOs9scbvv3dv2j4WJJD9nrAwk/9ZqSS9Bmk4lGnu79gg==
X-Gm-Gg: ASbGnctLw41sznHXESLXuL+bma3P7IUkfE2v5DwuR4E6pK+kx1q8+aypmkwnDn5pJX9
	+xdgH1u3BPDBAJoo36wEnQGn+Wac/zHgIL387DxsWwEuN3PT+xn3NvwJy+eJqzvTcUdzuOqm1S4
	WCTb26p8N1YtZ1kmoB11N1uT7WHMCUuYPbd35aRt9QavOGjJvifwgv4pjb5E99035YjnYIFTavi
	hAVEkOihSbSIxZARloIcKIMyzJpn+wz7AZwLzhnzAwVHns/NYLON3SVHVhdzcwHEoZZi6l/xV+I
	jpQRE/ejL7DFhgxsYYDREegCEc/iApuYJnpkz6cxQgKBYS2uMPRETpr3uk84ZCgprOERYin1kTo
	ipkIqh32WnX2yIhWeHEVaK617sESWXmMMSXUhQH4OqcXH2DbXkGQ4jJ5b72YinTW/5bo=
X-Received: by 2002:a05:6102:5ccc:b0:5db:d7a5:ba2e with SMTP id ada2fe7eead31-5e1de57c9c5mr7861934137.8.1764601779879;
        Mon, 01 Dec 2025 07:09:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqJ/bOtUtruLfvAMP21Fx4vb+d1CVVf6E0IukYWZBWR+luXF1KzuKUUzQCJI+z3Ap2EQMNNg==
X-Received: by 2002:a05:6102:5ccc:b0:5db:d7a5:ba2e with SMTP id ada2fe7eead31-5e1de57c9c5mr7861677137.8.1764601777393;
        Mon, 01 Dec 2025 07:09:37 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5a265d4sm1236160666b.60.2025.12.01.07.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Dec 2025 07:09:36 -0800 (PST)
Message-ID: <4f8a5842-2132-46f3-a3a4-1243e5342f6c@oss.qualcomm.com>
Date: Mon, 1 Dec 2025 16:09:34 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: qcs8300: Add clocks for QoS
 configuration
To: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
References: <20251128150106.13849-1-odelu.kukatla@oss.qualcomm.com>
 <20251128150106.13849-4-odelu.kukatla@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251128150106.13849-4-odelu.kukatla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAxMDEyMyBTYWx0ZWRfXzsbTBmWKKbfz
 cY12ifYUehyx8oYRHSLF2hKytolAyJOL3wEMVXV9T8Nwqz8dIkSfzJ9bOIJNbZNqdE2twVroSdS
 6xywX1EjbxEIX1EqNhbAy+C3Si9R8RLlZXRuYADmibpbH4l5m18foWWO0DI/2duyhV9neTAqgS9
 IPkTt+zM2mCLPYiNWBc9tgzf0HR2L6a1ORJ0d4ZvOpWUDs16iXao0o4QPu0Q91ezUCE3F5L9TfP
 zRfnE8BGHDEtmNFnQWHEPJb0qS9eYuJcsGwRAJ/RE5NPTBjSU4WgI2y4r4YaHMKSzd+cV6NwdKF
 WghdgyyM8nSSCt5kIBVSbOQdUnrDFpFABHSIMkqpMv3A+SQWb/E0DOGBOrDEcii6GIqdCTTWwxy
 jAUJggsWP/Uct4k4V7K0PvmsGgGz9A==
X-Authority-Analysis: v=2.4 cv=TbabdBQh c=1 sm=1 tr=0 ts=692dafb4 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=PHHq1DDFEsKsDgH6OmAA:9
 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: g7TLyFEO9hPsJlaZa-kXesNSwrXwnwnA
X-Proofpoint-GUID: g7TLyFEO9hPsJlaZa-kXesNSwrXwnwnA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512010123

On 11/28/25 4:01 PM, Odelu Kukatla wrote:
> Add clocks which need to be enabled for configuring QoS on
> qcs8300 SoC.
> 
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> ---

I don't have a good reference for this, but it seems like there's
a lot more various AXI_CLKs (PCIe, ethernet, camera) - do we need
any of them too?

Konrad

