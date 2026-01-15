Return-Path: <linux-pm+bounces-40917-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF78FD23FAE
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 11:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCB0E3010AA5
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 10:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5278E36BCFC;
	Thu, 15 Jan 2026 10:41:54 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46BE36BCD8
	for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 10:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768473714; cv=none; b=djqWvrXyy9d1kovf/+HqJ+wkuV8L4O3mrblN/1HUtPlAKXhVN5nVZ3JfvqwgXIyot5JlSO4L23j/5WmC97phqqNF45JYVcqVGMmBZBNXNpmvVE2dpjLlYiTAON1thOWc9Uol/58GY5Z2zv4V93gPjltZFTnsIQl9PTxG+ReOLcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768473714; c=relaxed/simple;
	bh=Ic+BG6PwFENklasmULObFPSGqA588zsHCZepmm6A/P4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/5lL0HhSM6ELdIsvJiUqs7Kz+CZjLbBPxEkOcsh5rjlUqaNj8UvR1JePQY9WFjjK6gMpzPQ9jZq0UVZHPBccKqI42xDvVyTVKllR5jpdV6WReYi/jttwYfO3lX3Mmxsre6Hoh6QALzHrz5bJ7LCyrjnZXuRV9phIAfgi3iVNIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b31a665ba5so98241585a.2
        for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 02:41:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768473712; x=1769078512;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1p2XoRu+N3MN1gMwzSh5wyB5gfaCBHLjeZ1kZTlyHmo=;
        b=X+IBVxvf+N3EU3dmY9xNyC5/bi3oWXPWE03ITLn6gb+dDylbmLOaf+Al8k1Pccr5mk
         PFuw7Xa+kJmBimv9hZymjEgNSySn0vBMHdCndfor/P9ythh8ytmTI3+CEZZI4fyUEjNx
         s7XQcrLUj+QNjLY25iBivwtwPDE1MWWFCSYORLTw9kqNBJ6AGy0aIdQsWidkvCGqMb4U
         8vPPiEoMbYbTSoS54K4quarFhgnasaCNnuLmhxLgppfPi0POzyvs1kN6IP4bsEBDFIaw
         +M5COglrbHsKk6vloK2BMm0xRYdsQjqJEDPV/KfpiK0Cn4HNVaYaRn97Dfc/LiqoAz7j
         Iacg==
X-Forwarded-Encrypted: i=1; AJvYcCUHgaAGsV0bZ3QCJIqyFyW9HfdvU2JWnBxLqtX+wCTOtQW35WQmWdu0TJ8AtUIt8pWOZSxVlt3ktA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcgRgpP/OVMV+8rDNbt8vrZTttNPTiuJbMys/lUhqqP3p/HODR
	iF2RvMGfFhcTDbcFO0OxVCF50u3PLE7wUr1xE9+q/pAR+3kLt3Imnf6Ys6H7N6R9Q/U=
X-Gm-Gg: AY/fxX4JvpaF7ML6YChtPpjXRtA7kG3M1+lsiuIfjXMzboycLKYaOYP51xS2UVxyn/G
	H6ubbWTkVDjy/EDJo+qKf1NYiJY4SVXKf/CEQDIidYINd0LEKRqmGbTzKbupQddtj+09T96zdCz
	+icNP24m+89eFosvsBjwkJmmi0KK6UeAvKxieQLmGPOITIxZkBKfkUeHjAQOCs5w+PTDMcdG29V
	2z4PHvucFnr8aE1py56+sAn9+XmrPS/CW1eEM7D7EP83n52yo3lsyKL6xa+T5AcRnrKewz0nTUg
	FeBeryDyDky9pVgVITcRnFl2Xsaf6FFd2Sr1VPAwTWfI6eQmDQ/KTVWwiOd7+5bTYU4hVvh7viK
	7bVhoOelu9DhPSvQJjjvvRg0hOR63Gctf3U79WhOxH+g8JZohAr58PPxMX0ZIRKn/vLjetDeCdR
	4iHGQlOIhgSeB5VnBJH+Oj0/IrGjN1wI09kdnCQtTXRmfkFRTceq3VsSQRspU=
