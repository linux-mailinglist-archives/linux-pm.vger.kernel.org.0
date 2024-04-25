Return-Path: <linux-pm+bounces-7135-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C5D8B28F1
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 21:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5608B220AC
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 19:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D7B1514F5;
	Thu, 25 Apr 2024 19:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NLaMPAaD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB14B14E2E2
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 19:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714072718; cv=none; b=tBsNLObhvZXVJgxmGuLkhaGusxF2WJ0gKt0qDBvpMxxKUuCOJI9I0fsOgKA9LyyW8d+HXV/f3qQ+OLXaH3K9/ydsKfXmzu6SDjEyc6rWtFhNNtDHd6hbpcM3PAIYIZO+6qwuKQo2PDgQ9/7Wdh2G0XHAYlXSzAnLCY9pJLpZu0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714072718; c=relaxed/simple;
	bh=9SMxCSKhvmc+6oVvqLR1AsFgyVSziSQPD4cUWIChFV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OlrVBK+bQHYDi1K1U/A7iOj/Qs/fSYjIVCG7RegPN0YC66MXfRIKDm5yhdfWAsI1+nwud83Bd7W59VMozaRo+F8IYo2JghvtCb179LuwW1SPosDYiX2jzPv62qf/vp0OE7iASRh9I2RyVmjXrocFuam0OkxCXbUHxCIIuUw2cAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NLaMPAaD; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e6acb39d4so1701492a12.1
        for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 12:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714072714; x=1714677514; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ev52rMR4Q4Woczb+9iTzXyh9tVmc6K3sVmdOuWpY6dU=;
        b=NLaMPAaDAfWyAjYqlc8UoygSIrawsyKNAlA7ESSWqmOyuD7gYLHRVsXShcg27laH8C
         nrJd6Nj6G8fx4R8h0a8lGW4sjlZ9kMbuxbjuZPoDCVrR4Sw84QIFhpBf3t6MTgRss3lj
         taDq8/QEE0XVuwzqEDWPUP3Xc4yEjWjtvE2Mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714072714; x=1714677514;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ev52rMR4Q4Woczb+9iTzXyh9tVmc6K3sVmdOuWpY6dU=;
        b=lyUmf4E44u3ydvx6hjFO1y1l5KaUYk8u42Vfq4ItwTrji3l+072gsQWT4yStXKs+9l
         3XTNhEICmyB70camQH2M4IfB66G8BOhdO/ZqOawYe4rweqIH6J3Jz4ecRQ1R5OU0Puhe
         DySrmGZ1Uul1hgb+4jLaox0lmrwr4yM7u+qR6wWHVvDWDdUauPHbXCEQwzAQhoNpTcLq
         zDeSDCT4kTgNQz41HK8w3IbWD0wAuHeROTlbmBxH3spkz4cW2nnxOWa96WRm8zg4DQaD
         E30mbslqDp6HerJkrKrdrsBWAC5ZfDSeOhHboBXB0YeRqS7NFPi0DGw+oylOc0Pou4mB
         jajw==
X-Forwarded-Encrypted: i=1; AJvYcCXI1+FGrA2TzST08/NnVlEIokThkdBX30Ap7x2btwRku4PWqjPh3FImZSJ/0FIc7tkO6De03wocaJI+NxTQC40OtgOkOMdb7Ug=
X-Gm-Message-State: AOJu0YybFNmOnrW4cjgNqG60YLjATIH7U+SQGJYru3ZUfUjmM1j9aqVt
	ye+yNEMB6fH3eIx4HoVDfw+k/qu7o+gXzAIybw90tZGWeAFWmSICzeok03FFi3qyYyiwOS1l0ZK
	q9X+F0Q==
X-Google-Smtp-Source: AGHT+IFnd3avZ55sGvvEzuKmL1AqNWdJo3GeiDiGS4nTC7gv/dSp93FZsx2Q6VK9x9TWESg6xcdFqg==
X-Received: by 2002:a50:d613:0:b0:56b:f5ae:c6b2 with SMTP id x19-20020a50d613000000b0056bf5aec6b2mr434009edi.13.1714072714548;
        Thu, 25 Apr 2024 12:18:34 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a101-20020a509eee000000b00572459a4ffesm731269edf.56.2024.04.25.12.18.33
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 12:18:33 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a51a7d4466bso161182466b.2
        for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 12:18:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXMIu3jl0+hEdbqZW9nPUWlI8R3vCda1CCmmrhvzgDgbk9X1uG4Wu+TE7Oys1Cdhtfl8sRHcAPq0+6/AHaBF2w3D0c1O1l8pJY=
X-Received: by 2002:a17:906:1345:b0:a4e:cd5c:da72 with SMTP id
 x5-20020a170906134500b00a4ecd5cda72mr421167ejb.63.1714072713361; Thu, 25 Apr
 2024 12:18:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0iUUmMUo86vBzYJjL4NjoFzpDwD1+c292aP+T++PLv6vQ@mail.gmail.com>
 <CAHk-=wj8J78-12QfAoKaLdRi2g1=_U7sv02POShjotcJ6t4nzw@mail.gmail.com>
In-Reply-To: <CAHk-=wj8J78-12QfAoKaLdRi2g1=_U7sv02POShjotcJ6t4nzw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 Apr 2024 12:18:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj52PUZ0xtoLs79B9uar6h7FVaKC0gbD-a_wZxDjH2ViQ@mail.gmail.com>
Message-ID: <CAHk-=wj52PUZ0xtoLs79B9uar6h7FVaKC0gbD-a_wZxDjH2ViQ@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fixes for v6.9-rc6
To: "Rafael J. Wysocki" <rafael@kernel.org>, Jarred White <jarredwhite@linux.microsoft.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Apr 2024 at 11:58, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And maybe this time, it's not a buggy mess?

Actually, even with MASK_VAL() fixed, I think it's *STILL* a buggy mess.

Why? Beuse the *uses* of MASK_VAL() seem entirely bogus.

In particular, we have this in cpc_write():

        if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
                val = MASK_VAL(reg, val);

        switch (size) {
        case 8:
                writeb_relaxed(val, vaddr);
                break;
        case 16:
                writew_relaxed(val, vaddr);
                break;
        ...

and I strongly suspect that it needs to update the 'vaddr' too. Something like

        if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
                val = MASK_VAL(reg, val);
  #ifdef __LITTLE_ENDIAN
                vaddr += reg->bit_offset >> 3;
                if (reg->bit_offset & 7)
                        return -EFAULT;
  #else
                /* Fixme if we ever care */
                if (reg->bit_offset)
                        return -EFAULT;
  #endif
        }

*might* be changing this in the right direction, but it's unclear and
I neither know that CPC rules, nor did I think _that_ much about it.

Anyway, the take-away should be that all this code is entirely broken
and somebody didn't think enough about it.

It's possible that that whole cpc_write() ACPI_ADR_SPACE_SYSTEM_MEMORY
case should be done as a 64-bit "read-mask-write" sequence.

Possibly with "reg->bit_offset == 0" and the 8/16/32/64-bit cases as a
special case for "just do the write".

Or, maybe writes with a non-zero bit offset shouldn't be allowed at
all, and there are CPC rules that aren't checked. I don't know. I only
know that the current code is seriously broken.

                   Linus

