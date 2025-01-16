Return-Path: <linux-pm+bounces-20532-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4BAA1366B
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 10:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91641188358B
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 09:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF141DA10E;
	Thu, 16 Jan 2025 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IDfv/rWx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC451AAA1D
	for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2025 09:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737019035; cv=none; b=aRF0Akd5N9I6XOq444O+vY+SOa6/fzTu29vfsH27bmiyf7xinm9X9la6AP3wa/ybZo7ozFheD1/fbSC07NlJ94hq+b5XZx7H4eVY/u61H2BmtNvuRTEXqnqwLyGqB2cLmrY7ABtzAw3SBNud55uQZzfV+C9aex5ugKDMSmM2HC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737019035; c=relaxed/simple;
	bh=jjpMue/Ht2qG19a9VG6JkTKgFZVesHzLY9PoP2l9ByE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8T7yLyxe7gxGAJt0cAnfrz6U89mm3EN6FmKwTLosiN3VTiMlzjXt+11MpjnB85wVq2MtHYCzCCBaE80HmMWtKOn6X/DWx8BqMENX65dAns+I3XVvZFkcOu+K7MSnnmQ0/v99GY2/WazTBIfrpU4cGIgu87NhnpCOjWwIJa00mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IDfv/rWx; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21636268e43so14386825ad.2
        for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2025 01:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737019032; x=1737623832; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qyCJ9CTa+KPiCKak9X4mNUa65nCq9LRdipr+oToK3pk=;
        b=IDfv/rWxhptW4SJyVWvMXrX3iG/7Me7LTXXSMDAczbZXR+yuwFvOwiVRkXbNW8NlHp
         mvaYX4uoply8BPuw4MVoh30lEgPZjvbjteNuc3dAvdrJick9qUkydfDjoPsNKGFdjYMY
         3hfJChqGZrX/dOYM7TvzUtDdIzYAAtROMhZhozExC8/87NSWPSob2NSZyhGEwmVILD0u
         TXIeqKzEDE7TBIc+p8mXjM2uD8UY7B+3IrIne7Sf5R6m+Ttrq2i2BrT7pVKxYyMoPva1
         0Ce1CBYZjO7DnQASoyX9EtRny1UANsVZwMYmWM8K94sz9aXM91vKYBS927mYM89D4L95
         fWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737019032; x=1737623832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyCJ9CTa+KPiCKak9X4mNUa65nCq9LRdipr+oToK3pk=;
        b=cI5sAPSB86ftBBlpnELDkS7wzSIkEt2hfUxYre4Uv7OYOoBsdEr/PzaBfE8UAgC4bT
         DiDbYhbYPW6odWlc0e8q+UoZNAQMH49M5+hQzRWMEdJe7YMV1g7999YJRiwhokvRyVTn
         +Ho9Fg3mZtrWpXu4cE70iHF2QdIqVYtZ0wNM42cttDUGNMAahJcA+vVZTwVJoSl+Ae/Z
         3G7UpSnE4YHH7+q+QXTnijr8KwkN0y018RH74WjiFEyWO8FQ5wZWlMf+PrSO/RVIcH+o
         jQ95N3/odQYBYAhQY6ibSVMTIiJA5FVM16AEexDjhjE87InP3joNeM7QJV4WUTbv/vu3
         5S2g==
X-Forwarded-Encrypted: i=1; AJvYcCWnF+bWcPKlJOMPabwWeNfhbeG3EegbuY0eYCa3ny9g7q/bpwooZLsZLWd7oEU/S6TzI6qQwTkyGA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6pY5FnWwaHE1jYBR/2tAzDZFmEkJgV8Hreo61CvLsx8/wQzB0
	ZgUB8WEx/tbHrN4MyWU2uFp5zb4tRsonnxOQyNOzR6nen9NTKYtTp6GcFfVi+q4=
