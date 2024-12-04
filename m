Return-Path: <linux-pm+bounces-18578-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D25969E4686
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 22:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4241B2CA8E
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 20:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC3C1F5403;
	Wed,  4 Dec 2024 20:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ii4Df9ET"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8741C3BF5;
	Wed,  4 Dec 2024 20:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733343770; cv=none; b=MCoPm1HoSO+Q+9GJ2uQxWHX8ARS6azDr/Nl42svDkuMbFPzuMopVWM3y/773cNrxfqaTXwuCnTkc+yQ20KRvK3tkZrxmmBwgNdbi5+DR1l3jl7GvbHfcc5TyNQlT4K8fXLXEdM6xd7MmcEH7he7ldeniJovp7dL92nZDr6cLORc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733343770; c=relaxed/simple;
	bh=0trD3xgMuTcQ522NBjE3lOKrUeCloP+XOtSvdc704e8=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=QW84uhxvmFtc2BRmyq4ASOcY32CBRpySdg5Ub3hzxxppDBYmUyRZGtUrUN4TEm6fmJRQCmVhqTXr36T+8dQ2A56Ta9FUxNKkKgbLT1uDdkfW0NmYVAxWV5F3kL5SASAI8twjp0rdqrLyx6MJsPdSWgWKLOU4q9bM6jy49FtDBzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ii4Df9ET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5556C4CECD;
	Wed,  4 Dec 2024 20:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733343769;
	bh=0trD3xgMuTcQ522NBjE3lOKrUeCloP+XOtSvdc704e8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Ii4Df9ETJjJlTt+OFI6XJ4qtn4c1zLT2QMdivBw/V6WxCbffn+5GnT/x9V0jfnriG
	 Ckj+ctFI030Oqp5kY2Ttv0zR6kOW749IuqszjgSBILW1RheoF2Qa5KYC5gQAeHkeYY
	 60YmmVLwIiVObrU/sYeTsQfk677+TlpgqBD3deYZ0bMgchJ8BxteVjNdjA/02aIGEH
	 dFzHP0jZ+vrXV/0LwSRwq4WXz2bREIb3pdAc/V4tfUOzKq/PcbQEXs5+DxByl0mhPX
	 DX69u3WXwSYfdZICNYAciKuIOrB+b/3OnAnc+F9VlSw4N7qgQRppPV9nKXsxdcxBle
	 T2bU/8iVNzqkQ==
Message-ID: <d15dc75cb5d0346bb56c58d4a933cf7e.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1b05b11b2a8287c0ff4b6bdd079988c7.sboyd@kernel.org>
References: <20241203134137.2114847-1-m.wilczynski@samsung.com> <CGME20241203134155eucas1p1e90c71c4f8eb5da41d2cc8a500f54dc7@eucas1p1.samsung.com> <20241203134137.2114847-6-m.wilczynski@samsung.com> <f21ffd12-167b-4d10-9017-33041ec322b0@kernel.org> <07bfb02a-1df3-4a03-83bb-d7edc540739d@samsung.com> <1b05b11b2a8287c0ff4b6bdd079988c7.sboyd@kernel.org>
Subject: Re: [RFC PATCH v1 05/14] dt-bindings: clock: thead,th1520: Add support for Video Output subsystem
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>, Michal Wilczynski <m.wilczynski@samsung.com>, airlied@gmail.com, aou@eecs.berkeley.edu, conor+dt@kernel.org, drew@pdp7.com, frank.binns@imgtec.com, guoren@kernel.org, jassisinghbrar@gmail.com, jszhang@kernel.org, krzk+dt@kernel.org, m.szyprowski@samsung.com, maarten.lankhorst@linux.intel.com, matt.coster@imgtec.com, mripard@kernel.org, mturquette@baylibre.com, palmer@dabbelt.com, paul.walmsley@sifive.com, robh@kernel.org, simona@ffwll.ch, tzimmermann@suse.de, ulf.hansson@linaro.org, wefu@redhat.com
Date: Wed, 04 Dec 2024 12:22:47 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Stephen Boyd (2024-12-04 12:21:11)
> Quoting Michal Wilczynski (2024-12-04 02:11:26)
> >=20
> > To address this, I'll specify the 'reg' property in each node to define
> > the address ranges explicitly fragmenting the address space for the VOS=
YS
> > manually.
> >=20
> > vosys_clk: clock-controller@ffef528050 {
> >         compatible =3D "thead,th1520-clk-vo";
> >         reg =3D <0xff 0xef528050 0x0 0x8>;
> >         #clock-cells =3D <1>;
> > };
> >=20
> > pd: power-domain@ffef528000 {
> >         compatible =3D "thead,th1520-pd";
> >         reg =3D <0xff 0xef528000 0x0 0x8>;
> >         #power-domain-cells =3D <1>;
> > };
>=20
> You should have one node:
>=20
>     clock-controller@ffef528000 {
>       compatible =3D "thead,th1520-vo";
>       reg =3D <0xff 0xef528050 0x0 0x1a04>;

Apologies for the typo. Here's the correct line:

	reg =3D <0xff 0xef528000 0x0 0x1a04>;

>       #clock-cells =3D <1>;
>       #power-domain-cells =3D <1>;
>     };
>

