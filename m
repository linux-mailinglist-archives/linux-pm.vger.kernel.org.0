Return-Path: <linux-pm+bounces-17232-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 015C59C26C8
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 21:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25ACA1C24088
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 20:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9567820B806;
	Fri,  8 Nov 2024 20:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oUv6GFYh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A671A1F26F4
	for <linux-pm@vger.kernel.org>; Fri,  8 Nov 2024 20:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731098580; cv=none; b=EjkbJxPSB7WeZHYiVBgkqCixozibgKNrMln2zmBAiLsCBLYVnOstCXtX+QRmKiAmGN6mTddRnLtShGfzJ5Seb/iXtTZdJzyL4tERCKeckYjRTQxY6jQESfsh9dNtN2SF5QwHS69muWgqTZNtdEAJAZhyo1cuOKLS4IYpjMoS9Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731098580; c=relaxed/simple;
	bh=NIGh/xa8vBmbgPLyU70Etun5Uy7YLNS7WA7j/MRtOkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d6iQw2z1UWpiiTGsHLfpiMK4eAp43G7XAu1uVbTYHRjVFNwT6kY7Zoz0xpo0B3sbyzgRHg6HAxALCNLmHqr9Di0vqUbyFhtcC71F00V3FnVLS4kjfEvF91REWHJRaGlLmwN7lyYHm6T0JC+7nTYYmW8TUHS4A216N3uPHYSpvpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oUv6GFYh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8FEYfB014252
	for <linux-pm@vger.kernel.org>; Fri, 8 Nov 2024 20:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VdJcdmEbuUjsz9W6dsG6F13BKeiSPurxezaypVBjUh4=; b=oUv6GFYhboRpAupQ
	o1N+ky3RuUB/q4tQBmntvG7rlQ6rqEY2Eu/Ko74+7HK2GiTBtw0kVLWKBjJ6ebWq
	YJNQHRJqix2lHQIVGHJGzpufDoF7K/dUKHh/EchecdGktjhKxHR201/WTbKPzLLN
	rn02LMen3StTASNEaRib647Bb/a+/OGLegr7GLchz3m01Zh3+hrIUj+rlaLAyEvu
	jCrDzXshGSdb5+5hFqBikgNaxfVVVFuoFgg2KVjxHi8z1CjSyh43hFcJZgvCcpVS
	yaW3Qn/WANnfHbK12SMzMA9bTQWbRrhhLwqxLQge2gQXwQXV17cIm75u0LVyPtVp
	rxnKKw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42s6gd2jym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 08 Nov 2024 20:42:56 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d37d9868b8so6034136d6.1
        for <linux-pm@vger.kernel.org>; Fri, 08 Nov 2024 12:42:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731098576; x=1731703376;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VdJcdmEbuUjsz9W6dsG6F13BKeiSPurxezaypVBjUh4=;
        b=tVDzMV2qxFP97E38Eomfi3nPoTfx47kfwUo3JAsqXjzA7Tf2DlPeRv26GG9RVIsd9C
         d9hF8V7G7B7xTjfqrhQL89m3AmQP6TlXyT69QLqP36qj12qaxMX9m2FRf4jMYJvIEU6e
         zvet93MMyM+CfiUHYTIa9KnZnxmF/BLtcNwchgXOlPb0gyfx18AVWaD45j0pxFy3TWax
         Zl1W9VKaCE8luhdbHEsYCYTuiQC2M5ZFwl8MFKCuFZk4lo1fX49Y1LqpGedZDtUzdrre
         5dJC+sMq/M0cYdxq/2rtK65+nqOan/b99IuH0uYTpcIz6DdoH40z3kYNBv4rVlfRvyUu
         KX2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWO6Eu1YnykfUnUhRThhteqfy3gUsHYGXpgjpw3+hjO9JKBW+r42ZgBvacYrTU6dzdM2zlm4kuvqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YydwdeGUjB9QrrTgC1x6cU8ZhXmlYs6d2cvVKEbSOeL/Pc7eyKR
	RckwcS88Nm0Grg01dXJeWuhnepwAZSmx8pSNhsuWg2bgn1R9BXx+PkfjondbADWUTJlfCW5x/s1
	1aZ11FSVqSrBdJl5dCN61GFB8yeWiLdN1m/ReRbFHdS8vSBeqdYCmJr5gGQ==
X-Received: by 2002:a05:620a:2a07:b0:7b1:4920:8006 with SMTP id af79cd13be357-7b331e4cf7emr229938085a.11.1731098575753;
        Fri, 08 Nov 2024 12:42:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2rPJ8TWctxcZMgE4zJgB8rPLFwzZPX76YJC1zO5aP6gngaNdRzDusbilO7NPwDQ+LrWVpzQ==
X-Received: by 2002:a05:620a:2a07:b0:7b1:4920:8006 with SMTP id af79cd13be357-7b331e4cf7emr229936885a.11.1731098575404;
        Fri, 08 Nov 2024 12:42:55 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c7ce0asm2314144a12.85.2024.11.08.12.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 12:42:54 -0800 (PST)
Message-ID: <cf054b7e-3ab3-4b33-a165-49287cac6515@oss.qualcomm.com>
Date: Fri, 8 Nov 2024 21:42:50 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/6] arm64: dts: qcom: sa8775p-ride: Add PSCI
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
 <20241107-arm-psci-system_reset2-vendor-reboots-v8-6-e8715fa65cb5@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241107-arm-psci-system_reset2-vendor-reboots-v8-6-e8715fa65cb5@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: wK2ElJ-2-_PWKNi4ouLLj9DGLq5HGU3L
X-Proofpoint-ORIG-GUID: wK2ElJ-2-_PWKNi4ouLLj9DGLq5HGU3L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 clxscore=1015 spamscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=959 suspectscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411080170

On 8.11.2024 12:38 AM, Elliot Berman wrote:
> sa8775p-ride firmware supports vendor-defined SYSTEM_RESET2 types.
> Describe the reset types: "bootloader" will cause device to reboot and
> stop in the bootloader's fastboot mode. "edl" will cause device to
> reboot into "emergency download mode", which permits loading images via
> the Firehose protocol.
> 
> Co-developed-by: Shivendra Pratap <quic_spratap@quicinc.com>
> Signed-off-by: Shivendra Pratap <quic_spratap@quicinc.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

