Return-Path: <linux-pm+bounces-24621-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBA2A75F51
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 09:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CBD3167FC6
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 07:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820DF1B0F1E;
	Mon, 31 Mar 2025 07:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ay1EarCv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8542E3395;
	Mon, 31 Mar 2025 07:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743405320; cv=none; b=rIzKm8ZGZtPbE911xYuveEGBvcK4wvDxwiNNfwKYi/fddR/mXVFaj+8bDF0gd0geFaRoJzeiAVR3u2ywUcPVn14hUKTWC/p5/DSCF5a6eo6NJZq2s5mwQ6vIZFcwYSbLKwYtYnfquqGi7frHef3tanVoScJRFsVJzje7tasLHkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743405320; c=relaxed/simple;
	bh=U9WwColyPjE0PpqjI7kbqYiBlOxCoADRrn2LMrMsr6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZ2fyXkbeY7gr964vctrzjOCMG1U3kjjpAtBBsAOzmDHmuWxj/JKI7hhlRzO8AznjB3jhxRPnqlpKk8WJ/XLPKFzNfJi3Xun9Ec6pQJywVR5hSVx5FYPhGYWkB4OxZh12DjKUbW8/aeU1fHr6LgySQNjbMaGNqdWYob9a0t/P4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ay1EarCv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1769C4CEE3;
	Mon, 31 Mar 2025 07:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743405319;
	bh=U9WwColyPjE0PpqjI7kbqYiBlOxCoADRrn2LMrMsr6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ay1EarCvuM4L667uBXmzflmFp6Gpw+QkTMwL8AEnelkr5h9Rs4pnLyMNxJc5fSia0
	 4P4suRMQCzZ+F8Lc7OkB7/Rr5+rbsfMR2kBNvnds9HXdtBvtI9qA+WzMag1hTEqquc
	 f/pJOOT6/cn0u2zA9zcQlMvuaroEopWI8xLGcy9BWxH1FmCn6HGtbBWYvsVnPr39MR
	 bXBE5Qi6jJl2cIDHP1pxKjTv9Fu1ShNBolIxr0srHHjSAU9i+ugaoxv3EdGT2PVzKn
	 9LMt9OvneCmz8DWaLTBbD4q26Fmf2Ag2naHinrAmsxsfLPCktVsx80hdSdvyuhkLwj
	 MvCmukjMnIfWg==
Date: Mon, 31 Mar 2025 09:15:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Peter Griffin <peter.griffin@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dt-bindings: soc: samsung: exynos-pmu: update
 reset for gs101
Message-ID: <20250331-curvy-daring-urchin-aeafa8@krzk-bin>
References: <20250328-syscon-reboot-reset-mode-v4-0-77ba57703ace@linaro.org>
 <20250328-syscon-reboot-reset-mode-v4-2-77ba57703ace@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250328-syscon-reboot-reset-mode-v4-2-77ba57703ace@linaro.org>

On Fri, Mar 28, 2025 at 03:15:20PM +0000, Andr=C3=A9 Draszik wrote:
> Add the gs101-specific reset node, allow it on gs101, and disallow it
> on !gs101. Similarly, disallow the generic 'syscon-reboot' on gs101, as
> we want the specific one in that case.
>=20
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---
>  .../devicetree/bindings/soc/samsung/exynos-pmu.yaml | 21 +++++++++++++++=
++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yam=
l b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
> index 204da6fe458d2d4bfeee1471ebc5c38247477ae2..8c7362cf3eeab11f6bb13a27e=
b295d5ee6721b71 100644
> --- a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
> +++ b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
> @@ -97,6 +97,12 @@ properties:
>      $ref: /schemas/phy/samsung,dp-video-phy.yaml
>      unevaluatedProperties: false
> =20
> +  gs101-reboot:

syscon-reboot

> +    $ref: /schemas/power/reset/google,gs101-reboot.yaml#

=2E.. which leads us to the existing node. Just use oneOf:

oneOf:
  - $ref: /schemas/power/reset/syscon-reboot.yaml#
  - $ref: /schemas/power/reset/google,gs101-reboot.yaml#

or actually better:

additionalProperties: true
properties:
  compatible:
    enum:
      - syscon-reboot
      - google,gs101-reboot

Best regards,
Krzysztof


