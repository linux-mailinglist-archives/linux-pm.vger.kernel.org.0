Return-Path: <linux-pm+bounces-18593-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 212BD9E4BE2
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 02:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3CCA16A7A5
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 01:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B401155321;
	Thu,  5 Dec 2024 01:36:56 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E481513CF82;
	Thu,  5 Dec 2024 01:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733362615; cv=none; b=Xwxieq8PDoGnazRRU2UEPjOzeZT1mAHIZPqmZ91f7fQUWrBrQ8SEmKlHDgCYyFNNUdh16JMOB5y0aKTwgsV2EMlAEj+pB2RPkJhKPbIKBHNd8qd2kJj4fPR6DvDtUO7I6CsCx5hk4tcJAJnU0juaCFu4nBLPCrlbx9S3q4Kj+z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733362615; c=relaxed/simple;
	bh=fZdU6sxfoL3KazzzgG0IqRHXFBv4IkDKpRz3mvnAKks=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZnbW1AMoTPiw5SxPKlZgIIfpiOFMcWJ/c1vcO8k34nNIBw4c8fKynU+aF7gPylLJgGzKyzNCdpKzDw5YDUg6EpFDEq3EeI8SY1jsGoCURKTzLA26OtUaXD3WMb61lmjTlo/KN91DAH6OY5tobGTpYK18wC2nRYv7yx186IUIpVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7705CC4AF0B;
	Thu,  5 Dec 2024 01:36:55 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 774511060500; Thu, 05 Dec 2024 02:36:52 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Andrew Davis <afd@ti.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241202211519.199635-1-afd@ti.com>
References: <20241202211519.199635-1-afd@ti.com>
Subject: Re: [PATCH 1/5] power: supply: ds2782: Switch to simpler IDA
 interface
Message-Id: <173336261246.1429662.16233834611899526698.b4-ty@collabora.com>
Date: Thu, 05 Dec 2024 02:36:52 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 02 Dec 2024 15:15:15 -0600, Andrew Davis wrote:
> We don't need to specify any ranges when allocating IDs so we can switch
> to ida_alloc() and ida_free() instead of idr_*.
> 
> 

Applied, thanks!

[1/5] power: supply: ds2782: Switch to simpler IDA interface
      commit: bea4395a04d2602e72f550e795c15e98e557b779
[2/5] power: supply: ds2782: Free IDA with devm action
      commit: fd647cc2cb73e8a6403f9c59fd7956f68f2e6b35
[3/5] power: supply: ds2782: Use devm based memory allocators
      commit: 1481f9f39091b95aec52553a9652d84a827a6004
[4/5] power: supply: ds2782: Use devm_power_supply_register() helper
      commit: 8571178e9adf3128d70d14359b965f370cfd522d
[5/5] power: supply: ds2782: Use devm_delayed_work_autocancel() helper
      commit: 1c44832979a70570f2e652013877c7b15000494e

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


