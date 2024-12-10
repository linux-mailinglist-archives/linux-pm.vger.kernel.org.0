Return-Path: <linux-pm+bounces-18914-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F469EB2A0
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 15:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E94FF16E3E9
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 14:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07ADE1BC065;
	Tue, 10 Dec 2024 14:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mUuKazj7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484CA1B86E9
	for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2024 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839362; cv=none; b=cFQ5MnJWy2TQ2koYkQqVu0RZkfkDyfmCI1WtcT6ikOBCXQtfmTlKdqJ9RHPLfwSWVbAdXKsjjBFDA1ebFTRLWCiR21T8FnL6gvQ+IqmrbkwFGeeIeBvmp7BHznKPvg70zuP0uK24q2ioXFo+7Jlg/329igoTgPbHBmRyvS1HI4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839362; c=relaxed/simple;
	bh=aMYlasDeJRUJ32CNMkhoq5ueHiY13RagJkPagQJl8N8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uvKu9gwsRKIi9iV9AI7BSHeso4wsE2zIUYPD5EONxgHmullEZE7HrSacJJTOMi7VMSbAYCQLceRsu7Y9cEf06bherTeP86DQUOQ7Mi6+ENELQTvnZcx7Vpt8ztqccg6cSiAqrBVPb1sS++watE2sB9N/0hawnnPuS9YLS9qukXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mUuKazj7; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6efa1e49ef0so56519657b3.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2024 06:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733839360; x=1734444160; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nf1alUKYDHbJzrOQtPD7/2cDvoI+WL/sLXAyfBpVNbU=;
        b=mUuKazj7oh0+fOTEh7Tag7gmc0Jyg5J4mXkorkdrP2Zxh/VEwlyzskqutYES5r+lAo
         hyJuq8fzsbK6BGzFlAM3ItLQqdd4dUeJlCdwxFMzPjXrkZwrTbLZ9630hxXPWZ83hafp
         7YVpmQDcWinpREjS14P4grJ0l+AITeiNItnXZYyzySQfBPCsmvxWpK97Dd8tAnayMMhv
         Ph0N5cDYNrpzj/6ee3ejyrt4Brcwnjnn9EF5tPnyVNpfiI5TpeAW+z1oQW1H271/pXAv
         PqFzBkylbr0UaaCKifiu/7BIL/BvFY42GoVUBGwoKpHsY25XXo7nvckaAinDyjVULsLp
         m2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733839360; x=1734444160;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nf1alUKYDHbJzrOQtPD7/2cDvoI+WL/sLXAyfBpVNbU=;
        b=QLUlv6MxPXX29wgFm1HdEWnc6XDpngkqlRfCoeyDJovtxchzJtvDo4rHBDY6IDB5YU
         8Hcwiw54gKjxGSGY7Qnerv6tONZ4wtWg3K07KCU9EBRZNSySigNjlO0xDUrhW/i/a5T3
         JPUB/oCLhUZW7I31365Gx+ZoYhZBLYTADjPDSV6gAC8Jpn2PTZLUBCvfV6j2xuZJaD4k
         XS/9V28XpPnwptgThbuuB5PhyVDH3MmFK6pekbkBhsOtNV5sPa9MZC/t5BA2WZyCZeCk
         Jo/ju/dAq1eMeAIIsc8/DKhZ1WtQALkygj9BxhK/f/01yd3Unv+YqcIp0ToddxV4CeqB
         NvpQ==
X-Gm-Message-State: AOJu0YwXQVXWb7+552Ngdi6xP/Dw+wgRfjIS2X68ixApnZgMbMp7Ty+3
	OPRtlTtaGe2mr2uTYMexQOSQb7Odxd6/ArqxCvkbqnSsjgnDvuw7bpr1JKSN5/VpvkP7Yo3oauG
	MGlHdFVsFHa9vPENgli/KkcaY7bsiOBdPFHkGkw==
X-Gm-Gg: ASbGncu68bp6dbG9fclaxB4r6qo8U9jNJaBqpK8PrvpGnLoUM+KGEvZKf/cghcdAAz2
	MpQNRGam6qY6uAibjX7AqyzETO2bM1maD2sX3
X-Google-Smtp-Source: AGHT+IHLRbGi59lCkKe21fHCD52MhJo63vY1GxLN7FsYIjyR+ox+8Qq2xjQAj0m60a2wLlxdHI5Bsw1heijOTMpYZdc=
X-Received: by 2002:a05:6902:1ac3:b0:e38:dfe:3c88 with SMTP id
 3f1490d57ef6-e3a0b0bd7cfmr16666843276.12.1733839360151; Tue, 10 Dec 2024
 06:02:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206-lpm-v6-10-constraints-pmdomain-v6-0-833980158c68@baylibre.com>
In-Reply-To: <20241206-lpm-v6-10-constraints-pmdomain-v6-0-833980158c68@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 10 Dec 2024 15:02:04 +0100
Message-ID: <CAPDyKFo9N8M73Z6Ltsbnd-WR-jYAqBedAHndViSD7YaKKYgBsA@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] pmdomain: ti_sci: collect and send low-power mode constraints
To: Kevin Hilman <khilman@baylibre.com>
Cc: linux-pm@vger.kernel.org, Nishanth Menon <nm@ti.com>, Dhruva Gole <d-gole@ti.com>, 
	Akashdeep Kaur <a-kaur@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Dec 2024 at 23:13, Kevin Hilman <khilman@baylibre.com> wrote:
>
> The latest (10.x) version of the firmware for the PM co-processor (aka
> device manager, or DM) adds support for a "managed" mode, where the DM
> firmware will select the specific low power state which is entered
> when Linux requests a system-wide suspend.
>
> In this mode, the DM will always attempt the deepest low-power state
> available for the SoC.
>
> However, Linux (or OSes running on other cores) may want to constrain
> the DM for certain use cases.  For example, the deepest state may have
> a wakeup/resume latency that is too long for certain use cases.  Or,
> some wakeup-capable devices may potentially be powered off in deep
> low-power states, but if one of those devices is enabled as a wakeup
> source, it should not be powered off.
>
> These kinds of constraints are are already known in Linux by the use
> of existing APIs such as per-device PM QoS and device wakeup APIs, but
> now we need to communicate these constraints to the DM.
>
> For TI SoCs with TI SCI support, all DM-managed devices will be
> connected to a TI SCI PM domain.  So the goal of this series is to use
> the PM domain driver for TI SCI devices to collect constraints, and
> communicate them to the DM via the new TI SCI APIs.
>
> This is all managed by TI SCI PM domain code.  No new APIs are needed
> by Linux drivers.  Any device that is managed by TI SCI will be
> checked for QoS constraints or wakeup capability and the constraints
> will be collected and sent to the DM.
>
> This series depends on the support for the new TI SCI APIs (v10) and
> was also tested with this series to update 8250_omap serial support
> for AM62x[2].
>
> [1] https://lore.kernel.org/all/20240801195422.2296347-1-msp@baylibre.com
> [2] https://lore.kernel.org/all/20240807141227.1093006-1-msp@baylibre.com/
>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---
> Changes in v6:
> - fix build warning on arm32 when building with W=1 and CONFIG_PM_SLEEP=n
> - rebase onto v6.13-rc1
> - fix latency units: convert usecs (PM QoS) to msecs (TI SCI)
> - all dependencies are now merged in v6.13-rc1
> - Link to v5: https://lore.kernel.org/r/20241101-lpm-v6-10-constraints-pmdomain-v5-0-3011aa04622f@baylibre.com

v6 applied for next and by amending patch1 to deal with the sorting of
include files, thanks!

[...]

Kind regards
Uffe

