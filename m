Return-Path: <linux-pm+bounces-43686-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MqZBXeaqWlxAwEAu9opvQ
	(envelope-from <linux-pm+bounces-43686-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 16:00:07 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2C42140D3
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 16:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2546A31CEDD1
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 14:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7813B4EB0;
	Thu,  5 Mar 2026 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCFQtb24"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E4A3B3C0A
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772722468; cv=none; b=nmcSYlwk5XxSedOiAQStPKmivBsHVyFE+A6Ys6sKxGJ/CNZXTn4E9CLAo1bbnKJ6ph3UW/4uoPzcKN7MGETNcbQdCFlh6ePk8UHzKgVxTs6B/vgHN6QlEnhKT02yW52jhumKEI1vc5XbB35a046m7RYeS7o2RHJG32v1Gwg8b/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772722468; c=relaxed/simple;
	bh=SPbv6etCW5Xl2VcRo/t3JbV86BiTlFol56ZJtfc8ntU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SzSVPrjsvvbPI4VGlJlCOpwJI+eOsIvVkExk1lAtcckaCHapm5DNs7ehHYQbWvtaR8pDE7rBgH29Pk3vMDtadChSauzZWZ+VaP3TDGxYiV+VFlH2OrabuZiD5CDPkJjSsY3Y2+qkhCGn78YapLsftvbnWlesfvHvXUicM7+YZps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCFQtb24; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C10BC2BCB2
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 14:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772722468;
	bh=SPbv6etCW5Xl2VcRo/t3JbV86BiTlFol56ZJtfc8ntU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tCFQtb24yCUc6Llx+HLtjOwtmoj3qsabefZ9uQ6H6Jgqo8SIEOux+SA5c2WMPWDeg
	 eBhEO3BzJEFMxgMx0KxP7t9WzgNN997+4hj7nSbO4dEi84/kACgyeChQCzePjWvHCp
	 h+RHRFX2p/6TjDp4ROLiiARmR7d9LlXEUY8uzWeC1cdNUXIZbqgKEozYsn5+8YEv+Z
	 6bYDh5PBkwLaM1RYDZUxNlOM2lPNcdp2QuTJumQrW38jzjcNMPXhmDC4hy2xSF6Bjo
	 JPzP2rTVAzCuOUHUENPhxvIO5Ke/HUGLxHLCVzjhEuOEywNZxh8b6cphwjQDDGhr86
	 a8Lnyk2DJHrow==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-4138136f02eso2506376fac.2
        for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2026 06:54:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU5L02Hg+jWOlQsqaCyD951IWL/Eq9iAx40Q7V+zpCH3lB8ECQkDyMh1Sg5Mh79ePurUHc0bGG3WQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzY1W4fWe1celKYhUyM3wTUJZqAE8GbyF7XbDwSUazQe2uJMyMK
	dyIi/oqO4frCqJ3EdHN3ticLjkXI2rAbPSWxm73caM0d98M5MBDJvrCPt1k397eqkQdMA9pu+OL
	VJtpUtlqs5VKCcOUnY+ecoe3p3tbAAxo=
X-Received: by 2002:a05:6870:b3d5:b0:416:93e1:28dc with SMTP id
 586e51a60fabf-416ab611a45mr3014464fac.23.1772722467208; Thu, 05 Mar 2026
 06:54:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212233044.329790-1-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20260212233044.329790-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 5 Mar 2026 15:54:14 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ggpCRtf-uk2UbSCByZkkKZxXKrbZ7-yRipsM-LvJ99PQ@mail.gmail.com>
X-Gm-Features: AaiRm51tJVEp3BfnT0IthuAxamNTeUb1b_Abg9_PKpyEPGUUKS3FD0ZmRvrRO3s
Message-ID: <CAJZ5v0ggpCRtf-uk2UbSCByZkkKZxXKrbZ7-yRipsM-LvJ99PQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] Move RAPL defaults to interface drivers
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6B2C42140D3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43686-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 12:30=E2=80=AFAM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> Hi All,
>
> The Intel RAPL common driver has accumulated a significant amount of
> interface-specific logic over time. There is very little common code
> shared across the MSR, TPMI, and MMIO interface-specific defaults.
> Keeping these interface-specific defaults in the common layer therefore
> provides no real benefit and instead increases complexity and
> maintenance burden.
>
> As a first step toward cleaning this up, this series moves
> rapl_defaults ownership from the common driver into the individual
> interface drivers and allows each interface to provide its own defaults
> directly. Additional interface-specific cleanups in the RAPL common
> driver will be addressed in follow-up work. This series is a
> continuation of the earlier cleanup and refactoring effort initiated
> by Zhang Rui.
>
> Patch Summary:
>
> Patch 1-7/12: Preparatory patches that do code cleanups in intel_rapl_com=
mon
>              driver.
> Patch 8/12: Preparatory patch that renames/declares the common functions.
> Patch 9/12: Move TPMI default settings from the common driver into the
>            TPMI interface driver.
>
> Patch 10/12: Move MMIO default settings from the common driver into the
>            MMIO interface driver.
>
> Patch 11/12: Register the PM notifier only when a RAPL package exists.
>
> Patch 12/12: Move MSR default settings from the common driver into the MS=
R
>            interface driver.
>
> No functional changes are intended across the series. This is strictly a
> structural refactoring to simplify the common RAPL code and prepare it
> for further cleanups.
>
> Changes since v1:
>  * Removed BIT(val) usage in divisions (David Laight).
>  * Divided the cleanup patch into 4 patches for clarity.
>  * Added Acked-by tag from Srinivas.
>
> Kuppuswamy Sathyanarayanan (12):
>   powercap: intel_rapl: Add a symbol namespace for intel_rapl exports
>   powercap: intel_rapl: Cleanup coding style
>   powercap: intel_rapl: Remove unused TIME_WINDOW macros
>   powercap: intel_rapl: Simplify rapl_compute_time_window_atom()
>   powercap: intel_rapl: Use shifts for power-of-2 operations
>   powercap: intel_rapl: Use GENMASK() and BIT() macros
>   powercap: intel_rapl: Use unit conversion macros from units.h
>   powercap: intel_rapl: Allow interface drivers to configure
>     rapl_defaults
>   powercap: intel_rapl: Move TPMI default settings into TPMI interface
>     driver
>   thermal: intel: int340x: processor: Move RAPL defaults to MMIO driver
>   powercap: intel_rapl: Register PM notifier only when RAPL package
>     exists
>   powercap: intel_rapl: Move MSR default settings into MSR interface
>     driver
>
>  drivers/powercap/intel_rapl_common.c          | 757 ++++++------------
>  drivers/powercap/intel_rapl_msr.c             | 251 +++++-
>  drivers/powercap/intel_rapl_tpmi.c            |  48 ++
>  .../int340x_thermal/processor_thermal_rapl.c  |   9 +
>  include/linux/intel_rapl.h                    |  17 +-
>  include/linux/units.h                         |   3 +
>  6 files changed, 562 insertions(+), 523 deletions(-)
>
> --

Whole series applied as 7.1 material, thanks!

