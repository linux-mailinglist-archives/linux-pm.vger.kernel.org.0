Return-Path: <linux-pm+bounces-22287-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9F3A392EF
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 06:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB7B016E284
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 05:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F771B6D0A;
	Tue, 18 Feb 2025 05:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CZ9x+v4b"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C2F1A5B8E
	for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 05:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857552; cv=none; b=NsEu4Way70em2vuCigjZdWtfeN9wyO415f2Ceib5/NqrjCo1Ngf4yZj87WhjcnmZOpzCkeEud3FgBLOvwp8ydYxmMNP/+9h9xl6sqi+Tuh4M3zy9qpopT6Nrek4ipgxRI0Ant6eUXWMpidSy7oAw9xWJ/zkUnqBBeQ86nxpnJ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857552; c=relaxed/simple;
	bh=L+HA70TVZSbeMdYskL8kC42n8szwtVtfysFxmDVHkKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTVOPsfQHwiNzshKGE8QOY7BXjXpolOyL8bDUKD0ywPhXMDO3Q5/6O3upyaLEHf1hNcyrKhd8DNqHrH1q9zTaKtZ5GhxZcSe3CbBiKyB7LRRHHRgf8TkpupHKidckFsuUN/AlvDeOYwmr9MX3c2ix50SrcuYY6dc/b4Htn7tYMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CZ9x+v4b; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220e83d65e5so77002175ad.1
        for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 21:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739857550; x=1740462350; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P3fYbERtYWIWV5Ldhm0+1AIYnN3OdcFMhdr4MubLhJ4=;
        b=CZ9x+v4bhPl2367Q/xYnwaa+zEHVu9bRrRQ20rGyPNm0lXvfYhm4RvY9zkjkI0lUKu
         N3wXvTiJJ5BT+19jK7ArVbH1BAzTgenn8OaVdrG0ofb4TViOpxmzjzojVOEGI/rHYlmX
         orsBKpUh61KMp470Ex7cbmt4OScB9+J8B6/iYHWcYXu1vVPUJWh6lQMPujlfgBR0d13V
         /FSv6sPDn4H5BwC9EvCiRNnikpV1QyJBAy0YHp4LKIOl1rWT8KC9Gx8o+U6yH837dDRe
         98sgVzzbEV3izV758Z2IZnV+1EIo7TPjaxKJEAA5RTaGKO1csnoCXEXQiDleWXZ/k7hr
         GU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739857550; x=1740462350;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P3fYbERtYWIWV5Ldhm0+1AIYnN3OdcFMhdr4MubLhJ4=;
        b=cflblADAGn3QWzkK1/eZV0P8yLjg8FfT/73RmWbfSD4JP1Vd6tH+0l8B2+5LntOkS+
         DEd4KY+YA+eqPVXaO+tBa2DDmgvn7oApwT+5f5yoB4lixhdjOFmIsyaE6bwry/ujcZC3
         YfoQNuB+zYmUz7m0/wXE+I70HTTPbmWcR4TcyArINLQ582MYBMVMIcDcKlnCy0/GSAjf
         Bn/FHsEWWFy2z53cOBamzwaxTqhKjaNVaTJQ8vakMCOf7HPgZS6sRlOdF//bXNfAIRJ3
         bK+2CyciixiYqfn9TMCg6oj6sG2Eo6LHJpXnqkCnbNmMG1SoHytIL5f6zZnBdbqEa4wN
         dadQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcEeqAnoDxeg/c9etCbJHrAYs+bTCOgpC6sXNoajusryu1FJakI7Ma1qeZw8xc/EFjQ6N8T6PNZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCSBUHM6d137Fv2L48LEA+B0G+rhXcQCKks5M78bDB9IFkMdvN
	G+1Enlt+VcPPqmnWjKK+gp8EOhxROTuQpviTwI7X1rtcyeSsNHuaS05W2UG6oQ==
X-Gm-Gg: ASbGncvEu0FEeQ8qqoRjHbZwrVdmDC7HRExmQ0mtCD6qAH4ugFYo5w/tUwvBqFpyvKn
	nJp4LntuIwsECg5jqrfmkdQNZOjRRnD0YOMEbG+Ibea0fopSR3TKGzv4t6/ZJ19Y20lhjKpXQ/G
	b1B3RtS9pMmwizbkXhv1+N3lgwGoPHK8p+P1iE9zMglUrEOw64B9Q2hKYCSaaWi4kRg36xF/SCd
	M40MZlisIvhcDHCZMall373Ajs4+wpJbyFyblnqtjeMx4r0ExNr6RF20DSlo1PJPwQgAiR0FQ0W
	AtCOV5zEUeVrT5PI1XJJcG+mIdPqZfvemiruUIlLCZ0CAyBq/94qhGCOdg==
