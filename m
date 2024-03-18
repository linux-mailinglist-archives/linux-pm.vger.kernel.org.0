Return-Path: <linux-pm+bounces-5078-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FAC87F209
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 22:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A6EF1F21A16
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 21:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2699559B5E;
	Mon, 18 Mar 2024 21:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GFPz1DB5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="sP5Qt6UG"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985195821B;
	Mon, 18 Mar 2024 21:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710797098; cv=none; b=mTzWW10655PgcJL1m77ueNesr/Hwzoc9ik2I5b9kx1x2SWMKgQn9YdtX/1X4YOlsWKvJs6Qgd4d3nLf2OXdiz1D1ypjXOebtDhHyhHDpXJAroNROGJakXLdsdfWJnElylwBaznsM+ZqsJ0nIOwJXe5rxB7RHraXg3EciB67LsXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710797098; c=relaxed/simple;
	bh=xwC5o7BEiXf9FRl2hIxykD7yqDyuhrPupfBToOJJlTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tguVCIpHlDt8I5vyUFbGkUelAEYRph3Ws7U2qJlTC2McoVK4aU7688+0no9iDE9A0HalxuTT5LpAp8AyCpAxmB/JdTwqD/vPRhlzgKdDUzBZBa/VsNbflbzVAjm5KXe5IETKMoVVgG+b5Cx3Y7dQMmOTkHwJQL+Whly8e57sAa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GFPz1DB5; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=sP5Qt6UG reason="signature verification failed"; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 262F6234DE;
	Mon, 18 Mar 2024 17:24:56 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-transfer-encoding;
	 s=sasl; bh=xwC5o7BEiXf9FRl2hIxykD7yqDyuhrPupfBToOJJlTg=; b=GFPz
	1DB5P8iYSvs8eQpZaspEU981FKnl5eFfb8OqT7owVB6XWFlQsBDto4LRQ5C0CUxb
	myQY7MmnDEI14kn5r233oNvotzAXQ/nqJmSBPs9jsSFrTbe8rm6RQZCwz17zStC9
	BuILDtODNhKNGo7tGXbzX9Q5/NM06AROkEAug4U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1E6CD234DD;
	Mon, 18 Mar 2024 17:24:56 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:mime-version:content-transfer-encoding;
 s=2016-12.pbsmtp; bh=xwC5o7BEiXf9FRl2hIxykD7yqDyuhrPupfBToOJJlTg=;
 b=sP5Qt6UGC/+x2zgsfN1c23WYC5W8Bwqnr+vrInzMhV35sxHqu0cMMPRbm11nMfW48XH5Mb4Hd7OyCZXsRIHAaFfURKNB4XKs3KsIDreIL72vP+NKAMzyw+dY0wKlmtnPOytUnAKxPctpTR1LfwSonpECK0thbxhcYFmpD2XxXhM=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EB0FA234D9;
	Mon, 18 Mar 2024 17:24:51 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id AD6A1BE2B9E;
	Mon, 18 Mar 2024 17:24:49 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>
Subject: [PATCH v2 0/13] Mediatek thermal sensor driver support for MT8186 and MT8188
Date: Mon, 18 Mar 2024 17:22:02 -0400
Message-ID: <20240318212428.3843952-1-nico@fluxnic.net>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 F501C348-E56D-11EE-A2FF-F515D2CDFF5E-78420484!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

This is a bunch of patches to support the MT8186 and MT8188 thermal
sensor configurations. Several changes are needed to cope with oddities
these SOCs implement.

All values (calibration data offsets, etc.) were lifted and adapted from
the vendor driver source code.

Version 1 can be found here:

 https://lore.kernel.org/all/20240111223020.3593558-1-nico@fluxnic.net/T/

Changes from v1:

 - renamed CPU cluster thermal zones in DT
 - fixed logic to cope with empty controller slots at the beginning
 - isolated bindings to their own patches
 - added MT8188 default thermal zones

diffstat:

 .../thermal/mediatek,lvts-thermal.yaml        |   6 +
 arch/arm64/boot/dts/mediatek/mt8186.dtsi      | 256 ++++++++++++
 drivers/thermal/mediatek/lvts_thermal.c       | 375 ++++++++++++++----
 .../thermal/mediatek,lvts-thermal.h           |  26 ++
 4 files changed, 585 insertions(+), 78 deletions(-)
 .../thermal/mediatek,lvts-thermal.yaml        |   6 +
 arch/arm64/boot/dts/mediatek/mt8186.dtsi      | 256 +++++++++++
 arch/arm64/boot/dts/mediatek/mt8188.dtsi      | 383 ++++++++++++++++
 drivers/thermal/mediatek/lvts_thermal.c       | 425 ++++++++++++++----
 .../thermal/mediatek,lvts-thermal.h           |  26 ++
 5 files changed, 997 insertions(+), 99 deletions(-)

