Return-Path: <linux-pm+bounces-23663-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AB1A576F5
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 01:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3922189AF1A
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 00:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C2779D2;
	Sat,  8 Mar 2025 00:38:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F3D4C62;
	Sat,  8 Mar 2025 00:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741394299; cv=none; b=PE4DyZSAMnPvLmShEBOCUMAOgVPBsY8LOjDIdLZwRSln+yOkLfUEJTmIPXP8jdVisOpkWYGhuHkW5jFQDIVjfKEJNidP8anGaRq0Fg7jJ5kHxZwmFSqTL9HnfNcxkzMJ2Q8MvktTHxyjgSN8b6AMU/opcDgrkZRuhfBzV4wtLwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741394299; c=relaxed/simple;
	bh=4oGa+nKn7tM/EDKaaKrGLPPr4naWpF6v11LWCUxNi64=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QkNLPTqd5RSLEHwM/cDvdd1Jc/2KWfZcE3mik5f9YWan975c+ef3VV02+H1XrkJEBY7VZnT6KHE5MV3BlNA5dwx0MejHQMiXXQKuEMYExPJq9lmdEPMEqGgT8Ls4qMN3SFQhDAf33EL3S3v4yXcm7xByNFwaMq+YTUu/37kArw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868BCC4CED1;
	Sat,  8 Mar 2025 00:38:18 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 79362180B97; Sat, 08 Mar 2025 01:38:16 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, mazziesaccount@gmail.com, Bo Liu <liubo03@inspur.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250228080236.2759-1-liubo03@inspur.com>
References: <20250228080236.2759-1-liubo03@inspur.com>
Subject: Re: [PATCH 0/9] power: supply: convert to use maple tree register
 cache
Message-Id: <174139429646.169744.34639270959899665.b4-ty@collabora.com>
Date: Sat, 08 Mar 2025 01:38:16 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 28 Feb 2025 03:02:27 -0500, Bo Liu wrote:
> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
> 
> Bo Liu (9):
>   power: supply: bd99954: convert to use maple tree register cache
>   power: supply: bq24257: convert to use maple tree register cache
>   power: supply: bq2515x: convert to use maple tree register cache
>   power: supply: bq25890: convert to use maple tree register cache
>   power: supply: bq25980: convert to use maple tree register cache
>   power: supply: ltc4162l: convert to use maple tree register cache
>   power: supply: max1720x: convert to use maple tree register cache
>   power: supply: rt9455: convert to use maple tree register cache
>   power: supply: smb347: convert to use maple tree register cache
> 
> [...]

Applied, thanks!

[1/9] power: supply: bd99954: convert to use maple tree register cache
      commit: 0857367003bcf3038098cc8577ffd4fff3874bc7
[2/9] power: supply: bq24257: convert to use maple tree register cache
      commit: 6d166a69863fc36a1db8b85a016ceea25b20a082
[3/9] power: supply: bq2515x: convert to use maple tree register cache
      commit: 71a7627d3a1c3234fddcb0160e171ddc96ec06e4
[4/9] power: supply: bq25890: convert to use maple tree register cache
      commit: 21153cf9a79afcdba7ca1d563f8a1737c928b4e9
[5/9] power: supply: bq25980: convert to use maple tree register cache
      commit: f8be87583c124b2aecc90f5ee542eb9f52eac7ab
[6/9] power: supply: ltc4162l: convert to use maple tree register cache
      commit: 8cf985e069ca56b72e1d6053cb0f6007d7ee9ca5
[7/9] power: supply: max1720x: convert to use maple tree register cache
      commit: dde0409a223bf3638b38b2b961fae644f94a2580
[8/9] power: supply: rt9455: convert to use maple tree register cache
      commit: af4499fb2a3fdfddd293a809a3c86e9e1b8ffa1c
[9/9] power: supply: smb347: convert to use maple tree register cache
      commit: bfa2b6370b796a3418e8d9d4bc0814a8dceea189

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


