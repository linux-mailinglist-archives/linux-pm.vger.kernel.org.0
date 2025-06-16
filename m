Return-Path: <linux-pm+bounces-28784-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 400CEADA8BD
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 09:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25AFA7A6C6D
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 07:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90805191F7E;
	Mon, 16 Jun 2025 07:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="s2UVLpUK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B1417BCE;
	Mon, 16 Jun 2025 07:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750057317; cv=none; b=VpS7Klvb10yA8oNeHoFyIC4efCcPRZFY66Tv3qrrbb9YKcxECy6zHfipsCoGAPJ7KRPpf4iqtNQsk1vkLtwFx1IK6E6uHhrdAf1xGRYHpG1jSsemt1G5qhxZ9KfTLeXC5TUgZOTXIoDOk+Mxbbc2IKE6GD24WFC/cuwndUZmKko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750057317; c=relaxed/simple;
	bh=InuKAAGjHu/C7GD/p6y1dIS+oWspdPvUrz6/e8cjyKM=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=W5OPfBhXIhvvKRoFubdRIpBJ7DaCtE4NRx1tD1I9BldcgUifMC/wCgOjB9nYyUaAptQV2JTGdow049wyUaCoWBe6NAuYkf1Evvuz8AKvSk+/OdqYhITAYHulsmLft/I7WqrIg2IHDvsavQMWUD4bmgFtLPHDjr8Lut7kjOQdTUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=s2UVLpUK; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1750057280; x=1750662080; i=frank-w@public-files.de;
	bh=InuKAAGjHu/C7GD/p6y1dIS+oWspdPvUrz6/e8cjyKM=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:In-Reply-To:References:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=s2UVLpUKJZyqePN0VoRDHjcH1kF2nvZKAqTZkzdJ3S1G1FhxLe/WJ7aonJgYwff1
	 2O7pslpgw6AoB9xR1d+Lp2pQuxrpjw4e7vRRvzCQCJE9Le8pURc9y1BzdaDseApBW
	 vGKi3V4o+j/N+t8sgHoYJlOfYH7EYq5jZ1g3AEaGpqqlIIfpajDNXPPYcaa6QNwtz
	 HS5/BrZ1I/KpeER6QopNP6/0JUw9kUSZ6tF+9OJjWZ+JZ70abf1sefc9pPUhTNMWT
	 Bs6vg9RrfIqyhdldZ0+XsproGILWz+1DSAmbEKySlpL5WDQzzQPV9G6OQp2f/k9ZN
	 VbxjqO4BMB+mS72rWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [100.67.37.206] ([100.67.37.206]) by
 trinity-msg-rest-gmx-gmx-live-b647dc579-tr2th (via HTTP); Mon, 16 Jun 2025
 07:01:20 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-e9eaf8fd-42f1-46d5-b1df-3bfefe02b2fe-1750057280436@trinity-msg-rest-gmx-gmx-live-b647dc579-tr2th>
From: Frank Wunderlich <frank-w@public-files.de>
To: mason-cw.chang@mediatek.com, rafael@kernel.org,
 daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 angelogioacchino.delregno@collabora.com, nfraprado@collabora.com,
 jpanis@baylibre.com, npitre@baylibre.com, colin.i.king@gmail.com,
 u.kleine-koenig@baylibre.com, wenst@chromium.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, daniel@makrotopia.org,
 steven.liu@mediatek.com, sam.shih@mediatek.com
Cc: mason-cw.chang@mediatek.com
Subject: Aw: [PATCH 0/3] thermal/drivers/mediatek/lvts_thermal: add mt7988
 lvts commands
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Jun 2025 07:01:20 +0000
In-Reply-To: <20250526102659.30225-1-mason-cw.chang@mediatek.com>
References: <20250526102659.30225-1-mason-cw.chang@mediatek.com>
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:E53Jv9HXOWkrKn1ZmdCThVsKfrzyzuGZargrqRZrhq4Jf1N6adv3cJ2SO3q/CtWy8d1d/
 QDM9voUlQrOto5dwjYfZWRz4yPGaMpj5j0PIhveWyIfGmukm4lJdw+qRF8g5xZigd97/80PljnoQ
 H8ZrO1S5pA+KCV21QjyAF1d3rOVeZzzMO0CfDykQZKy1Pztvw0C+hv8rbqBrIxsegEJF5iyfSKP0
 r4WZa67IPl1lKRtoLF3B1SdTESGO/2b3C5xJh94nV4fOA2mNfxuFfOgbRims31qA5sc6MRAMUNFf
 lw41SniqEtVepmdTyGLN3TgvPEvq317HVyJqOzvxi5npkIetYQ1kamys4S/E8OxFUA=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PxlaLSE8vxo=;EPEHr1o7va+Z4JcCx7lU/6b8+Cc
 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
 LFSEZB56NrtCrz7ufFA==
Content-Transfer-Encoding: quoted-printable


> Gesendet: Montag, 26. Mai 2025 um 12:26
> Von: "Mason Chang" <mason-cw.chang@mediatek.com>
> Betreff: [PATCH 0/3] thermal/drivers/mediatek/lvts_thermal: add mt7988 l=
vts commands
>
> Add the LVTS commands for Mediatek Filogic 880/MT7988.
>=20
> This series fixes severely abnormal and inaccurate LVTS temperature
> readings when using the default commands.
>=20
> Signed-off-by: Mason Chang <mason-cw.chang@mediatek.com>

Hi

just a friedly reminder for maintainers, is the patch series ok or does it=
 need any changes?

regards Frank

