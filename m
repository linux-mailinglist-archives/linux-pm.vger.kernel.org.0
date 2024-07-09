Return-Path: <linux-pm+bounces-10859-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ADB92B7F2
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 13:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88D141F21640
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 11:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B5E15884F;
	Tue,  9 Jul 2024 11:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ayo1fYoB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A3E157E61
	for <linux-pm@vger.kernel.org>; Tue,  9 Jul 2024 11:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720524535; cv=none; b=eEJEjTyMus/1LBmdHsFVfJDRfKwwLYwJTskzn/aYY29zR/5fgN8E0835ez/OefFuZebXdp8o9hvruuIqRos4HIqw8BuXBtOtT6T5v2ut+ywUB1BjnGC7MjQULEVT8kwQgZ/U9iFNu4n065DKjzvXFh1geYfmBiz2bWtJhxCw/P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720524535; c=relaxed/simple;
	bh=ViVFjZGgS8dNPjz5ZsLdjn3yYXpL9aBl4uTllH3CRXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bSljdjAaQTbnlWxlGNIX1js4P+rvJ9RMYyBYlISfiH9vMNMv+eiw4+1v+x3uXZ35e4nr8dqI9ZyL4IYdR6abrzpy4HX5hOI7YVxCs3vVuIlXFoNImtD8QAdDBZFpGybGo5PZA++UoAWZFstHq/ILuy/U7//PG35XisNOerIaTuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ayo1fYoB; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so72874361fa.0
        for <linux-pm@vger.kernel.org>; Tue, 09 Jul 2024 04:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720524531; x=1721129331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3qzAJjCuxDfaalc2old/6w/0ikvjZdAHEMZJhAtd5HY=;
        b=ayo1fYoBJJWD+RtYUNvHxZokC1nykAxVgvPCnAaNsWoM9BbKuR3wO8oHwAZWB8oRmX
         zM8wS32V8lEcBz3daIKPie4x/kjF2Bzi4AD/7M60ZPN06aTfxynRIy/RxOHotEUI1PU6
         Rk0HJXzpMnIqAIAy0UTdH9RZZE2ax0CT9wWdLsOtfFoZSp7CmY9nQlRgLj9YOtE+s+YW
         GfvGzndm/NvDNML8Pqt0nzCuEUgYH52uZlhzdErg0v3brT7yI/XoFwSM1qhFNuRA8zTQ
         YGDDXbtXvAKtxJJxXlT32jIOYe6WBjjp4AUimxy/ncjZPRL7Fq7eBdsZOrqyvLwnl5et
         mnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720524531; x=1721129331;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qzAJjCuxDfaalc2old/6w/0ikvjZdAHEMZJhAtd5HY=;
        b=j0PRq0qnkVcqh+Mlz95Bd0UtQIwawMykUgNUVY5MGdYdgkWmr7ikpSwSkxrOrv26TO
         KV32HNbPVJ98oIx5a25Kx5Gu3QOQBqqRN4z8y9R7/BKxbLbEbIpsgSVA21onyrNBCdDy
         2+c3gpk3iKv5E9ob+85AOy8OdjjN3PjOJy9dJZppimjxHXwh6yJqN/mHCI9HURPH8n34
         jljpTaQ1XuOHO+AJxnecBrAFFHx6sTtYEvyJEBUYI+Roy5nseQJsjrdNi6nYJD8rQ1yf
         yQOE2wLAE2yHkVXCAZj8zFQ8ulyAzkxwfEIUJGi8nXEvDh4Efp4mDhIl7Qn1KB5yIuPS
         IjWQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5LFoLG64HVzI6oEQ2hpk5akYaV39IeUnpiuI9QbITYJjOGVUGwr+uAZlWuco3y5NlQzRo79YBObTgGtHfXkFHnqAixY3OUwA=
X-Gm-Message-State: AOJu0YzETJOoXMgSQWS1gh9EwFBuz/b2bXXmX5B6a7ymd98PmktOYzhG
	pEbEgLLZBZOwTHHCLsMkmMspKpw+yEjGrnHBSVtLFNvjVkyLd6RCuV4W8z2e5WY=
X-Google-Smtp-Source: AGHT+IGS4L2H+hCKSxQz3uGyB0VuG6clhftOdyLInR1ymwePpLnvGZ+2GHobh0M7Xqc+cm/ImHJG3g==
X-Received: by 2002:a2e:a7c7:0:b0:2ee:8d9a:811a with SMTP id 38308e7fff4ca-2eeb310233amr24871521fa.31.1720524530481;
        Tue, 09 Jul 2024 04:28:50 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a7ff02dsm68784266b.110.2024.07.09.04.28.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 04:28:50 -0700 (PDT)
Message-ID: <1ec0dbfa-dbef-41e6-a871-7da61651572b@linaro.org>
Date: Tue, 9 Jul 2024 13:28:46 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/10] dt-bindings: opp: v2-qcom-level: Update minItems
 for oloop-vadj & cloop-vadj
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, angelogioacchino.delregno@collabora.com,
 andersson@kernel.org, mturquette@baylibre.com, ilia.lin@kernel.org,
 rafael@kernel.org, ulf.hansson@linaro.org, quic_sibis@quicinc.com,
 quic_rjendra@quicinc.com, quic_rohiagar@quicinc.com, abel.vesa@linaro.org,
 otto.pflueger@abscue.de, danila@jiaxyga.com, quic_ipkumar@quicinc.com,
 luca@z3ntu.xyz, stephan.gerhold@kernkonzept.com, nks@flawful.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org
References: <20240703091651.2820236-1-quic_varada@quicinc.com>
 <20240703091651.2820236-10-quic_varada@quicinc.com>
 <20240708155529.GA3244015-robh@kernel.org>
 <ZozgNAYKAvhPr0qk@hu-varada-blr.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ZozgNAYKAvhPr0qk@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9.07.2024 9:01 AM, Varadarajan Narayanan wrote:
> On Mon, Jul 08, 2024 at 09:55:29AM -0600, Rob Herring wrote:
>> On Wed, Jul 03, 2024 at 02:46:50PM +0530, Varadarajan Narayanan wrote:
>>> Since IPQ9574 has only one CPR thread it will specify
>>> only one voltage adjustment value. Hence update min items
>>> accordingly for oloop-vadj and cloop-vadj. Without
>>> constraining min items, dt_binding_check gives errors
>>>
>>> 	opp-table-cpr4:opp-0:qcom,opp-cloop-vadj:0: [0] is too short
>>> 	opp-table-cpr4:opp-0:qcom,opp-oloop-vadj:0: [0] is too short
>>>
>>> 	Failed validating 'minItems' in schema . . .
>>> 		{'maxItems': 2, 'minItems': 2}
>>>
>>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>>> ---
>>> v4: Fix dt_bindings_check error
>>> ---
>>>  Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml | 2 ++
>>>  1 file changed, 2 insertions(+)
>>
>> This is going to need to be rolled into your dependency because it needs
>> the same fix.
> 
> Konrad,
> 
> Can you please squash this into https://lore.kernel.org/lkml/20230217-topic-cpr3h-v14-2-9fd23241493d@linaro.org/

Yes, I'll do that in the next revision.. forgot to validate this..

Konrad

