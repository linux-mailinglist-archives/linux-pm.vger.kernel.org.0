Return-Path: <linux-pm+bounces-34096-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D14E7B477C6
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 23:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D427E7B3362
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 21:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630C52BE7B5;
	Sat,  6 Sep 2025 21:51:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458E6285060;
	Sat,  6 Sep 2025 21:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757195464; cv=none; b=bU4w745vCPegok8PhmpITCVEXEwQeLTvSc779tWB+IMRvCuwX+c2kyyevo16yVWYbukfDnzF8IY8vt8dwcMEFTGj1ExOuxowfRboQVPm+UcZSBXBkZcCzoZPKmfbIjGlxUyfc8CpLnBS3y6VeSDcPwPiUbB5i1DxPSzDgqCR8G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757195464; c=relaxed/simple;
	bh=c36v2YAhmGxDyr29eY7i/oLPsNSUdtg50OMq07ciEx0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XHGquoFmEk5ofW9Odw/5pL7bPE2RImwLQiUh8hWzneyO04FwcBTLAKhAJBpolGyZ/HA8Xw+xm6GRL6fJQD1/k7kQPEtqGrYwbDhPnPukeKZmXvylbQQsxbIjp245oKVXFxFiYkwiS+Rg1gTGOyy/GgUuHVRtIs5iPFljT4fu+mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE9BC4CEE7;
	Sat,  6 Sep 2025 21:51:03 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id B113F180B21; Sat, 06 Sep 2025 23:51:01 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, Andy Yan <andyshrk@163.com>
Cc: t.schramm@manjaro.org, zheyuma97@gmail.com, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
In-Reply-To: <20250818123303.334853-1-andyshrk@163.com>
References: <20250818123303.334853-1-andyshrk@163.com>
Subject: Re: [PATCH] power: supply: cw2015: Fix a alignment coding style
 issue
Message-Id: <175719546171.49763.1408095570981526175.b4-ty@collabora.com>
Date: Sat, 06 Sep 2025 23:51:01 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 18 Aug 2025 20:32:59 +0800, Andy Yan wrote:
> Fix the checkpatch warning:
> CHECK: Alignment should match open parenthesis
> 
> 

Applied, thanks!

[1/1] power: supply: cw2015: Fix a alignment coding style issue
      commit: def5612170a8c6c4c6a3ea5bd6c3cfc8de6ba4b1

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


