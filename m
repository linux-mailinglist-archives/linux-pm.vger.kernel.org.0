Return-Path: <linux-pm+bounces-1213-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB042814C1B
	for <lists+linux-pm@lfdr.de>; Fri, 15 Dec 2023 16:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08E49B20E96
	for <lists+linux-pm@lfdr.de>; Fri, 15 Dec 2023 15:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C361374EA;
	Fri, 15 Dec 2023 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JtXwfJR3"
X-Original-To: linux-pm@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E61536AF3
	for <linux-pm@vger.kernel.org>; Fri, 15 Dec 2023 15:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=x3iOjyDjnduKSLdjyt4m5pxrmBvVRyhz1EAUvOF097g=; b=JtXwfJR3KEkBSfjQa7+VkMapC7
	ZW5TGsaSUS7c65r4sqMOLf7TF2uCMWxZi6DWAGpF0bJdPLhUEw7rsxxxpnVdTRNFZvKW84mqA4j3x
	XfOgb9Aolqb+QtUkW6WobK+jY3i76U/xFr05M+Onq2exbx3IIVwja98WUnwE7xotIeiw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rEATW-0032Pf-LD; Fri, 15 Dec 2023 16:51:42 +0100
Date: Fri, 15 Dec 2023 16:51:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] cpufreq: armada-8k: Fix parameter type warning
Message-ID: <62f5e43a-a381-4bc0-ad75-e716a98a0ad9@lunn.ch>
References: <20231215153706.2087883-1-gregory.clement@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215153706.2087883-1-gregory.clement@bootlin.com>

On Fri, Dec 15, 2023 at 04:37:06PM +0100, Gregory CLEMENT wrote:
> The second parameter of clk_get() is of type 'const char *', so use
> NULL instead of the integer 0 to resolve a sparse warning:
> 
> drivers/cpufreq/armada-8k-cpufreq.c:60:40: warning: Using plain integer as NULL pointer
> drivers/cpufreq/armada-8k-cpufreq.c:168:40: warning: Using plain integer as NULL pointer
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312141651.lCAXGAZ2-lkp@intel.com/
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

