Return-Path: <linux-pm+bounces-10715-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C61B928DE1
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 21:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ACD4B22484
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 19:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A191176220;
	Fri,  5 Jul 2024 19:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdV0iyvc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32858175558;
	Fri,  5 Jul 2024 19:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720208485; cv=none; b=SZo+yw9oQ//R+853Dn8AU560Hsv+iyQwDa1ALPI0L/hyJy9xxx2XMQOMxIZkOESvOuJBEJrDdDFPrhmSpQUdQ9KxUyMz58N6JnKjPeMRO97qGwDzwY4Vwfa7SVUspjx3Ht+c9j1L9/mODs8sM0JwC38Iw0Uy0P/pBoi2SsJubKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720208485; c=relaxed/simple;
	bh=vv1Tpqm5QmUNe0ZQOWYzf5dxYr4UKCCoEL93djyVPBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PF9kEao+8/04CEm6b2RKSl731NONwpTpxs89sjpu0h6nSiTBgAbiMQLDVkqsGfitutLOWWN6wbb/lhnE3BVapbpmVyPgBWTDsL/Tt1xgO7nNl4KWhBekFNGY6sCqC6jozuDeheAo3fbJPJQH1b758mTjjTHqZ+LqhVylThZCH1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdV0iyvc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1331AC116B1;
	Fri,  5 Jul 2024 19:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720208485;
	bh=vv1Tpqm5QmUNe0ZQOWYzf5dxYr4UKCCoEL93djyVPBE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SdV0iyvczvjevvxKgRuHwb/p5DVxEwi6fHP5+gq4G0Eub7FHA+2T/bBRYzG9vdIa9
	 fRoqak2sQcAt/nSyNq12IqB91B7qwg4+o752lrM0OUE9HgRilLNiRQVZPr4XiBu1bs
	 zAzkQqr6CnIEO5ufHSqL694v/O2vk8xUP7mpPTmNeLCxKBi/gUOr36LvW4PSN1Wvy3
	 KynB7f3dL9HG1Ba/hxIpQk2FvbTbvDXCQHIhYH486bTdjhm+YbxtlsRuTFGh0kO5bs
	 33lhnGh5IPNRXYssrpLWmvU71ikbVSBuz9l2j1Jons5I6KPPxTF1JhmVH3hfsOUZ1h
	 BqJWcMMh1YtYA==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5c665fb40f7so1203eaf.0;
        Fri, 05 Jul 2024 12:41:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUg2Mo9BgUC6fgL8nGzn6uH/eAdCHtp9/iC5pLsxb+PsPYnZZuvsLzRCGiuD5GNjfZOa8psbs8rsEPfiYgqYGdAQD1D0M035sWPFBb7
X-Gm-Message-State: AOJu0Yz+dBX4/eF+YYxUwOPpAvOGitrilXfdVCGurZjdA5C6YW8nwPW4
	c7v64vRSnnzBV8+LP9kt0tpSkhMg/+A8NqpCkTSNxIMGzsQhiJsXCfs1Pb+r9cmaF/3q7xriWRL
	8iRYONijJVWslI9F0itsBcXZAB+Q=
X-Google-Smtp-Source: AGHT+IHhf5lue9PlQBJ+TEGrv4IYmQXq88rwEYo/5G6puxCxFYYJX4/nXyuEvlR7zYck6XP96wWR2uMz+IhFlANggtM=
X-Received: by 2002:a05:6820:228a:b0:5c4:7895:93b8 with SMTP id
 006d021491bc7-5c646ecb3c8mr7297664eaf.1.1720208484379; Fri, 05 Jul 2024
 12:41:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4585590.LvFx2qVVIh@rjwysocki.net> <13555515.uLZWGnKmhe@rjwysocki.net>
In-Reply-To: <13555515.uLZWGnKmhe@rjwysocki.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 5 Jul 2024 21:41:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iV8LNyh+-N4PSqDa3uiHgEj4-nfATQw9dkCy7uDr=x1Q@mail.gmail.com>
Message-ID: <CAJZ5v0iV8LNyh+-N4PSqDa3uiHgEj4-nfATQw9dkCy7uDr=x1Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] thermal: core: Add sanity check for polling_delay
 and passive_delay
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, LKML <linux-kernel@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 9:34=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.net=
> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> If polling_delay is nonzero and passive_delay is 0, the thermal zone
> will use polling except when tz->passive is nonzero, which does not make
> sense.
>
> Also if polling_delay is nonzero and passive_delay is greater than
> polling_delay, the thermal zone temperature will be updated less often
> when tz->passive is nonzero.  This does not make sense either.
>
> Ensure that none of the above will happen.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Well, the changelog is OK, but the patch is not.  I'll send a v2 shortly.

