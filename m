Return-Path: <linux-pm+bounces-5838-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 582F58966BF
	for <lists+linux-pm@lfdr.de>; Wed,  3 Apr 2024 09:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76A81F28AB2
	for <lists+linux-pm@lfdr.de>; Wed,  3 Apr 2024 07:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1045B698;
	Wed,  3 Apr 2024 07:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y3gvi4/R"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD145BAD7
	for <linux-pm@vger.kernel.org>; Wed,  3 Apr 2024 07:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712129903; cv=none; b=rgpmQGY4U83yWjMDx+0j4+ADQ0EDrUa3Hrs5iIWXNa401gVI8SebOToyCAE9fTlF4FQpZBwVsotkVrr/sVVX109PMdWhR3dDjOEmLZZ1rvjypanadaI0hGKKYB0NzdO6K5m7rSpI+XvtGVKuGPBlCzMppvJjHeYAWvzJZUhimJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712129903; c=relaxed/simple;
	bh=9WbOVVSwUWwd5K793ppWlQLxaj4rX8ZTjnhFhq5Y5v8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=cpRZQ1+3ik4ioJf0wqqIu91TgMSdxYuXgAU9Pm3A299OjklAT8IjPh6jIQXt8inR8vit3JAVM24HoHXoKkpgY4SWGUBe+E3FxXLuqByefezjrrxwZJ/vu9qsFKHZcgflzQUwZr3vy2ci+3oO+Qv3bmn+Cn4Bp+Vo3+vhOnVaiZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y3gvi4/R; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-47866551165so1273589137.1
        for <linux-pm@vger.kernel.org>; Wed, 03 Apr 2024 00:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712129900; x=1712734700; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QKsiTWwQltevYA1r+W4p6ubtTr4MlTT13dNzhqyl5yk=;
        b=y3gvi4/RAJmfKEgnpoLxwnQE8433aLxyArRDAGslmuB9KxTQuEh+J/WLv9kgcqoQ8M
         /yfUKwEq7n5kHEcOyYiEAi/O1Egb50y4A7gfQlweqg2pIm1E4DwdH5MY+oUXywgYrNho
         kFlg17qsPV1yr2tLxnpHYKmNPiHdOQn6NZV4xJYzXOUQgeZCtha9MN/4VEXcx3vB7XPP
         JuJr/aO3gAqrFN04tLz8ClQW3/Xt74e3QsOkV65d6QkS24y4GYaoiCKXgZMgFmN+PGZ8
         GKzRFKrHY/gkDf8oNMQPHAeulUmd0zchG2aFBXTjaFvF1MJVie/FxLD9LNWAlAaVJClW
         3j+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712129900; x=1712734700;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QKsiTWwQltevYA1r+W4p6ubtTr4MlTT13dNzhqyl5yk=;
        b=fvU2pOXCMLdEq8ao1BlED7mXQ7mT4kgyVWwpcmgAHbxZpFa1tV7T9wrsxvJdCmfrAG
         SOzBPxijqPQYbHMPEIafZqwLmFyZCnIjJOXlt+fwY6yXl7/a9NIKuhHcYtycJXrNMAme
         sH8Z+ro5bU9AyLP2AKwyp6/giJymyK0D1YEmVwQ1MpbJEO8q9zy6YUAEvXNFvSGvgqZ4
         6A+6r7A2zu1wBqGdujihxf4FBOhpNl2aAyctH7aqqG4MMEI6PNRAZcSR72qB2Sz8ASa8
         KN8w7ywmcJ6W+oi3px66s7NUFdzhZZJrvu8Olb7VSLjUi5JBh129FSckrBYtIOxvlZOZ
         3yPg==
X-Forwarded-Encrypted: i=1; AJvYcCUqDbloyL/WYhFF0R3Dh22TU2T7ERqOK5r3JM3qAkOgZsFHlMhWKnk2OHkB/GAqynAT8JVLlkAcrGc707T5O5bxKfWpxsAvT2s=
X-Gm-Message-State: AOJu0YzDCdmJj7enP62OAi3m4KqBYdwV29OwDrUcZhYi6kH/aStvkXeN
	wjTitkXak5NP4aPT7mUs08Dl2OIMdng5tJ+UKkd7rrPJhgeaD5dyZBhM1SO3fEdtjbhnyaz+dct
	Ua41KJAh2nq1NHfE5KupNwRkwulcEgqzYu+h0LQ==
X-Google-Smtp-Source: AGHT+IEDsnkIj6HCOWhXVjqLOlYJRYneScfnCc6Qn1cRIG8coLw2kTdZBaOy3HnsF7h3qlnpsiRbKmaYqRzZ9wPLo58=
X-Received: by 2002:a67:e359:0:b0:478:32e2:1833 with SMTP id
 s25-20020a67e359000000b0047832e21833mr11298728vsm.22.1712129900501; Wed, 03
 Apr 2024 00:38:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 3 Apr 2024 13:08:08 +0530
Message-ID: <CA+G9fYtj3aBdRreBmKZDQApEe2x8mugycPgN+_J5ebJzXDEq4g@mail.gmail.com>
Subject: kernel/sched/core.c:961:15: error: incompatible pointer to integer
 conversion passing 'typeof
To: open list <linux-kernel@vger.kernel.org>, 
	Linux Regressions <regressions@lists.linux.dev>, lkft-triage@lists.linaro.org, 
	clang-built-linux <llvm@lists.linux.dev>, Linux PM <linux-pm@vger.kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"

The riscv clang-17 defconfig build failed due to following warnings / errors
on the Linux next-20240402.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

riscv:
  build:
    * clang-17-lkftconfig - Failed
    * rv32-clang-17-defconfig - Failed
    * clang-17-tinyconfig - Failed
    * rv32-clang-17-tinyconfig - Failed
    * clang-17-defconfig - Failed
    * clang-17-allnoconfig - Failed
    * rv32-clang-17-allnoconfig - Failed

Build log:
-------
kernel/sched/core.c:961:15: error: incompatible pointer to integer
conversion passing 'typeof (*((__ai_ptr)))' (aka 'struct wake_q_node
*') to parameter of type 'uintptr_t' (aka 'unsigned long')
[-Wint-conversion]
  961 |         if (unlikely(cmpxchg_relaxed(&node->next, NULL, WAKE_Q_TAIL)))
      |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Steps to reproduce:
---------
# tuxmake --runtime podman --target-arch riscv --toolchain clang-17
--kconfig defconfig LLVM=1 LLVM_IAS=1

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240402/testrun/23264917/suite/build/test/clang-17-defconfig/details/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240402/testrun/23264917/suite/build/test/clang-17-defconfig/log

--
Linaro LKFT
https://lkft.linaro.org

