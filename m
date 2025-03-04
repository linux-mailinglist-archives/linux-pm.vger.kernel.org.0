Return-Path: <linux-pm+bounces-23432-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A3DA4E6F3
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 17:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3005418838DC
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 16:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F638296D49;
	Tue,  4 Mar 2025 16:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXSPILMi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E42F281523;
	Tue,  4 Mar 2025 16:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105367; cv=none; b=BAVXYwHNL7ZHoKKyc5dFIsGVS4knviYUZd1sl6ba+SLYVXvgPZIBGdBbVMaXV12oGuBAklxDvqKHm3HF/gNZ4C7MAZHMng3gwzZ4qNTSEDwmrHUNt94v2F0YV6jf9mmUhtmCWu48ppZXn0xWk66kvdo9CvBWQd+6TBvJ0KQg+Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105367; c=relaxed/simple;
	bh=EV+N2rbqXYmmMk/YyAnKxUxPZrcUg+1PniBKpcv0qKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNFkGTQAeVKq/K3BHzqMrrLfOgvwUCBnw8RuEU8jbHtnKv5qJlb7T3wuq90TYGHkUNYlMuvXLNUQ4V2Vy2wjKnPsoJUDsv3Q1/7uObtqtI6s1TS3WufTym8dqSGg3S2nvcE7O6RNW0u2WXp04tWMM7P8KfDqsJTMnTX9DgNSO+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXSPILMi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A2AC4CEE5;
	Tue,  4 Mar 2025 16:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741105366;
	bh=EV+N2rbqXYmmMk/YyAnKxUxPZrcUg+1PniBKpcv0qKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iXSPILMiDbG1+OfL9Hg/8K3LiBibffVc9koiFnM2f4SjX85WZqd/35e3hGmJFVart
	 EZIXyoz0VDyoF/0hTkc0OrscHyyAXkZ9jow3TbRh25hxg7YJXDa19/gDb1Nqz+J39Y
	 wr033y/xY+yvcEKNMbjabpzp6KWPy1+I41dskudD8nPLC/OTlAuW+gKf3tFdZbZfpl
	 30wIoXqtQvy6jYHh8Z+1ytEScE0DHg1+05nRc64K8sHDeZh9BxZoty17lTAw0VwKhg
	 H4jjg4Q0AlTNPvhFbKe79qzLoe8wqXzZVZAkQcqXHXuKNjyDCogQ+/06uEqKQryvZB
	 MP8nJPK4HxjXA==
Date: Tue, 4 Mar 2025 16:22:39 +0000
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, kernel@collabora.com,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
	Andrew Perepech <andrew.perepech@mediatek.com>
Subject: Re: [PATCH v3 03/20] mfd: mt6397-core: Add mfd_cell for mt6359-accdet
Message-ID: <a8fbb536-a246-4650-8085-d576652b0301@sirena.org.uk>
References: <20250304-mt6359-accdet-dts-v3-0-5b0eafc29f5b@collabora.com>
 <20250304-mt6359-accdet-dts-v3-3-5b0eafc29f5b@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OLmxqaxv809+84Iy"
Content-Disposition: inline
In-Reply-To: <20250304-mt6359-accdet-dts-v3-3-5b0eafc29f5b@collabora.com>
X-Cookie: Do not disturb.


--OLmxqaxv809+84Iy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 04, 2025 at 12:15:44PM -0300, N=EDcolas F. R. A. Prado wrote:
> From: Andrew Perepech <andrew.perepech@mediatek.com>
>=20
> Add an mfd_cell for mt6359-accdet and describe its IRQ resources to
> allow the mt6359-accdet driver to probe.

Lee, is this OK to merge via ASoC?

--OLmxqaxv809+84Iy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfHKM4ACgkQJNaLcl1U
h9AGawf+Krbqa+Vm4jfRJRkHk1Bz74IQ/DHedsnpuELy2Rv59vOzi/ONHxJ/Vsq8
03MvfgczYs8uzSrfII7fto16qxrsRaVGeTkSaanOAZHhFT32ytipNw7CIa03tchc
8NtyjnLXMDyBqeEuzKVUTmzp5DgA57934vPFsBXP+jix8i0IYKthA2mFxcIVk8AJ
npoP45KaBxueBRiIbQ88nbeEWMk2zpCYaqDQxeBCROSqF+j+VlV2V9/LFr9nmGla
fXrY4hD9vRT7RUs7od+v2zpfnn6M4dMqA1gEIoZq5b+NQ3BlVHug4uHInjm7QUqN
XR/caFRH1sjlz1NMYvElHtzG4TDjtQ==
=ZRYJ
-----END PGP SIGNATURE-----

--OLmxqaxv809+84Iy--

