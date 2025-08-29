Return-Path: <linux-pm+bounces-33429-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 054B6B3C2DA
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 21:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 427E77B1579
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 19:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF542376EB;
	Fri, 29 Aug 2025 19:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snsSDX5y"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9534321CC68;
	Fri, 29 Aug 2025 19:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756494572; cv=none; b=GWQWQRnegMbdfdK3KBZd5HN2pCEA9h98GTpRN5KZgCCZQ/FbLHkQRz+MilmyvX6rfKNcEukeOsu9296+A+nU5L+a4pzDy9AOhZdP8DCfRjS6ikNTmVf7wuX03qS6jtHal/hnJbtBR6BjrW3aE11iucaJFrxJeKyAsqtH+REBwwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756494572; c=relaxed/simple;
	bh=Zb9+/8M8zopR3BcnqGqQdbrwoGvHlFLljcApoCcw2Oo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=caTOWzjwFTTdOXDjQcmEWg+3/k5ZRDj5VSA+1DGMvPsEaDattW8yvq9TR2uoICOfv1sRUl/jrXPmL1sQVknPS5W2Rm7I9yx/chA3C6GUcAln2KZlnxRLHJeY9ImQ9ltJ1vETU7hothDQxgov97q/rkf2j3w2MGBEzsnLa61wmZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snsSDX5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293A4C4CEF4;
	Fri, 29 Aug 2025 19:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756494572;
	bh=Zb9+/8M8zopR3BcnqGqQdbrwoGvHlFLljcApoCcw2Oo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=snsSDX5yZeNPYdTyvIwZI8kK2KB8dF4SVoAcfnwGQ9ts4hYPAJ4aNMyqP+nXyrbeJ
	 viKVmCbSJJmzxri+YXnql1LzS/mZ1i9w8pJi7rOdb93sf5RVEs8+J5E9SLn9rzAL9g
	 4Eg2bFlLepqzRkS0TcyldUr4FQSQnGa5+42GCY/SfyRW3yMcX3Bo40E09sL5+uDcLO
	 JblYd5camA0dI1tdDRy2rwzoYnTfZNbwx52wPEwxkNcPQkVU/dEH4R+hEsNe7VZEXN
	 CRPRdXhq+y0xa5daTLxroxtYR1lNO/12iEjYzYtuznQl6w9ryp+b0hqh4PtPul5e4u
	 a2gmKm9gc9Tdg==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7455333b042so1231508a34.2;
        Fri, 29 Aug 2025 12:09:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVLQiDkyjcCjW+keag6h7Pds5fMwwgjIjUFhNMQNF+hOcVbAfMFkH845LSTFWd5JxneDOOPEwwflV2K15o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrUKUHNQwn8aYr+8U16Cmf8DiT8AUIOA3uhahAT4+qwmYpRrIE
	0o8XIL+Mc3i8i4kYFOyEM3iKb1gNLjKdPc7GFMyhyqtKn64JY9JJb/UHJDI3lLX2S57fbywp5Pc
	jRNMGIzwzAByUkbt1l0DSlGr2YE2mY8Q=
X-Google-Smtp-Source: AGHT+IGrVcxTx85OhPpR76OaElmEJ7YhImqLU2QpqRsw2Mm+Vd1MGw4jolHOUIS+DudL+pJPLiMcfLb5cO/oQh9UBas=
X-Received: by 2002:a05:6830:6084:b0:742:fd81:30aa with SMTP id
 46e09a7af769-745008fd4f6mr16089796a34.2.1756494571505; Fri, 29 Aug 2025
 12:09:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12749467.O9o76ZdvQC@rafael.j.wysocki> <2025082851-progress-unsliced-ade4@gregkh>
 <CAJZ5v0hn9NXvHPy6zV4R4y0AHtN2BfN41wjd5s7dos0wx6ih0Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0hn9NXvHPy6zV4R4y0AHtN2BfN41wjd5s7dos0wx6ih0Q@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 29 Aug 2025 21:09:20 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gj33W-2FOswYoBLQQyTj0wr_EuMUdLiL_tdt4t=ss-jg@mail.gmail.com>
X-Gm-Features: Ac12FXyVvEA25CZPhjEKXIYKonnQYlA3u5Y7oM0SSAVMXVpOEJro_CQ-vi9yNyA
Message-ID: <CAJZ5v0gj33W-2FOswYoBLQQyTj0wr_EuMUdLiL_tdt4t=ss-jg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] driver core/PM: Two updates related to power.no_pm
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 1:20=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Aug 28, 2025 at 1:07=E2=80=AFPM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Aug 28, 2025 at 12:55:50PM +0200, Rafael J. Wysocki wrote:
> > > Hi All,
> > >
> > > Applying this series will cause power.no_pm to be set for faux device=
s (so they
> > > don't get processed unnecessarily during system-wide suspend/resume t=
ransitions)
> > > and power.no_callbacks to be set along with power.no_pm (for consiste=
ncy).
> >
> > Oh, nice!  I forgot about that entirely.  Should these be backported to
> > older kernels as well?

So do you want me to resend these patches with suitable Cc: stable tags?

Alternatively, I can just apply them with the tags and route them
through my tree, whatever you prefer.

