Return-Path: <linux-pm+bounces-10554-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6B79264F2
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 17:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3CA028415B
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 15:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDC7181B90;
	Wed,  3 Jul 2024 15:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InE0LzIp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFF0181B8C;
	Wed,  3 Jul 2024 15:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720020901; cv=none; b=bqm2VjzSyuFd6d0X6lFj9YWHWJjODDizLQ1oPZrFUbHlvfVGOe+oq/CIowiKAx2ROa1KxH1xj7PD99Dvirn5eOiiwTkCcA0F8mPoTCB6+K0Lltw8GbrcjTUaCQRADREpOhRIQkzFeUM5BJhkrlkNYOMr0m9csRzCTY5JKJ4d3zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720020901; c=relaxed/simple;
	bh=WoXjh+ypt7zasFF+jb9rD3vMfTVDYAqnKxgrqLWK2PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNYNVSosdNRJ+2ky78YpjDFewrDGpKOXdxgNcswSjPkML8Hg4j9N0H3THkF6QoQmKTJCSsnU7g/cQXFr1st1VUMRbfgA9fjWFFYczp4bCUbx9gbvAKufSH/SUmP5zTgAts7s4VbkIj0PWbtEO8xGwHCkOUQHgRpeoI7j4Or1VuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InE0LzIp; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-79c056a7d4eso324181785a.2;
        Wed, 03 Jul 2024 08:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720020898; x=1720625698; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=x/l9NCWIE0l4Bx+XrdXwTpflR2LutCCCxUOf/LMelxo=;
        b=InE0LzIpza2ZgMh9M2YaFaUduzO8Vpo3UsvAfnDYNYQb45XtApSbseKOtnLbUA5PvH
         ovD4Fp/1nIzQElU0/3/9t4zj9bAfQZ+9gWPBOIsA/NqZLo/B3Ou/q7j5NGKYH19Eitxd
         RumuYu+s/AKxlJ3KfU/y/maq9/VBtpIF1rIiznqaBmoouO86jYo1SzhZLbr/d38PPzJo
         OYP4gfM39yVfCcMZ0gwttk8z6QHgdFhP/U8imUKIGo2bwTXspUxdy3MKIu7ONFWTnjGs
         x+hCFkJHCFqisoEbQeQKOw11c0viD37/xG2EH6UHYMT1J/5JignLpY/wVhQqemMU5qrv
         BkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720020898; x=1720625698;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x/l9NCWIE0l4Bx+XrdXwTpflR2LutCCCxUOf/LMelxo=;
        b=th1L2yK387iY70hCS5SJnmAVSyJ9AOMRH0EAftCcmvjNoVrr+uoL2uv/oKiGfEvVAr
         jHMWXKKWiD9KNHwFNU4PTb2v4GuWupGwC1a1ygxld6WB5IhZG3p/5+ecmsLxwwWnBU//
         Swhhyx2+4aSQJqvXE3NpUAPbcOoP5gvuva2DQtIBdJVxLTwV+O+QMyrbkyVdtA4gahAi
         wR4oLc+mGTMrsF91s0hYSZgzusvCVNrEj5FWNBk7t03Qu7eI0KPLPk1WuuAZrkfdq73+
         d34cr4oedBODhmwgn+kUxpjHkvb2I/zTCekq79ULOWNLXJqxn4wiPFoLw03ljbZ1AAL4
         Eh8w==
X-Forwarded-Encrypted: i=1; AJvYcCVwWGchL0LJmnLaIfQnPhNQMbvnsXNOs9+dRPfrSnOfpQTgLkP+HvBQpoCpCkhyU8twN2UjzsWMhnJb5cvVdNVMDYjkxHzxLO9EbIJWV3Vh4ArCWfprm2TF8KBkChgE5dJcehAfvJEAWwVyaYW1xUQdtBoVPdHqyxEaoKd1aOVzmJCJpW7I1g==
X-Gm-Message-State: AOJu0YwWChpflNT+kziy7foxsWmmQBwO1oxNfp2o5wbNNL/MgrI6z5Yx
	Oij8laVjUMXA1PnoogAutCKAOeghuCkYa0oT5kRWkcXA1f8xZotH
X-Google-Smtp-Source: AGHT+IEO4d2+aOnQArZ0S0ETV0kECHeJ9pw9DdLn3G4dWl2YLKyImfiX01E+IK2AhKyvjtzb/1cuCA==
X-Received: by 2002:ad4:5d49:0:b0:6b5:de1e:4bc1 with SMTP id 6a1803df08f44-6b5de1e4df1mr37812496d6.51.1720020898517;
        Wed, 03 Jul 2024 08:34:58 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b5e3d4b56csm4534756d6.48.2024.07.03.08.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 08:34:57 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 244211200043;
	Wed,  3 Jul 2024 11:34:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 03 Jul 2024 11:34:57 -0400
