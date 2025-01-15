Return-Path: <linux-pm+bounces-20510-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55023A12D66
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 22:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABC777A218B
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 21:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29ED91DDA09;
	Wed, 15 Jan 2025 21:08:56 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5731DC184;
	Wed, 15 Jan 2025 21:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736975336; cv=none; b=VO9IVUGP8aj1kB5RoEbvo7KsgcmA3S2OtFJujs1jzndJrja7AUfrXORbgciq0fY0HLM1R27hunbblYEYn2JQOeZli0lU6YLAArNKtUw06yAwYUOMqdv2Xg3kOf0QAzFc7/fBRaG64udZUdWLt/mlsN+FP2TCDaSjAlNNenPfsGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736975336; c=relaxed/simple;
	bh=Hc6oGqpA7KKCGq5JsZL79RSCvlj7LS++YtScRN99jS4=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BPOPqohwEGmKQvdSFljJHGAjNYHkQTx+kAqAHMPvk0zsB1WxwnPSUWL5ViruTU3WkJqfn1bdRlJACPibJsY3gvmcYcTM6tU8Toib7Spue9PLozeTlD+XAb1qbIww+ZxM1gw9IWhHvsrwsVCrQrAQDBM433Ecdm7FdUPVXJGQ8qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DFBC4AF09;
	Wed, 15 Jan 2025 21:08:55 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 1573E1060342; Wed, 15 Jan 2025 22:08:53 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Santosh Shilimkar <ssantosh@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250111185358.183725-1-krzysztof.kozlowski@linaro.org>
References: <20250111185358.183725-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] reset: keystone: Use
 syscon_regmap_lookup_by_phandle_args
Message-Id: <173697533308.451358.18169584396752785322.b4-ty@collabora.com>
Date: Wed, 15 Jan 2025 22:08:53 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 11 Jan 2025 19:53:58 +0100, Krzysztof Kozlowski wrote:
> Use syscon_regmap_lookup_by_phandle_args() which is a wrapper over
> syscon_regmap_lookup_by_phandle() combined with getting the syscon
> argument.  Except simpler code this annotates within one line that given
> phandle has arguments, so grepping for code would be easier.
> 
> There is also no real benefit in printing errors on missing syscon
> argument, because this is done just too late: runtime check on
> static/build-time data.  Dtschema and Devicetree bindings offer the
> static/build-time check for this already.
> 
> [...]

Applied, thanks!

[1/1] reset: keystone: Use syscon_regmap_lookup_by_phandle_args
      commit: 81312ea9b892e2c6989cce7274eca9f437ba6cf1

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


