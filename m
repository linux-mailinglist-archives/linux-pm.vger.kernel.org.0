Return-Path: <linux-pm+bounces-42128-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGMNDPpohGlK2wMAu9opvQ
	(envelope-from <linux-pm+bounces-42128-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 10:55:06 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C629F1117
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 10:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0E3C3033520
	for <lists+linux-pm@lfdr.de>; Thu,  5 Feb 2026 09:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378093A4F4A;
	Thu,  5 Feb 2026 09:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OIztZXVg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29163A4F2F
	for <linux-pm@vger.kernel.org>; Thu,  5 Feb 2026 09:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770285287; cv=none; b=U51Vt6iokjh/+jaCYD8TRvtO7oDzzz9urAFsJ+eVRO4M3lTYTcsk4wq/VHisObPMFLSgU0oTQZYc7BEWGBB+5qj5aRTSSNj+SOVzszo7R/daKOqgfEXQm22y/bwXx3qDpJlhkas9KIvb3t1WJNV0bg3GzA+JQfsRLcDzs13wZGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770285287; c=relaxed/simple;
	bh=+gH07T7gJ7+X3xesrNA2+Bs3sMLJhA4gaSIsoseJoFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQgp42JVCmonsSe59rXiCkp+LnN+mHC5tSfBW+K4ffhKTIaPG+qQCXRZFJS2a7L97hH9uAjQNaeJgGeg8ec5MpBQ9dxAUd/dIYP+AHW710s/IcnqPjMLSB43RhqMi6SF5cdjU8z0wwr4o3x4yT/zKnLcUUe/DIsZlw2U4N8wOo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OIztZXVg; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34c868b197eso484662a91.2
        for <linux-pm@vger.kernel.org>; Thu, 05 Feb 2026 01:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770285286; x=1770890086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9xBIY0mav+3IAaN2sDOZsKW4O0cnUlRHLSnJJ3/BuhM=;
        b=OIztZXVg1hLazuEkmqd8LlclnaLE4rA0fxlphw3KvArdlCYxrvdQZyDtKojtlalHtG
         1a66CHSgueLHo3e7wgPFL5SSykTdE+DP/Wqo/IzjGPPDm4GcyVlPjTjvAduAfl8knaW9
         NrADuUlm153qtL+TZOZwB02E5FIxQEvXf8VcuyXxGRlrop4XdAcCjNyZpmvoKpOXaqx5
         iTqPuOKTZ61EEAXWEtUzcfKjsOfoqd6olMTXQbZ52wRe3LltSc6K1bAuQ04//rTzOU9I
         efFMVyoMMVC/Y1sfaoxEqpR0CYhnFWHReEGc2mHEIYgZfGzJCicUald9h2trI26NPIf1
         gaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770285286; x=1770890086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xBIY0mav+3IAaN2sDOZsKW4O0cnUlRHLSnJJ3/BuhM=;
        b=s+e8TV0yD78+J2i3WM+iwZRjyiJ7CNnIFGDKrRyFhZRrkaBM474Ky3QLTHA24VzZ/U
         PJD1rlL03q2GaiCEPlMA5r654OpCAo86uo+bXezqd0nQqm44IPMd4pBAIKnu8ZdawABd
         rLF9OB2po3fgEk1sl696lQxxEFTsDY+iz6gJxDS9FzoEHNgHQwRtUsZhtX/IXDyfNI94
         BjAp3olJ/mZQ4lPdP20cqX0BHFdSIAnAzRYsJ1ByEbMHim2kH+CP5tx4/BeLhVIxdC7a
         lW+iYsu7i3VP4hUYrzk3Y2zDSCifoQK6xXUH4og/wEQyCcsw2xjtHRW7TdJuioe05GL7
         jQpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv70XzYBwVXoJuBKWp1ZBtgJpvEg6GQip4q8YlsDQ9U8cybCoHImSJCKy1Jqvm3Zo4/QvxK0EB5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YznRBarmT+FY++s5Rg4d6WL67kX2+lARVsd1ffR5D0GxDP5znnh
	WSTPuikTbUOf5GuJsg9hrqPyPXpmG6DL7LLZZro8enAGasfcQ3PdIyKuIG0cx9AdeiQ=
X-Gm-Gg: AZuq6aLlnyUi92StaIQJoiIrFWINz6L/Gtjt4IP6H8nQQExyBKTCHAhbEIqJRHhZ+C4
	G90AiWXe+DnKcSAwl3vAWPzlDBfMIlOM6ClZFOzcUdd8GS0Nm5u2FQ7aNb3epg9Mk+WmJoFP8UQ
	Z0hW0LuySvRDMTeJoSFOonKsvBWDCs4thMdgfRuHgdJ13tFV2DEkpEKMBDXZNbFPLRgfXBq0ykG
	TbYa7p86qN17o69val/wRlI3G/usD1dq/Wqw4zU8FbPdCcAcAytUusG4h/mb4PmODNd3d6vsZRl
	XxiOUYg0QvMo6eHdORtJYhz/hwzm4wjYWZBGlTKjqV0HgZXpjlB0yhmzsUpOK7yH3fSaJ8EFaLo
	DghuhKnmmAf8X50wdA5EfHd12B4/nIzx9k5MxhkTmiFGuq0LBVs7b8enpqIb8avlUxkZ5DIBg4U
	hY838ZOIl+wQs=
X-Received: by 2002:a17:90a:c110:b0:354:a05d:9dc2 with SMTP id 98e67ed59e1d1-354a05da864mr1522955a91.9.1770285285886;
        Thu, 05 Feb 2026 01:54:45 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-354894533dbsm2000361a91.7.2026.02.05.01.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 01:54:45 -0800 (PST)
Date: Thu, 5 Feb 2026 15:24:42 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin.linux@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	Oliver Mangold <oliver.mangold@pm.me>
Subject: Re: [PATCH v14 2/9] rust: rename `AlwaysRefCounted` to `RefCounted`.
Message-ID: <xh3iuwlz4wapmgzojg4v3sen4oezfua4vsedskvrqhc7ryyclj@jggikwra6dmj>
References: <20260204-unique-ref-v14-0-17cb29ebacbb@kernel.org>
 <20260204-unique-ref-v14-2-17cb29ebacbb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204-unique-ref-v14-2-17cb29ebacbb@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42128-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com,vger.kernel.org,lists.freedesktop.org,kvack.org,pm.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viresh.kumar@linaro.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,linaro.org:dkim]
