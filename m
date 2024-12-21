Return-Path: <linux-pm+bounces-19633-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CD09FA17C
	for <lists+linux-pm@lfdr.de>; Sat, 21 Dec 2024 16:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95531664C7
	for <lists+linux-pm@lfdr.de>; Sat, 21 Dec 2024 15:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E92A13B288;
	Sat, 21 Dec 2024 15:55:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA576335BA
	for <linux-pm@vger.kernel.org>; Sat, 21 Dec 2024 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734796526; cv=none; b=KrqiyGxzkrUuolxun2JbG34NPLoJni+wXjd0gNdDDeDOY3GDDA2IdunK7EfOLYaLWg65F00nQXy/Jm/zJOh8PU8X5rxvW7AIclGsCXJ9FScVzIVkIkMN4nJeMLJwGIuOfj/dGaSTQbZmJNWJdeOuHxeAgbYgCMtecSQXXS2hi34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734796526; c=relaxed/simple;
	bh=GL3rxMTNWqgI+3+pZ/zxUXfS+CGjJRyuBYg4uY0NBHU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VgfUsg+KMndD5PwhHYqrbCj3SRqDXD+QN2RSwtVhpvHNVRXMMq27OFTihBQ8X8s++fV1kNZCK+YyYZuFImnA09v8lUkdVmUHA3GSOSeYNNNixr/34Ze1jtBzyjKnkH+GvqEAvTzEsmE/WEzvMYdfloh/D4I3OjCQqaJgMWPlTI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5547DC4CECE;
	Sat, 21 Dec 2024 15:55:25 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 28E0A1060349; Sat, 21 Dec 2024 16:55:23 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc: linux-pm@vger.kernel.org
In-Reply-To: <20241215172133.178460-1-hdegoede@redhat.com>
References: <20241215172133.178460-1-hdegoede@redhat.com>
Subject: Re: (subset) [PATCH 0/8] power: supply: Add adc-battery-helper lib
 and Intel Dollar Cove TI CC battery driver
Message-Id: <173479652315.3359875.9667360404409275255.b4-ty@collabora.com>
Date: Sat, 21 Dec 2024 16:55:23 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sun, 15 Dec 2024 18:21:23 +0100, Hans de Goede wrote:
> Here is a patch-series which primary goal is to add support for
> using the coulomb-counter in the Intel Dollar Cove TI PMIC as
> battery power-supply class device.
> 
> This PMIC used on some Intel Bay/Cherry Trail systems has some builtin
> fuel-gauge functionality which just like the UG3105 fuel-gauge is not
> a full featured autonomous fuel-gauge.
> 
> [...]

Applied, thanks!

[1/8] power: supply: Use power_supply_external_power_changed() in __power_supply_changed_work()
      commit: 04d9741493e7a1d17d2109f4c9ea21f3314666b4
[3/8] power: supply: ug3105_battery: Let the core handle POWER_SUPPLY_PROP_TECHNOLOGY
      commit: db9d8eca3dc97d8d91d5e3fd878fb0bd0d8346d6

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


