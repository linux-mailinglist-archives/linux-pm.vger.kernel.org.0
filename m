Return-Path: <linux-pm+bounces-22408-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FFFA3BB29
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 11:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6683165D3B
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 10:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917161C5D4B;
	Wed, 19 Feb 2025 10:03:48 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986811C4A20
	for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 10:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739959428; cv=none; b=YCbO6D/uRafR7uLjsnY8CxDr0sATZzq8KBGUgc6f6NgQCjdKyt+JiSfp4+6dRP6vOnZdpKSaxEIRvB/stsivKN03sE4hZlWq9ydr5u2jS8QxxWmHTKOinqBzf4HueJWynv1b5FeQuwyNBuo5ShaS/gbDbnTvzI6/2JghpMtqvMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739959428; c=relaxed/simple;
	bh=XtrtCZV0lkdsjUSl6ULUvq1IW08NkPaiwEYGsGULFgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXy49lKoePGaiKbiv6GMFr0zU4DmEKuiq7mSiCLakXzB18rH+bZlm1p8s+x0gxjk/9ZQWIvTMyhmPyzSYV7hsCoI+qLL3boN2Zj0sJqVmgeOOnKW7nDw4tRAD5nZfB0d3Eec5Eo7hyCqghFqXX1aTMXR4MP6NJpTl89O2TW/Ujg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 511E61682;
	Wed, 19 Feb 2025 02:04:04 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57BBB3F6A8;
	Wed, 19 Feb 2025 02:03:44 -0800 (PST)
Date: Wed, 19 Feb 2025 10:03:41 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	<linux-rockchip@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH] pmdomain: rockchip: Check if smcc could be handled by TA
Message-ID: <Z7WsfWq1dC71uls0@bogus>
References: <1739926689-151827-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1739926689-151827-1-git-send-email-shawn.lin@rock-chips.com>

On Wed, Feb 19, 2025 at 08:58:09AM +0800, Shawn Lin wrote:
> Non-existent trusted-firmware could lead smcc calls into some
> unset location which breaks the system.
>

s/smcc/SMC or s/smcc/SMCCC please. There is nothing called smcc

--
Regards,
Sudeep

