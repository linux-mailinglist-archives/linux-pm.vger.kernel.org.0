Return-Path: <linux-pm+bounces-28344-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7424AD3103
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 10:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC453AC1AC
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 08:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4179F286D62;
	Tue, 10 Jun 2025 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfOIb8NO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E13280008;
	Tue, 10 Jun 2025 08:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749545883; cv=none; b=ndRnNoEKL+90myDsa93bii63LYBUhjMOMDTXNoKbEjAkV4q3RuX75ayMB+OVdylokApwivO8goYnyoFIXBbinCb1HWTy2EyujTNSWhXhNdM3AU857J8ue4MCxJuwztjb8TWr/qrtjOvKfIO+0zvpkVhJmzbqPIbkmHqjB0sw0AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749545883; c=relaxed/simple;
	bh=cFuJa1MbaQff0D7/bg5dOYx+v1MxdgpT1Fbr8faIue8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=qu0AFhtaJQAxS9QgYOx6OBN7vnE2seMCO56QBkssz/uAyhc8lNOJy8yyMvY/ftskEWhhXimd6gte57fB1telWlqWrc5gYhhyeF5DL7ZaXQ/Oh4lRvtbb4pT8+XCf80QgllIXzvzV6uiXurdw1bzMiLmV3FojUemtEK04UmERUCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfOIb8NO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A436C4CEED;
	Tue, 10 Jun 2025 08:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749545882;
	bh=cFuJa1MbaQff0D7/bg5dOYx+v1MxdgpT1Fbr8faIue8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=cfOIb8NOcXGU/mySXLxZkDRzL5vdr78k1PL0AQIb6in8sw9/Q/pNhYrpJKrOtgOMn
	 c/fYLdNp8wf8zizDUB//BynCOy0f2+lToIYd1bZVffz673hKoY6zWgkX9EH0Y7Mde0
	 SMNn2/8E2XrJCOXaIl8e/E7kyKGSrfQv5B86uhtLIQ5Fob+HMnLokFhbJwXboRxAmo
	 IruBZ/WmEqUxDNta+rNrXxngd2itlzd6Q/ubdNZTv4MZ0cjuGmqvq6KIHTGKRvRAeN
	 jCoiBQvU7orzJj01HBDY7e0JzP/LoJlqNUfmp58Ku9xQBfGnRJjhAy+A3tyVXzpgXd
	 karynLUNxTcJw==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Jun 2025 10:57:54 +0200
Message-Id: <DAIQ9342ZFYD.3VQVI80A18HKX@kernel.org>
Cc: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH] rust: module: remove deprecated author key
From: "Benno Lossin" <lossin@kernel.org>
To: "Guilherme Giacomo Simoes" <trintaeoitogc@gmail.com>,
 <rafael@kernel.org>, <viresh.kumar@linaro.org>, <dakr@kernel.org>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <mcgrof@kernel.org>, <russ.weight@linux.dev>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <leitao@debian.org>,
 <gregkh@linuxfoundation.org>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <fujita.tomonori@gmail.com>,
 <tamird@gmail.com>, <igor.korotin.linux@gmail.com>,
 <walmeida@microsoft.com>, <anisse@astier.eu>
X-Mailer: aerc 0.20.1
References: <20250609122200.179307-1-trintaeoitogc@gmail.com>
In-Reply-To: <20250609122200.179307-1-trintaeoitogc@gmail.com>

On Mon Jun 9, 2025 at 2:22 PM CEST, Guilherme Giacomo Simoes wrote:
> diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/n=
ova_core.rs
> index 618632f0abcc..f405d7a99c28 100644
> --- a/drivers/gpu/nova-core/nova_core.rs
> +++ b/drivers/gpu/nova-core/nova_core.rs
> @@ -13,7 +13,7 @@
>  kernel::module_pci_driver! {
>      type: driver::NovaCore,
>      name: "NovaCore",
> -    author: "Danilo Krummrich",
> +    authors: ["Danilo Krummrich"],

Unrelated to this change, I think we should add email addresses to
people in authors. Possibly enforce it by scanning each author element
and checking if there is an email address.

>      description: "Nova Core GPU driver",
>      license: "GPL v2",
>      firmware: [],
> diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
> index 2494c96e105f..ed2fc20cba9b 100644
> --- a/rust/kernel/firmware.rs
> +++ b/rust/kernel/firmware.rs
> @@ -181,7 +181,7 @@ unsafe impl Sync for Firmware {}
>  /// module! {
>  ///    type: MyModule,
>  ///    name: "module_firmware_test",
> -///    author: "Rust for Linux",
> +///    authors: ["Rust for Linux"],

We would need to special case "Rust for Linux Developers" or something
similar. But in several cases -- such as this one, we should just name
the actual authors.

What do you guys think?

---
Cheers,
Benno

