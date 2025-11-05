Return-Path: <linux-pm+bounces-37481-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C656C37F2E
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 22:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A78004F863A
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 21:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A5F34D923;
	Wed,  5 Nov 2025 21:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfNpKQuK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0279190664
	for <linux-pm@vger.kernel.org>; Wed,  5 Nov 2025 21:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762377203; cv=none; b=Af3dke2GUNun1ETKcyu20fC3lTB/EdSSjzTN5jNgtmQGLLqxtRxYxtsx395cpunXLtwJhVvtGowHyid+TYMk79frJR21sBkhWYBRe6zlTqJXJcMEGvMJn9ILKP2ha5j2bGRfwK+kfVRPA4Lig2IplEgZmw7M5OIuvPFLgDYcvkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762377203; c=relaxed/simple;
	bh=TtPX5wAsf31XsioAbGBoBPNIeRFsDJtRy/KczWb+LAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M5L9HxcttXWgkrqbQMhM3N0l99fLABFhDQSUMbwzvC/iVKizJPivsxhDjGzbpR5vP6AzMZg7kxhxAaNNK/9EVPt4a2IkBqH0rw+r1GVfOzgvUqhX5NSJfboH6xOnjSIrWdUa+P4GSNrV9cXQRnXdGENR707G90o56wA9VQMgKOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfNpKQuK; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2958db8ae4fso2638505ad.2
        for <linux-pm@vger.kernel.org>; Wed, 05 Nov 2025 13:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762377201; x=1762982001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYl4uAcPw2YN0ysy9XChF1hzlRCusGR8JO4Ns1lam1E=;
        b=YfNpKQuKJ/mEIJ7k9RyfYts2N60S1QVyJxwoOXNvlWVxiFprvAr1nuLEZof7rcfcry
         vj1eRFmcN72OMYiHk47+4r7zlmTkGXLhjNruD8o2nmmgZWs+6rUlZcV0tuZg2+sCbWIw
         Ft1BecP9VVJIATk2OW+jfWKu2IEYVoZdcJvVIptAPU0Oo71JZwZj4wA9cX/kIbZBkBab
         8Vc/j2uPgZWLHDDx+yCQMllejWcsi7iOJHYfnh5IgTBB+8fAQuX7ZnFIGDv5iMAHAoOi
         9ClJLvzoSSdMYb6j6O1YbeB4DEMvHGRfD7vORjhk1GI/joX31Wq2xz/kxUVbN9DkzBmr
         k7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762377201; x=1762982001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYl4uAcPw2YN0ysy9XChF1hzlRCusGR8JO4Ns1lam1E=;
        b=Hpfnned5oevs05utmgKfOI1LiEXTUL+eEiyfNgIP9rzKVnxJweFP9a869tSksqJp90
         UPj1r2d94Y1YrcnBmMAQvbOSet6htB2/9KqANJiSZyEj5MrKVQgodwvDbBN6hBmfwqNB
         Uedn8aGVysk4YrNLGPk/8wozh/75kFM/mpxavjx+AbefoAiIB7YgwAYwkZda+G+jTdAB
         8pAiEflG+3HGtUcK/XywlIdljrwnVh0qL+Ryq773e+VVpVIlaEsd+BIPMpjYst36BksE
         fvZ3LbEp+oMc0A/D9Mt9j0fKPCpS6eoMdIIIH9QomdKim/XMFQTQhCpDdd4Rxz1ABi00
         +CJw==
X-Forwarded-Encrypted: i=1; AJvYcCX0ByCgV1e+3vmAS4t/5OKzBc8gMCprpZjZ+cz318FEHX44NIiKlY+y1QbXKCwAZPkRU792HPUWcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXMjcE+oan564kGt5VBHWoAmILA9o+wKJMaFUz4NeeSYJ2wFKV
	NDvn7RntB45T+CmHrMt8in7IfHjzRTFPUbM1CXMWWMAYZgbpGZCiXXghRkzyKCzKA5vksPpS/CA
	1Y9Z7d3+htKzPmksn2KAEawqE7UzX7Ek=
