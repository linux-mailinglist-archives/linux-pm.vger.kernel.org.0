Return-Path: <linux-pm+bounces-33055-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 752A0B34F5A
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 00:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EEDC5E0C0D
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 22:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0E12D0C76;
	Mon, 25 Aug 2025 22:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="EY99sK59"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625A52BE02C
	for <linux-pm@vger.kernel.org>; Mon, 25 Aug 2025 22:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756162608; cv=none; b=i0p2ntDRaUZpqMOwuIQfCoKRvY4dOsmq75IYgY3xtwdieOUcyuD/ds6Huzc/E9X2l98ku2dc28bhbgA+4Bm0qe/kGIYbfE/oBWmiSZVRJJCubT8EmL3Y389wr+qiE09mmFplDbaQVcYGIwmNS0OAmKzSFhW71DhxY/6DTw0udwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756162608; c=relaxed/simple;
	bh=AHkQ5EAzmMEUHARI9ASYPbmU3Kpsoeyz3PvC+SAbgOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKTBq5co45bOQQmCBOg5qzsP8aPTGJPJ4g9Kt5K9Kw8/1Vn2tjVrntgiWGr7Je9WNaD2NMYPzrT2bZ2PuMnc7wxBROnJLppf817stCwlWDA96G8bNv7W/ncQ8X/wLBXSS360OMKIiBBC8IS1FATEKZHoQoT2MSsH9lSeoZ2FhVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=EY99sK59; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=protonmail3; t=1756162598; x=1756421798;
	bh=g/bnhO1X/k9VcIoKJOYdMoi09lvV4Ldk0tdwF8UKw+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=EY99sK59vd9Td+2xr16VUIgs5ZKjVq0J/agdcrQ2ooxkJGKfb8uOa++5WoDv9EgL/
	 0iqVJBnwf19z9baf6t7Ztf+tF7T7eZSYpx3xQDobOZ+ZdeRF0Yx8ty569+/1o6y7hh
	 yzYzlNDE/xx9GmO2/Yvw7hl0nm/v5zimG9KiPegf5TbSKNT4TUZn5oVgQO7YMuHnX/
	 8cR4Z3JySeFg47a4FhYOYtPcnt5MCRtcVfANQ8UNEn4TpMe9N1LfSN6iIS8ri3Zq/W
	 tXTGgmnr1jtHqnftFhiKkoNKHv7JIfkQT6M1rCDvYcqTkOfBfNgeBf1EnfjaLVL4CY
	 ocKdY3AEHgtHw==
X-Pm-Submission-Id: 4c9mPb56psz1DDXK
Date: Mon, 25 Aug 2025 22:56:33 +0000
From: Elle Rhumsaa <elle@weathered-steel.dev>
To: Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, vireshk@kernel.org, nm@ti.com,
	sboyd@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, dakr@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: opp: use to_result for error handling
Message-ID: <aKzqIWDAHWEqDG_7@archiso>
References: <20250821091606.7470-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250821091606.7470-1-work@onurozkan.dev>

On Thu, Aug 21, 2025 at 12:16:05PM +0300, Onur Özkan wrote:
> Simplifies error handling by replacing the manual check
> of the return value with the `to_result` helper.
> 
> Signed-off-by: Onur Özkan <work@onurozkan.dev>
> ---
>  rust/kernel/opp.rs | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
> index 08126035d2c6..9d79c2816af5 100644
> --- a/rust/kernel/opp.rs
> +++ b/rust/kernel/opp.rs
> @@ -12,7 +12,7 @@
>      clk::Hertz,
>      cpumask::{Cpumask, CpumaskVar},
>      device::Device,
> -    error::{code::*, from_err_ptr, from_result, to_result, Error, Result, VTABLE_DEFAULT_ERROR},
> +    error::{code::*, from_err_ptr, from_result, to_result, Result, VTABLE_DEFAULT_ERROR},
>      ffi::c_ulong,
>      prelude::*,
>      str::CString,
> @@ -500,11 +500,8 @@ pub fn set(self, dev: &Device) -> Result<ConfigToken> {
>          // requirements. The OPP core guarantees not to access fields of [`Config`] after this call
>          // and so we don't need to save a copy of them for future use.
>          let ret = unsafe { bindings::dev_pm_opp_set_config(dev.as_raw(), &mut config) };
> -        if ret < 0 {
> -            Err(Error::from_errno(ret))
> -        } else {
> -            Ok(ConfigToken(ret))
> -        }
> +
> +        to_result(ret).map(|()| ConfigToken(ret))
>      }
> 
>      /// Config's clk callback.
> @@ -713,11 +710,8 @@ pub fn opp_count(&self) -> Result<u32> {
>          // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
>          // requirements.
>          let ret = unsafe { bindings::dev_pm_opp_get_opp_count(self.dev.as_raw()) };
> -        if ret < 0 {
> -            Err(Error::from_errno(ret))
> -        } else {
> -            Ok(ret as u32)
> -        }
> +
> +        to_result(ret).map(|()| ret as u32)
>      }
> 
>      /// Returns max clock latency (in nanoseconds) of the [`OPP`]s in the [`Table`].
> --
> 2.50.0

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