X-Received: by 2002:a05:6122:2887:b0:559:7acd:1d3a with SMTP id 71dfb90a1353d-563a0924a58mr2005488e0c.2.1768467643857;
        Thu, 15 Jan 2026 01:00:43 -0800 (PST)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5636dc36a20sm16846242e0c.13.2026.01.15.01.00.43
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 01:00:43 -0800 (PST)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-94130b88642so454922241.3
        for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 01:00:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUsbXLamIfocgXn0LTyKSWPn6RRfUwzE1z+FsEZ71zIMqtAeeU0ghv/6PJDoGR0MbydiUeVboXhCQ==@vger.kernel.org
X-Received: by 2002:a05:6102:4b83:b0:5f1:4fb8:6b92 with SMTP id
 ada2fe7eead31-5f17f58c046mr2296699137.22.1768467196661; Thu, 15 Jan 2026
 00:53:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230080115.2120612-1-zhenglifeng1@huawei.com>
 <20251230080115.2120612-4-zhenglifeng1@huawei.com> <CAMuHMdVeHk-Enc-M9ztwSdeAtE8YPKtJwq+273bGPEFOEsu=Rw@mail.gmail.com>
 <aWZriVlQZ5jRx2o4@arm.com> <CAMuHMdVgbQnaCQ8U8FK6J1vJLsqc0_MC7zSTX2B=rsuF2kpEKg@mail.gmail.com>
 <41b7398c-b1a4-4b87-b6f9-07eacf4f4752@huawei.com> <CAMuHMdUuTrF=eN5tMsjmOfWuuT9r7aCOTS7=YP6+KrSdNrhEpw@mail.gmail.com>
In-Reply-To: <CAMuHMdUuTrF=eN5tMsjmOfWuuT9r7aCOTS7=YP6+KrSdNrhEpw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Jan 2026 09:53:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVxZ5bbkDqib7jyG50YEnKX=KuHs-svMX7-o2SPz8WF6g@mail.gmail.com>
X-Gm-Features: AZwV_QiQCjp_xx6Rd7qqH4UVq_yR09vqEc-Jt_NOVYext6gLSj5FqsRdjfyRE28
Message-ID: <CAMuHMdVxZ5bbkDqib7jyG50YEnKX=KuHs-svMX7-o2SPz8WF6g@mail.gmail.com>
Subject: Re: [REPOST PATCH v6 3/3] arm64: topology: Handle AMU FIE setup on
 CPU hotplug
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: Beata Michalska <beata.michalska@arm.com>, catalin.marinas@arm.com, will@kernel.org, 
	rafael@kernel.org, viresh.kumar@linaro.org, sudeep.holla@arm.com, 
	gregkh@linuxfoundation.org, dakr@kernel.org, ionela.voinescu@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linuxarm@huawei.com, jonathan.cameron@huawei.com, vincent.guittot@linaro.org, 
	zhanjie9@hisilicon.com, lihuisong@huawei.com, yubowen8@huawei.com, 
	zhangpengjie2@huawei.com, wangzhi12@huawei.com, linhongye@h-partners.com, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Jan 2026 at 09:37, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, 15 Jan 2026 at 03:25, zhenglifeng (A) <zhenglifeng1@huawei.com> wrote:
> > On 2026/1/14 21:54, Geert Uytterhoeven wrote:
> > > The confusing part is in the (absence of) logging.
> > > If AMU is not supported, freq_counters_valid() uses:
> > >
> > >      pr_debug("CPU%d: counters are not supported.\n", cpu);
> > >
> > > which is typically not printed, unless DEBUG is enabled.
> > >
> > > If freq_counters_valid() failed, the new cpuhp_topology_online() uses:
> > >
> > >     pr_warn("CPU[%u] doesn't support AMU counters\n", cpu);
> > >
> > > which is always printed.
> > >
> > > Given freq_counters_valid() already prints a (debug) message, I think
> > > the pr_warn() should just be removed.  Do you agree, or is there still
> > > another incorrect check that should prevent getting this far?
> >
> > I'm OK with removing it.
>
> OK, I will send a patch.

https://lore.kernel.org/a8dbf49bfa44a6809fa4f34b918516847dc14460.1768466986.git.geert+renesas@glider.be/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

