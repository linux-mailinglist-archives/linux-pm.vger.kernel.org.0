Return-Path: <linux-pm+bounces-38643-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5056C866DE
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 19:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6FFF84E3796
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 18:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F6732AADF;
	Tue, 25 Nov 2025 18:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSHlvt1V"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349E1329C7A
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 18:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764093943; cv=none; b=C3tFr02yApF7QtM1lgCIHTlJT/vYqvVIktwV7FK6rjkMD7RcQYozq1Qdc6pEhI9x9lKILOK1W8rMobAwdmwuqj8RmIlbmBFfSpFSFJPCXdQmidRwA8GiXdyxKhT9IDLjtSUp4on32I17mCMbjd394LRQ6qS3jk2TJnKxLJglodY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764093943; c=relaxed/simple;
	bh=/3kxarVz7v2F9UXOEv/gGUfA/ax1cOhOAxXSIPU5/eE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CzQ2JYl9iT7ASlhCkGgAdYePj3eYP0pduq9aloWX2LwUzKFZsWxCWPFmny0uVIvzs0r33eooZaCV6XSz06f6Tm1FjnBcetiHGYnMUrd1ns7mXsmSLQex/JvL0kjuptEbs6j7Lrdf30EuP+4yqR/EW4uRTIhoM8PhJqrNnKVUBwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSHlvt1V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9C3C16AAE
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 18:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764093942;
	bh=/3kxarVz7v2F9UXOEv/gGUfA/ax1cOhOAxXSIPU5/eE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lSHlvt1V+77eFw4bHQ14pcxly2uo85pe3n93w8JnaMKQo97CRvhH0EUHvHLox7YQ1
	 blGxQfqEadd2PVFlg4zVI8zS71qLhm1PVp3198xdIyuKle3eSkvDpFgOMAcaF5+uYD
	 9JJRsQ1M6O8Rj62kDVH3f+EIlmsD7uKZPJhq27uIzexwYrRjgasnDdoP5DmEdwPb7a
	 QpltsRKWYqItIL1glCcOY7FSai03U+49Divk4TLuglFHfqjjQl9lrYmQCzQASc2D3g
	 uyJuh+J0poCne/ziU2xEj4OJfuuvQawszv1t/AB/XKeU8yXTVj0/0znrVNTMpKc6wN
	 SsELc6ZRaxViA==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-65752954c43so33559eaf.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 10:05:42 -0800 (PST)
X-Gm-Message-State: AOJu0YwH5IHTYVuhCx9gQEVaUW+c5myOFlEY5b4cdB3QPLfrlRluskb9
	2zFO8yXOO6Uk4InQHlAFQSfkC0beh9lcoQPTY2sUbhvWjkrEKczFdkoyjkKgN9C7nu5vrCtPjfy
	TmUAdImnaptn0bm3QWX9oi1CpoE8FFCs=
X-Google-Smtp-Source: AGHT+IEXMLh/t+yulWWNnaSColJBcxSSuxC1hl3QlWZflGzFuKovSFkbKIN2GU1lhWT8uMkZ97mgWdLy7VsAyYjtPVk=
X-Received: by 2002:a05:6820:2005:b0:657:45e1:1979 with SMTP id
 006d021491bc7-65785873cdcmr8506478eaf.3.1764093942038; Tue, 25 Nov 2025
 10:05:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124205752.1328701-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20251124205752.1328701-1-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 25 Nov 2025 19:05:31 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jFm90q2uSmSzqwpTpqXbW2pOnqE9P_dbrYoSpee2=+8w@mail.gmail.com>
X-Gm-Features: AWmQ_bmyG_AM5HbMT6dy_VfsqXEM3z654CLeFMF-pxKatMSb-ENuLc7P5m27poc
Message-ID: <CAJZ5v0jFm90q2uSmSzqwpTpqXbW2pOnqE9P_dbrYoSpee2=+8w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] cpuidle: Update header inclusion
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 9:58=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> While cleaning up some headers, I got a build error on this file:
>
> drivers/cpuidle/poll_state.c:52:2: error: call to undeclared library func=
tion 'snprintf' with type 'int (char *restrict, unsigned long, const char *=
restrict, ...)'; ISO C99 and later do not support implicit function declara=
tions [-Wimplicit-function-declaration]
>
> Update header inclusions to follow IWYU (Include What You Use)
> principle.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/cpuidle/poll_state.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
> index 9b6d90a72601..c7524e4c522a 100644
> --- a/drivers/cpuidle/poll_state.c
> +++ b/drivers/cpuidle/poll_state.c
> @@ -4,9 +4,13 @@
>   */
>
>  #include <linux/cpuidle.h>
> +#include <linux/export.h>
> +#include <linux/irqflags.h>
>  #include <linux/sched.h>
>  #include <linux/sched/clock.h>
>  #include <linux/sched/idle.h>
> +#include <linux/sprintf.h>
> +#include <linux/types.h>
>
>  #define POLL_IDLE_RELAX_COUNT  200
>
> --

Applied as 6.19 material, thanks!

