Return-Path: <linux-pm+bounces-43468-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id z5JCJH0ipmn7KwAAu9opvQ
	(envelope-from <linux-pm+bounces-43468-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 00:51:25 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E03061E6D8B
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 00:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0AFB63009F15
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 23:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A00350A3D;
	Mon,  2 Mar 2026 23:51:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4FE338939;
	Mon,  2 Mar 2026 23:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772495479; cv=none; b=cqKwBye3YFg3fM772pnnuHwE31o9Cg5SdiG0MIMqIwGNMc+YI2ZPX6/7Gs9/5StELO2X0Y2plmrkiVyoIGsuJ6vJ+E0ZX9Pg1LloU2LkYr6vUM48tLjxEFc2VTO5eQVA4n+rbdPtyy6anP99F5ea6cM7+pcEM47+2v7Ku4EviCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772495479; c=relaxed/simple;
	bh=kHmTuXphPXpcY/ej+I7AdXfONMfwlkMthSz41XEqcAI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ra7FtpnzPuCS4/7Ey7deRxiuADPoQhYCgKZr/uhsAMJ7EggMdVF+H52FaadO5oZrr22fdjhc/kig2pnDlBJvVZP119Jdn7P0VWAlAGlxUIhK9Hwdu5z9ttHoLhlTx+rEoytp6t7Ls/4zTga9C9zfnSO0KmfaZrAuoJayJPhS/1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C95C19423;
	Mon,  2 Mar 2026 23:51:18 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 899B5180D08; Tue, 03 Mar 2026 00:51:16 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260130134021.353688-1-clamor95@gmail.com>
References: <20260130134021.353688-1-clamor95@gmail.com>
Subject: Re: [PATCH v1 0/2] power: supply: cpcap-battery: pass static
 battery cell data from device tree
Message-Id: <177249547653.612663.3021830485437919831.b4-ty@collabora.com>
Date: Tue, 03 Mar 2026 00:51:16 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: E03061E6D8B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[collabora.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-43468-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,atomide.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastian.reichel@collabora.com,linux-pm@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.870];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:mid,collabora.com:email]
X-Rspamd-Action: no action


On Fri, 30 Jan 2026 15:40:19 +0200, Svyatoslav Ryhel wrote:
> Add an option to populate battery cell properties from the device tree if
> the driver cannot access the battery's NVMEM.
> 
> Svyatoslav Ryhel (2):
>   dt-bindings: power: supply: cpcap-battery: document monitored-battery
>     property
>   power: supply: cpcap-battery: pass static battery cell data from
>     device tree
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: power: supply: cpcap-battery: document monitored-battery property
      commit: 62c395fa887c38dad878741b7a1095ef441ba813
[2/2] power: supply: cpcap-battery: pass static battery cell data from device tree
      commit: ca2199cb7ae0375071609460470eadbbde8a4dd5

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


