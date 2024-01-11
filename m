Return-Path: <linux-pm+bounces-2136-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 234B682B723
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jan 2024 23:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7D5DB24ED2
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jan 2024 22:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6C6EADE;
	Thu, 11 Jan 2024 22:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PEKK0G1D";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="1ogzqw/y"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5904FBEA
	for <linux-pm@vger.kernel.org>; Thu, 11 Jan 2024 22:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3891E20C47;
	Thu, 11 Jan 2024 17:30:37 -0500 (EST)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-transfer-encoding;
	 s=sasl; bh=sfEaKIIjCJW5ccyb2+CguAHPgJMfQcWP9YWXXViX1dM=; b=PEKK
	0G1DHo7qy7/10AEWnSxykxDqlcbM9BkIljCxdWPe5vRiPiWObIVFHmrkIV3+UlMa
	uWNvt5ABDNCeQXGXF4gvjaL4vcnnlY4VYvBRPIs+L+wIk3IKa+K68UKFhNj93zPe
	eDs7oDGy6ONdFu0JuKNJMWBBoKLzWxUL8vXsVpc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3116E20C46;
	Thu, 11 Jan 2024 17:30:37 -0500 (EST)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:mime-version:content-transfer-encoding;
 s=2016-12.pbsmtp; bh=sfEaKIIjCJW5ccyb2+CguAHPgJMfQcWP9YWXXViX1dM=;
 b=1ogzqw/yS1dHtKVszoAPnWlUxAB1W+MKFU+Kq/8LufzJ+eczpf0uJhho4t2Igqwyog/+47u71uEQxKNCLHVyqgPjCl3kgRE9D1C094bRYXbQvWk/wYcSSRa+7357zRWEe3qmZLor1EqxY67co8OcxWCgIWQMws0OU4EYhGsWAQw=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C4FC920C44;
	Thu, 11 Jan 2024 17:30:32 -0500 (EST)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 47619AD5A5F;
	Thu, 11 Jan 2024 17:30:30 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>
Subject: [PATCH 0/9] Mediatek thermal sensor driver support for MT8186 and MT8188
Date: Thu, 11 Jan 2024 17:29:57 -0500
Message-ID: <20240111223020.3593558-1-nico@fluxnic.net>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 0841536E-B0D1-11EE-B6FD-F515D2CDFF5E-78420484!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

This is a bunch of patches to support the MT8186 and MT8188 thermal
sensor configurations. Several changes are needed to cope with oddities
these SOCs implement.

All values (calibration data offsets, etc.) were lifted and adapted from
the vendor driver source code.

Feedback appreciated.

diffstat:

 .../thermal/mediatek,lvts-thermal.yaml        |   6 +
 arch/arm64/boot/dts/mediatek/mt8186.dtsi      | 256 ++++++++++++
 drivers/thermal/mediatek/lvts_thermal.c       | 375 ++++++++++++++----
 .../thermal/mediatek,lvts-thermal.h           |  26 ++
 4 files changed, 585 insertions(+), 78 deletions(-)


