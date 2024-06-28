Return-Path: <linux-pm+bounces-10165-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BA491B8A2
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 09:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E840B20CD5
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 07:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761F11420DF;
	Fri, 28 Jun 2024 07:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bs+1B7XV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C1C7EF10
	for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2024 07:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719560430; cv=none; b=oswxjjELVInx+EuL6+B3sHyMvYKZ/J4dmw0cscvQ6aSIC02o9xg9fJJyCkhTjMuN/cuXrlalBI5N5znozDIn8H2z061i68LfBnOaIcXZIWFz/yvWSsgnyaUh4rrKrBrX8ULltrQ0zjzINJxDzBt22cgjrctlIRPiJnQFbzkOKso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719560430; c=relaxed/simple;
	bh=b97aaavAT71gQuYxXVf5gNgk7XjtI4OnJYwefCGe79Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7MBkWSBDFGPdPjFRyAp1OEIDvG3hfZHbybkr7RLzWDjuK3Y5aqd8veKzG/vKFqzdbun6CUgQnTpPiLlR1nOX1zcJepLQgbayDG2xfWTe4s12wbt0raI+GTR8SUF4lBu9YfwHEWD+SkPvZKPvWQ5NLn/QMSq7EuIAIe6XOB+/fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bs+1B7XV; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52cdb0d816bso314294e87.1
        for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2024 00:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719560425; x=1720165225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vqCKQJd1sf9No+GXy8/Bf8J5+zntEVmwkuLi0BwTjgI=;
        b=Bs+1B7XVEComYxGgoxtF+crITOayPMauiFzKgyA2CfdikHu+7AbSO8iMS8SeGd8IsD
         xovHN1/Xw/xIxjJspOvpnFgFmIJl9ZWiQdVVyO8tdQoqFwXmiPLuJC12uqjw01jfQ91i
         lpY0RwsBod5G8Xr8W077KFHjB1YFjULjPjiA7bCrH+cPeyaoNk1drJm1q3AmXBM+Eu/6
         Vqo7UazrxxYXiv8XRDDIqbeOZt/cKisDnaHrdqpUDFw/cZkEruYr3XJxRHM5zGeDD8Kh
         yimsjFS3upDCA3TZdvyvDHc4gvOkgpZVQefJu8W/r1lZKgf0fzh9GRzhL55uF45zGdzo
         jsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719560425; x=1720165225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqCKQJd1sf9No+GXy8/Bf8J5+zntEVmwkuLi0BwTjgI=;
        b=ZFwP9BBgL4lHLNHDKbgREcUcWE4yxqRGApEx9DGp4HLXI5rsmuj0/lGodsiUOsFY1Q
         jNsQ+dMa6splsYN9JJZpYn7gVOLiLD1x+ULXaEIQJwQ//o8EvfEKQrkWfAKQQctCRIqV
         2Msx3v41w23wCrWPCG9Sb/+1jDp9EHfE4s99Oeu9kT7HhlVvCFtEIUlf0ELXpPzKR3ml
         9AtgA64CyiDz2o01ZpykdaNO3MDrwu64TCT/EKQJuNGzkh8vF50yadsKixZAYwuMhIsK
         wPb0x35ZzSXgXFtiHKqbzAeejtGxvm/OlLTIARfTHXdEQMA9HMSchFU1JdfQ9bDMVBO+
         1qIA==
X-Forwarded-Encrypted: i=1; AJvYcCXIEqLgmWLv1eCd9WfOj6h2rBYEk83k/G8FTofs3B7FbGmGu+QSddoGGGhgRcGyEa+QxjmIjQ0zvUroK6CyOZ4zrLRnBsYBZgM=
X-Gm-Message-State: AOJu0YyNxzyd/I3Ryp9EfP27gfivv2hZza25Lv9TCxGrYz/DnFrRzsNf
	4ia3IN+W6ATuvTzK4Q/ne6YegvI7NXblR4zwdA11FdipW5bc8+WpZvDX7U57NeY=
X-Google-Smtp-Source: AGHT+IEYmcphSATZ2KnJCM6m7XxAIKEYZnMxajXKg1H7FmUiYvq5YVN4+QRc3naCioEhM8pQKheogw==
X-Received: by 2002:ac2:58d0:0:b0:52e:74dc:95c6 with SMTP id 2adb3069b0e04-52e7b901f61mr214124e87.32.1719560425205;
        Fri, 28 Jun 2024 00:40:25 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab41c30sm192344e87.306.2024.06.28.00.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 00:40:24 -0700 (PDT)
