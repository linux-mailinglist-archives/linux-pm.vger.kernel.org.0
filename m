Return-Path: <linux-pm+bounces-9470-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EC490D5A0
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 16:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D10921C22F0E
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 14:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7E418E76F;
	Tue, 18 Jun 2024 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bq2T5lo8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829AD16D9CB
	for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2024 14:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718720811; cv=none; b=GuP0y90xgzweuEnlulLE1w88vi1LhTpGNyCxqFPBfKU5eSHlKfbK+xSPD7bAil+X3plppNHIoDIUkqemRNxr+zui+KPES89korUT/Rq+NvieTD02seNs5cpcbfHb3GcfJ8Sg4+H/wNcKSPqMF9Jgb+9dSRxAw1yKiYYO8Z+vK5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718720811; c=relaxed/simple;
	bh=6OODOhdNIVgojK0DD+bJ3xC5Pd0K2/xPp0YUVsVlCyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eNSbJV3OI7qr0/D4TSQJdpsy3B8IeLQvgq7s/a436/tj2F3H3pm0nVfo88O7NvT+9Hrl50UTeNRk1modqlsXwKBiGJ1Meuim9rgOAKeOCQ1RSSkn7jJoOfMngrGzLNvBW4mf7O0vsU67BkAyVsZFfdf7/lM4eIcsOBHQ/HqvKHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bq2T5lo8; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52b7ffd9f6eso5474909e87.3
        for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2024 07:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718720808; x=1719325608; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o4oltf+iDMEhrbAhAEQGa5uqGfEZG+Q9a3SV4m205oY=;
        b=bq2T5lo8QNw+36MP39ZmaGDBuA5DcCGKbvgNA3hodWxR3LokbSz+50Gz/lqQXkF4eO
         EOHrUSMV0PLAb/bVactpNPqIyUv6Yk8ZNrryyISKWNadAF4Dsr5uPZI/Fg7PF2AXJjTj
         c6hCBuiHbBmBpWO/99mOJNWl8BM8Pd4Ry2D57AFLcP3cbW+zOO38YJv77DH8q0XPIfD7
         +Th6hdEcD+WcJnXxaRU7doLac/IboZRFnpT2F5c8WhZqdOn3P0p/gldFmTC3XUGEpvBk
         Jbl/VzRD7eCnKXP9TO1sACoau0TE0EsMuWWCYjApKga2Ti5tvVer0C5sxDquOmIDU6EW
         xMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718720808; x=1719325608;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o4oltf+iDMEhrbAhAEQGa5uqGfEZG+Q9a3SV4m205oY=;
        b=EzJQpDMJ53uEG9F+xVI8lWhKD/3pVXMQyGbQlAELGE1vt9cQ1PRLykBbIbPnzGYZ1B
         gAg9fwt+npNJhKzwJ/rGI/AJP0UngxyBK5HpRWPABd9YorxXQuggc/BxVr3vS7POPct2
         If/+Bb6ec8PZ2jb1S2DpvCeVNQNHyE+UWSpyMu2E6cs09wT8rG7V6M6M+x0KzGLVQC3B
         eXDzfPe35QQCZ0Q4m3BCw2w6+IXaWh+T/Y+K+TngG3F+qimJUaiGcDNLvOpu65pyJwFP
         8A+elcOvIzULY+alcwqKyx8Uli1yEZa42wkqvYjY9SjQWjJIcaXIdpzsPPFw3+Z6oL9S
         nujA==
X-Forwarded-Encrypted: i=1; AJvYcCUdo7ZkJJ+Xe6FbooHivNAvmMP7qZGGyU+3LIjdYIm8LM1tkHbafo+HisL8Br11wqV5aTEYMBaTqG4my//ALG+9HxAoa0lMuY4=
X-Gm-Message-State: AOJu0Yyr8XEdWESZq4eCOtEn4XRzhYaJz5Fb1lMzWjhaRnx7Nd+eeOxh
	3B6bL6tTpX8Us5kK2Lf8jXBRUJUa4zFQ2pHgkjN9/1TY4lHfxmRoHH9Jv0G54X0=
X-Google-Smtp-Source: AGHT+IFHGjpAatLTh5i/TLtY4OH/tjLw1j7KJbR3WWjxHPOYuCrWDKwfD8gaK8LpcWJj2ajdG7CPng==
X-Received: by 2002:a19:c519:0:b0:52b:c025:859a with SMTP id 2adb3069b0e04-52ca6e56796mr8617234e87.2.1718720807536;
        Tue, 18 Jun 2024 07:26:47 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:4fb7:492b:2c94:7283? ([2a00:f41:9028:9df3:4fb7:492b:2c94:7283])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2825bf0sm1511574e87.32.2024.06.18.07.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 07:26:47 -0700 (PDT)
Message-ID: <08533ee4-ac72-4d36-84ef-c44e8865d16d@linaro.org>
Date: Tue, 18 Jun 2024 16:26:41 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] interconnect: qcom: icc-rpmh: Add QoS
 configuration support
To: Odelu Kukatla <quic_okukatla@quicinc.com>,
 Mike Tipton <quic_mdtipton@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Georgi Djakov
 <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <keescook@chromium.org>,
 cros-qcom-dts-watchers@chromium.org,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, quic_rlaggysh@quicinc.com
References: <20240325181628.9407-1-quic_okukatla@quicinc.com>
 <20240325181628.9407-2-quic_okukatla@quicinc.com>
 <d59896bb-a559-4013-a615-37bb43278b2e@linaro.org>
 <91f59477-1799-4db6-bcc2-3f0c5225d1c8@quicinc.com>
 <0a58e05a-7bf5-459a-b202-66d88c095b45@linaro.org>
 <20240508023716.GD25316@hu-mdtipton-lv.qualcomm.com>
 <434c6cfa-cede-4e62-a785-35a81ae0d30d@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <434c6cfa-cede-4e62-a785-35a81ae0d30d@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/28/24 16:52, Odelu Kukatla wrote:
> Hi Konrad,
> 
> On 5/8/2024 8:07 AM, Mike Tipton wrote:
>> On Sat, Apr 13, 2024 at 09:31:47PM +0200, Konrad Dybcio wrote:
>>> On 3.04.2024 10:45 AM, Odelu Kukatla wrote:
>>>>
>>>>
>>>> On 3/27/2024 2:26 AM, Konrad Dybcio wrote:
>>>>> On 25.03.2024 7:16 PM, Odelu Kukatla wrote:
>>>>>> It adds QoS support for QNOC device and includes support for
>>>>>> configuring priority, priority forward disable, urgency forwarding.
>>>>>> This helps in priortizing the traffic originating from different
>>>>>> interconnect masters at NoC(Network On Chip).
>>>>>>
>>>>>> Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
>>>>>> ---
>>>
>>> [...]
>>>
>>>>>> @@ -70,6 +102,7 @@ struct qcom_icc_node {
>>>>>>   	u64 max_peak[QCOM_ICC_NUM_BUCKETS];
>>>>>>   	struct qcom_icc_bcm *bcms[MAX_BCM_PER_NODE];
>>>>>>   	size_t num_bcms;
>>>>>> +	const struct qcom_icc_qosbox *qosbox;
>>>>>
>>>>> I believe I came up with a better approach for storing this.. see [1]
>>>>>
>>>>> Konrad
>>>>>
>>>>> [1] https://lore.kernel.org/linux-arm-msm/20240326-topic-rpm_icc_qos_cleanup-v1-4-357e736792be@linaro.org/
>>
>> Note that I replied to this patch series as well. Similar comments here
>> for how that approach would apply to icc-rpmh.
>>
>>>>>
>>>>
>>>> I see in this series, QoS parameters are moved into struct qcom_icc_desc.
>>>> Even though we program QoS at Provider/Bus level, it is property of the node/master connected to a Bus/NoC.
>>>
>>> I don't see how it could be the case, we're obviously telling the controller which
>>> endpoints have priority over others, not telling nodes whether the data they
>>> transfer can omit the queue.
>>
>> The QoS settings tune the priority of data coming out of a specific port
>> on the NOC. The nodes are 1:1 with the ports. Yes, this does tell the
>> NOC which ports have priority over others. But that's done by
>> configuring each port's priority in their own port-specific QoS
>> registers.
>>
>>>
>>>> It will be easier later to know which master's QoS we are programming if we add in node data.
>>>> Readability point of view,  it might be good to keep QoS parameters in node data.
>>>
>>> I don't agree here either, with the current approach we've made countless mistakes
>>> when converting the downstream data (I have already submitted some fixes with more
>>> in flight), as there's tons of jumping around the code to find what goes where.
>>
>> I don't follow why keeping the port's own QoS settings in that port's
>> struct results in more jumping around. It should do the opposite, in
>> fact. If someone wants to know the QoS settings applied to the qhm_qup0
>> port, then they should be able to look directly in the qhm_qup0 struct.
>> Otherwise, if it's placed elsewhere then they'd have to jump elsewhere
>> to find what that logical qhm_qup0-related data is set to.
>>
>> If it *was* placed elsewhere, then we'd still need some logical way to
>> map between that separate location and the node it's associated with.
>> Which is a problem with your patch for cleaning up the icc-rpm QoS. In
>> its current form, it's impossible to identify which QoS settings apply
>> to which logical node (without detailed knowledge of the NOC register
>> layout).
>>
>> Keeping this data with the node struct reduces the need for extra layers
>> of mapping between the QoS settings and the node struct. It keeps all
>> the port-related information all together in one place.
>>
>> I did like your earlier suggestion of using a compound literal to
>> initialize the .qosbox pointers, such that we don't need a separate
>> top-level variable defined for them. They're only ever referenced by a
>> single node, so there's no need for them to be separate variables.
>>
>> But I don't see the logic in totally separating the QoS data from the
>> port it's associated with.
>>
>>>
> I will update the patch as per your suggestion of keeping .qosbox initialization inside *qcom_icc_node* structure.
> I will post next version with this update and addressing other comments from v4.

Sorry for the late answer, but ack, let's go forward with this

Konrad

