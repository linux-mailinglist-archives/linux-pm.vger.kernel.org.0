Return-Path: <linux-pm+bounces-29238-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71749AE325C
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 23:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E185816EE5C
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 21:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D16019DF61;
	Sun, 22 Jun 2025 21:31:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DFCC2E0;
	Sun, 22 Jun 2025 21:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750627900; cv=none; b=PrMfZXa4zKtxNuD5gP6WCjsp+ApiwLBi85Za+FQ8cJwF9ve+FLmi46FsAoS+45A8X4pAC/Jx0deEzrCb0nerbI47+VMdw7rLSfBwfkoYRU7uxfqmhb7oQCWb08jQnYLM4atUKhgoHeVWjXm9W5Fy/ZWCgDOtreMiaCVxdfciJPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750627900; c=relaxed/simple;
	bh=7E3Y0LSEYBo7dVjkUIGsJwgTo0QCZKRB7bfj4EJFEjk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HQdstNYYb34jeMqfSNjlOat3EN+zVeL0FqFKcb5nxCIkalAXmjqxwW4gYQ9OEGTBA2+lSFroTwb9NqlpvgwB1pF34JUxgCV7vVLlpDavFCq8H+pkLUK8LHuOj+J3VI3ysBZPE5fgd9DssIB/9EBcqt12VU8bDoGSG5LFJAtrJPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80AD4C4CEE3;
	Sun, 22 Jun 2025 21:31:39 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 7CAAE180958; Sun, 22 Jun 2025 23:31:37 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Thomas Antoine <t.antoine@uclouvain.be>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org
In-Reply-To: <20250523-b4-gs101_max77759_fg-v4-0-b49904e35a34@uclouvain.be>
References: <20250523-b4-gs101_max77759_fg-v4-0-b49904e35a34@uclouvain.be>
Subject: Re: (subset) [PATCH v4 0/5] Google Pixel 6 (oriole): max77759 fuel
 gauge enablement and driver support
Message-Id: <175062789749.296878.8897572566383047929.b4-ty@collabora.com>
Date: Sun, 22 Jun 2025 23:31:37 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 23 May 2025 14:51:43 +0200, Thomas Antoine wrote:
> The Google Pixel 6 has a Maxim MAX77759 which provides a fuel gauge with
> an interface with a lot in common with the Maxim max1720x.
> 
> Modify the Maxim MAX1720x driver to be compatible with the Maxim MAX77759
> and enable it for the gs101-oriole board.
> 
> The voltage, current, capacity, temperature and charge have all been
> tested and show coherent results. The charge full design and capacity
> equal the ones seen on android, the ratio between average charge and
> average current does predict pretty accurately the time to empty under
> a constant workload and temperature is coherent with the dynamic state
> of the device.
> 
> [...]

Applied, thanks!

[1/5] power: supply: max1720x correct capacity computation
      commit: 58ae036172b5f051a19a32eba94a3e5eb37bf47e

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


