Return-Path: <linux-pm+bounces-26498-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAB3AA580C
	for <lists+linux-pm@lfdr.de>; Thu,  1 May 2025 00:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E9819A534D
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 22:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99E7226161;
	Wed, 30 Apr 2025 22:43:16 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F65322541B;
	Wed, 30 Apr 2025 22:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746052996; cv=none; b=l0tqKSnCbRfrgwzZrkB8L1c4e6nAEFeIin+nkybLic7T+jXvBuR6b/ctWXv3AtUJgSthct71PZY+yvUfbq84dJ/isz2RAHIJUWS7N5eBwGv7lhD0NMe6Mmndn7ptTHDBrlz0ebXjpaGrMmoIv50dVUrXW5gyLGryWC8hA6Mqxow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746052996; c=relaxed/simple;
	bh=pIwNlWtaVBN17takgzJoWXc8K61/U+c3hvfD6D2p0Wo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LLl5LNWFOnv7Cj58o/JkngNkXFmNJ0q/MZkHfsqfw3kXd5ZPgb740fr8pnhYGQIeyvrGGoi1nby5xs+ArSXnM9iXrp7ynCzDLuM5BjPy6mIZU05QtvufdWpI9JYEnaRFBWg9JjvgmW9GSjYGm4h7I8jlEwa1vCglDms8OsyXlrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9321C4CEE9;
	Wed, 30 Apr 2025 22:43:15 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id D2547180F6A; Thu, 01 May 2025 00:43:13 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org
In-Reply-To: <20250401-syscon-reboot-reset-mode-v5-0-5b9357442363@linaro.org>
References: <20250401-syscon-reboot-reset-mode-v5-0-5b9357442363@linaro.org>
Subject: Re: [PATCH v5 0/2] support Linux reboot modes in syscon-reboot on
 gs101 (Google Pixel)
Message-Id: <174605299385.111219.3051568976508089270.b4-ty@collabora.com>
Date: Thu, 01 May 2025 00:43:13 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2


On Tue, 01 Apr 2025 11:11:01 +0100, André Draszik wrote:
> This series updates syscon-reboot to support warm/soft and cold/hard
> reboot on gs101-based boards (Google Pixel 6 and Pixel 6 Pro).
> 
> Linux supports a couple different reboot modes, but syscon-reboot
> doesn't distinguish between them and issues the same syscon register
> write irrespective of the reboot mode requested by the kernel.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: reset: syscon-reboot: add google,gs101-reboot
      commit: 1495c1aa4447f64c1e2209a95b201cb6452bb775
[2/2] power: reset: syscon-reboot: add gs101-specific reset
      commit: 8c7cf0fc8cf5f5dee66d767655e06e190e6f2881

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


