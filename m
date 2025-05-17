Return-Path: <linux-pm+bounces-27263-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F760ABA9A4
	for <lists+linux-pm@lfdr.de>; Sat, 17 May 2025 13:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16B35189374A
	for <lists+linux-pm@lfdr.de>; Sat, 17 May 2025 11:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1161DE2DC;
	Sat, 17 May 2025 11:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5MqPy0E"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836071865EE;
	Sat, 17 May 2025 11:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747480604; cv=none; b=q9UKlUQu9vra5/HcO/7bT4Am5CcNDnCLCOP1lOmrNZwLLpu/1O1gWRifVEP55kbe0+3B13hGPqP8Xn1C+67oi0x/6ZbuPxaRhzfRD0tLP9BbMFKLrnDhMkHNDQ8ih3W15Bl1sDcjLduUDdMRYbQ5Qm0MWapg876LjlVNwIVnSbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747480604; c=relaxed/simple;
	bh=TQbNzv+KNeF4oDstHc0C0i1N8dU8BT9R/sMC1iLPUdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U5TOYcKoVgGmoSg39mHopL0/9QnghRQDP4QpTW1Yuk1NJtTikJ+V859nc281ikhPwVwu+ggygrAGdqdiKHD+C84uHn9q+obptTe+GTlp2KxiH5szRE2tS50oSn1FS9zWtEGdTVGLGKi9xfmQVpl1VSkhqKHgb1ARbKjbAvbPMek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5MqPy0E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08D8C4CEE3;
	Sat, 17 May 2025 11:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747480604;
	bh=TQbNzv+KNeF4oDstHc0C0i1N8dU8BT9R/sMC1iLPUdQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J5MqPy0EdP85nQXq5Y5mJmAaro5lHrk6ShnYJuJH42eynbHOEuR9/9alKFYdVqWPt
	 eXRH5s6QRgRiZXZRaX393uluc19OdscPU1SOsO9dDUZJRK1d+1qedmN2/Mfgt3w1Ys
	 3zXIXfAdFdePrACrdBNdixIK9eWgFE+5sRmk5wHnNbzot6W7R0PMRwoM32tKJ09DgV
	 OkxP4y420cDYF+8I0ejuSrJ0m8jygVOtmO4Bs+8A4K+FTbmzbGcD7mYodP6po8mQaD
	 oadX++J41fDPC/KEKDSsse9/eQ+omcNvss2mTrSkIrlYxW6zQh+ATf9LN1hfjsfxE3
	 YWNMCwt0/+w+A==
Message-ID: <31542315-5ea1-4849-b2f9-686cabce914a@kernel.org>
Date: Sat, 17 May 2025 13:16:38 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] dt-bindings: mfd: add pf1550
To: Samuel Kayode <samuel.kayode@savoirfairelinux.com>,
 Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>,
 Robin Gong <yibin.gong@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-imx@nxp.com, inux-input@vger.kernel.org, Abel Vesa
 <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>,
 Robin Gong <b38343@freescale.com>, Enric Balletbo Serra <eballetbo@gmail.com>
References: <cover.1747409892.git.samuel.kayode@savoirfairelinux.com>
 <8be1626f970c9fab8b50ae9ad45e0ddd88fa36bf.1747409892.git.samuel.kayode@savoirfairelinux.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <8be1626f970c9fab8b50ae9ad45e0ddd88fa36bf.1747409892.git.samuel.kayode@savoirfairelinux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/05/2025 20:53, Samuel Kayode wrote:
> Add a DT binding document for pf1550 PMIC. This describes the core mfd
> device.
> 
> Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>

You need to explain the dependencies in the cover letter. There is
nothing there but you have clear dependency and all bindings must go via
one tree, unless you re-do this to use compatibles.


> ---
>  .../devicetree/bindings/mfd/pf1550.yaml       | 122 ++++++++++++++++++

Same comments.


>  1 file changed, 122 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/pf1550.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/pf1550.yaml b/Documentation/devicetree/bindings/mfd/pf1550.yaml
> new file mode 100644
> index 000000000000..461bc13513eb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/pf1550.yaml
> @@ -0,0 +1,122 @@
> +# SPDX-License-Identifier: GPL-2.0

No.

Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.


<form letter>
Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC. It might happen, that command when run on an older
kernel, gives you outdated entries. Therefore please be sure you base
your patches on recent Linux kernel.

Tools like b4 or scripts/get_maintainer.pl provide you proper list of
people, so fix your workflow. Tools might also fail if you work on some
ancient tree (don't, instead use mainline) or work on fork of kernel
(don't, instead use mainline). Just use b4 and everything should be
fine, although remember about `b4 prep --auto-to-cc` if you added new
patches to the patchset.

You missed at least devicetree list (maybe more), so this won't be
tested by automated tooling. Performing review on untested code might be
a waste of time.

Please kindly resend and include all necessary To/Cc entries.
</form letter>

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/pf1550.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PF1550 low power PMIC from NXP.

Same comments

> +
> +maintainers:
> +  - Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> +
> +description: |
> +  PF1550 is a low power PMIC providing battery charging and power supply for
> +  low power IoT and wearable applications.
> +
> +  For device-tree bindings of other sub-modules (regulator, power supply and
> +  onkey) refer to the binding documents under the respective sub-system
> +  directories.
> +
> +properties:
> +  compatible:
> +    const: fsl,pf1550
> +
> +  reg:
> +    description:
> +      I2C device address.

Drop

> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  regulators:
> +    $ref: /schemas/regulator/pf1550.yaml
> +
> +  charger:
> +    $ref: /schemas/power/supply/pf1550_charger.yaml
> +
> +  onkey:
> +    $ref: /schemas/input/pf1550_onkey.yaml

This makes merging via separate trees not possible...

Just fold everything here, drop compatibles and then put binding in the
regulator. Unless children are re-usable which would justify
compatibles, but then please provide arguments for that.

Best regards,
Krzysztof

