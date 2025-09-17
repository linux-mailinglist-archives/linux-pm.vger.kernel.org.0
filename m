Return-Path: <linux-pm+bounces-34928-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0326EB82391
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 01:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF5662A7388
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 23:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C221A2C1583;
	Wed, 17 Sep 2025 23:03:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C0C27AC2E;
	Wed, 17 Sep 2025 23:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758150220; cv=none; b=sIfrwQyTpXKMwc6ZkemFmCIxBjIHWQQWvR6GMJPCplYc/eM0NkF9zuCxzR2fC7f65Qo7cmNb5T8lMUGaa/3taT5YT02H96PKW/iL74QztJFJXVmAL6kU324+nK9NC0InP/tXZH67v1cnbvkNWJZXKpy5SnyYI9HKBog1xb7J2E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758150220; c=relaxed/simple;
	bh=b3lnzbMGUMruv80TpeQ8LxeDYvyLXztW7EmdDS4NOSg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=S/7v8ud8WwAMAqyazMVyvngfUis2nSYgoNtiVOs661u33sjE5FtbIU5xC/KJkB0GSfR1wX/o6o6NA2QroVPKz7IotXZq4joGDIw1BTDncySFBfophzPJM3EUHGFyR80SQ1+itQF0ElavwYJ4FoPdnHBjVCL0ZbW1e+m74kt0T2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32554C4CEFA;
	Wed, 17 Sep 2025 23:03:40 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 5651218067E; Thu, 18 Sep 2025 01:03:38 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, Xichao Zhao <zhao.xichao@vivo.com>
Cc: pali@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250909020925.382261-1-zhao.xichao@vivo.com>
References: <20250909020925.382261-1-zhao.xichao@vivo.com>
Subject: Re: [PATCH] power: supply: rx51: remove redundant condition checks
Message-Id: <175815021834.129824.6840579489464192316.b4-ty@collabora.com>
Date: Thu, 18 Sep 2025 01:03:38 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 09 Sep 2025 10:09:25 +0800, Xichao Zhao wrote:
> Remove redundant condition checks and replace else if with else.
> 
> 

Applied, thanks!

[1/1] power: supply: rx51: remove redundant condition checks
      commit: 1bafaa156ed3881cd4f187ab1c43e408742e1f11

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


