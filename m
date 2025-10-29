Return-Path: <linux-pm+bounces-37065-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD4DC1CDC7
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 20:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68BA14E05A4
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 19:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947113590C4;
	Wed, 29 Oct 2025 19:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaMYCV0B"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700DD3590C1
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 19:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764433; cv=none; b=kyYMgE18/lxAl0eyYfsuyQLvTbwXkUc5FMV+uiFWsVfvLCLvNkNr4CC1QEEuhTZSmFBWmkt1ZWZT/dTzR99GQTzCaXZcKSaQ1d0578lxG3UQzuuc+rKFqIAwRjRVfo1sKQs8p6gez4klBKBDNRU3R+5cxRPv2VhUw6VYL0ksvXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764433; c=relaxed/simple;
	bh=7lyiAV1rqHRrNNC2mebu+0d6w0qgxZqfz9LsUM51/IY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A7R5FPpO4pB55ZkozbQJ37WQIkIYOqkkUBGlpVuhJARiZwMqPhD99cKJ19gyLywJc4xrhjmimIB1D6oQPKFdd5uWEeV1nr4PAwPaEhj9PmQVLsYWQiGXfZ2TmHbNwv14VexKl8DG93DR38+dEZ6bb3VzweGK817f91Bpcwyf5KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaMYCV0B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069D1C4AF09
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 19:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761764432;
	bh=7lyiAV1rqHRrNNC2mebu+0d6w0qgxZqfz9LsUM51/IY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kaMYCV0BjBakVZ+zrLfrrR3dVzNMx6/KLmy3R7stVpHx/DXX57k5gw0fYgKrgQDTE
	 2mrcvm8YNi2uT/o3OjtZFjLCeXfauOfpiHJxeUfmi8JlfJZg0HLukuNHRdNAnVaMC9
	 9gtkDiJ5zk0K1FQJHkgsdaaAMlsDh5Imm6Aabn7Q7UqpS0PtA81OCtfBiDnfbzpzja
	 0c0Y33hD7y6iZ2nTd/hcIW/dxBz8W1MnoDLmGmLgnFTeqGFYNpkwFXRZaWHqg6GXUD
	 09puiTffHYBoTYPiqgwQNUeP+dZAMCL4DNv8M2t+DDdZ+xPTxGOTF6XSWwnvAFwi9e
	 F3zqmHPzU9Czw==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-443ac891210so133780b6e.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 12:00:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVACcU26QmB4KfL0CHVdlwWekSc8k4yEB5T9KeWcah6dp/o6Skow7Uz6uNQ6XE4YXigoghNK3igMw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx12ZxHKszpyGglRjTVYp416NSyyISpAurNOQxXcjIPFrhZWvaj
	ZTCqZTkgUrU6qBw4SRqrAn8n/inP3KyP8Brom9V+w3FvFq9VJD3onDhPZCLgtEVQ8/Yy0VJLZ4C
	XTuKcX9JIPt9GMYbmBRIP6GjJCzG0pCw=
X-Google-Smtp-Source: AGHT+IEM2thqrNFpWgW4GaxlYBwePV2dgOkn3wDq3C3a3TbN7GDItXTyZfYFUpWtpwDSnFCac7W45ElxoOHQJDadjYY=
X-Received: by 2002:a05:6808:3990:b0:44d:bf83:d7f8 with SMTP id
 5614622812f47-44f7a3d0652mr1972133b6e.4.1761764431301; Wed, 29 Oct 2025
 12:00:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026170527.262003-1-mrout@redhat.com>
In-Reply-To: <20251026170527.262003-1-mrout@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 29 Oct 2025 20:00:20 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gtKTUAthA4OaCU-hV4j1OhRDuA10o-ZhXepFyq7J5L2g@mail.gmail.com>
X-Gm-Features: AWmQ_bk6EPvPp1ZojFQfUZnAvpOOabuA0STIcW3pcPHz9eAU0AO-Pz444iRTH1g
Message-ID: <CAJZ5v0gtKTUAthA4OaCU-hV4j1OhRDuA10o-ZhXepFyq7J5L2g@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: fix typos in runtime.c comments
To: Malaya Kumar Rout <mrout@redhat.com>
Cc: linux-kernel@vger.kernel.org, lyude@redhat.com, malayarout91@gmail.com, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 6:05=E2=80=AFPM Malaya Kumar Rout <mrout@redhat.com=
> wrote:
>
> Fix several typos in comments:
> - "timesptamp" -> "timestamp"
> - "involed" -> "involved"
> - "nonero" -> "nonzero"
>
> Fix typos in comments to improve code documentation clarity.
>
> Signed-off-by: Malaya Kumar Rout <mrout@redhat.com>
> ---
>  drivers/base/power/runtime.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 1b11a3cd4acc..7fe63cab2708 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -90,7 +90,7 @@ static void update_pm_runtime_accounting(struct device =
*dev)
>         /*
>          * Because ktime_get_mono_fast_ns() is not monotonic during
>          * timekeeping updates, ensure that 'now' is after the last saved
> -        * timesptamp.
> +        * timestamp.
>          */
>         if (now < last)
>                 return;
> @@ -217,7 +217,7 @@ static int dev_memalloc_noio(struct device *dev, void=
 *data)
>   *     resume/suspend callback of any one of its ancestors(or the
>   *     block device itself), the deadlock may be triggered inside the
>   *     memory allocation since it might not complete until the block
> - *     device becomes active and the involed page I/O finishes. The
> + *     device becomes active and the involved page I/O finishes. The
>   *     situation is pointed out first by Alan Stern. Network device
>   *     are involved in iSCSI kind of situation.
>   *
> @@ -1210,7 +1210,7 @@ EXPORT_SYMBOL_GPL(__pm_runtime_resume);
>   *
>   * Otherwise, if its runtime PM status is %RPM_ACTIVE and (1) @ign_usage=
_count
>   * is set, or (2) @dev is not ignoring children and its active child cou=
nt is
> - * nonero, or (3) the runtime PM usage counter of @dev is not zero, incr=
ement
> + * nonzero, or (3) the runtime PM usage counter of @dev is not zero, inc=
rement
>   * the usage counter of @dev and return 1.
>   *
>   * Otherwise, return 0 without changing the usage counter.
> --

Applied as 6.19 material, thanks!

