Return-Path: <linux-pm+bounces-33594-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC8FB3F27A
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 04:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BEC3189E132
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 02:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2F62DECB4;
	Tue,  2 Sep 2025 02:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="UNtW6m5l"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D166FC3
	for <linux-pm@vger.kernel.org>; Tue,  2 Sep 2025 02:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756780899; cv=none; b=LoMdSKJSmvzO1e/V9k2gaOJzYVZIp12nWg0GY0Ty5JFmFj/HxS+o/TPIxwTS2j0j/8SjOGrjNINRnxamnTVzIbU8x4CjUdFT9KnL+s8kM/l006KBz7bu+Ung1JRKQti9PaYX2Et6+mDVCjYa9slM2Ws35zzJx1s/rYYIjMDMEqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756780899; c=relaxed/simple;
	bh=cliUwr/BqV8Jj3ASMnnWECpyPQX0+Z1jg4U/YeW3IAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJVDC5sNjvnA/Hm8EewRo2t1krb1IHrP8jqPmg9cYX9t5IyGfOezon36axX9zAHngq+DebuKadVbjUfvcYEkEV+H5YmVbJ56MZVyjuKFNjEbFufP1e8my6YVo/aFooKIiKJO6RzaWuFfT43wvD8ddght7EUeg8yg8IylvPGWsUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=UNtW6m5l; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7f722cb35fdso422138685a.3
        for <linux-pm@vger.kernel.org>; Mon, 01 Sep 2025 19:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1756780896; x=1757385696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Enuy41nwZCcQ9zOdmE9e02q6xzYJW1G0wWmqMhJZXMk=;
        b=UNtW6m5lj1yl6NVQFu/I6RiQEN4wlipqid+O32WQTvmuXMfTUHGepv55FXMCyehr0+
         BUCGK7IinpNBj0x6APdlSkIul1RmOXiLhN7zFw3h7+ITb1tf9Gp9GrRlfbfDn1D7OlGd
         XiBIf/on8wDptiG5yL973Cm2c6yBogpGFswXDxPCSeTqnA5YEzxLRfOEJTPskC050bvW
         7+cnqCZomwfjIvRLOJmpRmo+ReHb0gp6yrCfQgzciM6ZvWL37QDOt8IVz2wonmnk6nDB
         VDX1VoxRazQnRmxKetnlBc6f9iUI8NvFlJfrek6Sxsf5iSmbxE4nNImCCtyNwTisZA4L
         p6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756780896; x=1757385696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Enuy41nwZCcQ9zOdmE9e02q6xzYJW1G0wWmqMhJZXMk=;
        b=hv38IWLrUbBDz9kGQpwpODtgta6KWWGDN4ucrHzQZ5ddOwXvUsIjAmqm9MiZmKeWjL
         jeB92TEgIj6L3WxEZgBOHqgM3AGF1mq+ZSR+xUBflfCO4yN1GM/tACOpztKL15hCdgoc
         ol8/X+3vrieq6t6ucSzVWyUF7GXSG2fcCwcIQErssbPw+0NY+hGm1gDt6nC70wpTUGVg
         wD1A02yxSdtmUTuuSe1xG6a96sNk/pydG8zKrvmj+eqVgVSW8ZN+f/7ZpV+WMVEx/GBr
         3w19Z2I4O34q1/Nv8lfug8/NTstgLSzKLtPpb9w5PSMOrRSW0JzFgeX0TB1ngNMZSwcv
         cjDw==
X-Forwarded-Encrypted: i=1; AJvYcCW14uR0PtNbPkI4VU3WlgHJzYkC2ado4PxYRzgQfZ1IbzU5fzTDhvfFwMZG9xhIlHdvVN2YzlYoyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwN81z9ZQJ7HR0kPwGErF4MIUFFx8Qe1SDAUiSY9dO6y3hqXz1c
	/RKhGIRmuIgFl7LmCdYQP3itn2YJ0RWsJGaB9cjNAriN50D3uhDEScFyfG8B5ZjgOQ==
X-Gm-Gg: ASbGncudPWrHrc0XQRjAY102yhZRgumZd86tOsgNIxza0SznhrXhzYpYAye3nIKBkKm
	/sTb7Rf2z0NOFDqlhEMk9CA7RpKrjBbDLL1SS6bN+IbsDjBorx3maqdMoAu2JBb4AFQh2Ljec2F
	D1DPefKEjH6NsnyrEbepLDM27dcVTP3fRXQecPZ+GWs43ZRzBXx938fZOveUju+s15uCiP9hg/q
	eW3XrJu3c0q1a7RCrtQgtZ1Nq0Z9rpE0ROyOQmJmNe0pZ6y1GOJl4dDUuf4eI+cdDTc/VAQDPOd
	lAubPnzZRtNixJ+qfFBtK38IeW2ww66lO8OmB6wXR+rpYKBEb7Ds+UOw0ojFFHpepzvr7YomMFX
	10bSx5dEZ5atpIqF88eUAxb48SG/wp9pl4WURz/ahP+UsS7O/vDw=
