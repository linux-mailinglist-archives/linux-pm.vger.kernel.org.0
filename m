Return-Path: <linux-pm+bounces-20301-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECC8A0B49E
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 11:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EF931885DDA
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 10:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA2922AE48;
	Mon, 13 Jan 2025 10:31:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A9F1B412C;
	Mon, 13 Jan 2025 10:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736764288; cv=none; b=UdR5K+mXCto1vXaLkzhad5qPvdKPurd7LP2Vpbw9oWNLcSaK9rX7WEhh621FuJGKaxrYqkEVBsx+feGIQq52V0DAb5NVMr5eYNhVtSfWbHSCSyh3cYRpnstIob/uOvcgRuq3DIr4sakwMaZLNitQS8dCsrYIdNqzrolxsGUAs3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736764288; c=relaxed/simple;
	bh=iAxLerq3mBFejbG7DZmX9Y0W4eFmi/39MqONhjtbiWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prGIKlFKikPhoS6CJbFri6rsrLCaSIeL4dkI6ESZPuhpdvnyM/RQRU0cjmL9Ioo9rhO3wCzAMf7NWEP3bE6CVPvnPX+/cWUfiJCvdVFTONagzUuRpcDPu+U3AXeQlodoc2ug5CDC0mCC1dcAx2eiqEvwH1C2mGRAXBe2dfQ2EHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CB371424;
	Mon, 13 Jan 2025 02:31:53 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5B243F66E;
	Mon, 13 Jan 2025 02:31:23 -0800 (PST)
Date: Mon, 13 Jan 2025 10:31:21 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: <cristian.marussi@arm.com>, <ulf.hansson@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>, <arm-scmi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <ranjani.vaidyanathan@nxp.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] pmdomain: arm: scmi_pm_domain: Initialize state as off
Message-ID: <Z4TreQ5bA9qiMTgC@bogus>
References: <20250110061346.2440772-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110061346.2440772-1-peng.fan@oss.nxp.com>

On Fri, Jan 10, 2025 at 02:13:46PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Per ARM SCMI Spec DEN0056E, page 16, "The platform may disable a resource
> if no agent has requested to use that resource."
>

True, but ...

> Linux Kernel should not rely on a state that it has not requested, so
> make state as off during initialization.
>

IIUC, this was done to avoid any transitions if the bootloader like U-Boot
has turned on the resource and OS can just rely on that stay. Anyways if
the resource is not used by any driver/device in the kernel, won't it be
turned off anyways ? What am I missing ?

I need to dig details, but I remember doing what this patch does and
reverting to what we have based on the feedback IIRC.

--
Regards,
Sudeep

