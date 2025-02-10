Return-Path: <linux-pm+bounces-21618-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E5BA2E2CE
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 04:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BBAC165836
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 03:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C0635959;
	Mon, 10 Feb 2025 03:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xKn1TGDS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC25EEAF9
	for <linux-pm@vger.kernel.org>; Mon, 10 Feb 2025 03:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739158372; cv=none; b=C2onK1nQfbNCh0ykuPMYuEutJo+o+n0OfhG/rJIdCzS5GPsDzXD8vE8EECBLM2B3ypEkKp1ymNZ3uOxvjOaf9hHu3KT8HCZCqfLBgZ/d6v1IXKdeZ36OSo7Qrbr4s+FPkPTLcnS+pWycsCoMg+g//9P6n/oNQ7Wj/bmEr6QlQV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739158372; c=relaxed/simple;
	bh=jnnmj0WfzpeDrcbnj+h7NoyTOp/J35XvifKCDJfWDYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIRKC3Mb4Z2YxaTn4Og7uZLCgQMVOfKLW8aWYR20UyJxvwxx3Ce8bzc5Vn3vi7G+ZmqVqu9+t7chl7fH+e4OQn1bK7B5oXApH66uFdy1J1jjXqAoNRX2JZMWXbTil1kGrTfSb8fDhoply7x8s1Wn2l/VJU64/I/V/X0Au+CeCjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xKn1TGDS; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fa1e25e337so4345958a91.1
        for <linux-pm@vger.kernel.org>; Sun, 09 Feb 2025 19:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739158370; x=1739763170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rDphYiBK6zaLhzzhuS11hijH34kWZBXLf6tNFNwk8Fo=;
        b=xKn1TGDSGa3Y4X9H0nCrWEEnCn9w6ZpgoVjZATI9NyheLH3xESb5tLGtUpf9UAZ0aB
         5LzyYTkT615x0LWGDWSuUKsw5yRJryJwIS4vaSy+6eV8bR7dnGFYFt79AN2xlbkCEWde
         l8tyK8oZfru2cs+XH0G4x6CzxtOQEsWFAeanUeIH4rvsl8eqXeS6cH+fbv7ZKA3163hR
         u9GPzbqYk55OejW0KSyCl4tfnv3OK+wCppqTnWvDnoDm3eVv3NLuIzacY/H2rF1khEqx
         Wx1TMZipsXlzgWs1I0CXeNuG6KRjNl8pNkeFy+lJDAEcRuJoLKTxeJROPhPwPuSeOXp/
         /dNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739158370; x=1739763170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDphYiBK6zaLhzzhuS11hijH34kWZBXLf6tNFNwk8Fo=;
        b=fs52QvQBlV247+498t6hFngGvaaKQpSz36FuGKO+B8yh/2f2DyaDvfqrBximGDHOyG
         6922YzER30hW+p2A0vXsrit5qG/CFZWKnSU7UCokvTNVp1xsK1uin/NRsZ73AyXwMMWa
         ZhgKBckp2IIFdpHel6PQRG7ijTCXAB46QgPMcehYz8af0sp7zxGsG8C3W7TDgPMUpauh
         m1Ph8mzhbx53WU3pqEnP3Lf3+38HMJtgn2zFWZ/6iKOUCaiRY6n9oE+Je0rUmAFXizAj
         FxrQIRRigJId7lHIG4rbO0+fukeycgJVr75rdNyK1OjToZnbM9Vl1sgicGGfAgQSvO2b
         DjwA==
X-Forwarded-Encrypted: i=1; AJvYcCXBRQJeMZ6P7lWSQpyqzt1lAOaDQ5Uv6vUILQlPhaIaHRYrYALnUWy6Jha1AWayLo3HgnVIYkS8DA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5GqUu8f5y0DViHPRoaEoWkZauEbFlFWfSR886VUwQNMvk/HbD
	zWOpLAssV1HJpG5DV7lDlTkM89aBP5QAgLIo5QS8Y0GBb00q/JHn+NeUVJ19rA==
X-Gm-Gg: ASbGnctE+ow6pC0egi59WHbNLiy3cL5sXLSd4YkKo9RqZQPefoh+8ytzTqhD+H7EKai
	3Q7GZZqoQTOgRercdZ4CiaZWcZsWcCS7HpPW8peyCpnZKvYDZCHinne9M2jez3WPATP/isc4v+r
	5ZAb1E3CPVA7KVBVojQyQdTX789gyZmriFayL69I2057GUVNvULELObuznYi1xtqGAex6bx8SUT
	VOtSjgnmcumdYP8gkIVbax3Qapdfn5jjaj/EpPY27GOzDRxZxZdjZaLrC0tI21PZVvRLSQnv3ia
	JpkIdCuXnVCv2WX53UVtDxyWA7u9wIRyoe479kY9bQw4zx97fWgPj3XKZw==
X-Google-Smtp-Source: AGHT+IFjZyZ3ezW0s75YhMjc+3RWhwDMlBTzyIdX4ehs3aMkTRN964Frh+KixLFvEGShcSqs5iHgnQ==
X-Received: by 2002:a17:90b:1d52:b0:2fa:137f:5c5c with SMTP id 98e67ed59e1d1-2fa23f44beemr16953451a91.1.1739158369742;
        Sun, 09 Feb 2025 19:32:49 -0800 (PST)
