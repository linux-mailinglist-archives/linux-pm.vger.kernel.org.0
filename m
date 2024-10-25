Return-Path: <linux-pm+bounces-16484-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8049B0C5A
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 19:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D4951C203F6
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 17:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09610189F45;
	Fri, 25 Oct 2024 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jiT6XWP3"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355A8800;
	Fri, 25 Oct 2024 17:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879157; cv=none; b=Z7ydio3ROic96Tk0gLCEfy98qW7C0nrOwZnkbwxAsDaqOvDy05QwBhBuPss/ZvDefPIwb8SHjEL+aTTCdNA94BsNaCXcPOru4695wevYX+CnHkEUJX5G8SGGaFf9B+qjC1LaEwH4a5Wqdpg9hpYxt1vRUyl01huNdl/T0Q0zeh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879157; c=relaxed/simple;
	bh=u2eL/kAdmCfRHjkRdT0GhObtfJQkXd41mks2/mXhkiA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H8HTxtKsn4h3sLQ+8ZQeB/1hYGNXCOvnPJNWMAe+PHlN5/wc9zoA/KOxMxt606EbMR4oGUDIQynwqH7CZ39RCItW7QdYHfCAD6stfv5H0JpCylvMN8W/Moy9QVThOV7FsByhktPkbNfgc3ZUeLwfdUP7HxywaHd3Rr+hCDYAHXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jiT6XWP3; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49PHwxRh030612;
	Fri, 25 Oct 2024 12:58:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729879139;
	bh=GpSLalUzNrmD4PotMuaGBUbYK1zZiH71ItNeVXW7vwg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=jiT6XWP3MtkUN8Fn8mLyH9gfqD+XVyV79JzdSj4FU+yIxhqjBbd67YizLn5m7CUK3
	 XqA+GOjm0tsfwzAiysVbeZyCN5LLxje/eUfSz0LUVl/kZ8V4osONphjWnp9crqRVRw
	 z8OrR1vSjtUXMQlfKGr1e9l6o9mdqdt79qkO0UJU=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49PHwxN8078354
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 25 Oct 2024 12:58:59 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Oct 2024 12:58:58 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Oct 2024 12:58:58 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49PHwwkI023370;
	Fri, 25 Oct 2024 12:58:58 -0500
From: Nishanth Menon <nm@ti.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len
 Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>
CC: Nishanth Menon <nm@ti.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Kamlesh Gurudasani <kamlesh@ti.com>,
        Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>,
        Vishal Mahaveer <vishalm@ti.com>, Akashdeep Kaur
	<a-kaur@ti.com>
Subject: Re: [PATCH v13 0/5] firmware: ti_sci: Introduce system suspend support
Date: Fri, 25 Oct 2024 12:58:55 -0500
Message-ID: <172987909155.476920.13344501386526710095.b4-ty@ti.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241007-tisci-syssuspendresume-v13-0-ed54cd659a49@baylibre.com>
References: <20241007-tisci-syssuspendresume-v13-0-ed54cd659a49@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Markus Schneider-Pargmann,

On Mon, 07 Oct 2024 08:08:53 +0200, Markus Schneider-Pargmann wrote:
> Abstract
> ********
> 
> This series introduces necessary ti_sci driver functionality to support
> various Suspend-to-RAM modes on TI AM62 family of devices. These Low
> Power Modes include Deep Sleep and MCU Only as described in section
> "6.2.4 Power Modes" of the AM62P Technical Reference Manual [0].
> 
> [...]

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

NOTE: I have picked up Ack from Rafael per [2] and applied the full series.

[1/5] PM: QoS: Export dev_pm_qos_read_value
      commit: 3e360703d0bff3bb5643b2a0bf9a670931ba8b71
[2/5] firmware: ti_sci: Add support for querying the firmware caps
      commit: 055b6cfb62f5a1ea811aa21b96f2e611329b12b8
[3/5] firmware: ti_sci: Add system suspend and resume call
      commit: ec24643bdd625971933451f22b8e33d364920f6e
[4/5] firmware: ti_sci: Introduce Power Management Ops
      commit: 60357991f6b9d4bd4dc442a368da3f468cfa4903
[5/5] firmware: ti_sci: add CPU latency constraint management
      commit: a7a15754c7f70a833ffeb9ad996b358924f10305

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
[2] https://lore.kernel.org/lkml/CAJZ5v0g1Ri_wKYppomE6RXqcZXRnX7bLOPMtsQaao0uchSfE9A@mail.gmail.com/
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D


