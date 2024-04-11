Return-Path: <linux-pm+bounces-6288-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC738A1F48
	for <lists+linux-pm@lfdr.de>; Thu, 11 Apr 2024 21:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342CF1F284A1
	for <lists+linux-pm@lfdr.de>; Thu, 11 Apr 2024 19:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3FC205E1A;
	Thu, 11 Apr 2024 19:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PKjQqiMy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C72C1802B
	for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2024 19:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712862891; cv=none; b=qbmGhzgZXclYcAcc45FGszchuLYyW74j6oH/YQxgZJJCPGEUd9njv3HjR49wP97kk5vPdN2wq3mDVPmMPuEfKEaTksC/PHfed6I1Gf3g9jp0mXOpVbgB/Mo/Sco2aN2vzK/vzQeE/YyD0cQooGK2q/JvdR3vWkk4+/zVXl5INEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712862891; c=relaxed/simple;
	bh=H8ys9L1hv7S7Nx/j9cn+rySGJ/YQIhVVIhaZ1i15xeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jmzz1OSedsAUuURBJSSiGm+gGfciboCPEiXuUnX5f9Ep+E7AywA9WUBfnatjWfOW3qWhM334R+6oornnDI+e8SorQVkvsGwYx1uH4YS/MMZb5SkfzD+ZT6jJ92Bhn5P9VjQ/pwG+SUNdg39hgL8oVNE8+Hke5kfvPv7+v7x4oKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PKjQqiMy; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-516b6e75dc3so226984e87.3
        for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2024 12:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712862888; x=1713467688; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=24c5MYVKM5W9suD5aHIvWrEfS4imCoj9FJNn9YD5CY4=;
        b=PKjQqiMyZwpR2Uz7GycDFY43Zud9snhUbFkDnWSZwohnAdGFw6RbjSSseTjpiWKMPT
         4mJg3mWIHFLr8aR6f4M2+N20jzRrS76XhfVXHbkA/sSpjCnvjbS2bEAHavLoxKD+5BEE
         F+BkLf9dsVLkBlG+qj9185+XtP1vww40iX2fI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712862888; x=1713467688;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=24c5MYVKM5W9suD5aHIvWrEfS4imCoj9FJNn9YD5CY4=;
        b=r6p7mTA3Ammm5EzZdsg6lcUHhaudFLghUsWPeBGjZzUaEz9siD380RESn6Y1h6WWGf
         n+psYQKeFQCDm3XKgLKDhMDHBgy+D687g0QhpRqN8f8OFWcOCJtdOsxv+zW0VF6ZMV9j
         O5Fr4eH84uOo1GpdaK40yhLTAA33Ba82oWOf+6GqlfIeVMPo1gFPzesK0cXJwq8uHCxH
         2ap2sp/IUSmYD15+6Q/F819CSgNAarvTGax403W6UDvrOzxX7XbtfSE1PM9dLeLQJrwr
         /Y2m2oGv3vshd6gWsTQp6M2Eby3iQPd+IC600Ih4Kf7Cs8Sp4fAbY1aON2yC2b/GpVbA
         o96g==
X-Gm-Message-State: AOJu0YyRGC2Wt2GUcuFMFMVx06MCg9IrIxFA+hYRryQNsgoEdRrAVoOq
	enEA9Ych+pwVyBVWI6j2rCH5Gl958fBZxUo3QVOvzRMgpzSpSXgNyWTIuNodvFZsfilolcmDUfp
	deZePuQ==
X-Google-Smtp-Source: AGHT+IGbOLZT7cpwa13g8EfeFRST9kyMgC3ib+HKxwfiGotEDfcNTN1CI9ZMas3EM3uUbD3NRXw8Gg==
X-Received: by 2002:a19:7604:0:b0:515:b0ef:2ae3 with SMTP id c4-20020a197604000000b00515b0ef2ae3mr357428lff.39.1712862887978;
        Thu, 11 Apr 2024 12:14:47 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id m19-20020a17090679d300b00a4e03c28fd5sm1017980ejo.43.2024.04.11.12.14.47
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 12:14:47 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-343f62d8124so74335f8f.2
        for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2024 12:14:47 -0700 (PDT)
X-Received: by 2002:a5d:570b:0:b0:346:44:3910 with SMTP id a11-20020a5d570b000000b0034600443910mr307796wrv.49.1712862887128;
 Thu, 11 Apr 2024 12:14:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJvTdKmK_U7nChpm=MzaDyw3T9V6hSua-6C89WCjo828vxm+yw@mail.gmail.com>
 <CAHk-=wgaTzpJssX2z7OiQOLL0BZzHGAfJn0MYPhuN9oU0R2f-Q@mail.gmail.com> <CAJvTdK=BO2YtUCrNzjMR8EydaDzaPasfi9m3_4UreC2J1MYjTg@mail.gmail.com>
In-Reply-To: <CAJvTdK=BO2YtUCrNzjMR8EydaDzaPasfi9m3_4UreC2J1MYjTg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Apr 2024 12:14:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgNZV3pwPMjOr1_NGUt3L1rK+38xtSp78w02X6qYwqhJA@mail.gmail.com>
Message-ID: <CAHk-=wgNZV3pwPMjOr1_NGUt3L1rK+38xtSp78w02X6qYwqhJA@mail.gmail.com>
Subject: Re: [GIT PULL] turbostat 2024.04.10
To: Len Brown <lenb@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Apr 2024 at 11:20, Len Brown <lenb@kernel.org> wrote:
>
> ISTR that once upon a time at the kernel summit you expressed a
> preference that things like utilities (which sometimes depend on merge
> window changes) come in after rc1 is declared to basically stay out of
> the way.

That may have been true at some point, but probably long ago - the
merge windows have been so reliable that it's just not an issue any
more.

So I'd rather see people hold to the normal release cycle, and aim to
have the rc releases for fixes or major problems.

We also used to allow entirely new drivers etc outside the release
cycle as a "this cannot regress" exception to the normal rules, but
that has also been largely abandoned as the release cycle is just
short enough that it makes no sense.

So the "new hardware support" rule has basically been watered down
over the years, and has become a "new hardware IDs are fine" kind of
rule, where just adding basically just a PCI ID or OF matching entry
or similar is still fine, but no more "whole new drivers".

                  Linus

