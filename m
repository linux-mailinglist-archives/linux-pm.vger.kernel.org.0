Return-Path: <linux-pm+bounces-36631-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 849BEBFA445
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 08:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8026B584050
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 06:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42E72EFDB2;
	Wed, 22 Oct 2025 06:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tA5kH5d8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852102EC569;
	Wed, 22 Oct 2025 06:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115161; cv=none; b=YXDdiTzcav/houI2C/gX4QBvklcv2ZceMkZVG/BtPwPnn5iKioiECUITCDuJzD+sbYMav8vUb0WrmHecWCIGGSQwVHQZuE0aN2Ur90XlydXrda4lYnLP3tO/5QmhIDiwcrQxT6pIOqVWVE4tABuxwm5H/3WbQSyMDoPU8z00MeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115161; c=relaxed/simple;
	bh=cjz+4FLk0fJPFbORna7dS+dCkdfSE0IQ1LJUuc7G8xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFZx5VzRPtCdy/AJjZXYCUusL3W3m8V5IKblbv7YukXAXHNM1N43XhflAxk/Jby27l3CqF/ePyOvqustavmAL+FnxiW/MhEXxzX1yLy796HcOao8bpKI6uCjGlGVRvM26H5bHk+NZt3mWb5xdEQ7ArWYzBRMyMMR9/7VX3x5d/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tA5kH5d8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB49C4CEE7;
	Wed, 22 Oct 2025 06:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761115161;
	bh=cjz+4FLk0fJPFbORna7dS+dCkdfSE0IQ1LJUuc7G8xY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tA5kH5d8tnc4x0lWs6nncAVn4lcZFa6Ei/FUoLmKOibYiWV5QeEutr90QUpA9F0EC
	 gEB7QE+Ll41XfqMiHtsehht+Jm3lk9mbkbWZgyO6JynnyklJQmCRNjue2qsqBofsw3
	 2CL4Gb/NzJC7wKw+1o9yAKiV1enxChDt0U2J1YIE6ApiQWqPa9xM93ha/+KGp91+yJ
	 1dL97UO/RrfOHbGzoWuZt9e3dGAG9KmB+bdsOy/lphn+j9PuPrsygutxdKxArro7h5
	 bdd6NJDe4VCmQikvWUrFQJI2HZ4n6kwq0bgNVbydcOFC7HPMnpf8SZcWbfXiAgY65w
	 1byX8U4PKuKtg==
Date: Wed, 22 Oct 2025 08:39:18 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 03/10] dt-bindings: soc: samsung: gs101-pmu: allow
 power domains as children
Message-ID: <20251022-uncovered-soft-uakari-4b52e3@kuoka>
References: <20251016-gs101-pd-v3-0-7b30797396e7@linaro.org>
 <20251016-gs101-pd-v3-3-7b30797396e7@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251016-gs101-pd-v3-3-7b30797396e7@linaro.org>

On Thu, Oct 16, 2025 at 04:58:36PM +0100, Andr=C3=A9 Draszik wrote:
> The power domains are a property of / implemented in the PMU. As such,
> they should be modelled as child nodes of the PMU.
>=20
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
>=20
> ---
> Note: Ideally, the newly added properties (ranges, etc.) should only be
> 'required' if "^power-domain@[0-9a-f]+$" exists as a patternProperty,
> as they're needed only in that case. As-is, this patch now causes
> warnings for existing DTs as they don't specify the new properties (and
> they shouldn't need to). Only if DTs are updated to include
> power-domains, such an update should also add the new properties.
>=20
> I've not been able to come up with the correct schema syntax to achieve
> that. dependencies, dependentRequired, and dependentSchemas don't seem
> to support patterns. Similarly,
>   - if:
>       required:
>         - ...
>     then:
>       required:
>         - ...
>=20
> doesn't allow patterns in the 'if' block (or I didn't get the syntax
> right).
>=20
> Rob said in
> https://lore.kernel.org/all/20251010141357.GA219719-robh@kernel.org/
> that this is a known limitation in json-schema.
> ---
>  .../bindings/soc/google/google,gs101-pmu.yaml      | 40 ++++++++++++++++=
++++++
>  1 file changed, 40 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/soc/google/google,gs101-pm=
u.yaml b/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
> index f7119e7a39a3fe0a0a23d1faa251d356f83ba501..a24390f6d2a54afe1aa84935e=
03f719a62f4fc8e 100644
> --- a/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
> +++ b/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
> @@ -26,6 +26,14 @@ properties:
>    reg:
>      maxItems: 1
> =20
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +  ranges: true
> +
>    reboot-mode:
>      $ref: /schemas/power/reset/syscon-reboot-mode.yaml
>      type: object
> @@ -49,9 +57,23 @@ properties:
>      description:
>        Phandle to PMU interrupt generation interface.
> =20
> +patternProperties:
> +  "^power-domain@[0-9a-f]+$":

Keep consistent quotes, ' or "

The problem is that you mix children without and with unit address. I
guess that's the limitation of syscon-xxx drivers because they could
take the reg/unit-address, so it's fine.

Best regards,
Krzysztof


