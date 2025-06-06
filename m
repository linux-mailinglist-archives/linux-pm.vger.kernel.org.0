Return-Path: <linux-pm+bounces-28207-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0E2AD08C7
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 21:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E3EB3AA848
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 19:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F5C21324D;
	Fri,  6 Jun 2025 19:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYDWGecd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9A5BA38;
	Fri,  6 Jun 2025 19:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749238827; cv=none; b=LAA7ivx+JRlniev4XM9G9jo+7FdIfdXag5zu+GkZiVmAvMuTb2QRcBBpXbDsbEaSyjo5fyPkzwiDxM7vlejWx2TFRyJElbca/w8LAXAXO6bwRKPp0/l3XM8sn2PbvCpaLnlqXioscoGp+J14d6X3CXzKuAmEUhxG+Vil49tUDos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749238827; c=relaxed/simple;
	bh=JdN9pj498j6YsXhJSeh5Y1ABLwMtpUZB1qlSnZ7ABlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKQTVKgrtPRGV7wZCy8IU6Pk6iAivKeQfh9LIHLzIiiSnzaRFlkF/TVbSuXOgfQM9DC6pwklHUgCW0mHwYkHuOkyhI3TO7vAzQI0GT002CCpGifxDDRA6WuFeSIPOpMwwJ+1AiRNMAUJFPSdpPzKOL2VBXhh5TroZqUBcAfD2A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYDWGecd; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7d20f799fe9so231842685a.2;
        Fri, 06 Jun 2025 12:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749238825; x=1749843625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nbj9X239o+v5nPIWaAKB5167UwpYfUckog1wQ+6Tum0=;
        b=EYDWGecdpL+Hm9zdJ9Hs7lFn2+Lgu2OErOY0PKsPBGUAVOp4IjCHgRXuq7wec+k/87
         fUckV61cmhIPkC5Ys3zRxTffkEj77m+U2cbc4xM4i2ZMHQmJ2zH+j0zxWFmL0tf8QC03
         THxtP+1WgaYWvwFONXxYrUR83qQsBk8U6e96EfWdLdiEg7e28xvFM657LMEj1k0K2Cqn
         YHvenH8cqoqUrfD964Rfjikrvq+aJ1H94i4INxrjo6VX+KnYMLbBJMt6RPy5CA5IFLzn
         tbsINWPkTfzPZ+5Q8v1E9I+s89lIqKzWgV/ihu5Z4jT0N1QcMI2E5tW6ec6rmOZucg9n
         YBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749238825; x=1749843625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nbj9X239o+v5nPIWaAKB5167UwpYfUckog1wQ+6Tum0=;
        b=PNMDjp9D1IJCT38glXZoJVMbVELAQ/rhk2VgRcyTwlESvFOeQJ4REh/LqVc/Fvi6uT
         vBJKxcv2RdUSV3/4DR2kqj1YdaQzb/9MUwqFQq57zlePGUZFy30Vjcrez8IMB+rC+Qvf
         b7xP0u7+EQE6FTqCrU7U/63IDEBjYH5Xi6iwxC1sqbqIY3gZqVTnzsXIvicujgVNHk3S
         nv4O1qpdJVhTUZSSTul6iFZ93a/wjdSHEb3ZjaZg3rNCc2raW8g7A0bWk0zBitf0769u
         muEVsXPlt2qHwqfkbQ7Q+ImFEUW+ciOL/lLsQ38vd/+cj3mD1QHBQNYFUQ0iMn2ujQf2
         14ug==
X-Forwarded-Encrypted: i=1; AJvYcCU/B1FE2jIBF+IrVuQgxeUGM24X3HGSefN9gGGoWWMoIoLOOYiHbV0/U0/ebQvSTZXE747dwZBEDzY=@vger.kernel.org, AJvYcCV2Caw8LNUt09u7heJrxlJC5RbEU3c/g03lVaeLcikAYY8Kft1DjMJQC9CcSZeY816dD6PzDOv74YZ1JHc4UyQ=@vger.kernel.org, AJvYcCVBNGzX7ZkKM926lwXSAwEEvA0ZtLUSGvfqMS68KQKJr02roBsiRyfdgsV5cJ2AP0l68QlJHQ5uD0c+DN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqodjXivD9rH1BsTljr0E9ImxUj53TMGAiyG8zKSHEXz+F3TiG
	3sSwTtAia6kaW/Wevry8rvtnRqoLn5fdWnvGOsSIEC0/cTRmgT9YA/D9
X-Gm-Gg: ASbGncuOJkZrondWvuz2SCY7p7LEELqD79UIV4017+b4JCVXVICbWs3Vl/zIF+unWIh
	Ey7uzbmrxT20Mpie0uYnzqVVXJFtJBnU33/iOlrc9LyOf7+rzHWYXdP3iA1dF6WGLtYO3JoKgP7
	vDPOppObmJZ1Uw/Z0zS3PxYDrZg/tMQm5Oddo9cS/k6P2uFn1aGt/mAH4iNryUrrVuUZ/QsbD7f
	KYHseBRRwMoBFbhE9dSD4twVAbX2MYi1rDwUfusJG7CgdF3ZBX5vlBKhDKd+ST1nbUcKxerSEg1
	xa/syz1OTgjutzOkaEbDimwEH6+eZ2sC0Zw0+IkTBHMZVLlz7KPG3jZQPbX+AioRsc6h8GH87wi
	kIUIPi6FeTzCRLfk4YF7dgwyWoN5BhcA7HUirM+4epXfGwVlDVdWT
