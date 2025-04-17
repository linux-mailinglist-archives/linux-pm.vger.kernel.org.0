Return-Path: <linux-pm+bounces-25600-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A74A91497
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 09:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587AA19E006A
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 07:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03254218ABD;
	Thu, 17 Apr 2025 06:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0XnOR9/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E8C218ADC;
	Thu, 17 Apr 2025 06:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744873067; cv=none; b=bDLy5lRWH1wTt2bp25vJGWyI2DcS2iwF3FHiU89fXObTZuf2HSIH+fhy24+aofs7Bck9P/DGzFmHwMHJfTXQpWfLuJuxcIQHgrpHgdowmro7WeAUPnXo95GE/PpTv6sJ4DyuaFqLn0wdj68XfVT8XXzI7kIACYRYaKJGKhczAr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744873067; c=relaxed/simple;
	bh=/PWTZEMbGQ3UyfVIdX4FNP9ZBka66rFtLWONMckbvtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cn3H5csQjC4ws2TmbrJBrre12CZc2o2WP6ZcjtosoEes1risvIHqYHAt5/hescAJNHOv0AZ5yv8DxCJ9GK3bBLG9UiaLP5o0qS1/hjKgFea0Rz+vSqckJ37fAr7jIsdDcnHnJ1lDARJkIZkhPHC+YGw8sC9zIfLolWGygHOqsp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0XnOR9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40478C4CEE4;
	Thu, 17 Apr 2025 06:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744873066;
	bh=/PWTZEMbGQ3UyfVIdX4FNP9ZBka66rFtLWONMckbvtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r0XnOR9/FN+oBxAAWd3Otn81xxSI2Q5irmhAr1XxFzVIq814mcDLYt94hs4pwPiLw
	 SZcKH8MOaJjy3CeF7zkDqcQXFdli21Y8rau3sEXKExbpS7tHKwOrqB8zTr0RjZW8rA
	 q7tpGBsKMp/5ikyjaEUgqRZ6nB4lwMSGaSlXVY5WrGki9JaCi3SP/tzYIjaZgU4Spa
	 gibhvZyeHj/UkWbMjmYEKpoZwUjphoBh5UGgxlhcVJaKqpU9vI5Gk1uzFSwOmIesTQ
	 Fz68Q+hoIeWm644WUz25F9jLOdS33dK7M49L89dGxe4VSTpWM6oW/1AEa4tQwwXkBA
	 zAYTLM9GgmQuQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1u5JBx-000000005bs-3Dzg;
	Thu, 17 Apr 2025 08:57:45 +0200
Date: Thu, 17 Apr 2025 08:57:45 +0200
From: Johan Hovold <johan@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Rob Herring (Arm)" <robh@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: fix compile-test defaults
Message-ID: <aACmabdI0o_TxuNk@hovoldconsulting.com>
References: <20250416134331.7604-1-johan+linaro@kernel.org>
 <20250417042500.tbuupp3jdpfkk7kh@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417042500.tbuupp3jdpfkk7kh@vireshk-i7>

On Thu, Apr 17, 2025 at 09:55:00AM +0530, Viresh Kumar wrote:
> On 16-04-25, 15:43, Johan Hovold wrote:
> > Commit 3f66425a4fc8 ("cpufreq: Enable COMPILE_TEST on Arm drivers")
> > enabled compile testing of most Arm CPUFreq drivers but left the
> > existing default values unchanged so that many drivers are enabled by
> > default whenever COMPILE_TEST is selected.

> > Fix the default values for drivers that can be compile tested and that
> > should be enabled by default when not compile testing.
> > 
> > Fixes: 3f66425a4fc8 ("cpufreq: Enable COMPILE_TEST on Arm drivers")

> I have already applied a similar patch:
> 
> https://lore.kernel.org/all/20250404124006.362723-1-krzysztof.kozlowski@linaro.org/
> 
> Can you rebase over that please ?

Ah, sorry, I forgot to check linux-next.

Just sent a rebased v2 here:

	https://lore.kernel.org/lkml/20250417065535.21358-1-johan+linaro@kernel.org/

Johan

