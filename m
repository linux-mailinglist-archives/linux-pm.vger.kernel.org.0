Return-Path: <linux-pm+bounces-34528-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD9AB54400
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 09:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F673BA08E
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 07:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFD92D0275;
	Fri, 12 Sep 2025 07:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="t0BOt3Qy"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672BB2C324D;
	Fri, 12 Sep 2025 07:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757662616; cv=none; b=NEoO2NaBh5dtmrZE1MNDBoUKymZ47rwURMqjG1xa1ftGZBBCVq360ShRTcWgi7983GLnNdVTCQ2HlQf4D4LVvd3NyDsik5lxHfeyPgxAJOR9LK5Kqcs8X0gcDqB48pJJz7mx7I8OAAGdzXgnULqG6IXM0SNXi1a17Dw9VSUz7yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757662616; c=relaxed/simple;
	bh=GWhgaIJNcX5gJ7ylYTfAO0G7hC/dPv5MnjLr/ldEdkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gB3uX3LFcE+A8fwcfy99sgcMWIEm15JkNIxYZiwRkg/2MLBOLjek+vlAabaRbYZfAZvRQDS/TinMXrixi9Ro4h5XrhEHtEZW5nqF5QvxjfHa4ibXO5e/0wIj+wwBuTF6zJyP5Kbmkm7mH7DD/nbTRR1yHZgwcxRte1/UH+UFgEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=t0BOt3Qy; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=iQePpiySKBUe3OfKkAmoPumu7+44E19hPRb0KlPpFxY=; b=t0BOt3Qy+23zPozlFwGCraLr/E
	FK80ST+EDMKRX47D1X8qtqiWYZK9unYaxhxMy2WzG38G2o6LBNfw2xsg5iWA+DCSdF+Z4xkrT6K8L
	7qxtZVz0+7fidgX+xbQeDCEciaegFFMCpqTnnLSvBGhi5y4I7KSjNOsn2vAMbhdAuvtpffvrISGyV
	9G2+OoYOhxlee5FNCZ1hLO55TpPzdnYc4bBX07xL6sDOIdh/Ag9NnrYwoY1tJzwEr0JHmRAl8IQO1
	8yC7/CJiNmCcx5CjBgPpJtMCx8nSruu4j1RVuxE104S7dyJW3J4Hv6o2K5+n9o2BgBSQ+dHi1J6ku
	DmCipxhg==;
Received: from i53875a48.versanet.de ([83.135.90.72] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uwyKr-00085j-5d; Fri, 12 Sep 2025 09:36:45 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
	Chris Morgan <macroalpha82@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	broonie@kernel.org,
	lee@kernel.org,
	lgirdwood@gmail.com,
	sre@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: (subset) [PATCH v8 0/5] Add Texas Instruments BQ25703A Charger
Date: Fri, 12 Sep 2025 09:36:30 +0200
Message-ID: <175766258325.683160.13363723166042765380.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250904160530.66178-1-macroalpha82@gmail.com>
References: <20250904160530.66178-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 04 Sep 2025 11:05:25 -0500, Chris Morgan wrote:
> Add support for the Texas Instruments BQ25703A charger manager. The
> device integrates a boost converter with the charger manager. This
> series adds the device as an MFD with separate regulator and power
> supply drivers. This allows us to manage a circular dependency with
> a type-c port manager which depends on the regulator for usb-otg
> but supplies power to the BQ25703A charger.
> 
> [...]

Applied, thanks!

[5/5] arm64: dts: rockchip: Add USB and charger to Gameforce Ace
      commit: 36d05f21da4d1879f7e81f18eae85f34e9c64aa5

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

