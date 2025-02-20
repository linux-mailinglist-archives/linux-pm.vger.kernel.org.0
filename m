Return-Path: <linux-pm+bounces-22559-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7E3A3E11E
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 17:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 579CF3B5723
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 16:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40531204879;
	Thu, 20 Feb 2025 16:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHew2h1L"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0990313A87C;
	Thu, 20 Feb 2025 16:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740069620; cv=none; b=pkSHXwgs7qtw8XA3mXT7MRukzrPqRpcJEZ2JmOdUHADqZGdCJHzJTOsWrIKZo5PB0fhuHkSm9zcNJLYAw0cMg57DXg7Q7oQ1yz2VIYBtZYsgnViLNzWW7YyfLICe/dFxPHKvLyfasoLvV94vAVh/9fNeCHkkQ2NFJ7gDJKUx1IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740069620; c=relaxed/simple;
	bh=yGrW1sKVebqJhUcMcxVBHgSJO25Iq3FjkThrAN2NsKI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jGqtUtrkfbzS4oGTwhFKYqLEfpBbV9+23duh1imsDRl6YQGeMC3GbctqqHSTv3lXVTetkMnFbk1+wFd3qCCbUr7I4WZ20jbQ8VOBr569v9CLSwAz1s9GSyRGCciA2g3UPRZsYgi0NtSb3GSn8CzBlCzhTMhahTR00RvCOmdJJ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHew2h1L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A0BC4CEE2;
	Thu, 20 Feb 2025 16:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740069619;
	bh=yGrW1sKVebqJhUcMcxVBHgSJO25Iq3FjkThrAN2NsKI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oHew2h1LIKFuHP5TwtrVGg/jFxVLEXSmPMZl7Xhszm2Xyi1SttuJs9BIgQ7vBaGRR
	 jZos+8vIqCLhl5cFJYAnfe4S1pVsT4uAnKwJ85f62W1xwYFq78EaGEGy1yyciNZsrJ
	 ru3CSoK9qE97a+g5ptUBJAagw4h1DZXIaMST12BLJ/TRjM6oKEt/XCj8QbEbb1jvwA
	 A8qIsu6H+ik/8g1IsZUb5MfVGjvmRn16Zzc5ac/D9SkNsdEql7bfER/G0XjV/fEYPH
	 8CPHTWoAU7Vse7YZV8Ex5i9AgQqQB1OBSDPIy5xQqusu1t6YtnsKjS8Ri2IT9UxbRT
	 9tdrXfpsTaoSg==
From: Lee Jones <lee@kernel.org>
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Dzmitry Sankouski <dsankouski@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250123-starqltechn_integration_upstream-v17-0-8b06685b6612@gmail.com>
References: <20250123-starqltechn_integration_upstream-v17-0-8b06685b6612@gmail.com>
Subject: Re: [PATCH v17 0/7] Add support for Maxim Integrated MAX77705 PMIC
Message-Id: <174006961563.882548.1668950876404410080.b4-ty@kernel.org>
Date: Thu, 20 Feb 2025 16:40:15 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-510f9

On Thu, 23 Jan 2025 18:04:25 +0300, Dzmitry Sankouski wrote:
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
> 
> [...]

Applied, thanks!

[1/7] dt-bindings: power: supply: add maxim,max77705 charger
      commit: af280f29f32c885942f67edacfeae7d9b6e897a4
[2/7] dt-bindings: mfd: add maxim,max77705
      commit: 2ae4ffff28bf48a7144591eed7081f746b98e130
[3/7] power: supply: max77705: Add charger driver for Maxim 77705
      commit: a6a494c8e3ce1fe84aac538b087a4cab868ed83f
[4/7] mfd: simple-mfd-i2c: Add MAX77705 support
      commit: 7b591ef98b3fc1ce20c3ccb86715429b72e2e6f0
[5/7] mfd: Add new driver for MAX77705 PMIC
      commit: c8d50f029748b73313838b64b829992b66ccb704
[6/7] input: max77693: add max77705 haptic support
      commit: eb79f3a5a51a1f484e2570d983dc9d8217e8f912
[7/7] leds: max77705: Add LEDs support
      commit: aebb5fc9a0d87916133b911e1ef2cc04a7996335

--
Lee Jones [李琼斯]


