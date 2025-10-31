Return-Path: <linux-pm+bounces-37179-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BAAC24E89
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 13:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF1CA189BB64
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 12:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2203054C2;
	Fri, 31 Oct 2025 12:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dwurp.de header.i=@dwurp.de header.b="ZAYGvruo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.dwurp.de (mail.dwurp.de [185.183.156.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE38730DD2A
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 12:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.183.156.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761912198; cv=none; b=oAUPqR0hsgKMxJdDoqswufzzk7yeHxRKQHp+kLxkeBBAooTKeFsMx0jB9brsf2PwY07pS/mXDRuhCzU8Hlqslq/W9Hnk5WoL43jPJp622x/tq6Xg7lTgWSJEfL9wOoDM+1wuLLLywzhpPd8aJbUFTTcanp4PA5nBTMnFsBJswaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761912198; c=relaxed/simple;
	bh=mIJRpM7OMor0+Ent7b8EP0n6f3sY/K0CCDHCl8CUCfY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=PURLmVC2KO3mCSkukPqaSJwwRwm4PmuymfULd5lc/us6JTLs3w4VUcPz2/1VRLpYJzoUXChv0WdkNW3ncXNURyBEsI5F0dJg/wlWy143Cm2bROn4OGXhOaL5ygGz3SkGhsuPXi0MiNnl17W61LFXF8WcOpZ0n5AsCPuAi4uJ+Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dwurp.de; spf=pass smtp.mailfrom=dwurp.de; dkim=pass (1024-bit key) header.d=dwurp.de header.i=@dwurp.de header.b=ZAYGvruo; arc=none smtp.client-ip=185.183.156.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dwurp.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dwurp.de
Message-ID: <078eef57-07c9-420a-99b1-e47b3dd93204@dwurp.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dwurp.de; s=mail;
	t=1761912185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=z7YtlgvEMBaBPvri+yrStwdxL2p0WLfpE3WhraNm/fE=;
	b=ZAYGvruoMmOg9C7r5s4ecnj6RaLMN1a5LVei2ntznAMWU45g1Nji5fpKABuez1p3uhfMxO
	QQfYT8XufpBUpgf1jCsdzg9pnvvTL2u79VuO5KDJg11G0+5O1gX/LEb2jGFhO6YLjooIui
	2fwo67Hud6tSNtiINh1n5sLHFdsTG9A=
Date: Fri, 31 Oct 2025 13:03:02 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sebastian Fleer <dev@dwurp.de>
Subject: power_supply sbs-9-000b: driver failed to report `technology'
 property: -5 on rk3399 google-gru
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
Content-Language: en-US, de-DE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

on an Acer Chromebook Tab 10 (RK3399 google-gru/scarlet) we see a lot of these error messages
(sometime multiple times per second):

[  247.155467] power_supply sbs-9-000b: driver failed to report `technology' property: -5

With POWER_SUPPLY_DEBUG=y these look like this:

[  142.335138] power_supply sbs-9-000b: driver failed to report `technology' property: -5
[  142.352393] sbs-battery 9-000b: sbs_unit_adjustment: no need for unit conversion 0
[  142.352437] sbs-battery 9-000b: sbs_get_property: property = 0, value = 1
[  142.353283] sbs-battery 9-000b: sbs_unit_adjustment: no need for unit conversion 51
[  142.353310] sbs-battery 9-000b: sbs_get_property: property = 51, value = 0
[  142.355202] sbs-battery 9-000b: sbs_unit_adjustment: no need for unit conversion 2
[  142.355231] sbs-battery 9-000b: sbs_get_property: property = 2, value = 0
[  142.359681] sbs-battery 9-000b: sbs_read_string_data_fallback: i2c read at address 0x22 failed

Battery status reporting with upower seems to be hit or miss:

$ upower -i /org/freedesktop/UPower/devices/battery_sbs_9_000b
   native-path:          sbs-9-000b
   vendor:               <unkn>
   model:                <BATT>
   serial:               ffff
   power supply:         yes
   updated:              Fri Oct 31 12:41:02 2025 (3 seconds ago)
   has history:          yes
   has statistics:       yes
   battery
     present:             yes
     rechargeable:        yes
     state:               discharging
     warning-level:       action
     energy:              0 Wh
     energy-empty:        0 Wh
     energy-full:         36.55 Wh
     energy-full-design:  33.78 Wh
     voltage-min-design:  3.84 V
     voltage-max-design:  3.84 V
     energy-rate:         0 W
     charge-cycles:       N/A
     percentage:          0%
     temperature:         23.9 degrees C
     capacity:            100%
     icon-name:          'battery-caution-symbolic'
   History (charge):
     1761910862  0.000   discharging
     1761910806  62.000  discharging
     1761910801  0.000   discharging
     1761910796  62.000  discharging
     1761910791  0.000   empty
     1761910755  62.000  discharging
   History (rate):
     1761910851  0.000   discharging
     1761910821  4.380   discharging
     1761910791  0.000   empty
     1761910760  1.658   discharging

$ upower -i /org/freedesktop/UPower/devices/battery_sbs_9_000b
   native-path:          sbs-9-000b
   vendor:               <unkn>
   model:                <BATT>
   serial:               ffff
   power supply:         yes
   updated:              Fri Oct 31 12:41:07 2025 (18 seconds ago)
   has history:          yes
   has statistics:       yes
   battery
     present:             yes
     rechargeable:        yes
     state:               discharging
     warning-level:       none
     energy:              22.6548 Wh
     energy-empty:        0 Wh
     energy-full:         36.54 Wh
     energy-full-design:  33.77 Wh
     voltage-min-design:  3.84 V
     voltage-max-design:  3.84 V
     capacity-level:      Unknown
     energy-rate:         73.1904 W
     charge-cycles:       N/A
     time to empty:       18.6 minutes
     percentage:          62%
     capacity:            100%
     icon-name:          'battery-full-symbolic'
   History (charge):
     1761910867  62.000  discharging
     1761910862  0.000   discharging
     1761910806  62.000  discharging
     1761910801  0.000   discharging
     1761910796  62.000  discharging
     1761910791  0.000   empty
   History (rate):
     1761910867  73.190  discharging
     1761910851  0.000   discharging
     1761910821  4.380   discharging
     1761910791  0.000   empty

These errors show up with kernel 6.12.55 as well as 6.17.5.

More context is available here: https://gitlab.postmarketos.org/postmarketOS/pmaports/-/issues/2261

Any idea on how to fix this is highly appreciated.

Best regards
Sebastian

