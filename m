Return-Path: <linux-pm+bounces-32097-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DC6B1FBAB
	for <lists+linux-pm@lfdr.de>; Sun, 10 Aug 2025 20:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F31D17710C
	for <lists+linux-pm@lfdr.de>; Sun, 10 Aug 2025 18:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0AF274FD9;
	Sun, 10 Aug 2025 18:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYe7rWM5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BF926C39B;
	Sun, 10 Aug 2025 18:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754850349; cv=none; b=YJiFknJFnhdHL+bvzNwHLfyYdGCOzf3i4kry2+Wrb4tuI+MT9TTFVqe0iTAWzvsHg2IMDRC9PjD/T4VH7yXS5fDdkyhCXQpk/MMSKNHfrKZ4+fyCSIMS1v7FJFWOrLkunhb7u91/mHUScrmfkcOBVJHBbxoxWiYsXufzKwwZNXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754850349; c=relaxed/simple;
	bh=mZCkM6wGTji0mWS1T8Wao5Nwc6iHBzOB8nBF6FjiL+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JYCQd870NlKgYnKfudTxMi80MXMX1yK0Pgv1cHlQQHQxbFN0kVD6jrYH7mTzyqBJn5HlUdrvXf6wwZHG6YIek5MYtkvKIZyByp8UqQSaE+hMpaJZ2KQrF0nLb2zd+Pd3PD4Q2dmMNOoNJFL/Qr54s+6i818md3ogBM4E3+bJRtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYe7rWM5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF8DC4CEEB;
	Sun, 10 Aug 2025 18:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754850348;
	bh=mZCkM6wGTji0mWS1T8Wao5Nwc6iHBzOB8nBF6FjiL+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QYe7rWM5WTvPFgmLR7TLjrutsMkJklAM/UhllHcSQAfItQYp0TIM5qKhyNbmwqd9p
	 HZnUw7fWKocJce1pJiPspNZGQZH+Vm46cN7KOL9PZ4eh0w2SCOQKvmn1daATRrV9Cv
	 4cdQxC1mAC5SLLCrc9dk587FcaSETEVNuPQjkKwe4pFCCgoht6KoOnQpmJstZ4LwhK
	 mU+QkVG1GAVBX32aiGpRWx+VUTOzOhMWP8cbN7RtcdzXpodPlWtbwmfwo68Jz84cp0
	 iVRfDjK90q+dXl0TmkkgfAGAicf3uU1xgqaNv6tz949zkpXivG+bL2WJz3LruH+wWv
	 f0AqtP3qtqlPQ==
From: Sven Peter <sven@kernel.org>
To: Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>,
	Hector Martin <marcan@marcan.st>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Sven Peter <sven@kernel.org>
Cc: asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: (subset) [PATCH v7 00/10] Apple Mac System Management Controller
Date: Sun, 10 Aug 2025 20:25:34 +0200
Message-Id: <175485029271.49938.2893773472462799086.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250610-smc-6-15-v7-0-556cafd771d3@kernel.org>
References: <20250610-smc-6-15-v7-0-556cafd771d3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 10 Jun 2025 15:29:41 +0000, Sven Peter wrote:
> This series adds support for the System Management Controller found in
> Apple Silicon devices which we model as a mfd. It also includes support
> for the GPIO block and the power/reset block as sub-devices.
> 
> Changes between v6 and v7:
>   - Rebased on 6.16-rc1
>   - Dropped mfd- prefix from the macsmc driver name
>   - Removed the check if the MBSE key exists in the reboot driver since
>     we can rely on the device tree now
>   - Changed my mail address to kernel.org
> 
> [...]

Applied to local tree (apple-soc/dt-6.18), thanks!

[08/10] arm64: dts: apple: t8103: Add SMC node
        https://github.com/AsahiLinux/linux/commit/6101fe95b1ee
[09/10] arm64: dts: apple: t8112: Add SMC node
        https://github.com/AsahiLinux/linux/commit/49765a617a54
[10/10] arm64: dts: apple: t600x: Add SMC node
        https://github.com/AsahiLinux/linux/commit/4379305ffbc2

Best regards,
-- 
Sven Peter <sven@kernel.org>


