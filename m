Return-Path: <linux-pm+bounces-5194-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8067885F72
	for <lists+linux-pm@lfdr.de>; Thu, 21 Mar 2024 18:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259341C2351D
	for <lists+linux-pm@lfdr.de>; Thu, 21 Mar 2024 17:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9546763EC;
	Thu, 21 Mar 2024 17:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rOctEU41"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E86417590
	for <linux-pm@vger.kernel.org>; Thu, 21 Mar 2024 17:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711041376; cv=none; b=mX8AwQaTWeRi13/HCCa+kDjvrzDWk/i7Wb04UGyX/zt1IsI4DpYuxq0Wfb58D44+OP33PLuEaWcN1ISSSZE7vNERDG4oVt8pufqLVwSy3s8BO8ALPCdZxdJ3BjmaxaQfJ0b+RMlBBTIfVc8ByD+AiHJZrg8DIWzJT8B/0kGhP4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711041376; c=relaxed/simple;
	bh=RUsWaSGEGyzJkXmAa/BIHP71etV0BQXLfjmPcNLZps8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q/05vdgkqtZyHWq75wdZEzx9iiwDHeuT/6HeYz+oLLd/tko+DSlwd/DFJ/rFYFc/dQmswwR4uOsg74d/rFhrYnpv/+PzBNhrCJhKzNQm/sNks8HgDJ/rXCqfQxM2UfYHC7+utjCxAlDuWrRN/KX5/4Lx2+ru2f+Qa23UXGFQh/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rOctEU41; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d094bc2244so17398481fa.1
        for <linux-pm@vger.kernel.org>; Thu, 21 Mar 2024 10:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711041372; x=1711646172; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FBA7Y36AMw0KTupRrw+PnBU6PO+JQCp7HzJLhSmsbvQ=;
        b=rOctEU41ksX2XVMCUcrsRmWO6kNfoqXJ4z/t+hVWJdVVyfW/5+FtCxa9Quxc6kiPE2
         /lSXGM4JmHy0L3diLkWAzU5z5DN+asJTr9ZJkrZSjcyMsaWpCrezd4OckMDrblSMyuYF
         jMfw3XuxMShzCLypHQrpyY2j0ZG4Mho8ypSph5EnIO6A+S7kIFfDnFhuum3ovuXlt1AC
         UM6z9zfPKlh2xWF0g/yIVntihzDjTJJW7vZN8fQ8y9heEeoAnqZ8r4IT7vlNpiOTtKsT
         L7C4neCUETKTZKn+lTRpetRmp+0v32H10w12aEYjyGilCd4+ieJDUEb71fNK88DEWA1L
         7D8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711041372; x=1711646172;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FBA7Y36AMw0KTupRrw+PnBU6PO+JQCp7HzJLhSmsbvQ=;
        b=EoOUTzYgPkV8E3tr3rVGPpEEfTegfzDt167Vftag8x4ETUK5MgLlWGpz3CTSH0WD+a
         AuGvz/w/P7A77NdIeFP+ZJPPQh3/rFbYil6IQaALX/pxdoMIO6ha91nWCohYDG7bcX6T
         KVBVc0Xa25KgkvfJ7NGvIOzIc2D+Jr/R5ELhlq2P8cLzd3x/vPiHjdGwxmZCY4jieWu/
         6yi5+zxT0u2MIn2JNhyWjyK5PeI29Ep/qJHzjKYel9LDlajWFIEQtML9NtUvFIYmA6cV
         4CYv9LA21Wxrohv3yArZhrj8R9xZ/5BH3aetHgFLEjgpL+T1YgQUidWFBtI3PkFdr3EV
         sPmA==
X-Gm-Message-State: AOJu0YyyLIbbHjhWKWFP8qXPwdLsWLLjS2Zf8RBNKR+RbNbhvw1ipPrG
	mXuJzPeQ6qI+SIihqjJXqLfzpq+aaMUv7ucf5U7/9ag9CKS4oD9dplxYlA8H+YU=
X-Google-Smtp-Source: AGHT+IGkJlWYDvk6fZNaztZrSC12byEOQoxXY+/V0L13JjfECs9/v6X2OntqmmM+6UAK1rUT7dwbiA==
X-Received: by 2002:a2e:a415:0:b0:2d4:a6aa:39b3 with SMTP id p21-20020a2ea415000000b002d4a6aa39b3mr97037ljn.31.1711041372139;
        Thu, 21 Mar 2024 10:16:12 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id v9-20020a05600c470900b0041409db0349sm333276wmo.48.2024.03.21.10.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 10:16:11 -0700 (PDT)
Message-ID: <6df3c39e-5a03-46d7-921b-d53d75447aaf@linaro.org>
Date: Thu, 21 Mar 2024 18:16:11 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: thermal: convert st,stih407-thermal
 to DT schema
Content-Language: en-US
To: Raphael Gallais-Pou <rgallaispou@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Lee Jones <lee@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240320-thermal-v3-0-700296694c4a@gmail.com>
 <20240320-thermal-v3-1-700296694c4a@gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240320-thermal-v3-1-700296694c4a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/03/2024 22:33, Raphael Gallais-Pou wrote:
> 'st,passive_colling_temp' does not appear in the device-tree, 'reg' and
> '#thermal-sensor-cells' are also missing in the device description.
> 
> Convert st,stih407-thermal binding to DT schema format in order to clean
> unused 'st,passive_cooling_temp' and add missing properties.
> 
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
> Changes in v3:
>    - Specify const value for '#thermal-sensor-cells'
>    - Add 'maxItems' for 'interrupts' property
>    - Change commit log accordingly
> 
> Changes in v2:
>    - Change commit log to use imperative
>    - Drop description
>    - Drop 'clocks' description
>    - Add 'reg' property
>    - Add '#thermal-sensor-cells'
>    - Make node name generic in example
>    - Fix YAML style
> ---
>   .../bindings/thermal/st,stih407-thermal.yaml       | 58 ++++++++++++++++++++++
>   .../devicetree/bindings/thermal/st-thermal.txt     | 32 ------------
>   2 files changed, 58 insertions(+), 32 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/st,stih407-thermal.yaml b/Documentation/devicetree/bindings/thermal/st,stih407-thermal.yaml
> new file mode 100644
> index 000000000000..9f6fc5c95c55
> --- /dev/null

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


