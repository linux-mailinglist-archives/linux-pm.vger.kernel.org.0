Return-Path: <linux-pm+bounces-37736-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E61C46D26
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 14:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB6913A929B
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 13:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C694230FF3A;
	Mon, 10 Nov 2025 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OvY3moLp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NT/g4Q9U"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E943B21171B
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 13:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762780635; cv=none; b=NeJ1JPzgCBUYwNnP3dqrbivdhePupcqDLfvfOmugl6lnFOigxFo2bksPG6chap2sK+HT/Noi8aedXyH9S0D1G5FaMLdf+pMVSeq5rGXSuKP5Qaxl1VcqeKVEw8ftBefBZ2HR53jhvKiqAr1xTB8Z1qyECXRjybJcnLwLgbqTor4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762780635; c=relaxed/simple;
	bh=Pp8sadZa6Fs6HKKvmeIz/tCuyq6jNOOSo/X07LKN+cY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hLIayIutc2H62+l0Cd89aoquYsmeiorjqWOmPwWwuZLWTfbAdfr0nRUStbVT58FSAwMRsy6UgPlEqQx0KIjqKfi4XgBMKx6pPZclkPvTDbjrYisexsVxZVO8XeYYBCkLwLpz6M8vp8XUNc7OwDXDfN17OPO14g8R3T3uB6rgzlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OvY3moLp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NT/g4Q9U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA8FEnQ1567785
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 13:17:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Pp8sadZa6Fs6HKKvmeIz/tCuyq6jNOOSo/X07LKN+cY=; b=OvY3moLpUsOteqmG
	7FaRwCntbyDcESMa9uIAqudJib2CAr6icWKX7xY0rNOroYd+ksfRylKfEuP7/rVE
	qga6hb3W9zSlH8inJFBepLe6X5L6LzVLoW2/+ra30IkQnWVb72O8wGnOd5BATPCq
	bF1AL/cV8b2MQqOxYwOoGHJJwuI6CVG2QOqJNCX/rQSYqP/bBmBVDK2RJics28KB
	vjVNFoFMf/lLkFJgCLX56SpqkjZskL53C+tP3Xikn+DU0g93lwmECn0jnF3tj0cz
	g7/qYWaloHL67MWQMaCUecqToxFNX5wQRV3PDLiaZH5VidrU4ZT8qKS19761oy0A
	E9b17w==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xvjcu1e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 13:17:12 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7a99a5f77e0so5818616b3a.2
        for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 05:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762780632; x=1763385432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pp8sadZa6Fs6HKKvmeIz/tCuyq6jNOOSo/X07LKN+cY=;
        b=NT/g4Q9U87wbD2dpWzdvYj36KuqvpeP1Rsp1hfseJawdxl6Tvx1ZAAiw9GP9xxdNjt
         7twoFmfF4eJScNjCTwJwSDTECiUas7IlW03Zy+2TwGOMjz1qo/J9ciqvt8AX2wq2ecld
         ivcYk/e1U3jm3UOZuMCsXjgOcirOVgMmjOaeZyY3+IAir/GVXWlUmcO7rpMSiHJcTnk8
         +AM3NgLvL7dV3OTSue1es8UmV5J6Civ3o5gWcq9PUW4qPFZItgCjP+gC6p2gyH3YqqkX
         pxfn2UwvKLHEP++WjJSwBrFibnUk9TXrYFf87XV9L9PeXYrOPjuqTa6E3FzTKOHMlZk0
         0q2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762780632; x=1763385432;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pp8sadZa6Fs6HKKvmeIz/tCuyq6jNOOSo/X07LKN+cY=;
        b=TSH1Ey8XHgSCZ4Ao0g7w73w4cmcegM+dBvPSWI0wbQpUMDKl3WzpMSHIx/+H3RW5zq
         cALmo+WSv512/gUb4Rk3HegKH+q622N7GFdWZTaJgoP68vwo71v2VYMsp9fgsMshNavg
         MzHbn7kx8Dm9ymvijP/NBcRhq9BYj3ykAae9Rmg93/miXIN3/34FjFx3aRS+S2fbr8oh
         TqreHvPixnGCTuysgLY5ffVL4CT5iEDK+HPCG6m4911sSh8d2tsGF3sW6U9Lh6BwOIJz
         GPk7BasK/UsbT2+Yu1knrsa+tamnQj3l2QWZRIe5rUoNFKPMJJUiWq0/RKBH1Ii4xrGf
         x+gw==
