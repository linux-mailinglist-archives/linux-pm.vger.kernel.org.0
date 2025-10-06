Return-Path: <linux-pm+bounces-35735-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DC5BBE610
	for <lists+linux-pm@lfdr.de>; Mon, 06 Oct 2025 16:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 29CA34EE79E
	for <lists+linux-pm@lfdr.de>; Mon,  6 Oct 2025 14:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA682D594F;
	Mon,  6 Oct 2025 14:41:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FC914386D;
	Mon,  6 Oct 2025 14:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759761707; cv=none; b=vERv4E6vVsjfthobS3/llBk9RPT5zJ+S/Xf4Ye5ri0Za6TLq43qmryzLh4qbnj0eU+fC2b6uLw+RuqwKdtYXqNC/FD5XJUA8Yx5wSuOH7UbKPsy2qJlP3C6awSXObJIftVWTSGmivb5Wou/OzyGxDapcucNAmFf0NNfArqKmSSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759761707; c=relaxed/simple;
	bh=4vfoSLZu0iB+MKr7ng9UfsrwpdlYt9d/We31+FzYPxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1552tRJU8P0gYS0jpSIVAANwRATz088yBE/u6VvzWf3A8FwTgC8NldUvL6V8GTKAyrxjvtdAMnSJuGPUyfiVAVsgHD3UOXUE0pg+aMvZzLkwzHpBrtr9WWjzfuq1VKQRPoYHOO1LqZfeSqYQruzvg/Vkx9H/9G5h62TPqA9fT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DBD91515;
	Mon,  6 Oct 2025 07:41:37 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D62923F738;
	Mon,  6 Oct 2025 07:41:42 -0700 (PDT)
Date: Mon, 6 Oct 2025 15:41:40 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: smp: Implement cpus_has_pending_ipi()
Message-ID: <20251006-spiked-beige-gecko-6d8748@sudeepholla>
References: <20251003150251.520624-1-ulf.hansson@linaro.org>
 <20251003150251.520624-3-ulf.hansson@linaro.org>
 <20251006-manipulative-urban-antelope-31101f@sudeepholla>
 <CAPDyKFoz4P6cZWNA-omNtF3XqKKciC07aVXBTVQp8ueyyYxmxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPDyKFoz4P6cZWNA-omNtF3XqKKciC07aVXBTVQp8ueyyYxmxA@mail.gmail.com>

On Mon, Oct 06, 2025 at 02:22:49PM +0200, Ulf Hansson wrote:
> On Mon, 6 Oct 2025 at 12:54, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > 2. I understand this is intended for the DragonBoard 410c, where the firmware
> >    can’t be updated. However, ideally, the PSCI firmware should handle checking
> >    for pending IPIs if that’s important for the platform. The firmware could
> >    perform this check at the CPU PPU/HW level and prevent entering the
> >    state if needed.
> 
> I think this is exactly what is happening on Dragonboard 410c (see the
> stats I shared in the commit message in patch3).
> 
> The PSCI FW refuses to enter the suggested idlestate and the call fails.
> 

Ah OK, the PSCI FW is doing the job correctly, we are just attempting to
reduce the failures by catching few cases earlier in the OSPM itself ?
Sure it only reduces the failures but it can't eliminate those as IPI might
be issued after this check in the OSPM. I understand the call to firmware
can be prevented.

-- 
Regards,
Sudeep

