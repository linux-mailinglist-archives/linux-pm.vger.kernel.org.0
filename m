Return-Path: <linux-pm+bounces-24620-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 443F2A75F47
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 09:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BE473A8BBE
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 07:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2CA1AD3E5;
	Mon, 31 Mar 2025 07:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSdeyP93"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E541A7046;
	Mon, 31 Mar 2025 07:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743405093; cv=none; b=HKzwBaX6/0vfdemGD/k5aoYebVVYbpIQ/ywzcZPhxfgu4I9Npih6GVtatWhzRxyf9oFYBmUgmfPGj0G+H0X4M+TNKW55vDTtcufZqlfNUaXhbWR5f4hK2Fs35WhxzIllJS+UiUn3w0ihnMJuvQFOmlAFmu6fQuj9DAFjnT5iVW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743405093; c=relaxed/simple;
	bh=xT7WrDbAbzGj6vaDIChdvhzipFV59/v3gg7SXkyKn/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dj5ct3OUS/zlnchkff1zQEXXvDyDhXftOliqduK5isYddPOJPHNpZXyID7OfSQcwy5JiCtxsOX18DGsvRkZlwKcG39nJrWCeUI3xH+bZxYFBIItc+AE62VwAJKyQRKoTsRMGlaCo7Uiqx5JVnkVDrYoLRG+lMARze1+KUD+XTf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSdeyP93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697F1C4CEE3;
	Mon, 31 Mar 2025 07:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743405092;
	bh=xT7WrDbAbzGj6vaDIChdvhzipFV59/v3gg7SXkyKn/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XSdeyP937ISbslf0eEzJY8M6DYJnTqjE+jVb60RjB5P67SAFNTShNRYCKBFASxLDs
	 W2oJaOvepv4bZhaaCbg0tOvgGZwzF1cVN+qQVTCT7O5MPS45emLqzilhLwBqoFhv6i
	 SEeC1N2sQeZxgM8u+RbduukDLjdBIcomOj+llpbpMsn3LokbNfZu4apPL1UH44eqWo
	 xEm/eqIa2LM17yDDFJmrxQfpq/EP6jAq6VVja97cFeVihSom8P/NmTNFsHKCTLHoH+
	 NdXSAwCcEipajZ5JX3OISZZvxSE4w1xl/oUU+VrCgkHk2hhvVWkQ3xmpNGagwvc6jM
	 k7ls3aKigRzgg==
Date: Mon, 31 Mar 2025 09:11:28 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Peter Griffin <peter.griffin@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: power: reset: google,gs101-reboot:
 add Google GS101 specific reset
Message-ID: <20250331-unnatural-tacky-mouflon-a1157b@krzk-bin>
References: <20250328-syscon-reboot-reset-mode-v4-0-77ba57703ace@linaro.org>
 <20250328-syscon-reboot-reset-mode-v4-1-77ba57703ace@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250328-syscon-reboot-reset-mode-v4-1-77ba57703ace@linaro.org>

On Fri, Mar 28, 2025 at 03:15:19PM +0000, Andr=C3=A9 Draszik wrote:
> GS101 supports a couple different reset types via certain registers in
> the SYSCON register map.
>=20
> Add a binding for this.
>=20
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---
>  .../bindings/power/reset/google,gs101-reboot.yaml  | 32 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 33 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/reset/google,gs101-r=
eboot.yaml b/Documentation/devicetree/bindings/power/reset/google,gs101-reb=
oot.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..cbd0a1d9b45af0cb994d616c5=
6b96440c43ab971
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/google,gs101-reboot.y=
aml
> @@ -0,0 +1,32 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/reset/google,gs101-reboot.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Google GS101 syscon-mapped reset
> +
> +maintainers:
> +  - Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> +
> +description:
> +  GS101 supports a couple different reset types via certain registers in=
 the
> +  SYSCON register map. This map is retrieved from the parental dt-node. =
So the
> +  gs101-reboot node should be represented as a sub-node of such a node.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:

Just const instead of these two


> +          - const: google,gs101-reboot
> +
> +  priority:
> +    default: 192
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +allOf:
> +  - $ref: restart-handler.yaml#

Missing example... unless you are adding it in the other patch to the
parent node. but then separate schema for just two properties and allOf:
is really too much. Altough let me comment on the other patch.

Best regards,
Krzysztof


