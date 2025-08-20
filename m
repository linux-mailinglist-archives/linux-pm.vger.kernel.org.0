Return-Path: <linux-pm+bounces-32743-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 411EAB2E685
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 22:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EBF4A26363
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 20:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A74E2C2ABF;
	Wed, 20 Aug 2025 20:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="di0Cf9Kp"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F81C296BD4;
	Wed, 20 Aug 2025 20:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755721485; cv=none; b=EcMYDqtpedY8ksxtrUoJDjQsUtneL9bErcq7qTmV8MpkgriKLeZFLIZ1287NU7OTu1K8HQ16GDQqFg0D7/1/K4jv7s5K53MzqzhNgIpoUt0w0ne2dGHuQfPnGtWZREeOQr6VGxZaepWwo5IYRNPeDvdZQfvSfkixpdGLRS3FLj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755721485; c=relaxed/simple;
	bh=2v+IMVm6IgqZGS8Hphp9DRXBHawewl2uEW+/r9BI/EM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BgnS3Unlz6Q1mt10SsNG1t0dZSjFxx9+ExqCSzpBOfeJXH8bwvLSP1ya8sNXonB6A62zKzxQ28JqbHb//xthqkmATDqouxsHbd40chFeF+nqtkt7qyuh59R8+lAqsqya+A1ZQsMe1mHVPwF6oKXCXGEXWRvwkAHw0/qjA/dZy/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=di0Cf9Kp; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=2v+IMVm6IgqZGS8Hphp9DRXBHawewl2uEW+/r9BI/EM=; b=di0Cf9Kp78VENfldn13Bjh+KjB
	ZfCO6iYwRdSq7AySPsjmXPdn8tBz+HY/n3GG5HgjUDBJ5VpPf7A5doHpjQH1ZTaVprVIJQIYtV5cJ
	wJnqhNLs+fvoGqGLLqbgFAOz3RiS3OO0eMXshZiP7f+3c6ZUU0FnXUZ0Cok1xXBM/vQv3CwA8GQdY
	G6bgygCLL6sS/S0m8f8Mlsuywj4KSWLEJdOU3ZcBew/KN3thNxwRFVqvbNlPTcMMvvB90cYkgn3oo
	mbcxkz6MRrF8oq35OgYGIU66De7LB9rgEvN1RD8VgoByVTRdKF2eY/tGpc55VJ8Ed784Idlh+hqs1
	Y5D3cRdQ==;
Received: from i53875a0d.versanet.de ([83.135.90.13] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uop9M-0001iT-5z; Wed, 20 Aug 2025 22:11:12 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
 Diederik de Haas <didi.debian@cknow.org>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
Subject:
 Re: [PATCH v2 1/3] thermal: rockchip: unify struct rockchip_tsadc_chip format
Date: Wed, 20 Aug 2025 22:11:11 +0200
Message-ID: <6318605.2l3rmUXbR5@diego>
In-Reply-To:
 <20250820-thermal-rockchip-grf-warning-v2-1-c7e2d35017b8@kernel.org>
References:
 <20250820-thermal-rockchip-grf-warning-v2-0-c7e2d35017b8@kernel.org>
 <20250820-thermal-rockchip-grf-warning-v2-1-c7e2d35017b8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Mittwoch, 20. August 2025, 19:40:47 Mitteleurop=C3=A4ische Sommerzeit sc=
hrieb Sebastian Reichel:
> Unify all chip descriptions to the version without any empty
> lines.
>=20
> Suggested-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>




