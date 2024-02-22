Return-Path: <linux-pm+bounces-4278-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C6185FC88
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 16:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2BDB28637A
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 15:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F97E14D441;
	Thu, 22 Feb 2024 15:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EGK1Lq5k"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B943D14D42B
	for <linux-pm@vger.kernel.org>; Thu, 22 Feb 2024 15:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616243; cv=none; b=taJj6xUnMJbrZCC9b3BFIzTmktvtU00UOyp7fgJyAuauKxlmZdxaCtjDa6jPTXKnS5HTdfbfJE0A9BuhuKlT54WeU68K70DOC9/gVR2KIytrZQkOBfqU15IOPCjZ29l+Ng3a6acQugtfFjO9BBoYrmZg/X1A1pnuayJBN9061so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616243; c=relaxed/simple;
	bh=G6FdFkR1SinAjzKeeCmu/d6YLuca223FdRsHUFO3wPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NNDgLE30fFlNPYNJGUffwadIqVR2QVnMhFPlCMFD1keaALZRz2+laeOh6dqb2UNdp66kB6B0lH7QZTrnXwY+qX6QfyH6A7JUMVfsjwT0MlNWTtCnSZ2edOmY5l74LKdVB3/B9ni/bVSz+Ui56yxgqgepw393te9JVV9b9sib9lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EGK1Lq5k; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4128fe4b8c8so481805e9.1
        for <linux-pm@vger.kernel.org>; Thu, 22 Feb 2024 07:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708616240; x=1709221040; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ONFC+sKbmZgeU+8ec+H5IbujbZssYRsodi4WGWZ5Qg=;
        b=EGK1Lq5kNsPIGPN2VD8CPDYa7lJTZ/B9GG+YaMAn5765RSOdyirTu4JfBiBIWCMRMI
         33at6d1mPcjKifzZEdcq0yiELAN9QZiPUzHvvBG7ULc6BqxONmi+Xo7G+DPJVjh3MMk7
         XkRWxemb4hU5Ivmvy3jD44Q4eqGrmk1sMiqqEs2gTIB0/bxNTg/XiyWqnyjO6Vt09PrF
         NrkbkGGXnkZwHxFhXaXy3+CGjiJwxu/r0JKnlzhl4Cidcd8mYGjxmPPC6BhZBWlhjbR7
         CX7896FYCxkzPyBSc3adPV5mW8r/d0/tjEJa8J6wBY/xIlJd54cROR31zk+KD2/FqC8a
         eDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708616240; x=1709221040;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ONFC+sKbmZgeU+8ec+H5IbujbZssYRsodi4WGWZ5Qg=;
        b=Npqu0qMc2ixXTCzPsZijI4+nZMua8h8OaZy5l3eKVuSWvEftBkQ+DjFB2PCBD4mDVW
         O3HmYPQ+sbYpUkxzPdFo+dolKZ4u0orfuks8iSgZnUIOm0l0bzggj9g2FUHk0VB1e9F6
         fpXlstLHs3opoR7k8BpXjbz7X951ndrSe4q64bJVZ5hIkrnWPfCatbGfM7SHqEk/XeOF
         84fDkYcb+GqeXOcFj57c55K5HtMwycgqSBYSZr7yV9IPXn5vZfcUMPK1N4K5oO1v3+I9
         Fe2CNdR96vVJicHwRXoKViQl+NXVkkWoZlO3Jojt65BkDRUZFsyQHRToH/HCIH3YVa1J
         R/zQ==
X-Forwarded-Encrypted: i=1; AJvYcCULuliyG40eKh5fN2O4j4/ES2ENLCcL4+Cwd5tDV4WQVBAVHDIpd5BQUO+Tm+xC5nnk7xUF6eHXOc8INulhMaT8Qz4D+kveov0=
X-Gm-Message-State: AOJu0YzEsbW0v2/QmKm3H6o8zT34VSE4roP9e0POB4RMddoukWDtPM6M
	3m+NQsuQabFWYVjpOqrr2Di5Tj03322u7dLXmUCz/sug4g4Rzm8uusCg0QdpBYk=
X-Google-Smtp-Source: AGHT+IHunUCMJsjJDlX8NcL9abpvM7ZuC/4JFzRgNazdiUVASL0PdNnWK/BRF4OjEz2bKtAMkbZBYg==
X-Received: by 2002:adf:f9cb:0:b0:33d:269d:a80c with SMTP id w11-20020adff9cb000000b0033d269da80cmr12005438wrr.41.1708616240076;
        Thu, 22 Feb 2024 07:37:20 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ba24-20020a0560001c1800b0033d9ee09b7asm315655wrb.107.2024.02.22.07.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 07:37:19 -0800 (PST)
Message-ID: <986d5e42-f349-4069-b951-6c0ceb909dfe@linaro.org>
Date: Thu, 22 Feb 2024 16:37:18 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] thermal: core: Eliminate writable trip points
 masks
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, netdev@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 linux-wireless@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
References: <6017196.lOV4Wx5bFT@kreacher> <5913164.MhkbZ0Pkbq@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <5913164.MhkbZ0Pkbq@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/02/2024 19:42, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> All of the thermal_zone_device_register_with_trips() callers pass zero
> writable trip points masks to it, so drop the mask argument from that
> function and update all of its callers accordingly.
> 
> This also removes the artificial trip points per zone limit of 32,
> related to using writable trip points masks.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


