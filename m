Return-Path: <linux-pm+bounces-20179-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B82A086B6
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 06:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70A4B168717
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 05:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E32206F08;
	Fri, 10 Jan 2025 05:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PTMfA7aw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BC0206F06
	for <linux-pm@vger.kernel.org>; Fri, 10 Jan 2025 05:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736487709; cv=none; b=d4cTIEGwf1efcwjcGwLpy87T/Q9Uce5ISdAM9DHX0hQ6GBf5ON9p5qF4lr/THmoVKII4c3I0q/EawZdx3dX5kIS2qwFIG5K3u6M0ADs+LfTYuIUcUoWtft2OsDS+QS9i6CEKi3emnGpuzFeeC8+oGduTuhygBsBefMCK9LqLxh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736487709; c=relaxed/simple;
	bh=d8EZdy8eZtNJP/NsHjoNcY7bl+Qrc0U/I1kD++suigc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7fcVGssDcK3BFX4cCs8o0tp9svg57Z97jMCG0mpQmrMMicRi18q8PNTRWZ3l8zi/V3S7Bh9mQdDJxIsZztPLudw2lTfQFlvY9DVnB22ZwfRWdtM2ODFpNpE05Mq9UJSHIFSrNn57YTDosafFhDwKli09MyP6cxlfu7ZBO78mCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PTMfA7aw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-436202dd730so12163675e9.2
        for <linux-pm@vger.kernel.org>; Thu, 09 Jan 2025 21:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736487706; x=1737092506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KSHE9QNUgknUyKnwB9vF86rsbDuXt2zgyk5YFStDUsw=;
        b=PTMfA7awNxdNHBOHCm7r9k/nwpdBFkQsUkBBE228mFBOnoBdy2ZUknAFRBiyIYbfd4
         0Ll/KShZ6Edcbtdub3PEC3Sql1sDtyTk9efK2SNjKix7Bycoj8HDH1YxBD86Z0+zZrLh
         e7R/B9KtELan8ohruUj0844Vdnipeylln6YOt7F90a01BoekyRI3QMyaF3bEnY/jzBAL
         EOMxiZe1FkwhcIZWNwG7+DRZtv1/gprjESNRTYGi0NGPuiqHmIKOeZUv5GPws6PPWkB9
         rKib+p87zW7KR7HLCkKPqB2+JVP/PR9ZxJESc8wP0rMmIywzyi/tB6ohk4rQmT36GqQN
         8YSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736487706; x=1737092506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSHE9QNUgknUyKnwB9vF86rsbDuXt2zgyk5YFStDUsw=;
        b=bgIyhMoJrOOx7jF2Vg6hIsq59judb/s3rB3fqwS2wNbHY4hT5w3VGG1CUFHUbYmsid
         hExRnHWtsxHRQIgI2SJMmhJxYYJ7UrYcYMeJkMePlkqMW9ndme4ZQB2ui3soA/Kr5PMx
         iy+ErvN67et6oS8NVU+YmnPElKiP3OH0yNmuiNAHp1C3J6emgFBcFMV+5BYJrCZscpvp
         slodDtJVIwZ3IPUgzjRkyd5akdQtLNPtFJXE2HJFKJP/ZE4sWTbpit8v4FNxi/d674AI
         Y1wN4Jkk2tP2adukJg95FR8T35OLuJzBnU81TV+le+KugdilDg5N+aYbaCygqlEe4q4v
         2Dtw==
X-Forwarded-Encrypted: i=1; AJvYcCXQiPZYTDidrUJ29duCp2HwT49V/KWKuyKieamhWHSL8rMLTxOGXtpemn/b1dbrdRVbg4WcI6Ou1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYKZK+O1GO1H1WgZSqwgMrCReVsBX47PUfnKd0cPlCyz77bxjz
	OJ9/60m+lsCruD+Dwfl12P7EdPhSGtsX6jjBloVrhVHZOl8ZkAd+KT62B3r/6eY=
X-Gm-Gg: ASbGncsBWUcnkLG69q9vUSyrOkY+aat25IukrqLhrIPnuP+s5HdUkj0Os6SWUD/bbkw
	d2W1LonSi8bdnDRzf9ydVx+gpQi09WyheV1e+y58RIJkDJCRAbd5UU3884NO8TAKDhzlA/AhDxw
	iOrrnAkX0NyK15OY5Aijb0940cRswJgChSIFkbYwQyFTlerOMg3C5QMETpNBrlb/vgn29h+s0VS
	5H0dlkhCYZMEcmMdv3KuYKL7vDW53/yjMHaqmvrqUZhi2HXKkr62y6v6ww1LQ==
X-Google-Smtp-Source: AGHT+IF8fnt9NgOi4RyEVdFr/Wbr6/a+XkVoBSHDOZ0zVVlpiNPrx3Y6CtPFHTsb4GTGEsq45PDT1g==
X-Received: by 2002:a05:600c:1e1b:b0:434:fa55:eb56 with SMTP id 5b1f17b1804b1-436e2686279mr84877035e9.7.1736487705672;
        Thu, 09 Jan 2025 21:41:45 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9d8fb99sm41473965e9.3.2025.01.09.21.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 21:41:45 -0800 (PST)
Date: Fri, 10 Jan 2025 08:41:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [bug report] powercap: balance device refcount in
 powercap_register_control_type()
Message-ID: <a25400a9-ed04-4355-a9c5-e3439ac26d78@stanley.mountain>
References: <97c5c93d-e31e-483b-83c3-28b797b69e9a@stanley.mountain>
 <68cdb73b-59cd-47be-9bc1-9affa606ba8f@pf.is.s.u-tokyo.ac.jp>
 <CAJZ5v0h4TUvGKKD51U+RUWv0sCbRjon6PF3ycVaTHMoA=1VEVQ@mail.gmail.com>
 <87e46b70-d100-4ced-9b77-0d30eaecbf2d@pf.is.s.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87e46b70-d100-4ced-9b77-0d30eaecbf2d@pf.is.s.u-tokyo.ac.jp>

On Fri, Jan 10, 2025 at 10:13:38AM +0900, Joe Hattori wrote:
> > > > 
> > > >       631                 if (control_type->allocated)
> > > > --> 632                         kfree(control_type);
> > > > 
> > > > Use after free and double free.
> > > 
> > > Instead of reverting the patch, How about removing these two lines to
> > > avoid the double free (so that mutex_destroy() is called in the cleanup
> > > function as well. Not that it makes that big of a difference though). If
> > > that is ok with you, I will work on a patch to fix it.
> > 
> > I'd rather drop the commit in question and feel free to submit a
> > correct patch for the device refcount balancing.
> 
> I have just submitted a new patch addressing this issue. Please review it
> and apply it if it seems valid after reverting the original patch. If you
> prefer that I send a separate patch to revert the original one, please let
> me know.

No one sent a revert patch.  We were hoping that you would handle that.

regards,
dan carpenter


