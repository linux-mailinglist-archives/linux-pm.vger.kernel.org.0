Return-Path: <linux-pm+bounces-11464-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4694293DAB5
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 00:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 019AE28412E
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 22:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E34150981;
	Fri, 26 Jul 2024 22:39:17 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ED014F9EE;
	Fri, 26 Jul 2024 22:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722033557; cv=none; b=Y2lR/tZTDPEh7oBGJcjlh8xcXurmOIYw1/tRm69uL8P9DZCh4hX3C6Ir8eyF4w6dj0H+IepYsyPC0/BP1yDA7g+clj6Nf7errOd1eThBQP9C6RnElPzX8Id+rsK1lDi+Gzaif7GNXN5Kv6XdHZCo91K8B0UuJ0UX2/bxio41xYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722033557; c=relaxed/simple;
	bh=zeojFsQiHDX4XmNxWccT0AR/xon04OLn1RGYQ8D2Tas=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dQHh7rEtyLWW8sQN828dM+ld+TfkDBM/ZCz0SrLztLy3sw5odcxAErFL/TqhlcH73XdN0flmJjFcDgNvjLPZiUWEilYDCDp0nYkkJVl4KuknLsFfQmpd8zPpAAV691iRj+3GT+Dw2KcqYtA+Om5JNNNwkzTRXgBXtrk3kQDV1JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E803CC4AF0B;
	Fri, 26 Jul 2024 22:39:16 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 67D5E106097F; Sat, 27 Jul 2024 00:39:14 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20240717200333.56669-1-hdegoede@redhat.com>
References: <20240717200333.56669-1-hdegoede@redhat.com>
Subject: Re: [PATCH 1/2] power: supply: axp288_charger: Fix
 constant_charge_voltage writes
Message-Id: <172203355435.246603.3475606894803303467.b4-ty@collabora.com>
Date: Sat, 27 Jul 2024 00:39:14 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 17 Jul 2024 22:03:32 +0200, Hans de Goede wrote:
> info->max_cv is in millivolts, divide the microvolt value being written
> to constant_charge_voltage by 1000 *before* clamping it to info->max_cv.
> 
> Before this fix the code always tried to set constant_charge_voltage
> to max_cv / 1000 = 4 millivolt, which ends up in setting it to 4.1V
> which is the lowest supported value.
> 
> [...]

Applied, thanks!

[1/2] power: supply: axp288_charger: Fix constant_charge_voltage writes
      commit: b34ce4a59cfe9cd0d6f870e6408e8ec88a964585
[2/2] power: supply: axp288_charger: Round constant_charge_voltage writes down
      commit: 81af7f2342d162e24ac820c10e68684d9f927663

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


