Return-Path: <linux-pm+bounces-18891-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C28309EA9C3
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 08:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78CEF284D46
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 07:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6D5227560;
	Tue, 10 Dec 2024 07:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="od+/DqDU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B9C172BD5;
	Tue, 10 Dec 2024 07:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733816424; cv=none; b=bOqzMXtP0Dxodmbyazb2TESiOHREXq9PVO+yyJKJ57EBB3Vu1uY1ZBwboRqMF08nrZ1Z/QWY/B7hYSYu5P6BYwmNZIPB/xPyrJK0RH/iw37t9zNPxIX+zRTq1ymwVGIUTXIdCwsaBiU193ck82CypyD2uEFjmEoNtIWhFDsS1fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733816424; c=relaxed/simple;
	bh=nzpmwZVWHwGpxIkipi+fJQIVbIbAQ3WZO9CIjk+pZC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBdl7qX2JS7V4Vf0dYYeFEM/CNtjlXF9al5cWXERJk9FTe1ntAp7oBRxlzuf/aA8S0TKyVHzO2U/uFQkHa6LhEgNlbwX48mUGvR/2KC/H1B6Ktk6cJqjrhmrgoHVibuBTpS1Gy/AfkL+uygFwJR+7kf4fbG1ckjKyO1eWOH/vJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=od+/DqDU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F23FC4CED6;
	Tue, 10 Dec 2024 07:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733816423;
	bh=nzpmwZVWHwGpxIkipi+fJQIVbIbAQ3WZO9CIjk+pZC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=od+/DqDU66vllOpOtrqJzxvp4kFoQL0NFBzP6wow1TIETtZsigCBhbQ9KoOuf+wpf
	 ZGkdCP97oTCjX6SNemf+4gY1Z6PgrL9igEs8CYVYc3MZqNhwWNT30leKM2GOGWbWTt
	 7SpdPKENZwMpapADYJlWUcUW+rwXit56T281q9TwSqVvCdhKsrBf+axUo/oYqviZK0
	 iTSaUaKNA+n3c0O8wmNUyXZfGHNTUfxWXQGrL2nZ6OEvuuk2RQzP4OresoiJ3RCo53
	 Gyhl3f/5svwZOhTK/x8q90AxhNkKKZ89j0gBfn7Q8fOVfF3hUb+F3WjgEKQ4P7MB3K
	 EeQzYmdpIQLZg==
Date: Tue, 10 Dec 2024 08:40:20 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
	Purism Kernel Team <kernel@puri.sm>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v11 4/9] dt-bindings: mfd: add maxim,max77705
Message-ID: <v7pr3ah47h6w2bco2h7ctl4ydv3igu7vibbn6dy646fdljv7wf@eknbz34wsnof>
References: <20241209-starqltechn_integration_upstream-v11-0-dc0598828e01@gmail.com>
 <20241209-starqltechn_integration_upstream-v11-4-dc0598828e01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241209-starqltechn_integration_upstream-v11-4-dc0598828e01@gmail.com>

On Mon, Dec 09, 2024 at 02:26:28PM +0300, Dzmitry Sankouski wrote:
> +  charger:
> +    $ref: /schemas/power/supply/power-supply.yaml
> +    unevaluatedProperties: false
> +    properties:
> +      compatible:
> +        const: maxim,max77705-charger
> +
> +    required:
> +      - compatible
> +      - monitored-battery
> +
> +  fuel-gauge:
> +    $ref: /schemas/power/supply/maxim,max17042-base.yaml#

We do not use "base" in any names, but rather common. However shared
schema cannot be used without compatibles.

Best regards,
Krzysztof


