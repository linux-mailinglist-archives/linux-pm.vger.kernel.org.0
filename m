Return-Path: <linux-pm+bounces-9965-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1B6916F79
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 19:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7021E1C25327
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 17:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7BB17555C;
	Tue, 25 Jun 2024 17:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W/OYHY+F"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF24016F82A
	for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2024 17:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337429; cv=none; b=fWwcIvi2b1wSIm+Ch8ngjXnPIcLDGspvl6dSqBa8KDVkUyCqXyMGcfy0X4THzKQH+dLmatPPt1FXYauUZFBUoFsFpUUzqJJLG08i+6Fs6kl/krn90hyfh1aK9fsd5LitrMyLNjnSU+U6+lKJUfJJJ89kUUBN5CsZzQFunwopHTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337429; c=relaxed/simple;
	bh=5VgSZVq02U6IsfJaYVV8DFuJwm1vUyaN05VICVFOxus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCMNa1eyvgUVpwdhKN0iqaDOFl4eA5JdG/1GR5U+l9DJ8DV2o+LVM0m905OUFJpaLjQ0RVdjCibJQ3QGyQFCpi34WIIfRbv7+7KTSCDX5iKFH0+buQY7nu5P/2s+gKvYDEak39cvF4RGuo28usmXNzfZU2c9cvoUEoIAwHpb1b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W/OYHY+F; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f991bb9fb8so15325ad.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2024 10:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719337427; x=1719942227; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4NkneRAeqFnNlsteKCtsOu3L6FUBOoIj11zyXycSDMA=;
        b=W/OYHY+FqOuGsUAAM/lAWLh82jL8pplO7SJnUwwrO5+kVHVMmM+qm1p0l/ljd52Tjr
         sapjoSSvANCNt13dUiMSMmpURFAWKTHL0/eackqcJ5vm31hhOZ1WcbOcaKwAg1nUQOM2
         N1A91yG5/2ThGzxAToDfafgeHDt8+cGHwTAxIb4+xXiaRzeTO+TiSavGywEsWYrP8GG5
         DpdWAwyyuRD6dqG2nTvI069vEr8suShUjKeyuxtkj4lG+aDid2BtndGi9pFpMOF2N0em
         es5rQfRY5O5lvrFryaerqqlmlWngtc1MK5jfFXTqkmEKX16BE0Rfc/YBiLMUmtx3eEHl
         +ZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719337427; x=1719942227;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4NkneRAeqFnNlsteKCtsOu3L6FUBOoIj11zyXycSDMA=;
        b=bptE2kthuB1mX1LjNhGyg9ne0V80Sz723VyZdsXCcB0QP19FA0zuzzjDMIUipvr/KK
         XApUN2EIY+ic4TinTOdAdBHSJcSG5TnKoDni6zvxluxsUfFVY5oGEPA8oma46Lmotbt9
         C5loy+cJVQVuPWmWzFwEaSvNS5i897YwMXyf4mPCRe2ZFMbxmniUAUxjQFZp4ejDMjnZ
         cpH+zPtbK0/4RaVgpRHKj8H4pAn+cQDVOOQRjNRgUETxAHKvJffLItdOrHn09/td6dxX
         L/i+KTKhvgf7R5SAYFG1trn24O4JRJoOeU3Ed855vHemYNakM/PLEfk/vKxi/UNOTKB6
         Lh8g==
X-Forwarded-Encrypted: i=1; AJvYcCWajSpiBB0xPxV8SNrEJp+w+BgorRBwmy6CoxAfXq5Nc5M1TP3/CZRNrVANz+2xo1lT8lwLsiqYSIBx0OSIAa6iVqFLZVzK7e0=
X-Gm-Message-State: AOJu0YxwPb78xYAoDslrOzVZwQsQj41KTxrlb9JLRBZa7Gt9v81+QY6a
	u6dTSOuVsSN7YxXVngOq1Alves1YU9to+77V2LD066CvNWL/V7oxyyccJxRDnA==
X-Google-Smtp-Source: AGHT+IE3GbbrPTfGHz1QMDfN5VvYW2z9EAbtcbC6WTIkswzUwNwFll/14uYbFQbRSRjJoZ445WDIng==
X-Received: by 2002:a17:902:fb90:b0:1f8:9300:5361 with SMTP id d9443c01a7336-1fa6cae64cemr3548585ad.27.1719337426194;
        Tue, 25 Jun 2024 10:43:46 -0700 (PDT)
Received: from google.com ([2620:15c:2d:3:9a90:b76f:c388:1248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3d5ad9sm84394175ad.204.2024.06.25.10.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 10:43:45 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:43:41 -0700
From: Isaac Manjarres <isaacmanjarres@google.com>
To: John Stultz <jstultz@google.com>
Cc: tglx@linutronix.de, "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	saravanak@google.com, Manish Varma <varmam@google.com>,
	Kelly Rossmoyer <krossmo@google.com>, kernel-team@android.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5] fs: Improve eventpoll logging to stop indicting
 timerfd
Message-ID: <ZnsBzfSPZlrhpB1t@google.com>
References: <20240606172813.2755930-1-isaacmanjarres@google.com>
 <CANDhNCqhJRLgvhAong-5zjsfwk2sL7pNbK0EqWsPcaA+AuzxDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCqhJRLgvhAong-5zjsfwk2sL7pNbK0EqWsPcaA+AuzxDQ@mail.gmail.com>

On Mon, Jun 24, 2024 at 11:03:43AM -0700, John Stultz wrote:
> On Thu, Jun 6, 2024 at 10:28 AM 'Isaac J. Manjarres' via kernel-team
> <kernel-team@android.com> wrote:
> >
> > From: Manish Varma <varmam@google.com>
> >
> > timerfd doesn't create any wakelocks, but eventpoll can.  When it does,
> > it names them after the underlying file descriptor, and since all
> > timerfd file descriptors are named "[timerfd]" (which saves memory on
> > systems like desktops with potentially many timerfd instances), all
> > wakesources created as a result of using the eventpoll-on-timerfd idiom
> > are called... "[timerfd]".
> >
> > However, it becomes impossible to tell which "[timerfd]" wakesource is
> > affliated with which process and hence troubleshooting is difficult.
> 
> While your explanation above is understandable, I feel like it might
> benefit from a more concrete example to show why this is problematic?
> It feels like the description gets into the weeds pretty quickly and
> makes it hard to understand the importance of the change.

> 
> Again the N:P.F mapping is clear, but maybe including a specific
> before and after example would help?
> 
> Additionally, once you have this better named wakesource, can you
> provide a specific example to illustrate a bit on how this
> specifically helps the troubleshooting that was difficult before?
> 
> thanks
> -john

Hi John,

Thanks for your feedback on this! I'm more than happy to add more
details to the commit text. I'll go ahead and add an example to
showcase a scenario where the proposed changes make debugging easier.

I'll send out v6 of the patch soon.

--Isaac

