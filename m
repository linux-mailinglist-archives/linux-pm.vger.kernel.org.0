Return-Path: <linux-pm+bounces-9958-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CBC916B41
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 16:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFBB11F289EB
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 14:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F7E16F29B;
	Tue, 25 Jun 2024 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5Rf+4Xw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A62216C840;
	Tue, 25 Jun 2024 14:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327324; cv=none; b=nkQDWQHxcqIq2Ydpi4R/IO8EgRJCN57M0tBxQ4I/bLkEy7fpzRqos8hXOhKb8raWWy8JCMEn4BjWruTRZHuNmFQXfuH7zTnB6SfyuIwg2pX6Wt/sjs1lX8ZFqAaMCi+MAv/4F46dHY+RXJji6CxB+Fow2UEEhHWyWBJbPtz0Xl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327324; c=relaxed/simple;
	bh=66tqkQVIjQ3KifxJzurd/IM9a92dtSlu7LD3ir/MsYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHelOPlrFe2kj8kyh5RloHTgr1+oWOH17tsstEtd19Mbb3lpxbH8KgYm71LImH2x0BI8UvXmbfd94aCJG70FnwFjv2OuUDNHRjyvDx7W0E3mt97H85CvG7/TAURjE4j/INOCexED3FRDG63hnjWV4uyw0HbfyZhRrYVImvB1uJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5Rf+4Xw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293CBC32786;
	Tue, 25 Jun 2024 14:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719327323;
	bh=66tqkQVIjQ3KifxJzurd/IM9a92dtSlu7LD3ir/MsYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c5Rf+4Xw8E6hHZ+Orx/3Jw0L6hsHClLa8LH5YCUFGwvRYqzR3vrI23ejTfOMTvnBw
	 DK0c40J/Aa98/W+ijABbMyIXE/q3nvCldvthZ6kG2O0+bbxNahvOUGwlWe1qTjTIb9
	 A6o6UW+fzfLf14WrYR6KmY1Je1wLej+bW/hws8/4Ayg9OL0QtVpQ4fLLGJAiWlnMy3
	 5BL2VHQKSrVx3A6qIwEjE8zJbLBHkNunqRwilT6a56uB85YXDpIjKygs+Lx7hCOcZ1
	 l3V/3MAq7BrDemnZfX+5gOvrFMU+dOTxZKFHX12641cjBDNFH/Eu6e1M9FzQfBAcoz
	 dqmOE6ljF9EJw==
Date: Tue, 25 Jun 2024 15:55:17 +0100
From: Mark Brown <broonie@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com, lgirdwood@gmail.com, keescook@chromium.org,
	gustavoars@kernel.org, henryc.chen@mediatek.com,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com,
	wenst@chromium.org, amergnat@baylibre.com, djakov@kernel.org
Subject: Re: [PATCH v6 0/7] MediaTek DVFSRC Bus Bandwidth and Regulator knobs
Message-ID: <8b34897a-416a-4ff4-82a8-c37849d706ec@sirena.org.uk>
References: <20240610085735.147134-1-angelogioacchino.delregno@collabora.com>
 <f7b4cd98-1acf-4f6b-a7e0-57419abadba1@collabora.com>
 <57cf8f9f-4320-4c55-a9f8-a4c1facabfe8@sirena.org.uk>
 <39ed7b8c-b19a-40de-9b30-a731ac83ad20@collabora.com>
 <2e8a9cf2-2bc0-45d8-b6c1-e3a9441d5641@sirena.org.uk>
 <f855f6ec-f0f7-467a-9823-d19706574408@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ybfvhfwy3rgiDyzm"
Content-Disposition: inline
In-Reply-To: <f855f6ec-f0f7-467a-9823-d19706574408@collabora.com>
X-Cookie: Results vary by individual.


--ybfvhfwy3rgiDyzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 25, 2024 at 04:51:56PM +0200, AngeloGioacchino Del Regno wrote:

> The interdependency is for soc/mediatek commits, which depend on:
>  - Interconnect commits (which Georgi picked already); and
>  - Regulator commits

So the regulator stuff works without the interconnect and vice versa, no
build deps or anything?

> And... you reviewed the patch in the previous merge window :-)

I simply don't provide tags for things I expect to go via my tree.

--ybfvhfwy3rgiDyzm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ62lQACgkQJNaLcl1U
h9AudAf/W50XJ088Y6eXx3Vma3D22WxaI/Uw4qotmwWBWYHpqgxdEOOCvgf2FFjK
yF1i60d2zIF+vBTMm3jXo0NMBUxW+8M+60MOsDvZS0POPxkdko2+MOt8NfJlPpnO
16wz8lIR+oc1YFphmh4o3bgjsxXwbzyjVskjs0bBOWGRNllftiKZMUgQdg/aCbQu
grhS1n1AEKA7Q13ahMWrwh39gkRn51t3KPmAdwhy9j70XCHgSaNALEj7vOYIVnPR
QTPQn8bldlUAjUEmXdcL5Hgz1T1aRCOQAM019+IqWGTv8NPTi94IrWojfBZ02swb
4thLhUOHqd8mP01SIQjYM20dQOaW3w==
=lhMt
-----END PGP SIGNATURE-----

--ybfvhfwy3rgiDyzm--

