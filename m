Return-Path: <linux-pm+bounces-14780-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 645DA986D2F
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 09:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BCD5B20E2C
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 07:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6CF18952E;
	Thu, 26 Sep 2024 07:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOMrENlp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3BB188CC7;
	Thu, 26 Sep 2024 07:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727334306; cv=none; b=amxu7wvtdlucn9fomizvLerWTr69N9Bq3gQKi84JRPgtExrhG4PdxiN3V+qzvZtrRNeqOXoHqWAPZpUbY1jzAw1wC6o6mYEK356lFh90K3ijtrSvsGRbv72dghiNHzJj0I+1mgB067BOXf07r+yMbuETVKM2E5qnfzBJk69cvLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727334306; c=relaxed/simple;
	bh=PmeIsMqrFqSAHKlByfGuq98ieyZORXwH7IlRJ289hkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7rutuvZJ6V4dLpkHJAiO7EbZznKunFrCfTr7y3cW3marwnwz75B2MGdb2KTu5CTpRDeS8Kr3IGPMhF9MwfKSJz036R+PSCVkDD4lPAzbINxkvgZCHCg7yp7EJKalG6+zq6nH/P0FNQUEGF9GF/NOViC+tqebIydwYGUjlFTbWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOMrENlp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE93C4CEC5;
	Thu, 26 Sep 2024 07:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727334305;
	bh=PmeIsMqrFqSAHKlByfGuq98ieyZORXwH7IlRJ289hkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vOMrENlpetRETktPSGtOA359hRSkrkG8LJYOllofjox8SsQzjhpWT5a4/gJOOoNis
	 DPTDOOeK2io3H/Oxh18WRYbazxTmOlMmQgmpCemzmM5G2dn90s71QMcdXtNgiYx3Qm
	 lOssOVusI+Xp0FMIkHFHTV8l0tBxTrh2kE1Z3EyaHhBDKRi+CcG1nqnuyfoQzOvuoX
	 68nDpQvKl6eMv2wO3ru8Y+LZdpF4QBNsmDeMbj7H7RfHTcRRZQuVo0JHf97Prq+AT2
	 POLthqzIfDq4unWXO6fUGU5M1VvFsIEdlXhqQUNRz679fLEL5fDLG50ugTyOPO9BAD
	 irLg1G2ze4Zxw==
Date: Thu, 26 Sep 2024 09:05:02 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Caleb Connolly <caleb.connolly@linaro.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: power/supply: qcom,pmi8998-char: Add
 missing "interrupt-controller" to example
Message-ID: <bxxhgmcfxhzvf3m655gl3asiro6v6zaqrxeea3nlehyc54dl6f@3nvonnrzynpw>
References: <20240925173413.1905782-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240925173413.1905782-1-robh@kernel.org>

On Wed, Sep 25, 2024 at 12:34:12PM -0500, Rob Herring (Arm) wrote:
> Enabling dtc interrupt_provider check reveals the example is missing
> the "interrupt-controller" property as it is a dependency of
> "#interrupt-cells".
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml   | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml b/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
> index 277c47e048b6..a1b4926e7190 100644
> --- a/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
> @@ -61,6 +61,7 @@ examples:
>        #address-cells = <1>;
>        #size-cells = <0>;
>        #interrupt-cells = <4>;
> +      interrupt-controller;

Opposite, the interrupt-cells should be dropped. The parent ("pmic") is
qcom,spmi-pmic.yaml which is not an interrupt controller, according to
the bindings.

Best regards,
Krzysztof


