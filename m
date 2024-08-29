Return-Path: <linux-pm+bounces-13142-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEA5963EB1
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 10:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434161F21E71
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 08:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9047189F36;
	Thu, 29 Aug 2024 08:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYJwXoxr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997773D6A;
	Thu, 29 Aug 2024 08:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724920505; cv=none; b=I9rkY8dRbyw9+x4a5gnpi3vRK5Gc3+af6GFhs/U80sbG8gDmLVcRKyevRnDhyIOBAUqQuKetZsaMHpAEKVGgwy9EhLsUKbog5/LClTqXXErU0CqqtucmKHEbvtpBM80f9rTGLh/AyOr4suf8oVazw3pif0TQCgZYPWOHYBSsXi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724920505; c=relaxed/simple;
	bh=P0f8ntpzcKey1wli+oN8eCCGvNidzORW7xrQUlBhT3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bvTqYxVPfcX0kU/BYdCRbwXehNBliKTy7bXgd40Id19dU27+N78Gl7e3cyITm7hd1cYSvAwq5QFFeou6spRxRriTJ1nF4Y2EX8jKvdHY1h9C/MZ/KQ2ZNchA3yuzbxipWjniO9LcNiu/bdOTk1sov60WGi9U7NOeLClkhOuY8r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYJwXoxr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45145C4CEC7;
	Thu, 29 Aug 2024 08:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724920505;
	bh=P0f8ntpzcKey1wli+oN8eCCGvNidzORW7xrQUlBhT3E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mYJwXoxrqaUHZFFsNtMvTkCPvneG+WOO2MF97WITH5sfI+5l9M+JEMu+2XmuqAqsW
	 pXFlz3L0natvIdxu6Yc2+C6Qi2Ltxf1/w+2pFcnwn3625cBJLg08Z3FjfrcrT0TYxA
	 Y3lPBfnsTXOJ6Nyd4X82wvoZVBMVwju4VqUdlDczVTGkvQDDEQOCSBc9UkIZOdWz5k
	 QmzvT/FjPvr3V6GVovDdrIIqLm3La14vwsl5pCrpb7vy4Ua49hjC2+x5Uxx+r/m0OG
	 rYS4wY1ODCRow6lJUHU+2OTd3/d1z/MFh+7tSgYyW45YrVJ6RRsS4onddv61JbBRAf
	 3PjtitvyWzvBw==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5bef295a2b4so691750a12.0;
        Thu, 29 Aug 2024 01:35:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUr1dy0Ckxti/7b0b/SRUFR2eAyvZdST31A5T/ch0ORApZXmYwoShKelH4UH33Ap8WoojSTybuCYIU=@vger.kernel.org, AJvYcCVXLuWuD1fJi/BFzwv/YOnzhnfNIZFJjwcL+RN9CtAA47JhnBEVrN/fAcEfF70S6AHC8H1fWZGWN3ZJ1nE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6N18cqW4/LfzjR4g6mgtrHZrKjD15VPwa/83XfvLbj/mCiGwn
	ouknGvqB+ATHzEyH/i7x8w6fTa7SPn7yxEyK4M8DallLiNrPvHQBiZcbKiA8ZnqGYrxw4tL18Cq
	anOsvxXoYLbACD4/942aEABVF4uM=
X-Google-Smtp-Source: AGHT+IF/e3S0CMGyfyhfJSpUWyWUcXjSg14YL8RAMcl4MQ9juD6gouEMbZsgTyeeytlDKzqdQRjDuFUMsdjKimhDofc=
X-Received: by 2002:a05:6402:4314:b0:5c2:1132:7ce7 with SMTP id
 4fb4d7f45d1cf-5c220101f2emr2238125a12.7.1724920503791; Thu, 29 Aug 2024
 01:35:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828062459.1853837-1-chenhuacai@loongson.cn>
 <affff6410e681152c3fdcf3512df76d734f29aeb.camel@xry111.site>
 <CAAhV-H6YLg1ipUf-45-0zF6HRcCfkVikwQM5cAD7_VSYyAsfoQ@mail.gmail.com> <baba6eec7a1f66dc8b82d5e16612d0703dd33c81.camel@xry111.site>
In-Reply-To: <baba6eec7a1f66dc8b82d5e16612d0703dd33c81.camel@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 29 Aug 2024 16:34:49 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7RF8yXHacfq0nj-QTNXmZrRKG4xhHav66ZPg0SdGT64w@mail.gmail.com>
Message-ID: <CAAhV-H7RF8yXHacfq0nj-QTNXmZrRKG4xhHav66ZPg0SdGT64w@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: loongson3: Use raw_smp_processor_id() in do_service_request()
To: Xi Ruoyao <xry111@xry111.site>
Cc: Huacai Chen <chenhuacai@loongson.cn>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, loongarch@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Binbin Zhou <zhoubinbin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 3:33=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> On Wed, 2024-08-28 at 21:55 +0800, Huacai Chen wrote:
> > > Do I need to modify some firmware setting to make it work?
> > You should update your firmware.
>
> I've already updated to UDK2018-3A6000-
> 7A2000_EVB_V4.0.05756_prestable2405_0523dbg.fd on a XA61200 before
> trying CPUFreq.
>
> And I also tried enabling DVFS in the firmware setting, and disabling
> the overclocking.  Both didn't work.
Hmm, current firmware with DVFS can only cooperate with the old
CPUFreq driver in old-world kernels. New firmware which can cooperate
with the upstream CPUFreq driver hasn't been released yet.

Huacai

>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University

