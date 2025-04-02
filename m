Return-Path: <linux-pm+bounces-24718-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121B7A78850
	for <lists+linux-pm@lfdr.de>; Wed,  2 Apr 2025 08:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7BDF16F20B
	for <lists+linux-pm@lfdr.de>; Wed,  2 Apr 2025 06:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D219B230BF8;
	Wed,  2 Apr 2025 06:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvagkUC6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE0D1519A6;
	Wed,  2 Apr 2025 06:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743576500; cv=none; b=rrEcLZgXgpiJVIeMO1Ldav0k8fAy5Mg+0BEWTCawE8mhxQsRCAnipyRiLU7Gr4zygj29sh3ekTLEbM01UfGrmxQ18S4tEDS4UxAKpZy+j991hb5p1Yq2BBS4FxRr+KQNvCmL4L4FQzWnb0j8CXo55ZtDJnGjUgz5hRKTB1KXAfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743576500; c=relaxed/simple;
	bh=E1bV+ZSAUuEQxNhPyLIPtvTt5fbU6mA00CBvGzT+XXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsdEqXLXgw6mzRGkxyMAUIWPikaxWi7o/U4SYcRpCYqwbvoQuVDmr9J1y9w6Bl2bZiMjpOxfvK77xJ5hgXmfZhREb7Sq7wZqVu5oaFsTOcODpJql8pvZq5cW12OTw8Cah03pLmHRc9tqJZMY18lto0MmKhX/2ZWRVE/zYzdsVYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvagkUC6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39574C4CEDD;
	Wed,  2 Apr 2025 06:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743576498;
	bh=E1bV+ZSAUuEQxNhPyLIPtvTt5fbU6mA00CBvGzT+XXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HvagkUC67o2ypNjUUh+4D2kPj9fGjt+0nISzb3fMqrUvA9z/rYl1hikGj7RhwIcqI
	 yFlqDmikkd27f5hKYORYnpXqizAUN+gQ07VimUCux7O36KkCVeCpZilDUvVvWAuNna
	 A7z6NWDYhzxnw2bdHK/Ju+wrEGIC42ykOb5mGq3rZ/ruhMaE+qYBI35cGeppxwDCVO
	 4+0MzhpuVs4JskxVf7wiuja4hKQ+Llvmr2SxzM6fm+urYpNtDbDMz86vJDNx+L+uc7
	 Es9bi1JXfZz20Jw4dcX32e8yqrL/xqS2Taioni9cZ1ep7AIm3Jkih7sS/jCU2589Sw
	 UStw8qqu989IQ==
Date: Wed, 2 Apr 2025 08:48:14 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Peter Griffin <peter.griffin@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: reset: syscon-reboot: add
 google,gs101-reboot
Message-ID: <20250402-imperial-grasshopper-of-weather-2ff12a@krzk-bin>
References: <20250401-syscon-reboot-reset-mode-v5-0-5b9357442363@linaro.org>
 <20250401-syscon-reboot-reset-mode-v5-1-5b9357442363@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250401-syscon-reboot-reset-mode-v5-1-5b9357442363@linaro.org>

On Tue, Apr 01, 2025 at 11:11:02AM +0100, Andr=C3=A9 Draszik wrote:
> GS101 supports a couple different reset types via certain registers in
> the SYSCON register map.
>=20
> Add a compatible for it. When in effect, all register values and offsets
> are implied, hence they shall not be specified in that case.
>=20
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---
>  .../bindings/power/reset/syscon-reboot.yaml        | 42 +++++++++++++++-=
------
>  1 file changed, 30 insertions(+), 12 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


