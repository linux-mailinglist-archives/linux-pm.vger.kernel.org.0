Return-Path: <linux-pm+bounces-24193-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 520C0A65571
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 16:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7A831731C7
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 15:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9548E2475F7;
	Mon, 17 Mar 2025 15:21:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B264246335;
	Mon, 17 Mar 2025 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742224868; cv=none; b=O7tXpJo2qeYUnkNkpHspVO6yvhyxu62iM0YyVQUknfsCosgJNa+h7y7Ditm2PdnWWPKySMyNL160q3YPXHsij7tIXGOUqO0O8s0D6Pqbv/JfNAAWlHBHDtKX3fZS6eca8ZfHpuxPXWr2yf5g//ach7UlqDOjK+FWnv6hVs8HaKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742224868; c=relaxed/simple;
	bh=JN59LT3U+vr0NDVQqlU6VmSJgkApIcvgfciI/zMXefo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pw7nzPAn3bLIHGjwANlGpPI0mYN1bGmKkrA014keT6YKFE2IYJGN0h2alQMpHjz6rg5c9pNzOj5pP7wMfiqXe3x6RYBFLe48dfo+PdyzWwfUrnXEuG22Uqs+QfEUekHDj7pVOudlJWInmchoCU3ye3C7KeELatAKBZ+T03acBts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BB3C4AF0B;
	Mon, 17 Mar 2025 15:21:07 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 3E72C18082A; Mon, 17 Mar 2025 16:21:04 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, 
 "Sicelo A. Mhlongo" <absicsz@gmail.com>
Cc: "H . Nikolaus Schaller" <hns@goldelico.com>, pali@kernel.org, 
 maemo-leste@lists.dyne.org, phone-devel@vger.kernel.org, 
 letux-kernel@openphoenux.org, akemnade@kernel.org
In-Reply-To: <20250312121712.146109-1-absicsz@gmail.com>
References: <20250312121712.146109-1-absicsz@gmail.com>
Subject: Re: (subset) [PATCH 0/2] power: supply: bq27xxx: do not report
 incorrect zero values
Message-Id: <174222486424.175368.3276216628886709609.b4-ty@collabora.com>
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


On Wed, 12 Mar 2025 14:14:07 +0200, Sicelo A. Mhlongo wrote:
> Some bq27xxx variants are unable to automatically determine the state of
> the battery, e.g. capacity, after a reset. Under these conditions, they
> will report incorrect zero values even when the battery is full. This is
> misleading to userspace, and leads to premature shutdowns.
> 
> In an effort to fix this, a patch [0] was submitted, which unfortunately
> introduced a regression [1]. This patch series resolves the regression
> and implements the fix correctly.
> 
> [...]

Applied, thanks!

[1/2] Revert "power: supply: bq27xxx: do not report bogus zero values"
      commit: 4ebeb27b727519c13d420b499becdbca272e1399

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


