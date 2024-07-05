Return-Path: <linux-pm+bounces-10709-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27316928D72
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 20:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 919941F24832
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 18:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826665EE95;
	Fri,  5 Jul 2024 18:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFVoLoHl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3715224F2;
	Fri,  5 Jul 2024 18:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720203645; cv=none; b=MxG1kJ7mGkmYlJtJ5SZmP2jE7hS5Ree+rwV3+s1YSzj4jWIAiU0Nd6pN0Q6KUJYJVCPy34fO9sfvoQ49tdRO51SOt//a8GWykOzfwZ03PbixO9GLKQK1fEwiJ2mc8exi37KGOWpO0pJorHkJeeHcl/cYcS605Wh6ehdA6N4VxSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720203645; c=relaxed/simple;
	bh=uoFta6I8JPEygP73SjhomFnEOfSYhfgZEMEDcLP8pzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMhMYFDycVZiPxoACucsAizIfoEkUK34BebTQOxLAFyNhDZmZTmA9K3GTCMECM/pa1jOh/5UUIn8jjZ34SZ65dA5PngOypGsOO8+f67pHMfmgABquGVIOEIp6dRlkldnLg2j0OZfOlM3I3KON8U3I0AMkiHKdU0NMa/83rWhSLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFVoLoHl; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-79efec89c80so31990285a.2;
        Fri, 05 Jul 2024 11:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720203642; x=1720808442; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qa2FKn5XaUbae5dervtOKaOQ5T7PPgluvtVwBz/Khpk=;
        b=jFVoLoHlSH1iW1YufxiLeDwhHQLTRLGwaLP0YmEdYHqIvCm4Luml9BYq+0dFvRtf1C
         ydPydH95s0lZBZnDZei3KlYyqOBr0YjD4aBfGATcc/Q0DYM2gtMYMF31HUpmfWriSerA
         8OSZFpxBIW+RQt9IYNQYJmCwCb4rfskD6VKX/RNI34xkgyOOFhpw27SzDU9j71GpKPrc
         SCVK1rt8k/mgGUvPbEdUMCVZHcw2kkw6LBSoqUmxylI5KCImO/4u9EQ8ajSd6Y3YCP4h
         kD6F+yJCDz3WCqmFDU2R7JEMYZ7hDb6KfBJ1iNrcvBXMtHYfV1HS426Fq4JYdy3AMN3b
         5OKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720203642; x=1720808442;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qa2FKn5XaUbae5dervtOKaOQ5T7PPgluvtVwBz/Khpk=;
        b=jC9WUM2HbFBat72PERHH0+zq37Qx155HIvZGDQUMhfLZSxBD07tSztEOLt6E/WVZxY
         atYEwV21zCqMhp66onl9SHcrt8vghRBZwQR+4K6VDme6nZmeQrX1MKnFy9OUsjEvjOMA
         c7U8O6FrollONtNTyZL7TTPn7Bj5dnNjgZwQGG9/NzqKL9L0xo4jTeCspDI6DY3x1Ghq
         oaPoUYP2+QGCzPD6ZLh1t5IstUDSRoaysJoEGDt0bKlHxDkSWl6i9OXQKbFxiC1Uw1m9
         bmA8Xr4ycGKnG7/Bo6OCdgtKlZdn/OQhqIKybv43/jX8QB2lK6Zt/gNx/1VVORJadecZ
         8CMg==
X-Forwarded-Encrypted: i=1; AJvYcCUmQERVHsZPKGGO2yQPSLn9E35p/p1BdMD+kySObjtOpGsMZEQBGznuQXoyZIbd+6MgC1TmmJVCtrgx8HoZe38b19X16GgntYYhXKg90IYHG8K4uBH/1wW+FGDkn78YvQE9JCam3XqV+5zeiQjOmMCWcThotwDhj+enkkjAJfbZ9DjFEhCYVg==
X-Gm-Message-State: AOJu0Yz9XCWmVBJKFDV5WOzlWodxMBwM9YIv+UHsnQ6OyTVwjDJdMf6D
	hZ+/CEk+tWEEI6wrIUOMFiThZeVuFGjNax/OrfUEWnqY83dxQCsj
