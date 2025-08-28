Return-Path: <linux-pm+bounces-33257-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC771B39D8B
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 14:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A18DB1C82A5E
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 12:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7C730FF20;
	Thu, 28 Aug 2025 12:41:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF5230FC3E;
	Thu, 28 Aug 2025 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756384888; cv=none; b=l9sA/vZBoSDW2mwWZ1wzMe9+LtcZkDItcR0vofrXGgae76DeWknmG2EXkzmRSRJ9UId5mfVwoyaISG9P+z9vi5NQbbe3w/yRLC9mwLvPKlkESd+svu03ATe9li7Df9GZbE/hjhbiPV0vBvslOo09SlYTTqoV+58z0a2RPon/hZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756384888; c=relaxed/simple;
	bh=6LrRtbDFIk/4ICXmFP0WE/tozasOy7Bi4Th6Zu//z/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSQ5Afsz9m1Z1q1l2BYOUrpCs8nKM5Xo5aC69zDXirNKA7rIWZiWECD9u9ok6kLNOx7GukBKlDoSBW7jlHiTHm7yECvYAwRQ/dRPLAlr8rvDi+f7p1DVa2snUoRWRIxtq1hvDDxR+nhKMTMwUCTzMGKPx9e1B/5rw+2S7Mz0Yqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 722A81688;
	Thu, 28 Aug 2025 05:41:17 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7ACD3F694;
	Thu, 28 Aug 2025 05:41:24 -0700 (PDT)
Date: Thu, 28 Aug 2025 13:41:21 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v1 0/2] driver core/PM: Two updates related to power.no_pm
Message-ID: <20250828-nebulous-python-of-prowess-b4b02d@sudeepholla>
References: <12749467.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12749467.O9o76ZdvQC@rafael.j.wysocki>

On Thu, Aug 28, 2025 at 12:55:50PM +0200, Rafael J. Wysocki wrote:
> Hi All,
> 
> Applying this series will cause power.no_pm to be set for faux devices (so they
> don't get processed unnecessarily during system-wide suspend/resume transitions)
> and power.no_callbacks to be set along with power.no_pm (for consistency).
> 

Nice, even I hadn't noticed about these before. The changes looks good
to me.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep

