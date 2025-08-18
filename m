Return-Path: <linux-pm+bounces-32586-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EF0B2B1DE
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 21:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A7036210C8
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 19:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5DB25DAFF;
	Mon, 18 Aug 2025 19:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="cUYjT4gb"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0ED259CA7;
	Mon, 18 Aug 2025 19:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755546472; cv=none; b=sn+pfAMCdOgWuyz/CwWwGB9RE3qAzdZ7AwkEvU9yUR4u4czLKCxE2cF4ALuf+Y3FtPQqkaoziZjhXlVY+CBC6yyiKYxoPG1sZqxsEgeSmUOQNHzLrjxNtLExmUw5/LqwN8cdJQEAMuRwCS42xktGuH/FP2BuAyGnLZTz3+4fPz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755546472; c=relaxed/simple;
	bh=902WPU4xQKWeQ0OCIkYgyMri7TjMAcWjbBE7PZsEiGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tTwpxsPCXvMptGRY5z4jQNejo832bXqg2v8OW/AbLEjxYTXZsMCsEi5TqNJy4AKkoOE4HLN9oOtaws2roPBSsfxUgLcsd2p3eDs87StQ+Iz86o1PFB20ixCI/4DC8e2oHf9vnAnXFC5Q5lktIBydN3vrDzQB9ZTqSk+Vo75uvDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=cUYjT4gb; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=SxySystUolElsZ8oKWT++LDXpxEDwIiYseF8Su16NVY=; b=cUYjT4gbI1gpOVIT6pOU121qvn
	b8fbNHhgBZLchyPkNK3cCqiRG83om9upg7EDR7oikdkFM4YHZyQR0hzvs3UtJZh0LJyAtb/qLhbwC
	hvgICRpdHczCYEB0xWfy60mkhOqd+AoK5FSy6YWf6132x9cwzR56KWZRqIMDaOhCk76CMIG1eZS4R
	QiUy0PTJ9MPLQl7O5Ii7n1gG2tTTTfnzQNLfnF1EPG175XaoJw2P5Hn8Mi7jtcWllX7lTQuDFIiGA
	hrfqqImWPmywOQgarHM0q4cKzo4jH3a7a3UrPThYDDKTPosGGx/zN0ynts1Vk8VcLy7OJVD/TlSe0
	3GcLbiMw==;
Received: from i53875ad4.versanet.de ([83.135.90.212] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uo5pU-0001Ei-Lz; Mon, 18 Aug 2025 21:47:40 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH] thermal: rockchip: shut up GRF warning
Date: Mon, 18 Aug 2025 21:47:39 +0200
Message-ID: <2890475.6YUMPnJmAY@diego>
In-Reply-To: <b6cqwtj73twqxstslbhuulkgsmpds2hdyfsn7yewllkbtj7jz3@2kk74kgtefvp>
References:
 <20250818-thermal-rockchip-grf-warning-v1-1-134152c97097@kernel.org>
 <8402789.eFmWaWnqpD@diego>
 <b6cqwtj73twqxstslbhuulkgsmpds2hdyfsn7yewllkbtj7jz3@2kk74kgtefvp>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Montag, 18. August 2025, 21:23:54 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Sebastian Reichel:
> On Mon, Aug 18, 2025 at 08:44:15PM +0200, Heiko St=C3=BCbner wrote:
> > Am Montag, 18. August 2025, 19:26:15 Mitteleurop=C3=A4ische Sommerzeit =
schrieb Sebastian Reichel:
> > > @@ -1621,12 +1656,16 @@ static int rockchip_configure_from_dt(struct =
device *dev,
> > >  		return -EINVAL;
> > >  	}
> > > =20
> > > -	/* The tsadc wont to handle the error in here since some SoCs didn't
> > > -	 * need this property.
> > > -	 */
> > > -	thermal->grf =3D syscon_regmap_lookup_by_phandle(np, "rockchip,grf"=
);
> > > -	if (IS_ERR(thermal->grf))
> > > -		dev_warn(dev, "Missing rockchip,grf property\n");
> > > +	if (thermal->chip->grf_mode !=3D GRF_NONE) {
> > > +		thermal->grf =3D syscon_regmap_lookup_by_phandle(np, "rockchip,grf=
");
> > > +		if (IS_ERR(thermal->grf)) {
> > > +			ret =3D PTR_ERR(thermal->grf);
> > > +			if (thermal->chip->grf_mode =3D=3D GRF_OPTIONAL)
> > > +				dev_warn(dev, "Missing rockchip,grf property\n");
> >=20
> > I guess it might make it easier for people seeing the log, if we could
> > insert an "optional" into that message for the optional tier.
>=20
> Sure, I can add an "optional". I'm not sure how "optional" they
> really are, though. Code like this looks quite fishy to me:
>=20
> if (grf)
>     regmap_write(grf, ..., RK3568_GRF_TSADC_TSEN);
>=20
> I marked these as optional, as the driver should probe without the
> GRF. But to me it looks like most platforms with optional GRF
> support should have been made mandatory in the first place.

okay ... then I take it back, and we should leave out the optional.

That way people may wonder and possibly verify their soc variant
or build setup.


Heiko



