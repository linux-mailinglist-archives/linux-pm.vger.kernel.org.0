Return-Path: <linux-pm+bounces-21718-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 451D9A2F4AE
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 18:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A77237A134A
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 17:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDA51F4629;
	Mon, 10 Feb 2025 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0wLt4Le"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A765256C6B;
	Mon, 10 Feb 2025 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739207314; cv=none; b=KN7QM0TatYulPvOf0QGV44o460YIQ/mADF8xzfmxHo4HEAQVdg6XfVz6eIOTepqyD/hZZ1LyFzPw9a3Uimci9OY0qBoSMbBRitNkthYKwBfJlrhk5fIrCgOPNyACjebYkHFQTw52C1BGY03ZZHBYxw4BoWbNfxTuoVeKFWu8Nec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739207314; c=relaxed/simple;
	bh=YPiIV3FVQDgTvF1uzfq8I8ivVOEmSwK8YTY460GDFAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7XMpREk8cXH4NuzH0ZLTsoS5kpgK6cNnD3Kt71sJRta8nEtV7uvAnvJDU83c6IoAhqh7+ULbPNSgcIuv2UDBZxcft2TkTh39/zQ/crHE7qEbgE84MJJ7R/NIEEhkm/6EcekMB9fjuNd/wyLPS7PLyEZmifEL2MB3jW6eKDxKuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0wLt4Le; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C3AC4CED1;
	Mon, 10 Feb 2025 17:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739207313;
	bh=YPiIV3FVQDgTvF1uzfq8I8ivVOEmSwK8YTY460GDFAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d0wLt4LeSACcXTPEuk37KpFhHehZdYr8F4InbpZn3f9Uikmlj3Su6Zk4uIILqeA0v
	 WYIenmqtTTwRGHnHInzY5RsVw+W6Cx7PSsIo4B8/ljPxgDPRuGN7tb7GfdXqJFBVEX
	 mP690288N2MA8gSZ/5T3XeX6tliEWXQ104SsCFL12lKin9if5xr0cBwkZyLI2HsYHg
	 v58Qjz59fufrVCYSyAm3XsN7h1fGKvjEuo/gt3LZRptVOltfkqWdnTeTZfPXQB/2u2
	 ltRQtBShL+D6luWGOyYNbJeZyhu0N4ek3vPMnnQp/00HAKgYDI78HfGg2kEphJTZh/
	 5DZsRY4yAudlg==
Date: Mon, 10 Feb 2025 17:08:27 +0000
From: Lee Jones <lee@kernel.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v17 0/7] Add support for Maxim Integrated MAX77705 PMIC
Message-ID: <20250210170827.GF1868108@google.com>
References: <20250123-starqltechn_integration_upstream-v17-0-8b06685b6612@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250123-starqltechn_integration_upstream-v17-0-8b06685b6612@gmail.com>

On Thu, 23 Jan 2025, Dzmitry Sankouski wrote:

> The Maxim MAX77705 is a Companion Power Management and Type-C
> interface IC which includes charger, fuelgauge, LED, haptic motor driver and
> Type-C management IC. It's used in Samsung S series smart phones
> starting from S9 model.
> 
> Add features:
>   - charger
>   - fuelgauge
>   - haptic
>   - led

LGTM.

Once Sebastian provides an ACK, I can take the set.

-- 
Lee Jones [李琼斯]

