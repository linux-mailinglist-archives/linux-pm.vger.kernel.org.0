Return-Path: <linux-pm+bounces-3760-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E233D850A53
	for <lists+linux-pm@lfdr.de>; Sun, 11 Feb 2024 17:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C31A1F210BB
	for <lists+linux-pm@lfdr.de>; Sun, 11 Feb 2024 16:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651C88814;
	Sun, 11 Feb 2024 16:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hgi8o84t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D509847B
	for <linux-pm@vger.kernel.org>; Sun, 11 Feb 2024 16:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707669077; cv=none; b=I6O3GpE2fkCJY6Ahi9EMg85ws0aj6pun5VHP+b8rKD81SEB/YoBYsh07BvY8mlGHVPqjeL7FBP8aQRjHw/TzbmSbd2h+teGpBVZmldxkQOZkP5rm5LZqQiNrWQA4kDD8wItAT3A5KLf/N5zKTL0l9nXkTyP251+04ABDZkbFmZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707669077; c=relaxed/simple;
	bh=DA9dq7M4TbhxUI1Qabd8d7o5WzQ2s4lS69QxPh3gijk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MF8bJ++yXKdifqSFGsooVLSWndo6wLPHqPNpGJU1NYW5SaJCS7R7/dZ8frACvLCaMQcy/IK/Qm0eAizFOcyuFUIl/evaD5DaFjgZ3eEZA8JMAgG7GUZVFe202Ith0kMO28JGipHlAZhniWJZxp+X/jI2dTq5p4+mt2wiect8NbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hgi8o84t; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4108cbd92b9so8165995e9.1
        for <linux-pm@vger.kernel.org>; Sun, 11 Feb 2024 08:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707669074; x=1708273874; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mOhWANwOKYdeEfL69UEuiwITCvq91KBON9rm558EAiU=;
        b=hgi8o84tP5g0H0O3AgOJ9mZOVOlGY1iZ7f7r/MATcHo/5n/GvL63s3W7DYmDl8Znbu
         ThbRzbP6Rnq8nrqiexMl4QqhYwuMss330HvXWpC7QiwzHrJanUBEKzo6J4suM8KDOQUE
         OdiMYkKvMCHyneek6RQtTVX4ywQfcCqJ1QRnwywc3p4PilA/E2YMiR3Mk/hGkhsgja4x
         HYRg5sN1tVCNidjwrLtQfwZFp5WQ1jFaT2eKE5LVDc57eQyAbBuSNFsiKJe8KLPjG8TG
         i3VmaT3aAoHcMpkp8v0i4tElDW8CmpQ7cnd+C4mUoK07BJm8s0Kkcd6Zy3M7mdvbNUh5
         GUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707669074; x=1708273874;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mOhWANwOKYdeEfL69UEuiwITCvq91KBON9rm558EAiU=;
        b=BV/w2PYRKUtFFse9QIVddVrY6/ujwgkNglTchbdCdgXbtPz9XvQb4DVIDHwPn+Tmsw
         AG3ZK7XSWMc9tTrnlyQyJCiJ3B0WXsivV8VCMiaWqjZj9W7aW+4nJWiaCIUp0YU6uayc
         9sKaXYY7T3jR++oSxxC+fcegsFumCtMmLtnh1aN3ewdzFCbGd+wwNJepTzSIDbPAAtSj
         2dkpuA8UFUA1xfuASb2k2ed4C4jXclOJ+DFebKKaikP1AGTVYGco8Dtm4oOFEtyQRNfa
         I8Rokn1fP9a41xcSfEvqfwI2eV6uteSmw4v+vy6qXkRW27Y7zGyv2rfgnrElK/tnF4SY
         fXJw==
X-Gm-Message-State: AOJu0YyM4yBAbY56EC0S3ID1b2jSGljgx5q6H9JztsDTF9qQQHExN/DP
	/5SHqCLAxb5BfCnAiCDw8C1UC4ZJjEtmQW+dkrBMN+nwLeHDk2/FVowvJ7r3X0w=
X-Google-Smtp-Source: AGHT+IFfk+8ej04a/5UZQVhERRrmlv0ana7p+b6Ch8k8V9/W76I9B9x/wX2V8AkSH0ynfzirvbSftA==
X-Received: by 2002:a05:600c:444f:b0:410:c791:2c64 with SMTP id v15-20020a05600c444f00b00410c7912c64mr1259756wmn.15.1707669074004;
        Sun, 11 Feb 2024 08:31:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWux6/jxMCnx7mahXSKEb+xjVV3KhloU4fdl8qD85lI9jz4bPugReD+jPckHbIh4TtBhOgyA066CB1yV9iF0W+u1E5yXPKLvGZMzGiVDfrWogg3dmltwCLT705R2CWYnpU+fQvbUtXGJv1En0VnaF1oNKgJ0Y5xw5VBtVDhBm4OG2UWZqFRdMadf0GVwKPIQBUPZDrsP/xwY6f6MAS1LFxp+R9DOWy7LopMJHn6m86Uxh4xtlGcUDB0ew5tDWKS6tHWinzHaMlUK77ei3OY1V4tI2LGjKHB1/LbKD5Ao0umLAYqz4/HUWrIxs3DI1sxgWziMjZCELhU9czwQ6ddz6fhl+5YZELruhFCIv8yg6JktHrCrbw80yXexvuumrWVdPp01KV8o99IZqxQqacwb/qBdBsk4zYvEvh5GL/DqqC6lTUoIGW6IaYGSZJd8vr2bJwEIT5aW9/022ZYnljUsjbyt79RelIB01wHPYpLLPPaSp9fTOGJti9JEKmMgLixdci3edtH7BIR26UcxIUz5fb48kEFJgKif9ClNDW+vwgLsAeNUVBMz/k4WBGI+Ko5GriIm5SpordcYV6Ol5CV5e4O7buDtJc3Y7ri584AWRZ4Ah7mGoJpKjdhm47okPs/V1co2QGOEkSDC7GBF4U=
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id l9-20020a05600c1d0900b00410ab50f70fsm2806503wms.15.2024.02.11.08.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 08:31:13 -0800 (PST)
Message-ID: <647146ad-337e-4dc4-9db0-18daf4ef46d6@linaro.org>
Date: Sun, 11 Feb 2024 17:31:10 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] dt-bindings: thermal: sun8i: Add H616 THS
 controller
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>,
 Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Martin Botka <martin.botka@somainline.org>,
 Maksim Kiselev <bigunclemax@gmail.com>, Bob McChesney
 <bob@electricworry.net>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
References: <20240209144221.3602382-1-andre.przywara@arm.com>
 <20240209144221.3602382-3-andre.przywara@arm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240209144221.3602382-3-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/02/2024 15:42, Andre Przywara wrote:
> From: Martin Botka <martin.botka@somainline.org>
> 
> This controller is similar to the H6, but covers four sensors and uses
> slightly different calibration methods.
> Also the H616 requires to poke a bit in the SYS_CFG register range for
> correct operation, so add a phandle property to point there.
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


