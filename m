Return-Path: <linux-pm+bounces-40625-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A708CD104B8
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 02:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 44A333013D6F
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 01:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2AA242D72;
	Mon, 12 Jan 2026 01:56:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4C023C51D;
	Mon, 12 Jan 2026 01:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768182966; cv=none; b=pmjdeCPLwnWce8nnPeZWX/lBnd3zSZoIbMEPyj5O4ywaj3VjTfvokV1WMpsiSa+iaIiawSdEXnVILzqICNH2fre/dRFN+Gv6i6F2veO/bwAvVWiGtkOOjStTqPg1k1ogcPU5JJscmq3zpPXfZaKw27JlMbfkz7sVOFtANZrWLJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768182966; c=relaxed/simple;
	bh=vVn02YOwsTf4/peOrg+nn0aoVxP5JH7luY+/9A4tLt0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AdsuDf2C7RjWPgx7CJK4Zbj5ryOxXN8K1be0BHBLF7RycD6OkOEJUfIjS3XcHtIpc8yjc4M0MHaWUOOJ5HU8tKwMPpwd2HYaiqvaMFTXUJ8I931rHibLjIOJndW/qFnJap5qGIKVdiJTwjmb6YfdJRIBrUSuhG4aVHv9+wZzCuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CABDC16AAE;
	Mon, 12 Jan 2026 01:56:06 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 1615D18054D; Mon, 12 Jan 2026 02:56:04 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, Alexander Koskovich <AKoskovich@pm.me>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexander Koskovich <akoskovich@pm.me>
In-Reply-To: <20251214191529.2470580-1-akoskovich@pm.me>
References: <20251214191529.2470580-1-akoskovich@pm.me>
Subject: Re: [PATCH v2] power: reset: nvmem-reboot-mode: respect cell size
 for nvmem_cell_write
Message-Id: <176818296408.643060.245834626583033588.b4-ty@collabora.com>
Date: Mon, 12 Jan 2026 02:56:04 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sun, 14 Dec 2025 19:16:18 +0000, Alexander Koskovich wrote:
> Some platforms expose reboot mode cells that are smaller than an
> unsigned int, in which cases lead to write failures. Read the cell
> first to determine actual size and only write the number of bytes the
> cell can hold.
> 
> 

Applied, thanks!

[1/1] power: reset: nvmem-reboot-mode: respect cell size for nvmem_cell_write
      commit: 36b05629226413836cfbb3fbe6689cd188bca156

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


