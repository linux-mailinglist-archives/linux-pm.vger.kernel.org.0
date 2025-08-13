Return-Path: <linux-pm+bounces-32260-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0E5B24804
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 13:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81ED27210B4
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 11:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5422F6572;
	Wed, 13 Aug 2025 11:07:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08752F6571;
	Wed, 13 Aug 2025 11:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755083258; cv=none; b=ehEtGJ2e643H8ut4l6AXgzbS+DviVW1jwj8lyZVy8eyNyxJs1GudmVCiqMrihbnCgTt/jz+m5Zs+4ctgciglIkwAOFOTB2bIFIhW35jWqk7QnuBn30Z97OQ/xHAG4DJxTstSSPFUqP1Y6ZswgOLGzoEOPnA+5osTG1Hg9GkAk74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755083258; c=relaxed/simple;
	bh=Y4glvwOywonEuV/qz+yS8PrmS77FfM0DYO9hteuYo84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNoNDcvSXEGpkWFG0oLL8/ZUCL6Elai1bBcbwcvpuqXma2m+wOpcP4FbShbyueUs3pfTJCaBmt25WxOHTNQTSm48lepY2BlhDcPJEtLWvMxi2V139VHjmnztoVM2/+/GD2MrrnjpE01NZwSxG0duxTmNYFH5V++hg7TtlYYxvh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9B9812FC;
	Wed, 13 Aug 2025 04:07:27 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DAC103F738;
	Wed, 13 Aug 2025 04:07:34 -0700 (PDT)
Date: Wed, 13 Aug 2025 12:07:32 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: Re: [PATCH v1] ACPI: processor: idle: Eliminate static variable
 flat_state_cnt
Message-ID: <20250813-poised-robust-spaniel-0e706d@sudeepholla>
References: <10715991.nUPlyArG6x@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10715991.nUPlyArG6x@rafael.j.wysocki>

On Wed, Aug 13, 2025 at 12:38:58PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Instead of using static variable flat_state_cnt to pass data between
> functions involved in the _LPI information processing, pass the current
> number of "flattened" idle states to flatten_lpi_states() and make it
> return the updated number of those states.  At the same time, use a
> local variable called state_count to store the number of "flattened"
> idle states found so far in acpi_processor_get_lpi_info().
> 
> No intentional functional impact.
>

Thanks for this cleanup.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

