Return-Path: <linux-pm+bounces-17059-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A09F99BE20F
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 10:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65AFC284C1C
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 09:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AAD1D63EF;
	Wed,  6 Nov 2024 09:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="li8nmCy3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBA11D5ABD;
	Wed,  6 Nov 2024 09:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730884353; cv=none; b=duAZNKr5ayl0eUuj8STsyM67zt6ribpc0ecrzFEdWyTh0h3KjiRnjqKgkCURWmih1tWCs48DmFzVkHFj0Wtp8LrJGZpvzBKs+W9INAOas8IFO5ruih/l03qFVxmF/88TgA4wHkRyTDpvKAEkDKiWC/1yErtOvboMnw+e+CHZqcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730884353; c=relaxed/simple;
	bh=vBtPgAq5zkwFfAZqksVHHgW8EQlGOUc2Q3SmQIcy0QE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=szRcaqb4H8tSjkeWoGQXXMkOy1kPfX7IbQfkK3tnb+EopnlJKxcTIYR/AU5F2eigt7sFbCD/QIHTO/MonEb1bZb0h557HSx2hg6vk2Kj1sadkLDjGq4b+100hPgor8NbJTgsLrF1qJCYxU9FYMeayfQ709kuO8mCg8KIpe2PVto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=li8nmCy3; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5cebcf96fabso6256472a12.3;
        Wed, 06 Nov 2024 01:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730884350; x=1731489150; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7nW40zqFje8srCjiR5OmAVUxOIYZzyXXm/hFeVlWl6I=;
        b=li8nmCy3ab6R5GuFB3Q8pbV0Ho/54yFexB+/7dPVn5ge0d6WM//e/Twq0+Sh9GijHx
         zB/ePIrhG2LYyceFk3iGq6Jx+kbm9SYyFS96OH2l+z4DzNYbFpIUYoVPllWVhEMqON3u
         SO967qEgyJV8rj3RJDFXUjjrG4bC8swPFrytxr0GXasDAweAwOISvL6GHWzHt++rLpQc
         GrLbTam6uAwnb3hwpFoppj8R5BPCMUNGPef0AF6f8Wj042vAkiE4Vbl715HztOt6+irm
         BZzTlWGOwHav9DhtFWJBZ0llVegaz77/HFo8hq9GCQ+m1QHrXeMAxPqxyLPkfxzZCH3N
         9IMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730884350; x=1731489150;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7nW40zqFje8srCjiR5OmAVUxOIYZzyXXm/hFeVlWl6I=;
        b=L+RFlvaoZ0c1Bwcv0Sye8EOrTxV2xbfEaBiTzbIuwSp3Qmf1SYYnUUML8JpBnzgc4T
         lu97YLeercFJJOV2Ir01Q3mquBakUn4fEVIqeHzQX6u3X4a+7Org207jaePMcfEBM3I/
         YyzibGotREPnPb9IcFH36MKqUJSZvyFNxowA3TnLGBvC0UiP1z7j4l/GHroVwn1V5wuf
         fOAIxGTcG+tyMVbSccPVYRQZ7XHi4ZYDrXzz9bwG05neK5rT9TfI2RSHGOEljj4GHzWU
         Hlhex73iLZ0pRhTYkk9lq2GHxHq797gp2g/yv9/CDHQYWJsJ6bUGCsbJt6NlES3FDuvH
         zGpw==
X-Forwarded-Encrypted: i=1; AJvYcCViY5CLcVfHLFBagO3hTH8JtreJyaDYRClkjBeR6TVeYRrH+brGhMgVLFJVfQwZQJIFMpFuNyaKGHK25baVzQ==@vger.kernel.org, AJvYcCW3VN8pUjhd4FzUI/wNgufapuYtkUUJnY+zy88uuIorgeSyzTX4Fb4oo16AD2F9n40u7gBbnmekwa1uAbrt@vger.kernel.org, AJvYcCWJAepcaTOQ2Xfw1/bH0Pa2JoX94bmA6vlQbEJ6twK+hZgN/FN2Y4bSfWbkNUURgUHkdFvYrr2Msms=@vger.kernel.org, AJvYcCXhyNpa9ik+kfW4S0Gq+Dp0sDGitA4RjQaMqhulzM/8VoLoljYkTNrcX1NsaaLJ1NHz2F6QxRW2uDQy@vger.kernel.org
X-Gm-Message-State: AOJu0YwncUiO/GRhdNBXLx6CsLV4ncQ1QKl0v9mhFvlNyYOJETv6RqeQ
	2jj0E0NitvHGdj/cLiNR1YBOmWeWDMsRdqB1xkvNMYlgavSCzxQf
X-Google-Smtp-Source: AGHT+IHV7R7KK9k7MSo6cyQksVmBATZQ1s9HUzySsITu23MhMBSld/91CVKjIp26poEYOqy04HF6jA==
X-Received: by 2002:a17:907:6d12:b0:a99:d782:2e2b with SMTP id a640c23a62f3a-a9e50938952mr2045392166b.30.1730884349784;
        Wed, 06 Nov 2024 01:12:29 -0800 (PST)
Received: from ?IPV6:2a00:f41:90aa:ba3c:cb43:651a:b4b2:c19? ([2a00:f41:90aa:ba3c:cb43:651a:b4b2:c19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb16dbd38sm248935966b.73.2024.11.06.01.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 01:12:28 -0800 (PST)
Message-ID: <2c7ece9d-95e8-4d01-a9da-c1d5d7388771@gmail.com>
Date: Wed, 6 Nov 2024 10:12:25 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] arm64: dts: qcom: ipq5424: Add thermal zone nodes
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 srinivas.kandagatla@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, amitk@kernel.org, thara.gopinath@gmail.com,
 rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
 lukasz.luba@arm.com, andersson@kernel.org, konradybcio@kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20241104124413.2012794-1-quic_mmanikan@quicinc.com>
 <20241104124413.2012794-8-quic_mmanikan@quicinc.com>
 <91ea0f03-9bbe-491d-9056-ebd9fdc73bfa@oss.qualcomm.com>
 <8cb665f5-4885-4853-804a-7313decc719c@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@gmail.com>
In-Reply-To: <8cb665f5-4885-4853-804a-7313decc719c@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/6/24 09:47, Manikanta Mylavarapu wrote:
> 
> 
> On 11/4/2024 7:21 PM, Konrad Dybcio wrote:
>> On 4.11.2024 1:44 PM, Manikanta Mylavarapu wrote:
>>> Add thermal zone nodes for sensors present in IPQ5424.
>>>
>>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>>> ---
>> [...]
>>
>>> +
>>> +		cpu3-thermal {
>>> +			polling-delay-passive = <0>;
>>> +			polling-delay = <0>;
>>> +			thermal-sensors = <&tsens 13>;
>>> +
>>> +			trips {
>>> +				cpu-critical {
>>> +					temperature = <120000>;
>>> +					hysteresis = <9000>;
>>> +					type = "critical";
>>> +				};
>>> +
>>> +				cpu-passive {
>>> +					temperature = <110000>;
>>> +					hysteresis = <9000>;
>>> +					type = "passive";
>>
>> You have a passive trip point without passive polling
>>
> 
> Okay, will remove this.

You most likely want to preserve it, while keeping a sensible
polling frequency, so that userspace will be aware of the current
CPU temperature. <100> sounds like a sensible value here.

Konrad

