Return-Path: <linux-pm+bounces-25878-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEE4A963A1
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 11:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A62D73A47D4
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 09:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260D11EFFAB;
	Tue, 22 Apr 2025 09:05:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F719476
	for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2025 09:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745312724; cv=none; b=kZmOsPniXUG2560ZrnkCYCj24jB4l+bYkcTPt6+jAYsHnTQQYCar61aAxDc5xYUdpM3qsjWShLBU6NHZ9tOZ7MV1C2DstrvhJQzDsu6cTPylv3xTnQea15GtE97iAVKPlK9C557mFQLCiE/t+VyoHWgexd2VvZkb6YlqXOqjWME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745312724; c=relaxed/simple;
	bh=TZonv/6iYJ38tTawNSsaWLZKkPcyirYh0sJkKVflj2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIuyEp4Q3laP9OmH5HeiVN5wm4Miw51aw7v7ettfl+YmjFwMij1S7UiFzK7X/HD4T4tKMpeAqHWapYvwDY+uXXaZdw3PgDBzVr/jQMb2G0ASsdUh2J+S/A4qwsRP1dLG62N3zmV0k27s6Xuo6xs1ukH0ZrPidWii5Kchi2UMUZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u79Z3-0001P0-34; Tue, 22 Apr 2025 11:05:13 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u79Z2-001WYe-0y;
	Tue, 22 Apr 2025 11:05:12 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u79Z2-00F5gw-0Z;
	Tue, 22 Apr 2025 11:05:12 +0200
Date: Tue, 22 Apr 2025 11:05:12 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	=?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>,
	Guenter Roeck <groeck@chromium.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v9 1/7] power: Extend power_on_reason.h for upcoming
 PSCRR framework
Message-ID: <aAdbyEQT4mJ4BlRA@pengutronix.de>
References: <20250422085717.2605520-1-o.rempel@pengutronix.de>
 <20250422085717.2605520-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250422085717.2605520-2-o.rempel@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

On Tue, Apr 22, 2025 at 10:57:11AM +0200, Oleksij Rempel wrote:
> Prepare for the introduction of the Power State Change Reason Recorder
> (PSCRR)  framework by expanding the power_on_reason.h header. This
> extension includes new power-on reasons:
> - POWER_ON_REASON_OVER_CURRENT for over-current conditions.
> - POWER_ON_REASON_REGULATOR_FAILURE for regulator failures.
> - POWER_ON_REASON_OVER_TEMPERATURE for over temperature situations.
> - POWER_ON_REASON_EC_PANIC for EC panics
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

I forgot to add:
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

