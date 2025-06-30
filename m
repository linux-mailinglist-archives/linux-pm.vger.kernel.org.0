Return-Path: <linux-pm+bounces-29844-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3547AEDEA6
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 15:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE18B16CBAD
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 13:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E9A28C5CB;
	Mon, 30 Jun 2025 13:12:26 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79956285C90;
	Mon, 30 Jun 2025 13:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751289146; cv=none; b=h6N965I6gGSQQeZXjAu1zEGl0eP3bnf/dOZvB360tlSy58KD+H4jiIAwMuy8MgSesV34Qu9cRLskoRGXe0E5MiGwgD5fMwDBefYtb3n2ZT0VPqp4rzXOwx//vCF6wMgVTiZeL2+VBOj1SC9rKFqHydWrK4lxdsUgOvnUW2DuO0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751289146; c=relaxed/simple;
	bh=4ekT1XPrxJNspsoiZsY2bnDaLUg6PUo2XqV8IuGPwbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtABNYWHM2jwOOzgeMXIrjYIetuLIFqm5tD0Ej58aqmiuuDNwO1rzwCOcjZHNcTvfKRe6PJeZMspuFDmQjrGxcTssFHvPzmrggsmNUtCPLh01GTAh699m9inr7S/sV/quauB2mXMkT/yA5bZecyIDf2XIYpkknLd4vKK0VyGIv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A1A51AC1;
	Mon, 30 Jun 2025 06:12:07 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4F8F3F6A8;
	Mon, 30 Jun 2025 06:12:21 -0700 (PDT)
Date: Mon, 30 Jun 2025 14:12:19 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Chris Bainbridge <chris.bainbridge@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Saravana Kannan <saravanak@google.com>
Subject: Re: [RFT][PATCH v4 0/2] PM: sleep: Handle async suppliers like
 parents and async consumers like children
Message-ID: <aGKNMySk6I0hJXSY@bogus>
References: <5011988.GXAFRqVoOG@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5011988.GXAFRqVoOG@rjwysocki.net>

On Mon, Jun 23, 2025 at 02:44:09PM +0200, Rafael J. Wysocki wrote:
> Hi Everyone,
> 
> These two patches complement the recently made PM core changes related to
> the async suspend and resume of devices.  They should apply on top of
> 6.16-rc3.
> 
> They were sent along with the other changes mentioned above:
> 
> https://lore.kernel.org/linux-pm/2229735.Mh6RI2rZIc@rjwysocki.net/
> https://lore.kernel.org/linux-pm/2651185.Lt9SDvczpP@rjwysocki.net/
> 
> (and this is v4 because they have been rebased in the meantime), but they don't
> make any difference on my test-bed x86 systems, so I'd appreciate a confirmation
> that they are actually needed on ARM (or another architecture using DT).
> 

All the changes LGTM.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

I don't have platform to exercise this patch much ATM, so sorry can't do
much testing though.

-- 
Regards,
Sudeep

