Return-Path: <linux-pm+bounces-29339-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76054AE45B8
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 16:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B65AA1883998
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 13:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41010253F1B;
	Mon, 23 Jun 2025 13:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DK7GbNpc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6B8254AF0
	for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 13:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750687118; cv=none; b=YxN0Qn4Cr/HTh6XdyNYYLJXw7KdToxLUgwiF8TtuZ8vXptXOd+EVhAOnOHE//oCq1x1cwJF15Gj0X9ariJCdqUJhbmiubLWjIK8FbwxiuTK8KitUSD0f9EG7Nli31Td5PBhUtk7yvf9x8CVAJ62ysHH66TDsHeCfSK+e4vvPAZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750687118; c=relaxed/simple;
	bh=z7xRW/zHgqmPhcHqJRBygp5qO68gNdSDYBspX0f2XUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XwGCEJ3f2F8zoYw3bL8gYxqJ7oXr3S+ZO8/Mk1yEFHMjDg9rrgwUH68vXYNH3ozIKQBp/tczo95DQZMDlpRN+JZjdNgCa+4bVSJ4AtXTbb8d84D74dwAE6j7m8NS/6jQQxK9MGZbf/X6bThdEJUL0bXVdtT72XUg5pntGE3D/JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DK7GbNpc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N8aqvl011465
	for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 13:58:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gVPZjTtp1XI2FupP4oz954O3iw9aZ3hAniyWNapzx64=; b=DK7GbNpcZaFHiJ63
	1jj2VqudphMJnRJdIYUaxmX7dxhdHWTIY0OS2nDiN4a61RVr8cu89xcRyGdgmRTa
	GhLwq++sMu7DgR70uzwptTFprZjMz/Ah5WaMes+sDFnu9AYuO3BOB8lbeI5dP24I
	RX8mK20MwZDrbp6KsLUZXEiHnJE0PIWQWunUWX0z7klfvXVz7Llg8dnov2KLu//P
	AQA3TRgjUd7dn/XdqX+VurjV5xErBCBM0sCuSEgHXpYH9YVSqtqjcXSwVSgFf6FP
	PHUzxQ2ntcw78aS+p7BIhuDo91BrTmR/Y+yL0JOHZ8tNKYxDh+y8tIlTYIn7ILCu
	Aa6I/w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47emcmjfjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 13:58:34 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-74913385dd8so4063740b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 06:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750687114; x=1751291914;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gVPZjTtp1XI2FupP4oz954O3iw9aZ3hAniyWNapzx64=;
        b=g2AwgxA2Q2JcIbnQReLV1+neSojcDo6cpMduLndikak5cGBrt8iuj5lD2niWQKNZLG
         DGnJwAN/b5OX4KAjoqlKA/GnyOW1Lhbta6hfXXUKu5eF8boi83a7bcoYSlUTTwSR3iB1
         lghAey8ma07Rt8BNOXujhO0dPYIAJQhvtGXkYsf41NF+46yZY4QctwBXKhTrupB3MW6u
         3KNgvEfZ7pvMK+AQQGfZmE7k9ZEYjsGuDKBXhAtez6mOd6ydEo6NPp7FRaazrogZYnc+
         s36fbIARVjzwZJefhrHskhE0DB8zDPM0KqSSlWmoFwiFiQKelH38TlMBlKaXVS8R+Ob5
         mUMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7UXN6rw6jGtCxBdv7jMGGuSVKMSjYgWdSUnp0yQqFKnmqUcFkr4VzfSNkZh475EQOsSOxOJhaLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJRCbXoDp5PmY4Q+di/J7VeLBdUO8zZlyL5iS/JEUeCVpnQvje
	Alev4RIfOfxrv1RhTcIqy4zAs08cnPJNq6Ke8SioyV9/57gka44pE0ZaBsOYwGHr+XTReR9djKQ
	IEtf4NBUqVp4/yiaymjQatu75EQm+ytZ28YhuP8PSvwlrZbNyD6jRTGwIlU+FEw==
X-Gm-Gg: ASbGnctrV13aCvY9la+ANGCAaiN2Kdq6G8kPjAecMr7RoSkxtFTmNV4jb6eVtHaCvAB
	1CosiMTAWddgxXLp1C0nkV6BnINjUcAEjF/oQ/nF/vZMTuNDQJP5kiO2CI1yRwf0fO6AAE4ONqa
	EedCeMMAjCm8V6K640LRDEbpzBJ11YYofLoT8aathSJQXSAvS1Q++mqSGiOweByVErrmn3+xJNz
	LYevx0Bodsmg8+yFV1QWF4JCMRPNJGTmeV27he32j3NPD47UCc5k9qkAtPBOdcxvddU0m5AONM7
	0e5B6tABmljuFhKdWUMrUl3aPtxSr/qdX2Bs40axpQ==
