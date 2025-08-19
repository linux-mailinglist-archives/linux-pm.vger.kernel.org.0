Return-Path: <linux-pm+bounces-32663-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 056D4B2CD50
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 21:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CF8E3A05CF
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 19:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F8D340D95;
	Tue, 19 Aug 2025 19:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUqn8CaW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F45F2848B5;
	Tue, 19 Aug 2025 19:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755632842; cv=none; b=ttPz+WdTgvy6zQjQ0gDDapCHr1NtxTvrY5EnoenAoxSDlSb+lSDjLdI+cmGoV2R1Yr3ln8Bswqo0TKlfHEdClfNBOhbCO39bon8kt0T27LXwPxOvPs4CO8IuynyJEB69PowE9qaXGw9h2Kbg2ud+cF+A4OjPOELbEtSNuuyHhlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755632842; c=relaxed/simple;
	bh=xt/58KmllUW4lNZsXFqhBH1ZZJq+5aimby3rpZNcJdg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SeJPA0Ayn4CleIK35pbldWMlV56F9+VZ34DmysffVXbJZFh9CtmCD/vKd96bmG2qQ5rGPo/UdoKEMhSITyzvtACEW2c0HflsgqXf8lnF8TsVG/C+GQP/CVP7PrTfxWG4LYyNTYqbxjb1kVmAOAK1RhuxjPul/bCu4jrPciBm64A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUqn8CaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD48C4CEF1;
	Tue, 19 Aug 2025 19:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755632838;
	bh=xt/58KmllUW4lNZsXFqhBH1ZZJq+5aimby3rpZNcJdg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mUqn8CaWaE4SMPZxZbfC7rahyZXtouO2rtHxr05+MVrOxmKTK2laP1PnLnTl+y7gB
	 hGASK2C7PijtzP0EBlEpuVVFDm8yqvvg1p97C2QYEsELbeVSxwPF8cQ4e/agqusNXk
	 61NA+KxfhnJ2WpMWfC0xB//3dXFVI3MdqyZxZLU47E0efnoYenttSvNJVLcEmwexln
	 NDMMx+cw8f+2c4DA8Y2N+tcpCWBpqX3P5qUa7XxRWVYMWWG8oeGm5pEjX4Ut/ZIOSB
	 KYgRJp8ujPLmwX2pc06U0V8VDPgywXfk7u5t7XgCANenAkT7OeTW6qNuCrDk8tj2Tl
	 aRyywouV7c63A==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
In-Reply-To: <20250819-reg_consumer_doc-v1-1-b631fc0d35a3@gmail.com>
References: <20250819-reg_consumer_doc-v1-1-b631fc0d35a3@gmail.com>
Subject: Re: [PATCH] regulator: consumer.rst: document bulk operations
Message-Id: <175563283711.270234.11714933416308258371.b4-ty@kernel.org>
Date: Tue, 19 Aug 2025 20:47:17 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Tue, 19 Aug 2025 12:25:43 +0800, Javier Carrasco wrote:
> The current consumer documentation does not include bulk operations,
> providing an example of how to acquire multiple regulators by calling
> regulator_get() multiple times. That solution is valid and slightly
> simpler for a small amount of regulators, but it does not scale well.
> 
> Document the bulk operations to get, enable and disable regulators.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: consumer.rst: document bulk operations
      commit: ec0be3cdf40b5302248f3fb27a911cc630e8b855

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