Date: Fri, 28 Jun 2024 10:40:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	angelogioacchino.delregno@collabora.com, andersson@kernel.org, konrad.dybcio@linaro.org, 
	mturquette@baylibre.com, sboyd@kernel.org, ilia.lin@kernel.org, rafael@kernel.org, 
	viresh.kumar@linaro.org, ulf.hansson@linaro.org, quic_sibis@quicinc.com, 
	otto.pflueger@abscue.de, neil.armstrong@linaro.org, luca@z3ntu.xyz, abel.vesa@linaro.org, 
	danila@jiaxyga.com, quic_ipkumar@quicinc.com, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/9] cpufreq: qcom-nvmem: Add genpd names to
 match_data_kryo
Message-ID: <kcgqm3ywdzdttllk357szirjdvdddsrcznfuwux6y237ncjnwb@3ots4rqreznu>
References: <20240626104002.420535-1-quic_varada@quicinc.com>
 <20240626104002.420535-3-quic_varada@quicinc.com>
 <za7t6ltttq2o5qwahfrzftsb7xfzbzdtg4zx3bvnf3fewhfeqf@vjrq7na5ioqm>
 <Zn5ZEI1m4jImz/Wp@hu-varada-blr.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn5ZEI1m4jImz/Wp@hu-varada-blr.qualcomm.com>

On Fri, Jun 28, 2024 at 12:02:48PM GMT, Varadarajan Narayanan wrote:
> On Wed, Jun 26, 2024 at 09:23:17PM +0300, Dmitry Baryshkov wrote:
> > On Wed, Jun 26, 2024 at 04:09:55PM GMT, Varadarajan Narayanan wrote:
> > > This is used for tying up the cpu@N nodes with the power domains.
> > > Without this, 'cat /sys/kernel/debug/qcom_cpr3/thread0'
> > > crashes with NULL pointer access.
> >
> > Add the interesting part of the backtrace, please.
> 
>         if (thread->drv->desc->cpr_type < CTRL_TYPE_CPRH) {
>                 seq_printf(s, "current_volt = %d uV\n", thread->drv->last_uV);
>                 seq_printf(s, "requested voltage: %d uV\n", thread->corner->last_uV);
>         }
> 
> thread->corner is NULL in the second printf above.
> 
> 	# cat /sys/kernel/debug/qcom_cpr3/thread0
> 	[   16.965241] Unable to handle kernel NULL pointer dereference at virtual address 000000000000000c
> 	[   16.965270] Mem abort info:
> 	[   16.973181]   ESR = 0x0000000096000004
> 	[   16.975607]   EC = 0x25: DABT (current EL), IL = 32 bits
> 	[   16.979425]   SET = 0, FnV = 0
> 	[   16.984889]   EA = 0, S1PTW = 0
> 	[   16.987756]   FSC = 0x04: level 0 translation fault
> 	[   16.990792] Data abort info:
> 	[   16.995652]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> 	[   16.998779]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> 	[   17.004074]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> 	[   17.009196] user pgtable: 4k pages, 48-bit VAs, pgdp=00000000481b1000
> 	[   17.014579] [000000000000000c] pgd=0000000000000000, p4d=0000000000000000
> 	[   17.020919] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> 	[   17.020921] Modules linked in:
> 	[   17.020926] CPU: 0 UID: 0 PID: 118 Comm: cat Not tainted 6.10.0-rc4-next-20240620-00020-g125eb3184fc1-dirty #9
> 	[   17.020931] Hardware name: Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C7 (DT)
> 	[   17.020933] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> 	[   17.020936] pc : cpr3_debug_info_show+0x3a0/0x3ac
> 	[   17.020945] lr : cpr3_debug_info_show+0x390/0x3ac
> 	[   17.020948] sp : ffff800086293b90
> 	[   17.020949] x29: ffff800086293b90 x28: ffff0000034ae038 x27: 0000000000400cc0
> 	[   17.020953] x26: 000000007ffff000 x25: ffff0000034ae028 x24: 0000000000000000
> 	[   17.020957] x23: ffff800086293c80 x22: ffff000002399880 x21: ffff000002a8fa80
> 	[   17.020960] x20: ffff0000034ae000 x19: 0000000000000000 x18: ffffffffffffffff
> 	[   17.020964] x17: 0000000000000000 x16: 0000000000000000 x15: ffff800086293a40
> 	[   17.020967] x14: ffff000002913000 x13: ffff00000291200f x12: 0000000000000000
> 	[   17.020970] x11: 0000000000000000 x10: 0000000000000000 x9 : ffff0000034a9000
> 	[   17.020973] x8 : 000000000a567520 x7 : 0000000000000001 x6 : 000000000a567520
> 	[   17.020976] x5 : ffff000002912014 x4 : ffff800080e1f3a5 x3 : 0000000000000014
> 	[   17.020979] x2 : 0000000000000000 x1 : ffff800080e1f848 x0 : ffff0000034ae000
> 	[   17.020983] Call trace:
> 	[   17.020984]  cpr3_debug_info_show+0x3a0/0x3ac
> 	[   17.020987]  seq_read_iter+0xe0/0x45c
> 	[   17.020993]  seq_read+0xec/0x130
> 	[   17.020996]  full_proxy_read+0x60/0xb4
> 	[   17.020999]  vfs_read+0xc0/0x31c
> 	[   17.021003]  ksys_read+0x70/0x104
> 	[   17.021006]  __arm64_sys_read+0x1c/0x28
> 	[   17.021008]  invoke_syscall+0x48/0x114
> 	[   17.021014]  el0_svc_common+0x3c/0xe8
> 	[   17.021017]  do_el0_svc+0x20/0x2c
> 	[   17.021020]  el0_svc+0x34/0xd8
> 	[   17.021024]  el0t_64_sync_handler+0x120/0x12c
> 	[   17.021027]  el0t_64_sync+0x190/0x194
> 	[   17.021031] Code: f94012c2 aa1403e0 b0004701 91212021 (b9400c42)
> 	[   17.021033] ---[ end trace 0000000000000000 ]---
> 	Segmentation fault