X-Google-Smtp-Source: AGHT+IEfGRzkAZoJGulJoHViWTZWxO98WsvX1GNg/acRhZQU9F+ZFNkV87Dz1dLl6TBxLDnLIyPHCw==
X-Received: by 2002:a05:620a:700c:b0:7e8:12c1:12c2 with SMTP id af79cd13be357-7ff282c764dmr1013796185a.34.1756780896276;
        Mon, 01 Sep 2025 19:41:36 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::f777])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8069c1524cfsm62575685a.43.2025.09.01.19.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 19:41:35 -0700 (PDT)
Date: Mon, 1 Sep 2025 22:41:32 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	ryan zhou <ryanzhou54@gmail.com>, Roy Luo <royluo@google.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] drvier: usb: dwc3: Fix runtime PM trying to activate
 child device xxx.dwc3 but parent is not active
Message-ID: <38b706cc-5966-4766-9165-51935fdcd790@rowland.harvard.edu>
References: <CA+zupgwnbt=5Oh28Chco=YNt9WwKzi2J+0hQ04nqyZG_7WUAYg@mail.gmail.com>
 <CAPwe5RMpdG1ziRAwDhqkxuzHX0x=SdFQRFUbPCVuir1OgE90YQ@mail.gmail.com>
 <5d692b81-6f58-4e86-9cb0-ede69a09d799@rowland.harvard.edu>
 <CAJZ5v0jQpQjfU5YCDbfdsJNV=6XWD=PyazGC3JykJVdEX3hQ2Q@mail.gmail.com>
 <20250829004312.5fw5jxj2gpft75nx@synopsys.com>
 <e3b5a026-fe08-4b7e-acd1-e78a88c5f59c@rowland.harvard.edu>
 <CAJZ5v0gwBvC-y0fgWLMCkKdd=wpXs2msf5HCFaXkc1HbRfhNsg@mail.gmail.com>
 <f8965cfe-de9a-439c-84e3-63da066aa74f@rowland.harvard.edu>
 <CAJZ5v0g9nip2KUs2hoa7yMMAow-WsS-4EYX6FvEbpRFw10C2wQ@mail.gmail.com>
 <CAJZ5v0gzFWW6roYTjUFeL2Tt8kKJ_g5Q=tp2=s87dy05x-Hvww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gzFWW6roYTjUFeL2Tt8kKJ_g5Q=tp2=s87dy05x-Hvww@mail.gmail.com>

On Mon, Sep 01, 2025 at 10:40:25PM +0200, Rafael J. Wysocki wrote:
> Of course, the driver of B may also choose to leave the device in
> runtime suspend in its system resume callback.  This requires checking
> the runtime PM status of the device upfront, but the driver needs to
> do that anyway in order to leave the device in runtime suspend during
> system suspend, so it can record the fact that the device has been
> left in runtime suspend.  That record can be used later during system
> resume.

As a general rule, I think this is by default the best approach.  That 
is, since B was in runtime suspend before the system sleep, you should 
just keep it in runtime suspend after the system sleep unless you have 
some good reason not to.  In other words, strive to leave the entire 
system in the same state that it started in, as near as possible.

One good reason not to would obviously be if B is the source of a wakeup 
signal...

> The kind of tricky aspect of this is when the device triggers a system
> wakeup by generating a wakeup signal.  In that case, it is probably
> better to resume it during system resume, but the driver should know
> that it is the case (it has access to the device's registers after
> all).

Not necessarily.  Suppose that C is a child of B, and C is the wakeup 
source.  B's driver might decide to keep B in runtime suspend 
since B wasn't the wakeup source -- but then C's driver would have to 
make the same decision and would not have access to C's registers.

>  It may, for example, use runtime_resume() for resuming the
> device (and its parent etc) then.

Consider this as a possible heuristic for B's ->resume callback, in the 
case where B was in runtime suspend throughout the system sleep:

	If B's parent A is not in runtime suspend, test whether B
	has a wakeup signal pending.  If it does, do a runtime
	resume.  If not (or if A is in runtime suspend), leave B
	in runtime suspend.

At first glance I think that will work fairly well.  Even if B is kept 
in runtime suspend when it shouldn't be, the normal runtime wakeup 
signalling mechanism should kick in without too much of a delay.

The big problem is that this issue applies to all subsystems and 
devices.  It would be better if we had a uniform solution that could be 
implemented in the PM core, not in every single subsystem or device 
driver.

Here's another possibility, one that can be implemented in the PM core 
during the ->resume, ->resume_early, or ->resume_noirq phase of system 
wakeup:

	If A and B are both in runtime suspend, do not invoke B's
	->resume callback.  (Or maybe don't invoke it if A's ->resume
	callback wasn't invoked.)

There probably are some detailed reasons why that won't always work, but 
maybe you figure out something like it that will be okay.

Alan Stern

