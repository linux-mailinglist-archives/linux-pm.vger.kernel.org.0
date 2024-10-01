Return-Path: <linux-pm+bounces-14997-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F1898B511
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 09:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18F261F226BB
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 07:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8281BB6B6;
	Tue,  1 Oct 2024 07:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUffass2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537BF194AD6;
	Tue,  1 Oct 2024 07:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727766143; cv=none; b=ETQAKSuiQZozarTw366AS9Zq9+H/2c8WtvU9hOwsAeh+rPBfHkUGIx3jk0sIcK41z4hwpipli38LkXkWSGcEccHzE1ubRWMWO2oEhcQ6yRGTXJjfRNPTzJHcneO1BI94Sg/MkSLEfixdvFacxvwdb2bB8iFxRPHo3EnTvSu+2LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727766143; c=relaxed/simple;
	bh=JiNwJfaUj4tY4idPDYEa7vtxFc2/p2JSEmTSyzSIDL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjtOmJ5wzuPjFxYVOylUWhHLJnKtt2ODJZztRRIymBGhT0t3ACzSYBBzWIx+Ta9hYVUiXPTEbnK9nSYOysvpL1a+F+P8ANHRtsRMgIiTtoDzcDKL5GccOblELXdETNp2way05blBOT2bnq2A1YspSLtA7r0s1N/TYqTlVwTyjFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUffass2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B755C4CECE;
	Tue,  1 Oct 2024 07:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727766142;
	bh=JiNwJfaUj4tY4idPDYEa7vtxFc2/p2JSEmTSyzSIDL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VUffass22TOXVgrWVAJU7Yo5eWbhl1vg0yRoo5rlmhoVMi1hjNgj6zM6iJTnRGc78
	 uA0vA3qNA9cGdGCfD1C1PWhIfCE57ul6ord2Y+DsbbLz+wqAgTWTZ7UlgFYt268+0V
	 Bg8F2+GHTlWq9esRHvZH5jxBj7rFo9K+2AJPwcX2VhsrP8p4uaEBF5pQnLq4pmiQeq
	 ZgwHKjQkUP/0uukpiCd/4XbQb1StYJWo411IEeVm4Q8/DSDUd82ivPw+e1xVDOT8l8
	 JaT0uTQQQcfth0XEZShe4EoF/v2PXlAB8z2WZqcifzSQM9Q+I8njvO2asQaYT8fwn6
	 wKEMm+wn049fg==
Date: Tue, 1 Oct 2024 09:02:19 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pm@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, tony@atomide.com, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, Lee Jones <lee@kernel.org>, devicetree@vger.kernel.org, 
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: power: supply: Add TI TWL603X charger
Message-ID: <hongy6wkrxb6o4qyfbsgw7ar6e4vbdwewaxnf55p4s5z7n2hh6@uglfoy54kibf>
References: <20240930155404.1275702-1-andreas@kemnade.info>
 <20240930155404.1275702-2-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240930155404.1275702-2-andreas@kemnade.info>

On Mon, Sep 30, 2024 at 05:54:02PM +0200, Andreas Kemnade wrote:
> Use a fallback compatible since for especially for generic
> defensive setup of parameters, both 6030 and 6032 are the same and
> U-Boot actually uses a generic 6030/32 function to enable the
> charger.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  .../power/supply/ti,twl6030-charger.yaml      | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/ti,twl6030-charger.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


