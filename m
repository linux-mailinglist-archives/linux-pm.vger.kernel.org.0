Return-Path: <linux-pm+bounces-40536-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E16D097B6
	for <lists+linux-pm@lfdr.de>; Fri, 09 Jan 2026 13:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 16F4F306228F
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jan 2026 12:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D6F35A92D;
	Fri,  9 Jan 2026 12:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKppacJ3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EAE359713
	for <linux-pm@vger.kernel.org>; Fri,  9 Jan 2026 12:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767960918; cv=none; b=cwrvxkDY2H6tdsNSP9tG/Q33Yp7edtE941a9M7HYJV2RM43d+ovj6G+TfELJr+mdLM/+zLR/aRzBrchG/Q7YxERGmbm2ORY+sXUbAiwTUtUH8mWerN4Z+2miJdn8crwg6tPhlOG3Ue2h78ahN1IihC9LSY0D2WCccM57ZoJyGrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767960918; c=relaxed/simple;
	bh=Q+MvHTPWuJLz+VvQWoGrQuTCvgpFbzUt9tL0+8XM1zk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PL5EElyx/eq/Bn9XFd+tu4PSiDDsDF0q7MHGH00SWALXvkk5kSu3mv4EUTadmQ0ypmosBDcu+dGrOVvNgkHypW8aSxKV60kwnWE9DJGGgJ9jR497UPOCk3UplWthr7ljRh/wsWaraR2V8Qloz6P8Ts7DfOZvlcQxmFUEy7aELYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKppacJ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A61EC4CEF1
	for <linux-pm@vger.kernel.org>; Fri,  9 Jan 2026 12:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767960918;
	bh=Q+MvHTPWuJLz+VvQWoGrQuTCvgpFbzUt9tL0+8XM1zk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cKppacJ3r9yywX2c/rEBZBCX5qHhCtSBCyswDY0Gr2ORStDHDxBGFYdXvK1VM/2U/
	 DL1dmiTWc8hqUZqdSdeRHVlGwYgUucP75UtzNNDvaX7Z5zjB4E/biYvP0lnrR/wtmJ
	 QSFg4V3a5Q61C7Dlz8l1BAnzVGptA8iUMVQwzrjaTZKFe+G+emB3sam3OHQ5jmZAEy
	 CEbLvwPEtUCZCZEJYmNIkudiNNZQJbth+OHAKEjyK2pCnjV5b/PChNKwmlE7pG/nDW
	 ikrNkLehhUTemQyDh3sctI9aXRc0IoPdF+GCHGFBjOw/jde6iziZ1gVKjJf4LQdiVO
	 IbUwEVl990f7Q==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-459a516592eso2736592b6e.1
        for <linux-pm@vger.kernel.org>; Fri, 09 Jan 2026 04:15:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXo6bO/+jLvGCusr5kt4WUrVziweBjALmLwUY1OumUqIJo0utbZUUDTZV7lF3CUZX0AydI69TLJBA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxRnRFF9C1x5Koac/tOPSvTq001lw/i1BZHdy/oztERR4Iivql
	09+lDT4fr9Xxa8ZOkMntkuAjtvD7cu3+BGrXAdoN67QjqXXMTyRa54IyEu3cl3Az+Rl7NwfIFA5
	lJhR/a4KUBYI++SUQMO3bRJG1ZD8wUZg=
X-Google-Smtp-Source: AGHT+IGuNuuYP5j4GBXsCKGPHH8/WGJAFVmUXPrvsPhnj56nFHYpg9m2T4o+h62kffjtfOUR+/0mF/+dtLclowT7Nwg=
X-Received: by 2002:a05:6808:159a:b0:44f:6dcd:1e52 with SMTP id
 5614622812f47-45a6bcd99a8mr4869690b6e.8.1767960917170; Fri, 09 Jan 2026
 04:15:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8633556.T7Z3S40VBb@rafael.j.wysocki> <aWBq-Rfu1yez6EjK@vaman>
In-Reply-To: <aWBq-Rfu1yez6EjK@vaman>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 Jan 2026 13:15:04 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hOe5Yy4pj6CXNqPRX+mTZ_CNjNhvXP4vQy9=M0DMafuA@mail.gmail.com>
X-Gm-Features: AQt7F2ohSuiKeqvlYLG5EK6PWfQHeWgJ_xIowCcEZ3PleyRvOqbPrEvL_6WRsGw
Message-ID: <CAJZ5v0hOe5Yy4pj6CXNqPRX+mTZ_CNjNhvXP4vQy9=M0DMafuA@mail.gmail.com>
Subject: Re: [RESEND][PATCH v1] dmaengine: sh: Discard pm_runtime_put() return value
To: Vinod Koul <vkoul@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	dmaengine@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 3:42=E2=80=AFAM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 08-01-26, 16:28, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Clobbering an error value to be returned from shdma_tx_submit() with
> > a pm_runtime_put() return value is not particularly useful, especially
> > if the latter is 0, so stop doing that.
> >
> > This will facilitate a planned change of the pm_runtime_put() return
> > type to void in the future.
>
> Hey Rafael,
>
> This is commit b442377c0ea2044a8f50ffa3fe59448f9ed922c in my tree.

Cool, thanks!

