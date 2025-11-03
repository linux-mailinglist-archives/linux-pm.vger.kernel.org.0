Return-Path: <linux-pm+bounces-37296-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C835C2BADD
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 13:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD5DD4F941E
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 12:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A1230DD1E;
	Mon,  3 Nov 2025 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RwVvNEzs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O0+wTLfc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5098730DD23
	for <linux-pm@vger.kernel.org>; Mon,  3 Nov 2025 12:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762172632; cv=none; b=M6suZaL0KyRiAWYS/lJ7waur8hJWfBuXw7Ae1PkcTSAd49bltDFw1P18+EK5ULVU4aK2zuRFr8JlzeUw3/GMZ4kJecJYtkyeMAat/Y/HvzbAGies0R4RHrQvtyQWM6UNK6yBLsfl8xl/Ebj9oFAZ+H+CWn859BI7CMmQhwdVk+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762172632; c=relaxed/simple;
	bh=GL67y7dtpFN+c7EYfHg2LIS5mPBVg3wakU2g90qprTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JBMI9QZX8yLf1hiLtVb/v7pJOY6RXMAbugp3SWmAXl7eB9wxCX6ie1RmxYqgHc+03lL1Mrmj3wZ118m0kKDNmn7sYp3PLMtmBgz1mT8ozTYqTJgLfChsHUu/k9PCvDSnh1eO96sWoXtSMxXX/44YA8l+qisHHVeIrz0ml0ruioI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RwVvNEzs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O0+wTLfc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A3B5ucG2906643
	for <linux-pm@vger.kernel.org>; Mon, 3 Nov 2025 12:23:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pLDocl8OIbPcP+9ub1WxgqdY32ZSLXkBpKRcN7PVu78=; b=RwVvNEzssueT+rXy
	gr0p6nyCoKHoUo7l2WxXOJE5SoNfTzbHjm9SbjptxGZH9CXGXFKyWQBXvinacwnA
	fUvl0XhE17esXfaZsQ5wjP5P+VMjCE38SR6c+Ei0XuVqjHV8cknEArX9g7qxVLak
	nEqnbgaR3/Cx9WZBUf42I5ikzdksvgNhFNDeW62gFr0yKu7nCTphE6hK82YMPgRN
	SFa9m/GCb7W608WFlnxARpVlMn9xdRxJiJC+Nm5zu1Qlefnb4fr+MjIMPHtLvbPu
	loUaXyiUFQFq684GCMYYyAFn/SpwlNqd6/M6WQdNEtcfn61N5Ixv3I6rIVH9bZm3
	TdDKVA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6u7kr5u1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 03 Nov 2025 12:23:48 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8801e695903so7107046d6.1
        for <linux-pm@vger.kernel.org>; Mon, 03 Nov 2025 04:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762172628; x=1762777428; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pLDocl8OIbPcP+9ub1WxgqdY32ZSLXkBpKRcN7PVu78=;
        b=O0+wTLfcIECFdCKr50YPXEXznrpOYs17RRa3kt9hxu2U0fSo0tYT3vT5b4sS1idf/Z
         H0Lci9thUSPO8zXzLMYmXgeBa6z2WBkYWiIFBbfPeN6OXqvennVLpscaM8DyJZQvgSOg
         0Mqv+FJ4yel+KuPxSx0OPWtSpM98gdWgvaCY6FgebFFZEDhrPkNSIYsmwiu0HJF8jT4m
         UcwNrNPJ/4DnETQCpCgmdfVM+PJJ6+5SI1VBREuVGNrNTJumIEVoTKQJXhF5sU2VpsEV
         sUGJ5B1kPe85P+r9IHNp7kNXnxbGaR7J5ChrU9ZZlRV59OAynp+Ay4xmzK+Tef3+r3ad
         HJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762172628; x=1762777428;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pLDocl8OIbPcP+9ub1WxgqdY32ZSLXkBpKRcN7PVu78=;
        b=doU3wJgiBO8M/kPFtXKd3ybEtqskOEs9ADIGItehsCfJuv1Ypds0mjluQGnW5++wcK
         /u246Qt4GCTd4r2mVDnSodp908/cK5J+xof2StsdwiwnYVoWanUCJg2zyk9nwYcWOL76
         AwqNICfVNDCbLskht2rUwp8M72eRS/O4eDJZJsq1ECrGx+8wCsx6HrSi6sTA7Yh/V8oW
         gTkdabTpHi3Y4AS7Q8hFNbPnTz3xAneUCBtxg0P4RdssHl0hZklBkUNIxqr9GGxfwwbm
         dNOUXpcQ4HuMZH+DDOpuznptsVkKUYuSAvh73PMOck3n2v0XjjdhPerFyqACGr5/EgI5
         3wDg==
X-Forwarded-Encrypted: i=1; AJvYcCVr2GUcJ0xanz9M/g/1d0xVerX1Cje+VDJ0vEUKgCHe6E/Sap6l1bF8k3e9QvxHG3d0xD7Hx3AJKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm+dT9xT8bkLc2ZuijlYq0nt47B1vkHtHLa1oNVZfYS9dxHTok
	FZdRzXjieMQ2D1ZqFrIhLmrKOaiAVNCDXkMxEVDaG1Gcz0a7E6vsPKKK5Ss/1YSj2/BOSJXyBV+
	pk09RVJaDeeRzpqNtKSPz/bZ2bRGXVpqOTyTtt61GhWugJxlvKjPdCCqkEDX4HA==
