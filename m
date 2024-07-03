Return-Path: <linux-pm+bounces-10562-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4FB926A64
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 23:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A2B0B235AA
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 21:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB725191F71;
	Wed,  3 Jul 2024 21:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bl7aOJib"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708C019067C
	for <linux-pm@vger.kernel.org>; Wed,  3 Jul 2024 21:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042639; cv=none; b=myjkNcfLnLCXw+tAzRXrdDmYBiUpkC6o35TZa3xy2x3/lkGaDDbqd6jR8qk0vX4KlBq+eAqqlxRK7ToFhMOG6WeHW9S1YyejfIfrQ5vFp/KV/4ExvF44WSAr8Sp6lfW7ySrMteujJhxmoZmftMSztLQWZeDxjp8uMmjFRtQS4Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042639; c=relaxed/simple;
	bh=aGY4JJ7NrcVaIcFo1rEJ2jw8kYcxyHDAh/LTsW7tpVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prtL1TD/O1xWgw9mUt2bAKLaSRW2h1H7glrufn/MmqPtqjdYonKmXGRoozOQ1aMl2qhYchrtLaGwDn+lgaLCOlJk+NA8Vzcmp/fqRD3NrqZgAkWchvi86dGxh7MU6tjhvS6ZB9EUyzGewszEwuwUCWOo1Hk3dULEOn8827apgdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bl7aOJib; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fb2936c4ccso64755ad.0
        for <linux-pm@vger.kernel.org>; Wed, 03 Jul 2024 14:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720042638; x=1720647438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SsKaNV/QilXxMlGWjE5Y3ek6SYClBFD1a8IKmwgCqHo=;
        b=bl7aOJib/kMeZNWV9lLXsyCAuoFjHsPs6AGqKEet82Zl3CPEAGa49Z3ijfMThZ57wO
         QGqqm6Djl/4IrWhRI6exTgKqlKQTvwWOVQ8hT7efn6PBwNaHTtimtPzzgLnViiXbfj/M
         EmLE3IsDGPoBKmr7Hy0i0nDGfUYDZU0hlyMI9LlJ1XuyN7yXJMYPrAJYVkI2pXopUHiv
         UqdQ2McYWIeQKBq4hQk23olETn/bgMQOEXFJsbOLtXk2nTUjrup5T79+ddp1bkNqVmrS
         1RaSGbeUFZkNZGDOyTTrryT+8AJYndInCAERyo45bFbzlQgtfj85nXPAT5L3zj75jnPd
         jqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720042638; x=1720647438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SsKaNV/QilXxMlGWjE5Y3ek6SYClBFD1a8IKmwgCqHo=;
        b=fA07YS8cvS0YuhLnq0TcNoJhZmcRMZpQVmlnQ4psGylQpKqZYfWO5hoXPXvHXehlot
         RfeZFyktN86KnnJunZ6lz7phx7zrMcM4Tjd4JsPm+o1+xv1G9MQ9KXScyJhg/ABvt+j0
         91wKxM84UZcVPIsCVyqQv4nT6D9QtrlBZFvwQDc4hJ81WHboqe80NxgCTn/sCRwZGlII
         ESFIhVOqbcBOB+twhGxOrVDf9PSMVBTRK/HQilWExxmd7Vf/915HAAznjxDM5Aks9o0q
         n0Z7xdTLhgal2QnJwSx1hYY9D05YOOLoW7a4wtrywd4Vc1cOhXUxAsrP0Gqs9phVHmeW
         xIag==
X-Forwarded-Encrypted: i=1; AJvYcCWWBvACDnBPz2akgGAximiUM3kN5Hld1apQyLKscRarxMDeyk+Rcuvx3I4kbFe94QsnWOjYBMb505XW56ttDwhhW4BKGHRefGA=
X-Gm-Message-State: AOJu0YxtI3Yy5ZEDzLb6bhVSUxWZ81GImQQj0cFym1HFnlULRL2o/h1g
	6HBUmyAbezQDI78LCsZ+TPqYlBPbRMMcrjd4id/nU8/b7umGY7CcOUpoL1O2ng==
X-Google-Smtp-Source: AGHT+IGTqTsZmzhyrTz3vvsHq/xKinAvJI6+Jy3C2I+ajzgYv53kM/TvqnJdQuzeWnds72lFvTmrSA==
X-Received: by 2002:a17:903:64d:b0:1f6:3a2e:f6c6 with SMTP id d9443c01a7336-1fb3267301bmr243515ad.21.1720042637262;
        Wed, 03 Jul 2024 14:37:17 -0700 (PDT)
Received: from google.com ([2620:15c:2d:3:77ce:79b0:1f72:f91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91d3e7fe9sm11266858a91.50.2024.07.03.14.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:37:16 -0700 (PDT)
Date: Wed, 3 Jul 2024 14:37:12 -0700
From: Isaac Manjarres <isaacmanjarres@google.com>
To: Mateusz Guzik <mjguzik@gmail.com>
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
Message-ID: <ZoXEiCvdNRr_tj2N@google.com>
References: <20240606172813.2755930-1-isaacmanjarres@google.com>
 <4x5wsktkcwt7einzjowricl27pzusx6ggls43zionql7ixi5cz@icbegmuqqxcl>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4x5wsktkcwt7einzjowricl27pzusx6ggls43zionql7ixi5cz@icbegmuqqxcl>

On Tue, Jun 25, 2024 at 07:58:43PM +0200, Mateusz Guzik wrote:
> On Thu, Jun 06, 2024 at 10:28:11AM -0700, Isaac J. Manjarres wrote:
> > +static atomic_t wakesource_create_id  = ATOMIC_INIT(0);
> >  static const struct file_operations eventpoll_fops;
> >  
> >  static inline int is_file_epoll(struct file *f)
> > @@ -1545,15 +1546,21 @@ static int ep_create_wakeup_source(struct epitem *epi)
> >  {
> >  	struct name_snapshot n;
> >  	struct wakeup_source *ws;
> > +	pid_t task_pid;
> > +	int id;
> > +
> > +	task_pid = task_pid_nr(current);
> >  
> >  	if (!epi->ep->ws) {
> > -		epi->ep->ws = wakeup_source_register(NULL, "eventpoll");
> > +		id = atomic_inc_return(&wakesource_create_id);
> > +		epi->ep->ws = wakeup_source_register(NULL, "epoll:%d:%d", id, task_pid);
> 
> How often does this execute? Is it at most once per task lifespan?
Thank you for your feedback! This can execute multiple times throughout
a task's lifespan. However, I haven't seen it execute that often.

> The var probably wants to be annotated with ____cacheline_aligned_in_smp
> so that it does not accidentally mess with other stuff.
> 
> I am assuming there is no constant traffic on it.
Right, I don't see much traffic on it. Can you please elaborate a bit
more on what interaction you're concerned with here? If it's a
concern about false sharing, I'm worried that we may be prematurely
optimizing this.

--Isaac

