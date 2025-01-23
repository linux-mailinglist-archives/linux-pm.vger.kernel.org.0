Return-Path: <linux-pm+bounces-20827-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C91A19D62
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 04:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB634168103
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 03:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A5112C7FD;
	Thu, 23 Jan 2025 03:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GdNeMPoE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213CC8615A
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 03:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737603844; cv=none; b=RrmsNsx6i0vGGq4FEvpyaARNrfhhp51ewv5hI6MXotnlZorGMND65klieC392r3bI9hURn+rAI/BDz+wiKbfU8Mz2VKYI+ebQ3XBYcutnuAVlgMg/Sd46Lp948prkYS+mR/QzNMKoXCNN2apsp8Hq59luy+Kgx+atQOTEDltyV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737603844; c=relaxed/simple;
	bh=70QXJ1fUDSF1/EMFEoazUOtCExyx/cHHDB4wx0+O1s0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WK6nTL+Lq6r/EzuHcnqEyEKYNixZ7pjIYVKVfmiSvoS8vIp1Uef1aRg+mQOeJcNPZarvlqZM1o0kegAMmu+7I18G4aYw4aHIL74/mryF6dXHdAZDrny19uLOLk+ZBQerIV+cuphS6PLZAdxip82TDgeLoLonrTuL6RBBj5XA9Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GdNeMPoE; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2efd81c7ca4so684942a91.2
        for <linux-pm@vger.kernel.org>; Wed, 22 Jan 2025 19:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737603842; x=1738208642; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R72c6XuQv5WvOJOqP2KYpXDCD+4Gn1lpWJ4fFcfXZ0o=;
        b=GdNeMPoEx9udRn30HmlRgZucp4Gy4UNCxLxRyTyEiisFkaChDbFQKzX2592E9WiZnP
         7RkUXaN/uzhuuW80dGIwjPRZAxivXAp3VpF2n2rWT48qxBpIX+WJktUPng6jgSyv2WYA
         aLz9ss+AW8q+TJnWqkPvX1E/vNbLtvpVEfZ0Dy5+KGEuzyGjwX6MoNJbQDLJjzCy3VGY
         8trbtpTju+5pDd70DAgUHURYfBWpt6Swi7pQYaY3jONbwh0l+TBvKKy4VuHRoHKimRK1
         VB5Nb1rdis/8AWOwuE/Hw9zKOZpqtC4DfUs+2RqZZhA415ITgyAdcl2jOLgSfyclTRra
         RfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737603842; x=1738208642;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R72c6XuQv5WvOJOqP2KYpXDCD+4Gn1lpWJ4fFcfXZ0o=;
        b=pBghieUD5VkClz/LaVzUKLX4qrrdydVjABw6D9W8Ucr8+af+G72GSqjg2SsSEWp9Gr
         6dhZp6NU7p8KnOSwL8/I9E3LdfrorzDu45JNYaGXcN/p9wr7Kat2z6gx1cYsf2i/olDB
         xBrhe8N2u83bWn3qAsheBnIavcMAbpI9rmzFqxOjPL/cswmQKxQuJLkZhFAUx3iXZvRd
         ZAazof1TRXPDmSvxbu4zYRluIEs4hKcpY8xF5/A7U01HsEnk9x2eKTL1nv+16cYKfKmf
         yApg9k3mKgIVwup/FxkvDanfEL3q1JVV+qeAohn93CscQSdWgRcEHoD3SG0vpuMH91Fi
         V98g==
X-Forwarded-Encrypted: i=1; AJvYcCWoiR0tL86nzoAdJaesXWQDqZleWmLnygZEOuO5jiYX5+LBEWrgAs0yZw1Baad2l4AErf28l3FC7w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3jtTtGeTirkkVeoZnJ+WjYY0GmcCs5oLVMCrnvnu+Ff5VJbEm
	boFeP6yhskHxKIAGlrUkHOTveIEHC0wOvjaAjGXO41I3mlGTKhi5QS+hfoJUXbc=
X-Gm-Gg: ASbGnctPFLF2GcEYY/tODKqx4zj9nDAbkOGiacJB8GuC1pT1lfBjKKZp/XMaJQhy3XQ
	Tlx9LfhNfblSM6mrMwMTlkF8QMrzYRUxOdf7sLi6YpA/Q3RxEG5iwE0BVYOnQOJ4+zoxuZCccv2
	o1UmOLA/tWYkJPtHjFRqjTQ73Sg/OQkK//B79X1O1r1bW9gS1VRtWjYZW5Yr77sXjMucHBUAJUY
	sE/ZOD3zuw4F6kSXWfB6TFpzZtvkQau1P4uFtw2CyrNJ2xrsDdhQmp93htTviFUtf/ILcYR8ZV2
	9/Ccmt4=
X-Google-Smtp-Source: AGHT+IFYMjUGvNd0ZVMIg8ZM9TNP3wdvfJpc+nt1WjZ/r0Fm5w99jQ04/Kks0iX0dZ5f2Icp+icS8Q==
X-Received: by 2002:a17:90b:530f:b0:2ea:5054:6c44 with SMTP id 98e67ed59e1d1-2f782d86491mr34109958a91.31.1737603842385;
        Wed, 22 Jan 2025 19:44:02 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7e6a5e30csm2570979a91.7.2025.01.22.19.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 19:44:01 -0800 (PST)
Date: Thu, 23 Jan 2025 09:13:59 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
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
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH V7 06/16] rust: Add bindings for cpumask
Message-ID: <20250123034359.pz7w64fyr6fopl4r@vireshk-i7>
References: <cover.1736766672.git.viresh.kumar@linaro.org>
 <4f233d3f6d593ba2e1cdde68af44200cae74f6f2.1736766672.git.viresh.kumar@linaro.org>
 <CANiq72=o+uc3ZnNrdkuoSGSL8apNE4z4QwpvsiLfGzXFywSLrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=o+uc3ZnNrdkuoSGSL8apNE4z4QwpvsiLfGzXFywSLrQ@mail.gmail.com>

On 22-01-25, 15:40, Miguel Ojeda wrote:
> On Mon, Jan 13, 2025 at 12:23 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> >  rust/kernel/cpumask.rs | 85 ++++++++++++++++++++++++++++++++++++++++++
> 
> BITMAP API maintains `cpumask` on the C side -- Cc'ing them, since
> they didn't seem to be in the loop?
> 
> Relatedly, should this have a `MAINTAINERS` entry?

Updated MAINTAINERS for this and clk bindings now. Will be part of V8.

-- 
viresh