X-Gm-Gg: ASbGncsko/gyS14TSJJB+kaFMhZ+irzZvjJ/lHibF+0USmX002Hj2yrK7WwOVy5EB4o
	7nu5+wVzHcIdpQ97Xg+bgFKNrIN2LK5DBazKUUkb2T7mo/EruilgijueNT2GcDx8bBtHgbdTm26
	EB+wu+xXaGri1308R/cAah7MDJDta6tIsooBERmJVgixgcwFR6LNE/gggt/mwACTTTYSH5o/gKE
	XHfcv3ycVpchBhvKNoWmNF6Nxq0i4/25BHXMKXMd2e3mWrsOrfWYVRDO6tkOBPL042fyiMl1wUj
	poInfgWlYfNRpc/1fW7MEJMrc/dBt82CAYkaeOWfeuMw0WDPFPWwVCAROAxlVLlrwUoSsTqStuh
	ipCPSAH7lcr/Be/6CNNdNMK5q9qADgQonYEiFPc7AOUfeacW/TKB7INzs
X-Received: by 2002:a05:6214:c86:b0:87c:2360:d41f with SMTP id 6a1803df08f44-8802f493160mr98182196d6.3.1762172627394;
        Mon, 03 Nov 2025 04:23:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHNEHFu5uzZ0tS3YbeG5ybPjbh0d4UBxSalGY+3hESR5a39mHj9S8jaxD5JqLSDjkMxCzcSQ==
X-Received: by 2002:a05:6214:c86:b0:87c:2360:d41f with SMTP id 6a1803df08f44-8802f493160mr98181806d6.3.1762172626865;
        Mon, 03 Nov 2025 04:23:46 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6409012a6a2sm7946707a12.23.2025.11.03.04.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 04:23:46 -0800 (PST)
Message-ID: <0fd020e4-636a-4bb3-9c22-7a5b16e4d3c3@oss.qualcomm.com>
Date: Mon, 3 Nov 2025 13:23:43 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] Various dt-bindings for Milos and The Fairphone
 (Gen. 6) addition
To: Luca Weiss <luca.weiss@fairphone.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org
References: <20250905-sm7635-fp6-initial-v3-0-0117c2eff1b7@fairphone.com>
 <c93afd94-9d94-42fb-a312-df6e26bb2bc8@oss.qualcomm.com>
 <DDZ1X799V2KV.269J9YL1AGCIF@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <DDZ1X799V2KV.269J9YL1AGCIF@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDExMiBTYWx0ZWRfX8h8+fFavHM5l
 cO4jJwRvCEUfCH8Xy/wZ7e1cI7px9jebHeG/1wQdObGaysnhTbcQa70NpYbzKHSxWT12Vg1ow5q
 eKb3FgyvD9uZpPgMOFHnV31o0bQC8lvDQGbhdAlBWETVU5GplevTFEqKGExy5MIf7Veon6Y60sE
 hCboNegRph+PPO3v3DPxrI4ueBBJeQQ4GMNX44WGZq0Le/vQDfz8Dfw7BWvVsWjvu/TGIo1Kzme
 EDKTa4F8h0uATWI/PaXctgMqQYJsV4nYRSAGyujbkds7Jr2FNCDMrIPaniZcdAEHdm/l65fBMxZ
 zO+l6OYJ6ifbWZ3WSpxUGRe2KSymTVJCLA+JbntyXxiNWqodK3gPsznHlEFFtKJfqltkpR70bLh
 gihaAjzsczFwQsDSnAH/io+1AXTcpw==
X-Proofpoint-ORIG-GUID: IPUpTczV6VDrgK5eIE8K2lartJ0EebLI
X-Proofpoint-GUID: IPUpTczV6VDrgK5eIE8K2lartJ0EebLI
X-Authority-Analysis: v=2.4 cv=Q9HfIo2a c=1 sm=1 tr=0 ts=69089ed4 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=6H0WHjuAAAAA:8 a=ySytLBbe-S1-HUGBodAA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=Soq9LBFxuPC4vsCAQt-j:22
 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-11-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511030112

On 11/3/25 1:17 PM, Luca Weiss wrote:
> On Mon Nov 3, 2025 at 1:14 PM CET, Konrad Dybcio wrote:
>> On 9/5/25 12:40 PM, Luca Weiss wrote:
>>> Document various bits of the Milos SoC in the dt-bindings, which don't
>>> really need any other changes.
>>>
>>> Then we can add the dtsi for the Milos SoC and finally add a dts for
>>> the newly announced The Fairphone (Gen. 6) smartphone.
>>>
>>> Dependencies:
>>> * The dt-bindings should not have any dependencies on any other patches.
>>> * The qcom dts bits depend on most other Milos patchsets I have sent in
>>>   conjuction with this one. The exact ones are specified in the b4 deps.
>>>
>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>> ---
>>
>> FWIW this looks good.. where are we with regards to the dependencies?
>>
>> Are we waiting for anything else than the PMIV0104 (as part of glymur/
>> kaanapali)?
> 
> Hi,
> 
> From my side, I'm not aware of any patches that have any unresolved
> comments, so I'm essentially just waiting for the correct maintainers to
> pick up the variety of dt-bindings patches in this series, and the
> PMIV0104 and PM7550 series.
> 
> Any advice to make this actually proceed would be appreciated since most
> have been waiting for quite a while.

Apparently I misremembered, kaanapali actually uses PMH0101 and PMH0110
and PMH0104, whereas glymur uses pmh0101, pmcx0102, pmh0110 and pmh0104

(it is not easy indeed)

so it looks like PMIV0104 only showed up with your series.. and I'm not
opposed to it, let me leave some review tags there, and I suppose I'll
just ask you to rebase this series on next & make sure the bindings
checker is happy

Konrad

