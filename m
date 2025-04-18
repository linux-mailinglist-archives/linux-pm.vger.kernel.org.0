Return-Path: <linux-pm+bounces-25702-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AEDA935F7
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 12:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD5B87B304D
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 10:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E822222A4;
	Fri, 18 Apr 2025 10:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="G/1b13db"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA5E270EB0
	for <linux-pm@vger.kernel.org>; Fri, 18 Apr 2025 10:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744971849; cv=none; b=SeItTCCV8uvqWxY9w7Dv7MKqn+ZCKkW4n4/emKTzEEj3QaOrXGIl9D7p2oLemLI/UB9P6FcXlarjaobIBWF6Y+YmgIH9VcibgXZXCVwHxSsuRfyEpu91zCHu2qWACjJEgTL+mP90LsyOcaIvb4rhMzhilxCFTYlTrf08sS9Jl7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744971849; c=relaxed/simple;
	bh=atJhdaYKS6mysof7bXhlzakrTennjV1rb/oDep2wowk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Egmf3p259nXBlWHjHifYjjpTYR2IxIpK9yJqbJ8YfnqBOueu3lIyEdEDyxaJIFeYoHX1jetZO89QqpWRcvezqbRyWgGkobYLvChvjyddcaFXBdduPvB9CIrUzvyU2B2BIhpfTU+edfknV4agu8pOAzaeS4hzZP0B1y8c9/aIenQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=G/1b13db; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-391342fc0b5so1418656f8f.3
        for <linux-pm@vger.kernel.org>; Fri, 18 Apr 2025 03:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1744971846; x=1745576646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YJmTDwCr1kPva4b5vrqnHN2+KW5Z+MMvffJ+VbT6Gqg=;
        b=G/1b13dbFPQ3pVu2wAmR7BitESN2ySJU05KmD8gl/wGhLMAhtHgi4KGdyv6zJx0JmW
         67mZezflUT28zIgfZByxXwD5AfJF4w9A9maQIUKAa2Ml1kgozLHqicjpC2r+E51lEbUi
         sJLgYciLUqydjlo/Q1A6HT5vbaLt0vYNeBhSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744971846; x=1745576646;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJmTDwCr1kPva4b5vrqnHN2+KW5Z+MMvffJ+VbT6Gqg=;
        b=IwYPXwX2eOtJr6cvIXCbRYg08muQzTCpyuO5kdEF7rfa+ztsZkNfEeopEbLSQZh5Bx
         6jLwe4SF8k1dbVluaoSRMBOH9VJxMIRLDiSD2p62j55YV65cAPX0ouwaqjupPDt2ItIn
         xp/ZsTDUgczpVX34PqJEcKIjHrsKXNmrHaRL95dycDdubkSgurslD4/Og17QUufxHR/p
         i3pEajQ0NUEVU3gxbVyb5GMtcuxy/RXyZhK+sWKWq/SwY/qqvi2cEz497DSa1nDcQlXV
         W6cFTw23y5MCRP/SPkpKuc8v4r1m2qPL+Z3kdn74qiM0dKlq82//d1hnxaC6aHHNoyHc
         TglQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBcsywRl4Ztiz1XVYF28PDjXK8SFfrNubMO2kKyipjad1whyZRn3Hgp1lSNytNxviItmXNQh/wHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyusjGaoB6duCmezEAiyAdVoeLHezgnpRROtPKPW6JSaxKr8mPs
	hLc/Nh67SxOzdR8Jshj1LiuMzkv8KT6P/BUbcG8D7JMpsE5o4B4Og+XvEiEzyBo=
X-Gm-Gg: ASbGncsA2RTREWq1d3mbTtGaIRXZjtBjfhxXayqgeMrF3z5avcv/M7AnriFBS/mtE5g
	3T6G3hGoYtNvdcuobDT1VYAoKphV7F2eL0TxzLDkIs8EYRvKySrEWHEmjBKB6Jq5UB59zwLug3g
	4GtJV6dEwYMrEKh2rHKxJUQTvbaRXBEGNlaC7gOEt2FLNHsS2s2H6gBF1uSONdIv/ZQEGpwSUSP
	jmUXZZjg40DfBniPVtZ8c1e45HMlqsd+EPxWPZ32lIBav2gdEb4VZXSS28nxBE5zMtIUYKUGfwV
	E8RBrh5vagFlKxXgXTN2U30V+d/BwbbOtSM3cG9rEJpI0Z7/qAeAt08Z6HQBDJk0Qi81pML+qQI
	4f8PChA==
X-Google-Smtp-Source: AGHT+IHVvlOW/PQKztqdeuYLzZIIyWPEnxfP7TS8Tghjk3gRsyw5XUF1KlSks6byhbOqrb7JpJRwGA==
X-Received: by 2002:a05:6000:40de:b0:39e:e438:8e32 with SMTP id ffacd0b85a97d-39efbb09208mr1538497f8f.55.1744971845933;
        Fri, 18 Apr 2025 03:24:05 -0700 (PDT)
Received: from [192.168.1.183] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa420683sm2349158f8f.20.2025.04.18.03.24.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 03:24:05 -0700 (PDT)
Message-ID: <50bf962c-2c9e-46a2-bbac-cba9cf229e79@citrix.com>
Date: Fri, 18 Apr 2025 11:24:04 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -tip v2 1/2] x86/boot: Remove semicolon from "rep"
 prefixes
To: Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
 linux-video@atrey.karlin.mff.cuni.cz, xen-devel@lists.xenproject.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>
References: <20250418071437.4144391-1-ubizjak@gmail.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20250418071437.4144391-1-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/04/2025 8:13 am, Uros Bizjak wrote:
> diff --git a/arch/x86/boot/video.c b/arch/x86/boot/video.c
> index f2e96905b3fe..0641c8c46aee 100644
> --- a/arch/x86/boot/video.c
> +++ b/arch/x86/boot/video.c
> @@ -292,7 +292,7 @@ static void restore_screen(void)
>  			     "shrw %%cx ; "
>  			     "jnc 1f ; "
>  			     "stosw \n\t"
> -			     "1: rep;stosl ; "
> +			     "1: rep stosl ; "
>  			     "popw %%es"

Doesn't this one still need a separator between STOSL and POPW ?

~Andrew