Received: from google.com (49.156.143.34.bc.googleusercontent.com. [34.143.156.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa15ab5b26sm6767278a91.20.2025.02.09.19.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 19:32:49 -0800 (PST)
Date: Mon, 10 Feb 2025 09:02:41 +0530
From: Ajay Agarwal <ajayagarwal@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Oliver Neukum <oneukum@suse.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Brian Norris <briannorris@chromium.org>
Subject: Re: PM runtime_error handling missing in many drivers?
Message-ID: <Z6lzWfGbpa7jN1QD@google.com>
References: <20220620144231.GA23345@axis.com>
 <5caa944f-c841-6f74-8e43-a278b2b93b06@suse.com>
 <20220708110325.GA5307@axis.com>
 <4ca77763-53d0-965a-889e-be2eafadfd2f@intel.com>
 <1937b65c-36c0-5475-c745-d7285d1a6e25@suse.com>
 <CAJZ5v0j0mgOcfKXRzyx12EX8CYLzowXrM8DGCH9XvQGnRNv0iw@mail.gmail.com>
 <5c37ee19-fe2c-fb22-63a2-638e3dab8f7a@suse.com>
 <CAJZ5v0ijy4FG84xk_n8gxR_jS0xao246eVbnFj-dXzwz=8S9NQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ijy4FG84xk_n8gxR_jS0xao246eVbnFj-dXzwz=8S9NQ@mail.gmail.com>

On Wed, Jul 27, 2022 at 06:31:48PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jul 27, 2022 at 10:08 AM Oliver Neukum <oneukum@suse.com> wrote:
> >
> >
> >
> > On 26.07.22 17:41, Rafael J. Wysocki wrote:
> > > On Tue, Jul 26, 2022 at 11:05 AM Oliver Neukum <oneukum@suse.com> wrote:
> >
> > > I guess that depends on what is regarded as "the framework".  I mean
> > > the PM-runtime code, excluding the bus type or equivalent.
> >
> > Yes, we have multiple candidates in the generic case. Easy to overengineer.
> >
> > >>> The idea was that drivers would clear these errors.
> > >>
> > >> I am afraid that is a deeply hidden layering violation. Yes, a driver's
> > >> resume() method may have failed. In that case, if that is the same
> > >> driver, it will obviously already know about the failure.
> > >
> > > So presumably it will do something to recover and avoid returning the
> > > error in the first place.
> >
> > Yes, but that does not help us if they do return an error.
> >
> > > From the PM-runtime core code perspective, if an error is returned by
> > > a suspend callback and it is not -EBUSY or -EAGAIN, the subsequent
> > > suspend is also likely to fail.
> >
> > True.
> >
> > > If a resume callback returns an error, any subsequent suspend or
> > > resume operations are likely to fail.
> >
> > Also true, but the consequences are different.
> >
> > > Storing the error effectively prevents subsequent operations from
> > > being carried out in both cases and that's why it is done.
> >
> > I am afraid seeing these two operations as equivalent for this
> > purpose is a problem for two reasons:
> >
> > 1. suspend can be initiated by the generic framework
> 
> Resume can be initiated by generic code too.
> 
> > 2. a failure to suspend leads to worse power consumption,
> >    while a failure to resume is -EIO, at best
> 
> Yes, a failure to resume is a big deal.
> 
> > >> PM operations, however, are operating on a tree. A driver requesting
> > >> a resume may get an error code. But it has no idea where this error
> > >> comes from. The generic code knows at least that.
> > >
> > > Well, what do you mean by "the generic code"?
> >
> > In this case the device model, which has the tree and all dependencies.
> > Error handling here is potentially very complicated because
> >
> > 1. a driver can experience an error from a node higher in the tree
> 
> Well, there can be an error coming from a parent or a supplier, but
> the driver will not receive it directly.
> 
> > 2. a driver can trigger a failure in a sibling
> > 3. a driver for a node can be less specific than the drivers higher up
> 
> I'm not sure I understand the above correctly.
> 
> > Reducing this to a single error condition is difficult.
> 
> Fair enough.
> 
> > Suppose you have a USB device with two interfaces. The driver for A
> > initiates a resume. Interface A is resumed; B reports an error.
> > Should this block further attempts to suspend the whole device?
> 
> It should IMV.
> 
> > >> Let's look at at a USB storage device. The request to resume comes
> > >> from sd.c. sd.c is certainly not equipped to handle a PCI error
> > >> condition that has prevented a USB host controller from resuming.
> > >
> > > Sure, but this doesn't mean that suspending or resuming the device is
> > > a good idea until the error condition gets resolved.
> >
> > Suspending clearly yes. Resuming is another matter. It has to work
> > if you want to operate without errors.
> 
> Well, it has to physically work in the first place.  If it doesn't,
> the rest is a bit moot, because you end up with a non-functional
> device that appears to be permanently suspended.
> 
> > >> I am afraid this part of the API has issues. And they keep growing
> > >> the more we divorce the device driver from the bus driver, which
> > >> actually does the PM operation.
> > >
> > > Well, in general suspending or resuming a device is a collaborative
> > > effort and if one of the pieces falls over, making it work again
> > > involves fixing up the failing piece and notifying the others that it
> > > is ready again.  However, that part isn't covered and I'm not sure if
> > > it can be covered in a sufficiently generic way.
> >
> > True. But that still cannot solve the question what is to be done
> > if error handling fails. Hence my proposal:
> > - record all failures
> > - heed the record only when suspending
> 
> I guess that would boil down to moving the power.runtime_error update
> from rpm_callback() to rpm_suspend()?
Resuming this discussion. One of the ways the device drivers are
clearing the runtime_error flag is by calling pm_runtime_set_suspended
[1].

To me, it feels weird that a device driver calls pm_runtime_set_suspended
if the runtime_resume() has failed. It should be implied that the device
is in suspended state if the resume failed.

So how really should the runtime_error flag be cleared? Should there be
a new API exposed to device drivers for this? Or should we plan for it
in the framework itself?

1: https://lore.kernel.org/all/20250129124009.1039982-3-jacek.lawrynowicz@linux.intel.com/

