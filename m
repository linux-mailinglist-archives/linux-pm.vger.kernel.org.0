Return-Path: <linux-pm+bounces-12181-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA5C950DBF
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 22:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFEF11F23626
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 20:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40ACB1A3BAB;
	Tue, 13 Aug 2024 20:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="uUngCoN6"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F809187F;
	Tue, 13 Aug 2024 20:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723580494; cv=none; b=igiA8T70tEJJYE9q73RLkic7Xq7A1vPQsJPErUjErNi2m0zxzs4JezZAPvvocCSGBGyMyvooZSYMXkg6o+5EQVzTZWuAy/NQoLTH+2E7oGDiCKYVFo4maxmvvzW7/ICou5grHtAiVSgX5hKhar9WqxSlkOsVkuDqU0U7RMVqK/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723580494; c=relaxed/simple;
	bh=qj99utWeg4VoBQ0jzJtUxbx4AsS/LQaSgC9lsUkge3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fjoy3ZiYa2iA/csHclDfBWkV8xxoc6nfoq0bO3NjeanGPaAlVtMpvaOh832Dm4GFZyUtW7vIVtd2os1WzRjvUaU+LPX0R4WDNial4f1+gjZqy8RaRmSsBcGSdZZCh26bKNXcsCOxCxz+RNQwyKy3F1C5LodHPeGqmGOu2ls+4yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=uUngCoN6; arc=none smtp.client-ip=192.19.144.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 6A2A8C0000FB;
	Tue, 13 Aug 2024 13:21:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 6A2A8C0000FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1723580490;
	bh=qj99utWeg4VoBQ0jzJtUxbx4AsS/LQaSgC9lsUkge3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uUngCoN6C/slC9Qxh9f6SYlP8G6SdSe29J1ZOaBGNNc7/efQFx6QZa4pYg58RwukN
	 jVW1yx2BMX2oU9S14MRnjjeSsK9Y+tUnZqHtVorqA87XqmZjPZ+6yZmQeQoOMQEpgl
	 POKPfcEaSVj+BMs0WaYjd+2ycqCp/66i8XKR9huc=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 73A0418041CAC6;
	Tue, 13 Aug 2024 13:21:27 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	Stefan Wahren <wahrenst@gmx.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Maxime Ripard <mripard@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	=?iso-8859-1?b?TWHtcmE=?= Canal <mcanal@igalia.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Minas Harutyunyan <hminas@synopsys.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Lukas Wunner <lukas@wunner.de>,
	Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
	Peter Robinson <pbrobinson@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-pm@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel-list@raspberrypi.com
Subject: Re: [PATCH V2 01/16] firmware: raspberrypi: Improve timeout warning
Date: Tue, 13 Aug 2024 13:21:29 -0700
Message-Id: <20240813202129.3856485-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240728114200.75559-2-wahrenst@gmx.net>
References: <20240728114200.75559-1-wahrenst@gmx.net> <20240728114200.75559-2-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Sun, 28 Jul 2024 13:41:45 +0200, Stefan Wahren <wahrenst@gmx.net> wrote:
> Recent work on raspberry-power driver showed that even the
> stacktrace on firmware property timeout doesn't provide
> enough information. So add the first tag name to the warning
> to be in line with a status error.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/drivers/next, thanks!
--
Florian

