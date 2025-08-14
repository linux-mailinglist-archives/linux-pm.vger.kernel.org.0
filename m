Return-Path: <linux-pm+bounces-32364-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8749B25A69
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 06:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D0307B72DF
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 04:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8468F1FC7CA;
	Thu, 14 Aug 2025 04:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VFk8wODM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558121F12E9
	for <linux-pm@vger.kernel.org>; Thu, 14 Aug 2025 04:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755144941; cv=none; b=PPT9429WVu480yc77ufMaGCGnoR9lJk6GLFH99qwtaCJCn3PAEzkYVpdBNTthowiYoof/knLXEsbZJvLfr2y67T3EJWKamuaUEFds7do9nmwZ3h69Beq9DCpwucJr+YeTbOTUsPimF6IkCdwBGio+SIdGzH4nLHLzKpviVuA0yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755144941; c=relaxed/simple;
	bh=aINf4JQIOzGrbC8KNPOs49EQ27ER0B2fAmdlIOg6AJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uef6hdS3M2A2OqOCBO9aQlkAvthem7EHAAuMwov2EGGkUOyjGaYPvaMrxV3og/+n0PQ42Ieh3gV8B0tfb36booeges9wpYfgmC3zlCMrvsJJHj1FbjXTVLTMUBIj1gPOfz3Hr1sn15aF5pgrVMKyIydVdd/nF0LY+WaBTHI9weo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VFk8wODM; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e2ea79219so685427b3a.2
        for <linux-pm@vger.kernel.org>; Wed, 13 Aug 2025 21:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755144938; x=1755749738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=34KWmLyAieUzqtSrdM5jM6hi2YW8C3abPtgGolrQZzs=;
        b=VFk8wODMCPp4sykRcxFNrGPwYPG/tsAGsdvjgE8c//5GEJgXop+PzeRQ86GIEnq+Jt
         ASnKVOR4xGiZ4gw3PsRdnQIZmOaAliJXJMdIgmMpEIALEpSHT7cBRDzkwbzLoco5gInP
         2Abkeoobct2tyzQw6OD8fUL7uatVHX+mJDw5ev5SBRFATouJVPxFd3u2MWeryMAoCQRa
         OLz16rLSNbNZSh7wwfTHosg5H9wZjviaTXy8WCve6PISnwpN4KltPa/Polk9HYhhXvzH
         /Gf67SHkyWDytV3RVGaHCQm7l7DWx7B1HC3m87leSgUlALZeAiB1gChgw4j7cMuET9Dk
         xRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755144938; x=1755749738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34KWmLyAieUzqtSrdM5jM6hi2YW8C3abPtgGolrQZzs=;
        b=wUmXM5E4oghmsEc+Vq7qdEYzfdm2LyHlkHnc9TYbfDPjubT9NEcpb4VnlBc1cBPPDc
         1gzuqlamhr9V45FSqer3rTf9viXx47u9fR/QyZNZ5QBl6DqjjXk5KKqwtC6V3J9UDAfd
         Gj2J1xhW2VIjuc/RPuAbrNbMQ5w28vlDbNGzQO1x03nk0OSkthYFknKSFt7vC7FAEcHR
         LMfeIJbErPFuSZ/3ZPpIjGojIT5CJaWJ6EGXscq4Of7+b8i28pPGvXSkCu5HMH6PnNws
         3uDCIJkLuxVdogR80KW/k4Ohp8CRdSWdQJ+H3QfZhd6MDPWB/iyGcCHl5prqxg1T8WDA
         yL4A==
X-Forwarded-Encrypted: i=1; AJvYcCWDjJVN6ZNTLPLNAdsLxU0Hjanv+6tp794g0Rc/dgH8+2XtlEQ/gs1sVaNkUBgQBi9Dm+JnKOvE+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYiMo37T3EaHTn3Q1QPz2TV3HKTTdorWjc25fi2UXQhsl2CR3E
	oLuKFsUHYBw0SwI8hdDeAptDkdlf8nSVcfFVxpLIpcyJvpCzCgDww2H5hYKwScTlIno=
X-Gm-Gg: ASbGncv2nDzWHj3BpL44aIbrpg/ItINK5X7ua/A5O9ltyASS6A51ak+iQn1UXjzgORc
	SGvGQ/bDccBXKjat8bY1AKsLF3+fBB1t28dfdHkwtGs/0zJu9nhIYcKSBU87NNWZw3Keb20VcDr
	jasz2+gOthRKHXQfRAWfKl5Hiq3ELIf5d6yDA0V6lyuRxbqdrSauPMBbJ6fARar/HUvE8807DpS
	xoIt+bSx5N2TDmhSTeaETcWOLMPiZnKNSH3xHwqE3s1XJ/aAFtaKHACujdj60c/HZYm1CKYYJ2A
	HWbGSFOwQZDyNfW16x2AWdG+r4Sp/pUAk/Gz807E5OgyrtNZDn2Ohki/yyzcB+vrwiyXwDQGevf
	D1F7ZgVSOGtSdCn0H4kqRvBu8SOhKdrfdbHU=
X-Google-Smtp-Source: AGHT+IFKmQVKtrRTGaZ8hTWhd7nE8H1E8AgUXml21TmSiOXRMbfiiTxpX/j+26/xYc1Zfc3ne6Vv/g==
X-Received: by 2002:a05:6a20:7d8b:b0:240:1204:dd5 with SMTP id adf61e73a8af0-240bcfbba85mr2301691637.8.1755144938050;
        Wed, 13 Aug 2025 21:15:38 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bd9795200sm31652911b3a.114.2025.08.13.21.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 21:15:37 -0700 (PDT)
Date: Thu, 14 Aug 2025 09:45:35 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Jens Axboe <axboe@kernel.dk>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 04/19] rust: clk: replace `kernel::c_str!` with
 C-Strings
Message-ID: <20250814041535.l7yj2wm4ae3l4k7p@vireshk-i7>
References: <20250813-core-cstr-cstrings-v2-0-00be80fc541b@gmail.com>
 <20250813-core-cstr-cstrings-v2-4-00be80fc541b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813-core-cstr-cstrings-v2-4-00be80fc541b@gmail.com>

On 13-08-25, 11:59, Tamir Duberstein wrote:
> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible.
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  rust/kernel/clk.rs | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

