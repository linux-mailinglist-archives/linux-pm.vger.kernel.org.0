Return-Path: <linux-pm+bounces-36616-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C632BF9B7E
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 04:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A235A565764
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 02:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62C58F54;
	Wed, 22 Oct 2025 02:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aKlNqAj8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3435A21CC4B
	for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 02:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761100053; cv=none; b=aXmXCLkgUdLwXGpYprjqbgGgGXFiV85cS61H2kNRex1AubC746wmAUPFdx9dAW+9u4GxwuGfk471MDmwdCUK5AO3wCpyrv8OZsBeWmeZxKNPv4i4kvnMt1OCGUSVRimoLHP58Ely2q0SRzeTVFjj4Hq24xoCI926/Cem9oeeEq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761100053; c=relaxed/simple;
	bh=A+P0s8xM+ovp2iCRdR2wm/nwAd8dNmdnn9/2R/2q9mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1tlMLYouApvWy6jUi3PHusNML4lqritlO+EnbSjlDtNc4W2HMQYlB4QbVixvhH2eNzSvgyfRhtq6jpmmvkZsXQpuXlHN/X9FHMt/uC4iCKRtZhEvZZTM15OKulY0mG5ouNyxhC0sM5HmJ+kvlQ4O9zvPlrTaYDZGH/A6w39Bg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aKlNqAj8; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-330b4739538so5909573a91.3
        for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 19:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761100051; x=1761704851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Kynz5f6kQn3G9h5f1VDmHPl6BLtsPQWnOh0t3sfi0M=;
        b=aKlNqAj8jXvvWoICbfNwKUqLGP/aPJt/n2SESZe6VHiyTTE8J40WagoO4bVRrT+qiX
         OgTdYRYckYQlquqlWtROXxhAwy+utRm1jmHF5SAROzafg4jUZ3LaXBg12KXTsMoK2QTy
         MhoEL5kohuLJmswz8GF+RPKgG6gVOPrXt2mWXRituP26sm0KzzdVtDXj1zcQB0fCMvoV
         EWFQ4s/bvRvRkPtHqWB0VAwv5CQ5QwEyQAtaIx/wbAK6O0V+wsI23tum/tKi+cZZ8nm/
         MU3CXKwTo1bA2ndzRTVmIVKL7gBE9yBOelXsJxfxoEncwWtTZfW4pUjNlmChldVCbrmQ
         vEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761100051; x=1761704851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Kynz5f6kQn3G9h5f1VDmHPl6BLtsPQWnOh0t3sfi0M=;
        b=JcJw3igDU0VK3qTwo7emVGj/W5D79mPMCnG0AQQ8IHTXh+cRJzpkYtWW1+1JK8fmNO
         UaYOAf1n0+PZIHRXCEl5V2PoM7J5aQGarAZtzUzWhfm127IQugwc/7TDKu+v2nIlSEts
         LkFnR57BsVbGJQ3C1AM5XUKSPlg7Q1bU9HWamNKX9miOuC1paxYHHQqrm+dKzj9fQI8e
         /oCGeTDAcMqbFRI9rPvr1SI7vMbHRtL32IgecqT02s6anbdIbJ1DjqUMzQRWd018UipY
         848pEh42qRQ/vCDhaEKs3mv1MG7ABXkJAGDoq25eNTycQ7uSddhyul0jbM6A46S7poXn
         Zg5g==
X-Forwarded-Encrypted: i=1; AJvYcCV/etMxrhA0GQmN5Jd6BGeuC4EfK/XCWhPEihBIFW6nZ54txj0jZXcsYN1bVANDNayNr77mSgdrBA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2mZ8eBpCxcqxMo8R+Qmu4wCDdomhyeTJvGdQz7XpEJdutzGEN
	oINtULsWhz+waFdxIKgH4cUMH7mKakTXsdkfk915WqyOZ0zAm6W0JctABpzVl/eEUqk=
X-Gm-Gg: ASbGncvbW+LyhHq2Mf7ozlqJofoph0hNSILRVP0VfKPA83NZ8cZBzjGj4QucIVr9q5Q
	hXEdugK7xCmkJmJmpGFrlzUtoX/z8npiTnsU7EvHXjllFZ48EeANWNpkpjTJacT3meYKHTUwuWK
	fC8rTu8QiUHgA12zPvXZ9RUxcL+lDrojYJcqhTb3ryzQa4y/fdj/xsV79MdSlvikCbAhMLaGKk2
	hAlPG/oZxo6e4T5O/T+F9a6FGN9zETPZ68BNjpIP9bd20g/jv4lxN9kmUBMOfaF87RGoMbjlpDt
	cjJDrwuxRt8RLFsa7T2yHMaDLqG6dP61CLYR2ZfOk+cEnNQ942WVEubDJdY5nlKj37foQo6kTrb
	jYfrEHnkNO5gq3gG6jl+co4WvDiQvHb7WFr9VnATpnAC3AU4PNV97qHdCkxTmlwCaRES4SN+PKd
	+xCCAGZ3dIvfIEsHVx/i4Rvdk=
X-Google-Smtp-Source: AGHT+IFJLVFpIR1aWCyZCFOIKnAA6a58lXYXHZeAFELxfkfneTEN5uN4Dh2U6O2etE9y+Y+gRJvc9A==
X-Received: by 2002:a17:90b:1dc6:b0:32e:64ca:e84a with SMTP id 98e67ed59e1d1-33bcf888575mr30106334a91.12.1761100051119;
        Tue, 21 Oct 2025 19:27:31 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223f11e1sm981092a91.12.2025.10.21.19.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 19:27:30 -0700 (PDT)
Date: Wed, 22 Oct 2025 07:57:28 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v18 11/16] rust: opp: fix broken rustdoc link
Message-ID: <gcdcwpotzidrksmsnyvesnojcylbb2fqpiue4fijhj2cmayli5@7lpyessslxka>
References: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
 <20251018-cstr-core-v18-11-ef3d02760804@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018-cstr-core-v18-11-ef3d02760804@gmail.com>

On 18-10-25, 13:45, Tamir Duberstein wrote:
> Correct the spelling of "CString" to make the link work.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/kernel/opp.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