X-ME-Sender: <xms:oW-FZjiKjNwbtqpKpce0t7OUID3NoJS9L5vePjOeg6UX4whTG3YH7Q>
    <xme:oW-FZgBGm2-keJLkSXRoYqpwmfXO_4u60M3TwaI4hdRpC0YSUi6ijx57lQQ0zZ21E
    8s1UpbVpr5y2-1q2Q>
X-ME-Received: <xmr:oW-FZjEmYYWtndaJ7WpAG141qzt9Wu-EQKvbeOKNER3tMkOhkKkaQbNBsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejgdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtuedtveethfdugfejieetleekteekgeeguefhvedvteeljeelteehhffh
    ieetffenucffohhmrghinheptggrshhtrdgrshenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:oW-FZgS1vAodjsg-AiSVHGVlUnwX5eeNDGhBHIXHEX6ILo_GI9F4tQ>
    <xmx:oW-FZgxv7rDfADyfXu9HSStSXn_BeRp6ZYFCMfXfmZSsdVr6bLViMg>
    <xmx:oW-FZm6sQNUNo7NQ9Cr-q8TOVusgKy9Yz4ubNw6RMtRwoO7cd5v6fQ>
    <xmx:oW-FZlzQebP0q8E4d-OfhD29xYWX6oQn6Qv1mdfdNOFqVHhlPk6oiw>
    <xmx:oW-FZggskcFHT1Oa_tFVHo1ZR_NEvvBsLZNdlHjVcevbDmsXaxh7SJ6d>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jul 2024 11:34:56 -0400 (EDT)
Date: Wed, 3 Jul 2024 08:34:55 -0700
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
Message-ID: <ZoVvn0QCSR8y4HQJ@Boquns-Mac-mini.home>
References: <cover.1719990273.git.viresh.kumar@linaro.org>
 <fe8e9a96b29122876346fc98a6a9ede7e4f28707.1719990273.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe8e9a96b29122876346fc98a6a9ede7e4f28707.1719990273.git.viresh.kumar@linaro.org>

Hi Viresh,

On Wed, Jul 03, 2024 at 12:44:26PM +0530, Viresh Kumar wrote:
> This commit adds initial Rust bindings for the Operating performance
> points (OPP) core. This adds bindings for `struct dev_pm_opp` and
> `struct dev_pm_opp_data` to begin with.
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
[...]
> +
> +/// Operating performance point (OPP).
> +///
> +/// # Invariants
> +///
> +/// The pointer stored in `Self` is non-null and valid for the lifetime of the ARef instance. In
> +/// particular, the ARef instance owns an increment on underlying object´s reference count.

Since you use `ARef` pattern now, you may want to rewrite this
"invariants".

> +#[repr(transparent)]
> +pub struct OPP(Opaque<bindings::dev_pm_opp>);
> +
> +// SAFETY: `OPP` only holds a pointer to a C OPP, which is safe to be used from any thread.
> +unsafe impl Send for OPP {}
> +
> +// SAFETY: `OPP` only holds a pointer to a C OPP, references to which are safe to be used from any
> +// thread.
> +unsafe impl Sync for OPP {}
> +

Same for the above safety comments, as they are still based on the old
implementation.

> +// SAFETY: The type invariants guarantee that [`OPP`] is always refcounted.
> +unsafe impl AlwaysRefCounted for OPP {
> +    fn inc_ref(&self) {
> +        // SAFETY: The existence of a shared reference means that the refcount is nonzero.
> +        unsafe { bindings::dev_pm_opp_get(self.0.get()) };
> +    }
> +
> +    unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
> +        // SAFETY: The safety requirements guarantee that the refcount is nonzero.
> +        unsafe { bindings::dev_pm_opp_put(obj.cast().as_ptr()) }
> +    }
> +}
> +
> +impl OPP {
[...]
> +
> +impl Drop for OPP {

I don't think you need the `drop` implementation here, since it should
be already handled by `impl AlwaysRefCounted`, could you try to a doc
test for this? Something like:

	let opp: ARef<OPP> = <from a raw dev_pm_opp ponter whose refcount is 1>
	drop(opp);

IIUC, this will result double-free with the current implementation.

Overall, `OPP` is now representing to the actual device instead of the
pointer to the device, so the `drop` function won't need to handle the
refcounting.

Regards,
Boqun

> +    fn drop(&mut self) {
> +        // SAFETY: The safety requirements guarantee that the refcount is nonzero.
> +        unsafe { bindings::dev_pm_opp_put(self.as_raw()) }
> +    }
> +}
> -- 
> 2.31.1.272.g89b43f80a514
> 

