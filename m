Return-Path: <linux-pm+bounces-40385-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF0ACFF471
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 19:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CD0B339FE75
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 16:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E089239E16D;
	Wed,  7 Jan 2026 16:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gJVwcJUH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A02F36657A
	for <linux-pm@vger.kernel.org>; Wed,  7 Jan 2026 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767803912; cv=none; b=ld8tD4AGfLiKz0ujoCgDpH7+c7sAOyYQQw+MTn0Ku7CPPXoN0LLOa+93b7uxDIkKp+K1379WxbBHmeqck8EWcn6ePNXut2mFcwezbDyN4XDfFX7KOOcihSDznLEURIWFpdb+GgcBksA7CQmDGG3r+KzRZZsNQ37TP2jn21g94qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767803912; c=relaxed/simple;
	bh=5h4K5oub7/AXA/c29GFK3TWej4Mta4tDG2m4A/NuNYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lke1NbVZGUhPjdapTI69KC4F2nEazBrxQj5Ht7HkSk0zPA5lYBmJ8KXIaVEdnhnwpPIYkjczfW+gs86C41Cbe5xjga0/KvuAWq4Nc3/GUm9mmfRamabQUyWHHKZbjura16ZsbKr+r40YBaSS6N/oWZofvccctezY7CoerQ/LSQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gJVwcJUH; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47d59da3d81so4963725e9.0
        for <linux-pm@vger.kernel.org>; Wed, 07 Jan 2026 08:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767803903; x=1768408703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VE8Zj62WXZdLdYrr2YwiHtiAoQvZVh2N0dQUprLSifQ=;
        b=gJVwcJUHS51Sy1heqVaoDG3EeOCsP2Fa6j8+KqGrC0e+BMkHr3fYLobL+lYwacpgOU
         1zRyF7D6bmFk0yoLVrXo6SmPj5c/S3dljFz/Haq4VPwkenNO6YUewC08sbVhLLvfTHmy
         d62qluusIEGnCt1bx8O6FQO/SX7EtldvEOa4fS6HfYp8Oqe0JHTaE7HIpCXe3v24ppqg
         gJDqjnsCFIu8f6ZaeJBZtGxBVkvE6EYEdHHg/m/QJ68mK2YakMOyd0xUMVt6wSsYutA3
         /aYcYxc6xmoQ0AJ793ZH+A80bTHiwOM481iBU2fHRySx4+qM2bO0cUes//3SrFrzA4WL
         Trzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767803903; x=1768408703;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VE8Zj62WXZdLdYrr2YwiHtiAoQvZVh2N0dQUprLSifQ=;
        b=tym8N5/E/oJIfJxwZyIa/tu0eAS6WVipJpvzuPRDVEdAShR2EEiX+CLx2Eg/0kXsRo
         cWuOQEo9fuEInxhRYz2azFTIUiOgKnWUJTJnMmdsfkLY5O9iCJpOJe1slDvEHkWDLJk2
         nZffAQMy/f7m044Xu7/LuXos66jVKxKbjKzKs/6batyuQJkA1F9Shpxj8FSD2seofEX/
         nBGCB3Opp2+PzYlLdWH6WgYLp4+Sbv3nug7cFIAAH8FrQvc1K6Uwd0IdyKP2If3HHNUP
         6gJ4Y8ZKCH5DQCZSF/P38CDMFxIIjm/fTh7Cdl+vQC9ixwlU0V6cUmsFR6O3Idq1PLLX
         W/uA==
X-Gm-Message-State: AOJu0Yy3NDSz6he6Xn16r+03zoRpD8CoEFeYl6gJRGnCZyJP1frv918q
	/cKJdJGRPLBjc3ImGpJiurOFz94lAsWGPSmj+ErypmZBFqaSGuWfwcvDcjXdMGZ8fFM=
X-Gm-Gg: AY/fxX6ufUnZSgeFVIY6s3m4FVtpzF476LN7XM6euWBj/Pjya0DY3xvTWbAG3lD5dxd
	xY6UL6Ytdn4SpNVlFdVBPEAqTu0ND3Fm3HHB+LnZa5ypmDsibT33dTnzjIcTrxenWTu1hSax6D9
	NroZgLZVtBGPp7fgeC71gNrK9SaWVrWspUKzToSM4dcKTiFKhCvMrjcFUVI98mEROVBJj8GPHNf
	0mFFZLc2WmNj6MXLS9LSw3DMc4UJ2ADToPw3bi3tGHlLPqiev6pt1oNuBaI1zrvSeAiQOEHYIyu
	WYbMU7alUWK/ZrWFOF8BK61l45xddCm0RmW4KURklDtiXyUiqL86tXV72XgrYoMFli70L95NS4o
	mU96Pj6ub7fVtsJTGXupg5H+V3qbQ0mIR3rK/UH3cAzd4lEy3L598iqfB6lOZRtveN6hkLLRVh/
	o85mTpdjlkCx2BkmvIoUn4Nu7WrwMnulkhjRSb7vKlsVDs4CdWjRuKwbjGjF6Hfrgtsw==
X-Google-Smtp-Source: AGHT+IFlEZxyM1oDC2UILSq7md9juHQsIhmsBcJE41UR70lvfgIq0kGCqYeoOjecl8psTYZcXOhJag==
X-Received: by 2002:a05:600d:41c9:b0:45d:5c71:769d with SMTP id 5b1f17b1804b1-47d8484a4e7mr37627045e9.8.1767803902697;
        Wed, 07 Jan 2026 08:38:22 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:edca:100f:ed11:66f2? ([2a05:6e02:1041:c10:edca:100f:ed11:66f2])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47d8715b5f7sm17049305e9.4.2026.01.07.08.38.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 08:38:22 -0800 (PST)
Message-ID: <a6c04e69-b0fe-43b1-ab7b-3326f6980471@linaro.org>
Date: Wed, 7 Jan 2026 17:38:21 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] Add TSU support for RZ/T2H and RZ/N2H
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
 John Madieu <john.madieu.xa@bp.renesas.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 "magnus.damm" <magnus.damm@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
References: <20251126130356.2768625-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <TYRPR01MB15619FEEF47DF01E9FFD57BF68586A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <TYRPR01MB15619FEEF47DF01E9FFD57BF68586A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/5/26 10:09, Cosmin-Gabriel Tanislav wrote:
> Could I have some feedback from the thermal maintainers regarding
> this series? Is there anything I must change for it to be queued up?

At the first glance, the changes look ok for me.

John ? Geert ? Magnus ?


[ ... ]

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

