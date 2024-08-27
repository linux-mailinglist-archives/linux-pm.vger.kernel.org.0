Return-Path: <linux-pm+bounces-12990-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7740F9614CF
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 18:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04579B233D8
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 16:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5722E1D175C;
	Tue, 27 Aug 2024 16:58:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5A41D1752;
	Tue, 27 Aug 2024 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724777922; cv=none; b=K2NKarsrx6UGE3sEHsqfBHnRK775h/kvk77fi8msCw6qyPvkdEUGnAcFwBbg0pyhjZssYdyycH2/GiuaCHVa28o3pampk8gphcJREIhcvPGzW9v6kz524mK+WiDLnvRsfToirpt2zaGQGP7zSLfW6Blc37LlC9SkXe0ofmerg6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724777922; c=relaxed/simple;
	bh=AMpF/bcnC9x+huyvXTFfIjbRkVuqFI61cCRkIaQw+Lo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ipHK5YuZsibTjtK/JwuaxHlA6zGalfm9EAnvKqCPHKQ1IZqKhUkaoR1a7lDff0W9KqyESc4LwGuVcSa0jbKfO3smonCt8j8L9Yvkn3nrhK/3c+BYUitkJi8n/lllxRjVGvjI6PT5QHCNp82mecdOSupQhLnFFt1BYgF66q6BYI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B7BC4FE08;
	Tue, 27 Aug 2024 16:58:41 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 8F99810604BD; Tue, 27 Aug 2024 18:58:39 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Hans de Goede <hdegoede@redhat.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Sebastian Reichel <sre@kernel.org>, 
 Anton Vorontsov <anton.vorontsov@linaro.org>, 
 Ramakrishna Pallala <ramakrishna.pallala@intel.com>, 
 Dirk Brandewie <dirk.brandewie@gmail.com>, 
 Artur Weber <aweber.kernel@gmail.com>
Cc: Henrik Grimler <henrik@grimler.se>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
In-Reply-To: <20240817-max17042-soc-threshold-fix-v1-1-72b45899c3cc@gmail.com>
References: <20240817-max17042-soc-threshold-fix-v1-1-72b45899c3cc@gmail.com>
Subject: Re: [PATCH] power: supply: max17042_battery: Fix SOC threshold
 calc w/ no current sense
Message-Id: <172477791953.367469.12003415047436890038.b4-ty@collabora.com>
Date: Tue, 27 Aug 2024 18:58:39 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Sat, 17 Aug 2024 12:51:14 +0200, Artur Weber wrote:
> Commit 223a3b82834f ("power: supply: max17042_battery: use VFSOC for
> capacity when no rsns") made it so that capacity on systems without
> current sensing would be read from VFSOC instead of RepSOC. However,
> the SOC threshold calculation still read RepSOC to get the SOC
> regardless of the current sensing option state.
> 
> Fix this by applying the same conditional to determine which register
> should be read.
> 
> [...]

Applied, thanks!

[1/1] power: supply: max17042_battery: Fix SOC threshold calc w/ no current sense
      commit: 3a3acf839b2cedf092bdd1ff65b0e9895df1656b

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


