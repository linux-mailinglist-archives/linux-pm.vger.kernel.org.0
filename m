Return-Path: <linux-pm+bounces-31118-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9307B0B6A7
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jul 2025 17:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C31A3B6DFE
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jul 2025 15:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DC321D581;
	Sun, 20 Jul 2025 15:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aPpK+mCf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351EE21CA14
	for <linux-pm@vger.kernel.org>; Sun, 20 Jul 2025 15:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753025055; cv=none; b=q+E0noprIFCyek+J39FYJXkUuB50un6ST/Qrd6NW2J0Fr2RMOpUbXn8vQ7fpDBOLmFeYHZUEHidDrbaZNsInh0LiAyyvcWieOr3UDRAVrq4BQgLDoGHyJmcYJJOOEgrVfIofBCFGMOx+7HBI89DQiGag0FgIlhGFABMSC4VU6Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753025055; c=relaxed/simple;
	bh=5RovnvTDAuovyn4cAtpqbi9TnjFhXvo6Fxsbgus1QVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EzgT7Sf+/w3/QvsaM2wkSLIJnlyc2FJPY+RM1caGG9Oej1WfunDZdbUdhNk+WGX1X9wFJKRsfzIXWyAiaQjd+izWdLeqJfvVERPnhhgKLdqtdXKlU2Buw4SCeNKpHjPZBe3jH0scQZ4gB8pGf18tgbe3Sst0kW4HkDA1wDxkad0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aPpK+mCf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KDQ3bi000306
	for <linux-pm@vger.kernel.org>; Sun, 20 Jul 2025 15:24:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Cn5tyQX/xC6r7LynCtZ+cKfCSqVjcFVIFtjOQjXs2ws=; b=aPpK+mCfhjIK+hdD
	kc7epzo/3ZcjON3f1eCOhZl/+jNOdPGmcQe0iNhhRhkIZJxBFvmBjEoG1lDhrawW
	WKq8fUcUjITAkKZzMs73dSdMwxcenkCPDRygzrp9jTPA5TCb+IpU5l1TO9gUjEjn
	ONgP98f1kU/BXLkWA+J5p+fvp4ddAsZCNepIyspJVfaCI6rC/WhfESxgFavA0MQj
	xyUzWh6zHybxc0wpKiHYy6v3wdM1ZNTEUA9HpxdNwFdx7oe51MwYXq20yqCTd74B
	OuFamdAimiUVF3VTbfn1qr3alGcNCYIS8se8lgB8HqvLoCOma2tcZP4HfSkiwwsb
	fGxYvg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048tac8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 20 Jul 2025 15:24:13 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2354ba59eb6so50628715ad.1
        for <linux-pm@vger.kernel.org>; Sun, 20 Jul 2025 08:24:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753025052; x=1753629852;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cn5tyQX/xC6r7LynCtZ+cKfCSqVjcFVIFtjOQjXs2ws=;
        b=D5M/768kl782Zorwt8xqq3NrNGPSPG4TNSzYVzLKmtO/2eapwUscJfYr+cFVuOQdgY
         dc12YuxJ+mrR4Rh/ZFuBwTHYh+Bgn/GXv/zCvuzwhDBIpb1UGp/o4SdlPAHTQg76auHh
         GRpKs6ZVbaPIsIBs7BDktINn5x/KC7Rp4XmapPiOjW3MH2PKvsQs58dkiUoIws3Zgqzp
         O+ByPVgFOF0DGpzJ9ivgdt4MlM56nD/h2vfgm5qfKK5eI1ros5hSr9bYb2d4gUsF4ifD
         lqYdtJvxOurWv+3MyREOCTRTgjUlYi7tQBb+zvjhfKQawnL9KySwsxH4btKQjWS51KkQ
         CBTA==
X-Forwarded-Encrypted: i=1; AJvYcCVjy7Mjs60pW2KllRleAQR+IhTl3xTJtyPS6tAiNlnliEvI9T5P0/DOzPA4HYVnwhgyIpvMMGN+9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZqeZqtsp7n8EO2tYkwv5JzJcZ3M1qlnpX81QI+DJ34K9NeWF+
	8eDFZ0+xDmwrXVE/RhP6g9zEc4zA905eP18BLnM9jtzgy0LQr2v2fEGJNgxeIaZvKhzpQg4Zx+U
	PdkQXHwVZ/jGTvdWp86U+fOmS+Ie2x+L/s6ri+8CVaTbzY73IIGXYwt+K61CzQA==
X-Gm-Gg: ASbGncuNQgg23TZT0Mg/Q/7rgKOyDGCu0BgHq2+SR1RfFt/19kg3VmhjaUKiwM5x/QZ
	TF1EmPK/RDRuvmADZ16zwjYVXgkRhikAiqRUCvylB3jk9aWXpGzfJQawLC7CSi3DVfdUrbNaX0K
	T2hmsI8YIB24M/fT01RXC27va6E23RS/PGrlH3x1/9UUDIRLUd6hJUlZBPF0UMm26Har4CJDVhD
	z2RExnF2KCPv51gtfWbzcPjuStdYotNma9fqVFgBZJofJ+acwcoR+n8kxVPg3ujv/bqMZP0VaFM
	R5TWHu72yPVYwhehFZJDXIvti9P4W1hudb65N117/3SDJ56RYNkgum4riVTFrrT4plGFKGTvife
	w
