Return-Path: <linux-pm+bounces-14656-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CFD9855E3
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 10:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D98E61C234D9
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 08:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FAC158D8D;
	Wed, 25 Sep 2024 08:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EBWAuV/A"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6350B156222;
	Wed, 25 Sep 2024 08:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727254496; cv=none; b=rc0LWD6OtdXUwOW666JIM8rETLE0ENhC5UDQW6icUyLyURO7TuUhV8Cv0MIeRWe7bC9sf9nn2V5LJ2ZO8g8W2VjsSbbZQdOGDniSvSSLMNiEpm/9ewMMFgvo80q3Emt3ayPmBobNxIKaTvyfzOibW593gWqlgBmKzxVZdruISSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727254496; c=relaxed/simple;
	bh=1FOp92KBJPupmba1Mm9f9uzhUy5JB5JjPCZW7EGMWL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gl5e3F0n3g606LcwkYUdTcgMSwyM620vpmRWVmB8WU0uCtXaHhwOMGBbv3AfeAF03zMWfmf5IyN1ENwGi6iozSegRAJOKwwBeW4PQ8xIP9Jjj9vJZLx2lIX0Mp5q2hb4ar4oNJrmeFyxNBXgNWTSwyK7RDSR+3bjgRHGlgQqPV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EBWAuV/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6D0C4CEC3;
	Wed, 25 Sep 2024 08:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727254495;
	bh=1FOp92KBJPupmba1Mm9f9uzhUy5JB5JjPCZW7EGMWL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EBWAuV/Au7O5eNiyzx8rAflBIfIsJ+spS8nHYZxW3ZMoWnG/4r0ZUX6wOswRIxHiM
	 998+n6c0+o3noyUm7pZzgbCKAp7szbjwynmmpgKWUeKFUE7mrTAv6K4dBh3d8boW9f
	 W4i68A4Y1Ut+L5OsadjLTCLALlkyQiH26r3tux6s=
Date: Wed, 25 Sep 2024 10:54:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: dengjie <dengjie03@kylinos.cn>
Cc: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, xiehongyu1@kylinos.cn,
	duanchenghao@kylinos.cn, xiongxin@kylinos.cn
Subject: Re: [PATCH v2] USB: Fix the issue of S4 wakeup queisce phase where
 task resumption fails due to USB status
Message-ID: <2024092525-envision-impotency-c1a6@gregkh>
References: <2024092543-enforcer-quaintly-9f3e@gregkh>
 <20240925080618.188429-1-dengjie03@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925080618.188429-1-dengjie03@kylinos.cn>

On Wed, Sep 25, 2024 at 04:06:18PM +0800, dengjie wrote:
> >> Fixes: 3904bdf0821c ("PM: hibernate: Freeze kernel threads in software_resume()")
> >> Signed-off-by: dengjie <dengjie03@kylinos.cn>
> 
> >What happened to the other authorship information?
> >
> I'm very sorry, the information of other authors was 
> accidentally added when I was using the script template.
> 
> >And again, please use your name, not an email alias.
> >
> My name is Deng Jie, and dengjie03@kylinos.cn is the 
> email account registered with my name, where "03" is 
> added to avoid the problem of having the same name.

Great, please use "Deng Jie" as the From: line and the signed-off-by
line as is required.

thanks,

greg k-h