X-Google-Smtp-Source: AGHT+IHpZ/IaGSA+dGThw/HYLW10zv8SsMAGZM1KMd0Uto+19hSYra3+hogZMY5uPLu5Y9sn2fz0rA==
X-Received: by 2002:a05:620a:24c9:b0:7c5:3d60:7f8d with SMTP id af79cd13be357-7d22987a511mr724757785a.19.1749238824905;
        Fri, 06 Jun 2025 12:40:24 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d2669b570bsm175603285a.106.2025.06.06.12.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 12:40:24 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8AC1F1200068;
	Fri,  6 Jun 2025 15:40:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 06 Jun 2025 15:40:23 -0400
X-ME-Sender: <xms:J0RDaN2mAdZ2onNk4nm0ASddRgv9ARryA6ClZsFLZfQj6h3myXByIA>
    <xme:J0RDaEG2UFyP3FycZYYO-Nubd7kSkfJfGs6rOSlUml1z44BjRMz9OyC8mzR_pnxjE
    ANHKJSv0fL79fcInA>
X-ME-Received: <xmr:J0RDaN5XaCtLKv2mdcw1FgcuqruhwSI5ZTghcgQtxhaHXBztY6wBHvkn_GavoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdehhedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpefftdeihfeigedtvdeuueffieetvedtgeejuefh
    hffgudfgfeeggfeftdeigeehvdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eplhhoshhsihhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrvghshhdrkhhu
    mhgrrheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopeihuhhrhidrnhhorhhovhesghhmrghilhdrtghomhdprhgt
    phhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrgh
    grhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhho
    rdhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtoh
    hmpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:J0RDaK1J6gNH26XlCQWKsoaNvYSAgqER0h_eept8naG7TLpviWCDAQ>
    <xmx:J0RDaAGRslaYt2AkyCLX5J_Mqek-Gx4yFIockNXEsH2v3SdGRmQZrQ>
    <xmx:J0RDaL8_IWRgP37L0xrF_ZjYUKi4DJ8Sawns2Z1HUUXu3M3HwT5m9A>
    <xmx:J0RDaNlPH1oHbCulUdqrI_Vf3QtgYtA_sa5xLYTADMKrzwZTdZby7Q>
    <xmx:J0RDaEHCzlMR_45qZBYc0boRe7HDXkQIK1nBuxeWDUCOm8-DEoBIc9DM>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Jun 2025 15:40:22 -0400 (EDT)
Date: Fri, 6 Jun 2025 12:40:22 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <lossin@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: cpumask: Validate CPU number in set() and clear()
Message-ID: <aENEJlFK10q0j76Z@tardis.local>
References: <8b5fc7889a7aacbd9f1f7412c99f02c736bde190.1749183428.git.viresh.kumar@linaro.org>
 <aEJwm16HSwCyt7aB@Mac.home>
 <DAFAR5SUQSU9.OSLB2UAXE9DY@kernel.org>
 <aELugDefiviXZjx6@Mac.home>
 <DAFP9ZRENV0S.ON0XKIXIAEKY@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DAFP9ZRENV0S.ON0XKIXIAEKY@kernel.org>

On Fri, Jun 06, 2025 at 09:34:04PM +0200, Benno Lossin wrote:
[...]
> >> >
> >> > All `Cpumask` functions then take `CpuId` instead of `i32` as the
> >> > parameter. Needless to say if we were to have a cpumask_next() wrapper,
> >> > the return value will be `CpuId` (or `Option<CpuId>`), i.e. if a bit was
> >> > set in a cpumask, then it must represent a correct cpu id.
> >> >
> >> > Make sense?
> >> 
> >> Just to make sure, the `nr_cpu_ids` stays constant, right?
> >> 
> >
> > Sort of. I believe the value won't be changed once the kernel boots, in
> > most cases (modulo NR_CPUS=1 or CONFIG_FORCE_NR_CPUS=y), it's a
> > read-mostly variable not a constant, and the value gets set by either a
> > kernel command line or how many CPUs the kernel actually detect at boot
> > time. See:
> >
> > https://github.com/Rust-for-Linux/linux/blob/rust-next/kernel/smp.c#L995:w
> 
> It's allowed to increase, but if it ever decreases, the invariant of
> `CpuId` will be wrong (ie it's not *invariant* :).
> 

I don't think it's allowed to be changed once set after boot, certainly
not allowed to decrease.

> >> >> @@ -101,10 +108,16 @@ pub fn set(&mut self, cpu: u32) {
> >> >>      /// This mismatches kernel naming convention and corresponds to the C
> >> >>      /// function `__cpumask_clear_cpu()`.
> >> >>      #[inline]
> >> >> -    pub fn clear(&mut self, cpu: i32) {
> >> >> +    pub fn clear(&mut self, cpu: i32) -> Result {
> >> >> +        // SAFETY: It is safe to read `nr_cpu_ids`.
> >> >> +        if unsafe { cpu as u32 >= bindings::nr_cpu_ids } {
> >> >
> >> > You probably want to check whether `bindings::nr_cpu_ids` can be
> >> > accessible if NR_CPUS == 1 or CONFIG_FORCE_NR_CPUS=y, because then
> >> > nr_cpu_ids is a macro definition.
> >> 
> >> Just define a helper function?
> >> 
> >
> > Maybe, but it is then "a variable read" vs "a FFI function call" if we
> > want to check every time in clear()/set(), of course if we only check it
> > in CpuId::from_i32() mentioned above, the performance impact shouldn't
> > be observable, because we won't call that method often.
> 
> Sure, you could also have a rust function that is inlined that does the
> two different checks depending on the config.
> 

Yeah, that's what I'm thinking about as well.

Regards,
Boqun

> > Either, I was just pointing out the current fix may cause build errors.
> 
> Yeah that should be fixed.
> 
> ---
> Cheers,
> Benno