X-Received: by 2002:a17:902:e845:b0:234:d7b2:2ac3 with SMTP id d9443c01a7336-23e256b5f6amr233001535ad.20.1753025051552;
        Sun, 20 Jul 2025 08:24:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUOqsroGWNvuq0aBkHthsIfTFvGKyjKlWXBZvHeY8vMrQhZYhY78dv87gCgxB4llexBH7YVA==
X-Received: by 2002:a17:902:e845:b0:234:d7b2:2ac3 with SMTP id d9443c01a7336-23e256b5f6amr233001145ad.20.1753025051069;
        Sun, 20 Jul 2025 08:24:11 -0700 (PDT)
Received: from [192.168.29.115] ([49.43.229.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b561bsm42672895ad.89.2025.07.20.08.24.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jul 2025 08:24:10 -0700 (PDT)
Message-ID: <d604104f-837d-34e2-ac62-261a8ccecfed@oss.qualcomm.com>
Date: Sun, 20 Jul 2025 20:54:02 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v11 2/8] power: reset: reboot-mode: Add support for 64 bit
 magic
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
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
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik
 <andre.draszik@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>
References: <20250717-arm-psci-system_reset2-vendor-reboots-v11-0-df3e2b2183c3@oss.qualcomm.com>
 <20250717-arm-psci-system_reset2-vendor-reboots-v11-2-df3e2b2183c3@oss.qualcomm.com>
 <6vlm3ybjpy2jq3cr2pzj4vcmqwoissdml2xmhfzlulfbrpzakt@xrepu6c5zykb>
 <713b2cc8-1bc7-a8b7-678b-5fc7fe25615a@oss.qualcomm.com>
 <8d4a42b6-657f-4c30-8e25-4213d8d53a89@lunn.ch>
 <1653597d-4d6b-a771-fbd8-c129c630ac0a@oss.qualcomm.com>
 <6227828c-5db0-41c8-956f-eea6f790ccac@lunn.ch>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <6227828c-5db0-41c8-956f-eea6f790ccac@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDE0OCBTYWx0ZWRfX8SdSnxIVChmm
 2lWfygs1v2zJozLlIq28VycC7GbGvvKMB8flQF6jaxd73MOuoVT2q5lg2Gfmp/ATfjiqCB/kW+q
 u6Kb8Xs5mPcUO8x4UdsxQRk9pN+qV5/A3tKcfEmf1rJYSz448nj18GfyPHWbfDvLlF9FFdpTCt+
 QlFT9ePGOBbhIvTVTJkHbieuTA9szFEZY1YBP11JfNxlNrz5vdzJkvLVcd+vCzdHCz/OREhsUYs
 uQOItx706L76eBwnBZDoaFkOqBA/Yu+UXyKQP6redYXhyKsOKx8Y4azNAq9L6YEExogTNmkomaZ
 ix2bKfJCzEBfUR/Y42pyrPgZdcgxN7MxbPMilDySfsPyEeZmnRw49JSTwUZ5XNsp7BlkNmqaTJn
 hKusH/iUcWDX0HxSIq0wPjrAu+bdESf/st37WmYsaY9yNwQ9yMzhWxiCYpaQjhZf6UHBvmdP
X-Authority-Analysis: v=2.4 cv=Jb68rVKV c=1 sm=1 tr=0 ts=687d0a1d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=AKgrFWMC3jRjh4njwhq9Fg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EyloEgBdZQ85O2IC3a4A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: _YzNCnW18M0cj6lLab6gQCHmTiBjUjyS
X-Proofpoint-ORIG-GUID: _YzNCnW18M0cj6lLab6gQCHmTiBjUjyS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=822 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507200148



On 7/20/2025 8:46 PM, Andrew Lunn wrote:
> On Sat, Jul 19, 2025 at 11:07:47PM +0530, Shivendra Pratap wrote:
>>
>>
>> On 7/19/2025 10:27 PM, Andrew Lunn wrote:
>>>>>> +static int qcom_pon_reboot_mode_write(struct reboot_mode_driver *reboot, u64 magic)
>>>>>>  {
>>>>>>  	struct qcom_pon *pon = container_of
>>>>>>  			(reboot, struct qcom_pon, reboot_mode);
>>>>>> @@ -37,7 +36,7 @@ static int qcom_pon_reboot_mode_write(struct reboot_mode_driver *reboot,
>>>>>>  	ret = regmap_update_bits(pon->regmap,
>>>>>>  				 pon->baseaddr + PON_SOFT_RB_SPARE,
>>>>>>  				 GENMASK(7, pon->reason_shift),
>>>>>> -				 magic << pon->reason_shift);
>>>>>> +				 ((u32)magic) << pon->reason_shift);
>>>
>>> As a general rule of thumb, code with casts is poor quality code. Try
>>> to write the code without casts.
>>>
>>> Maybe something like
>>>
>>>       If (magic > MAX_U32)
>>>       	   return -EINVAL;
>>>
>>>       magic_32 = magic;
>> sure will update it. And in above, should it be recommended to add a explicit
>> cast(for any avoiding any compiler complains)?
>>  like: magic_32 = (u32)magic;
> 
> I would hope the compiler/optimiser can figure out from the test the
> line before that this is a safe conversion. So i don't think you need
> a cast.
sure, thanks.
> 
> 	Andrew