X-Google-Smtp-Source: AGHT+IFDKsjpOV3WQSl9h1CBLDGosKsTmrRJo2jd0bi0Yz7lnea06PF/6yZ0BzDR9C2JzwCJOs0/0w==
X-Received: by 2002:a05:620a:210d:b0:79d:78d3:3b30 with SMTP id af79cd13be357-79eee20d17emr546711485a.15.1720203642359;
        Fri, 05 Jul 2024 11:20:42 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79effcdaf12sm14489285a.60.2024.07.05.11.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 11:20:41 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 0A52B1200043;
	Fri,  5 Jul 2024 14:20:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 05 Jul 2024 14:20:41 -0400
X-ME-Sender: <xms:eDmIZmT7ToBaR3_9QCLn04uMTGXzuqexQdxJPIpF7o_sof_ZMCgb9A>
    <xme:eDmIZrz9olf5dAUmGrzHR6wK5WETGAov2cC_e_BdB6Zxat0QzE-wnBLwXGXuMPsnU
    aPom1zDcMm_L51M-A>
X-ME-Received: <xmr:eDmIZj1JDanEtDewDY2ezSm_-DQprmQS6HOLZ8bjGF1qrQwuHnD9GQBdhgFVWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddugdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepgeeljefgffegvdetkefhueffgeegfeefleekiedvveejgfejheeivdff
    ieetvedtnecuffhomhgrihhnpehpohhinhhtvghrrdhsrghfvghthienucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhht
    phgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqd
    gsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:eDmIZiBplJk3Yu6HS5-x5kRMBmfMF3e7ZgBZg1NNHvumWCNOGSgfyQ>
    <xmx:eDmIZvhGZ6CqfQYwxfxrTs3WwOuaoLpFjvLSxwBxf1MtOOl5qFA1YQ>
    <xmx:eDmIZuqjQhMvyvTa8O-eZiDzwx5T7RzJ0Q8CHynkvUJTNWR14jFmKQ>
    <xmx:eDmIZiiY-YyHoyrUqvZVwp3IWq7_ThJF9rQyUVa7tEvCmkKR7Vr-6A>
    <xmx:eTmIZuSFikJ3s98ZpWPIJ40WD9S0aHdhh_xBfzpZK4jM2n7RETOT7ATd>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jul 2024 14:20:40 -0400 (EDT)
Date: Fri, 5 Jul 2024 11:19:33 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V3 1/8] rust: Add initial bindings for OPP framework
Message-ID: <Zog5NYptZRaqbUBz@boqun-archlinux>
References: <cover.1719990273.git.viresh.kumar@linaro.org>
 <fe8e9a96b29122876346fc98a6a9ede7e4f28707.1719990273.git.viresh.kumar@linaro.org>
 <ZoVvn0QCSR8y4HQJ@Boquns-Mac-mini.home>
 <20240705110228.qqhhynbwwuwpcdeo@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240705110228.qqhhynbwwuwpcdeo@vireshk-i7>

On Fri, Jul 05, 2024 at 04:32:28PM +0530, Viresh Kumar wrote:
> Hi Boqun,
> 
> On 03-07-24, 08:34, Boqun Feng wrote:
> > On Wed, Jul 03, 2024 at 12:44:26PM +0530, Viresh Kumar wrote:
> > > +/// Operating performance point (OPP).
> > > +///
> > > +/// # Invariants
> > > +///
> > > +/// The pointer stored in `Self` is non-null and valid for the lifetime of the ARef instance. In
> > > +/// particular, the ARef instance owns an increment on underlying object´s reference count.
> > 
> > Since you use `ARef` pattern now, you may want to rewrite this
> > "invariants".
> 
> I copied it from the device's documentation. What all details should I
> be writing here ? A link to some other implementation would be useful.
> 

"Invariants" defines "what's a valid instance of a type", so here I
think you could drop the "# Invariants" section at all, unless you need
to use some of the invariants of fields in `dev_mp_opp` as a
justification for safety. For example if you have a pointer in
`dev_mp_opp`, and it's always pointing to a valid `T`, and in one method
of `OPP`, you need to dereference the pointer.

