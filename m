Return-Path: <linux-pm+bounces-18590-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1086B9E4BE0
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 02:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B371F16A77D
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 01:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167D614F9D9;
	Thu,  5 Dec 2024 01:36:56 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30E813AA5D;
	Thu,  5 Dec 2024 01:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733362615; cv=none; b=VOzOG3gCF4O07j8rMvwJ8/SWmjpKNcCzEftfuZY3CHILppAdhO16IrsB8BRe+nN/TkE1arQlJbyLUzEPFiul/i2JIY4txoiOq8OE1Tj4Rn+sQI+AIfQ4NkoeAxDLnas+scazctmnP1aviX4Y05kvaJeB7NT23JLHZmScg3+WQ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733362615; c=relaxed/simple;
	bh=BnnC0Z3WdW7APYQau/oHACoQWtKHZrH8nAtM7eeTYtU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QUk5/1RcyBrWGtXoVElKPaFGwZxQayPFmLRL+0lB84dXJLRI4Iz5uHve722vMeQc9dT+sTOIG8qI2HsgEGwKuPStvKDUVq2kZQo9G+Oh1EiAApkyB13nwtXSu2Ltyc0QPzIGyQ+6+mwIl5rg4fiaxBno6262v7fmFGA1s1mxJWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79999C4CEDD;
	Thu,  5 Dec 2024 01:36:55 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 730C610604B0; Thu, 05 Dec 2024 02:36:52 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241202-sysfs-const-bin_attr-psy-v1-0-f846430b8b66@weissschuh.net>
References: <20241202-sysfs-const-bin_attr-psy-v1-0-f846430b8b66@weissschuh.net>
Subject: Re: [PATCH 0/4] power: supply: constify 'struct bin_attribute'
Message-Id: <173336261240.1429662.9452532103348993626.b4-ty@collabora.com>
Date: Thu, 05 Dec 2024 02:36:52 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2


On Mon, 02 Dec 2024 20:02:18 +0100, Thomas Weißschuh wrote:
> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
> 
> The usage of read_new/write_new/bin_attrs_new is a transition mechanism
> and will be reverted after the transition is complete.
> 
> [...]

Applied, thanks!

[1/4] power: supply: ds2760: constify 'struct bin_attribute'
      commit: fc197588917bb05252115c9e76f3d34d30600249
[2/4] power: supply: ds2780: constify 'struct bin_attribute'
      commit: 9aae72fe40f06872ae20c0cdb545ea5ecc840842
[3/4] power: supply: ds2781: constify 'struct bin_attribute'
      commit: 8159fcb12862f826a26964d8b814ad33e69ba4de
[4/4] power: supply: olpc_battery: constify 'struct bin_attribute'
      commit: dc509d8be38ffe4ff6d752bdb7913718318e83cd

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


