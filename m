Return-Path: <linux-pm+bounces-5868-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCC88970E5
	for <lists+linux-pm@lfdr.de>; Wed,  3 Apr 2024 15:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5E2F1F270C0
	for <lists+linux-pm@lfdr.de>; Wed,  3 Apr 2024 13:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696D0148FF8;
	Wed,  3 Apr 2024 13:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WSNDfrU1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE37148824
	for <linux-pm@vger.kernel.org>; Wed,  3 Apr 2024 13:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150778; cv=none; b=qINrhj1KX7BWb+ZoYVOmcSXi7z8blOcBnhqfU0sddpeCpfAIg9gpt6JIU4wmckuDtKJPDpFYMO7918zjI305GGnSbHuDT+abb6yRZjlye2swNP72IQREbvxK25uwul6JmZKmQ92RILs5ozyxhZIsw5BYNOXWS78h8BYVW0AiwnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150778; c=relaxed/simple;
	bh=/ZFx3ebO9y9cafs7GJSvKhCZCl2L53c7NYdEippbANY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nC2J2NTSuDA7bn9AqUmEYKmEVbJIv7wyU2mwTe00qPDk/DBRCMn5VYlY1gWrDn5uLY+KFlp/ebJYunfpCcSP/VKi00E63/PmrJxmJLx8nKK7G/aVjcTpZJfJMi2N6FbcUKenk4taAKyaPfENZEkIdSDzrwz3jFRoYNpE8gybVts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WSNDfrU1; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2a28b11db68so706831a91.2
        for <linux-pm@vger.kernel.org>; Wed, 03 Apr 2024 06:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712150776; x=1712755576; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kr5yQL8fx0u0tyLMbu3sLuMSllEG5G+mAeHccxYfdVY=;
        b=WSNDfrU1A5IuXWhh9HEqfMP+zlmpZ+t64/OBY35FevtWwhqB8nNVHgahOdCX79SOp3
         1yn4HDv63eYR79bakZ9SkDgU02BXUgYL9Wipu16c1zbX53EgqjoEXfn9Ts3KixMoQj8e
         ZT3d9gYmEjpubF0RDlGKNv3zHXYOgSHzz81a68rJm6oZ/xNJVXvfsteVWByLQ1UANfeU
         ybeLHoHUWN8KZwzf7IWlteXQvzSC4yGMukXof5DunOP5/NkU/nTmJDZOa1BB123Uw7RB
         ceEVVEephv1GR+LLJftUFK8eNa+o1E/zwIime3eFHQpxgsQziB+wm/Tm99kxK+BMUdib
         CLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712150776; x=1712755576;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kr5yQL8fx0u0tyLMbu3sLuMSllEG5G+mAeHccxYfdVY=;
        b=TkO+7rUew8o3VlRsPQTTpnZYzj73ikCRa6aG9Cjdau4IvEAyR+C8ylFIzYKsTlkSAu
         3fnV1j56kUeGZgs9yL940hKq5tDPVkyqICXwVYcFS1qRUmhrC1WLNCklkHBFnWe1kAWs
         mf9FKt/a0GX7nBbqYrDMwqA5pOVTTZe1xqPVF1CLdLSJdXchWyNcVhg7QULz+0ynEyOR
         k9Y7Un/iDTqsp1wPyI99wfL0gu2aqVAy6wrXJbHI0IMYFuB1w7WC6jSiHbgUwIIBn230
         fj7fCBC4epXwdymS9n0OYu0xTkxoUeEjVy4QsE25FRQzHlVwmMrxu3SoQxF+Rhqorux9
         ZseA==
X-Forwarded-Encrypted: i=1; AJvYcCXRNDPFf8Nw9fgqcYk9XKiuxosjlrC5d0ZeDiO8IPexfoDTt3HyEnm0E+owWXjSwb3DO9vrII6xGiZhu3XVae14Ity/9W1YZJM=
X-Gm-Message-State: AOJu0YzaC0+5P9WQ/yjStee5pee9p6yUou33/uCZ74N4WLVY636zBbSi
	jNpl9bb3SoB97f01Q6CQOe0q3sv7pB/SISm7sfohC7kPPEv+Q2CMRnWvLmyL5EY5eJVj9h9n/f+
	3cKSNfjWkL+Yr2GLovw0RJZ+Udm3kYbQo3nsQ5A==
X-Google-Smtp-Source: AGHT+IEak/WLSgffbuVSjwab06JTulWpxWfMzkQ8I6F5L8nOzPRvaiqB048L3gfCz5mrvMfqk7JY/JqIUVyg8IDxNG0=
X-Received: by 2002:a17:90b:19c3:b0:2a2:a7be:3b5c with SMTP id
 nm3-20020a17090b19c300b002a2a7be3b5cmr1005626pjb.6.1712150776261; Wed, 03 Apr
 2024 06:26:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYtj3aBdRreBmKZDQApEe2x8mugycPgN+_J5ebJzXDEq4g@mail.gmail.com>
In-Reply-To: <CA+G9fYtj3aBdRreBmKZDQApEe2x8mugycPgN+_J5ebJzXDEq4g@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 3 Apr 2024 15:26:05 +0200
Message-ID: <CAKfTPtC9YgbZgGNK82MhhzzsD3P6j64+w6oieJMDKQNOmrC4FQ@mail.gmail.com>
Subject: Re: kernel/sched/core.c:961:15: error: incompatible pointer to
 integer conversion passing 'typeof
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, 
	Linux Regressions <regressions@lists.linux.dev>, lkft-triage@lists.linaro.org, 
	clang-built-linux <llvm@lists.linux.dev>, Linux PM <linux-pm@vger.kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, linux-riscv@lists.infradead.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"

Hi Naresh,

Adding riscv people

On Wed, 3 Apr 2024 at 09:38, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> The riscv clang-17 defconfig build failed due to following warnings / errors
> on the Linux next-20240402.

Could you confirm that there is no problem with other arch and/or
other toolchain ?

>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> riscv:
>   build:
>     * clang-17-lkftconfig - Failed
>     * rv32-clang-17-defconfig - Failed
>     * clang-17-tinyconfig - Failed
>     * rv32-clang-17-tinyconfig - Failed
>     * clang-17-defconfig - Failed
>     * clang-17-allnoconfig - Failed
>     * rv32-clang-17-allnoconfig - Failed
>
> Build log:
> -------
> kernel/sched/core.c:961:15: error: incompatible pointer to integer
> conversion passing 'typeof (*((__ai_ptr)))' (aka 'struct wake_q_node
> *') to parameter of type 'uintptr_t' (aka 'unsigned long')
> [-Wint-conversion]
>   961 |         if (unlikely(cmpxchg_relaxed(&node->next, NULL, WAKE_Q_TAIL)))
>       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

There is no recent change on this code. Could it be a change in
cmpxchg_relaxed ?

>
> Steps to reproduce:
> ---------
> # tuxmake --runtime podman --target-arch riscv --toolchain clang-17
> --kconfig defconfig LLVM=1 LLVM_IAS=1
>
> Links:
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240402/testrun/23264917/suite/build/test/clang-17-defconfig/details/
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240402/testrun/23264917/suite/build/test/clang-17-defconfig/log
>
> --
> Linaro LKFT
> https://lkft.linaro.org