X-Gm-Gg: ASbGncthPl/x3/J2776y/ZeQbUl9JWAzddShTUNKMQZa8dLkjSnI0eoji8v5v5Uncq0
	vbkgoKWk+U772bPl7zn/Z7RykXyXILhkw9lGPWZJebVbJmgD1Yy+MPntjpGhCdeHtvG2gkoSL/w
	3JgkKMcUvVuVfbTnDuSC3pG5PyDe8zl5XSuilocbnNKouF2xG5wA17XkX4XtvPzTsEWK2a1DcQc
	fMRtPj12+RdOaMtq4xK9UtB3jRu3Wh3zYdHSGycbw/ocErn7j7OmhuEoL5Ma5k5sZ5MwzhgnoDW
	ZGAxtvaaCVX1fMlQGJzBGBYU718ADDj3Iok=
X-Google-Smtp-Source: AGHT+IHJuaCbV8Dvr3w5WGu51Kk+xXfCjwSmuvKRdYVaKJf7OUcW5sfriYB+7HI9rK4/5a+tYVgAbKZ5vZmFdHN1rt8=
X-Received: by 2002:a17:902:e889:b0:295:5132:1a99 with SMTP id
 d9443c01a7336-2962adcfdd4mr62180385ad.44.1762377200682; Wed, 05 Nov 2025
 13:13:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105143851.4251-1-gautham.shenoy@amd.com>
In-Reply-To: <20251105143851.4251-1-gautham.shenoy@amd.com>
From: Chris H <chris.harris79@gmail.com>
Date: Wed, 5 Nov 2025 13:13:08 -0800
X-Gm-Features: AWmQ_bk9z1xb3CgvzyDGOVjF_ZRV-xAXTvxsOcf3VIYYEJ6ctGNF7I9zc6gJMjo
Message-ID: <CAM+eXpe1j5=PW9AuJCJQWat=ivwViU45y0ortdiav-kX=2Hs+g@mail.gmail.com>
Subject: Re: [PATCH 0/4] ACPI: CPPC: Fixes to limit actions to online CPUs
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>, Yunhui Cui <cuiyunhui@bytedance.com>, 
	Jeremy Linton <jeremy.linton@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Ionela Voinescu <ionela.voinescu@arm.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Confirming: I've tested the first two patches in the series on kernel
v6.17.  The patches successfully resolve the issue described, allowing
one to boot with amd-pstate + nosmt=3Dforce.  In other words: receive
the expected amd-pstate scaling driver when SMT logical cores are
disabled.

ACPI: CPPC: Detect preferred core availability on online CPUs
ACPI: CPPC: Check _CPC validity for only the online CPUs

Thank you Mario and Gautham for addressing this so quickly.

Chris Harris

On Wed, Nov 5, 2025 at 6:39=E2=80=AFAM Gautham R. Shenoy <gautham.shenoy@am=
d.com> wrote:
>
> Hello,
>
> Christopher Harris reported a regression between v6.10 to v6.11 that
> the amd-pstate driver failed to load even when the commandline had
> "amd_pstate=3Dpassive"
> (https://lore.kernel.org/lkml/CAM+eXpdDT7KjLV0AxEwOLkSJ2QtrsvGvjA2cCHvt1d=
0k2_C4Cw@mail.gmail.com/)
>
> On debugging the issue it was observed that when the commandline
> contains "nosmt=3Dforce", the CPPC code fails when performing certain
> checks such as checking for the presence of preferred cores and
> validity of the _CPC object since it iterates through all "present"
> CPUs while the object state was populated only for "online" CPUs.
>
> This patchset contains fixes to address this issue.
>
> The first two patches in the series address the issue reported by
> Chris.
>
> Patches 3 and 4 harden the code in a couple of more functions which
> iterated through the present CPUs when it is more apt to restrict the
> operations to online CPUs
>
>
>
> Gautham R. Shenoy (4):
>   ACPI: CPPC: Detect preferred core availability on online CPUs
>   ACPI: CPPC: Check _CPC validity for only the online CPUs
>   ACPI: CPPC: Perform fast check switch only for online CPUs
>   ACPI: CPPC: Limit perf ctrs in PCC check only to online CPUs
>
>  arch/x86/kernel/acpi/cppc.c | 2 +-
>  drivers/acpi/cppc_acpi.c    | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> --
> 2.34.1
>

