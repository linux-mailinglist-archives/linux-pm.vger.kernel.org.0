Return-Path: <linux-pm+bounces-41181-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OWxHVOyb2nMKgAAu9opvQ
	(envelope-from <linux-pm+bounces-41181-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 17:50:27 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DBC47F54
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 17:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 563DF5EBECB
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 15:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944B444CAFE;
	Tue, 20 Jan 2026 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqY0vvXR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBC044CADC;
	Tue, 20 Jan 2026 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768922625; cv=none; b=m7pqjFmbUnVGl5RHaU+XuCZZTz4QxFBbJj4fOnxHiMEEREN1ItLi8TKq19ng5cBCdbDc//bFnL/EcE/KBul9CbJnLF7OaHqk84XgeBqFHwrvTrJa4IzBB2spPAs3bin4Ph6YJ/6x3XfcBha/EdAvamMBWLcdN4eIekGuHbGU5Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768922625; c=relaxed/simple;
	bh=yFpqcP046V33uu7LH9iROjAkwfN+Ziy2MDZKuPNJabk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EGS7YZi10l/c+NudhKnSCZujvB+msLb33boTWAN+TxE4jfuL5tpuqqIauZiNV3Z4S8JUN1ODkxGTp2s4fMnBNAt++8+JUSOiQ03/Bk3g0KUoiC+LJJF4vsnbYTMePoK6zYvtxiYhLUffrDhV5w7XvilhDzgQ6sNwAoAeyrhRXRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqY0vvXR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B806CC16AAE;
	Tue, 20 Jan 2026 15:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768922624;
	bh=yFpqcP046V33uu7LH9iROjAkwfN+Ziy2MDZKuPNJabk=;
	h=From:To:Cc:Subject:Date:From;
	b=TqY0vvXR7bRhUJKoca81xN6InO15NdEjCG0GIrHXa81xsHN6yTgrk3r7msSaApANj
	 n5ku8XpIHXPLFKqEvGFMIsyIcTax3y+SvnTigROxJihbFOZCrZ/E+54hCuthuk+mL2
	 F7A8o9h57UjVqxHB8p92gLuHC5EOuERFDfbo7hu9XB+jaNqgnHLh8QeFEaPspkRF2H
	 5Q8BVGUBLgAnMbqnR/gAB6UtxFgEDU8QXz543gHfK8cqYyNzpg2E4n6W69w4+CTfD6
	 My0JBD2KMS17rT/HAcNQo4aTMd9LtxsBd8BgFPZXdcOVvgKF8YqEe8vjjgVY9BN/bm
	 VGnBttB3rf/rA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v1] thermal: intel: x86_pkg_temp_thermal: Handle invalid temperature
Date: Tue, 20 Jan 2026 16:23:41 +0100
Message-ID: <2815400.mvXUDI8C0e@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41181-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_ALL(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,intel.com:email,rafael.j.wysocki:mid]
X-Rspamd-Queue-Id: 06DBC47F54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit be0a3600aa1e ("thermal: sysfs: Rework the handling of trip
point updates"), THERMAL_TEMP_INVALID can be passed to sys_set_trip_temp()
and it is treated as a regular temperature value there, so the sysfs
write fails even though it is expected to succeed and disable the given
trip point.

Address this by making sys_set_trip_temp() clear its temp variable when
it is equal to THERMAL_TEMP_INVALID.

Fixes: be0a3600aa1e ("thermal: sysfs: Rework the handling of trip point updates")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/x86_pkg_temp_thermal.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -128,6 +128,9 @@ sys_set_trip_temp(struct thermal_zone_de
 	u32 l, h, mask, shift, intr;
 	int tj_max, val, ret;
 
+	if (temp == THERMAL_TEMP_INVALID)
+		temp = 0;
+
 	tj_max = intel_tcc_get_tjmax(zonedev->cpu);
 	if (tj_max < 0)
 		return tj_max;




