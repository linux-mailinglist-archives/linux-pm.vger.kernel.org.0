Return-Path: <linux-pm+bounces-24194-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86688A65572
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 16:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437291895BEE
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 15:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958A4248166;
	Mon, 17 Mar 2025 15:21:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2C42475C2;
	Mon, 17 Mar 2025 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742224868; cv=none; b=ioHon6abxnSY53mngZrHECcTV06Dd0HYokdZhQWoP6wzx/3kz+tgEfZKmcCm6Hi0SEQoNh7IBVVloFtQb6jFXdcfgVRUaTSX/Kp5j8BILju19ZrQi1A4p+PamBwi1d5DfUFpwOOprXubVYxmPmRNhNwmSzPriqKfyZTTXGmStMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742224868; c=relaxed/simple;
	bh=Ea0UjlDUrTa7QdhlEmnGtepRWK9bK6m13zCCX0Ct540=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uYsnIStnyl5re9EKzJRP2M+QTiepx0kKLI0PXUTFunCRRz5EDFEe/+M6g4UQ1vAerazWOPjvzke0cwrZ8ZOLVPu4bACU8g67aBHsG/Xj7cWABNCkIz3DfrSNA0ki08DiAZFJ8YZtBv8fJKLK82vrsNKQG4BfPY89sr9GGKDTLc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A97C4CEE9;
	Mon, 17 Mar 2025 15:21:07 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 37269180829; Mon, 17 Mar 2025 16:21:04 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Artur Weber <aweber.kernel@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht
In-Reply-To: <20250316-max77693-charger-input-threshold-fix-v1-1-2b037d0ac722@gmail.com>
References: <20250316-max77693-charger-input-threshold-fix-v1-1-2b037d0ac722@gmail.com>
Subject: Re: [PATCH] power: supply: max77693: Fix wrong conversion of
 charge input threshold value
Message-Id: <174222486420.175368.1264786366288548105.b4-ty@collabora.com>
Date: Mon, 17 Mar 2025 16:21:04 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sun, 16 Mar 2025 21:11:49 +0100, Artur Weber wrote:
> The charge input threshold voltage register on the MAX77693 PMIC accepts
> four values: 0x0 for 4.3v, 0x1 for 4.7v, 0x2 for 4.8v and 0x3 for 4.9v.
> Due to an oversight, the driver calculated the values for 4.7v and above
> starting from 0x0, rather than from 0x1 ([(4700000 - 4700000) / 100000]
> gives 0).
> 
> Add 1 to the calculation to ensure that 4.7v is converted to a register
> value of 0x1 and that the other two voltages are converted correctly as
> well.
> 
> [...]

Applied, thanks!

[1/1] power: supply: max77693: Fix wrong conversion of charge input threshold value
      commit: 30cc7b0d0e9341d419eb7da15fb5c22406dbe499

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


