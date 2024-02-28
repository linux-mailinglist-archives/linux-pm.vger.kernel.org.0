Return-Path: <linux-pm+bounces-4521-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0936D86B587
	for <lists+linux-pm@lfdr.de>; Wed, 28 Feb 2024 18:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1387AB25C1A
	for <lists+linux-pm@lfdr.de>; Wed, 28 Feb 2024 17:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC7915D5B3;
	Wed, 28 Feb 2024 17:05:56 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78EA159587
	for <linux-pm@vger.kernel.org>; Wed, 28 Feb 2024 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709139956; cv=none; b=oDVQjg1uMs9u7eiCYLMcv4dzwnnksx8Un5h9SOdzvtGxhldpnyrHsoKM2siq5qMkWd4ncWnPdYXKgd3sgL13EhMdDKTwVxpjDv+9vJjX2DxkeE70ezGf8ieljBB0V48w+O5Ar8jKC5aZFhM+07MOFa1vAu+lUPQ+UX4EJfH+odY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709139956; c=relaxed/simple;
	bh=9YXR46DUab9K9DJSXzbzQW4bBkwni8ycrvseLJm5I6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMxNWbKT48VTdwLD7PtZELtCWC9DWuqt8SRmZXwjRey0fr5RXwFpjX1U9XM17wuvDJhAfz8/jM98M3QetpvEzyKVnoXACtLKNtsDdq/e+P+zcnPb45nYL1e6OqV4giwmCLepRl8lIJ0CZtCFyQKOE8w7qBgI3ISHN+YvpKTu78Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5A6EC15;
	Wed, 28 Feb 2024 09:06:32 -0800 (PST)
Received: from bogus (unknown [10.57.94.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 874FC3F762;
	Wed, 28 Feb 2024 09:05:52 -0800 (PST)
Date: Wed, 28 Feb 2024 17:05:50 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] cpuidle: psci: Drop superfluous wrappers
 psci_dt_attach|detach_cpu()
Message-ID: <20240228170550.mpi57iyxqzcbhdr5@bogus>
References: <20240228151139.2650258-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228151139.2650258-1-ulf.hansson@linaro.org>

On Wed, Feb 28, 2024 at 04:11:39PM +0100, Ulf Hansson wrote:
> To simplify the code, let's drop psci_dt_attach|detach_cpu() and use the
> common dt_idle_attach|detach_cpu() directly instead.
>

LGTM,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep

