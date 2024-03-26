Return-Path: <linux-pm+bounces-5392-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C0188BD5B
	for <lists+linux-pm@lfdr.de>; Tue, 26 Mar 2024 10:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 412E2302584
	for <lists+linux-pm@lfdr.de>; Tue, 26 Mar 2024 09:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13456481BA;
	Tue, 26 Mar 2024 09:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SS7Yt93t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE37537EC
	for <linux-pm@vger.kernel.org>; Tue, 26 Mar 2024 09:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444355; cv=none; b=YaHpEpx4+/lYjRTETv26kARZalIph8fuy1xHTyxKGifkNkTAG6iXKv8zgv9AbqqrDLU4mj2Se+kNvlde0g6SJNXDw/Gbxdp+44WxC1EJEryYWxqIg93u55Y0MWP9FtGMWwRuWF9kbF11KmQqyf9fEQOrjQucu1ElwnQMca/4fSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444355; c=relaxed/simple;
	bh=ohfTQ7GJVXTk363SelUFR6n62hLvktyWhLYwkiSSWmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lZzGgjqnYTHDx1rJ7z47j2xeNtLwnPaLcX/xEDH9ifYIq41F1xMAM0WgLpdlkZzn7116YuOlVi7fum1Sxa0tUowDO8MGP6KzcTsCKVdzWUN2OAG5VzYuFIutCUf54bg5g1qiV7Hx/vx+CuQ4hVxU+2ZE9N4+i0lGpBP0OhLJBq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SS7Yt93t; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56a2bb1d84eso9260901a12.1
        for <linux-pm@vger.kernel.org>; Tue, 26 Mar 2024 02:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711444352; x=1712049152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAEJSBfJUiPrazp2z7NPHsoCuUhr0rZr10Rftpi6JSA=;
        b=SS7Yt93t0atCtLWEMcJk6II4QLPDa3jDqgKL4ClcekjgzqpJlPsZdxO5OXKl5hQWcT
         B8RSJwMJZpzcUdzbWseLm4VUqfmirE9Sh33erOtuyo0wpoxFffkYpDk0DLOSjnDPaK8y
         abJqipkspyoNmJyQm2bvk3e47JYeYKZnv5WfaY9o2czyj0T7zf6jSEBeKb+5NXxMD2uT
         j1KxH78BP/H9+o1c0qWELULqSphqrgWjafHRn2ZSa1rYYPC35FHetVQij7ubIw0vD/zs
         wJQlUQ5GimmS89KelMTyJbG0wwED8HXy8qD7Fe7uGrepaM0hFUr6tuaAzFqmCqCw+LQ3
         3t7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711444352; x=1712049152;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAEJSBfJUiPrazp2z7NPHsoCuUhr0rZr10Rftpi6JSA=;
        b=gA896IIDQHKXK77eaW8x3iFUqdGrjtx2do5/Jfn3mKkO90LVXyo2P6aDiemVQcrWdU
         M1eEU8uRsbPrVQjjcWYYugAMVKJ9BQWGeLHPl5WClk1hOWEb/dfDS6ZhYuvMCQ4MV1WJ
         SpIQvqfROLf5TxDS3av2IHp2+PPiQR+EhzFD5WIapDDhBTEdUG1Zht1n7OwMt4F1wwuM
         HvW3MNJeX09ow+L8iraAQ9/45He/1wQVcmTZvviGgORkzbhN+3rdSh7OMdpM34EMhj8v
         xHJy59YmfR8CH76/l/C30shPVPI+uSGUhb77kUV+t4AyBfBqnHY1aGaCSrexQtgZN7PM
         HmNg==
X-Forwarded-Encrypted: i=1; AJvYcCWjjv/M3HSrQUotmPw5J11DOJyDs11YOxifcUGbkuwgdaZ6kTi+ntTJ+cM21QsmVUkt5mZWDmRUjAzr2uv7BlQnwUJuwtjlois=
X-Gm-Message-State: AOJu0YxrilPy+Fr5Zt5ssuzxHieAEbPZaIgmSi9Sc/y+vUkB9wfm97NJ
	rtxg+l/QbjT/1sNSFsAKEgn3BHOJ5FDGyuIA5CMGLIpq9Rlzlt1yFvJ2a6kkytU=
X-Google-Smtp-Source: AGHT+IGh2QisQCMmX4g1ej5hIK7DfPBJ159gYNUJjUWQQnwzMXF6xwjUKIHwfGeEmAixP5jyrdIuhQ==
X-Received: by 2002:a50:8d57:0:b0:566:902e:65e4 with SMTP id t23-20020a508d57000000b00566902e65e4mr800574edt.18.1711444351598;
        Tue, 26 Mar 2024 02:12:31 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id i23-20020a056402055700b00569731a1eb2sm3934388edx.46.2024.03.26.02.12.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 02:12:31 -0700 (PDT)
Message-ID: <8a170865-79c7-4218-8e81-342afac3f8c7@linaro.org>
Date: Tue, 26 Mar 2024 10:12:29 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] dt-bindings: interconnect: Add Qualcomm IPQ9574
 support
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, mturquette@baylibre.com,
 sboyd@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, djakov@kernel.org, quic_anusha@quicinc.com,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240325102036.95484-1-quic_varada@quicinc.com>
 <20240325102036.95484-3-quic_varada@quicinc.com>
 <4e7ff99f-f362-4d58-b2f0-ca2dc1fe4b55@linaro.org>
 <ZgKOZGDxqGD8dmAn@hu-varada-blr.qualcomm.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZgKOZGDxqGD8dmAn@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2024 09:59, Varadarajan Narayanan wrote:
>>> ---
>>>  .../dt-bindings/interconnect/qcom,ipq9574.h   | 62 +++++++++++++++++++
>>>  1 file changed, 62 insertions(+)
>>>  create mode 100644 include/dt-bindings/interconnect/qcom,ipq9574.h
>>>
>>> diff --git a/include/dt-bindings/interconnect/qcom,ipq9574.h b/include/dt-bindings/interconnect/qcom,ipq9574.h
>>> new file mode 100644
>>> index 000000000000..b7b32aa6bbb1
>>> --- /dev/null
>>> +++ b/include/dt-bindings/interconnect/qcom,ipq9574.h
>>> @@ -0,0 +1,62 @@
>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>>> +#ifndef INTERCONNECT_QCOM_IPQ9574_H
>>> +#define INTERCONNECT_QCOM_IPQ9574_H
>>> +
>>> +#define IPQ_APPS_ID			9574	/* some unique value */
>>
>> Why random unique values are bindings? Why this cannot be 0? Please
>> explain how this is used by DTS and driver.
> 
> This 'id' is not used by the driver or DTS. It is a unique id that

Then it is not a binding really.

Don't put driver stuff to bindings.


Best regards,
Krzysztof