Well, I asked to add it, so please drop the timestamps and registers and
include it into the commit message. While you are at it, please review
Documentation/process/submitting-patches.rst and change the commit
message to follow the guidelines.

While doing so (and while responding to a comment below) you will notice
that this change should not be applied to the generic match_data_kryo
instance. Instead you should add a device-specific entry into match
table and use struct qcom_cpufreq_match_data instance that has
.genpd_names set.

> 
> > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > ---
> > >  drivers/cpufreq/qcom-cpufreq-nvmem.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > > index 939702dfa73f..5e6525c7788c 100644
> > > --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > > +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > > @@ -399,6 +399,7 @@ static const char *generic_genpd_names[] = { "perf", NULL };
> > >
> > >  static const struct qcom_cpufreq_match_data match_data_kryo = {
> > >  	.get_version = qcom_cpufreq_kryo_name_version,
> > > +	.genpd_names = generic_genpd_names,
> >
> > This forces that every Kryo SoC has "perf" genpd, which obviously isn't
> > corret (at least from the upstream support point of view).
> 
> While trying to get the above backtrace, randomly during boot
> I see the following BUG too.

This isn't a response to my comment.

> 
> 	[    1.562847] ------------[ cut here ]------------
> 	[    1.574342] kernel BUG at drivers/cpufreq/cpufreq.c:1542!
> 	[    1.579203] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
> 	[    1.579209] Modules linked in:
> 	[    1.579217] CPU: 2 UID: 0 PID: 11 Comm: kworker/u16:0 Not tainted 6.10.0-rc4-next-20240620-00020-g125eb3184fc1-dirty #10
> 	[    1.579227] Hardware name: Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C7 (DT)
> 	[    1.579232] Workqueue: events_unbound deferred_probe_work_func
> 	[    1.579249] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> 	[    1.579257] pc : cpufreq_online+0x938/0x954
> 	[    1.579271] lr : cpufreq_online+0x788/0x954
> 	[    1.579281] sp : ffff8000817c3520
> 	[    1.579283] x29: ffff8000817c3520 x28: ffff0000029efa50 x27: 0000000000000001
> 	[    1.579294] x26: 0000000000000001 x25: ffff8000814d8da0 x24: 0000000000000000
> 	[    1.579303] x23: ffff0000029ef9d0 x22: ffff800081735000 x21: 0000000000000000
> 	[    1.579312] x20: 00000000000c15c0 x19: ffff0000029ef800 x18: ffff00000183481c
> 	[    1.579321] x17: ffff8000818a3638 x16: 0000000000000000 x15: ffff8000818a3670
> 	[    1.579330] x14: 0000000000000003 x13: ffff00000192b140 x12: ffff8000814d8c58
> 	[    1.579338] x11: ffff00000192b140 x10: 00000000000009b0 x9 : ffff8000817c3240
> 	[    1.579347] x8 : ffff00000192bad0 x7 : 0000000000000001 x6 : ffff8000814d8da0
> 	[    1.579355] x5 : ffff8000812c32d0 x4 : 0000000000000000 x3 : 0000000000000000
> 	[    1.579363] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 00000000fffffff0
> 	[    1.579372] Call trace:
> 	[    1.579375]  cpufreq_online+0x938/0x954
> 	[    1.579386]  cpufreq_add_dev+0x80/0x98
> 	[    1.579395]  subsys_interface_register+0x100/0x130
> 	[    1.579404]  cpufreq_register_driver+0x150/0x244
> 	[    1.579413]  dt_cpufreq_probe+0x8c/0x440
> 	[    1.579420]  platform_probe+0x68/0xc8
> 	[    1.579430]  really_probe+0xbc/0x29c
> 	[    1.579438]  __driver_probe_device+0x78/0x12c
> 	[    1.579446]  driver_probe_device+0xd8/0x15c
> 	[    1.579454]  __device_attach_driver+0xb8/0x134
> 	[    1.579463]  bus_for_each_drv+0x84/0xe0
> 	[    1.579470]  __device_attach+0x9c/0x188
> 	[    1.579478]  device_initial_probe+0x14/0x20
> 	[    1.579487]  bus_probe_device+0xac/0xb0
> 	[    1.579494]  device_add+0x55c/0x720
> 	[    1.579500]  platform_device_add+0x1b8/0x244
> 	[    1.579510]  platform_device_register_full+0xfc/0x184
> 	[    1.579516]  platform_device_register_resndata.constprop.0+0x5c/0x8c
> 	[    1.579524]  qcom_cpufreq_probe+0x1e4/0x498
> 	[    1.579531]  platform_probe+0x68/0xc8
> 	[    1.579540]  really_probe+0xbc/0x29c
> 	[    1.579548]  __driver_probe_device+0x78/0x12c
> 	[    1.579556]  driver_probe_device+0xd8/0x15c
> 	[    1.579564]  __device_attach_driver+0xb8/0x134
> 	[    1.579573]  bus_for_each_drv+0x84/0xe0
> 	[    1.579580]  __device_attach+0x9c/0x188
> 	[    1.579588]  device_initial_probe+0x14/0x20
> 	[    1.579596]  bus_probe_device+0xac/0xb0
> 	[    1.579603]  deferred_probe_work_func+0x88/0xc0
> 	[    1.579611]  process_one_work+0x148/0x28c
> 	[    1.579623]  worker_thread+0x2e8/0x3f8
> 	[    1.579633]  kthread+0x110/0x114
> 	[    1.579641]  ret_from_fork+0x10/0x20
> 	[    1.579653] Code: aa1703e0 52800021 97e38ed5 17ffffea (d4210000)
> 	[    1.579657] ---[ end trace 0000000000000000 ]---
> 	[    1.851078] note: kworker/u16:0[11] exited with irqs disabled
> 	[    1.855791] note: kworker/u16:0[11] exited with preempt_count 1
> 	[    1.861586] ------------[ cut here ]------------
> 
> Randomly, the following call seems to return -EBUSY causing
> the above BUG().
> 
> 	ret = __cpufreq_driver_target(policy, old_freq - 1,
> 				      CPUFREQ_RELATION_L);
> 
> 	/*
> 	 * Reaching here after boot in a few seconds may not
> 	 * mean that system will remain stable at "unknown"
> 	 * frequency for longer duration. Hence, a BUG_ON().
> 	 */
> 	BUG_ON(ret);
> 
> Not sure why this does not happen in every boot, and how it
> is tied to genpd_names. Will debug and update.

Thanks!

-- 
With best wishes
Dmitry

