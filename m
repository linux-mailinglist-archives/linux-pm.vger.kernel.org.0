Return-Path: <linux-pm+bounces-31522-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771ADB141FA
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 20:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C4E0540D0C
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 18:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D64275AE2;
	Mon, 28 Jul 2025 18:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="op+JZmYr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEF72727E1
	for <linux-pm@vger.kernel.org>; Mon, 28 Jul 2025 18:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753727388; cv=none; b=LSbyapGg+GP1IwW9ffW33qsitebE4zTaVvx2wd1HawQ7YofM8zcZHJAxOBoYZ2PoTDkB0qqd8a4RRqKSaUJ/Hjj8lwNvojcOvC9WJcth7yZr7MALtdcup8VXA8rFa0NCiT6i/mRNDaPUtiz91yCbZp+Eqkgd5ivt2FJEKqVJkec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753727388; c=relaxed/simple;
	bh=Zgzq5fUBiscuzMXprNY3QBGKYe4UUihhhz0vOaibSdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R0BjSDtZRlLIho1qDvJBMoD2jC1kisTXyCzae2kTmDIeghHLV6ivvhDtYih+2TpDYmt2J2uAef67SfxPs/nJ+lRVEYSzI6AiYPPNbrNjrS7mJLqDIHIhhzd3b51XMg66sOkOhLRdr671HA63fgzhr2JcXrVtc+Oaeq/yKp9X1SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=op+JZmYr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SAlO2e018349
	for <linux-pm@vger.kernel.org>; Mon, 28 Jul 2025 18:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OvJzrl+/UhBa3hmO88GolGsvDJxBlDvFKg+LbxKyh0I=; b=op+JZmYrnrYaiWf9
	IGp3irs3z6UtuOaL1T6sn68k5fQnJKYOdAIy+9hLRn95GzpMzoxWoBJpLaVgL3D2
	HdNtuN2Io4BgLvzgTkem+QbYncYROwAAImE4kfdJLXGuoS5z59ykf4pF9xMf1q+0
	IDsYzA/6AtGblKj3szpW5Z+Jel4+v2WeOrWMqQ/zlilvBRc0qbRz9E+Ka8DRf8ss
	lqCyU0Sc9heQ2h/eWrnGX/CnF6Pq2m4goK17gdFfYGwoLfzmxwdo5SZiPIclM3EQ
	e+g/LprGV4KIl1YHU7d2oZjsac3UF2cc58Z6D5VDvU3kQLU7ik20uZ5Tc0jEsYpO
	K+QD8Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pbkwfpx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 28 Jul 2025 18:29:46 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fad2a25b65so88374946d6.3
        for <linux-pm@vger.kernel.org>; Mon, 28 Jul 2025 11:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753727385; x=1754332185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OvJzrl+/UhBa3hmO88GolGsvDJxBlDvFKg+LbxKyh0I=;
        b=OG07PPPhutvjYyWzn/X6StnzpY/yiNBINRAYRPAp0p6GQp+sKcV+ngPDvnCefGivkP
         rjoH+JNwyE61EL8s4siTYhpYzMhy9TIKL0MXISBexk9udm0KHBPbXzxlRVNz+gZ18nbu
         3Xwg14IDAiliUDP2HsEFk/MdEs7Aa6aml7MazhiWQCSHvmo5JjqVjzFqtaT3FBCE48xz
         CP1zmpd3k5gS2A8ZeweqY6xSI3BeNg7Rm1t/vNN0oO0FECagN/kx939XLxFP3s9yuYDj
         F+RJGUO0neq2jxpehgPczBkGnwHCNwnLq7gXQmyGSLSRYzmbK9EDuX2ce6FYRzPYRKaU
         9h3w==
X-Forwarded-Encrypted: i=1; AJvYcCWfF5meviC957DYQBtB1CC7lxhA+13nRCszQC/6MTMQxepZgvRBefRzf54SB3CUv80cfgu0vw/bKg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9hkzNN5OBbmubqU4YZK3e9Qd9WnXus7LN3naLy0tJJWQp2QrL
	/4GoRtqmFRo90RzVB0RDmnOdUSlm1xQQtfi70PCOyWw0h2KyxA5TWWO3VcqH3G+nX5ed4fNo9xU
	80KfZQn1eS0HfBcgRc8VoD4I/3cGYWwEq/zqqGLwRQq/ObNhaMQgqrv6KOmnSog==
X-Gm-Gg: ASbGncvGdskDcgOuX4uRmY1PAhG3sSyCluxpIjzP0Fu2I5VJmTwRj86vBEqGgJq2fox
	NU0LbAnQPL9Hg0+bOWPtkhGWTg7E8EUYJZBK9yk2YGL/jZKiA/QBaG7wDn1Wkm7OyH5vpx8Lkvp
	d1KT7tQ2JQh68nzfuIfM7gaPQxrW2SZJFG7jWJnno7DjKkTX4+AmsdsTEKAcPjBOYWGgV4EiKop
	Wu12g2jZ5OjqGAqcaQ9tDPSq49ou3swM0HMrS2iBiBYdkhZ8K2RGQy4TM9f2w7Hj3RF/D/eSOvY
	+ePcHZnEJNt5waPW/9tb8r4b+k00cGJGy/s76j4TLjwiVmY+srnmUVc94/2PPcuDKTL9yZBsCc7
	ygWzWF55dGfs6LvTWJOyxce21uytdEy5u0tsLK5yfWdnoByVSOUfmtB0T1sGgKWDY9z9kPQiM2m
	lpAL7xbNCRuWRifYTnXg==
