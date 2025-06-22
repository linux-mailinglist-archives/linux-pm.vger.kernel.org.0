Return-Path: <linux-pm+bounces-29231-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB4AAE31AA
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 21:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2562418906D4
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 19:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26CD1FC0FE;
	Sun, 22 Jun 2025 19:13:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CF51F8BDD;
	Sun, 22 Jun 2025 19:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750619599; cv=none; b=Jen5svB2A4ISNHveLD0KSQOLj39DtqGvcrKpLUU6IkUVJt2TrsPqf1oFNbTPPefNrOhEYICklqhQALc9fov4BYVZsufMwgCgDX2OP8fFotsVCbGyBiu5HOVEZnTH7OCjTOMfpabNzrqGpg3AKT+79NI7HJuscj+RG5fGUy+f4eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750619599; c=relaxed/simple;
	bh=3qeHhRn0NPMyUpnXPj+s7izmuPSJ9qVI/8HvcHHTCIk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=m/fgGpxP5iUwbKABH0uaTOfYY9s2tnBQN4vl8Osw5ZERkb5EFzAjoOHTDaZllpuww6h3fX6mbE3jWRztaAppMvlJ6YmGNLldgzW+IszCO4eTnQdRdEyE/ERBrkyNJz/nF1hh1W/B/WGRLLnRj11zoNTCTgfNKshc7PkBqJBLWJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DC3C4AF0B;
	Sun, 22 Jun 2025 19:13:19 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 51F9E180959; Sun, 22 Jun 2025 21:13:17 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, philipp@uvos.xyz, Charles Han <hanchunchao@inspur.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250519024741.5846-1-hanchunchao@inspur.com>
References: <20250519024741.5846-1-hanchunchao@inspur.com>
Subject: Re: [PATCH] power: supply: cpcap-charger: Fix null check for
 power_supply_get_by_name
Message-Id: <175061959732.285737.9614627733052759738.b4-ty@collabora.com>
Date: Sun, 22 Jun 2025 21:13:17 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 19 May 2025 10:47:41 +0800, Charles Han wrote:
> In the cpcap_usb_detect() function, the power_supply_get_by_name()
> function may return `NULL` instead of an error pointer.
> To prevent potential null pointer dereferences, Added a null check.
> 
> 

Applied, thanks!

[1/1] power: supply: cpcap-charger: Fix null check for power_supply_get_by_name
      commit: d9fa3aae08f99493e67fb79413c0e95d30fca5e9

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


