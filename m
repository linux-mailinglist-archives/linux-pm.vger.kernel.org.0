Return-Path: <linux-pm+bounces-26301-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F742A9E50B
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 00:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A7617AB563
	for <lists+linux-pm@lfdr.de>; Sun, 27 Apr 2025 22:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B55E1F872A;
	Sun, 27 Apr 2025 22:50:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA2FCA5A;
	Sun, 27 Apr 2025 22:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745794219; cv=none; b=Cu+z5AeMPsOPMd1l5T3S34gLE+FEVxIErlA/AFs8i5Ss53XSwdkiorD2NUWDiorJ85/+BfeiU8owLXb3sXPni/OK539zg2xBZxrLOyhMV8IvphBwY3wBo3aomgbvaILSgQIV9/8CA9LOq3b0sOsid0pKqykWAme29VZwR3HM47k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745794219; c=relaxed/simple;
	bh=5aEq1QPIGztKU2UH0UG2ljvohKb3aCC/THa7DUSt13w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pXisqQihreVXC5KxH20EF7a/bOGV4UXxQ3BJ1sV24L7NTps3ubbKaQxkCZ8UqNmS5FJUNadQwd9jakRjCc3muFOJoukjlBnnfxOxstyXpId2A6OSHCdnJZNW2V2pz6txrPKu+VnQZbkrPV24t2y73zLpdAvth7YDWUmzl8q+y/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51DEC4AF0C;
	Sun, 27 Apr 2025 22:50:18 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id BC6C4180F9A; Mon, 28 Apr 2025 00:50:16 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250307-reboot-mode-chars-v1-1-d83ff95da524@linaro.org>
References: <20250307-reboot-mode-chars-v1-1-d83ff95da524@linaro.org>
Subject: Re: [PATCH] power: reset: reboot-mode: better compatibility with
 DT (replace ' ,/')
Message-Id: <174579421676.295785.14214055614630227030.b4-ty@collabora.com>
Date: Mon, 28 Apr 2025 00:50:16 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2


On Fri, 07 Mar 2025 07:50:18 +0000, André Draszik wrote:
> This driver's purpose is to parse boot modes described in DT, via key
> (node name) / value pairs, and to match them to a reboot mode requested
> by the kernel. Unfortunately, DT node names can not contain certain
> characters, like space ' ' or comma ',' or slash '/', while the
> requested reboot mode may.
> 
> This is a problem because it makes it impossible to match reboot modes
> containing any of those characters.
> 
> [...]

Applied, thanks!

[1/1] power: reset: reboot-mode: better compatibility with DT (replace ' ,/')
      commit: ca3d2ea52314286dda597f03b07ed759c5798fba

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


