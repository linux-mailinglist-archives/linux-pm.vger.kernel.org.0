Return-Path: <linux-pm+bounces-35071-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90678B8AAF7
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 19:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A5F5170D8A
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 17:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E7E31E8AF;
	Fri, 19 Sep 2025 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpKSAip9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4036B31A804
	for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758301462; cv=none; b=ro4kQz3ltQPzZN1N9Ii9eJneGOsdOUPtf9e/rPxNlXMbcPQozawr6nuD1I+zTtD+KU7yPsfRIQ1dK0Dl9763iFh7zVOQBNOI2Xove3Gtf9rXyLi2IbGo68PGYeWnnoPmUJnrLYilcFn9xoVrvqELxrZf6EYdPFbJZt7CCpzHTHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758301462; c=relaxed/simple;
	bh=5CYsOg5jJr8hUkgsKlQmf7YFSaMYtgi4KA1qSuVJ0ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O1/5VHqyDZVkQ7LStmJYjVoHTxyVniekxnakTbAwUoBoGoiLe0EnWEdc4C1TyY6sV+vBjrHnHXXAZO5ukSSUQbQHkzxzm58teXsq1ZWh90bK1FL8pg/24JIIJRZmCrprO88sbYombgDuxkO9jnsMCVGybmrfrfYOPkgwls73JdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpKSAip9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B0DC4AF0B
	for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 17:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758301462;
	bh=5CYsOg5jJr8hUkgsKlQmf7YFSaMYtgi4KA1qSuVJ0ns=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VpKSAip9WOBcdnECgAc+lQtBy9gF3+soWTxgvZ12sIqlrfaqNlDcJh9NtFDc8fizx
	 K4CV6lGW55IPBVVPRXLWPyNCICyh89HxsRsJMsQ8EkYc5xRkTNMYBwHvQLIe27HjHO
	 fq5CGpl5LbcxtICk6jjq3rl8hRiT6DXWyKFJjdDpVqiIL7Zf+LYMdINQZbymqvUJhO
	 ksj8WL1wLZvvNUQJicqRigsMgubDofNZsl2XK4zTiu37wSRYS9xQmYavt4kkXrC/bT
	 I2anV1GJkjuaKYeKFuDBdT8Qb6ec2BmJuXO7neTUtfyvx7+m4+7/GvVDqNKvsuIZWo
	 ++4M8mQCNit+A==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-758a28587e5so2758523a34.1
        for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 10:04:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXzpaL8gw9Gx7J9GBfOf8898KkFdvn3dW6H3xhuItlfxEise51vcbAmJMdVQUhrK9f7szf3vN7Pgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwE8yadd/2SX8/lgWzYrctAhvjGolFp4lIfTRoTEIyviRs/6nft
	TwDMJxbrv2+UcD5nPqev164QZbj76YbWmD3ooaQopIvYXttRwNTeImx7YUKWu2Tgd1EM82C9D3E
	2n27DxcFaLTWhpuQdWRdG4EhE1Fj6Umk=
X-Google-Smtp-Source: AGHT+IGGi8IjbMXxwPN6Xb52b4tEX1mdDHXrNYE7hpOJQ3vprC68PbB3fo0xufG4TCA3g48eLNmGSvgnmI/hkbbcRFQ=
X-Received: by 2002:a05:6808:bcd:b0:438:2907:2eb2 with SMTP id
 5614622812f47-43d6c24899emr1965364b6e.27.1758301461293; Fri, 19 Sep 2025
 10:04:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919163147.4743-1-tiwai@suse.de> <20250919163147.4743-2-tiwai@suse.de>
In-Reply-To: <20250919163147.4743-2-tiwai@suse.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 19 Sep 2025 19:04:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h_qFs6D6pMfZT-NxgyDOOYYUzN=Ketw69C4BqsAG8_JQ@mail.gmail.com>
X-Gm-Features: AS18NWDj9nosWVkd3nd92OmaMdphOkBExCsiZSjzHaRETJjzO1RShkRvuC81Smg
Message-ID: <CAJZ5v0h_qFs6D6pMfZT-NxgyDOOYYUzN=Ketw69C4BqsAG8_JQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] PM: runtime: Define class helpers for automatic PM
 runtime cleanup
To: Takashi Iwai <tiwai@suse.de>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 6:32=E2=80=AFPM Takashi Iwai <tiwai@suse.de> wrote:
>
> From: "Rafael J. Wysocki" <rafael@kernel.org>
>
> This patch adds two CLASS macros for the easier use of the
> auto-cleanup feature to manage the runtime PM get/put pairs.
> With the CLASS macro, pm_runtime_put() (or *_autosuspend) is called
> automatically at its scope exit, so you can remove the explicit
> pm_runtime_put() call.

The part of the changelog below is actually really nice.

> Simply put, a code like below
>
>         ret =3D pm_runtime_resume_and_get(dev);
>         if (ret < 0)
>                 return ret;
>         .....
>         pm_runtime_put(dev);
>         return 0;
>
> can be simplified with CLASS() like:
>
>         CLASS(pm_runtime_resume_and_get, pm)(dev);
>         if (IS_ERR(pm))
>                 return PTR_ERR(pm);
>         .....
>         return 0;
>
> (see pm_runtime_put() call is gone).
>
> When the original code calls pm_runtime_put_autosuspend(), use
> CLASS(pm_runtime_resume_and_get_auto) variant, instead.
> e.g. a code like:
>
>         ret =3D pm_runtime_resume_and_get(dev);
>         if (ret < 0)
>                 return ret;
>         .....
>         pm_runtime_put_autosuspend(dev);
>         return 0;
>
> will be like:
>
>         CLASS(pm_runtime_resume_and_get_auto, pm)(dev);
>         if (IS_ERR(pm))
>                 return PTR_ERR(pm);
>         .....
>         return 0;
>
> Note that there is no CLASS macro defined for pm_runtime_get_sync().
> With the auto-cleanup, we can unify both usages.
> You can use CLASS(pm_runtime_resume_and_get) but simply skip the error
> check; so a code like below:
>
>         pm_runtime_get_sync(dev);
>         .....
>         pm_runtime_put(dev);
>         return 0;
>
> will become like:
>
>         CLASS(pm_runtime_resume_and_get, pm)(dev);
>         .....
>         return 0;
>
> Link: https://lore.kernel.org/878qimv24u.wl-tiwai@suse.de
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

So I'm going to include it into the first patch and add a
Co-developed-by: tag for you to it.

I'll send a v2, but I'll wait some time in case someone else has any
comments.  Probably tomorrow.

