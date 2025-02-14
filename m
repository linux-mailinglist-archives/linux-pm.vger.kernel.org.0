Return-Path: <linux-pm+bounces-22068-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74665A358D9
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 09:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22F687A475D
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 08:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108A822256C;
	Fri, 14 Feb 2025 08:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPH1wC+a"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50A2205AB8;
	Fri, 14 Feb 2025 08:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739521678; cv=none; b=pSQ0uLAu32mghJ3BZLEkyF679LFbEsfQ9o+LqwJzN4QlKGs7aY6kcO65woXCT7X+RqmqJrODFWOX28VsqMA3AjmDqwJc9TK9wu30kO+R6x8M6vT96bSqwvhhLfbKXgsEKiiSMd3CV7dSEXERvh90zk8I64XzQbDv9aqiRtzPQ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739521678; c=relaxed/simple;
	bh=BoRysOvekYDA4kO3GR1yCKqhh422oc1fAiBZ2HdLOvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BF6fYjld6k7/Ub/KFwMMxa+57aiXgmYgfu7LoUiBAxYZUVd/MaSOkH46+dPI/con1frP5ECxYawrReVMmBLYDYcSuQuqB23kbsHUtJA60kDfqiwgnwUM9Ul0lpdqe8XhNIb7+3OEYkfVz8BsFpiWOQEFFMSK0VlcAkm2Hb067Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPH1wC+a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21CFC4CED1;
	Fri, 14 Feb 2025 08:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739521676;
	bh=BoRysOvekYDA4kO3GR1yCKqhh422oc1fAiBZ2HdLOvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZPH1wC+aZsA9yZhCw7fK5KlP3yKl+CSu4P7qaTcf/n0xCDu+7Q6KgnLNqD0/6zb8R
	 DZ0BXrOaWvV/hfWh5Vtx6WYQErdUHCN7nZM8B+6iGO/y1nx9UpgnaiiHT8vGpnPNLy
	 9zjeOPrHIjm4JaE+YFeAUz1lpp61AjwLndaVjYu+XeqGeRyIyKjFcHGWtY/rJ6jbfo
	 QFeJ1tCeWsi78+uTdVZg6rzKOXfcQ7CtM5H6STxL7yGs7g/jC0QXQG9ZCSYjeDW/jh
	 loU9x+QiyOB3UmFeDDMqnxF9Hb9OZwR2KPABGet6Y9z3/pHHZ4j7KNG+OqO7qv1Sg0
	 +/jwbNfV2+/+g==
Date: Fri, 14 Feb 2025 09:27:53 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, claudiu.beznea@tuxon.dev, sre@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, p.zabel@pengutronix.de, 
	linux@armlinux.org.uk, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 06/15] dt-bindings: rtc: at91rm9200: add
 microchip,sama7d65-rtc
Message-ID: <20250214-fat-elegant-myna-bb2c6d@krzk-bin>
References: <cover.1739221064.git.Ryan.Wanner@microchip.com>
 <a0338f3d05ed43eeaf2121dd22a9f0dbf25f2fc0.1739221064.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a0338f3d05ed43eeaf2121dd22a9f0dbf25f2fc0.1739221064.git.Ryan.Wanner@microchip.com>

On Mon, Feb 10, 2025 at 02:13:06PM -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add SAMA7D65 RTC compatible to DT bindings documentation.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  .../devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml          | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml
> index c8bb2eef442dd..0c878331170b4 100644
> --- a/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml
> @@ -25,6 +25,9 @@ properties:
>        - items:
>            - const: microchip,sam9x7-rtc
>            - const: microchip,sam9x60-rtc
> +      - items:
> +          - const: microchip,sama7d65-rtc

So that's enum with earlier entry?

Best regards,
Krzysztof


