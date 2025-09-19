Return-Path: <linux-pm+bounces-35078-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074F7B8B4D1
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 23:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6286C7B441C
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 21:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26622BE7D1;
	Fri, 19 Sep 2025 21:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApVwj5H8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6CD381BA
	for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 21:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758316395; cv=none; b=rWoalhzbMBI27bp6gC7EyN7ffF55hwS/5BJdRQHkJftZcr6LVhfepWTsxeHMBUyw5KeogxNga8zC8TuNunyinsE7r7l4YvUAGCQiuw0qw1jKyXctS9uQRW/wPQHyTaGKGB7Gdmei6mqnlHH2PZiqQO8wzpTbBuPgQc88CYvpffA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758316395; c=relaxed/simple;
	bh=1LBZm3tViyEk9WGaszF/av9kAKvUmA0Io1A5lN/1dZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLL5BjeodWUavlURQFm4zs89WSqdtI/eSJDQb6WmpGUZYD8LfCSXlqNpwOTR18ULpTNxk8fwtDdXD0EQoRcuk/X8lSwnMTdQCEUK8k6ihGeTSAdOh8uX7YLNhTUlkSAWa6QSh8PwXWijxvoXSoWoD1XeC5ZC5OMJurOKSr/PfpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApVwj5H8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9438EC4CEF7
	for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 21:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758316395;
	bh=1LBZm3tViyEk9WGaszF/av9kAKvUmA0Io1A5lN/1dZo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ApVwj5H8ttH2IulpCgrBg6J61DErEa+Utr7mDJJehyEkTO+S8miKnVRp17Lo+xckL
	 hEkkaqTkFAKSBge45o5M+xX0eOeWDyg3uZXmqojN7xYK5F7K/JoPZdjmlyuYkr4Au8
	 TtzhVLuUD46704cLAeUeVnqdX2P4iI/PSmbS0OVETVAX5mnfXb9LIZ/7CKAj5xXcFw
	 uG+QD7iiCFq3VmKNbw90UzV0Wp+dfTwuJvcyHmkJvbEb4OJ3c33NqGSbpHwC5Hheih
	 8GJj171ro/y3UEXKt/fmAhzYiQ5smEYZTgVPermnChpPKpYGcyekDEI3SUpD0+hYEg
	 7mnlcSxIZ5x4w==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-626190c9c1eso835418eaf.0
        for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 14:13:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXTUdSQwpT1XRSTnwNI0zP0rCcY+S9N7pIed6IWJDk6sbqHfKtfRbJFEdkO4XmJywaxDIPG4byx/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdpgYIYm7oEPOsb9bb78Pclj+PWK6RGLzfBB3vyBUksm7hoJ+x
	r7F6WHA0EArUNM5NlNPE0QzNFiMqmZpj2DdkzrYpj+V6vUnHGKM+ZxZBh9Go4/JgAKF8HUqYbuO
	xtemvncXTKbj09TrliTmiZ9PtW0nnQKQ=
X-Google-Smtp-Source: AGHT+IGrZ2HA8FzwQTb4wfxWm0JgX+FFPpSWCNkTt8xhrFxqOZm12RFgGMRNz7CcJstpbEB9LUbsULzu0tyPgfQMhGQ=
X-Received: by 2002:a05:6808:7003:b0:439:aeb9:88fb with SMTP id
 5614622812f47-43d6c18d966mr2642320b6e.17.1758316394912; Fri, 19 Sep 2025
 14:13:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908085738.31602-1-zhangzihuan@kylinos.cn>
In-Reply-To: <20250908085738.31602-1-zhangzihuan@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 19 Sep 2025 23:13:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hgku5V-3GNVH2w8GT2JzkHOU2NZkfHdrRDT-Hb80tuuQ@mail.gmail.com>
X-Gm-Features: AS18NWDehhhPB2xlBMFibfeDQnR-pUHpEQp9MKkCkOVUsCVFU0wJxcZWkJDLnb4
Message-ID: <CAJZ5v0hgku5V-3GNVH2w8GT2JzkHOU2NZkfHdrRDT-Hb80tuuQ@mail.gmail.com>
Subject: Re: [PATCH v1] cpufreq: Add defensive checks during driver registration
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 10:57=E2=80=AFAM Zihuan Zhang <zhangzihuan@kylinos.c=
n> wrote:
>
> Currently, cpufreq allows drivers to implement both has_target() and
> has_target_index(), which can lead to ambiguous or incorrect behavior.
>
> This patch adds defensive checks in the driver registration path to
> prevent invalid implementations. For example, a driver is no longer
> allowed to implement both has_target() and has_target_index() at the
> same time. These checks help catch driver mistakes early and improve
> overall robustness, without affecting existing valid drivers.
>
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> ---
>  drivers/cpufreq/cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index a615c98d80ca..cead6d4fa1ad 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2922,6 +2922,7 @@ int cpufreq_register_driver(struct cpufreq_driver *=
driver_data)
>                 return -EPROBE_DEFER;
>
>         if (!driver_data || !driver_data->verify || !driver_data->init ||
> +            (driver_data->target_index && driver_data->target) ||
>              (!!driver_data->setpolicy =3D=3D (driver_data->target_index =
|| driver_data->target)) ||
>              (!driver_data->get_intermediate !=3D !driver_data->target_in=
termediate) ||
>              (!driver_data->online !=3D !driver_data->offline) ||
> --

Applied as 6.18 material with edits in the subject and changelog, thanks!

