Return-Path: <linux-pm+bounces-10896-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C807292C51C
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 23:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D841C21C35
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 21:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AF618004E;
	Tue,  9 Jul 2024 21:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="omruXFHX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B0D14D2A7
	for <linux-pm@vger.kernel.org>; Tue,  9 Jul 2024 21:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720559091; cv=none; b=lXJwlmHFBS9wJareUQ0RtT6wgSj4hgwO1KQjvkT0Hz3OGionQCCMihLVXP4vo5ic0fhHIrjWWkvFwYcbmEXvnaA6aYyAOYI526oRHtka8sp3Js0oE+mv2FwByY9RABx0vZ3eukcEGHWCj+W2nqAnmbtAdyxj8hlNsqMQ+GANurU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720559091; c=relaxed/simple;
	bh=pQuWpDrDEaCFl7ELhP2pM9jtryDd25mq43Dk6pVulGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frh2G7S5WG698vSDqN8MSJS8SXibDBWkMfnlLDMPPC7Mc6HVVGYaP064sWOu95adl22ZHNXIXNDSefyZ82OdxYPaRRWBsOk+gJmTr2bNli/EJWb5Dg3OCYSSY4UaIR0bba+Hrqy6n73nZY87TdB7Ms+GxnG9keJ9ClFwrGzH7n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=omruXFHX; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fb10519ae3so19745ad.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Jul 2024 14:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720559089; x=1721163889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yOZEUf/J6siPzygu395P3D/gjZTzmsga/ioXaj0U6JM=;
        b=omruXFHXUBjKOYPm3rt8AQhwbj75vzdL377WHBGIif0PTZs4fLUSGT9AlbUjRc8Chu
         2SNI9PSWAj93mB3WljCJjgcFvfw+Mh2AouEa3bh46rpERpP4JiRBqVD3ANcN5amxlTys
         jGsRCrf21Ggnda7ziRQK6mUUcZ3eeR0sMalKZRJppAiR9MwVC8nOvCAjJS0xO07ngMd5
         czA3bSveOHOWU35domkKi70Qslp4/29Qo1wntovCrGdT0ImkE0v/XMBRP8/nJ5dAHYDv
         y8qVin6pN25B0tN3cmpyWy9lEPsqND+ovCg1O5MUvVpigSLAJzgtpP5QLGnj7Mlz3tN8
         p0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720559089; x=1721163889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOZEUf/J6siPzygu395P3D/gjZTzmsga/ioXaj0U6JM=;
        b=pjwwXWyJqOcIlXkdHQDYGEnG5LiktnpqBvHcfyj+RMuw1Kyh9xGmmqFERjMW1FvTEn
         32w4c4is8z6URmhq4cv7XigSj5f5VzsZxZpLCojBslL3jG5SX+hwyBNOgJOqbgoNqlCQ
         AZtfYrWe5WHmzHEIz4IW0DDBq911o6gAuxuXVkHpv4DeZyhZf9CrNjv9EcC4/nsERFso
         hEn5SIn7MmbEA8Q87dy2xG3G8Nq1KS5s6yXzYxfAzlUP2Hu8W/xkhI1ktBOHgl29oxHA
         PYZGfu+wDsw60c+Wiy64mCKLSmpX/n5b42Hq3tMnQdemqPLvUvt9ZWGgqLPi61eSR/fT
         BpZA==
X-Forwarded-Encrypted: i=1; AJvYcCVeVa0NXxZ0F+z2z1bc4Dg3DPi7W0SIXm57h+XqlELY+JIZIJmQlLu2XETnDWRc0Su61FV0mBwvmG89snAYSE3yzdflfOelzZs=
X-Gm-Message-State: AOJu0YzJENYv8yaF2nKN70iZvxdZKEym4uWnfm9H8+DfrSt/poLz3Mu1
	Vfgjzurp0AkFSzKcNFovaACGU1cpMxKg8iVAMXdUw6kTESG3Gj2ui0+Kxp8now==
