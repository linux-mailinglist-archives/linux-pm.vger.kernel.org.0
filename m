Return-Path: <linux-pm+bounces-8467-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EC78D612B
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 14:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B14DB2852FF
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 12:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B431581F6;
	Fri, 31 May 2024 12:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rR3oQM7M"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC4229A0;
	Fri, 31 May 2024 12:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717156892; cv=none; b=h2z/lKkUvR59Ms7iE2raZFTtO+W+1A6p5/L6tbDsqTh0ApRYF73WfWZ3PhtP8bUZcOluCCUbR7FYsT+ayOvnX4UVC4ha7bcLPQOcjBGHI3qYi7FQNVXQCd5PFXXFuuKmCysvp0aQ/DJnVcK9oVir1z35Nj9ntLK2/q8rPozZRZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717156892; c=relaxed/simple;
	bh=oSBVMnc8DbzbnZGG0e2B5WpXzjiiLuTOa/w8WzqCncE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lI3kL/KZ9iMnY12VcnOViv/JyuWvXGqa76YjBQUR6Dsm5an28I2VgytbM2i8cj0Q1Fu1ZDIdjb2Hg2M3yNzo3ZLYHCSH4H75f1TAdNebFKHWZggVAA5ggZpt4Nj1KO/BQ14q3PmLPQUkBh0KwmbBAbwtj3uMAr8azPVjDWJuOnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rR3oQM7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02557C32786;
	Fri, 31 May 2024 12:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717156891;
	bh=oSBVMnc8DbzbnZGG0e2B5WpXzjiiLuTOa/w8WzqCncE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rR3oQM7M8Ff2U8XxWBMWgkpu+11jNcRen6mmj/Kx83Z2kr9og3HIKNUchawuh7UIr
	 jrjUDgZ5ZKCyE3JMd+F0/E8TG5yGy0eCg9fEVqgAmIuFyAQl8+SFOVHvIsFjqHtStP
	 ollrYW1wkW1b/AVpYEIgSMMN1jyi49LwIvtk94U+hKm/NUjduGib/pkQZYgHqLB98o
	 /HlE6R0dJWqROUKv10JXcdU+K741VFz9Y1Axr4BOh7tefXrGbw2IHj8DgzzaxjKrz8
	 DvxdseoTu23MTevhFLhJQpUWxXb65zedi/rI35fibhANi4prZBLkCT7tgOsMUZbIdm
	 U19P5HS1fNIGQ==
From: Lee Jones <lee@kernel.org>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andy@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
 Lee Jones <lee@kernel.org>, Kate Hsuan <hpa@redhat.com>, 
 Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc: platform-driver-x86@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
 linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
In-Reply-To: <20240531114124.45346-1-hdegoede@redhat.com>
References: <20240531114124.45346-1-hdegoede@redhat.com>
Subject: Re: [PATCH v10 0/6] KTD2026 indicator LED for X86 Xiaomi Pad2
Message-Id: <171715688820.1048514.12317802240706577541.b4-ty@kernel.org>
Date: Fri, 31 May 2024 13:01:28 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Fri, 31 May 2024 13:41:18 +0200, Hans de Goede wrote:
> Here is v10 of Kate's series to add support for Xiaomi Pad2 indicator LED,
> this is unchanged from v9 except for being rebased on top of 6.10-rc1 and
> dropping patch 7/7 since that one has been merged through the pdx86 tree.
> 
> Patch 6/6 has an Acked-by from Sebastien for merging this patch through
> the leds tree since it depends on the earlier patches.
> 
> [...]

Applied, thanks!

[1/6] leds: rgb: leds-ktd202x: Get device properties through fwnode to support ACPI
      commit: f14aa5ea415b8add245e976bfab96a12986c6843
[2/6] leds: rgb: leds-ktd202x: I2C ID tables for KTD2026 and 2027
      commit: 75bd07aef47e1a984229e6ec702e8b9aee0226e4
[3/6] leds: rgb: leds-ktd202x: Initialize mutex earlier
      commit: e1b08c6f5b92d408a9fcc1030a340caeb9852250
[4/6] leds: core: Add led_mc_set_brightness() function
      commit: 5607ca92e6274dfb85d0ff7c4e91e6c4ddb6d25c
[5/6] leds: trigger: Add led_mc_trigger_event() function
      commit: 0921a57c91648b08857b47a2f26fa7942f06120f
[6/6] power: supply: power-supply-leds: Add charging_orange_full_green trigger for RGB LED
      commit: 9af12f57f1f9785f231d31a7365ad244c656b7ff

--
Lee Jones [李琼斯]


