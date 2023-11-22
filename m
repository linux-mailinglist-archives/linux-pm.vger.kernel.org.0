Return-Path: <linux-pm+bounces-99-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 356D97F51FE
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 22:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 625271C209DE
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 21:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED2814002;
	Wed, 22 Nov 2023 21:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+DAYlma"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CBC1C14
	for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2023 21:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FCBC433C7;
	Wed, 22 Nov 2023 21:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700686871;
	bh=LFJYP+QjzywPPTWxrzmRwkBKvDt/8qXL2sn05QMF5tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n+DAYlmapEZKrvTtUqKHYNU1PFaL2I5a3UWtBmUXQnpFrfGztZvuFATKxUxEua+km
	 o9poCmNBo3TSnLW8W00G5Aublxu5IHhZdFDhkcxDpbLWR0FA5kcXnQClCAXVzv1yE9
	 wMc/KP+WN3bwkqrEH/dFx8f4jlZ5ovi/mjLtORd7JUQfO/xmzRxx1vTiuez7FIjChU
	 Gp8OcAXR4KM6kjXJ8KMA99gEH4cJFtjXYdYO6EAJQ6zJHYbjxsWl2fLjygceo5x1cA
	 HbRyx4cb968mZf8x0Q1/ox9qbFm2KUBBvEvCTbSeaali2AzdhrNL59WN/whMesx+C2
	 T3LF4R2qu3cfQ==
Date: Wed, 22 Nov 2023 22:01:07 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] cpuidle: Remove unnecessary current_clr_polling() on
 poll_idle()
Message-ID: <ZV5sEwwnQTjh-QXm@localhost.localdomain>
References: <20231113220326.7933-1-frederic@kernel.org>
 <20231113220326.7933-3-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231113220326.7933-3-frederic@kernel.org>

Le Mon, Nov 13, 2023 at 05:03:26PM -0500, Frederic Weisbecker a écrit :
> There is no point in clearing TIF_NR_POLLING and folding TIF_NEED_RESCHED
> upon poll_idle() exit because cpuidle_idle_call() is going to set again
> TIF_NR_POLLING anyway. Also if TIF_NEED_RESCHED is set, it will be
> folded and TIF_NR_POLLING will be cleared at the end of do_idle().
> 
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Please discard this one, I'm taking a new way to deal with that.

Thanks.

> ---
>  drivers/cpuidle/poll_state.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
> index 9b6d90a72601..d5cb3eb85a54 100644
> --- a/drivers/cpuidle/poll_state.c
> +++ b/drivers/cpuidle/poll_state.c
> @@ -40,8 +40,6 @@ static int __cpuidle poll_idle(struct cpuidle_device *dev,
>  	}
>  	raw_local_irq_disable();
>  
> -	current_clr_polling();
> -
>  	return index;
>  }
>  
> -- 
> 2.42.1
> 