X-Forwarded-Encrypted: i=1; AJvYcCWbT/HBaTKH4DCAc1p3Z88ufIiq2kGdRBclmYJ0VUDBBfasC2tOehijUTPmBIudEath/Zx6PcUcDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YweETijjPmvAc88dlg0OJiv7OXwWQJyMy9Lwf1G3FSKRZhIHUo7
	v31RhozovkKxPRtQVv95uxphI5Oj/LQr2v7aLy3F5VqmUrE6qyLU39GECBtcBsT39hZ7xrwdpq4
	7MmFpePG7xp2PT0GLe+DfLuAUisbF3qlIJ73YPEYgXznN+pGLrjBj7jDuICJsAQ==
X-Gm-Gg: ASbGncthbSdBccidXs1KQWMInT9/copgSehc/FkdSSu4Xy3Og+mxzBztTPRPcOQvw03
	3rwzrWlszrWQUh+VIYNGIABtCTHi9+QlBKLGlP2/kGG7QHTlqj4N2Ci8bFNM/beX5BWheDhNs3X
	DgV1T5WGy8IpggJUhRu3h4t2bnwy0OKp2HVQWPrEMYn27Us/nzQbaGdDqoh2rEsCYdccGUufk6P
	ZGdLSgfNlYfqomaLa5y1jkjKzv5mVeztU+sRg+JHRuVnXXSseR5JocML+a+L6K71FYSuDw5/1pW
	Y4qhGrw1hjlF5YkV2RlREaI4yAIXNRZrvKNoFIr8nn7pkYELLv/4ld3AKRp1b0j4554Db41ATgn
	W3b2W60fM10S8//G5cJ9WqtKF4HlQttS8
X-Received: by 2002:a05:6a21:99a0:b0:33b:4747:a258 with SMTP id adf61e73a8af0-353a3c6009fmr12911272637.46.1762780631396;
        Mon, 10 Nov 2025 05:17:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkxP2hPnDoM4zia18XuhPq48JzSy1cdEh/jpvEdsdq3YcmavDKiIkTcVKGhtOOp9ROXx9gMg==
X-Received: by 2002:a05:6a21:99a0:b0:33b:4747:a258 with SMTP id adf61e73a8af0-353a3c6009fmr12911218637.46.1762780630744;
        Mon, 10 Nov 2025 05:17:10 -0800 (PST)
Received: from [10.219.57.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cca5fd74sm11778345b3a.58.2025.11.10.05.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 05:17:10 -0800 (PST)
Message-ID: <4fc9c7cb-72dc-27a2-deba-4fd3eabb1fc6@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 18:47:01 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v17 01/12] power: reset: reboot-mode: Remove devres based
 allocations
Content-Language: en-US
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel
 <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
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
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik
 <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Xin Liu <xin.liu@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
References: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
 <20251109-arm-psci-system_reset2-vendor-reboots-v17-1-46e085bca4cc@oss.qualcomm.com>
 <CACMJSevoC3xYoeodGYnY4_EFSexqbNLqT_7UbRu9DxDRx8_gzA@mail.gmail.com>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <CACMJSevoC3xYoeodGYnY4_EFSexqbNLqT_7UbRu9DxDRx8_gzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=QuxTHFyd c=1 sm=1 tr=0 ts=6911e5d8 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=OnlfXhMgL6LeeRaFfUwA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: q_tuXFj6z1iwzPojpKRaDz9VaVU-HzzF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDExNiBTYWx0ZWRfXwFX5ONZwqwUu
 tLRttL6V1J7Ct3XJXRDC0EfJouMEc1CTSARJA/4VS4FNBZxeS4dRrWKFnkkzb8W7tkOtEe1G3Bj
 BD6TYGnutzbE0h74CRY2YTMr298I0ruBPkII6ddBqgr5K2TX5gL/rC2VU0aO9toZaDUJFFualPd
 JTSWGFabpeKCp6Q0EJT2njGiyDOx99mHzk1ZGoTsUjdDwVIIk8/Ov85abMeALanbgyT05uLbk+4
 JYDDGlNCXdWyFbfkPRV9MnxFw7hK8IJoFgFIei1E8xOCokEtfv+OooJsZ6b8ULA4XQs+Gl+jgay
 umnoy+QZjwkG8gWCVwYUpfrVxK2YSUpY9YovlaRgjDKcxiUtzqH1ISI2gRMcLwFGiaX0j0xk8Ml
 eguoBa/Py8bRTh2+IDRyjKejJ5caZw==
X-Proofpoint-GUID: q_tuXFj6z1iwzPojpKRaDz9VaVU-HzzF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100116



On 11/10/2025 6:40 PM, Bartosz Golaszewski wrote:
> You're making it sound as if there's some race condition going on.
> That's not the reason. They should be avoided in subsystem code
> because you have no guarantee that the function will be called after
> the driver is attached to the device nor that it will not be
> referenced after the managed resources were released after a driver
> detach. It's about life-times not synchronization.

sure. Will correct the language and make it more clear in the commit
message.

thanks,
Shivendra

