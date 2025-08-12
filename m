Return-Path: <linux-pm+bounces-32224-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD50B22551
	for <lists+linux-pm@lfdr.de>; Tue, 12 Aug 2025 13:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66B0E564BF3
	for <lists+linux-pm@lfdr.de>; Tue, 12 Aug 2025 11:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3252EFD94;
	Tue, 12 Aug 2025 11:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8vYU/q0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ECD2EFD8C;
	Tue, 12 Aug 2025 11:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754996742; cv=none; b=hr/d7n8063eSEEju+knQyiVTdVZeKj9Mj8fbcWBdX2YfZ7toyQGW1B0FtC1dyBT8ua4mMMggMYnte2KaoJMmMxOId54LMY6xxofnBhteOLBX8fTHHYyiRQJ3HKkmGWJsNzOsyDpjUooJY1Bf5xcWEe3nAhzZRveXBkmZLh/BGVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754996742; c=relaxed/simple;
	bh=jxTjEnHMPmG/BlK3tUeUzJ7ztWZxZ6PlYKzdAUEeXPs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cW9a8SiJwCidM3k1pn7SZTUPVCs5YaJ1tuMX9IJUB70WxvWJ6o9cwAG0U4EsRGiWbQlGSvKwWFoXxH1O480urvcTfCyjb6Q3Qy1u0fd37yLHPB/q0kUqTAOvoJUKZaHcJ+rZMH4rYNgyytx0TonlfATBXTxVPYjS5jdnzPuR02Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8vYU/q0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853C4C4CEF4;
	Tue, 12 Aug 2025 11:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754996742;
	bh=jxTjEnHMPmG/BlK3tUeUzJ7ztWZxZ6PlYKzdAUEeXPs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=P8vYU/q0NEUim5xP4qaa7JJH6ed2uJcE0DvoTEx+DYq17cfY8JeAY3YZrF1MruKuo
	 jc9L88hfparqYQth3xaLv//o0sLtxi9Jmp8HRLYh+uuTaBzHnlTp2O694si6apnOhs
	 I2Z2B9iB1YS2WmT8TU7YUaASrlDNQrktlcoTjK+QdmrygNJ78AHVFyRor4hlaRSqbu
	 B1C63NqZgQ0Ra4W9TVrmVTWU4ueIMFA88Ls6dzLOuLFzK3vtqTe0b5ABpv3xTnn9VD
	 2nEa2QO+TsvsjfnN5mYhOFdqwnimL++x+uycDnQpVgEH0clp+h7j4lODHVKqQq2nXi
	 ZAjILq64EkUeA==
From: Mark Brown <broonie@kernel.org>
To: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Paul Cercueil <paul@crapouillou.net>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org
In-Reply-To: <20250807214459.4173892-1-robh@kernel.org>
References: <20250807214459.4173892-1-robh@kernel.org>
Subject: Re: [PATCH] regulator: dt-bindings: Clean-up active-semi,act8945a
 duplication
Message-Id: <175499674028.16220.7731759072204819862.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 12:05:40 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Thu, 07 Aug 2025 16:44:57 -0500, Rob Herring (Arm) wrote:
> The active-semi,act8945a binding is documented in multiple places. The
> charger child node is documented in regulator/active-semi,act8945a.yaml
> and power/supply/active-semi,act8945a-charger.yaml. An old text binding
> is in mfd/act8945a.txt.
> 
> Update the regulator/active-semi,act8945a.yaml with the additional
> descriptions and constraints from
> power/supply/active-semi,act8945a-charger.yaml, and then remove it and
> mfd/act8945a.txt.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: dt-bindings: Clean-up active-semi,act8945a duplication
      commit: a54ef14188519a0994d0264f701f5771815fa11e

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


