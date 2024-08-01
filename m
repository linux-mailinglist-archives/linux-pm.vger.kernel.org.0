Return-Path: <linux-pm+bounces-11811-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE1E945013
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 18:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15CA5B27FD4
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 16:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680981B3F21;
	Thu,  1 Aug 2024 16:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrkCFjWd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFE51DA58;
	Thu,  1 Aug 2024 16:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528332; cv=none; b=ZwNJIICYChH/AVIoJGXHsC9C2jijUduycBA7SPyf5nwHo+uBR2BvvvvAP0T2j5W0Uou7NlYXUV0jkJfgyLJIIBZavbLddK4JoHvX41LoUnUbO8gO8I5smKEzESLpbm5pe5qnrVbQGjdiZAgJ/DJlnLIRjuLmk01zhRoskmg83no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528332; c=relaxed/simple;
	bh=xpE5ZfVKnxqG5WERp0OB1HLOa7RKYVijxWtgEhj0+Rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fujlG3n2dBpjuiTvs0szProKp0HO13CZjNzXBkwqrtids4fiei+mtwfa1ai16BYm6r9wLGhqzo10QEu/JomBlcs5IupFEHl8qMts2A4rfZIUFnxYasMRAQ0fRH/NahMXBR0JnZaFVHm1ecqw6mag43Bow9d6DIAFFpzcmAbEV6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrkCFjWd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C8CC4AF0C;
	Thu,  1 Aug 2024 16:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722528331;
	bh=xpE5ZfVKnxqG5WERp0OB1HLOa7RKYVijxWtgEhj0+Rs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LrkCFjWdx0vDUmXDYIB9x6+f44l0222FvnFFDiq7o5fBefmAKYKTsR228tjJnjDmf
	 kXbxrtf2nWEA+K3PIZOJ/nmjDvZS3e5uZZyyE4wOrvk9gGoGiucL+v8YoOoUgCnyLh
	 ZYpcKshuvdcD+SNX5rtImPzDdO7ruoNNOSjS3A9nxN8KIzlsqr7EO1p1/ukLV+Z8Zo
	 7F9OHykWNwo9dNj/HyJGTYIJk/uc9KtGyULFOw0+KH66JshkF1nqf2i+aYpH3C/ozc
	 nLsASQjcHL4SbugXKvUlZ3hggXyoSp4fqY7uJ34C06nX40PMI7lUTLzWr3DMvMsu4G
	 cU+d3SEGZPf8g==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52f00ad303aso11036231e87.2;
        Thu, 01 Aug 2024 09:05:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXujggnkzX0DqCpG6q6yNBT1EhFUMwdijpcicPf1IlNEqc3CqkumVsP1WgQ+1WtV0xFhUV3CNwR2EZG2LrO2phmZB0uwK/E/7QC7ALLPNX2MeV2PyEXvfkB+5I9GUHkKkqHj48weofbP1IsahIMpqO0bIeXgnljMjR/jz7H2kvy4KgIIq0kpA==
X-Gm-Message-State: AOJu0Yx0JAAeVEHYoC77QOVdVA/wpgp9uzLVFvK6a8ulYhdRhMQRnG8J
	FO23dpCMEGlQ9vMX/bytySJiExulvG9Rz/bG7Sf4awZYc4kfQcKSpJ6NiA7axR5UUNcVXIvy9ZH
	XySXMW5ZLqSCl+yuC/RR9iEbUPw==
X-Google-Smtp-Source: AGHT+IFSaBHEBx0cPsFVT0dU/9exSRj56/Zithgk5yZPkdk+2bYopgDbA53wywVrQFM+8T64rnpjtlyO3GuTZcOUNLg=
X-Received: by 2002:a05:6512:39cb:b0:52c:def6:7c97 with SMTP id
 2adb3069b0e04-530bb3d43b5mr254230e87.45.1722528330066; Thu, 01 Aug 2024
 09:05:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1722334569.git.viresh.kumar@linaro.org> <e0df2db1caa49f15628aa18779b94899dcf37880.1722334569.git.viresh.kumar@linaro.org>
 <CAL_Jsq+SxdPyb3qQyce7u8Ur=WCd1p+pQxJ+yJrTyS2xk3BF0w@mail.gmail.com> <20240801083119.bwd6k6vimwyhv6cl@vireshk-i7>
In-Reply-To: <20240801083119.bwd6k6vimwyhv6cl@vireshk-i7>
From: Rob Herring <robh@kernel.org>
Date: Thu, 1 Aug 2024 10:05:17 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJe4W4XV1RwkRRhJ4U=TzhgE5vo6aBsXBWjPzU89dWeAQ@mail.gmail.com>
Message-ID: <CAL_JsqJe4W4XV1RwkRRhJ4U=TzhgE5vo6aBsXBWjPzU89dWeAQ@mail.gmail.com>
Subject: Re: [PATCH V5 8/8] cpufreq: Add Rust based cpufreq-dt driver
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, 
	Nishanth Menon <nm@ti.com>, rust-for-linux@vger.kernel.org, 
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Erik Schilling <erik.schilling@linaro.org>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Joakim Bech <joakim.bech@linaro.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 2:31=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> On 31-07-24, 15:14, Rob Herring wrote:
> > We don't want anything in Rust based on of_find_property() which this
> > is. That function assumes a device node and its properties are never
> > freed which is no longer a valid assumption (since OF_DYNAMIC and then
> > overlays). There's some work starting to address that, and my plan is
> > using of_find_property() on dynamic nodes will start warning. The
> > of_property_* API mostly avoids that issue (string types are an issue)
>
> Okay. Migrated to of_property_present() now. Thanks.
>
> > Also, it's probably the device property API we want to build Rust
> > bindings on top of rather than DT and ACPI. OTOH, the device property
> > API may be missing some features needed with OPP bindings.
>
> I am not sure which device properties are you talking about. Are there
> any OF related examples available there ?

device_property_*()

Basically a wrapper around fwnode APIs taking struct device rather
than fwnode. While I think the sharing of properties between DT and
ACPI is flawed and converting C drivers from of_property_ to
device_property_ calls is pointless, I think since rust bindings are a
blank page, using the device_property_ API makes sense.

Rob

