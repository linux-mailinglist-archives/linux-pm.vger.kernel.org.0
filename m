Return-Path: <linux-pm+bounces-26817-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FA6AAE388
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 16:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C41653B70DC
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 14:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906C928937D;
	Wed,  7 May 2025 14:50:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8B82874FE;
	Wed,  7 May 2025 14:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746629438; cv=none; b=kmQ69Fw4mP42VpQCCnNUiSbsCbxSh2sqctIMZ8lB+lN4ac1fAcmcrHOOckbZcWvtrUIxGFkFBsQt9q1DTJgAslGVko0kz3BbKss1siZ8uh9IHrOiVk0yzczlVZU+zK/h3xx/SfedjW/EDwjx5BhiYEkD6r8EL8sZpzgre4r/W58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746629438; c=relaxed/simple;
	bh=nVWccaSSxf+SxwkrGQJlOttYR6ugWmY1cHA+TrNndNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkE2BEvUb5LYP+4A4HnkfL2N0Z8dO31CHbFBaikXzJTY8/5k3SB6C/AKwjuAXRTQpOqOatMl+SVUUn9g6p3bP2v74XTvPVbo7MszZv19KuflL6rGen/Nvi2qEdNmcKjnR/tTEGp+duNo0lUUrNSB+WKfEvOo8Di2qvS+v+ajBzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C652339;
	Wed,  7 May 2025 07:50:24 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7C273F5A1;
	Wed,  7 May 2025 07:50:33 -0700 (PDT)
Date: Wed, 7 May 2025 15:50:30 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1] PM: sysfs: Move debug runtime PM attributes to
 runtime_attrs[]
Message-ID: <20250507-obedient-imposing-carp-3c9ffa@sudeepholla>
References: <12677254.O9o76ZdvQC@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12677254.O9o76ZdvQC@rjwysocki.net>

On Wed, May 07, 2025 at 04:29:37PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Some of the debug sysfs attributes for runtime PM are located
> in the power_attrs[] table, so they are exposed even in the
> pm_runtime_has_no_callbacks() case, unlike the other non-debug
> sysfs attributes for runtime PM, which may be confusing.
> 
> Moreover, dev_attr_runtime_status.attr appears in two
> places, which effectively causes it to be always exposed if
> CONFIG_PM_ADVANCED_DEBUG is set, but otherwise it is exposed
> only when pm_runtime_has_no_callbacks() returns 'false'.
> 
> Address this by putting all sysfs attributes for runtime PM into
> runtime_attrs[].
> 

For once I thought it will change the paths before looking at the code
and realising that all the attributes get merged under "../power/".

FWIW:

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

