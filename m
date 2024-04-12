Return-Path: <linux-pm+bounces-6308-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D448A2AAA
	for <lists+linux-pm@lfdr.de>; Fri, 12 Apr 2024 11:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81CA91F233B2
	for <lists+linux-pm@lfdr.de>; Fri, 12 Apr 2024 09:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46555029E;
	Fri, 12 Apr 2024 09:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P9oyv30E"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDAC5029B
	for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2024 09:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712913293; cv=none; b=kKvmCw9zWBjSY4jucaBpbRTr8PF8db/p0JjmGFY/2fgqKwEiAjU+BHEKizgBHfmdErlBRIFz53kRNYhgI0aOMUzoBuO4dP/bxLae6TSA2i3tZhmZVtrurpIeWny68qMdLfdKi3dMSZuBfhFrlO6cqsUKjcGujT7Bd9T+KY2L/CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712913293; c=relaxed/simple;
	bh=hYY8RXIlxqYXGuny94QzgtHsP6gOYBBZQSGN+HHzmzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shNMtLLozrptuh43IdeAXvs8vvnP2GT+8XIf6GMnKUqE1b+w6YW4j+942v/DMmOZYkt2LXXPYRO3ATwTnrycMD0n8VMKh4VdxNLk/VxwwT9vreMtLRm7uch21YsxVntfZ5VlqTlH2YV2hI31yETXcNAjNoOiK4ZG7IzjLck2Fbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P9oyv30E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52337C113CC;
	Fri, 12 Apr 2024 09:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712913292;
	bh=hYY8RXIlxqYXGuny94QzgtHsP6gOYBBZQSGN+HHzmzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P9oyv30EEwEkogmoxU/TuGsKhxzvhiuO3bDI976G/vwHZnRDRDO0m2P8cSeIszx9J
	 AL60qSFKulmA1GRCa9WKWOxYhllDjqwWrTiiguretQEBlNol4jSOfBsvfTmpzki6n/
	 GVj2ISqFDdGH/3UOneFZr10tDcSjP6Y9KE2MOuoE=
Date: Fri, 12 Apr 2024 11:14:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: lizhe <sensor1010@163.com>
Cc: "viresh.kumar" <viresh.kumar@linaro.org>,
	"grygorii.strashko" <grygorii.strashko@ti.com>,
	"gregory.clement" <gregory.clement@bootlin.com>,
	"grant.likely" <grant.likely@secretlab.ca>,
	bsegall <bsegall@google.com>, broonie <broonie@kernel.org>,
	bristot <bristot@redhat.com>, brgl <brgl@bgdev.pl>,
	"f.fainelli" <f.fainelli@gmail.com>,
	"fancer.lancer" <fancer.lancer@gmail.com>,
	festevam <festevam@gmail.com>, Finn Thain <fthain@linux-m68k.org>,
	rafael <rafael@kernel.org>, linux-pm <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: exit() callback is optional
Message-ID: <2024041238-publisher-provable-7ebe@gregkh>
References: <b97964653d02225f061e0c2a650b365c354b98c8.1712900945.git.viresh.kumar@linaro.org>
 <5759bc29.32d04.18ed0ef5037.Coremail.sensor1010@163.com>
 <20240412062407.ntahibzv6xsbrnxs@vireshk-i7>
 <1b53a162.32e95.18ed0fdb13e.Coremail.sensor1010@163.com>
 <20240412063246.tk5z245miakbxws4@vireshk-i7>
 <2117690204.533771.1712904398042.JavaMail.root@mail-tracker-145-3ep34-c9h23-5f64cf7787-82gdh>
 <2024041212-bony-emphasize-75dd@gregkh>
 <663acff5.349d4.18ed18da6ff.Coremail.sensor1010@163.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <663acff5.349d4.18ed18da6ff.Coremail.sensor1010@163.com>

On Fri, Apr 12, 2024 at 05:05:05PM +0800, lizhe wrote:
> I found it first and submitted it to the main line first. Please be fair and just. Let him withdraw his patch.

lore.kernel.org links for this please?

