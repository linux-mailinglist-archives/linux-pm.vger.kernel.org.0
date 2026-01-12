Return-Path: <linux-pm+bounces-40635-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AEBD10D84
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 08:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2C0E3021FA9
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 07:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA5C32F756;
	Mon, 12 Jan 2026 07:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PzwKJWei";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QK4APHgX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E6E32E6BA
	for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2026 07:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768202542; cv=none; b=N6PWQ8XVq7p5OZMxsdv67T/n6V2/ffeT4814jgqg1SjbSO7DIKNfPl0g6qTzowf5Xd5DXJeFZbfpgixkHstn4mL91ybD09qFkiFMZcPMox2BCwD2mUX/WJGxzWc8qtZOy6VK3gDgVtWo+LBMmJzrizLt/aztEi2yRrznoWGLko4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768202542; c=relaxed/simple;
	bh=ztzeNJeVh9oqyHho2eCqBRYs/+UfYJ6VhvgrG5/UMAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c65wXolIku5XXBfPusaYEsQtC0O6B/t2Gfw1NhHCSiH9oLvsbptQ0rC7mvWjWTgAKL3Uoxm893YE3w2xQCC8iOfVYU8JQboTlbOdUZIzWBCQgWzfY78c69mE75El1Iw4vXkYp04aqQKhdEJhYOJ2s14vXaRxyVCILspoMUYPRMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PzwKJWei; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QK4APHgX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60BLuZ6i083949
	for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2026 07:22:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yrgsXQGyq4NPH2ohviivYBqcTq8XLkOffS6n7gtjfF0=; b=PzwKJWeiFGs4LJpw
	P7Cd7dnIQ9XocKJ5S6e4jbhEG5wQOi+sboC7JUbedHHxXmVm/N+GHWTMt6gq31eg
	s3jcnkNZx1FWetPsyiOtQpNB1uKllacut4jgrMODA/BytrdVITl6YqA1fT5AD26M
	jBPvnRRTG9OxGB/61p0wpUIYTxnSB61XAK/dfP4KSZi0uR7xRfh2BBMeW+8peCwR
	nY9EETl8jYywmh2m3JhxjNNZykDDx2aU+Vskq0sWPoFD+jCcQIY/mjnJYLT2I13L
	zx0yAQu7pGNK8imJ+z1D32yB1HCxFIcT9PUE3rHAVkBES5h+SlHZla9Z9J9zEZPV
	RkBFyA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bm8kysyrq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2026 07:22:20 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b2dbd36752so1598419985a.0
        for <linux-pm@vger.kernel.org>; Sun, 11 Jan 2026 23:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768202539; x=1768807339; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yrgsXQGyq4NPH2ohviivYBqcTq8XLkOffS6n7gtjfF0=;
        b=QK4APHgXhXspAytw6KbdrbSIM0W++/qw9E0S0ZCuqrl6UEVNMb2WxPF6LvpVZgAt7Y
         G3ZDBYAxrpiuiszNxXeq5sbgtOFFSIVAoURiKcdloqDw7s9FJ+p9j0/TvTQZj4X2uECs
         JzSmhSgPPNyO1P6KjeJz8AdH4Gv6rCpSeMVNxoqGFFI8VEviSUAMzW2NKq7XwOSMxWFq
         6QslNf1lsmdK1Awk6BxbnhHL1ePx1xYyk9ciYW8djcDFno95i/zGOUiW382hW6241ACF
         UCd/D/56EINNjpjyvMKW8zZO1m5GkM/nJcgAjSV19R/zRCyKshElVgDjBANLIgkOHvdq
         /gZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768202539; x=1768807339;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrgsXQGyq4NPH2ohviivYBqcTq8XLkOffS6n7gtjfF0=;
        b=OwPe0oZzbbTsaR/gIzwdCUyeB6WEUJ7bJrp1ak/I6Wi7SlVumidlAeGdP6zTxXsok+
         +nyzmv/eEYsFf7mNn98aMNZrGFZquXQXHQ2zgbGCrJpXBJUQSDcB67yZQYzm+VtR04Ju
         aPryD+SNWiOtuF+FfPQUg8W+JSAQE1WpJadsW76OViRtY8XePpMxaeQZJzcjHwjq87rx
         9wbkkNw3C1y3LuqOPov68Dl/yXlUpaCGimkHBoxw8miLhZa08li7tIfsPffG7E3jmaWF
         lzOn9p2mpZj5nQ+1NtTY19V7ttRtTLBMAg0HAy7b1Gn/Ot2fMo2J/o8nZ5V0WEzanJRC
         lWqw==
X-Forwarded-Encrypted: i=1; AJvYcCUoDbHp1xOlvHwmESQhAI2LJykBJ552iRZUbwBuxGEwI49Kd24idg4IX9AQsWlF/6krrOB0f5M/Ag==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoj0eLGpKe7LgAu1my5FaicCreKcIVSLGBKUgjrx4z+SYJMBKO
	2pYeBAU5L0qg1cL6JN3I+6GkwK86XhSY1D8zKR48TZQfNhkgGhP58hrFfj8wEOCol6UFDEFrIp1
	Kks7mCTYNXE272dyM6+FSJL02g03u2pLStu/Pmzk/rpAQE8R+UcdCJ+CYDSLHbw==
