Return-Path: <linux-pm+bounces-19700-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 901EF9FB0D7
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 16:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6E5B1883E3F
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 15:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777C71B21AC;
	Mon, 23 Dec 2024 15:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4g9N+KP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C02A1B2183;
	Mon, 23 Dec 2024 15:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734968676; cv=none; b=VJ0bWfUbyCdvZlo4UZvPrwFryyk9fUNgSf6Nj8afow6CaLXPBh/2Oj86ONaLgWDDsQgYL+luQRNn0KcZAUNInWxxHvzHjYLFTrl/RnRj+nQtGuF1oOtvyvanpcZHV3sR1jtBJDbfAgen6cgSunMPm9wp/Nz8m9wwFlBbI9n8Mtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734968676; c=relaxed/simple;
	bh=P58BfM1eLX8nsbarr8LbXy7rbCHGW8IEeTz+FqnUKWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeRHlfAY2ACSh1Pb5d630BPIZE8+cszoRWojsxYXZjMlrYsj/56i1IJ+8cX1kigQTNyidy/Un4/daVw1FIgqGd0d3HuE384RTkqjZrH/aX1EKRchEZRxhln0bT+ZUeZeLLDsnSB7yv/a9/Z3ohKiyjiYkaxD30aGlL+eTcH6Gk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4g9N+KP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6710EC4CED3;
	Mon, 23 Dec 2024 15:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734968676;
	bh=P58BfM1eLX8nsbarr8LbXy7rbCHGW8IEeTz+FqnUKWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X4g9N+KPNqW0RxnI16bsJjOeWE9zDNZjaiw6LVONzqPNNmNUWPE6bxtxQYqQSCS6l
	 fvgpsa+N7tcoaCndjdh/1K9lhWUko4typP0hOdpAEFIKrH5Totua2gJdpmqzxo55qZ
	 +yj1FjFW+aAJvqosmnbazKupvINeNlxKKFOPHS6ds9REf2Cbc/CqPCUY2/0xtm43Hc
	 43iWsdxMhuN/9UAiqhMKV/U97sb53jj5BbNCJhBJa5HanE+FcemrDEsvpFCyFGbbph
	 vXBvnWwtAmo4PO4l+iA3tJ8TSupXmRyF7QrfRqbL26ENAgp7TAPNrk0YdNjWVFgBAb
	 oevOO3sqanlfQ==
Date: Mon, 23 Dec 2024 16:44:33 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
	Purism Kernel Team <kernel@puri.sm>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v13 02/10] dt-bindings: power: supply: max17042: add
 max77705 support
Message-ID: <mkl76lbmsoyiewssj52le4jpp3up2s7qrot444wokeafraxvay@55xsjrp35c3l>
References: <20241223-starqltechn_integration_upstream-v13-0-fbc610c70832@gmail.com>
 <20241223-starqltechn_integration_upstream-v13-2-fbc610c70832@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241223-starqltechn_integration_upstream-v13-2-fbc610c70832@gmail.com>

On Mon, Dec 23, 2024 at 04:59:39PM +0300, Dzmitry Sankouski wrote:
> Add max77705 fuel gauge support.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
> Changes in v10:
> - keep alphabetical order
> ---
>  Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


