Return-Path: <linux-pm+bounces-31084-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3089BB0B008
	for <lists+linux-pm@lfdr.de>; Sat, 19 Jul 2025 14:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8BAB1AA1493
	for <lists+linux-pm@lfdr.de>; Sat, 19 Jul 2025 12:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC6C287244;
	Sat, 19 Jul 2025 12:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jq8jwH5i"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F02E3597E;
	Sat, 19 Jul 2025 12:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752929677; cv=none; b=YOVaklBzG4t2QBgWJEUlgjxBMgVITNcJtfBxYCJQw8bZemnep9lNPMDUt5xOmZtfZGaZcecUAaEeR+nMCNviVlGy7KlgMJ+6deG1ULC0RlSNvUaTrJifFypZAcMYTu4haPMbL1cHZeEj5+8GqqqkiVXSyqY8Wp3jaM3eOYxJ54g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752929677; c=relaxed/simple;
	bh=a2WHzkI/q/vrfok07xSzhfKqQpt4+MzLjtP3AUlEfJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iL7qgp6xuRm9gzcHLNZB5AVYy7h5HdbUdPC/HQ60vz4QUGYNMJ7Ktnj5Qt70aVANHCEORlRExr5b5xbj9N7CVClAQlYWAVgGNpdnm4MdwzKt7MfXUFPVAOxJCyEgQQHdBB++oT9w+aVoi9yE9+2R9u3VfRHVpyrFAGmYCcGO2OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jq8jwH5i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3978C4CEE3;
	Sat, 19 Jul 2025 12:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752929676;
	bh=a2WHzkI/q/vrfok07xSzhfKqQpt4+MzLjtP3AUlEfJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jq8jwH5ioSPAWSCDq53c0gOMiFlEapSfh+u1ampq1Bc2an1kYbzy+Qp5JwT4oCONn
	 5DJpv4QxdFB4CMjzAyO46vKignmqVGI/XyjMKQ+VOnzYJoDoj+sINd25AxXRtl92eo
	 NOFO6lX01LEFFhpxiNbiJci1AYikzfGAngRAGRofT03gCf1qrXhdyS6QJdOh1/kVG6
	 5EMvCqYHxxHIWMFLcwOAD28Q0dpwnB3NReOvwE/ULTcV3fWNGULEq9W4dux/jx3B1j
	 8oJiksxGtGrivHaRVUSLcY4z6JEVXOZqibk75hlFj6NoV2/A5hkiGAvfE9lU0E/VDt
	 Y4eWjdBpazflQ==
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
Date: Sat, 19 Jul 2025 14:54:20 +0200
Message-Id: <175292958117.11653.12996215497191655678.b4-ty@kernel.org>
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

Applied to git@github.com:AsahiLinux/linux.git (asahi-soc/drivers-6.17), thanks!

[04/10] soc: apple: rtkit: Make shmem_destroy optional
        https://github.com/AsahiLinux/linux/commit/0445eee835d6

Best regards,
-- 
Sven Peter <sven@kernel.org>


