Return-Path: <linux-pm+bounces-43461-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDRWAjAYpmkCKQAAu9opvQ
	(envelope-from <linux-pm+bounces-43461-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 00:07:28 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D1D1E64EC
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 00:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5E6FA30117DE
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 23:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8886431F9BA;
	Mon,  2 Mar 2026 23:07:23 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7A62F9D82;
	Mon,  2 Mar 2026 23:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772492843; cv=none; b=BJh3woD+oAQysERRbcuaSJ2KCPzAgU0vR9OICLm/i6TEO4YOVBXUKbO/DNJDGjyBiB3bt+HXlSmSKTJVdPe4yXznPq1HrnMz/tPHEEC1L8y+EgYjW/GaDFaIszLztKET75hBTkmtqBXzctDsvz58LPK6Owt/m81cDc+fNHXHaYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772492843; c=relaxed/simple;
	bh=DHRjIFWCxvU8ccmBew/DyUv9QrerN2fu1cwXZDjBu/I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TseN2dHrtwZCx73uJ8C92/DokjOQHUjkP9EB5NwoXsS3q5dbTbFgULqUX3Qz7lyW4Tjf62UEFaKNbf0L1EWubHzHmkgmxuQ5lO3Gh8dPXn9tWOOhSBLCLYtnyUVidOAMaf/Hb2R6K3z1iMUitDDoa7ysldx3ivTwrTP2E72EzfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDAF9C19423;
	Mon,  2 Mar 2026 23:07:22 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id D94F3181254; Tue, 03 Mar 2026 00:07:20 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Sebastian Reichel <sre@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Ramakrishna Pallala <ramakrishna.pallala@intel.com>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 Amit Sunil Dhamne <amitsd@google.com>, kernel-team@android.com, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 stable@vger.kernel.org
In-Reply-To: <20260302-max77759-fg-v3-0-3c5f01dbda23@linaro.org>
References: <20260302-max77759-fg-v3-0-3c5f01dbda23@linaro.org>
Subject: Re: [PATCH v3 00/11] power: supply: max17042: support Maxim
 MAX77759 fuel gauge
Message-Id: <177249284087.588775.13895048096276647752.b4-ty@collabora.com>
Date: Tue, 03 Mar 2026 00:07:20 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 16D1D1E64EC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[collabora.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43461-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastian.reichel@collabora.com,linux-pm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,collabora.com:mid,collabora.com:email]
X-Rspamd-Action: no action


On Mon, 02 Mar 2026 13:31:59 +0000, André Draszik wrote:
> This series adds support for the fuel gauge integrated into the Maxim
> MAX77759, which is a companion PMIC intended for use in mobile phones
> and tablets and is used on Google Pixel 6 and 6 Pro (oriole and raven).
> 
> Amongst others, the PMIC contains a fuel gauge employing the Maxim
> ModelGauge m5 algorithm, that is similar to the ones supported by the
> max17042 driver and binding.
> 
> [...]

Applied, thanks!

[01/11] dt-bindings: power: supply: max17042: add support for max77759
        commit: 7a9ae6e2457d654cb3b2597882d61297ce9652c3
[02/11] dt-bindings: power: supply: max17042: support shunt-resistor-micro-ohms
        commit: cb850494d77ab8bf1ebe40a1e6c709724a899e87
[03/11] dt-bindings: power: supply: max17042: drop formatting specifier |
        commit: ef67048dca6a94ecd874565a48f023dead25d7b7
[04/11] power: supply: max17042: fix a comment typo (then -> than)
        commit: 62b5cb32f0beed13cf6d7cf4605e09eb92f2f64c
[05/11] power: supply: max17042: use dev_err_probe() where appropriate
        commit: 092a518f8e8f97aa4e50c413600a849dcd0a8705
[06/11] power: supply: max17042: avoid overflow when determining health
        commit: 1c6b480642c8457e477867f348d1347ac2f6bb82
[07/11] power: supply: max17042: time to empty is meaningless when charging
        commit: c4ff06590c3149fa5cc3061c7877cd75df4351e9
[08/11] power: supply: max17042: support standard shunt-resistor-micro-ohms DT property
        commit: 460f54cd8dee5f048fe33d1858db919566c73d0e
[09/11] power: supply: max17042: initial support for Maxim MAX77759
        commit: 4ece9d5d7fcd176821f41a278dfa9efd87544afd
[10/11] power: supply: max17042: consider task period (max77759)
        commit: add02276239b8af842f2e761774fcd8a861c2d48
[11/11] power: supply: max17042: report time to full (max17055 & max77759)
        commit: bb42637516d058c412d2acabab4cd2a455ecd769

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


