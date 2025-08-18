Return-Path: <linux-pm+bounces-32528-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EEAB29F22
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 12:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B55D516443B
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 10:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447A52C235A;
	Mon, 18 Aug 2025 10:26:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2F02C2354;
	Mon, 18 Aug 2025 10:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755512801; cv=none; b=oQ85Oi4sjF9dZogPbzOacLruzBdS3KfXMiBzOa9zINTd+3HL1tpIhwL2R7siEe6atgmWOEhD86vAA3k45IoiPFdg7g31mYmh/MjqsuXiti0zAEUvudXFQST3H1uLHtIiX6lgiUxRgPgsFh+ntPeSu/X5yRpxgfn9ClGhced6zJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755512801; c=relaxed/simple;
	bh=6Z/Vq2WjM/YTa9vXXE0zlB8nTgra9GEsKtuAp7YqD4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHcOqsQl4lcumU6sFit4+nmrq01SoAJkuenPu/NzQ8CkcjnKupmamyjZwDr6yHWEDf6hidUGD++IbFam9YrWEDMkDnt3f1fn1G2YaAEVN59juaLtDou7Rz4a/5CJX7KTaZIPji1BpfkY6u/HPy8AilX7FpSY+LEmPnY6rl871Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6CED1424;
	Mon, 18 Aug 2025 03:26:29 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDFDA3F63F;
	Mon, 18 Aug 2025 03:26:35 -0700 (PDT)
Date: Mon, 18 Aug 2025 11:26:33 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
	james.quinlan@broadcom.com, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, Peng Fan <peng.fan@nxp.com>,
	Mike Tipton <quic_mdtipton@quicinc.com>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: scmi: Add quirk to disable checks in
 scmi_dev_used_by_cpus()
Message-ID: <20250818-righteous-numbat-of-champagne-d5b71c@sudeepholla>
References: <20250814225155.3519000-1-florian.fainelli@broadcom.com>
 <aJ7rBgce5eWSkkk3@pluto>
 <79711a6c-8b59-43c9-bbbc-369be1608a49@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79711a6c-8b59-43c9-bbbc-369be1608a49@broadcom.com>

On Fri, Aug 15, 2025 at 09:46:22AM -0700, Florian Fainelli wrote:

[...]

> which would be more in line with checking the Device Tree only, and it would
> also allow for unmodified backports to reach the stable trees. Contrary to
> what I suggested privately however, this check is done later, so we leave a
> chance for properly formed DT to return "true" earlier on.
>

Completely agree on keeping the backports for stable simple without the
need to backport the quirk infrastructure.

> What do you think? I am now leaning more towards that solution that
> leveraging the quirks as I agree it is somewhat unrelated.
> 

I am confused here. Do you prefer not to have SCMI quirk based solution
upstream forever ? Or are you OK to revert the fix and move to quirks
say in v6.18 and above ?

-- 
Regards,
Sudeep

