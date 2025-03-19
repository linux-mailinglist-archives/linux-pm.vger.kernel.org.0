Return-Path: <linux-pm+bounces-24326-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B77A69CCB
	for <lists+linux-pm@lfdr.de>; Thu, 20 Mar 2025 00:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0A2425153
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 23:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D642223716;
	Wed, 19 Mar 2025 23:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZLfRuoy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2DC2222A1;
	Wed, 19 Mar 2025 23:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742427740; cv=none; b=O+9Y8Gtg5/+vM+EbX2bXZf1ZpC0IQa+OpI/qx1T4IsA1hJ2z+Hhxk0zz+Cu1sFvHtb5hYmD2Ry61PKeuJJZNDZ27H+w+1/Gx4GWTNBI/OMV+dtn1xCVybGba7TgXDjLxVQTdkuCqeGLA1m2xY9xW/FvsXXIfhfcyJ/r8f2jVGVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742427740; c=relaxed/simple;
	bh=2DHRKW+ZtPYLjeyzEWQuzOQUbGwhYP2SpRTrHx7JFZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWbSCbmKXjKBKAC6AAHyWT1gdJ/w1HuNynQfYO/+PLDBNE2Wbf/ILX473jvNxL+DIWqTYLg94CRMLYZzUkjnbG8XTCvO02voH34e4X6SNU9SxlOMom9RfXypQEXGgbeX5ac5HrkTkSwbq3i3a179QZAcS1E6Ks0TxyL0AeIX0Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZLfRuoy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DDD0C4CEE4;
	Wed, 19 Mar 2025 23:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742427739;
	bh=2DHRKW+ZtPYLjeyzEWQuzOQUbGwhYP2SpRTrHx7JFZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UZLfRuoyCH4ZyJdjYW1+dVKQAVE59LiiCQlbQvEtUh+hP9b+CoKpp30p1b9pkVvjR
	 435PSCn218QDgYaR69XFEt19AmDWzE0uYofq3jAiU25axHRN9RdthgKoK5THD8UW5o
	 RKupPN+D+lFApcFdB0SzpqKNBHkOlr0+DSFvNGH907+mnnPIOMsE4eMzkWoAiC+kiL
	 4uAaZ5zbaEo4Zrvn4jnNXhQVudm9/nlGXYRO7g3mGt8+f8tL5C5J1p4qCb/w1NLbgl
	 4MCwk9o0QQCBDr986iLidOykuw7Cbp336TPXiQyWW1TLlpGnAXVLJBPNKXgOp27jiC
	 DlkmZmk9m60zQ==
Date: Wed, 19 Mar 2025 18:42:18 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
	Artur Rojek <contact@artur-rojek.eu>, devicetree@vger.kernel.org,
	Mike Looijmans <mike.looijmans@topic.nl>, linux-pm@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Dzmitry Sankouski <dsankouski@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: power: supply: Correct indentation and
 style in DTS example
Message-ID: <174242773745.2648480.14551287782671331549.robh@kernel.org>
References: <20250318081428.33979-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318081428.33979-1-krzysztof.kozlowski@linaro.org>


On Tue, 18 Mar 2025 09:14:28 +0100, Krzysztof Kozlowski wrote:
> DTS example in the bindings should be indented with 2- or 4-spaces and
> aligned with opening '- |'. Correct mixtures of the style or any other
> indentations to use preferred 4-spaces.
> 
> No functional changes here, but saves some comments during reviews
> of new patches built on the existing code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/power/supply/bq25980.yaml        | 34 +++++++++----------
>  .../power/supply/ingenic,battery.yaml         | 14 ++++----
>  .../bindings/power/supply/ltc4162-l.yaml      | 18 +++++-----
>  .../bindings/power/supply/maxim,max77705.yaml |  4 +--
>  4 files changed, 35 insertions(+), 35 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


