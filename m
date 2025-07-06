Return-Path: <linux-pm+bounces-30225-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CD6AFA83B
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 01:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C53D1899D6E
	for <lists+linux-pm@lfdr.de>; Sun,  6 Jul 2025 23:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBD31DF244;
	Sun,  6 Jul 2025 23:04:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027291311AC;
	Sun,  6 Jul 2025 23:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751843082; cv=none; b=iOwZyDSN9Ir5w26xPN+pQs3eOu1iftlcstlPwH1D6DWlc0Yf97jAnVYq1YZuTID3wW+1C+TCGKer1ECeGGDx9SS9Pt3xds4dITd+Nbh2hRaYh9nEXwGK+rUJw/LmqE3PwAiJI8xFis2tIK8P+1RsEVQxKmyUkWOi44OODwPutN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751843082; c=relaxed/simple;
	bh=FmUHLPC78N0osvQilGaMbd8BWV/yhRBwcLx/JLasVCo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V8kBs2nNmZyaRlX7UMbS/+4Rnyi8cYBGhWqnVNYCKG3jBDOt9GqELmbC8IiYQrXema/HjeUyRUsOcntoiMonU0UJlooXSvGTRy0RtSHRk3a95iiO+pGdYz+6QUe0r8cLH5SpNhszeI/nfifzL+T5IkQwCItL79ei76eY6DZzlhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62496C4CEED;
	Sun,  6 Jul 2025 23:04:41 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 491A7180F17; Mon, 07 Jul 2025 01:04:39 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
In-Reply-To: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
Subject: Re: (subset) [PATCH 00/80] treewide: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-Id: <175184307927.139015.14590076333078183263.b4-ty@collabora.com>
Date: Mon, 07 Jul 2025 01:04:39 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 04 Jul 2025 10:52:25 +0300, Sakari Ailus wrote:
> Late last year I posted a set to switch to __pm_runtime_mark_last_busy()
> and gradually get rid of explicit pm_runtime_mark_last_busy() calls in
> drivers, embedding them in the appropriate pm_runtime_*autosuspend*()
> calls. The overall feedback I got at the time was that this is an
> unnecessary intermediate step, and removing the
> pm_runtime_mark_last_busy() calls can be done after adding them to the
> relevant Runtime PM autosuspend related functions. The latter part has
> been done and is present in Rafael's tree at the moment, also see
> <URL:https://lore.kernel.org/linux-pm/CAJZ5v0g7-8UWp6ATOy+=oGdxDaCnfKHBG_+kbiTr+VeuXZsUFQ@mail.gmail.com/>:
> 
> [...]

Applied, thanks!

[54/80] power: supply: bq24190: Remove redundant pm_runtime_mark_last_busy() calls
        commit: 2453753f395e68af947d9ac6ce37bf0eb40f7123
[55/80] power: supply: twl4030_charger: Remove redundant pm_runtime_mark_last_busy() calls
        commit: f9335bb4f5d4f3b913efd5872c2794d027dd85a6

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


