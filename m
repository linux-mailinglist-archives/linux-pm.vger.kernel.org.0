Return-Path: <linux-pm+bounces-37280-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FDAC29B93
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 01:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389F43AEE79
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 00:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480A6226D18;
	Mon,  3 Nov 2025 00:48:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9282253EF;
	Mon,  3 Nov 2025 00:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762130921; cv=none; b=Ke7Yllblyl5vm3iBq9fOddryfPMScjljqx1+HHWHS+o/r1FDBGCtphnvLqNCvEhwUxgZ5dPZsSriRjRc77TaXn/Ij3etIe/o/61bOrujoz8R1n/efhP4S+BTtQKNzcl5k16yE/Wzo1NDNgdIGYP0wkeqLZ5N0ZIwhB0NctF2WB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762130921; c=relaxed/simple;
	bh=LKDibR5PiwX9DKk8uCq2qfo8M+DSlz4ZgYHoGEMG7+w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lQPKE+ijHiGpJ9BI83PBl3YWlrgQIBQZ+TrlvNZ7u1X3zcGTTvl8sX46hfFFykaXh7Q9BW4HWckvRh7UGobw7O+UJvrxxj/yvFZDc78vweE+5hyOdpIiU33POsTZHtOc8aycyf2Zax3N9XAnz/G/O7CTg/C7olEPkye1fRZQww0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F55C2BCB0;
	Mon,  3 Nov 2025 00:48:40 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 76FAD1822DA; Mon, 03 Nov 2025 01:48:33 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Yixun Lan <dlan@gentoo.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Aurelien Jarno <aurelien@aurel32.net>
Cc: linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev
In-Reply-To: <20251102230352.914421-1-aurelien@aurel32.net>
References: <20251102230352.914421-1-aurelien@aurel32.net>
Subject: Re: (subset) [PATCH v5 0/2] driver: reset: spacemit-p1: add driver
 for poweroff/reboot
Message-Id: <176213091347.301408.11587695003687450479.b4-ty@collabora.com>
Date: Mon, 03 Nov 2025 01:48:33 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 03 Nov 2025 00:01:58 +0100, Aurelien Jarno wrote:
> This adds poweroff/reboot support for the SpacemiT P1 PMIC chip, which is
> commonly paired with the SpacemiT K1 SoC.
> 
> Note: For reliable operation, this driver depends on a this patch that adds
> atomic transfer support to the SpacemiT I2C controller driver:
>   https://lore.kernel.org/spacemit/20251009-k1-i2c-atomic-v4-1-a89367870286@linux.spacemit.com/
> 
> [...]

Applied, thanks!

[1/2] driver: reset: spacemit-p1: add driver for poweroff/reboot
      commit: 28124cc0fb8c7dc01a6834d227351e25d9a92c58

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


