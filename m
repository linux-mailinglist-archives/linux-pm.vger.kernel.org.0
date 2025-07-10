Return-Path: <linux-pm+bounces-30558-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F07EB00059
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 13:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99C5F17AE71
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 11:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7AC2D9485;
	Thu, 10 Jul 2025 11:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="BzgOQ4wH"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A4620FA9C;
	Thu, 10 Jul 2025 11:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752146234; cv=none; b=GRbfUy3aD9/rZAXtsINVWHQ2rV7OSqPgo8FX/xvZfwIqvK5aCkSRDfGdgMaXgYoEASjefApunK7He4HzPFGJda93yKDafnAjRLprJU5dTePepRyr+WFoy4+UJSu71U3xsQZpDRLItnQUUFarUGLKmcNwhr9dReALYSNe+ICKlx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752146234; c=relaxed/simple;
	bh=QvwwnPsW3knLIltBIEoiitBnipa0SwOi009wD+wqp4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dRj66xxLm91S/8T/xwCb0lniy/05Q7yHogyEgV/MJUAyX29nRXRMRIEQ1fEhiE4BItOID/W7PfAKfEw97zWb9YKhiK9/5b0geFKlU1nQkY3VtZC/mUDYgMmDBkiIvQFiLohejDcQwcVJWRNipMDo5gw2uU9q7v+raTfLQS7LQj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=BzgOQ4wH; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=QvwwnPsW3knLIltBIEoiitBnipa0SwOi009wD+wqp4Y=; b=BzgOQ4wH9LxFHFXobmsfZMf6m5
	Baa4elG56mrwz+nWPNi4kTSrOuSdhD/tW1ICcxbzClt5fiGocQj2RDWwHETI9eHJJE3ofyDGDu4mx
	xOTaWyL49oBdUUZ9X0ojAD997KZGLalsYIMG1m8BFVwvzUBMB1AGJFiSVa3OVbGCJ4KlkqJijKuxO
	h7hbRCJitCLvy+AL9rpKHc8QmMDu9RbY3gUhkk0zXTP9oDFcR1E2447W5S1MJcomFgdbOlYHP8HOm
	IXWiaeNqH89hCyM2aB4EF+JXX5hYpScQxft1pvZKcLaCbXw5q42jT2S9wbfMtHyioywKZwMwg3xFY
	d2verbrw==;
Received: from [194.95.143.137] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uZpGv-0004Ql-5M; Thu, 10 Jul 2025 13:17:01 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Alexey Charkov <alchark@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, kernel@collabora.com,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject:
 Re: [PATCH v6 2/7] dt-bindings: rockchip-thermal: Add RK3576 compatible
Date: Thu, 10 Jul 2025 13:17:00 +0200
Message-ID: <6689502.31r3eYUQgx@phil>
In-Reply-To: <20250610-rk3576-tsadc-upstream-v6-2-b6e9efbf1015@collabora.com>
References:
 <20250610-rk3576-tsadc-upstream-v6-0-b6e9efbf1015@collabora.com>
 <20250610-rk3576-tsadc-upstream-v6-2-b6e9efbf1015@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 10. Juni 2025, 14:32:38 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Nicolas Frattaroli:
> Add a new compatible for the thermal sensor device on the RK3576 SoC.
>=20
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Acked-by: Heiko Stuebner <heiko@sntech.de>



