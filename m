Return-Path: <linux-pm+bounces-30682-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6804B01C0E
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 14:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F5573ADDF8
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 12:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE28A27A127;
	Fri, 11 Jul 2025 12:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M24FBhjL"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26584A24
	for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2025 12:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752237106; cv=none; b=i2L4uiUe1qLY0h02AWesRPTr5RhZIIoRuoUrLCxwxN27tfXmPWwirVkmehSu0Ar0KdP4BvtCvpcBYOH+L1lWZRNMKs16T76V+mscTEBELm251V3abHGi0IcL6uQy+qct5kAKnQqipsuuOyHcwRzkOkgvf3tcBpeifBUS+DIVNdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752237106; c=relaxed/simple;
	bh=vOtJC2lOwcpYRMoM5XyFUe5Y2lcMQftZQj+oIy/Njcc=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:
	 In-Reply-To:References; b=P/IH7EWCHYVNl5lzuWRu/6xAn7xgJNGqS82Qd3v6tg66CJBaO1h2pRB0wNJw9HdCbbMxc28ln48kwaXqw7S/q3DWx+fDs3oiI7hFMfdWNFES9MtaKRE0qPrmshUY/z47z7iz6gZXvFCcHiK4ik0J0Eh6V1ZG5q6yBdVEQTQaamw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M24FBhjL; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752237092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jbLKuNOVurWKtK4oUnqVUqNVImgpQxoJDSpLuja+PYM=;
	b=M24FBhjLkVSWkRYyqjg/YQ4GGhqyackjFl259cMwBWczjuvJQrzu25iMs7BHqNB/MJKwuD
	YA12G3wwbCOSSh0EfiBkIrSQLYbpgMWmozVf6/p3Ot9yfj8lZu0QNDvO3RWOoV6zepSMCB
	uNN4PkSJGJoHf//JXrNkdy9a0Z8nHrQ=
Date: Fri, 11 Jul 2025 12:31:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Frank Wunderlich" <frank.wunderlich@linux.dev>
Message-ID: <6910cf379fafc80a921daf5b9321550eff37c1b1@linux.dev>
TLS-Required: No
Subject: Re: Aw: [PATCH 0/3] thermal/drivers/mediatek/lvts_thermal: add
 mt7988 lvts commands
To: "Mason Chang" <mason-cw.chang@mediatek.com>, rafael@kernel.org,
 daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
 "Nicolas Prado" <nfraprado@collabora.com>, jpanis@baylibre.com,
 npitre@baylibre.com, colin.i.king@gmail.com,
 u.kleine-koenig@baylibre.com, wenst@chromium.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 daniel@makrotopia.org, "Frank Wunderlich" <frank-w@public-files.de>,
 "Steven  Liu" <steven.liu@mediatek.com>, "Sam Shih"
 <Sam.Shih@mediatek.com>
In-Reply-To: <b014c34a560854e6dd6a6dd483b9443f42252b51.camel@mediatek.com>
References: <20250526102659.30225-1-mason-cw.chang@mediatek.com>
 <trinity-e9eaf8fd-42f1-46d5-b1df-3bfefe02b2fe-1750057280436@trinity-msg-rest-gmx-gmx-live-b647dc579-tr2th>
 <b014c34a560854e6dd6a6dd483b9443f42252b51.camel@mediatek.com>
X-Migadu-Flow: FLOW_OUT

Hi,

i finally found someone for testing this as it only affects ~2% the mt798=
8 users:

https://github.com/frank-w/BPI-Router-Images/issues/16#issuecomment-30619=
76373

so can you please review and add it to mainline?

regards Frank


Am 8. Juli 2025 um 13:56 schrieb "Mason Chang" <mason-cw.chang@mediatek.c=
om>:

>=20
>=20On Mon, 2025-06-16 at 07:01 +0000, Frank Wunderlich wrote:
>=20
>=20>=20
>=20> External email : Please do not click links or open attachments unti=
l
> >=20
>=20>  you have verified the sender or the content.
> >=20
>=20>=20=20
>=20>=20
>=20>=20=20
>=20>=20
>=20>  Gesendet: Montag, 26. Mai 2025 um 12:26
> >=20
>=20>  Von: "Mason Chang" <mason-cw.chang@mediatek.com>
> >=20
>=20>  Betreff: [PATCH 0/3] thermal/drivers/mediatek/lvts_thermal: add
> >=20
>=20>  mt7988 lvts commands
> >=20
>=20>=20=20
>=20>=20
>=20>  Add the LVTS commands for Mediatek Filogic 880/MT7988.
> >=20
>=20>=20=20
>=20>=20
>=20>  This series fixes severely abnormal and inaccurate LVTS temperatur=
e
> >=20
>=20>  readings when using the default commands.
> >=20
>=20>=20=20
>=20>=20
>=20>  Signed-off-by: Mason Chang <mason-cw.chang@mediatek.com>
> >=20
>=20>=20=20
>=20>=20
>=20>  Hi
> >=20
>=20>=20=20
>=20>=20
>=20>  just a friedly reminder for maintainers, is the patch series ok or
> >=20
>=20>  does it need any changes?
> >=20
>=20>=20=20
>=20>=20
>=20>  regards Frank
> >=20
>=20
> Hi all,
>=20
>=20I submitted the patch a while ago, but haven't received any response
>=20
>=20from the maintainer yet. I would really appreciate it if any maintain=
er
>=20
>=20could take a look or provide some comments.
>=20
>=20If there is a more appropriate maintainer or reviewer for this patch,
>=20
>=20please kindly let me know or help forward it.
>=20
>=20Thank you very much for your time and help!
>=20
>=20Sincerely,
>=20
>=20Mason
>

