Return-Path: <linux-pm+bounces-8468-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114268D6130
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 14:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4275A1C21F34
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 12:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9563D1581F4;
	Fri, 31 May 2024 12:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ce4vnNSY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C4529A0;
	Fri, 31 May 2024 12:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717156958; cv=none; b=GSeZaI7J4TVH41TwFlCrlQfNyYQAknVzsnzXSvA6mperMN2WjXSDpFDWnPvtbL3B1/xhrpMLgj842Xbvr9hqVUBWE+7Lf49PXoWpf1WJl+pxKRB1YAvsLZl+N5EpRv33Pq9zCbR7zKFshAEMsH9CpNaQB6ZMx6fi9x6EkJZO2D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717156958; c=relaxed/simple;
	bh=radVXi0UTDUiK1mwA2tlbsbnMXiA/rRl4knjJfHcpV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/kak9whbM37oS+jvtb4GB5IjrX+1OYPzK8QCTEvPWvupCJfh4I0+5vzaBJCGDH/jxLa7qGbm+LBTCd3FNRK5uFCGoJQLytYky4MR3L+OACdAeYO+LoJ/0c+Vi9ahUX28Dp2wOXuHFdexVVwUEQt1eTshBfxF8Dmu/tVpDQw1GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ce4vnNSY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF37C116B1;
	Fri, 31 May 2024 12:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717156958;
	bh=radVXi0UTDUiK1mwA2tlbsbnMXiA/rRl4knjJfHcpV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ce4vnNSYmVqIhhsm4ELH6lOSumc5qLZfj4MifpYDeT8CWU9hLXEMzoJs9V5unFHuo
	 rBIbv1Xa86b13PlxtnDaiFte9rQ1q2mt3zrMbPa8zCrH4HlqmmflQbRrGyRZW5J2YT
	 vkZmL9eq7TYxcdJVJtO5LhKnkUQfmkb4pk8E5cNpfVcYR4+aZXuZVd2e8tJEsFjhFO
	 WN5PWVZc3jN6+DU2k5mZ3SO36iEGNxfIzhB0KEyyHY3mCrSshAvSyELShapg77uyOy
	 HSQ/wZd41nWmFZ1dZsK9FZEd4Pt/gMtmTQBYfFgv5yCuWGMZvH95sZXswdbPPLt73L
	 FDLUfNV1LI6yQ==
Date: Fri, 31 May 2024 13:02:32 +0100
From: Lee Jones <lee@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Kate Hsuan <hpa@redhat.com>, Sebastian Reichel <sre@kernel.org>,
	platform-driver-x86@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>,
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v10 0/6] KTD2026 indicator LED for X86 Xiaomi Pad2
Message-ID: <20240531120232.GF1005600@google.com>
References: <20240531114124.45346-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240531114124.45346-1-hdegoede@redhat.com>

On Fri, 31 May 2024, Hans de Goede wrote:

> Hi All,
> 
> Here is v10 of Kate's series to add support for Xiaomi Pad2 indicator LED,
> this is unchanged from v9 except for being rebased on top of 6.10-rc1 and
> dropping patch 7/7 since that one has been merged through the pdx86 tree.
> 
> Patch 6/6 has an Acked-by from Sebastien for merging this patch through
> the leds tree since it depends on the earlier patches.
> 
> I have some further power-supply LED triggers work pending:
> https://lore.kernel.org/linux-pm/20240510194012.138192-1-hdegoede@redhat.com/
> which applies on top of this series. So this is going to either require
> an IB for Sebastian to merge into his tree before applying those, or
> (once ready) that series can be applied through the LEDs tree too. Since this
> follow up series deals with LED triggers I think that either way makes sense.
> 
> This work includes:
> 1. Migrate the original driver to fwnode to support x86 platforms.
> 2. Support for multi-color LED trigger events.
> 3. The LED shows orange when charging and the LED shows green when the
>    battery is full.

Applied and sent for testing.

All being well, I'll submit a PR soon.

-- 
Lee Jones [李琼斯]

