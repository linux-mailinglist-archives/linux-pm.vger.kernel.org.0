Return-Path: <linux-pm+bounces-34490-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49994B536FB
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 17:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AC4B188E283
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 15:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEEC3469E6;
	Thu, 11 Sep 2025 15:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqXsidjq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C7234575B;
	Thu, 11 Sep 2025 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757603447; cv=none; b=tkKNT9VMwBzdgppkUQnfgM0ySE/nJsGPh/3Yn87NRgPZlXsl7rsbAXQHXN/qMQKAeQGMWHr8Lri+cjx/RCAuZJDoAQxZiGrEKnIaKZGyXatfZhXwr0Xp/KhWckarBhC/gqC5mp1ItmcBaUYZ4tS/0iJVdoWhZpL6C4aYisYa2Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757603447; c=relaxed/simple;
	bh=vESIC3H1d33KdZFzxixmTx3M3eMgo+ACg9D5yt4PcCg=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=fcz+PtNFzUmNOGZvEYuZRjTyVeI9MoiLGBnvF0iEb1iwWgyN7+GQVT6zdQclNq/1Ln7kABf40qeHCFNH0LysgI2jlIFv3UPFNCUiO13jPylg9+urxvCpe9qXToiTH4xtmZKBT7aNqKF4GNSU8LO9/kQqjsVHs5JN1Vr7HdeF//A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqXsidjq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E05C4CEF0;
	Thu, 11 Sep 2025 15:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757603447;
	bh=vESIC3H1d33KdZFzxixmTx3M3eMgo+ACg9D5yt4PcCg=;
	h=Date:From:To:Cc:Subject:From;
	b=LqXsidjq1YDfMhTjyyakuA68Sau14+CsdPbk3pQa+JSDz5kxLm7YDkVGntQ/4uSAI
	 dAkVnqb0HX0u6CWNQNaJdzT9BmfotW5DRlHJazp0lsSVsThxnCp45Op3a7khPHZvry
	 GT3N+DzSKbVP2EiXnWC+mYkIbf058x5V7jbqdmF7WR5TsSXc2xy1cD79c+wtThIIAN
	 GznqcxdzTIkF/DeBipkrf2l1mcuDELKujjEnT4PVAjT8PCBKZ7nnecAl1erTjnF/xy
	 f45o2nGeu98bY7PF05jyA1OsiBOXIsDYZ/SGE3bNKaXo2S+gtk/XHEnMDt4bNp6Urj
	 GXPViTOV9Vwgw==
Message-ID: <013e03cd-6d8d-4bf9-ba52-5001d10444b7@kernel.org>
Date: Fri, 12 Sep 2025 00:10:43 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:DEVICE FREQUENCY (DEVFREQ)" <linux-pm@vger.kernel.org>,
 Chanwoo Choi <cw00.choi@samsung.com>, Chanwoo Choi <chanwoo@kernel.org>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>
Subject: [GIT PULL] devfreq next for 6.18
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Dear Rafael,

This is devfreq-next pull request. I add detailed description of
this pull request on the following tag. Please pull devfreq with
following updates.

Best Regards,
Chanwoo Choi


The following changes since commit 1b237f190eb3d36f52dffe07a40b5eb210280e00:

  Linux 6.17-rc3 (2025-08-24 12:04:12 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-6.18

for you to fetch changes up to eddb5ba91b289faa15117d4fc1c2fb223f3493c2:

  PM / devfreq: rockchip-dfi: add support for LPDDR5 (2025-09-09 23:37:39 +0900)
  
----------------------------------------------------------------
  
Update devfreq next for v6.18

Detailed description for this pull request:
- Add support for LPDDR5 for Rockhip RK3588 SoC on rockchip-dfi devfreq driver.

- Fix an issue where DDR cycle counts on RK3588/RK3528 with LPDDR4(X)
  are reported as half by adding a cycle multiplier to the DFI driver
  on rockchip-dfi devfreq-event driver.

- Fix missing error pointer dereference of regulator instance
  and remove redundant condition on on mtk-cci-devfreq.c devfreq driver.

----------------------------------------------------------------
Dan Carpenter (1):
      PM / devfreq: mtk-cci: Fix potential error pointer dereference in probe()

Liao Yuanhong (1):
      PM / devfreq: mtk-cci: avoid redundant conditions

Nicolas Frattaroli (2):
      PM / devfreq: rockchip-dfi: double count on RK3588
      PM / devfreq: rockchip-dfi: add support for LPDDR5

 drivers/devfreq/event/rockchip-dfi.c | 91 ++++++++++++++++++++++++++++--------
 drivers/devfreq/mtk-cci-devfreq.c    |  5 +-
 include/soc/rockchip/rk3588_grf.h    |  8 +++-
 include/soc/rockchip/rockchip_grf.h  |  1 +
 4 files changed, 82 insertions(+), 23 deletions(-)