> > > +impl Drop for OPP {
> > 
> > I don't think you need the `drop` implementation here, since it should
> > be already handled by `impl AlwaysRefCounted`,
> 
> Right.
> 
> > could you try to a doc
> > test for this? Something like:
> > 
> > 	let opp: ARef<OPP> = <from a raw dev_pm_opp ponter whose refcount is 1>
> > 	drop(opp);
> 
> I now tested it with a kernel test to see what's going on internally
> 
> > IIUC, this will result double-free with the current implementation.
> 
> Quite the opposite actually. I am getting double get and a single put :)
> 
> Thanks a lot for pointing me to this direction as I have found that my
> implementation was incorrect. This is how I understand it, I can be
> wrong since I am okayish with Rust:
> 
> - What's getting returned from `from_raw_opp/from_raw_opp_owned` is a
>   reference: `<&'a Self>`.
> 
> - Since this is a reference, when it gets out of scope, nothing
>   happens. i.e. the `drop()` fn of `struct OPP` never gets called for
>   the OPP object, as there is no real OPP object, but just a
>   reference.
> 
> - When this gets converted to an `ARef` object (implicit typecasting),
>   we increment the count. And when that gets dropped, we decrement it.
>   But Apart from an `ARef` object, only the reference to the OPP gets
>   dropped and hence again, drop() doesn't get called.
> 
> - The important part here is that `from_raw_opp()` shouldn't be
>   incrementing the refcount, as drop() will never get called. And
>   since we reach here from the C implementation, the OPP will remain
>   valid for the function call.
> 

Right. I wasn't aware that you didn't return a `ARef<OPP>`, which mean
the return value won't handle the refcounting automatically (and because
of that, the refcount shouldn't be increased.)

> - On the other hand, I can't return <&'a Self> from
>   from_raw_opp_owned() anymore. In this case the OPP core has already
>   incremented the refcount of the OPP (while it searched the OPP on
>   behalf of the Rust code). Whatever is returned here, must drop the
>   refcount when it goes out of scope. Also the returned OPP reference
>   can live for a longer period of time in this case, since the call
>   originates from the Rust side. So, it needs to be an explicit
>   conversion to ARef which won't increment the refcount, but just
>   decrement when the ARef gets out of scope.
> 

I think you got it correct ;-) The takeaway is: there are different
types of pointers/references, 1) if users only use a `struct dev_pm_opp
*` shortly and the scope can be told at compile time, you can provide a
`&OPP`, 2) if the scope of usage is somewhat dynamic, and the users
should descrease the refcount after use it, the API should return a
`ARef<OPP>`. And since the refcount inc/dec are already maintained in
`ARef<_>`, `OPP::drop` shouldn't touch the refcount anymore.

Also as you already noticed, calling `into` on a `&OPP` will give a
`ARef<OPP>`, which includes an increment of the refcount, and usually
should be used when the users want to switch to long-term usage after a
quick short-term use (e.g. do a quick check of the status and decide
some more work is needed, and maybe need to transfer the ownership of
the pointer to a workqueue or something).

