Return-Path: <linux-pm+bounces-8527-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 268C58D83BE
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 15:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6735287C77
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 13:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7DD12C491;
	Mon,  3 Jun 2024 13:19:22 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFF059B4A;
	Mon,  3 Jun 2024 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717420762; cv=none; b=RoLI54MSgfBWr6K2kqpD46+VRUFGlci2TAOnroG8iLgorVR8gV2QmVbEJDCZvF7a5LTdehB9O1ibGuVC6K0awYdA6HvoHzbIyGHPNDvBqOTwp+NmGWdQIoMcC0yrCNW1thbYrBtZ8oe+IbnBI6j7Dbn6wYi1ipH3Ik3pKXgmKJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717420762; c=relaxed/simple;
	bh=4YroT21gJnLZenzG3TScNYnn7yMAq8yFIJmSMtaH100=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVLhe5C1RTKIMKx5e6mZgvNM6ZLzmFta6JU2OOsC4N6OQ0e/T3stk5PzR8/T7wevTw/2dbCFstRgn+RXpBN1cirX4KDQnxdoIOp8ZgQ0/acNIgQCtAIU2ZSGOAKnezlzUV/YrjcTSIENKqzm75ae9GSmTlBsUXKd5OAtNIW0oEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 444521063;
	Mon,  3 Jun 2024 06:19:44 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA52A3F64C;
	Mon,  3 Jun 2024 06:19:18 -0700 (PDT)
Date: Mon, 3 Jun 2024 14:19:16 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: cristian.marussi@arm.com, ulf.hansson@linaro.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] pmdomain: arm: scmi_pm_domain: set flag
 GENPD_FLAG_ACTIVE_WAKEUP
Message-ID: <Zl3C1Gt0-LvLWl4g@bogus>
References: <20240514131833.911703-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514131833.911703-1-peng.fan@oss.nxp.com>

On Tue, May 14, 2024 at 09:18:33PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> Set flag GENPD_FLAG_ACTIVE_WAKEUP to scmi genpd, then when a device
> is set as wakeup source using device_set_wakeup_enable, the power
> domain could be kept on to make sure the device could wakeup the system.
>

I am fine with the change, wonder if it can be made conditional but I can't
think of a sane way to do so. If Ulf thinks it is harmless to keep it
unconditional on all the domains, then I am fine with that.

I assume Ulf can pick this up directly,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep

