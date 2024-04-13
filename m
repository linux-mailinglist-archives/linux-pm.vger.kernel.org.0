Return-Path: <linux-pm+bounces-6358-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D2E8A3E3D
	for <lists+linux-pm@lfdr.de>; Sat, 13 Apr 2024 21:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35EDD281B87
	for <lists+linux-pm@lfdr.de>; Sat, 13 Apr 2024 19:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5814454660;
	Sat, 13 Apr 2024 19:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OmD4fAKY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9921753E0E
	for <linux-pm@vger.kernel.org>; Sat, 13 Apr 2024 19:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713036715; cv=none; b=Mp/NWbILEoSOW5jfHPzuGadpeW4C+ZXjkNHwW5mTeN6atrndjTRZr3cHogv6E39ZZGMHkkX/9s1FDM9B9B60gani5TGCStJuDCL41dYFe9yeAdbFMip9K8Y6NwTnqltpB89NeiJLyRnh2gkmQMEcvyCM5IC2VNGiptKejxLMoeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713036715; c=relaxed/simple;
	bh=YJ6jDS8SjWnTuVP9uJ1ghT1sfqZX9ES30YU+dQqnSYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XVozEtrcDiKAsZY9+pFu/mnSQBvbTqOmbGQxSzLmlGj+dRMfUGt7yqiKrmW9qO6Hd51mKfiTbOxGw5XdWXxxEi7p41VsaVXMDo06aAfYxMoIIQToqxWtLSrebXJh87IuroervvYbVKhv6wgygRyxoxz9TyH7otH+VFD8B6Wi2l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OmD4fAKY; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a46a7208eedso276230466b.0
        for <linux-pm@vger.kernel.org>; Sat, 13 Apr 2024 12:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713036712; x=1713641512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hoM0XAEUpRVPIeinoPGbPpP3Hh4hNSukUOnMJ2HLsSE=;
        b=OmD4fAKYGHCGIqNRpTYDFLuil6ZKAfwxtzKkm8uPW44ZA8iUPtu6wfi5VaDFis3c0P
         wA0rZdvUxoG6aC3W1T1z8crx20hZ0ecZo1U2f7BtBf4mwHF63veKU/Q8tNe5LMA7cMnO
         VU8nw2C+VWqmkApVK2d6vdjGcqQnGKYlNd0+OQh3aZhvPadjLZ5f9DRvjCnGmq0Uo5Wm
         fjwGAWsPC22ELrzLVSdeFIfl4ZWMS4c9s2I3JpgZFsFA9+kn1Evgm8CdYgT08Fsd5qfV
         ctFSgkDPayLPP+Z5epQa1YRmkemdm9xvwLNbV13lswtHIMmVQgdzQBn5VgFkAExPQzjQ
         4xmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713036712; x=1713641512;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hoM0XAEUpRVPIeinoPGbPpP3Hh4hNSukUOnMJ2HLsSE=;
        b=Jrc946DASIxIP1I0SmvEAl7RRk+N2y89N+b+ie2wnIJmih1BHvfw8owQS4mKUDmDoi
         m5meCtDwyeJcRxhJjaUSmhydmMQ8xcrerX+NpELLAcNhL972mTdmtiM4DGa7Px8UGN63
         u4VNGCsPvFrro0jVTHzMzZJnvFEGL76k2dyUnVAJYSp9Ey94wp3vMWK4pZY+FxaibhnG
         RyLH2/lp6okW6iipWkcaHW+Mt9iDp6dPa/fhZT78e+djhzh09EH/z2crXGkOe2v5gdam
         z0dn2rtsPUxIJN3nxZVSRERhNWZVlnys72sTrENXOL7SsszmZCU08M68IWHE4syuLIky
         Exog==
X-Forwarded-Encrypted: i=1; AJvYcCXVF0pzwpxaG+euG2J+LinI41HNemtNDtFIfzybFcVZ3864GKhELXCPzcRtf62Ews0eTtSaSaeDWIzhz11gM8J0pK4FMTMkKK4=
X-Gm-Message-State: AOJu0Yw9xt62ATGBzBbNu1nH/xrJVSvVaieSv+pIBHWUgSb45EOP0DTL
	xP6vSr89+d8flMA3TfJKADdWcEDvwiXZd00mYCl4q9MskvB43SJ9bji8seNMrqY=
X-Google-Smtp-Source: AGHT+IHWPDhTqchT37eSS3hl4fS80ZHtZAxMHWMIjAccLluFFcknTGFsE11xDHgQYFR0iSEAVhIR3Q==
X-Received: by 2002:a17:907:94c1:b0:a51:e5c7:55b7 with SMTP id dn1-20020a17090794c100b00a51e5c755b7mr4208196ejc.47.1713036711430;
        Sat, 13 Apr 2024 12:31:51 -0700 (PDT)
Received: from [192.168.45.55] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id oz16-20020a170906cd1000b00a51bf5932aesm3319727ejb.28.2024.04.13.12.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Apr 2024 12:31:50 -0700 (PDT)
Message-ID: <0a58e05a-7bf5-459a-b202-66d88c095b45@linaro.org>
Date: Sat, 13 Apr 2024 21:31:47 +0200
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
 Bjorn Andersson <andersson@kernel.org>, Georgi Djakov <djakov@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, cros-qcom-dts-watchers@chromium.org,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, quic_rlaggysh@quicinc.com,
 quic_mdtipton@quicinc.com
References: <20240325181628.9407-1-quic_okukatla@quicinc.com>
 <20240325181628.9407-2-quic_okukatla@quicinc.com>
 <d59896bb-a559-4013-a615-37bb43278b2e@linaro.org>
 <91f59477-1799-4db6-bcc2-3f0c5225d1c8@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <91f59477-1799-4db6-bcc2-3f0c5225d1c8@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3.04.2024 10:45 AM, Odelu Kukatla wrote:
> 
> 
> On 3/27/2024 2:26 AM, Konrad Dybcio wrote:
>> On 25.03.2024 7:16 PM, Odelu Kukatla wrote:
>>> It adds QoS support for QNOC device and includes support for
>>> configuring priority, priority forward disable, urgency forwarding.
>>> This helps in priortizing the traffic originating from different
>>> interconnect masters at NoC(Network On Chip).
>>>
>>> Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
>>> ---

[...]

>>> @@ -70,6 +102,7 @@ struct qcom_icc_node {
>>>  	u64 max_peak[QCOM_ICC_NUM_BUCKETS];
>>>  	struct qcom_icc_bcm *bcms[MAX_BCM_PER_NODE];
>>>  	size_t num_bcms;
>>> +	const struct qcom_icc_qosbox *qosbox;
>>
>> I believe I came up with a better approach for storing this.. see [1]
>>
>> Konrad
>>
>> [1] https://lore.kernel.org/linux-arm-msm/20240326-topic-rpm_icc_qos_cleanup-v1-4-357e736792be@linaro.org/
>>
> 
> I see in this series, QoS parameters are moved into struct qcom_icc_desc. 
> Even though we program QoS at Provider/Bus level, it is property of the node/master connected to a Bus/NoC.

I don't see how it could be the case, we're obviously telling the controller which
endpoints have priority over others, not telling nodes whether the data they
transfer can omit the queue.

> It will be easier later to know which master's QoS we are programming if we add in node data.
> Readability point of view,  it might be good to keep QoS parameters in node data.  

I don't agree here either, with the current approach we've made countless mistakes
when converting the downstream data (I have already submitted some fixes with more
in flight), as there's tons of jumping around the code to find what goes where.

Konrad

