Return-Path: <linux-pm+bounces-25355-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 079BDA87A33
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 10:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B21B43A6C90
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 08:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C491259483;
	Mon, 14 Apr 2025 08:23:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F097E2628C;
	Mon, 14 Apr 2025 08:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744619011; cv=none; b=Yk19uNTGjYHimsstPZbdIsyzqOzeR4/jCWR+y2blukQnmVjGFCrxzBnUuCgRZgjhAzGWIw9hujDykiGMfsIBERQq6j7Qr0d0cjTUQIYTwmu+o6X7NJzov1XNqjsQHk8mOFuYCD7azJtHV3qEOUGwtuLo8KRBX48BSUNDeW+/JEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744619011; c=relaxed/simple;
	bh=DTn0h/+Ep5caUk0dt4DGeVayyg5JOlWoTsB2zL7viis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3apWtfPZ4bRZ8y56ByLzTN6mvi4cu7fboY/b4RYdbIPUHIEIN/JpqHshT65unP6O+wnI8y/+FGAuvEn+FPz2am9gJLoQuLwCTvru9tHV/X73dvgso0u1hp9MynOmH8hWwNaRb3wSbVCDDK8uutUF53Of4zdHchGU1I+xEoNRCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C92C1007;
	Mon, 14 Apr 2025 01:23:28 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BCAC3F694;
	Mon, 14 Apr 2025 01:23:27 -0700 (PDT)
Date: Mon, 14 Apr 2025 09:23:24 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Mike Tipton <quic_mdtipton@quicinc.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, <arm-scmi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: scmi: Skip SCMI devices that aren't used by the
 CPUs
Message-ID: <20250414-splendid-clam-of-democracy-dacf96@sudeepholla>
References: <20250411212941.1275572-1-quic_mdtipton@quicinc.com>
 <20250414083832.GA19563@nxa18884-linux>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414083832.GA19563@nxa18884-linux>

Hi Peng,

On Mon, Apr 14, 2025 at 04:38:32PM +0800, Peng Fan wrote:
> Hi Mike,
> On Fri, Apr 11, 2025 at 02:29:41PM -0700, Mike Tipton wrote:
> >Currently, all SCMI devices with performance domains attempt to register
> >a cpufreq driver,
> 
> The scmi cpufreq device is created based on entry
> { SCMI_PROTOCOL_PERF, "cpufreq" },
> 
> So the scmi-cpufreq driver could only probe the upper single device.
> 
> How could the driver work with all SCMI devices with performance domains?
> 

IIUC, this is on a system with multiple SCMI servers/providers some of
which don't deal with CPU performance domains at all.

-- 
Regards,
Sudeep

