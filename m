Return-Path: <linux-pm+bounces-4030-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 719F1859015
	for <lists+linux-pm@lfdr.de>; Sat, 17 Feb 2024 15:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC914B21C6C
	for <lists+linux-pm@lfdr.de>; Sat, 17 Feb 2024 14:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E06A7B3EA;
	Sat, 17 Feb 2024 14:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lbb1+j/n"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0AC7AE76
	for <linux-pm@vger.kernel.org>; Sat, 17 Feb 2024 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708180064; cv=none; b=lKBbHsUdQAxyT4tDAQRIQxDbHqO5fvbxD9aIyfk87acrt74TJuXnUwOaqwgq3tE6foc776rfP6IfhPDPCeafH6iE+3RZ6S1VWunMHCAMwSpDyVo5LEO5tExiBnLvC8/hR+zR3NXgYJgW0/rC6Q2pGwbfLiWSJEatb1PGkeZ6DCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708180064; c=relaxed/simple;
	bh=jRlINdbg4JEuPWhpxkKqWf4N327YRG2hSi66nO5K17s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OZGQc121byRnJg6gN2AVgqGVgfAQ1J5bP5fbt2HLO3AWS0Oo+xj2U6nK0ym0dg3HzuaPWkJHv12SfRBKfQtyxkkgvw+aakN1UFm7PplQx2KNefyQR4rH7of61Cygv9+zHvpiVwedTAl5AToU0zljxpFDDKO6b2pWz06QxZj6OwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lbb1+j/n; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso2597307a12.3
        for <linux-pm@vger.kernel.org>; Sat, 17 Feb 2024 06:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708180060; x=1708784860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o4kikdKHR3faZBL1guvZu0OzCu2qhiR5nbEAWGYdvts=;
        b=lbb1+j/nEoe956gUP/K3J8NNgK+TRG5KeSgrKdR3AGGQ5lcod2uvQWSwsqqL2G0Pyc
         eO9nz9aZ3e1ofJ3Hut4btGqXFmxJGWKmhlY1Vv45X+F9ykWCBxMFsyBxRWZnEiy3bOZk
         Z7sp0DRqf/DPdJJMJyOxA+UT2f7VFE4CGto6RB+TFlFLvbbWPHv7Etl2ELmJvfYWDHAq
         HENZSvdZXXzaJj4HlFIT6jQRYJvbbYbnZYRvbtfl/D1FNQlhvNBCkP66osjentFxyPfc
         rkJvZ7Lr1twZR4HTiKD1s6z7Pcm+HTppsZ30/A9dKpgThEUpzwOT6lLIuoOSpIinykZJ
         qlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708180060; x=1708784860;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o4kikdKHR3faZBL1guvZu0OzCu2qhiR5nbEAWGYdvts=;
        b=V50bbYWBs2idVfq9hXLvwFd8MsERKf/HtNeEjJWcIUDFCrqQmnMM9JfHDLGjD0o6eB
         9ggHn2vcFItEPLPYwfOKfDjFGGkp/SeEeoRckQRIeYFzB6RkZhVDgXdz/c3RzJ3AMieR
         pj/sdXnAkFMN4oyDCLN+N71LNXmIJRPBF2mAxWmj8Wh8kefoFebDFYUO5wJP7NZVDtXs
         uquH04NrxeMvB6/kIvouKN9hbfa5/tDc1yPtq9+XV8cw4QBzHtkT6kRsptj03nauiC0N
         moQxO0gQrWgu/XYBh+zuw6Q5Jb5+vT6eDuXTrJmfrU0Dh3HIiU+qOifZgwgkUmCopbNy
         0Xpg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ/YP8XQd2qGW11rAxqVIBFEgaCkAbbLG0tHI9x0Zs9gUs/HNYkTJJwJiyozaHXUSKWX9WOr1E123Vu5sTVQCSqFCy7cb9kFc=
X-Gm-Message-State: AOJu0YxZvgTFVRA6EaWrX9zDr161yA/9rmsd7UmJPfJedNNfVv3WwbXw
	PBK2FzfRvuEW3QGIksARSoOnKa7yXGDW8VvW7pfQ9vr6+Ydda+R7hfvPrkpomI4=
X-Google-Smtp-Source: AGHT+IGmeY+dZXaraQ7KyLKFWeJGq+Bg5GuAIZMJjrZUIOpv6SD8HhcXxOfZOBSfGmN0pki5EmdiBA==
X-Received: by 2002:a05:6402:120c:b0:560:e4d8:ccca with SMTP id c12-20020a056402120c00b00560e4d8cccamr5983617edw.28.1708180059791;
        Sat, 17 Feb 2024 06:27:39 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id el14-20020a056402360e00b0055fba4996d9sm923053edb.71.2024.02.17.06.27.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 06:27:39 -0800 (PST)
Message-ID: <f84a4933-ce7a-4820-9b57-84a1549602ff@linaro.org>
Date: Sat, 17 Feb 2024 15:27:38 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: cpufreq: Add nvmem-cells for chip
 information
Content-Language: en-US
To: Markus Schneider-Pargmann <msp@baylibre.com>,
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Andrew Davis <afd@ti.com>, Dhruva Gole <d-gole@ti.com>,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240206145721.2418893-1-msp@baylibre.com>
 <20240206145721.2418893-2-msp@baylibre.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240206145721.2418893-2-msp@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/02/2024 15:57, Markus Schneider-Pargmann wrote:
> Add nvmem-cells to describe chip information like chipvariant and
> chipspeed. If nvmem-cells are used, the syscon property is not necessary
> anymore.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Acked-by: Andrew Davis <afd@ti.com>
> ---
>  .../bindings/opp/operating-points-v2-ti-cpu.yaml | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml b/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
> index 02d1d2c17129..b1881a0834fe 100644
> --- a/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
> +++ b/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
> @@ -34,6 +34,14 @@ properties:
>        points to syscon node representing the control module
>        register space of the SoC.
>  
> +  nvmem-cells:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array

Why redefining the type?

Best regards,
Krzysztof


