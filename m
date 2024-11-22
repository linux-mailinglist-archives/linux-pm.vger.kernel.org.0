Return-Path: <linux-pm+bounces-17937-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 759A59D580A
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 03:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D30C1F21EE9
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 02:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BC914F114;
	Fri, 22 Nov 2024 02:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="oBedGZ26"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0347B70824;
	Fri, 22 Nov 2024 02:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732241020; cv=none; b=Apof/DNyCFT/YJPGMFgldH4hQXNZjCpZgeDoq0h/AUKzaxozAv+QmDq+P70mHdhMqpOPb8LYFKCxr1WzKBRaA7pzrUkP8VFJ/nlnimTb2arPEy0wl06nmXDEO+tPSXrwA6sOSWz2PRcGMeHWtBeYss9Ljto6JlTt5WWNKx4Ld7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732241020; c=relaxed/simple;
	bh=H0o3EjIFg35q1FThBYx71l0Umjljt08gfkwVq6HGqss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozTBJV//Y5ktvHyMaZ9alQiIf/8fFq8bb6wmTB4ZbjUHpo+JqysAc8MEQpWr5rtNgKNcpsgHJb0yXlh0t+10mA17GzOaqgwWWZXMQ/haUHw8nN3mMZqLvQDq2Vl89DPEomUWAn1OeWHLxrJkU4xiq6fJZ9nnLFh6I3iBbBvvbNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=oBedGZ26; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=cO28DLrqyhaXcLC+CnKPyQYG0vP5bHEaBQLUcQnkvM4=; b=oBedGZ26PuF8sAcW
	hBNyNHs/4AoX7D2gzmGfSQOLVT7lo+SgQQVZ9wff7mFuoh0sx6cXakzClwL8WCdY2zxgcucgxYmR4
	yZ28vwdgeuFZnIs7zAM7ozS/BNDef4GXIIVN40t/xY9v4eQ9+Zsvs1oRkt1zYgZw900pUq296DGHN
	AoHXJ6ClvXgDsRKqqRMo07wsBCTiu9xGY6cJlDAujirM4PIoeBto0TmEKqzlZJ8A2d0O2Gxj9kRLe
	QkHxyisz7H/h1D1jvNqaFr4KJmZKxAP037ANkPBtc/45qMJOjYTroYfjwsv48K/C1iJ3AcG1d90uF
	1I3+Dy0lS1WjUuEEcQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tEJ1E-001Egq-03;
	Fri, 22 Nov 2024 02:03:36 +0000
Date: Fri, 22 Nov 2024 02:03:35 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: cw00.choi@samsung.com, myungjoo.ham@samsung.com,
	kyungmin.park@samsung.com, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM / devfreq: Remove unused devfreq_event_reset_event
Message-ID: <Zz_md0hui8nY625s@gallifrey>
References: <20241022003157.303127-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20241022003157.303127-1-linux@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 02:03:24 up 197 days, 13:17,  1 user,  load average: 0.00, 0.02,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* linux@treblig.org (linux@treblig.org) wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> devfreq_event_reset_event() was added in 2015 by
> commit f262f28c1470 ("PM / devfreq: event: Add devfreq_event class")
> 
> but has remained unused.
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Ping.

Thanks,

Dave
> ---
>  drivers/devfreq/devfreq-event.c | 26 --------------------------
>  include/linux/devfreq-event.h   |  6 ------
>  2 files changed, 32 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
> index 3ebac2496679..a60703374006 100644
> --- a/drivers/devfreq/devfreq-event.c
> +++ b/drivers/devfreq/devfreq-event.c
> @@ -183,32 +183,6 @@ int devfreq_event_get_event(struct devfreq_event_dev *edev,
>  }
>  EXPORT_SYMBOL_GPL(devfreq_event_get_event);
>  
> -/**
> - * devfreq_event_reset_event() - Reset all opeations of devfreq-event dev.
> - * @edev	: the devfreq-event device
> - *
> - * Note that this function stop all operations of devfreq-event dev and reset
> - * the current event data to make the devfreq-event device into initial state.
> - */
> -int devfreq_event_reset_event(struct devfreq_event_dev *edev)
> -{
> -	int ret = 0;
> -
> -	if (!edev || !edev->desc)
> -		return -EINVAL;
> -
> -	if (!devfreq_event_is_enabled(edev))
> -		return -EPERM;
> -
> -	mutex_lock(&edev->lock);
> -	if (edev->desc->ops && edev->desc->ops->reset)
> -		ret = edev->desc->ops->reset(edev);
> -	mutex_unlock(&edev->lock);
> -
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(devfreq_event_reset_event);
> -
>  /**
>   * devfreq_event_get_edev_by_phandle() - Get the devfreq-event dev from
>   *					 devicetree.
> diff --git a/include/linux/devfreq-event.h b/include/linux/devfreq-event.h
> index 4a50a5c71a5f..461080280de9 100644
> --- a/include/linux/devfreq-event.h
> +++ b/include/linux/devfreq-event.h
> @@ -104,7 +104,6 @@ extern bool devfreq_event_is_enabled(struct devfreq_event_dev *edev);
>  extern int devfreq_event_set_event(struct devfreq_event_dev *edev);
>  extern int devfreq_event_get_event(struct devfreq_event_dev *edev,
>  				struct devfreq_event_data *edata);
> -extern int devfreq_event_reset_event(struct devfreq_event_dev *edev);
>  extern struct devfreq_event_dev *devfreq_event_get_edev_by_phandle(
>  				struct device *dev,
>  				const char *phandle_name,
> @@ -149,11 +148,6 @@ static inline int devfreq_event_get_event(struct devfreq_event_dev *edev,
>  	return -EINVAL;
>  }
>  
> -static inline int devfreq_event_reset_event(struct devfreq_event_dev *edev)
> -{
> -	return -EINVAL;
> -}
> -
>  static inline struct devfreq_event_dev *devfreq_event_get_edev_by_phandle(
>  					struct device *dev,
>  					const char *phandle_name,
> -- 
> 2.47.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

