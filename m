Return-Path: <linux-pm+bounces-20090-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDDDA05D13
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 14:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C04673A1E29
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 13:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE3C1FC7F4;
	Wed,  8 Jan 2025 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdccK5ix"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578881F9F7D
	for <linux-pm@vger.kernel.org>; Wed,  8 Jan 2025 13:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736343774; cv=none; b=OdTrRcNNp9vvIAxrq5ixeqCqEu/cTh953M0mPjBHIRIZwO620cpuJTRPZNNY2rngzm3yfaGu9e9zY/VYMNAEu+F2SRB8DIMcpvrih7KsKoJFNEIW+k8jUc7cpw2ScOqSmfhrckFqVqahVNGkT450lK7sfhhHJ93o2QQI2t1yj9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736343774; c=relaxed/simple;
	bh=MRpq/+SA7iXM6RcBC1IgyGCkzCP4QQ2/TD8XNnMatBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3HUY4CzPzwLfVUYuwNvEp2rVfDqkDtSRsdIpTrAeXCxOs+KGUqLEqWbhilCi6/f6AFDovwlwjxmbdr1MVEdN94JPuU7fjjenQMkTm48L7pvTAYk0+WWsgyZ6YU8xe9jcBnEDCBZdm77gpdsVJ7wYgZ+uK8qTViSWNXdNrJOTRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YdccK5ix; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736343770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6ihvbv82+RdRwTRUbUOAT3MrioMMatOFaSAlH7HGxVM=;
	b=YdccK5ixOgkRReWPiVZf71T8xy7N+KWFctVglMjwAe3dzvWmI+Qguvc7duUmEevPKmFqNg
	uVV0IVIN8u0G59Tf9LbSTqh2cQ2lqJ81vPrafK7tGSqWllKpc9FcW059kt6B/iZfmT/4kj
	8KdOknkzI0xix0pTlhjm82QbpxI4faE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-okmcqrGZOCK4Dvgps4QzJg-1; Wed, 08 Jan 2025 08:42:47 -0500
X-MC-Unique: okmcqrGZOCK4Dvgps4QzJg-1
X-Mimecast-MFC-AGG-ID: okmcqrGZOCK4Dvgps4QzJg
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385dcae001fso7192259f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Jan 2025 05:42:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736343766; x=1736948566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ihvbv82+RdRwTRUbUOAT3MrioMMatOFaSAlH7HGxVM=;
        b=pEWCZHPQc3yyvT6HQxIFqpz6EOFCOmuKEw/Dee4ewBgby65HDryQ8bQ1QupG4YqnqU
         NJohyGYEAqwH9iLtl/b+eHC7oszUebtHFdsfxwqVXSkfhLRJDbgYtcPLMbqRyxtLPCQx
         7zir80/e+28G43cqmMX7Rlr56RyZYmls7q6A0KwJi6sKIWdIE/5ecHJo6JzzIOO+uC06
         B7BXO3dY0Br2J9iqyvNvY69tRYXum7LHciS14EBHjPb2SVu5/EP2N30HOla9gvEF+iVZ
         bX1xkJQ31q923aEXdjCQ7vDrHaiHPO6NDU2Gr3S6fMxlEwnetI8yT6dz0FmX5Gv0pgoS
         Sixg==
X-Forwarded-Encrypted: i=1; AJvYcCWAYylkpMPMzWcPAaV0vCa7dmFDSzGd7q5KZQcSzy2ycOaRA2u/zDZzLLPmviiTvB7WONejm44Mmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNlEAEs7QzyW171/4lquKTHhgrgnMPgxNWwjGsxuWRF60AMTeU
	y4v9bFOghGXqCyYdKs/K/7x91JNNUoSfOcAb2JiBIN0KTf2szJG27ZXlLZ/2cABwTcQ8zj7MBlz
	tVNkyt/Dr4iQfqyr06+4Q3U/hTltWElnGhlROj8IyYgckCTs0GvfnEyMm
