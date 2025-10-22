Return-Path: <linux-pm+bounces-36629-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 044CABFA3F7
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 08:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7BEA19A4330
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 06:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4102ECE9E;
	Wed, 22 Oct 2025 06:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDO4qd8f"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698362E8DE8;
	Wed, 22 Oct 2025 06:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761114889; cv=none; b=jwUNGZ8w0K0HnxXP2FsAw7q5QSRNtC2ha5DdDJA/qOnxoZI638tuP+XsxAoaHi2qZUzns85hFpF0M9jjYmttIx0xIm2GlXE9btAeEGfggTNg4+qwZrDSkDHnNMD6QTaWmgs6EXJEQxOYKqfbU+bVY8oqaADlsnsGaAOwGVOl+EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761114889; c=relaxed/simple;
	bh=D2PTmYOT8hDSErFJQKrvndrwlAQoD632GmelzECD21A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1Zjp540VdKVSqXYKVOkdCk0BmUUt2aCODLZ20aMVDH7DPePQCHKlVp1iuacgSN6BI8ZRDeVrT+hEPZ+peSO0Qla/Rim6apK1e9/ewcezr0MS7w8krDoX7JAzcFHWVdfAslJzH13U4FG/3KwSpRB8As3bYMtPb/fZnBnu13aqRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDO4qd8f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5908DC4CEE7;
	Wed, 22 Oct 2025 06:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761114888;
	bh=D2PTmYOT8hDSErFJQKrvndrwlAQoD632GmelzECD21A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZDO4qd8f22vFrYaO0/g2y2okUHkPeHwKrJyZHuzVii/PTBZtNvdJB++osfbbYH1mt
	 Ve89PKu1ILbGtMtnjTKqs3aoI/SXMCzpMrEVM00QF2VYDWNjaciAPPEwWkxtMkyRdq
	 oXLRqZShToaoQ9aMCIUwUnHpZF19PvDT+XM7JHfyIuVoiy3K+JrTq6zoPRjukDQ6Wz
	 03SCoRpSqj+dJj/tjXZC52svfvOhjGlXqB4LMsEqUz2rdda65pl3sHsyiwaFaXRaa+
	 hckVcONQx8yJzefLKdrlPpZuBgtINnyPGw7THqY+Tbj6wjB0toc4xATH8/EqpQ4CH7
	 hdvk2y6h0pfrQ==
Date: Wed, 22 Oct 2025 08:34:45 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 02/10] dt-bindings: soc: samsung: exynos-pmu: move
 gs101-pmu into separate binding
Message-ID: <20251022-tremendous-literate-markhor-a7b98f@kuoka>
References: <20251016-gs101-pd-v3-0-7b30797396e7@linaro.org>
 <20251016-gs101-pd-v3-2-7b30797396e7@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251016-gs101-pd-v3-2-7b30797396e7@linaro.org>

On Thu, Oct 16, 2025 at 04:58:35PM +0100, Andr=C3=A9 Draszik wrote:
> The gs101-pmu binding is going to acquire various additional (pattern)
> properties that don't apply to other PMUs supported by this binding.
>=20
> To enable this, move google,gs101-pmu into a separate binding.

You did not copy all the properties which effectively drops certain
things from the binding, e.g. clocks, interrupt-controller and maybe
more. Please list them in commit msg and explain they are not applicable
to GS101.

>=20
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
>=20
> ---
> v3:
> - use additionalProperties, not unevaluatedProperties
> - fix path in $id (Rob)
> - drop comment around 'select' (Rob)

Best regards,
Krzysztof


