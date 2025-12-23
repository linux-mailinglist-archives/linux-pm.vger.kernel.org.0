Return-Path: <linux-pm+bounces-39818-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 958CBCD804D
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 05:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97520305C4FB
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 04:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EF12F12AF;
	Tue, 23 Dec 2025 03:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVGeSvmx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0372DF153;
	Tue, 23 Dec 2025 03:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766462180; cv=none; b=mvcCm/mh2PA1VjRDG6UclcuWczKQqKYMKwPdfvM5kMVlJwGEaEgLksL3q7kS8LE/2fpeebvCH3S7oH1KzNiJKPBw2pOsIi1YXMl6swVlNhmry9cICXlOU4TT2VK40k5t7w54589hFM91YfehVjPEDFwbAAP2SbjGOIB+aAHS/Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766462180; c=relaxed/simple;
	bh=e5BMuNTLew3Xv7qVXFoS8L6keuyx/ZFii6dtT834gjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qam4a76VaHQ5qgzRMxhKzw6mEptIYEs/LNOVSuQrj3yR8/nDKeDTeYSGp1PXc5fY/5dR62gx8PBHDZOzosJ2+jMMfux8v+EYZCqOBZx2EQY8WpnUAuivn97ptJjoxpwycm4UQvhTSGAh1U0UQqd3vxSQZCizlEhwmOKDDb+u3Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVGeSvmx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE462C116B1;
	Tue, 23 Dec 2025 03:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766462180;
	bh=e5BMuNTLew3Xv7qVXFoS8L6keuyx/ZFii6dtT834gjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HVGeSvmxypXGiZNp4ksEf+/keQDBOBnqolPPlgKLaBgFTeiQhhi3AtRaViu2DgEa+
	 N+o8+D+ctDD5J59Z9Zqvse5Sf3M6gqZHwsWYaIpNqjba7QWU6NYN2gTjcuAG6J36Hs
	 8k5VcrDe0xV9fzj8EqpOfl+G2kEfNA+BP+nYVbsP664Dc0H3kInt4WmCfAXGFlvxr3
	 gLtHtc68tX/dL7UBw9k7wKdThMm9+B0DWosiaZgRi3uUQfN4ADX83a3kuN6k33v9OQ
	 ZBOvNeCO9GHeji3T/WtHh5tF/JqHrHiWSqSpLGfJi+iRn8wiLjuiH3wDVfTGQlFXWu
	 KIKWpNquDGYYQ==
Date: Tue, 23 Dec 2025 03:56:16 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Brian Norris <briannorris@chromium.org>,
	Dan Callaghan <dcallagh@chromium.org>,
	Sami =?iso-8859-1?Q?Ky=F6stil=E4?= <skyostil@chromium.org>,
	Benson Leung <bleung@chromium.org>, chrome-platform@lists.linux.dev
Subject: Re: [PATCH v1 18/23] platform/chrome: cros_hps_i2c: Discard
 pm_runtime_put() return value
Message-ID: <aUoS4AxGx291bLqF@google.com>
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
 <2302270.NgBsaNRSFp@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2302270.NgBsaNRSFp@rafael.j.wysocki>

On Mon, Dec 22, 2025 at 09:27:44PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Passing pm_runtime_put() return value to the callers is not particularly
> useful.
> 
> Returning an error code from pm_runtime_put() merely means that it has
> not queued up a work item to check whether or not the device can be
> suspended and there are many perfectly valid situations in which that
> can happen, like after writing "on" to the devices' runtime PM "control"
> attribute in sysfs for one example.  It also happens when the kernel is
> configured with CONFIG_PM unset.
> 
> Accordingly, update hps_release() to simply discard the return value of
> pm_runtime_put() and always return success to the caller.
> 
> This will facilitate a planned change of the pm_runtime_put() return
> type to void in the future.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Tzung-Bi Shih <tzungbi@kernel.org>

