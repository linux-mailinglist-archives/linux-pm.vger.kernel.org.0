Return-Path: <linux-pm+bounces-28190-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABEEACFF33
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 11:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14B641892CB5
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 09:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8168E286401;
	Fri,  6 Jun 2025 09:21:39 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B942857F8;
	Fri,  6 Jun 2025 09:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749201699; cv=none; b=n2JP8YQ94A+OMrk6qe8APVBvj77f9jETnBbI52fCvRDg0QOmvgZpyRC2tAqKdKuaA0auWWwSa0F629Q8RxaKmaJLzI2VP/C/QdtkkvY+RxWkOnoVaanTbJEwbSImaP9M4AQqpXkt1pgmlRsxVB2E0DyPThO0uBs3vuefQHFqOSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749201699; c=relaxed/simple;
	bh=JNII4LjXiJAVTUR4XLq+TZLkG3dqk5KWt6XmBuCspDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZvDf21LAr/A+d8t0zrXSVEeLtDyCTG6VwL5KHzGDnQs+sSOhc7pDgybXAhozXFnNG5fB+ZwXnVeNxLr8nMAL6M7r3a8tOBBVG+/2gM1958IScQ1QAgMnShN4qoG74VNykwfeaM+unSWbe6aHAySHDY/8wB6UHHL+QpxXjlkfjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2C94153B;
	Fri,  6 Jun 2025 02:21:16 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A85D33F59E;
	Fri,  6 Jun 2025 02:21:32 -0700 (PDT)
Date: Fri, 6 Jun 2025 10:21:29 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	Javier Martinez Canillas <javierm@redhat.com>,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] pmdomain: arm: scmi_pm_domain: remove code clutter
Message-ID: <20250606-charming-aloof-adder-8acc6d@sudeepholla>
References: <20250606090802.597504-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606090802.597504-1-lukas.bulwahn@redhat.com>

On Fri, Jun 06, 2025 at 11:08:02AM +0200, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> There is no need to introduce the boolean power_on to select the constant
> value for state. Simply pass the value for state as argument. Just remove
> this code clutter.
> 
> No functional change.
> 

Nice cleanup. Thanks for doing this.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Ulf,

I assume you will pick this up when you start collecting patches for
next merge window.

-- 
Regards,
Sudeep

