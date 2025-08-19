Return-Path: <linux-pm+bounces-32648-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D169CB2C6C5
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 16:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02CD8A06127
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 14:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E41C22D4C3;
	Tue, 19 Aug 2025 14:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="XVIqOrWx"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED2F1FBEA6;
	Tue, 19 Aug 2025 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755612818; cv=none; b=PHAh024V7HNU6DGQ9YocdrEoe6TdTKhhWCjxx/3WdkPiK093W8JSaEtrKNbLDXd2xUd9xG5J/GkbvMa6BAQaCqyEDpynzKKzW54ShYTrwlLk64DU55tMkTt9eoTAaHIlOTw+foc8V37J/FLxd8Mp9NGLmXM+lbZxkGMmswExtSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755612818; c=relaxed/simple;
	bh=r/jjDVBpMYe6yCMuNsQecOc4not0AcCVqBMxMD+67+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kR+RdO9oay9f7eCw0ZvQnaIclETu8MgLGGatji7jKtlg5qezLMkxw5278pTjgSwXqZniRi9a4ZY1IuDeZwVUl7aacyeRR0dHcG38jsUTW4Lrkhv5W/fE4hGPnBw1E1MWc7a/TIagfzIH53ldlKPjDvx4vv2zSB3eodeMcDimHHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=XVIqOrWx; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=VOR0hONBCgnAOtPlpEiq+Hxh37W5wGpYCr6vX3T4P00=; b=XVIqOrWxqTmSb28RvJYOVuGYmg
	67/e+ta6Ry26Qu1pDepLc0M0XbcGJJbN04Iz+ck5hYvFsyztw8GtEmkuSq5UvFdAL4SY0ezWIRFCB
	yQEWGRKzHuUYSiFYNjMK0ntHgNAuoZl4qE2fdNU04GgaHBNdcdPwuMgNZ8B615SDFhNRY6738P9ip
	KjO80Q63+tqhS3azRamJg69vB+03we7mXlRmAYczSXF+6oo00e4/FtEd5HTGyfEaTopJV0/hwvT5c
	bQ4I8zYacojs5B1rnBfUifGfSk3Ty7fc6xRFvpk8js/5SN7eIgLzZINHuHIe/4Nufu2VbXIil5yTm
	dPw5uWkw==;
Received: from i53875a31.versanet.de ([83.135.90.49] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uoN5Z-0002JI-VN; Tue, 19 Aug 2025 16:13:26 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Robin Murphy <robin.murphy@arm.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH] thermal: rockchip: shut up GRF warning
Date: Tue, 19 Aug 2025 16:13:25 +0200
Message-ID: <11865312.F0gNSz5aLb@diego>
In-Reply-To: <ciuhfx4u6xs2g43hn7nzjfmhaakfip6ndcpftuvg3kgzf52zkt@3vyvcjflmtqm>
References:
 <20250818-thermal-rockchip-grf-warning-v1-1-134152c97097@kernel.org>
 <2c7301cd-9c86-47fd-8b79-05f3e1a89e47@arm.com>
 <ciuhfx4u6xs2g43hn7nzjfmhaakfip6ndcpftuvg3kgzf52zkt@3vyvcjflmtqm>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 19. August 2025, 15:56:42 Mitteleurop=C3=A4ische Sommerzeit sc=
hrieb Sebastian Reichel:
> Hello Robin,
>=20
> On Tue, Aug 19, 2025 at 01:42:42PM +0100, Robin Murphy wrote:
> > > +	if (thermal->chip->grf_mode !=3D GRF_NONE) {
> > > +		thermal->grf =3D syscon_regmap_lookup_by_phandle(np, "rockchip,grf=
");
> > > +		if (IS_ERR(thermal->grf)) {
> > > +			ret =3D PTR_ERR(thermal->grf);
> > > +			if (thermal->chip->grf_mode =3D=3D GRF_OPTIONAL)
> > > +				dev_warn(dev, "Missing rockchip,grf property\n");
> > > +			else
> > > +				return dev_err_probe(dev, ret, "Missing rockchip,grf property\n"=
);
> > > +		}
> > > +	}
> >=20
> > Nit: Does the lookup itself need to be made conditional? I think I'd
> > also agree that the "optional" mode seems suspect, so potentially it
> > could be a whole lot simpler, e.g.:
> >=20
> > 	thermal->grf =3D syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
> > 	if (IS_ERR(thermal->grf) && thermal->chip->grf_required)
> > 		return dev_err_probe(dev, PTR_ERR(thermal->grf),
> > 				     "Missing rockchip,grf property\n");
>=20
> I came up with the enum, because I think most platforms having
> "optional" GRF support actually require it, so I want to keep the
> warning. At the same time I don't want to mark them as GRF required
> at this point, since that is potentially a DT ABI break. It really
> needs to be checked per platform in the TRM and/or by testing on
> real HW. With this patch we can easily handle this platform by
> platform by moving them from GRF_OPTIONAL to GRF_MANDATORY without
> affecting the unchecked platforms. Also switching a platform from
> optional to required needs to be reflected in the DT binding. So
> this involves a lot of work. I think it makes sense to carry the
> slightly complex check in the driver's probe routine for now.

I did go digging now ... there are 3 variants marked as "optional":

  rk3366_tsadc_data ->  rockchip,rk3366-tsadc
	never added any DTS

  rk3399_tsadc_data ->  rockchip,rk3399-tsadc
	commit 95c27ba7bd92 ("arm64: dts: rockchip: add thermal nodes for rk3399 S=
oCs")
	added the tsdadc node together with its rockchip,grf reference

   rk3568_tsadc_data   rockchip,rk3568-tsadc
	commit 1330875dc2a3 ("arm64: dts: rockchip: add rk3568 tsadc nodes")
	added the tsdadc node together with its rockchip,grf reference

So none of the platforms had ever a phase where we had the tsadc without
its grf-reference. So making the GRF mandatory for those, will not create
breakage. We could even tighten the binding to make that explicit.


Heiko



