Return-Path: <linux-pm+bounces-21786-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91638A3055B
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 09:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44BDA167C4C
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 08:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C6A1EE7DF;
	Tue, 11 Feb 2025 08:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYRi6IPU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE351EE017;
	Tue, 11 Feb 2025 08:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739261569; cv=none; b=fqZ13/dZh5UEpK/7b4zzfsx+NFk5qImLGhIU32iexjwCXdoPGnMMRR/+k80s2Jgo7ks26ByXSwO/aosV/8Q1VaaX2bFB40gB79nw2d1yugHHEhQUeQ36RP4Z+UX+1Y0sePd7j0K8SorKcbEHPDZWj18c4NCHvtuiI4llXhudAoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739261569; c=relaxed/simple;
	bh=BnklPy0jBwIcPPG0sfRjtHiMoI+AINPFQwQR4mm4XlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSsqnE+r38GvjiP/X0QUwKbGa8rA/8FJC3LZJ4i/ebYuEgoixlvcoWGQzheTidBe8xYKvFZHHw5Q8Dir6HdxHuRRQp5+8ni5d479OzDLjXOab5LMF5YF9hc8wPifb20XmTXI1avI0z12GKZBG2lp5CweQ229TEoNMN8rLNmYWpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYRi6IPU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2383EC4CEDD;
	Tue, 11 Feb 2025 08:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739261568;
	bh=BnklPy0jBwIcPPG0sfRjtHiMoI+AINPFQwQR4mm4XlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RYRi6IPUcjP10cTFZ3JnXr6ZE2UChBLEn+nMJE3VvaCYbQmqo4hYQfj/GlHbDcbTo
	 bDdvAfGvM76dcFahRq4LANPLe7jgrG3KiRZddZ1SWCZ8M9jNqfe9CcVATpb/BBMorq
	 pIxuZzg9fa2jb3UhLNX4EdCT3G9sE55zQpsV6SyQZq7hVP5fBJa7iaqmYeSJgeEiLb
	 OqspoFUWG2j6ZFih8kukG5bDISXmlXIw7IdEVnhQcM4LLrFXw63ZbMpcHPYgNlQ45W
	 01MSNTnfclflNUGViKchq8sl248/zRw4s+qGxRY9KUMxCk9kFeFqvo5UTDVeR6H5Jx
	 YqQiWrOlZvWdg==
Date: Tue, 11 Feb 2025 09:12:45 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, claudiu.beznea@tuxon.dev, sre@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, p.zabel@pengutronix.de, 
	linux@armlinux.org.uk, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 01/15] dt-bindings: mfd: syscon: add
 microchip,sama7d65-ddr3phy
Message-ID: <20250211-logical-ingenious-slug-9b648a@krzk-bin>
References: <cover.1739221064.git.Ryan.Wanner@microchip.com>
 <7e2c590467171cb3a942692aef5a679f127e567e.1739221064.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7e2c590467171cb3a942692aef5a679f127e567e.1739221064.git.Ryan.Wanner@microchip.com>

On Mon, Feb 10, 2025 at 02:13:01PM -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add SAMA7D65 DDR3phy compatible to DT bindings documentation
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


