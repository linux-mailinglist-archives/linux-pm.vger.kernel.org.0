Return-Path: <linux-pm+bounces-32021-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DCFB1CC34
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 20:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C32E3BAE4D
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 18:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D5E29DB96;
	Wed,  6 Aug 2025 18:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="tHUqBro+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20D727146E;
	Wed,  6 Aug 2025 18:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754506353; cv=none; b=HVDEv+aeex3rfvs4wd5kSkaM45bLasrzOfZdpVsZbqL4n8Og+9yYPuGAVtgE4M6PI6gIjcItJ1+yf1YYoCjQHUYRPdnbKLEg7b0ZSG06Ka8US7s9BEkVNkD9nXDlCC06VdC+reEFYQP1tx6/xwKGyVEtQhPNuyQT7pubeW+coNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754506353; c=relaxed/simple;
	bh=HYuKE2kt/iqUMs4m+a4Sm4HmB9N+1ME1xjxGoQb+KMc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TY7yEY0swbWaC1VbAoU1+0OLLCHorGTeD4K6Luto0TinGrz8vKWm7hOqLrlovUNYC8RD6JHn7QKuxRI3ix8sGBM2ODu8BRvacWwNnwqbUOZdwZh5WHjIYYyJ5D9WI1w7Nus3cMSBxVCFvO6MD0/MLIfELWMXDqfak8+b0XsRvF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=tHUqBro+; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754506323; x=1755111123; i=spasswolf@web.de;
	bh=txQRTnixhS7Vyqs9XSLq+j3Zi7aCn+VHrpqWjB5kKCU=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tHUqBro+4SZ5ot8mt/OOOB2YP86YgHAIggQ8FYaJ2qixE+Njql4yzfXpjUrnrUDP
	 YdEeWpnY5bb46Em9dOXgdJH9YohgsS4pJ8+db5aahK5lSnjl2Inu3uVdtc3fdnOJC
	 C/WoeSLBofST5QE8r8bDmUK49zq2t/fAVJZlGkVukMBqFAZ5n90JTcDLin1GsmQmu
	 D3xgQltt789OT4Q6vkMsNOn/2okdgmYqvkGx3DIzsPqog6SBw6OOH1QRFZEY60tpF
	 POOyaDf8S5TTspYlVj7Iz3I68RtaHYPyhgnHzXEY00MVeqHP36+31etTQPo2c1xvk
	 miKaKAJd8KeQt2t0Lw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFJjP-1uq2uJ3kRF-00A9O6; Wed, 06
 Aug 2025 20:52:02 +0200
Message-ID: <d501ba67cbae1113c50fccf97155c1fa67a533ae.camel@web.de>
Subject: Re: loading amd-pstate-ut kernel module crashes with PREEMPT_RT
From: Bert Karwatzki <spasswolf@web.de>
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, linux-pm@vger.kernel.org, Huang Rui	
 <ray.huang@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
 Sebastian Andrzej Siewior	 <bigeasy@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, Steven Rostedt	 <rostedt@goodmis.org>,
 spasswolf@web.de
Date: Wed, 06 Aug 2025 20:52:01 +0200
In-Reply-To: <aJI9xbIllYV7ON8S@BLRRASHENOY1.amd.com>
References: <20250731092316.3191-1-spasswolf@web.de>
	 <aJI9xbIllYV7ON8S@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pcUqTZUVdT2z0lA07waNdR6KGE1zn0paiDuL1/0vZNQC9slurIN
 CnVqvMETuoag868vDAbzBowhjK/71mbVnu/dn71IBhmp5M7Cb0gHppvsf+I4YnNAdmFv5O/
 bXiERZJXr0R5uM4sFry0N2FU0vCp1eRNhQonpSVFEpBIi5oh/9je07PtzBLqpH5WpgdhuEn
 +o6xk0XPcOVfOETvGqMMQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:npk0z5mYoGk=;7d5svnN8GomrtjGKApg95O9rH77
 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

Am Dienstag, dem 05.08.2025 um 22:52 +0530 schrieb Gautham R. Shenoy:
> Hello Bert,
>=20
> On Thu, Jul 31, 2025 at 11:23:15AM +0200, Bert Karwatzki wrote:
> > When loading the amd-pstate-ut kernel module (which is supposed to tes=
t
> > the amd-pstate cpufreq driver) the following crash occurs (most of the=
=20
> > time the loading has to be repeated several times):
>=20
> Thank you for reporting this. I haven't run amd-pstate with PREEMPT_RT
> yet. But for the following issue to occur, we need the schedutil()
> governor's sugov_update_single_perf() (which will eventually acquire
> the read side of the cpufreq_driver_lock) to race with some call that
> acquires the cpufreq_driver_lock on the write-side, thus forcing the
> read-side to take the slowpath which can block on PREEMPT_RT .
>=20
> The amd-pstate-ut has the amd_pstate_ut_check_driver() which will test
> switching between one mode to another. These mode-switches involve
> unregistering the driver, and that callpath involves write-acquire of
> the cpufreq_driver_lock.
>=20
> So the race should potentially occur when the following code-path
> through the amd_pstate_ut_check_driver()
>=20
>=20
> amd_pstate_ut_check_driver()
> > -> amd_pstate_set_mode()
>  |-> amd_pstate_update_status()
>   |-> cpufreq_unregister_driver()
>    |->subsys_interface_unregister()
>     |-> cpufreq_remove_dev()
>       |-> cpufreq_policy_free(policy-cpu-X)
>        |-> write_lock_irqsave(&cpufreq_driver_lock)
>=20
> running concurrently with the schedutil governor on another CPU.
>=20
> sysvec_apic_timer_interrupt()
> > -> try_to_wake_up()
>  |-> ttwu_do_activate()
>   |-> enqueue_task_fair()
>    |-> enqueue_entity()
>     |-> update_load_avg()
>      |->sugov_update_single_freq()
>       |-> amd_pstate_adjust_perf()
>        |->cpufreq_cpu_get(on CPU Y)
>         |-> read_lock_irqsave(&cpufreq_driver_lock)
>=20
>=20
> Here, the read_lock_irqsave() has to take a slow-path in the presence
> of the writer, which can sleep on PREEMPT_RT. But this is illegal as
> this is invoked from the interrupt context.
>=20
> Can you please check if you can generate the same lock-up with the
> following script without relying on the amd-pstate-ut driver?
>=20
> -------------x8------------------x8------------------------------
> #!/bin/bash
>=20
> while ((1));
> do
>      echo "disable" > /sys/device/system/cpu/amd_pstate/status;
>      echo "guided" >  /sys/device/system/cpu/amd_pstate/status;
> done
> -------------x8------------------x8------------------------------
>=20

Yes, this script also causes the system to lock up.

Bert Karwatzki
>=20

