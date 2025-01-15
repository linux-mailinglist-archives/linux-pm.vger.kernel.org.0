Return-Path: <linux-pm+bounces-20465-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E2CA11B7F
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 09:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE9C3A32B4
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 08:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7043B2361C9;
	Wed, 15 Jan 2025 08:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bFvv+6ef"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3EE230D07
	for <linux-pm@vger.kernel.org>; Wed, 15 Jan 2025 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736928400; cv=none; b=QjGqLlUNhu8+kWVQcOwrNjwhE05/5p/GSrtjiQameQHSLaDls2i3QsmFOhPWuqbHAPdu1bM7EE7CRndrAHfW50j4Ll61SxWT4Hc4VRaDVzfpgbqCpWlDnQqlS6ZX21PvhxIGJbho8spTumapzFdEalPJOQ4pxlEDc0+3qV5tlOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736928400; c=relaxed/simple;
	bh=skiuF4mKziKyash7wRxgTCHEeKCEAR74XfkPxuBIFN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PujQNyfjk95+mvaOEMPkBbKRvjm797UGD/wUuQB/060iHiLTMAyyjYEy2FebaCuGA+BdgsXsAQSTRWyhMKWzPQUoo9RSrPYOLNoqWkgSnmpZt4fwkRDecryIVieT1KzDvAHnI8ufFJqSqjCMDJQDz0GdKsi6Vt5YPpRZxxSa+CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bFvv+6ef; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-436246b1f9bso8132215e9.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Jan 2025 00:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736928397; x=1737533197; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V6tmmaVntluIZHDy4W3k37bBnP5TDFLyEDatW3+vp8s=;
        b=bFvv+6efuAmHt8SRgsQ0CFGDw4qk3YnPbPUX+0/xNHIRzHj9zpLl6iBr7WhDQRrfZe
         7/pdHeEzCiN5YqxMUH3FLSxMjUSX3iTlQ1Z1SeGE4BXkh5QxDQGGcFnZ8riSPrmdGNeo
         GOtYbFt1DhQmxU023+fFnJWDQQi4eyGgtTr2wotA4Gfy3W1rJBA73kTPX+fxZdu05Gky
         9JDjZpFQWt6SFEBdtpaMtEN0JLwMjSaG5F2JxDN4mPgJAlk7g/Mg/57p4pgv8dRDy2yS
         CHm/Ya2+Iqf8P4ECEf+nwptQd/FHeUy7OAEBqrr9B6BPzLS7TVkVkBSuIgP8UNBFC8T0
         2A3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736928397; x=1737533197;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V6tmmaVntluIZHDy4W3k37bBnP5TDFLyEDatW3+vp8s=;
        b=gA5xaDjLaIeJyZuespkqipKE6Iug/EMW0XRgix0VPGjAbR0guwAqQcebOKxvTRCFWx
         3oFstsYDrg1BaFdRSU9qUxNWlxJ1spkctCeLQw+S+GxLdY82AxiQOvTNGDKhobAfmPLz
         x4k/9ic9/puX2CqdacXu806cLFTS4YSvJCBA3MaFhzcJrxoWfSe1jjTN5gyPjYae7Smr
         TPY5Yef0896UQi/Cm99ALDHMr8iC1T3UBTNeHuRLAyEMRsBtj6jO+PLU1dI/QctFkPDI
         WHC/NfMdbs3NJJd9Dmg+IZ2SBuT4zeFTzIovTZSFJACO8fLKMbGh4DyrUYBqIPqoPXJR
         Dnkg==
X-Forwarded-Encrypted: i=1; AJvYcCVA5yo9AjMb2RPxlHSrNo00fYJk6u3TY+cczqLQ7Be+1P7vU4sgsimZcOuXY1kUChqawEl/nwXSjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxT9oCFICTkE/6T6Hc3lsyKQ9kM81HZnUNB/pvKHm/hiImu6KPI
	qbf3FY6JLbh8rJzjXbViFVokINMOYRGyM7ZcAjT05W4rD8S6gj8ylg0Pa8MnCtQ=
X-Gm-Gg: ASbGncuBCvutX5q0Td/MfyeZDqC31EpjIheLrDUYpnuvr52oN36m9gx6U8HZfaiICcu
	qT10DVHMuEi34r8ysB+lOVLvaQBGQ/ZUaVD4g3jsbCjUPF9drui8/RLAINaQ0EivAxGfjF0+ytW
	NVylDlfM6pDVI/G2IaOyUXQ1mcYypXrmLxWg15jGaYPhG9xNImvG6XThRdjKfiAgIpCd3HoQ1gx
	tSqA3329wei0yxYZcTWcYMDkTcI/9mnHEqgkRUd6RtzU74h5kOACscJrT3zwCVYPNXf7HUP+Sba
X-Google-Smtp-Source: AGHT+IERkrSq6zfrDfiGjxlzVHToRu9to7KUnw+e7J8Elokl8vRWR9VD6r4ks9l8S3yf7KEoDEuEjA==
X-Received: by 2002:adf:9ccd:0:b0:38a:69a9:af95 with SMTP id ffacd0b85a97d-38a872e5eeamr7782610f8f.7.1736928396613;
        Wed, 15 Jan 2025 00:06:36 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c74fc57csm14318475e9.40.2025.01.15.00.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 00:06:35 -0800 (PST)
Message-ID: <55df5f1c-a429-4fc3-9857-c5580090a690@linaro.org>
Date: Wed, 15 Jan 2025 09:06:34 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIXSBwbWRvbWFpbjogVXNlIHN0cl9lbmFi?=
 =?UTF-8?Q?le=5Fdisable-like_helpers?=
To: Changhuang Liang <changhuang.liang@starfivetech.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>, Walker Chen <walker.chen@starfivetech.com>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
References: <20250114203547.1013010-1-krzysztof.kozlowski@linaro.org>
 <ZQ0PR01MB1302D40B42B69887842A7377F219A@ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZQ0PR01MB1302D40B42B69887842A7377F219A@ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/01/2025 02:55, Changhuang Liang wrote:
> 
> In jh71xx-pmu.c jh71xx_pmu_set_state(), maybe you can also change this line:
> 
> 	if (is_on == on) {
> 		dev_dbg(pmu->dev, "pm domain [%s] is already %sable status.\n",
> 			pmd->genpd.name, on ? "en" : "dis");
> 		return 0;
> 	}
> ====>
> 	if (is_on == on) {
> 		dev_dbg(pmu->dev, "pm domain [%s] is already %s status.\n",
> 			pmd->genpd.name, str_enable_disable(on));
Sure

Best regards,
Krzysztof

