Return-Path: <linux-pm+bounces-29436-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4760EAE68CA
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 16:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65AAA3AB097
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 14:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BC62D131D;
	Tue, 24 Jun 2025 14:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b="Y9Db3CJu"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E271F4607;
	Tue, 24 Jun 2025 14:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775099; cv=pass; b=IxjKXiOAYOTIHrPWvR5zhx/fIXnW8yGoivjfdzMgHa++Cv4ndBzrtNtnGHxo/UAyF+KFyVfZI07vNh0vJ9iPzostisKYlJkn4kZvx61eTBfI3yHINUNin9WGIw1PlpI5R6xxvp/owsPHcpP/s+2LpsGKOLxd/kxxUaYpWUb37RQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775099; c=relaxed/simple;
	bh=RrCfd4LRI0YthoKkMgXgWQDEDfg201AKOzW91yg3140=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QEN7wuRUcQzO//cTlhfhySubGSjrR5g7pSurGsFnST1zHNPjvr7IOacsupqhuBoebp39yv6Ci5riXZXMZ4RcoWsomzVxQv1GfxWd8ZXgaYJ7afiLTVPdvBw/wWD8jmzeKIWpv8FRL79V6TAkAxND67GTGXXfWFMdwQJ1khwMQhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b=Y9Db3CJu; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750775065; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FtqdH5fHsxD5tdO7RpQju9z7Kg83NOATY3cl0059rNyGDnnP3b9v5JTOlHY6/urmd5nUxZXc5cMU39UUrlA0hWZXJpWRMyKMEIiiJydahC6TEBGh01wTwYzKfZc9tM47Yv7ZorSRTjazwYMRLA06vjhSiZ11hNJyrRlsxIsIBNE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750775065; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RrCfd4LRI0YthoKkMgXgWQDEDfg201AKOzW91yg3140=; 
	b=ACM7SGKNrUHcbiaQDC0GYK/KK410dR4iCIUK8yPanKSUsXcJp94qDBrO+V9ftpLE50I7K1WyacmNirQxm7/ubHcs85iZMTb/f815+arXp/x/bnTPg2TATcQTUADIyJjJD6TtmoNrnBM8zrI6ey6j0Z8kS8BmBfee6gT2iW1uRVw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nfraprado@collabora.com;
	dmarc=pass header.from=<nfraprado@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750775065;
	s=zohomail; d=collabora.com; i=nfraprado@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=RrCfd4LRI0YthoKkMgXgWQDEDfg201AKOzW91yg3140=;
	b=Y9Db3CJu+WCNT9IPnm9GUXLw/oPeRGGIdJ9OZByccR8anQcerUNem9jDBQpmBSh3
	fsEYbTHqEY6/DS4vW0m35Mv3iNeztEuw6kqgWK1dg/nKqVabW6tRDbfUm3XKQIHqKof
	3/O+sJ5oh376h1WzFmpK2W7xZXuOhXJkH5D7VTzw=
Received: by mx.zohomail.com with SMTPS id 1750775063297142.35232576576414;
	Tue, 24 Jun 2025 07:24:23 -0700 (PDT)
Message-ID: <2762e08674df39b79dc169ef3791eaeeaff17d17.camel@collabora.com>
Subject: Re: [PATCH v1 00/13] pmdomain: Partial refactor, add MT8196 support
From: =?ISO-8859-1?Q?N=EDcolas?= "F. R. A. Prado" <nfraprado@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	linux-mediatek@lists.infradead.org
Cc: robh@kernel.org, conor+dt@kernel.org, mbrugger@suse.com, 
 y.oudjana@protonmail.com, linux-pm@vger.kernel.org, ulf.hansson@linaro.org,
  linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 mandyjh.liu@mediatek.com, lihongbo22@huawei.com, wenst@chromium.org, 
 matthias.bgg@gmail.com, krzk+dt@kernel.org, kernel@collabora.com, 
 linux-arm-kernel@lists.infradead.org
Date: Tue, 24 Jun 2025 10:24:21 -0400
In-Reply-To: <20250623120154.109429-1-angelogioacchino.delregno@collabora.com>
References: 
	<20250623120154.109429-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

On Mon, 2025-06-23 at 14:01 +0200, AngeloGioacchino Del Regno wrote:
> This series refactors the bus protection regmaps retrieval to avoid
> searching in all power domain devicetree subnodes for vendor
> properties
> to get syscons for different busses, and adds a new property which is
> located in the power controller root node containing handles to the
> same.
>=20
> Retrocompatibility is retained and was tested on multiple SoCs in the
> Collabora lab - specifically, on Genio 350/510/700/1200, and manually
> on MT6795 Helio (Xperia M5 Smartphone), MT8186, MT8192 and MT8195
> Chromebooks.
>=20
> This was tested *three times*:
> =C2=A0- Before the per-SoC conversion in drivers/pmdomain/mediatek
> =C2=A0- With per-SoC conversion code but with *legacy* devicetree
> =C2=A0- With per-SoC conversion code and with *new* devicetree conversion
>=20
> All of those tests were successful on all of the aforementioned SoCs.
>=20
> This also adds support for:
> =C2=A0- Modem power domain for both old and new MediaTek SoCs, useful for
> =C2=A0=C2=A0 bringing up the GSM/3G/4G/5G modem for both laptop and smart=
phone
> use
> =C2=A0- RTFF MCU HW, as found in MT8196 Chromebooks and MT6991 Dimensity
> 9400
> =C2=A0- Hardware Voter (MT8196/MT6991), allowing ATF, remote processors
> and
> =C2=A0=C2=A0 the AP (Linux) to manage the same power domains through a vo=
ter
> MCU,
> =C2=A0=C2=A0 avoiding power racing
> =C2=A0- Directly controlled power domains for MT8196
> =C2=A0- Voted power domains for MT8196
> =C2=A0- Multimedia (voted) power domains for MT8196.
>=20
> Note that all of the power domains for MT8196 should also work on
> MT6991
> but since I have no Dimensity 9400 boards, even though I'm 99.5% sure
> that
> it will simply work as those are the same, I avoided to add
> compatibles
> for 6991 as it's impossible for me to test.
>=20
> AngeloGioacchino Del Regno (13):
> =C2=A0 dt-bindings: power: mediatek: Document mediatek,bus-protection
> =C2=A0 pmdomain: mediatek: Refactor bus protection regmaps retrieval
> =C2=A0 pmdomain: mediatek: Handle SoCs with inverted SRAM power-down bits
> =C2=A0 pmdomain: mediatek: Move ctl sequences out of power_on/off
> functions
> =C2=A0 pmdomain: mediatek: Add support for modem power sequences
> =C2=A0 pmdomain: mediatek: Add support for RTFF Hardware in MT8196/MT6991
> =C2=A0 pmdomain: mediatek: Add support for Hardware Voter power domains
> =C2=A0 pmdomain: mediatek: Add support for secure HWCCF infra power on
> =C2=A0 pmdomain: mediatek: Convert all SoCs to new style regmap retrieval
> =C2=A0 arm64: dts: mediatek: Convert all SoCs to use mediatek,bus-
> protection
> =C2=A0 dt-bindings: power: Add support for MT8196 power controllers
> =C2=A0 pmdomain: mediatek: Add support for MT8196 SCPSYS power domains
> =C2=A0 pmdomain: mediatek: Add support for MT8196 HFRPSYS power domains

For the entire series,

Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>

(as I've reviewed this internally before submission)

--=20
Thanks,

N=C3=ADcolas

