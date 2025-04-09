Return-Path: <linux-pm+bounces-25048-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EEBA83041
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 21:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5F9B1B61DB3
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 19:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036311E22E6;
	Wed,  9 Apr 2025 19:18:02 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9B41C6BE;
	Wed,  9 Apr 2025 19:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744226281; cv=none; b=HObqfkdJVxg30O1MG2TgXrmVpgpyKjn3FnTJv8bDGtegCHZZsEBeaMvSrRflFP/X2783ZNbXtjLSmt1P5DhqX1ZhngW9w9gCPkWs+eUCFRbCmOTPUKqCu8Kw0dUaKNHfNreEx18ccXFb2wEa1ZzfmBkHsUljKpPICCjTrw/Xl8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744226281; c=relaxed/simple;
	bh=SW+anX2q3RaqVoCHxVXbf8GdHLpP6Zl5Lw6Q/sV1Ezw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEfLJRY5tDIR4Hs/PcQGnFCxmfuLShlG7RLP0O6poe0XiJVx2L9DPsstQQXj3it4LHZaCtSI7jyQ9I7jKE6bzSCJk8qnX/Br6B/i2n057lz9Izeh6ZWvcDIKY4vKIVXmHwqwst34e8lE5C2pyXdHDawBlruLGmnfvm+dXyWjfMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B080D15A1;
	Wed,  9 Apr 2025 12:17:59 -0700 (PDT)
Received: from bogus (unknown [10.57.41.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE6DF3F694;
	Wed,  9 Apr 2025 12:17:57 -0700 (PDT)
Date: Wed, 9 Apr 2025 20:17:54 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/9] cpuidle: psci: Transition to the faux device
 interface
Message-ID: <20250409-adorable-venomous-cormorant-d01246@sudeepholla>
References: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com>
 <20250317-plat2faux_dev-v1-1-5fe67c085ad5@arm.com>
 <CAJZ5v0gcRDJFJtnPY+sszkUEYsdqxfm194Y7=namkD0qYnokHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gcRDJFJtnPY+sszkUEYsdqxfm194Y7=namkD0qYnokHg@mail.gmail.com>

On Wed, Apr 09, 2025 at 08:03:32PM +0200, Rafael J. Wysocki wrote:
> On Mon, Mar 17, 2025 at 11:13 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > The PSCI cpuidle driver does not require the creation of a platform
> > device. Originally, this approach was chosen for simplicity when the
> > driver was first implemented.
> >
> > With the introduction of the lightweight faux device interface, we now
> > have a more appropriate alternative. Migrate the driver to utilize the
> > faux bus, given that the platform device it previously created was not
> > a real one anyway. This will simplify the code, reducing its footprint
> > while maintaining functionality.
> >
> > Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: linux-pm@vger.kernel.org
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> Do you want me to pick up this one?
> 

Yes you can pick this up.

Just checked again, this is v1 and correct version.

-- 
Regards,
Sudeep