> Here is the diff that I need:
> 
> diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
> index aaf220e6aeac..a99950b4d835 100644
> --- a/rust/kernel/opp.rs
> +++ b/rust/kernel/opp.rs
> @@ -692,7 +692,7 @@ pub fn opp_from_freq(
>          })?;
>  
>          // SAFETY: The `ptr` is guaranteed by the C code to be valid.
> -        Ok(unsafe { OPP::from_raw_opp_owned(ptr)?.into() })
> +        unsafe { OPP::from_raw_opp_owned(ptr) }
>      }
>  
>      /// Finds OPP based on level.
> @@ -718,7 +718,7 @@ pub fn opp_from_level(&self, mut level: u32, stype: SearchType) -> Result<ARef<O
>          })?;
>  
>          // SAFETY: The `ptr` is guaranteed by the C code to be valid.
> -        Ok(unsafe { OPP::from_raw_opp_owned(ptr)?.into() })
> +        unsafe { OPP::from_raw_opp_owned(ptr) }
>      }
>  
>      /// Finds OPP based on bandwidth.
> @@ -743,7 +743,7 @@ pub fn opp_from_bw(&self, mut bw: u32, index: i32, stype: SearchType) -> Result<
>          })?;
>  
>          // SAFETY: The `ptr` is guaranteed by the C code to be valid.
> -        Ok(unsafe { OPP::from_raw_opp_owned(ptr)?.into() })
> +        unsafe { OPP::from_raw_opp_owned(ptr) }
>      }
>  
>      /// Enable the OPP.
> @@ -834,31 +834,33 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
>  }
>  
>  impl OPP {
> -    /// Creates a reference to a [`OPP`] from a valid pointer.
> +    /// Creates an owned reference to a [`OPP`] from a valid pointer.
>      ///
>      /// # Safety
>      ///
> -    /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
> -    /// returned [`OPP`] reference.
> -    pub unsafe fn from_raw_opp_owned<'a>(ptr: *mut bindings::dev_pm_opp) -> Result<&'a Self> {
> -        // SAFETY: The caller guarantees that the pointer is not dangling
> -        // and stays valid for the duration of 'a. The cast is okay because
> -        // `OPP` is `repr(transparent)`.
> -        Ok(unsafe { &*ptr.cast() })
> +    /// The caller must ensure that `ptr` is valid and OPP's refcount is incremented. The refcount
> +    /// will be decremented by `dec_ref` when the ARef object is dropped.

Usually the second sentense "The refcount ..." won't need to be put in
the safety requirement, as it just describes how ARef works.

> +    pub unsafe fn from_raw_opp_owned(ptr: *mut bindings::dev_pm_opp) -> Result<ARef<Self>> {
> +        let ptr = ptr::NonNull::new(ptr).ok_or(ENODEV)?;
> +
> +        // SAFETY: The safety requirements guarantee the validity of the pointer.
> +        //
> +        // INVARIANT: The refcount is already incremented by the C API that returned the pointer,
> +        // and we pass ownership of the refcount to the new `ARef<OPP>`.

You can probably drop the "INVARIANT", as it's an invariant of `ARef`
which already guarantees since the safety requirement of
`ARef::from_raw()` meets. At least you can write them as "normal"
comments.

> +        Ok(unsafe { ARef::from_raw(ptr.cast()) })
>      }
>  
>      /// Creates a reference to a [`OPP`] from a valid pointer.
>      ///
>      /// # Safety
>      ///
> -    /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
> -    /// returned [`OPP`] reference.
> +    /// The caller must ensure that `ptr` is valid and remains valid for the duration of 'a. The
> +    /// refcount is not updated by the Rust API unless the returned reference is converted to an
> +    /// ARef object.

Again you could drop the second sentence, or you can put it somewhere
outside the "Safety" section, if you want to.

>      pub unsafe fn from_raw_opp<'a>(ptr: *mut bindings::dev_pm_opp) -> Result<&'a Self> {
> -        let opp = unsafe { Self::from_raw_opp_owned(ptr) }?;
> -
> -        // Take an extra reference to the OPP since the caller didn't take it.
> -        opp.inc_ref();
> -        Ok(opp)
> +        // SAFETY: The caller guarantees that the pointer is not dangling and stays valid for the
> +        // duration of 'a. The cast is okay because `OPP` is `repr(transparent)`.
> +        Ok(unsafe { &*ptr.cast() })
>      }
>  
>      #[inline]
> @@ -910,10 +912,3 @@ pub fn is_turbo(&self) -> bool {
>          unsafe { bindings::dev_pm_opp_is_turbo(self.as_raw()) }
>      }
>  }
> -
> -impl Drop for OPP {
> -    fn drop(&mut self) {
> -        // SAFETY: The safety requirements guarantee that the refcount is nonzero.
> -        unsafe { bindings::dev_pm_opp_put(self.as_raw()) }
> -    }
> -}
> 
> Makes sense ?
> 

Yep, looks good to me!

Regards,
Boqun

> -- 
> viresh

