Return-Path: <linux-pm+bounces-18890-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 078139EA9B9
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 08:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3C39285009
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 07:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6811E22D4E8;
	Tue, 10 Dec 2024 07:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PW3R4KX5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0B3192D66;
	Tue, 10 Dec 2024 07:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733816332; cv=none; b=V+Ar3UP7Jq6aEXA4Lo5J8r07a55qhNACaoKSYJORRTh1jtIp66WKV6gKWgLlz3PHHIcr5/eNPEsrZXHvVkqTBDWYkUTf8uNEs9HwGp5fV0km+FcXCVmGWpBZxgrEFHDvskmawV7LgMl79jQKOiMD2h6tJOhdjxBRsV/cPU2Tlhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733816332; c=relaxed/simple;
	bh=8vRgH+DMqnC+8/qKfDvPBIE9joqCziZosetEu39kVLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u86jJSc8Z5sUe2CimXTd6yUtJpQrkVDl6xKr0ge078gZl82zZLz/aHbm9JRTh8/YT8xbMX5F2QyQKoRV+zpbL9VYhuMZ2IsmQV3ozmul/FNrZzGEUYiR3IgjbVtk5aPAHMb+EuoxMf0/h4WYV/NMKaWPS2m3OJsgH+53kIqMPa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PW3R4KX5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA21C4CED6;
	Tue, 10 Dec 2024 07:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733816332;
	bh=8vRgH+DMqnC+8/qKfDvPBIE9joqCziZosetEu39kVLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PW3R4KX5PHfiWqmhGDpTq2CMpzpuB8ic7gVYKZIjTtMSZSl0TQmccGekO0WBKclzc
	 op0gGKe7SaTQdj9jmFRffjS3DuqmuBm/8UMwSJgVtDlkW7J2MGnY6Squ0V8xby3JCb
	 d14112euSK5m0GhPCDxjALPO9mSybn4gtUeNc4khfws8c0BGNsX9o0ExWrLsjmyFLM
	 QRJfgHYBqiZZYM2RHXIby5R1heAHhhKOosIBXVfVdfyNr3QGnuJhxWKrV3j04lkfbZ
	 2haK4kNkNVxWWgdBL/b8hpyOJS0OCpevJ+T5mjo6qPWqcAjrbRxJgGUPDVU/MNG7zJ
	 0nr/m5kc6Xj+g==
Date: Tue, 10 Dec 2024 08:38:48 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
	Purism Kernel Team <kernel@puri.sm>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v11 3/9] dt-bindings: power: supply: max17042: split on 2
 files
Message-ID: <7qt7thbuh5mvoaknxaiteusbmcmiusc23k2oiyvq3bwn4l6wsw@p4qid73hmiry>
References: <20241209-starqltechn_integration_upstream-v11-0-dc0598828e01@gmail.com>
 <20241209-starqltechn_integration_upstream-v11-3-dc0598828e01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241209-starqltechn_integration_upstream-v11-3-dc0598828e01@gmail.com>

On Mon, Dec 09, 2024 at 02:26:27PM +0300, Dzmitry Sankouski wrote:
> Move max17042 common binding part to separate file, to
> reuse it for MFDs with platform driver version.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
>  Documentation/devicetree/bindings/power/supply/maxim,max17042-base.yaml | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml      | 49 +------------------------------------------------
>  MAINTAINERS                                                             |  2 +-
>  3 files changed, 68 insertions(+), 49 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17042-base.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17042-base.yaml
> new file mode 100644
> index 000000000000..1653f8ae11f7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/maxim,max17042-base.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/maxim,max17042-base.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim 17042 fuel gauge series
> +
> +maintainers:
> +  - Sebastian Reichel <sre@kernel.org>
> +
> +allOf:
> +  - $ref: power-supply.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max17042
> +      - maxim,max17047
> +      - maxim,max17050
> +      - maxim,max17055
> +      - maxim,max77705-battery
> +      - maxim,max77849-battery

Shared schemas define only shared properties, not compatibles. But the
main problem is you did not answer nor resolve my previous concerns -
either this device has separate address and probably is a separate
device on the same or different bus.

Plus this was not tested and does not really work, but anyway let's
focus on my previous concerns first.

> +
> +  interrupts:
> +    maxItems: 1
> +    description: |
> +      The ALRT pin, an open-drain interrupt.

...

> +
> +additionalProperties: false
> +
> diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
> index 14242de7fc08..b7fd714cc72e 100644
> --- a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
> @@ -10,60 +10,13 @@ maintainers:
>    - Sebastian Reichel <sre@kernel.org>
>  
>  allOf:
> -  - $ref: power-supply.yaml#
> +  - $ref: maxim,max17042-base.yaml#
>  
>  properties:
> -  compatible:
> -    enum:
> -      - maxim,max17042
> -      - maxim,max17047
> -      - maxim,max17050
> -      - maxim,max17055
> -      - maxim,max77705-battery
> -      - maxim,max77849-battery
> -

This does not make sense. Final device schema must come with compatibles.

Best regards,
Krzysztof