X-Received: by 2002:a05:6a20:258a:b0:220:19b7:9d6b with SMTP id adf61e73a8af0-22026e3fc69mr18664029637.9.1750687113742;
        Mon, 23 Jun 2025 06:58:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVl1R1DUJMadEXAlc5CPHNyyosQFNPkLwlX/IE9EL9s6zL6fnh2dV9q0vTc02V0SmdWqoDwg==
X-Received: by 2002:a05:6a20:258a:b0:220:19b7:9d6b with SMTP id adf61e73a8af0-22026e3fc69mr18664002637.9.1750687113387;
        Mon, 23 Jun 2025 06:58:33 -0700 (PDT)
Received: from [10.204.101.81] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a66622asm8539213b3a.137.2025.06.23.06.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 06:58:33 -0700 (PDT)
Message-ID: <e8653c35-d6bf-4992-9edc-414309768bfe@oss.qualcomm.com>
Date: Mon, 23 Jun 2025 19:28:25 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] arm64: defconfig: Enable X1P42100 GPUCC driver
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Jens Glathe <jens.glathe@oldschoolsolutions.biz>
References: <20250620-x1p-adreno-v3-0-56398c078c15@oss.qualcomm.com>
 <20250620-x1p-adreno-v3-2-56398c078c15@oss.qualcomm.com>
 <66094c33-07bd-4621-b49c-b29a0270e002@kernel.org>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <66094c33-07bd-4621-b49c-b29a0270e002@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 0JZvwJGsOw-2hawa1DXn2wTMXPUOZ9Kb
X-Proofpoint-ORIG-GUID: 0JZvwJGsOw-2hawa1DXn2wTMXPUOZ9Kb
X-Authority-Analysis: v=2.4 cv=J+eq7BnS c=1 sm=1 tr=0 ts=68595d8a cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=gxl3bz0cAAAA:8 a=EUspDBNiAAAA:8
 a=Od58GZWkWy8WqyN3Zg8A:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=kiRiLd-pWN9FGgpmzFdl:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA4MyBTYWx0ZWRfX9Ev9ia46HghW
 KzlhKPTsRvfQk9xwIZbRjFy/8dxccDWPKF1AKsL35dYgU16PDUa9Q6UIJ/D+BQ+np+ANW1kVNqP
 nIAQl2JuVAyqlu3ZpNv6QDtKbnlFhAYZF2IYAsuz5DXHeD27zeoSQn8csWd0u5COTCNKHei1tE9
 zHT/VRK/lj0ucRJPnq1ujZlpqg/QGcG1esA0kCwk3Xf3oUxi8ghimJSomsl9M02k7meJgtWAJVz
 bLzGJuB0kM6fGxu7tc4XEIrpndXCWjA6WyVDZld3nLEuD8YdSmfK1vgaXEfrkIfacprwOk0YsyL
 6vBiyrlIFS5qYuR+NGLkizkvxerwdxSpKzIiHa3dR4hIc/Nwq4PnNjKRnsnvX7en2HaP1YZU7vZ
 XcGUjkDLnlai351qijIu2uWEcizIC6ip3hx6rh+J20TVTobryvKwP33n6pYLWexGG11Mz7pH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=730 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230083

On 6/20/2025 12:39 PM, Krzysztof Kozlowski wrote:
> On 20/06/2025 08:54, Akhil P Oommen wrote:
>> In order to enable GPU support in X1P42100-CRD and other similar
>> laptops with Snapdragon X1P42100 SoC, enable X1P42100 GPUCC driver
>> as a module.
>>
>> Tested-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> 
> Defconfigs cannot be tested really...
> 
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>  arch/arm64/configs/defconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index 897fc686e6a91b79770639d3eb15beb3ee48ef77..ccd03ab5de495498281175a4550bc73d3e65f3f4 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -1347,6 +1347,7 @@ CONFIG_CLK_X1E80100_CAMCC=m
>>  CONFIG_CLK_X1E80100_DISPCC=m
>>  CONFIG_CLK_X1E80100_GCC=y
>>  CONFIG_CLK_X1E80100_GPUCC=m
>> +CONFIG_CLK_X1P42100_GPUCC=m
> 
> Not placed in proper spot. Don't add things in random order, but follow
> savedefconfig.

Ack. will reorder.

Btw, can this patch go via Rob Clark's (drm/msm) tree?

-Akhil.

> 
> Best regards,
> Krzysztof


