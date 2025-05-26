Return-Path: <linux-pm+bounces-27669-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6ADAC449A
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 23:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FE3F7A4B37
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 21:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080E52405ED;
	Mon, 26 May 2025 21:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnXKqig2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE0E1F4CB5;
	Mon, 26 May 2025 21:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748293374; cv=none; b=bjRlH0CLsJB6zDkaC0RVmEPPcyx3UTM6g9f+CHDOye8FxKL0kKaBsW3ikMytp6nsrn5Y3UuHT1ssCarUDloNSdiEgfd5Vv+xSmn3Q78Bx5ec7u9DG0yUi393KhrfpHF5NI0/D2oxX4Bs0yKzbaWAWNikcyhPIL6d1yjMbi4LNrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748293374; c=relaxed/simple;
	bh=HFoLzWXsdbXPDnO+7KButpJfxjK8elvqnYvhrA5Hbak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gawQJtnQbzQRqZopQrvr3acdaYtcN3Ck0Wz9rhVE0YqINMI4nkh0VWL4Le2R9lAIfJ0s2FF3f+v0qedHJinoF1ZZoAfHGAqdXCpaesrx6MlY/U4ZzhodJMlRO3Q6ez4gwTXvLRUT+4yFF0bzeS51tls9+ao3W/lTZZyJ1cbtB/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnXKqig2; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3087a70557bso463641a91.2;
        Mon, 26 May 2025 14:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748293372; x=1748898172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AC1/MK6Cj/tOt7Y2lAVJFz4X+BOSYolz6DZCpGYHzE=;
        b=YnXKqig275Uo0aR8mYbs5ag7a/Sbd9mElbuIz2k8VVpY8cleLODpyZPTjRT57UZSyv
         RCTUz8sj/i43TQCwgkHdPYr7n0gFPk8s2fyUL0YPRZfpdMPAHtLt8Z0tCsrs7Lkj53KE
         iVRL3TIuLvtW5MabE1mQSJQvrJ11CF7LAZkLnItBE9/A8HUOYFIFbz0meuE41gPpGYMG
         D9zawFoeLqqw6r99PHAEPKGTlfQHQl0Pu6V9Hbm6yqiFj0C7o5mAGfdnadcxToDPdPse
         oNA4A3X6xfXHiXYlsRJl6jRaR4S3mv76lNMLPYinEWAMp0rzQ5bXW7di2DKQdGdky1vW
         I6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748293372; x=1748898172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/AC1/MK6Cj/tOt7Y2lAVJFz4X+BOSYolz6DZCpGYHzE=;
        b=wkfu4L0VyCsvHPFy9GtsCmNfzPj0e2gHnZQusOGO221qsZ0nTe7lugB99jHwTLaVYM
         sVKnuiR3xUQUTaZQXl/bzlIMEl9GpxYvwW9mI2mY8Jo+KEA3Yg3fNQcg/qz15+CERNfj
         ON5kIlO3DcysAj3p8Cf7ULNnJmPDwo/NcvrL1bSPmAJjH7VsQoi9QD6lhpyXXmFnHmhn
         bKYP3g0II8JOmzn4d65QFh+6MqD0TdA31VZPB5HLwoTeADJuZp9Y9ssL5tfrkBMMkIUk
         IdbfqeHUxB0dsJvYebvS0Do9QYsR6cP0F4om/SfxRF0/94+xT8doq0Fqv92NfZtxNl+K
         aVmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT8MNDGsQVmZIUb2Fn+ZCmXbgv2PsWNfju6sBjWUo1LawNMwHlLsRFWIVnNfdF9y5/gMWenWeM6Eankqgsz2Y=@vger.kernel.org, AJvYcCXG8NvBYn3laSTt6TZOsMuG1WOl/plPJ7RMNrIy5lW83qVZhby7vA1WenxT8PeSeNrv7PT3fc+84xYnyVU=@vger.kernel.org, AJvYcCXTRlr9Y036CLjlwRhxMxNcKGY9R390LvTUzW54E8pPDdqPV4Wp+aAW5TNFQFA9J0AHl1OdvaMm64M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxE49ZHQ11W/SXN9F6iFQDocGiJocnfFJ6kSLxmfUMnIeyzjNC
	TPtHjEEh9fLFBdgqzcOsOsNSKTbPNw8FWi2t6mPZkBvLQJZwy0ofNdFAniTAOTQ7/0Fb5wExeu2
	ZzGCdcZSx6FgdDcabWeFlMU+wGqLrmIc=
X-Gm-Gg: ASbGnctXHQSQL5kWCOaqOzT88pUwtCB/1UcGdObrDWcXcvVImGBApIfdIEMfH/IVZvK
	wGklh44fX0jvL0dFT20PyQ5FiJ6kHU2szMbs9EWggnlFp5iS0A3a9EfSjWQRrETNZw9CCmNad4p
	uTHjLo5Xjywe86WcmO/o9d4SDABB0aN8HRodWLtZgUo4M=
X-Google-Smtp-Source: AGHT+IFVOZbMnrJUIuHlM77IXFRc/w6606oR8GF9Q4Qc8rse04e4M7th9KMo/MGfPgFY7ftmMEWzzHMCwEqIMjjisdU=
X-Received: by 2002:a17:90b:3b8a:b0:2fe:7f51:d2ec with SMTP id
 98e67ed59e1d1-3110efdcef2mr6176790a91.0.1748293371579; Mon, 26 May 2025
 14:02:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a80bfedcb4d94531dc27d3b48062db5042078e88.1748237646.git.viresh.kumar@linaro.org>
In-Reply-To: <a80bfedcb4d94531dc27d3b48062db5042078e88.1748237646.git.viresh.kumar@linaro.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 26 May 2025 23:02:39 +0200
X-Gm-Features: AX0GCFs3mitDZeUVaag9Ym6BT3_NQqZhEEXfqbYGVBcWRJm2ip1NubhIC79BqA8
Message-ID: <CANiq72nLpziMATRyod2qg8_MjtpO6OxOggAyanJ=Kd_FLwhy6w@mail.gmail.com>
Subject: Re: [PATCH] rust: opp: Make the doctest example depend on CONFIG_OF
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, kernel test robot <lkp@intel.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 7:35=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> +/// #[cfg(CONFIG_OF)]
>  /// fn get_table(dev: &ARef<Device>, mask: &mut Cpumask, freq: Hertz) ->=
 Result<Table> {

Quick note related to this patch for the future/discussion: I think it
is a good idea to keep `cfg`s as local as possible, like it is done
here, although for documentation I wonder if it may be best to put it
at the top and hide it, e.g.

    /// ```
    /// # #![cfg(CONFIG_OPP)]
    /// use kernel::clk::Hertz;

(We took that approach in another example recently)

It is nice that the `CONFIG_`s appear at the top, so that one knows at
a glance when the example applies, as if it was configuration for the
example.

On the other hand, it may be useful for the reader to see immediately
that they will need the `cfg`s. But it may be distracting from the
actual examples, and there could be a need to add it too many times
(e.g. in every related example).

Cheers,
Miguel

