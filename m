Return-Path: <linux-pm+bounces-40264-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B52CF6FC6
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 08:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07101302653C
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 07:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB05309EE2;
	Tue,  6 Jan 2026 07:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X2rhLxsg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lnmawn0L"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC1922127E
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 07:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767683459; cv=none; b=NvXBsRHUOI5oCPJ8edZKCqoxseStCJkPnJJDz5hyTRVfYjlAkBnmyl+X2mo5bIW7rx3kBsVZ8sOCanSY9RLaT00iKeh4HoL/JuWNjlJdePVmpDhIW6S5YlqTBbK2tllpfO4DgIJuiL41t58Idz8L3kNxUfX1bwE24wTp9vZ6yvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767683459; c=relaxed/simple;
	bh=0vKA38yiagfGrGeqmX2UesyDtC4bAUmn0ChESVuvSV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C04zkiM2VVeORJfo1Cy/wcA/xWfm/JxJA7ZwHnp4+mth8zas9pbJv0JOuybxpj/HWMxyRq2E473ZBpsHTSzz3b51PKzdbyODAU9CTNLG+KP8Stk/gLYli+Hk0Rw/HITZBcIKj5baAb/W6DVTnTmG0nA+H1Xj030cwDxpCh5M7Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X2rhLxsg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lnmawn0L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60649ftK2255371
	for <linux-pm@vger.kernel.org>; Tue, 6 Jan 2026 07:10:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yR+2kAsivE/Rvdu/9KWZ7We8zTZVWkvuerZ6CyrQIVY=; b=X2rhLxsgYoyoE5AY
	L4b4cQJTQ3YgIfJCOY2LOJVoBKGe5vLK1LpNNiDsUPfYPZFJrCvR5L6HKf8GR76o
	8Xem8H7csVtFQUIFSXCaZou94+irylPnnV29sMLXiknpFDdgHOFgL+jg3vNiCh+U
	u8uJoDzslcYsqpOZb8u3b16lzO2UczbNws/eJs15FDtstTOCjhv8bpMg7IBiBdsU
	zE7CqkcaOz/1l++v2Uo3JcN+XNUAHfVn3rtogIk4FRDqu1x5eiisquylcuSGquLf
	JjcY9vRoINW1D1IPJp/i+YibBXgIyJDSEo3kApXRCtijUJfeLCFyzeiGe3OegeMW
	i1Zuwg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgu420ff1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2026 07:10:56 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ee16731ceaso15433941cf.2
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 23:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767683456; x=1768288256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yR+2kAsivE/Rvdu/9KWZ7We8zTZVWkvuerZ6CyrQIVY=;
        b=Lnmawn0LVw8DMzTtX0DzlOTfI5YZVENJIAUOa8YkRlT07xUl8TwJ9M1pbTCeqp8kmx
         nRrR/06BnconodOZyRAVoluI3cUywFV6Bk4Ab+Vxn5bNO+OiQ+KK7A2GK+kA8Z1usHxa
         NcYAT9h+sgDBZbINIA8ecrqotmmMMlvtfL2l+XUvCrpAfpo6q75efGcfJRTGd1JcEAX2
         F+k5u6SODMc4PNTJguRMKXXy4J5L001xqF2ZEiu6xd6sgpCgAS7x+IO6DIg2Atdtw/hK
         JIgb0uruuTMXlyc7ymxh9a2p8eSFsZ5NG0qXkTbispbtBn6LIL6LqUaM2kxGcwgLMG5v
         JXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767683456; x=1768288256;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yR+2kAsivE/Rvdu/9KWZ7We8zTZVWkvuerZ6CyrQIVY=;
        b=k8s0JrO+usPjv6pXnU1e26+34U0S+sy+ssPG9BSmfD4nhVPbuJXb1Jo2jywofRsxpY
         gKeuRVUmu1dodbj5mTNhpdrnx5tzn+bzVoApFaDGO59OD48oTpW89P7ScWmFjLxVVFRN
         Q69/1yqK4uuc65l01AN5yk7b8k7Coyd+RAbCHHUwLH5PEf38WXiBjqGE2VTpXfxpVQTV
         iyr/yY7SxHXgDA8vjn2pT82seFDpNyZAXx0L+jvfrrN+WOV0waw0MMgzfnVmIKjzKzNT
         q9L2913+vUyT3GEJca1WaF79flpYmOhZO2K2NDhkaTCIO1Pn6ICv7oFdk9P0sXHULXFo
         LY1A==
X-Forwarded-Encrypted: i=1; AJvYcCUgIRrTZox0dOsQnDknkazDdPI17kXHiJYJDVWtl9LUeR+xuhDGkmoFFQHx46f2u3bzeS0FtsBx7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYzLJcVz1/MN4Zshq3fLCxWGXRHt9d+AsBRJu68Ja5v946Bt1e
	mQei069U0hxHzEluW7lpmMEfVaNSJ1mLXrtMp1j9kPwusQSpLX5o7Xb9JY54gjhEdA9OOnI2RuJ
	4HIqrAIdIhKWmlJZed3soMKf5dIJwkklFHeY5izAnYxN3BZvK84ttVkrENPot9Q==
