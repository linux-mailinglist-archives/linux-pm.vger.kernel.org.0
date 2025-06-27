Return-Path: <linux-pm+bounces-29635-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E08AEAF6B
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 08:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E9EB567F81
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 06:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4D9218ABA;
	Fri, 27 Jun 2025 06:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaWXwu0i"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FE821858D;
	Fri, 27 Jun 2025 06:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751007526; cv=none; b=KJXFDvWnnRDrbOBMfjSYUr7neKCCYtL2KPHDLGloYMR4C2e+/v8VGwE12g7iugVS0HYNFv4ILExYxzGtOzlAWgDdlzwKA9ZLyEwktSmsw3ZFAHKPw0KNepmWQE+Xr2BHQ0LR8sbyWAsMyb9FH0GuxDsa31PHKeMHCJN0mAzsnU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751007526; c=relaxed/simple;
	bh=U00Wt6aru37Pu+FP5KMXq1ujUHGShgCuBTIQu4QJPGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzFbcmqI/hIhPRYPcPSQE3Bp6C6h6iXWP0/Npyk8bkz2O52kuSzB6eBg/xuvqM8w4SCtDd96Me44IAA6AVFZDIzU92W0xQciXZ2OF11Z7gRK4rWUd1zDeP93Vwm14wwekzux0+vktL5kOf4f+RSJ1oBZYhKbWGqrYz1ohk6eYAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaWXwu0i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C10C4CEE3;
	Fri, 27 Jun 2025 06:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751007526;
	bh=U00Wt6aru37Pu+FP5KMXq1ujUHGShgCuBTIQu4QJPGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CaWXwu0iXbiZA7oWvep3mRF5ME28JAE5DrKZo+jVpHw1zwJENwHfmNG0joHXYb2Kf
	 SYky40oOM059O/S9O0lCI8BONxLA8agBRfmtrSq5dLu/5rzqHGvTB43N2x/6X5Bn3S
	 lKwRIAaP9aUCJsHo8FaTSb61FkG5kbVjkI0IPdEz6WkC3JpPza/S6JW4rpFNV5/0NI
	 oYEHRapl89QIDbBjMrqZLhqz4i/2hOVy30S5FXErywoPVa9QDFSM+JinwJP0OTn18N
	 Hwv47z7D7GEuBxF6WXi19mtkCFkZIXMJinHvtQhXVATvPxcIKujcHYgMXu3rnj65mJ
	 QP9ZGi+loBpag==
Date: Fri, 27 Jun 2025 08:58:42 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	devicetree@vger.kernel.org, broonie@kernel.org, lgirdwood@gmail.com, sre@kernel.org, 
	heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, 
	lee@kernel.org, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V4 1/5] dt-bindings: mfd: ti,bq25703a: Add TI BQ25703A
 Charger
Message-ID: <20250627-lurking-amorphous-elephant-e14c7f@krzk-bin>
References: <20250626195343.54653-1-macroalpha82@gmail.com>
 <20250626195343.54653-2-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250626195343.54653-2-macroalpha82@gmail.com>

On Thu, Jun 26, 2025 at 02:53:39PM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Document the Texas instruments BQ25703A series of charger managers/
> buck/boost regulators.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>

Didn't you receive tag?

> ---
>  .../devicetree/bindings/mfd/ti,bq25703a.yaml  | 117 ++++++++++++++++++
>  1 file changed, 117 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

<form letter>
This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions of patchset, under or above your Signed-off-by tag, unless
patch changed significantly (e.g. new properties added to the DT
bindings). Tag is "received", when provided in a message replied to you
on the mailing list. Tools like b4 can help here. However, there's no
need to repost patches *only* to add the tags. The upstream maintainer
will do that for tags received on the version they apply.

Please read:
https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577

If a tag was not added on purpose, please state why and what changed.
</form letter>

Best regards,
Krzysztof