X-Received: by 2002:a05:6214:226e:b0:707:159e:d1c9 with SMTP id 6a1803df08f44-70720658229mr164970406d6.51.1753727385096;
        Mon, 28 Jul 2025 11:29:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSNgPB3zFf6oPz//UBdRYzoglKZ/sN+oF3kbq9PUMHp+iEJ5arlOsVMtajvVAOtS+w9j00QA==
X-Received: by 2002:a05:6214:226e:b0:707:159e:d1c9 with SMTP id 6a1803df08f44-70720658229mr164969656d6.51.1753727384396;
        Mon, 28 Jul 2025 11:29:44 -0700 (PDT)
Received: from ?IPV6:2001:14bb:cc:47df:51b5:3653:9304:7ee7? (2001-14bb-cc-47df-51b5-3653-9304-7ee7.rev.dnainternet.fi. [2001:14bb:cc:47df:51b5:3653:9304:7ee7])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b631a186csm1366470e87.78.2025.07.28.11.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 11:29:43 -0700 (PDT)
Message-ID: <2d672126-ca4d-411e-89cd-f40f8d8a4f5e@oss.qualcomm.com>
Date: Mon, 28 Jul 2025 21:29:40 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 07/10] firmware: psci: Implement vendor-specific
 resets as reboot-mode
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
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
References: <20250727-arm-psci-system_reset2-vendor-reboots-v13-0-6b8d23315898@oss.qualcomm.com>
 <20250727-arm-psci-system_reset2-vendor-reboots-v13-7-6b8d23315898@oss.qualcomm.com>
 <b81aa592-a66b-457b-9f42-df4505b28508@kernel.org>
 <3gtlf5txxtioa5bvo6o467jupyoam4hjhm2mdiw5izv5vbl3tz@drndgp3tcrgo>
 <bcef34c3-98b4-454c-8138-c73729e17081@kernel.org>
 <5e2caeb7-360a-4590-a36f-ff1ec4c20d31@oss.qualcomm.com>
 <2a39c0ab-edd4-402c-95a0-a6286f03102a@kernel.org>
 <1926e6e0-70a4-67fa-5e91-cd0155af1eac@oss.qualcomm.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <1926e6e0-70a4-67fa-5e91-cd0155af1eac@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LsaSymdc c=1 sm=1 tr=0 ts=6887c19a cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=v3ae4HcI9OlR9PdQa4UA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDEzNSBTYWx0ZWRfX4P8SyX8LH4qI
 vwi8WyXu+Uk9M09X5jN69+rpd/57hRcf9ZXk8HvFLQdzEQXHAC+k2dEnRGestt5osWxwzvEKHIG
 G+ro1KrVMVVwUxQPwA5PuECEKN815vYF5yqzh4JK0CPS+qufxKg0b8CRweY+cvVJHQyJTPtB1Bp
 b6vX2ZPZfBeFeJJ5FupIsUuDc3P+Ur9S0oTlRUvcsSEd04g1nYAPt29ixYxHFZWGq5i4ylHpWVe
 KWt6p2HV3GOHJf8k07AuL/chY8qTNucBj7rmdXYfaj6skE11sGWVAfU9Do7hI/6FDXR3AyVhzJ2
 Wcn0cpJK5Cxn8ieLkXQBNjvA2cGOBzzMIx6GGEWG3VGbpScsT3371pNA/xwm6r0u9zF8he/CQke
 TotGUkDEvbiKnFiO1acthjYhE0wt9Eh5TER8hKnfm4bdZoqBifn6RnP6fTKzz992u8wU2DL9
X-Proofpoint-ORIG-GUID: bEaRmKkShdpR6QmKS97Z6MaXo2TO3sc5
X-Proofpoint-GUID: bEaRmKkShdpR6QmKS97Z6MaXo2TO3sc5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=990 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507280135

On 28/07/2025 18:54, Shivendra Pratap wrote:
> 
> 
> On 7/28/2025 5:53 PM, Krzysztof Kozlowski wrote:
>> On 28/07/2025 14:03, Dmitry Baryshkov wrote:
>>>>
>>>>> and the reboot-mode is defined in the
>>>>> previous patch. So, I'd assume, the path is defined.
>>>>
>>>> As I said, path is not. only psci/reboot-mode is.
>>>
>>> Do we have an _actual_ use case where PSCI node is not at at root node?
>>
>> Yes, many cases, because it belongs as well to firmware node.
>>
>>> If not, it's obviously a deficiency of the schema. Could you please
>>> provide suggestions on how to describe that in DT schema?
>>
>> I do not see deficiency. There is no ABI that psci must be root node, so
>> there is no issue to fix there.
>>
>> If you want to add such ABI, I will answer: no, don't, because we do not
>> want paths or node names to be the ABI.
>>
>> Compatible is the ABI.
> Will define a compatible for psci->reboot-mode node and use it to find the
> node. Hope its fine to define a compatible for reboot-mode which is defined
> as a property inside psci?

I think it was more about finding the PSCI node.

> 
> thanks.
>>
>> Best regards,
>> Krzysztof


-- 
With best wishes
Dmitry