X-Gm-Gg: ASbGncv6P3fyvMCWPIOyQcGSUgAw7i5+kF0SC+9cT30VcUVZdaPRktOhVN5UC7AIOFa
	78KRAKhMRfnKYbjkyb0sd5YxVOmdkSY3K3MGNtuIeJ5H4mOdDVGPwPtnyhl4RvjG+orLtReKz2e
	E3SNEaNyfyiAYtjUlwnruGyk+nSVAr1mf9zLxIfv6qFimZtk1BVfPHErEF65rrjnfI9G9uRmP4Z
	EKp1FZbsKm5ggYXIP+ZKNKOY74YGvy882EA4iyBrpLC0HbfEU6KqLmxOr8=
X-Google-Smtp-Source: AGHT+IF+AB/yDyP3sHokpXz+G8vtI+AE7lEQMNO+j75LpMCWt8816cElgMQ9bohqqloA18c6JDTSNw==
X-Received: by 2002:a17:902:d481:b0:215:b01a:627f with SMTP id d9443c01a7336-21a83f48e86mr521010235ad.4.1737019031771;
        Thu, 16 Jan 2025 01:17:11 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22e52bsm95102715ad.184.2025.01.16.01.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 01:17:11 -0800 (PST)
Date: Thu, 16 Jan 2025 14:47:09 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH V7 03/16] rust: cpu: Add from_cpu()
Message-ID: <20250116091709.gg5r5d7dmiqudt2g@vireshk-i7>
References: <cover.1736766672.git.viresh.kumar@linaro.org>
 <854f7b8c9cbcc7f38fe5ed548290f41224478b40.1736766672.git.viresh.kumar@linaro.org>
 <2025011430-humiliate-expansive-2ea4@gregkh>
 <20250115072050.72oeibi735k3pjdq@vireshk-i7>
 <2025011537-shuffling-unpaved-121a@gregkh>
 <20250115075859.mjpcvwctxx2vutpu@vireshk-i7>
 <2025011556-regroup-swapping-623a@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025011556-regroup-swapping-623a@gregkh>

On 15-01-25, 09:09, Greg KH wrote:
> On Wed, Jan 15, 2025 at 01:28:59PM +0530, Viresh Kumar wrote:
> > On 15-01-25, 08:54, Greg KH wrote:
> > > Ah, but that's not really something that SAFETY should override, right?
> > > 
> > > Yes, you know your implementation of this will stop using the pointer in
> > > the hotplug callback before it goes away but that's not documented here.
> > > And having the device "fail" afterward isn't really ok either as you are
> > > relying on the driver core to always check for this and I'm not so sure
> > > that it always does on all codepaths.
> > > 
> > > But, I'm ok with this for now, as you are just copying the bad C model
> > > at the moment, but it really feels like a huge foot-gun waiting to go
> > > off.  Any way to put some more documentation here as in "use this at
> > > your own risk!"?
> > 
> > What about marking it unsafe ? That would require callers to document
> > why it is safe to call this. And yes add more documentation here too.
> 
> Sure, that's fine with me.

+/// Creates a new instance of CPU's device.
+///
+/// # Safety
+///
+/// Reference counting is not implemented for the CPU device in the C code. When a CPU is
+/// hot-unplugged, the corresponding CPU device is unregistered, but its associated memory
+/// is not freed.
+///
+/// Callers must ensure that the CPU device is not used after it has been unregistered.
+/// This can be achieved, for example, by registering a CPU hotplug notifier and removing
+/// any references to the CPU device within the notifier's callback.
+pub unsafe fn from_cpu(cpu: u32) -> Result<&'static Device> {
+    // SAFETY: The pointer returned by `get_cpu_device()`, if not `NULL`, is a valid pointer to
+    // a `struct device` and is never freed by the C code.
+    let ptr = unsafe { bindings::get_cpu_device(cpu) };
+    if ptr.is_null() {
+        return Err(ENODEV);
+    }
+
+    // SAFETY: The pointer returned by `get_cpu_device()`, if not `NULL`, is a valid pointer to
+    // a `struct device` and is never freed by the C code.
+    Ok(unsafe { Device::as_ref(ptr) })
+}

-- 
viresh