X-Google-Smtp-Source: AGHT+IGZUitn76mfCM9EnzN6heABLFA1iE9kZnxKb2TuoqafSIshuqFsZaMjvSrHhwGNWXnqfTBkog==
X-Received: by 2002:a17:903:2003:b0:1f7:34e4:ebc1 with SMTP id d9443c01a7336-1fbce1391d4mr234535ad.5.1720559088778;
        Tue, 09 Jul 2024 14:04:48 -0700 (PDT)
Received: from google.com ([2620:15c:2d:3:e5ff:5d06:df02:cdba])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a122cfsm21086945ad.5.2024.07.09.14.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 14:04:48 -0700 (PDT)
Date: Tue, 9 Jul 2024 14:04:43 -0700
From: Isaac Manjarres <isaacmanjarres@google.com>
To: Christian Brauner <brauner@kernel.org>
Cc: tglx@linutronix.de, jstultz@google.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	saravanak@google.com, mjguzik@gmail.com,
	Manish Varma <varmam@google.com>,
	Kelly Rossmoyer <krossmo@google.com>, kernel-team@android.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6] fs: Improve eventpoll logging to stop indicting
 timerfd
Message-ID: <Zo2l65cTwuSMDU-Z@google.com>
References: <20240703214315.454407-1-isaacmanjarres@google.com>
 <20240704-umsatz-drollig-38db6b84da7b@brauner>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704-umsatz-drollig-38db6b84da7b@brauner>

On Thu, Jul 04, 2024 at 04:03:59PM +0200, Christian Brauner wrote:
> On Wed, Jul 03, 2024 at 02:43:14PM GMT, Isaac J. Manjarres wrote:
> > From: Manish Varma <varmam@google.com>
> > 
> > We'll often see aborted suspend operations that look like:
> > 
> >  PM: suspend entry 2024-07-03 15:55:15.372419634 UTC
> >  PM: PM: Pending Wakeup Sources: [timerfd]
> >  Abort: Pending Wakeup Sources: [timerfd]
> >  PM: suspend exit 2024-07-03 15:55:15.445281857 UTC
> > 
> > From this, it seems a timerfd caused the abort, but that can be
> > confusing, as timerfds don't create wakeup sources. However,
> > eventpoll can, and when it does, it names them after the underlying
> > file descriptor. Unfortunately, all the file descriptors are called
> > "[timerfd]", and a system may have many timerfds, so this isn't very
> > useful to debug what's going on to cause the suspend to abort.
> > 
> > To improve this, change the way eventpoll wakeup sources are named:
> > 
> > 1) The top-level per-process eventpoll wakeup source is now named
> > "epollN:P" (instead of just "eventpoll"), where N is a unique ID token,
> > and P is the PID of the creating process.
> > 
> > 2) Individual eventpoll item wakeup sources are now named
> > "epollitemN:P.F", where N is a unique ID token, P is PID of the creating
> > process, and F is the name of the underlying file descriptor.
> 
> Fyi, that PID is meaningless or even actively misleading in the face of
> pid namespaces. And since such wakeups seem to be registered in sysfs
> globally they are visible to all containers. That means a container will
> now see some timerfd wakeup source with a PID that might just accidently
> correspond to a process inside the container. Which in turn also means
Thanks for your feedback on this, Christian. With regards to this
scenario: would it be useful to use a namespace ID, along with the PID,
to uniquely identify the process? If not, do you have a suggestion for
this?

I understand that the proposed naming scheme has a chance of causing
collisions, however, it is still an improvement over the existing
naming scheme in terms of being able to attribute wakeups to a
particular application.

> you're leaking the info about the creating process into the container.
> IOW, if PID 1 ends up registering some wakeup source the container gets
> to know about it.
Is there a general security concern about this? If not, can you please
elaborate why this is a problem?

Thanks,
Isaac