X-Rspamd-Queue-Id: 8C629F1117
X-Rspamd-Action: no action

On 04-02-26, 12:56, Andreas Hindborg wrote:
> diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
> index a760fac287655..06fe2ca776a4f 100644
> --- a/rust/kernel/opp.rs
> +++ b/rust/kernel/opp.rs
> @@ -16,8 +16,8 @@
>      ffi::{c_char, c_ulong},
>      prelude::*,
>      str::CString,
> -    sync::aref::{ARef, AlwaysRefCounted},
> -    types::Opaque,
> +    sync::aref::RefCounted,
> +    types::{ARef, AlwaysRefCounted, Opaque},
>  };
>  
>  #[cfg(CONFIG_CPU_FREQ)]
> @@ -1041,7 +1041,7 @@ unsafe impl Send for OPP {}
>  unsafe impl Sync for OPP {}
>  
>  /// SAFETY: The type invariants guarantee that [`OPP`] is always refcounted.
> -unsafe impl AlwaysRefCounted for OPP {
> +unsafe impl RefCounted for OPP {
>      fn inc_ref(&self) {
>          // SAFETY: The existence of a shared reference means that the refcount is nonzero.
>          unsafe { bindings::dev_pm_opp_get(self.0.get()) };
> @@ -1053,6 +1053,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
>      }
>  }
>  
> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<OPP>` from an
> +// `&OPP`.
> +unsafe impl AlwaysRefCounted for OPP {}
> +
>  impl OPP {
>      /// Creates an owned reference to a [`OPP`] from a valid pointer.
>      ///

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

