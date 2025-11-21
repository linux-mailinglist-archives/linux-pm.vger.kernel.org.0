Return-Path: <linux-pm+bounces-38367-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB4CC791E1
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 14:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1E381353000
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 13:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA84332904;
	Fri, 21 Nov 2025 13:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="AKTab14n"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7028133508F;
	Fri, 21 Nov 2025 13:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763730165; cv=none; b=IiZQ0Xe/optsGCuQoNC/Y5CNE/IXz8Cal0U8VYMFSiDQyAOzm8GAepH6PcUANePX6/u9qvTtA7Q0wAiFxzjdXGAr9JGbqAiAWQ5GDoKR8U11GKiqc0V6WzNlz9HLPBsvhaHAG/F4xv4oRqqWsFtnbu0tSOKXDLQr3VaNmMj7ixI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763730165; c=relaxed/simple;
	bh=BJKh4phwJDlLNUyXOAuI9qLp7FEWCx2chfbFZ1pXVC8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=CTmGP5A/pEM4d88PgwmZJ+IOtWKGKtBPRt4eFjsesTLAHicc6ooewwb1sBlSVtAb/Xo8oyyl4LOak5ZnGuq4ovYTjTSK7OX3mkWff7LigHeK+/2bqc8Ny0EF5SS+pwjyyAHo6/KYss64Js+yqiBvMlkvZy8/IzOQFspMu8fh8mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=AKTab14n; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1763730149; x=1764334949; i=frank-w@public-files.de;
	bh=BJKh4phwJDlLNUyXOAuI9qLp7FEWCx2chfbFZ1pXVC8=;
	h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AKTab14nS6dJcY2MrZjBYFyzqd327qVLv0eXboND1lGTw6UR2Tl3xUi8s53wBco6
	 9r3dTjutKRYlN70tDZpDED5Xe79HaVLZOhfzpN+eeN178RW/WO/Mtp86SKlw19y99
	 PS8GeaudaAAe519lu6i5MKqQ7isEgm661D1w7eVW5Zq/vcaD5LHl/JOYZ14NZoM58
	 9zMOSPb1uoRpIU8IB6InMxj6Dfpon6HOSpEwUzWYdxciDzHwIzfZaRCsf634UCoCQ
	 LdyFPrVa2VfBoIq/7Z/NqRcXKnonNJcCl4Z1vhR+Kv2brsvMTHGfcqnFOWHyg2hio
	 7iPpN0iac1ubZOpsbg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([194.15.87.255]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MGQnP-1vLbQm2U3R-00Bi4o; Fri, 21 Nov 2025 14:02:29 +0100
Date: Fri, 21 Nov 2025 14:02:26 +0100
From: Frank Wunderlich <frank-w@public-files.de>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Laura Nao <laura.nao@collabora.com>, srini@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, rafael@kernel.org,
 daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 matthias.bgg@gmail.com
CC: nfraprado@collabora.com, arnd@arndb.de, colin.i.king@gmail.com,
 u.kleine-koenig@baylibre.com, andrew-ct.chen@mediatek.com,
 lala.lin@mediatek.com, bchihi@baylibre.com, wenst@chromium.org,
 fshao@chromium.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_4/9=5D_therma?=
 =?US-ASCII?Q?l=3A_mediatek=3A_lvts=3A_Add_pl?=
 =?US-ASCII?Q?atform_ops_to_support_alternative_conversion_logic?=
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <84571de3-27c4-4448-a3fc-b937d175de29@collabora.com>
References: <20251121-mt8196-lvts-v4-v4-0-357f955a3176@collabora.com> <20251121-mt8196-lvts-v4-v4-4-357f955a3176@collabora.com> <84571de3-27c4-4448-a3fc-b937d175de29@collabora.com>
Message-ID: <19D052E6-7E81-455B-AB31-C805AD65F96A@public-files.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RYiLAjizWkiNBNsTmLW9L4nsAeCaJJc+KyEx/1v1wMAeX6IORSP
 mHcrEp7TqOrgEMHq6YNKPYd8yrOswOWbKkgk5564SX73mkS3M5m8Jea8grnYlnbM1mRAEdB
 xbkOxyU2VvdnfPOEFxU/QXU/Inxvcv+pFQd1oFUYgqzKeCBH8UieR7PTz0XSLjsa7bSxN2q
 Eq0Oyd13oFgrvTWNUxw/g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4msFM5iZKaA=;4FkhWXXU9iKaL0ollf9nqlEnMD6
 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

Am 21=2E November 2025 14:00:29 MEZ schrieb AngeloGioacchino Del Regno <ang=
elogioacchino=2Edelregno@collabora=2Ecom>:
>Il 21/11/25 12:16, Laura Nao ha scritto:
>> Introduce lvts_platform_ops struct to support SoC-specific versions of
>> lvts_raw_to_temp() and lvts_temp_to_raw() conversion functions=2E
>>=20
>> This is in preparation for supporting SoCs like MT8196/MT6991, which
>> require a different lvts_temp_to_raw() implementation=2E
>>=20
>> Signed-off-by: Laura Nao <laura=2Enao@collabora=2Ecom>
>
>Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino=2Edelregno@coll=
abora=2Ecom>
>
>

Should this patch not have same prefix like the others?


regards Frank

