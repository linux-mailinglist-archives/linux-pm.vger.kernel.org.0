Return-Path: <linux-pm+bounces-19545-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BF59F863D
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 21:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9B7818825B5
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 20:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70FB70812;
	Thu, 19 Dec 2024 20:48:17 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAAD1805E;
	Thu, 19 Dec 2024 20:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734641297; cv=none; b=AD9fsFKIFu5wHjAz6h19q2X5WQ87OW4kqaS2/SXzaa2La4Rb6olBJ+7l2IXaNSKjad7DVOPz6jyZIF1mR2XZTR2li7sKN+fS33wHCvpRf2QQMuw8Bj6DOUX4wTk90jKxvo/6bbMdMcqbbTtnZ64wncnsAJDc2nPeXmxDGf2eLcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734641297; c=relaxed/simple;
	bh=C04r9f7Utc19twHZO1R7UnAG0DaSsbGMpQoYS/fXENo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tZCOnlcdxy1REK+7WlUS37gWAkLIHsYQVZftJx3O+Y2vK4om72j3DhzRMc+NjyMw/hwcVcggSVEjbk2iGVump49ODHihLnBBYbVtJEp2GVpcMD5i4GMXaVgDYk+F3wzS09RqPiPGxx2RqmsQ2i/6mlNoML1qFLvMrqBdLECWXm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E772DC4CECE;
	Thu, 19 Dec 2024 20:48:16 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 32DAA1060348; Thu, 19 Dec 2024 21:48:14 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
In-Reply-To: <20241219-psy-extensions-sysfs-v1-1-868fc6cb46d6@weissschuh.net>
References: <20241219-psy-extensions-sysfs-v1-1-868fc6cb46d6@weissschuh.net>
Subject: Re: [PATCH] power: supply: core: fix build of extension sysfs
 group if CONFIG_SYSFS=n
Message-Id: <173464129414.3186079.9692868550504208106.b4-ty@collabora.com>
Date: Thu, 19 Dec 2024 21:48:14 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2


On Thu, 19 Dec 2024 15:28:18 +0100, Thomas Weißschuh wrote:
> Add and use wrapper functions for the sysfs interaction.
> Restore the compatibility of CONFIG_POWER_SUPPLY=y and CONFIG_SYSFS=n.
> 
> 

Applied, thanks!

[1/1] power: supply: core: fix build of extension sysfs group if CONFIG_SYSFS=n
      commit: 21096800c5ac634a9fbbac21505bfd798163b390

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