X-Gm-Gg: AY/fxX5cJyNGjPvpYrT3R3bPju0NeX/awIw1Wy9YgJ85nZpNwLtp4clHTxZj6/5VXLS
	jwBQCbjvrb9JtZPrVmElILMUR2Q3jbcuORsgLwjcuUPP66nuL1dsJygG7/hPvm3NpvKMTLh6jTE
	5R3LNmig7BV8P/ky+iwakYyznAKqDxU7aZuXQ8m2177tA/hjwP+3ZRtrw+kVmywNXRnJpZoAOcM
	sj/6ek59aB7DTEKIc7qvwneJy27U5WpLhdOGE0IPzgjM6aJZpQ+OmoE5SM4h1ZpMVgB71jssi8B
	bz1geE3fZFjGCsrxULfOeVXRPvSpEwZJpEdSfawHLZ4RyDJfPGN5ZNS0JQ7htsW9kflipSz9Juw
	nufR8O/k+NtNScnt7dhy3XiyXvKjToN9x5pb1bg==
X-Received: by 2002:a05:622a:2449:b0:4ee:ce3:6c9d with SMTP id d75a77b69052e-4ffa76ccec7mr26847491cf.19.1767683455238;
        Mon, 05 Jan 2026 23:10:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8XFjy35zyxBfC3DOLW8LBR5cVdZzZlCAUK/f6DleVwXoBDQ8jjn4JwiDCBEIoRdJUfETm7w==
X-Received: by 2002:a05:622a:2449:b0:4ee:ce3:6c9d with SMTP id d75a77b69052e-4ffa76ccec7mr26847261cf.19.1767683454846;
        Mon, 05 Jan 2026 23:10:54 -0800 (PST)
Received: from [192.168.1.29] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee870sm2690447f8f.36.2026.01.05.23.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 23:10:54 -0800 (PST)
Message-ID: <f8e6666c-86cc-4123-b1f5-681b656ccf9d@oss.qualcomm.com>
Date: Tue, 6 Jan 2026 08:10:51 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] of: Add for_each_compatible_node_scoped() helper
To: Rob Herring <robh@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Saravana Kannan <saravanak@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar
 <alim.akhtar@samsung.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Nikhil Agarwal <nikhil.agarwal@amd.com>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, llvm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-clk@vger.kernel.org, imx@lists.linux.dev,
        dmaengine@vger.kernel.org, linux-media@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20260105-of-for-each-compatible-scoped-v1-0-24e99c177164@oss.qualcomm.com>
 <20260105-of-for-each-compatible-scoped-v1-1-24e99c177164@oss.qualcomm.com>
 <20260105223644.GA3633916-robh@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20260105223644.GA3633916-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dYuNHHXe c=1 sm=1 tr=0 ts=695cb580 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=i0EeH86SAAAA:8 a=EUspDBNiAAAA:8
 a=o3VLu0Hs6I0nX9ffGz0A:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: jRYsompgj2qTNe-50-gpJDj_fVx94UCe
X-Proofpoint-ORIG-GUID: jRYsompgj2qTNe-50-gpJDj_fVx94UCe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDA1OSBTYWx0ZWRfX8pGYjSBPaA/R
 mmWpGyVwz4NgZyuh/kW7MUNekS1x3eSm+o988+Uc0lP6P5Rwi5ln9mvqKkJWTCHw3M1D7HL9K+f
 6x0KWRmxhzEGqmftZJT0J63cRpvx8QReTyLVh8BZXkpU6B8d3fVHRdtuQWqn6fVkWbsPAsxHczk
 kxr1TkqjGf6TazXngyyle7hIiZG8AoBPNIaE1rxSeVCJeDSAOWmJq02zoYnQUypFXnqOcV1n2bQ
 noAM8IHT7jJZhhtRmpJeIzEIz1YCUfIMRfLl/rlI/zY9+1vbtxG1pue/zuMgvqao02v3l0gMwvQ
 PoO7nCRokYlDe2/2khigYRxRHvQmmkdkapfbB7twznjnsVwE051gWxdL9t9dMGkyKFHIES5WPX9
 3I1V1ztGxlmzFgro5uxiWNaEJL0VOL5ltVb/TAnk4PRmGv61w7lhfCJzrdiFF8DstGILiTi6e2O
 ztAhYVW77lxnQ5r6AjA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060059

On 05/01/2026 23:36, Rob Herring wrote:
> On Mon, Jan 05, 2026 at 02:33:39PM +0100, Krzysztof Kozlowski wrote:
>> Just like looping through children and available children, add a scoped
>> helper for for_each_compatible_node() so error paths can drop
>> of_node_put() leading to simpler code.
>>
>> Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>>
>> ---
>>
>> Prerequisite for all further patches.
>> ---
>>  .clang-format      | 1 +
>>  include/linux/of.h | 7 +++++++
>>  2 files changed, 8 insertions(+)
> 
> You need to update scripts/dtc/dt-extract-compatibles

Right, ack.

Best regards,
Krzysztof

