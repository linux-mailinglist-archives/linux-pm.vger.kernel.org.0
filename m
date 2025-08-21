Return-Path: <linux-pm+bounces-32795-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF9CB2F3B3
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 11:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8260C7BF252
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 09:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C882EE604;
	Thu, 21 Aug 2025 09:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dMCyPtUY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92EF1F4C8E
	for <linux-pm@vger.kernel.org>; Thu, 21 Aug 2025 09:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755768102; cv=none; b=oKe88ab+klYJdhCh59uQ4WcqKmMKAph/cgSACiU0Oa420ki/WU1UtcbIrHjiQaY+Q2qUQz+R+zEY0hd5FGYD4itpkVZUlo4nA3oy+MG4G7lVjV68rZ787jzs+e6KBtu26aefQ076MvQcDPvWaLGTNwaxoyoQVCg5urbggwV8Zgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755768102; c=relaxed/simple;
	bh=ijPoGdjzeNrat6vrwS2Sn0CzPWVJk5y966fhUtipBas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEUe8vm34KWYeXuQHR6B3YCjkpmXDLOZ+6QqRj6gNZPZFq/a18KTMQVjZr8EyhTL5fw8AedkvKvdKCOI3KVFKZPGuGGGPcjflmeKWOdsTtRuPqspdPs1yyzEwh+GmY1CdB59/xAkzymhYG7o/pWHgxZ/cLSCBrWGc/TIaDbE8t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dMCyPtUY; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-246151aefaaso1830615ad.1
        for <linux-pm@vger.kernel.org>; Thu, 21 Aug 2025 02:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755768100; x=1756372900; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zJKypcai6x92HNXEJAfDnNbD+B+6yE1R6+hogPfBXqc=;
        b=dMCyPtUYvR8gFYvQEwWnT/ek4/oeHKtK4CFokwteo7v4sMxoWWYDsskcqz2iHKRjJv
         464NQ8uyehUfDNXCmrwtUO1KA2MBcwzuA+qc5RIXMzl+IZTFhobY3dP8GD46qkeBze7T
         cRiNcRx1QGvmAmq5QS6BRksqJ8hfq6CuF2mNAsna1nz6tg4o13hExGpDQPYloy3nRP6E
         s8xba+DWFbKji52VMDntPQdifDIq6YBpP4VBiWOc82Zwp3R4zzoNB3CM6+EzdrNXHtBz
         eIMTcIIGYFZfKoyZ+6NsOCSI22jK/DtGcM47ZRQ9TNl+abD9wcaAsOiCYzr/Yt9JkMTA
         4S/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755768100; x=1756372900;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zJKypcai6x92HNXEJAfDnNbD+B+6yE1R6+hogPfBXqc=;
        b=F0g1DLM/uOOpPdSh6CKFjcREVJ03WzNLrGUo2Xlfnk6Ujba8LivHMaR8SVGZ+ltgjl
         AVREHw8hS43yep33Gg8yfpBHQKULcx5UutithsnjPq4IHeb/p98EFcefxIymkSX48Fse
         IKkv4egVuSKYE/+a96pXZFCbLeDIfxRpcUuP3LifFwspYkx8T6tw81TZ3A6It3Mn3bNm
         iDJgd7IcqnZBuZ/S8CemE4SvJm9emconQBzUkw6jk4XdDbzRaiaqdFlvb/K6ulXDk8oe
         VOYOVDKkIJ1yc7jSixVFnzWwqswl2nXoOWYBLzWgr3YbxgMc/v50JSfJvjyb5CK0lH+x
         tBFA==
X-Forwarded-Encrypted: i=1; AJvYcCUMpQ++ewReTUJdJiBE5Elx8PPPulgqxcxNDgatrkVtIBQUC9R5yc5BFxMAMdiCjYDE7tkaVEdNKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGkOt1isrjjuhzNMzmS8l1VVieSZGS2AeQyBkdUmD+A9oc7c9i
	0yB92zeSVwn58zMsRZ57fq+NXXWGQB5ls5qO8sI2bWMRtEoGe47S8Y2RfzaCzvVpvmw=
X-Gm-Gg: ASbGnctK2GR1OS71LmHgHqZiAreTzFx9cMRFrUD57wyeaqelZP/X+y+cJN4B/jOdZVS
	EpiRRZ5/cusd9hphbYg8Aq3Fu8F2bKRUjtQiRIDXa0a7i2hTm3csyGFeJwydkoWO/8GkRVDoxZv
	2yLG9spdUN6OyuHUrMvWiEYHh/mmXFZNXxDFr6Z5GNU7RPC553bKIIEPpwlXcPTvbl7M6FZHm4K
	QG3KpmIhM2s2UVjjDCdAfPAPlRIpYRv8HqYEK7t64pGw7JStueJ78rL6yrVQuIPZNq1IU/BIYTD
	KFkFiAgDBRJLQ4ypL1kNOGk3t0FcegAH49TZ13j8RNXQRVECntGWLEmsau8i03bks3ldTJ1siw8
	HogN4/Q5n9WWYVofBuTahwYvX
X-Google-Smtp-Source: AGHT+IEcS/tuNVZrG+fDd+9f0DpmfNWHCLvje+/VQyO7/Ge/2qxOY4o5KiHN2KOvKZ3Zwoc4LV4bzw==
X-Received: by 2002:a17:902:e751:b0:245:fcc6:a99f with SMTP id d9443c01a7336-246023cf093mr25599545ad.11.1755768099946;
        Thu, 21 Aug 2025 02:21:39 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed375bc4sm49914185ad.60.2025.08.21.02.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 02:21:39 -0700 (PDT)
Date: Thu, 21 Aug 2025 14:51:37 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, vireshk@kernel.org, nm@ti.com,
	sboyd@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, dakr@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: opp: use to_result for error handling
Message-ID: <20250821092137.wttiixhiidt27hnq@vireshk-i7>
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

On 21-08-25, 12:16, Onur Özkan wrote:
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

I would get rid of `ret` as well in both the cases, like it is done by
other users of `to_result()`.

-- 
viresh

