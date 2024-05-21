Return-Path: <linux-pm+bounces-8011-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E338CA7F2
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 08:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94869B21DD3
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 06:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF417225D4;
	Tue, 21 May 2024 06:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OfuB3+2w"
X-Original-To: linux-pm@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1C6219ED
	for <linux-pm@vger.kernel.org>; Tue, 21 May 2024 06:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716272422; cv=none; b=M/jpqnH0fHr/N6f3+KgkgM05MR53pwbjR5ILOvc0jNVYuW79OmuRjozScyEA9hxqHG23y1ybSr6JR0I6qbrDjQFQW8h96pDmqjHWnkBYMv/7sBwN+TNy5AKj4jLp1O5MBLgts3fyqiXJVjyqFMqSE12Ee5MLeprjj0jDSA0aS5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716272422; c=relaxed/simple;
	bh=6BZUhcqjL/RDEOPLPEo2clmfPNGGzQtLf1UcRAWyZ9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cvf8pQuJ2pRdA3NddQJwA8fXC8L3GI/orRDOB3PO43Dmy+4PWu/2BpW5Tb9srVXcC59Ay4PF0UDnhNdnJq1ARoCaqEdvGDZvqWPSJ9/fgpb9BIMf0U40piLCbHJZ3r+VbefBMRhPFkVOuShNEIlW8W2IntPUzMgZHYbSlHW/kqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OfuB3+2w; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=CWIIV
	4GUEqaTGKIqatiR5yz6kVykBw1VoLJ1j6G/tXA=; b=OfuB3+2wmF3u16SrlxWfl
	rbCCXsM5OzGP9Di8NEh702JJM0tv2D/fVPFl+WU465OJpovagDrnHj4KVMmYA6BQ
	X9S2KYIL0D5G2gnN/pEGWGkLKbBNTVCDG6NBbYR/+i4wbQfULzowZBb1LxX8XI2G
	/lMX37YSey6KvtLppp5lkQ=
Received: from localhost.localdomain (unknown [111.48.58.10])
	by gzga-smtp-mta-g1-2 (Coremail) with SMTP id _____wD3v5rTPExmJE9nEA--.10425S2;
	Tue, 21 May 2024 14:19:00 +0800 (CST)
From: chizhiling@163.com
To: viresh.kumar@linaro.org
Cc: chizhiling@163.com,
	chizhiling@kylinos.cn,
	linux-pm@vger.kernel.org,
	rafael@kernel.org
Subject: Re: [PATCH] cpufreq: add a check for unsupported CPU frequencies
Date: Tue, 21 May 2024 14:18:54 +0800
Message-Id: <20240521061854.3821527-1-chizhiling@163.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240520075558.ytbeguk7v2mt7p4p@vireshk-i7>
References: <20240520075558.ytbeguk7v2mt7p4p@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v5rTPExmJE9nEA--.10425S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFy7uF4rZryUtF1xKFy5XFb_yoW5CrW7pF
	WY9F4qkry8Xa1DC3y7Ww1jg3W5u3ZrZ347GryYg34Fywn8CF90ga47KF17W3Wkur45Cayf
	ZryDtayIqF15GaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JU1yxtUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbBZhnlnWV4HVerVAAAsv

On 20 May 2024 13:25:58, Viresh Kumar wrote:
> On 15-05-24, 10:20, chizhiling@163.com wrote:
> > From: Chi Zhiling <chizhiling@kylinos.cn>
> > 
> > When user wants to control the CPU frequency on their own,
> > if they write an unsupported frequency to the
> > scaling_min_freq/scaling_max_freq node, the execution will not report an
> > error, which will make the user think that the execution is successful.
> > 
> > So, this patch add a check to return an error if an unsupported frequency
> > is written.
> > 
> > Testing:
> > CPU supported frequency [min, max] = [800000, 4600000]
> > 
> > before patch:
> > root: echo 0 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
> > root: echo 5000000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
> > root: echo 0 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
> > root: echo 5000000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
> > root:
> > 
> > after patch:
> > root: echo 0 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
> > -bash: echo: Invalid argument
> > root: echo 5000000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
> > -bash: echo: Invalid argument
> > root: echo 0 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
> > -bash: echo: Invalid argument
> > root: echo 5000000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
> > -bash: echo: Invalid argument
> > root:
> > 
> > Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
> > ---
> >  drivers/cpufreq/freq_table.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> > index 10e80d912b8d..416826d582a4 100644
> > --- a/drivers/cpufreq/freq_table.c
> > +++ b/drivers/cpufreq/freq_table.c
> > @@ -76,6 +76,11 @@ int cpufreq_frequency_table_verify(struct cpufreq_policy_data *policy,
> >  	pr_debug("request for verification of policy (%u - %u kHz) for cpu %u\n",
> >  					policy->min, policy->max, policy->cpu);
> >  
> > +	if (policy->min > policy->max ||
> > +	    policy->max > policy->cpuinfo.max_freq ||
> > +	    policy->min < policy->cpuinfo.min_freq)
> > +		return -EINVAL;
> > +
> 
> I think the current behavior (of not reporting errors) is what we
> really wanted and that's why it is written that way. The kernel
> doesn't want to enforce any min/max that the user can set, the kernel
> will just get it in line with the current hardware limits.
> 
> For example consider this case for a platform with following frequency
> range, 1 ghz, 1.1 ghz, 1.2 ghz, 1.3 ghz (boost only).
> 
> Lets say boost is disabled, at this point cpuinfo.max_freq is 1.2 ghz.
> The user does this:
> 
> root: echo 1300000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
> 
> With your change this will fail, but we really want to record this
> into policy->max. As the user can enable the boost frequency now,
> which will make cpuinfo.max_freq to 1.3 ghz and user isn't required to
> set scaling_max_freq again.


You explained it very clearly, thank you for your reply.

-- 
Chi.


