Return-Path: <linux-pm+bounces-7578-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA92E8BE177
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 13:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16648B27EC4
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 11:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B813158A14;
	Tue,  7 May 2024 11:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReyHsMEJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4296F156C71;
	Tue,  7 May 2024 11:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715082985; cv=none; b=fb7+6qEnXpHUnqBIIkx6zpRftEe88YnZD6stNNY5EOdwLv1v09MEjXUUsymyurULaukFg1VeWQqaqLGsIhMOQ6T0fFr5jD/WRkPLVoJSrquaiqHzMHjCresUGOlD6CiJVyDGdQBpvWnwxCGWGxbvBGNnzuf7DvFP19JF6AcGUQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715082985; c=relaxed/simple;
	bh=uAr4H7tRCIauFbOSTrd3V0hWCXkSwtoJfgsnqX9sr70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YhxH0HKn0xEQt9tE0Cm0tX44fCXQCP9WCJmITu5Km4xFwGskRkOpI34XtbjwLFcFTw90Wcmv5TBdfbz8LKRv12hAHVKuQn0auK3GaMPcIp4zkLwjYJCkdjxZMWxOpr/j85QXS6dOX4I+PRfNVcMPGWRVIaOlNcCxXFqMHsw8GLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ReyHsMEJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA956C4AF63;
	Tue,  7 May 2024 11:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715082984;
	bh=uAr4H7tRCIauFbOSTrd3V0hWCXkSwtoJfgsnqX9sr70=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ReyHsMEJcHVcQ/QzVa1NipUGARG6Otvh0daXxhb7d8Zzn3lO5Y7kxDGW7yhW1pRmB
	 VScqCjACYnC6KlY1e0TAHVcKpEetEu0GolbnyZcsBVyQHiKJWOZg1mt+J6Wj0PWGvB
	 VU1oTbNiLqxq14ta3pTG8mY7YVTiivI69fsBi3VyGOtz65njLD89cYNS3IgeFGFQUk
	 ayLkznKDV9vaplX+ee78cyfEwBxTG4OXtkEwmhp5LPhRcSlqBsiSSpdipXgF2txfVq
	 39FoT2PXtgQ1MTdOO5UXz3gNccZidFHwG0UhG0/4XQHd24a7YoJslE8OxkHB2uAgZq
	 /uZRl0eXNhlsw==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5ac970dded6so703933eaf.0;
        Tue, 07 May 2024 04:56:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW5vw7KMHFKku/R90/3r4Bh8i8YmFCWBqxiAqqsF2PFuhPPsiDy/egFhKkslV4L3XDueQ5FkM8yKCbBLa1+WdS/LAneub+T4Ylz2cpAvF8UsL6bcz/kLModotuh3jD/+ZsyotdtPFE=
X-Gm-Message-State: AOJu0YxEwPlI0mPvkV/Yw2lw9WGfSP9cin32tVsM2q11dVAGiUrO0jMd
	zN7Wy/Pe6YFp8acRm4BJseJkgmbBe1cgP7M4BiG4uPHoJzjy1YhD7DHLkt2t+HDDDq/mQBwj6g1
	9gJD3oGL1uA3rItxn/FNyVDsMEoI=
X-Google-Smtp-Source: AGHT+IF+Rp4W2Uk2K7Kxer083DoPkJWSnnwreX6eMyuRnWF/5c9lp7cAB9qGLtED08IWk28G+F4hbGyWdgiKfFAR9VQ=
X-Received: by 2002:a4a:b6c2:0:b0:5aa:3e4f:f01e with SMTP id
 w2-20020a4ab6c2000000b005aa3e4ff01emr13237648ooo.1.1715082984155; Tue, 07 May
 2024 04:56:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240505-ladder_do_selection-kdoc-v1-1-fa0da92735dd@quicinc.com>
In-Reply-To: <20240505-ladder_do_selection-kdoc-v1-1-fa0da92735dd@quicinc.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 7 May 2024 13:56:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gj82ADfzP83QdMhmoyd8DZSMusmz1qAQP95iS+s5iqRw@mail.gmail.com>
Message-ID: <CAJZ5v0gj82ADfzP83QdMhmoyd8DZSMusmz1qAQP95iS+s5iqRw@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: ladder: fix ladder_do_selection() kernel-doc
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 2:42=E2=80=AFAM Jeff Johnson <quic_jjohnson@quicinc.=
com> wrote:
>
> make C=3D1 reports:
>
> warning: Function parameter or struct member 'dev' not described in 'ladd=
er_do_selection'
>
> Document 'dev' for this function.
>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/cpuidle/governors/ladder.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governo=
rs/ladder.c
> index 8e9058c4ea63..6617eb494a11 100644
> --- a/drivers/cpuidle/governors/ladder.c
> +++ b/drivers/cpuidle/governors/ladder.c
> @@ -44,6 +44,7 @@ static DEFINE_PER_CPU(struct ladder_device, ladder_devi=
ces);
>
>  /**
>   * ladder_do_selection - prepares private data for a state change
> + * @dev: the CPU
>   * @ldev: the ladder device
>   * @old_idx: the current state index
>   * @new_idx: the new target state index
>
> ---

Applied as 6.10 material, thanks!

