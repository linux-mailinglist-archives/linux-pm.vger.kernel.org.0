Return-Path: <linux-pm+bounces-25707-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DCAA93671
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 13:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 033B37B147F
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 11:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA8F270ED0;
	Fri, 18 Apr 2025 11:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="j8UA000Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0861521ABCD
	for <linux-pm@vger.kernel.org>; Fri, 18 Apr 2025 11:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744975218; cv=none; b=hJ4OFv8MzabcO26Gy9Mv6EaoF7p26k0NlLxdVfwGKHRH5RWRxv0/CAEd0P9sP7chWAv5Tx5o0pkPYbeVXFLVskOf9zslxbr0G3o8rxzsI25jCNy5R9DJCOWu00SMDxpIV1iT6Qqr/Yk/mbsdARVMXvdEOJ6VkfIRIYUp2E3st5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744975218; c=relaxed/simple;
	bh=Sj8X2Lm6wKekaBjcx9Vsfq4exmy8nxBLBwcn+T7xo+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mwir+Imn99AoKlRRbY+2sMP3y5RTrj/eiwboyTkM7mywUHd7r/TLKkguuEzf365dR7X2HEdOR6lobWCy432kDQMc/LyjKxKlpJY3rTeTSPuqHD583qGoZr8yDxw3j6LfL9/psPUnSaJtfPH2fP4v7Hw20sCHzZMRR6CPOF323t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=j8UA000Q; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so21287035e9.1
        for <linux-pm@vger.kernel.org>; Fri, 18 Apr 2025 04:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1744975215; x=1745580015; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJj8Rfgi9EbV15zm3T8GaXom1YrGzd0C3xNCTSZPHuE=;
        b=j8UA000QIQkKpdWrRa/axOMJaoNjF3ix6zOsUjvMc+/cg97871DIOvaq4qcthpUoIL
         dr2bihlN7/wbIWb/Xl5figifHjowTitSWCkFs7G7f0Pb7qP0blE2hQqCbuYbSSrO0r23
         7q+9wR1hxYkJmh3CjVnuaB3ad1jJMyZhOx5AQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744975215; x=1745580015;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJj8Rfgi9EbV15zm3T8GaXom1YrGzd0C3xNCTSZPHuE=;
        b=VVxxIlFtIUl7eGqqTJTpiqTn/aqvqU7OpoWp1YKNN3gs3RJL622Qo0AqWEAdj6B1w+
         4eiwm9yKGmhWjssWuzxRO2yOJNxH0NLhJDccSU7AIU+MAkzIf01iHKrH18AsYXDyT14R
         owglJWH+gHl9Ey9sqtZlI71VyMQPohW06fz77b4oK3jZwpZN4PHZ2jE8n1AC4GYNeVCR
         817AIyi+sBHJzmrAsmhx3vDWoo7gMlU6vU+8u71L34stQQQB+Smm6hLct5TeNYcEl0yP
         ANNVFY3DizwW4PgX7XvnQSQBL6o/9+KHQA6YfAP3OTZfm6wEworEB9PlL60SCRMZWybb
         1+Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVwP2xPE6pUO3KzWgY3ynlyn8B6OoQFEH2s9mow0vk6b+ncrIvmiolWbV9qR3uehh5T9N44f0+LTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwS8E0x5EbCjNlEMRJpLKjeSpMrHgMjN3IKZ7XDnLnX9LleQ7rw
	3UD9vZXOPZjWe25LoZjj+sRWRRbzvGKbzFYWTo6fqCqzbWQnEGj5Ug/Fg8A/F+Q=
X-Gm-Gg: ASbGncsbjd/VM2EPhQuxr3G13xzYGLLrNKEa0HfTQchUJ1U592bUtP/f9a1rHzEd8I0
	n5FsFCb9qxswBCb3dLQpPxdVoSq4kXuxR1OIgtdJO/ADPL2GgwNmZJ4hxCecSblCQbipR8EquUa
	p/2AUpiN92m6vqzkLMrM8qzEEn0tQSpv4E4o8FuTgRrUwpiXXGwptKu8YRZnldsqUpgSnG+pwzX
	OLBDolNQJjx0O+0AElN6sbdKSYnPWq1UNIZYHEzb8QK1KR1dndp1gEzCz51aCjjGp6ouGXufIm8
	zKjIVVTjh4laDY0dwLTt8ZNSNCgmCT7x9MCoJhgEtXzfIHKJXzME2kX/vtyMIV36GeyM7SuXZAk
	oP+VJKA==
X-Google-Smtp-Source: AGHT+IEH86lkzDB8iD2jcwBv9xObYazBn81tO8e62htfmOl2I85kmXIxDh76Itbbny1GahYRs6qSCQ==
X-Received: by 2002:a05:6000:184f:b0:39b:f44b:e176 with SMTP id ffacd0b85a97d-39ef9466f36mr2679870f8f.24.1744975215276;
        Fri, 18 Apr 2025 04:20:15 -0700 (PDT)
Received: from [192.168.1.183] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5cf2easm18698005e9.31.2025.04.18.04.20.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 04:20:14 -0700 (PDT)
Message-ID: <4fb6d880-3d5f-4d42-8419-dcc697949a10@citrix.com>
Date: Fri, 18 Apr 2025 12:20:13 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -tip v2 1/2] x86/boot: Remove semicolon from "rep"
 prefixes
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-video@atrey.karlin.mff.cuni.cz,
 xen-devel@lists.xenproject.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Martin Mares <mj@ucw.cz>
References: <20250418071437.4144391-1-ubizjak@gmail.com>
 <50bf962c-2c9e-46a2-bbac-cba9cf229e79@citrix.com>
 <CAFULd4ZNiRdARn8O98zROQRWoL1ASQ+iPPTTmLRxjo9SGRHyRg@mail.gmail.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <CAFULd4ZNiRdARn8O98zROQRWoL1ASQ+iPPTTmLRxjo9SGRHyRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18/04/2025 12:15 pm, Uros Bizjak wrote:
> On Fri, Apr 18, 2025 at 12:24 PM Andrew Cooper
> <andrew.cooper3@citrix.com> wrote:
>> On 18/04/2025 8:13 am, Uros Bizjak wrote:
>>> diff --git a/arch/x86/boot/video.c b/arch/x86/boot/video.c
>>> index f2e96905b3fe..0641c8c46aee 100644
>>> --- a/arch/x86/boot/video.c
>>> +++ b/arch/x86/boot/video.c
>>> @@ -292,7 +292,7 @@ static void restore_screen(void)
>>>                            "shrw %%cx ; "
>>>                            "jnc 1f ; "
>>>                            "stosw \n\t"
>>> -                          "1: rep;stosl ; "
>>> +                          "1: rep stosl ; "
>>>                            "popw %%es"
>> Doesn't this one still need a separator between STOSL and POPW ?
> ";" is a separator as well.

Yes, it is.  I've clearly not had enough coffee yet.  Sorry for the noise.

~Andrew

