Return-Path: <linux-pm+bounces-29216-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AC2AE2DB6
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 03:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF6E16E9B8
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 01:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514C81F16B;
	Sun, 22 Jun 2025 01:01:14 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323BAC2FA;
	Sun, 22 Jun 2025 01:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750554074; cv=none; b=Cb/Z94iycEm3YGkbAYrWEM9yFjWj1na6ZK60jkXtwNFNPrtCqG0k08Hf6QBMJ75Nj7AGVWvkuFhhWqx2n5Moc8tO6yQFBhAjM4Pj3mR52Tz8A+G2cFM/v7VL1K3PTKUSfX9VxApqI5APW+jBV9AWgEJQUHFmwTe3e3E5R/7Yuqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750554074; c=relaxed/simple;
	bh=P010spSmYkMZxKdAqRbWTUbulxYjSNTI24eRNhFhjVI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n8tk0KDFqn/Gajk0KXeRL3P0FnPMhOU91tLBRaul8mR9GF2AVCnDbTfR3NBDYr6feJXG2sko1KJViu+3VCsMkS17iNwwOX+dKjyGhBp4SzWeTlVWh0X0LvYGILv/Z1G6wn+prDzJ5GmCs9qu94hmfWDDAzG1D6mZ1feZCSCjZtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8A1C4CEE7;
	Sun, 22 Jun 2025 01:01:13 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id B739E1806CD; Sun, 22 Jun 2025 03:01:11 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Taeyoung Kwon <xoduddk12345@gmail.com>
Cc: Taeyoung Kwon <Taeyoung.Kwon@telit.com>
In-Reply-To: <20250521131116.2664-1-Taeyoung.Kwon@telit.com>
References: <20250521131116.2664-1-Taeyoung.Kwon@telit.com>
Subject: Re: [PATCH v2] power: reset: qcom-pon: Rename variables to use
 generic naming
Message-Id: <175055407172.235949.3307469133347651788.b4-ty@collabora.com>
Date: Sun, 22 Jun 2025 03:01:11 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 21 May 2025 13:09:52 +0000, Taeyoung Kwon wrote:
> The qcom-pon driver was originally implemented for the PM8916 PMIC, and
> as a result, several internal variable names still refer to 'pm8916'.
> However, the driver has since been extended to support other PMICs as
> well.
> 
> This patch renames those variables to use more generic and consistent
> names, improving clarity and reducing confusion for non-PM8916 devices.
> 
> [...]

Applied, thanks!

[1/1] power: reset: qcom-pon: Rename variables to use generic naming
      commit: e4ab1bfc3fe92ef5f8cebcc17963a08955963995

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