X-Google-Smtp-Source: AGHT+IH9mb67E80iE2dKITP866mfonSNY51J7MjFAaydvKRMhKMf5Uoax7tn4nwC3ALthMBo2i5EMw==
X-Received: by 2002:a05:6a21:b93:b0:1ee:cdd1:2fdd with SMTP id adf61e73a8af0-1eecdd14f01mr48697637.16.1739857549554;
        Mon, 17 Feb 2025 21:45:49 -0800 (PST)
Received: from google.com (49.156.143.34.bc.googleusercontent.com. [34.143.156.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242546301sm9261922b3a.33.2025.02.17.21.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 21:45:49 -0800 (PST)
Date: Tue, 18 Feb 2025 11:15:40 +0530
From: Ajay Agarwal <ajayagarwal@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Brian Norris <briannorris@google.com>, Oliver Neukum <oneukum@suse.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Joy Chakraborty <joychakr@google.com>,
	Vamshi Gajjela <vamshigajjela@google.com>,
	Manu Gautam <manugautam@google.com>
Subject: Re: PM runtime_error handling missing in many drivers?
Message-ID: <Z7QehEhw3uM176tW@google.com>
References: <1937b65c-36c0-5475-c745-d7285d1a6e25@suse.com>
 <CAJZ5v0j0mgOcfKXRzyx12EX8CYLzowXrM8DGCH9XvQGnRNv0iw@mail.gmail.com>
 <5c37ee19-fe2c-fb22-63a2-638e3dab8f7a@suse.com>
 <CAJZ5v0ijy4FG84xk_n8gxR_jS0xao246eVbnFj-dXzwz=8S9NQ@mail.gmail.com>
 <Z6lzWfGbpa7jN1QD@google.com>
 <Z6vNV8dDDPdWUKLS@google.com>
 <CAJZ5v0i83eJWV_kvWxZvja+Js3tKbrwZ8rVVGn7vR=0qLf1mtw@mail.gmail.com>
 <Z7Kx2RN35QVyg8nP@google.com>
 <CAJZ5v0hom5Ex9xCfd_qD7XyFxie1iy2L_T8vDNWF-xBMmq=9aQ@mail.gmail.com>
 <Z7QcjvKRGKgrI8EC@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7QcjvKRGKgrI8EC@google.com>

On Tue, Feb 18, 2025 at 11:07:19AM +0530, Ajay Agarwal wrote:
> On Mon, Feb 17, 2025 at 09:23:18PM +0100, Rafael J. Wysocki wrote:
> > On Mon, Feb 17, 2025 at 4:49 AM Ajay Agarwal <ajayagarwal@google.com> wrote:
> > >
> > > On Wed, Feb 12, 2025 at 08:29:34PM +0100, Rafael J. Wysocki wrote:
> > > > On Tue, Feb 11, 2025 at 11:21 PM Brian Norris <briannorris@google.com> wrote:
> > > > >
> > > > > Hi Ajay,
> > > > >
> > > > > On Mon, Feb 10, 2025 at 09:02:41AM +0530, Ajay Agarwal wrote:
> > > > > > On Wed, Jul 27, 2022 at 06:31:48PM +0200, Rafael J. Wysocki wrote:
> > > > > > > On Wed, Jul 27, 2022 at 10:08 AM Oliver Neukum <oneukum@suse.com> wrote:
> > > > > > > > On 26.07.22 17:41, Rafael J. Wysocki wrote:
> > > > > > > > > Well, in general suspending or resuming a device is a collaborative
> > > > > > > > > effort and if one of the pieces falls over, making it work again
> > > > > > > > > involves fixing up the failing piece and notifying the others that it
> > > > > > > > > is ready again.  However, that part isn't covered and I'm not sure if
> > > > > > > > > it can be covered in a sufficiently generic way.
> > > > > > > >
> > > > > > > > True. But that still cannot solve the question what is to be done
> > > > > > > > if error handling fails. Hence my proposal:
> > > > > > > > - record all failures
> > > > > > > > - heed the record only when suspending
> > > > > > >
> > > > > > > I guess that would boil down to moving the power.runtime_error update
> > > > > > > from rpm_callback() to rpm_suspend()?
> > > > > > Resuming this discussion. One of the ways the device drivers are
> > > > > > clearing the runtime_error flag is by calling pm_runtime_set_suspended
> > > > > > [1].
> > > >
> > > > I personally think that jumping on a 2.5 years old thread is not a
> > > > good idea.  It would be better to restate the problem statement and
> > > > provide the link to the previous discussion.
> > > >
> > > > > > To me, it feels weird that a device driver calls pm_runtime_set_suspended
> > > > > > if the runtime_resume() has failed. It should be implied that the device
> > > > > > is in suspended state if the resume failed.
> > > > > >
> > > > > > So how really should the runtime_error flag be cleared? Should there be
> > > > > > a new API exposed to device drivers for this? Or should we plan for it
> > > > > > in the framework itself?
> > > > >
> > > > > While the API naming is unclear, that's exactly what
> > > > > pm_runtime_set_suspended() is about. Personally, I find it nice when a
> > > > > driver adds the comment "clear runtime_error flag", because otherwise
> > > > > it's not really obvious why a driver has to take care of "suspending"
> > > > > after a failed resume. But that's not the biggest question here, IMO.
> > > > >
> > > > > The real reson I pointed you at this thread was because I think it's
> > > > > useful to pursue the proposal above: to avoid setting a persistent
> > > > > "runtime_error" for resume failures. This seems to just create a pitfall
> > > > > for clients, as asked by Vincent and Oliver upthread.
> > > > >
> > > > > And along this line, there are relatively few drivers that actually
> > > > > bother to reset this error flag ever (e.g., commit f2bc2afe34c1
> > > > > ("accel/ivpu: Clear runtime_error after pm_runtime_resume_and_get()
> > > > > fails")).
> > > > >
> > > > > So to me, we should simply answer Rafael's question:
> > > > >
> > > > > (repeated:)
> > > > > > > I guess that would boil down to moving the power.runtime_error update
> > > > > > > from rpm_callback() to rpm_suspend()?
> > > > >
> > > > > Yes, I think so. (Although I'm not sure if this leaves undesirable spam
> > > > > where persistent .runtime_resume() failures occur.)
> > > > >
> > > > > ...and then write/test/submit such a patch, provided it achieves the
> > > > > desired results.
> > > > >
> > > > > Unless of course one of the thread participants here has some other
> > > > > update in the intervening 2.5 years, or if Rafael was simply asking the
> > > > > above rhetorically, and wasn't actually interested in fielding such a
> > > > > change.
> > > >
> > > > The reason why runtime_error is there is to prevent runtime PM
> > > > callbacks from being run until something is done about the error,
> > > > under the assumption that running them in that case may make the
> > > > problem worse.
> > > >
> > > > I'm not sure if I see a substantial difference between suspend and
> > > > resume in that respect: If any of them fails, the state of the device
> > > > is kind of unstable.  In particular, if resume fails and the device
> > > > doesn't actually resume, something needs to be done about it or it
> > > > just becomes unusable.
> > > >
> > > > Now, the way of clearing the error may not be super-convenient, which
> > > > was a bit hard to figure out upfront, so I'm not against making any
> > > > changes as long as there are sufficient reasons for making them.
> > >
> > > I am thinking if we can start with a change to not check runtime_error
> > > in rpm_resume, and let it go through even if the previous rpm_resume
> > > attempt failed. Something like this:
> > >
> > > ```
> > > static int rpm_resume(struct device *dev, int rpmflags)
> > >         trace_rpm_resume(dev, rpmflags);
> > >
> > >   repeat:
> > > -       if (dev->power.runtime_error) {
> > > -               retval = -EINVAL;
> > > -       } else if (dev->power.disable_depth > 0) {
> > > +       if (dev->power.disable_depth > 0) {
> > >                 if (dev->power.runtime_status == RPM_ACTIVE &&
> > >                     dev->power.last_status == RPM_ACTIVE)
> > >                         retval = 1;
> > > ```
> > >
> > > I think setting the runtime_error in rpm_callback, i.e. for both resume
> > > and suspend is still a good idea for book-keeping purposes, e.g. the
> > > user reading the runtime_status of the device from sysfs.
> > 
> > What would be the benefit of this change?
> The benefit would be that the runtime_resume would be re-attempted even if
> the previous attempt failed.
Actually, I wanted to propose the removal of `runtime_error` flag
completely from the code. But it sounded too disruptive to me. Hence, I
proposed the milder patch of removal of `runtime_error` check from
rpm_resume so that the drivers do not have to call
`pm_runtime_set_suspended` explicitly.

Basically, we still do not have a good solution for the situation where
one of the ancestors fails to resume. We do not know how to make the
ancestor working again. But I guess a re-attempt is better than not
doing anything about it?