X-Gm-Gg: AY/fxX7Nydj/cdMlZZGVRZdThJAZA/kxn5tYR61I8U94dWh4U3Z1IogkhPejYCukKrs
	92iyHQ8Q2NuHJykdWZjNMhQLV6WlGIketkKLm9Iu2LGjWsddN16TuQNWymeyf5022S/Pd8/ra29
	/2POmc/8xbNt/wEScVXkd/yO5WeW2bMU+7D7aHCr3joU1mL9PGU6rDsmQqOGW5g4MHVIsx/fId6
	J1S4ct+x9voKtpgsO2gqjRWMdaQrtjBJsDCkeLoUQhsMOVNmArfnE7ye43hVvcF86FeymPDTpzL
	aG4XALrWQYjV7KZHGsWxtg+mylt2JQOrd72CxGaMnPK5EcL+36tc0t2Soe1uIJ75AE/1gq/Bp18
	chVOiJ3ASFG5r4ok35Z35Gzn2dpsdU6NAGEKl6Q==
X-Received: by 2002:a05:620a:414a:b0:88f:c5d4:504e with SMTP id af79cd13be357-8c38941627emr2434909185a.81.1768202539432;
        Sun, 11 Jan 2026 23:22:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IES9LIQV04iwUMzow9lIXa/85Iq+/N7RaXAQVNjXOevpvlUb3E2dgRqc5jdJRCpkDbcV2oU+A==
X-Received: by 2002:a05:620a:414a:b0:88f:c5d4:504e with SMTP id af79cd13be357-8c38941627emr2434906085a.81.1768202538896;
        Sun, 11 Jan 2026 23:22:18 -0800 (PST)
Received: from [192.168.1.29] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f653cd6sm357188055e9.9.2026.01.11.23.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 23:22:18 -0800 (PST)
Message-ID: <92fecd2c-fdee-4c27-810b-4b5ceef09199@oss.qualcomm.com>
Date: Mon, 12 Jan 2026 08:22:16 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] dt-bindings: input: google,goldfish-events-keypad:
 Convert to DT schema
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com,
        sre@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, jserv@ccns.ncku.edu.tw,
        eleanor15x@gmail.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-sound@vger.kernel.org
References: <20260108080836.3777829-1-visitorckw@gmail.com>
 <20260108080836.3777829-4-visitorckw@gmail.com>
 <20260109-remarkable-crane-of-exercise-6bc17f@quoll>
 <aWPUwCbFoIItG7n3@google.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <aWPUwCbFoIItG7n3@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: AP_QGSEfxhnxsqF2Ar8fh9J_q3wfJlBz
X-Authority-Analysis: v=2.4 cv=ZuDg6t7G c=1 sm=1 tr=0 ts=6964a12c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=R1dviKG_3SLBLtS2J8cA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: AP_QGSEfxhnxsqF2Ar8fh9J_q3wfJlBz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA1NiBTYWx0ZWRfX8EbIIADql82I
 1KVf0YpQ+wVqOu0CFUB0MB6xSt2gcCj2Nw2bHGTLDpzjUdMA5uaTb6/hYSxp3EhuftzvGESPb+/
 4tLsJv28JFcff9riAdU7E5qBFm/CJ6pBY6xiRztFKM7Fy3iBD8lE/CXsKeDqpEaUWS1dP2gR/qJ
 J6ov+2yM+GeuxevnxiR1Rtuhn7EJ8J9EaRazCBUGKbtSTFIjuM2chUPYO1sn191SocQOh2EaMKy
 IM62GUmxdTnOSGrxKRuymQst65zGdl2JyIJIRO9sis6sPMeFXa8iVDurcxmc+yog2Ra8ab049RE
 my63OhtFEp9S8qv8DKqyMHlvOX+/ua+hz8gwKLCHLvhIr9xhgAly8DTk1sEKkFkNWEdAVhDcVBm
 GyNlnrTwXpSl+DpYSgf88xhbjaFFaw7GyDAoXjSGDLoh3GPQ4Gka9bfuS1ZYtdxxgrnfXoANwbP
 AoUaQ1AnkJOv2spH9MA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601120056

On 11/01/2026 17:50, Kuan-Wei Chiu wrote:
> Hi Krzysztof,
> 
> On Fri, Jan 09, 2026 at 09:23:33AM +0100, Krzysztof Kozlowski wrote:
>> On Thu, Jan 08, 2026 at 08:08:33AM +0000, Kuan-Wei Chiu wrote:
>>> +
>>> +examples:
>>> +  - |
>>> +    keypad@9040000 {
>>> +        compatible = "google,goldfish-events-keypad";
>>> +        reg = <0x9040000 0x1000>;
>>> +        interrupts = <0x5>;
>>
>> Same comment as before. It applies everywhere, btw.
> 
> Oops, I actually had a local fixup for this but forgot to apply it
> before sending. Sorry about that.
> 
> On a side note, none of your replies regarding v2 appeared in my inbox
> or spam folder. I had to retrieve this message content from the lore
> web interface to reply. However, your replies to v1 arrived without any
> issues.

I think this was issue on oss.qualcomm.com side, because email did not
reach my other mailbox either.

Well, Gmail sucks a lot and brings a lot of pain for all other people
(e.g. LF infrastructure), so if switching maybe avoid Gmail...

Best regards,
Krzysztof