X-Gm-Gg: ASbGncv34Txy8SZPItdzsB0tlVbc3RgDUQ1QLFhIF7cROkkzamupmG7LgM5uUcDFUcD
	rHwvy+9KRNX8AG4SRB7Ukj9P7MGXmBhSBAjhrC27dLW2BneNwV3crq3csQGhKSK0AVLVhl2gH/I
	jLKAa52OJNht37+fiY/OMCUf+Dzi18aaLr5DGwqMglTOJhUu8tl8TaTxCMQK+JJlbEY6/EqZu+s
	TiN5X+yaum/LgOKge150jZ09PhufjG9LhQADZk8XZCudA==
X-Received: by 2002:a05:6000:18ac:b0:385:ef39:6cd5 with SMTP id ffacd0b85a97d-38a872f6ed5mr2475725f8f.1.1736343766221;
        Wed, 08 Jan 2025 05:42:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5Ck6Qa9Y/G4V6PSLpc+GPlb+MkstmuA44/qCtdLMqpRoYijty1LnDRVFQARcJyuTB9SaxCQ==
X-Received: by 2002:a05:6000:18ac:b0:385:ef39:6cd5 with SMTP id ffacd0b85a97d-38a872f6ed5mr2475681f8f.1.1736343765655;
        Wed, 08 Jan 2025 05:42:45 -0800 (PST)
Received: from pollux ([2a00:79c0:618:8300:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8475cesm52644149f8f.57.2025.01.08.05.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 05:42:45 -0800 (PST)
Date: Wed, 8 Jan 2025 14:42:42 +0100
From: Danilo Krummrich <dakr@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 04/15] rust: device: Add few helpers
Message-ID: <Z36A0g9g6qkRZSjh@pollux>
References: <cover.1736248242.git.viresh.kumar@linaro.org>
 <429b7539f787ad360cd28fd1db6dc3d6c1fe289d.1736248242.git.viresh.kumar@linaro.org>
 <2025010734-march-cultivate-bd96@gregkh>
 <20250108110242.dwhdlwnyjloz6dwb@vireshk-i7>
 <2025010835-uncover-pamphlet-de5b@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025010835-uncover-pamphlet-de5b@gregkh>

On Wed, Jan 08, 2025 at 12:52:54PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Jan 08, 2025 at 04:32:42PM +0530, Viresh Kumar wrote:
> > On 07-01-25, 12:56, Greg Kroah-Hartman wrote:
> > > On Tue, Jan 07, 2025 at 04:51:37PM +0530, Viresh Kumar wrote:
> > > > +    /// Creates a new ref-counted instance of device of a CPU.
> > > > +    pub fn from_cpu(cpu: u32) -> Result<ARef<Self>> {
> > > 
> > > Why is this a reference counted device, yet the C structure is NOT
> > > properly reference counted at all?
> > 
> > Ahh, I completely missed that it is not reference counted at all.
> > 
> > > Are you _sure_ this is going to work properly?
> > > 
> > > And really, we should fix up the C side to properly reference count all
> > > of this.  Just read the comment in cpu_device_release() for a hint at
> > > what needs to be done here.
> > > 
> > > > +        // SAFETY: It is safe to call `get_cpu_device()` for any CPU number.
> > > 
> > > For any number at all, no need to say "CPU" here, right?
> > > 
> > > > +        let ptr = unsafe { bindings::get_cpu_device(cpu) };
> > > > +        if ptr.is_null() {
> > > > +            return Err(ENODEV);
> > > > +        }
> > > > +
> > > > +        // SAFETY: By the safety requirements, ptr is valid.
> > > > +        Ok(unsafe { Device::get_device(ptr) })
> > > 
> > > So why is this device reference counted?  I get it that it should be,
> > > but how does that play with the "real" device here?
> > 
> > How about this:
> > 
> > Subject: [PATCH] rust: device: Add from_cpu()
> > 
> > This implements Device::from_cpu(), which returns a reference to
> > `Device` for a CPU. The C struct is created at initialization time for
> > CPUs and is never freed and so `ARef` isn't returned from this function.
> 
> How about fixing the reference count of the cpu device?  :)

I think that's really what is needed, otherwise it'll never work with the
guarantees the Rust `Device` abstraction provides.

The patch below is still not valid I think. It assumes that a CPU device never
becomes invalid, but that isn't true.

There's a hotplug path [1] where the device is unregistered.

[1] https://elixir.bootlin.com/linux/v6.12.6/source/drivers/base/cpu.c#L94

> 
> But seriously, this is NOT a generic 'struct device' thing, it is a 'cpu
> device' thing.  So putting this function in device.rs is probably not
> the proper place for it at all, sorry.  Why not put it in the cpu.rs
> file instead?
> 
> > The new helper will be used by Rust based cpufreq drivers.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  rust/kernel/device.rs | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> > index 66ba0782551a..007f9ffab08b 100644
> > --- a/rust/kernel/device.rs
> > +++ b/rust/kernel/device.rs
> > @@ -6,6 +6,8 @@
> >  
> >  use crate::{
> >      bindings,
> > +    error::Result,
> > +    prelude::ENODEV,
> >      str::CString,
> >      types::{ARef, Opaque},
> >  };
> > @@ -60,6 +62,20 @@ pub unsafe fn get_device(ptr: *mut bindings::device) -> ARef<Self> {
> >          unsafe { Self::as_ref(ptr) }.into()
> >      }
> >  
> > +    /// Creates a new instance of CPU's device.
> > +    pub fn from_cpu(cpu: u32) -> Result<&'static Self> {
> > +        // SAFETY: The pointer returned by `get_cpu_device()`, if not `NULL`, is a valid pointer to
> > +        // a `struct device` and is never freed by the C code.
> > +        let ptr = unsafe { bindings::get_cpu_device(cpu) };
> > +        if ptr.is_null() {
> > +            return Err(ENODEV);
> > +        }
> > +
> > +        // SAFETY: The pointer returned by `get_cpu_device()`, if not `NULL`, is a valid pointer to
> > +        // a `struct device` and is never freed by the C code.
> > +        Ok(unsafe { Self::as_ref(ptr) })
> > +    }
> > +
> >      /// Obtain the raw `struct device *`.
> >      pub(crate) fn as_raw(&self) -> *mut bindings::device {
> >          self.0.get()
> > 
> > -------------------------8<-------------------------
> > 
> > > > +    /// Checks if property is present or not.
> > > > +    pub fn property_present(&self, name: &CString) -> bool {
> > > > +        // SAFETY: `name` is null-terminated. `self.as_raw` is valid because `self` is valid.
> > > > +        unsafe { bindings::device_property_present(self.as_raw(), name.as_ptr() as *const _) }
> > > 
> > > is "self.as_raw()" a constant pointer too?
> > 
> > Subject: [PATCH] rust: device: Add property_present()
> > 
> > This implements Device::property_present(), which calls C APIs
> > device_property_present() helper.
> > 
> > The new helper will be used by Rust based cpufreq drivers.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  rust/bindings/bindings_helper.h | 1 +
> >  rust/kernel/device.rs           | 7 +++++++
> >  2 files changed, 8 insertions(+)
> > 
> > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> > index 43f5c381aab0..70e4b7b0f638 100644
> > --- a/rust/bindings/bindings_helper.h
> > +++ b/rust/bindings/bindings_helper.h
> > @@ -31,6 +31,7 @@
> >  #include <linux/pid_namespace.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/poll.h>
> > +#include <linux/property.h>
> >  #include <linux/refcount.h>
> >  #include <linux/sched.h>
> >  #include <linux/security.h>
> > diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> > index d5e6a19ff6b7..66ba0782551a 100644
> > --- a/rust/kernel/device.rs
> > +++ b/rust/kernel/device.rs
> > @@ -6,6 +6,7 @@
> >  
> >  use crate::{
> >      bindings,
> > +    str::CString,
> >      types::{ARef, Opaque},
> >  };
> >  use core::{fmt, ptr};
> > @@ -180,6 +181,12 @@ unsafe fn printk(&self, klevel: &[u8], msg: fmt::Arguments<'_>) {
> >              )
> >          };
> >      }
> > +
> > +    /// Checks if property is present or not.
> > +    pub fn property_present(&self, name: &CString) -> bool {
> > +        // SAFETY: By the invariant of `CString`, `name` is null-terminated.
> > +        unsafe { bindings::device_property_present(self.as_raw() as *const _, name.as_ptr() as *const _) }
> 
> I hate to ask, but how was this compiling if the const wasn't there
> before?  There's no type-checking happening here?  If not, how are we
> ever going to notice when function parameters change?  If there is type
> checking, how did this ever build without the const?
> 
> confused,
> 
> greg k-h
> 


