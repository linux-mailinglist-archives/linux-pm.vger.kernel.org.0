Return-Path: <linux-pm+bounces-19632-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F5C9FA173
	for <lists+linux-pm@lfdr.de>; Sat, 21 Dec 2024 16:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE2217A2183
	for <lists+linux-pm@lfdr.de>; Sat, 21 Dec 2024 15:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE00B13C8E2;
	Sat, 21 Dec 2024 15:54:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882C81FDA;
	Sat, 21 Dec 2024 15:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734796445; cv=none; b=Em7Y1FXwa3kA/YDa9AuDr+JThIY/hHbthEmmgQhG+BiGehc0WfQGKbQRteA+qpV6ePe+/oCbhxcliGnsdPPSTE4mKqfMTe0G4B5Nd9bXgs4g9kDnutC08fGZdOEpSGoiFJHJkm110aV/HBQtv3Th1F9ycGiNAps2HQP2mZJnBSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734796445; c=relaxed/simple;
	bh=qm6Pv55x2QHGYxooMDfCPnI0HCDGLsy3syUCTeoteOI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IVAjw6QoiQxhrRpRxkKSJ6AOMKBqGhRzp9KjSNNGWteWuYNVLkATp2b7fWpgd6B9iW00cYzIKVXdcpYJhI66gxtM8AWUyeIyrUSYyk67wAF0PPDyMrKglLlDlSG/nyfi+rVz7l4XI+xB60yY/mcHArS34jDI6V5CK+oXUTG0edI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02340C4CED0;
	Sat, 21 Dec 2024 15:54:04 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 9618E1060348; Sat, 21 Dec 2024 16:54:02 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, Bhavin Sharma <bhavin.sharma@siliconsignals.io>
Cc: tarang.raval@siliconsignals.io, 
 Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241220084958.32367-1-bhavin.sharma@siliconsignals.io>
References: <20241220084958.32367-1-bhavin.sharma@siliconsignals.io>
Subject: Re: [PATCH v13 0/2] power: supply: Add STC3117 Fuel Gauge
Message-Id: <173479644260.3359498.3393893755513748803.b4-ty@collabora.com>
Date: Sat, 21 Dec 2024 16:54:02 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 20 Dec 2024 14:19:53 +0530, Bhavin Sharma wrote:
> Adds initial support for the STC3117 fuel gauge.
> 
> Output of test_power_supply_properties.sh
> 
> TAP version 13
> 1..33
> # Testing device stc3117-battery
> ok 1 stc3117-battery.exists
> ok 2 stc3117-battery.uevent.NAME
> ok 3 stc3117-battery.sysfs.type
> ok 4 stc3117-battery.uevent.TYPE
> ok 5 stc3117-battery.sysfs.usb_type # SKIP
> ok 6 stc3117-battery.sysfs.online # SKIP
> # Reported: '1' ()
> ok 7 stc3117-battery.sysfs.present
> # Reported: 'Discharging'
> ok 8 stc3117-battery.sysfs.status
> # Reported: '30' % ()
> ok 9 stc3117-battery.sysfs.capacity
> ok 10 stc3117-battery.sysfs.capacity_level # SKIP
> ok 11 stc3117-battery.sysfs.model_name # SKIP
> ok 12 stc3117-battery.sysfs.manufacturer # SKIP
> ok 13 stc3117-battery.sysfs.serial_number # SKIP
> ok 14 stc3117-battery.sysfs.technology # SKIP
> ok 15 stc3117-battery.sysfs.cycle_count # SKIP
> ok 16 stc3117-battery.sysfs.scope # SKIP
> ok 17 stc3117-battery.sysfs.input_current_limit # SKIP
> ok 18 stc3117-battery.sysfs.input_voltage_limit # SKIP
> # Reported: '3577000' uV (3.577 V)
> ok 19 stc3117-battery.sysfs.voltage_now
> ok 20 stc3117-battery.sysfs.voltage_min # SKIP
> ok 21 stc3117-battery.sysfs.voltage_max # SKIP
> # Reported: '3200000' uV (3.2 V)
> ok 22 stc3117-battery.sysfs.voltage_min_design
> # Reported: '4200000' uV (4.2 V)
> ok 23 stc3117-battery.sysfs.voltage_max_design
> # Reported: '206000' uA (206 mA)
> ok 24 stc3117-battery.sysfs.current_now
> ok 25 stc3117-battery.sysfs.current_max # SKIP
> ok 26 stc3117-battery.sysfs.charge_now # SKIP
> ok 27 stc3117-battery.sysfs.charge_full # SKIP
> # Reported: '3000000' uAh (3 Ah)
> ok 28 stc3117-battery.sysfs.charge_full_design
> ok 29 stc3117-battery.sysfs.power_now # SKIP
> ok 30 stc3117-battery.sysfs.energy_now # SKIP
> ok 31 stc3117-battery.sysfs.energy_full # SKIP
> ok 32 stc3117-battery.sysfs.energy_full_design # SKIP
> ok 33 stc3117-battery.sysfs.energy_full_design # SKIP
> # Totals: pass:12 fail:0 xfail:0 xpass:0 skip:21 error:0
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: power: supply: Add STC3117 Fuel Gauge
      commit: 69a3761389cb9a3a05684e84a659c2799b62cbb3
[2/2] power: supply: Add STC3117 fuel gauge unit driver
      commit: 74e3f620852390a4e8359c6056d67af1e42b1b1c

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


