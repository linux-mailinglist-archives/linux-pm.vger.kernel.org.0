Return-Path: <linux-pm+bounces-34095-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E195B477C3
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 23:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B39D5A2DE5
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 21:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD13F29AAFD;
	Sat,  6 Sep 2025 21:49:48 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFF1315D3C;
	Sat,  6 Sep 2025 21:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757195388; cv=none; b=apA8PhVBtVXngaQBmd0MMByWVmrJ17NHbR1Pf+0kZx3gwE/VMRjvxbe6ad6OjjpRJG3GuVpWGlQVJiGgUtCv2RjTW8HvLuqVSqeC+kG6uYgnWF4qbYwpis6hC/X2TfCc/S29MJbqmay4OsE02e1kaCV7A4Y8HYrBhsRbB8zRQUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757195388; c=relaxed/simple;
	bh=kh46p3M5mF+h7MiV9MxgvUyYDsR/wb/jA3QYFBFh+BM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HsaBmBcAYIVPPFhBKf9YgSoOJSq603zvgvtq5J/VfKy6rBXoqc+X92BYlDSVOen7zcQUQBPnXoKsaAx1rPzGN85ixZJiXwgTdv4Lwg0njGl3k0VoxGOjq+q0RfRBjTKDYzXDL/krNfkmFZuuQq1zVp2uUYxN3ksxtdDBLBMCgcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ECFCC4CEE7;
	Sat,  6 Sep 2025 21:49:47 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 3477E180B21; Sat, 06 Sep 2025 23:49:45 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, matthias.bgg@gmail.com, 
 angelogioacchino.delregno@collabora.com, Xichao Zhao <zhao.xichao@vivo.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250820040441.124894-1-zhao.xichao@vivo.com>
References: <20250820040441.124894-1-zhao.xichao@vivo.com>
Subject: Re: [PATCH] power: supply: Remove the use of dev_err_probe()
Message-Id: <175719538519.47657.1623934291535812529.b4-ty@collabora.com>
Date: Sat, 06 Sep 2025 23:49:45 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 20 Aug 2025 12:04:41 +0800, Xichao Zhao wrote:
> The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
> Therefore, remove the useless call to dev_err_probe(), and just
> return the value instead.
> 
> 

Applied, thanks!

[1/1] power: supply: Remove the use of dev_err_probe()
      commit: c3a49515225e44b2593839a4b3fec70c39dc0c89

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


