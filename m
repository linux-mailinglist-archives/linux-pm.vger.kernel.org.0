Return-Path: <linux-pm+bounces-32809-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEC0B2F884
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 14:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA1AC1CE216B
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 12:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1181831DD9C;
	Thu, 21 Aug 2025 12:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="txzMEN3F"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449A730F7E1;
	Thu, 21 Aug 2025 12:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780123; cv=none; b=moJW3ML+Fj+uLEhs2OGVEghbC5NOjeo1LD5zuCbuaiW8leoWj6as7JiRcV8yUkvWbSchWR0MEG3D99Yf/7C9widtAjjDlkOtp348t0yt8cH/aHdo8m42MaBWEmTz99s21pewF9oYYp1FDsR+eI9m/bgeOVoxgS0XIraweNgGR2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780123; c=relaxed/simple;
	bh=CU4cTKvaSQ23yYf+H4pKFowY3NHmF+KaBQQhNfP4Zvg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TD4/1pvkTAzmwcUBaHowHpsXby8MAsHY6ag1xJydkvAsP2kIIe2oWxUwtf03PgJwKr0gLtWE3zJiGZjGs3eOtzhUsi8Z3ReAXcihLePw8gWLvdOh4w9xuTmRzb7h6KWWWw65KLWciMYoQ20KHRPxMd08PrI0NdqNbG2Tqlxy/JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=txzMEN3F; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1755780117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2qBXp2L6ghuaOFTwpw0VcF+lJn82b0iwLgdjpHusKRY=;
	b=txzMEN3FKtz1olFZUVrErfLHlhVNtHZp9Kd/i2sWnJtnGBam8Rdp3Oaogr0G23n5z4Eehf
	nGkZ9OB8Xo587f3LLNgNZFk6nWKx26GGOODXnDG6QmhwykAptAb4nKdWsxH5mY0lzf762R
	v5ZuMJSkoNsbXkwH1yFunobZ3E4zLw9ecdcIjUIrrUWy3yPU3o8Radlqb5OGtBQjUE46wM
	IzknYv9LHjnyR4g9tqA83ILR4aotfauXFfh970xI8ortZznliPacH7OK51v7hjHYF0jUKk
	eCuIcurdewmlFv0qdyBGbByDQeQawkgA59EaxihTeqGqU8F1X+bMOwNtY3h9UA==
Content-Type: multipart/signed;
 boundary=3b571f17c3ddaedec092828a238ae966d2c316d9a762f9d2cf5b0d604e2a;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 21 Aug 2025 14:41:34 +0200
Message-Id: <DC843K2CRBHH.1IUX1SB576TFZ@cknow.org>
Cc: "Robin Murphy" <robin.murphy@arm.com>, <linux-pm@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <kernel@collabora.com>
Subject: Re: [PATCH v2 2/3] thermal: rockchip: shut up GRF warning
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, "Daniel Lezcano" <daniel.lezcano@linaro.org>,
 "Zhang Rui" <rui.zhang@intel.com>, "Lukasz Luba" <lukasz.luba@arm.com>,
 "Heiko Stuebner" <heiko@sntech.de>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>
References: <20250820-thermal-rockchip-grf-warning-v2-0-c7e2d35017b8@kernel.org> <20250820-thermal-rockchip-grf-warning-v2-2-c7e2d35017b8@kernel.org>
In-Reply-To: <20250820-thermal-rockchip-grf-warning-v2-2-c7e2d35017b8@kernel.org>
X-Migadu-Flow: FLOW_OUT

--3b571f17c3ddaedec092828a238ae966d2c316d9a762f9d2cf5b0d604e2a
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Aug 20, 2025 at 7:40 PM CEST, Sebastian Reichel wrote:
> Most of the recent Rockchip devices do not have a GRF associated
> with the tsadc IP. Let's avoid printing a warning on those devices.

Retested with v2 of this patch (set) and there were still no regressions
on Rock64 (rk3328), RockPro64 (rk3399) and Quartz64-B (rk3566).
I skipped testing my NanoPi R5S (rk3568) this time.

And on Rock 5B (rk3588) I (still) no longer see this warning:

  rockchip-thermal fec00000.tsadc: Missing rockchip,grf property

So also with v2:

Tested-by: Diederik de Haas <didi.debian@cknow.org>

Cheers,
  Diederik

> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/thermal/rockchip_thermal.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)

--3b571f17c3ddaedec092828a238ae966d2c316d9a762f9d2cf5b0d604e2a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaKcUAwAKCRDXblvOeH7b
bkU/AQCEUoGxVyVSNGRj6qG6NCl2nThKkgrDRtbsVWcAv4iiLQEA5qiGnnUdk7ma
IuxRHRF24a7aweQEHZRYm58eco2GUQQ=
=xzaV
-----END PGP SIGNATURE-----

--3b571f17c3ddaedec092828a238ae966d2c316d9a762f9d2cf5b0d604e2a--

