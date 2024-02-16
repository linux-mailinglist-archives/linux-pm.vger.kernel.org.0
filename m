Return-Path: <linux-pm+bounces-3970-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B71D185759D
	for <lists+linux-pm@lfdr.de>; Fri, 16 Feb 2024 06:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55B8C1F249E6
	for <lists+linux-pm@lfdr.de>; Fri, 16 Feb 2024 05:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357A012E68;
	Fri, 16 Feb 2024 05:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKmb5Gvx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8F812E5D;
	Fri, 16 Feb 2024 05:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708061428; cv=none; b=tA723GosquYLHY7Gp9EJId00iFHuuN2a/G8QAOjfvt4+9x/bbdH2WBH3IV7CZX2Zk9VKH8z/RS5YwcT630nHpESRdky95c4RsE0NTE/X7eHnrbG9gBywgI/DETZrbz4PcPyEuuCXt2QoxtWKkoCKg0VtSPNWP7crQRYucyA6WmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708061428; c=relaxed/simple;
	bh=Eu0og32T7XWPIozbBw/VUAIhMl5sQUBRhMshi5KK94g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PjNuo9b8Q/ry5OuZkjVXr47Y7IvMxfQf0Pmv/r13z+RX+mXStqfJr3VXX6CgdyzhqD3aHckHOznhlTKad/eX0uXzmPldZgigCqJKx4B5h5BKwZHYw6MqTQ64Pw9WJLYe4FNPtxikKfiDPmp1D0BPFPO1AWsc3s3sHyps0XAtM80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKmb5Gvx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E8C3C43390;
	Fri, 16 Feb 2024 05:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708061427;
	bh=Eu0og32T7XWPIozbBw/VUAIhMl5sQUBRhMshi5KK94g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FKmb5GvxNoSIRTTma7pxdMHZdMMLnj+LYgWd9PchaT4m5GIbqCMr1vos4jsaYDy8K
	 ozEq/++a8tLTbiTNUj8XMLX76ujHZQD+2Yx1tkTOYdS2zflJHbNQSIQsls/aqQ+2lg
	 PAlZ/Cp0wvtW7CcpmXs+1iwmn6lz8Dvpnam5EFVjlpBJA2t/dSERjI3NmTBdV+vmqK
	 90UWfjxrjDvNMddDm1nm2kkLhucvr6jHD6qDBGYaR6UGNZbUkHTTGC1mSEIWWpbGfM
	 D5kFeGiXgQoYe0lq/4J0Xu5G/Xf3E4SgMGGrkYyIt/6u0X6jzcA5w/1H9DRO2ygjwy
	 o527LcpJv5lNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 74CABD8C966;
	Fri, 16 Feb 2024 05:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/3] thermal/netlink/intel_hfi: Enable HFI feature only
 when required
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170806142747.12395.15243886635113017913.git-patchwork-notify@kernel.org>
Date: Fri, 16 Feb 2024 05:30:27 +0000
References: <20240212161615.161935-1-stanislaw.gruszka@linux.intel.com>
In-Reply-To: <20240212161615.161935-1-stanislaw.gruszka@linux.intel.com>
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: linux-pm@vger.kernel.org, rafael@kernel.org,
 srinivas.pandruvada@linux.intel.com, ricardo.neri-calderon@linux.intel.com,
 daniel.lezcano@linaro.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us,
 johannes@sipsolutions.net, fw@strlen.de, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Feb 2024 17:16:12 +0100 you wrote:
> The patchset introduces a new genetlink family bind/unbind callbacks
> and thermal/netlink notifications, which allow drivers to send netlink
> multicast events based on the presence of actual user-space consumers.
> This functionality optimizes resource usage by allowing disabling
> of features when not needed.
> 
> Then implement the notification mechanism in the intel_hif driver,
> it is utilized to disable the Hardware Feedback Interface (HFI)
> dynamically. By implementing a thermal genl notify callback, the driver
> can now enable or disable the HFI based on actual demand, particularly
> when user-space applications like intel-speed-select or Intel Low Power
> daemon utilize events related to performance and energy efficiency
> capabilities.
> 
> [...]

Here is the summary with links:
  - [v4,1/3] genetlink: Add per family bind/unbind callbacks
    https://git.kernel.org/netdev/net-next/c/3de21a8990d3
  - [v4,2/3] thermal: netlink: Add genetlink bind/unbind notifications
    (no matching commit)
  - [v4,3/3] thermal: intel: hfi: Enable interface only when required
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



