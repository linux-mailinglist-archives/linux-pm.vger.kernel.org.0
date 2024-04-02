Return-Path: <linux-pm+bounces-5771-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E38C8949EC
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 05:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEC6C1C230F4
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 03:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8CB168B9;
	Tue,  2 Apr 2024 03:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Yc05Gq9Q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="rGs9S7c5"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D442C9E;
	Tue,  2 Apr 2024 03:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712028472; cv=none; b=loerdRdpw+gPQC82Pl1sB0OY6veXdE5/S6fMYWLDtA1YPHguckMAzJyAChzYhKEeB7VknxXifc4skoWvAO3Tis51i+3DosvTVJE6QsLb3e0sV6Wv4e1FKd+mHG83v+xxtC8OJsSAeaORkgZA7jMbaSkgtzGpJzVhLCZo7l59b5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712028472; c=relaxed/simple;
	bh=Y6jvOzEouXNWKuWy3ccTjj476XMGHanXU+3TO3ClnKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=egbhL77VqsKhIh6q1e4MmU3NwfKtCm3cKzFQYydev814Po0VAoQulwHdjTwzQuURb1EDsLjK+FR7eV/CSfMfVVJ86lPNMNeMAM2vsQg8H7b1eJ3EMt4oi9m3/HblzC2mzQmZrqnIPmFtadt6t3fdbBpdDgyQ6DsutDPAsMwtQxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Yc05Gq9Q; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=rGs9S7c5 reason="signature verification failed"; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 929B325040;
	Mon,  1 Apr 2024 23:27:50 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-transfer-encoding;
	 s=sasl; bh=Y6jvOzEouXNWKuWy3ccTjj476XMGHanXU+3TO3ClnKg=; b=Yc05
	Gq9Q4s+S4T8ijXt4ByAH2vn0T9sWQinjDx0KDB9iZ4yaLIRz0Yr4mArCGoVdw4N5
	PqVrlHe5jv1igraG7vjHtF5P7Zf6d1Pw6VPGy1vKz8JxIKah24EpD/RTf0xoi7nM
	+8RVPPFT//es9w6lDVvHqctpGs685cgHzHgr+78=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8AD122503F;
	Mon,  1 Apr 2024 23:27:50 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:mime-version:content-transfer-encoding;
 s=2016-12.pbsmtp; bh=Y6jvOzEouXNWKuWy3ccTjj476XMGHanXU+3TO3ClnKg=;
 b=rGs9S7c5Q0bvvz5g4tDLqISdgaZ+uFHhu/hvls5t2MQJLlLELiUj5GWWqrZKtsW7ql3p3yOQ/MrXaBzUGuOG02YmH1LTTwPlTfdbrL8ZPv1tnh6QMIDroITGXF0JAc9FrxGAc8tqkf5xn53uNvT6nWSe84shCXRxkCivcTuK5+o=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8736E2503D;
	Mon,  1 Apr 2024 23:27:46 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 3F48BC1CEC6;
	Mon,  1 Apr 2024 23:27:44 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v3 00/15] Mediatek thermal sensor driver support for MT8186 and MT8188
Date: Mon,  1 Apr 2024 23:25:34 -0400
Message-ID: <20240402032729.2736685-1-nico@fluxnic.net>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 F974D08A-F0A0-11EE-A764-F515D2CDFF5E-78420484!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

This is a bunch of patches to support the MT8186 and MT8188 thermal
sensor configurations. Several changes are needed to cope with oddities
these SOCs implement.

All values (calibration data offsets, etc.) were lifted and adapted from
the vendor driver source code.

Changes from v2:

 - use meaningful name for binding index definitions
 - reuse LVTS_COEFF_*_MT7988 on MT8186 per reviewer request
 - do similarly for MT8188 that now reuses LVTS_COEFF_*_MT8195
 - use thermal zone names the svs driver wants
 - adjust some DT node names and iospace length
 - remove variable .hw_tshut_temp as it is constant across all SOCs

Version 2 can be found here:

 https://lore.kernel.org/all/20240318212428.3843952-1-nico@fluxnic.net/

Changes from v1:

 - renamed CPU cluster thermal zones in DT
 - fixed logic to cope with empty controller slots at the beginning
 - isolated bindings to their own patches
 - added MT8188 default thermal zones

Version 1 can be found here:

 https://lore.kernel.org/all/20240111223020.3593558-1-nico@fluxnic.net/T/

diffstat:

 .../thermal/mediatek,lvts-thermal.yaml        |   6 +
 arch/arm64/boot/dts/mediatek/mt8186.dtsi      | 256 +++++++++++
 arch/arm64/boot/dts/mediatek/mt8188.dtsi      | 383 ++++++++++++++++
 drivers/thermal/mediatek/lvts_thermal.c       | 434 +++++++++++++-----
 .../thermal/mediatek,lvts-thermal.h           |  26 ++
 5 files changed, 987 insertions(+), 118 deletions(-)

