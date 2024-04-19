Return-Path: <linux-pm+bounces-6715-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F638AADF2
	for <lists+linux-pm@lfdr.de>; Fri, 19 Apr 2024 13:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB7B41C20C6E
	for <lists+linux-pm@lfdr.de>; Fri, 19 Apr 2024 11:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3077183A07;
	Fri, 19 Apr 2024 11:56:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5C37FBDF
	for <linux-pm@vger.kernel.org>; Fri, 19 Apr 2024 11:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713527797; cv=none; b=RRLaZAthRXLOdTh8RoK9O0xWmfx1pgdX/BuVaRiX9wtuFbR56Heck/ldPChuQu1RgH8VO/w9xm0z3eYyfzqq8ogvG3OP/TokpcEzPY2E9gKJfOvbcivK9H9wDBl+cdasLxHatl2Jgg92+Im53y/rHubdEul1QsbXDDZ8/0AeBWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713527797; c=relaxed/simple;
	bh=T3STDVe7xxU2a7JoWtzmlCoWg5g6NQdOyEj8aWsFGW0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N7yDyfC9DfaKFoILRxoGD3H2UHd83oXom3eTqGHGVOfAtl5jBkMVOHaECfOSPPquovAmT2JI7zq4nyqkZY7Y3zJRO4VR5uOGed2NYyYezhCUA2Lnt6usb7hZZSlHEDLCzZso2l7IF5VQ8BAEsCfvZNM2KzMtyAzx3j2zCSTJmW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19CCF2F;
	Fri, 19 Apr 2024 04:57:02 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13DF73F64C;
	Fri, 19 Apr 2024 04:56:32 -0700 (PDT)
Date: Fri, 19 Apr 2024 12:56:30 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: kernel test robot <lkp@intel.com>, Brandon Cheo Fusi
 <fusibrandon13@gmail.com>, oe-kbuild-all@lists.linux.dev, Jernej Skrabec
 <jernej.skrabec@gmail.com>, linux-pm@vger.kernel.org
Subject: Re: [vireshk-pm:cpufreq/arm/linux-next 6/10]
 drivers/cpufreq/sun50i-cpufreq-nvmem.c:128:44: warning: '%d' directive
 output may be truncated writing between 1 and 10 bytes into a region of
 size 2
Message-ID: <20240419125630.7951b45c@donnerap.manchester.arm.com>
In-Reply-To: <20240419105628.faaqz2p4qdlfxyre@vireshk-i7>
References: <202404191715.LDwMm2gP-lkp@intel.com>
	<20240419111345.028ad7ec@donnerap.manchester.arm.com>
	<20240419105628.faaqz2p4qdlfxyre@vireshk-i7>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Apr 2024 16:26:28 +0530
Viresh Kumar <viresh.kumar@linaro.org> wrote:

Hi Viresh,

> On 19-04-24, 11:13, Andre Przywara wrote:
> > So I see the problem: "speed" must fit into one decimal digit. At the
> > moment it's fine, because "speed" is returned by one of the *_efuse_xlate
> > functions. For the H6, the output is masked by 0x7, so can never be larger
> > than that. For the H616, the return value is a constant selected in a
> > switch/case, which is at most "4" at the moment, so it's safe as well.
> > 
> > So is there some established way to communicate this, to appease gcc here?
> > Would explicitly checking for the range and bailing out solve this? Or is
> > the some kind of assert to make gcc happy?
> > Or do we just increase MAX_NAME_LEN?  
> 
> I fixed it like this in the OPP core earlier:

Ah, yes, thanks, that looks good to me, and indeed fixes the warning.

How are we going to handle this? Do you gonna squash this into the
respective patch?

Cheers,
Andre

> 
> diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> index 30e5c337611c..cd50cea16a87 100644
> --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> @@ -19,8 +19,6 @@
>  #include <linux/pm_opp.h>
>  #include <linux/slab.h>
> 
> -#define MAX_NAME_LEN   7
> -
>  #define NVMEM_MASK     0x7
>  #define NVMEM_SHIFT    5
> 
> @@ -208,7 +206,7 @@ static int sun50i_cpufreq_get_efuse(void)
>  static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
>  {
>         int *opp_tokens;
> -       char name[MAX_NAME_LEN];
> +       char name[] = "speedXXXXXXXXXXX"; /* Integers can take 11 chars max */
>         unsigned int cpu, supported_hw;
>         struct dev_pm_opp_config config = {};
>         int speed;
> @@ -235,7 +233,7 @@ static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
>                 config.supported_hw_count = 1;
>         }
> 
> -       snprintf(name, MAX_NAME_LEN, "speed%d", speed);
> +       snprintf(name, sizeof(name), "speed%d", speed);
>         config.prop_name = name;
> 
>         for_each_possible_cpu(cpu) {
> 


