Return-Path: <linux-pm+bounces-20088-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B24F2A05B46
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 13:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A33B188A729
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 12:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852D61FAC5E;
	Wed,  8 Jan 2025 12:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yMu5AMsf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DD21F8F07;
	Wed,  8 Jan 2025 12:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736338501; cv=none; b=X7c+XpxBlOfyH3MKh3WwksBYtPuC819PakyQ0bkLOGNTlQfRx1c83bnrRtiqKav8D42fVAIOyS+jXsWYDByyLmAzb9WZoLeR/qFeJj9hB5yDtXNRhPEgMvWlo7RT1CrDcSDve94+k/3InXnTD2uI88dIJ2CMcIwqJsZy0TtL9Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736338501; c=relaxed/simple;
	bh=ucoyG4O7Dg6LGWBoP+zrTqY/WNLhwkS+ljmKUYtFkpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WivulywaoFypx3zpEbPbDbvuDcIZyk62VYkJgRoTYE1FAGN3AuHNW8iYhUPdGkoBF8loJzsqjTLGokmnUso9wlAWzj4HOUm3sKpnRboFtDT/B/4DGhNmKlk8GrupJolYHlSsVISs4D05YnhRzQcHfZzMv3lYRAkentWGDfN55kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yMu5AMsf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B215C4CEDD;
	Wed,  8 Jan 2025 12:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736338500;
	bh=ucoyG4O7Dg6LGWBoP+zrTqY/WNLhwkS+ljmKUYtFkpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yMu5AMsfCoik22t1xZqxwdzrftYY/pOso6SckSTL55S490ZVHEnXrXFtHleUKXnyv
	 qCWP05JKWHukuwmLlWWUyvEDRpSNwiM4LwmFL4/pdmVO3l0Q5ncZYksrEWyRJzNTvQ
	 f3bnqFNLPn+vaDXurdWRh4iE6hlqisSAKISXyq0E=
Date: Wed, 8 Jan 2025 13:14:58 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
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
Message-ID: <2025010829-kabob-herbs-8ce6@gregkh>
References: <cover.1736248242.git.viresh.kumar@linaro.org>
 <429b7539f787ad360cd28fd1db6dc3d6c1fe289d.1736248242.git.viresh.kumar@linaro.org>
 <2025010734-march-cultivate-bd96@gregkh>
 <20250108110242.dwhdlwnyjloz6dwb@vireshk-i7>
 <2025010835-uncover-pamphlet-de5b@gregkh>
 <CAH5fLgg+XQ2ALpW2x2Mwc4h-ZMo8ZpynH3VA9kxFWyg5SgvmXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgg+XQ2ALpW2x2Mwc4h-ZMo8ZpynH3VA9kxFWyg5SgvmXw@mail.gmail.com>

On Wed, Jan 08, 2025 at 12:55:38PM +0100, Alice Ryhl wrote:
> On Wed, Jan 8, 2025 at 12:52 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > > +    /// Checks if property is present or not.
> > > +    pub fn property_present(&self, name: &CString) -> bool {
> > > +        // SAFETY: By the invariant of `CString`, `name` is null-terminated.
> > > +        unsafe { bindings::device_property_present(self.as_raw() as *const _, name.as_ptr() as *const _) }
> >
> > I hate to ask, but how was this compiling if the const wasn't there
> > before?  There's no type-checking happening here?  If not, how are we
> > ever going to notice when function parameters change?  If there is type
> > checking, how did this ever build without the const?
> >
> > confused,
> 
> Rust auto-converts `*mut` pointers to `*const` when necessary.

Ah, so it's magic :)

thanks for the explaination.

greg k-h

