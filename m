Return-Path: <linux-pm+bounces-35241-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBD1B96DD6
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 18:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C299C3B5F8E
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 16:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54791328589;
	Tue, 23 Sep 2025 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RzhNiRle"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0037232340F;
	Tue, 23 Sep 2025 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758645821; cv=none; b=OEZJEHbBjEm5aiXVUPbCA8DR5XnwoVFZhDmqlZ5CZbl0Ji4/HqlpXg5QhIYab6NsLEK1HG1a2ksZJdegQry1o2taiqzbVNm659vApXXNhpP5aMhN9CK0sWkXL1fJO6TLLlrWFDQh9JQxFN+OkPBWxH3rbKkq+uoRCcpST4a2XG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758645821; c=relaxed/simple;
	bh=k8jA/Vr6JqeHR8HYy1whNk2r3CDd2XljOKC50tsH8cU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDXel8yOTPYHaLd4A0OjavfcbkGzEaRc92/U8LgQG7znt7VYt2Do67taDkMeg84fQPl9vkSYILl5AdArYwdNlOZTCLdnzEu+785ToFOurNB2FuOa6oeprdvQLd+ZFK3ZrfDpT23o3D2d4D6KJ7037xzzJz499zT2lR1iQOvRidQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RzhNiRle; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58NGhRSf1031169;
	Tue, 23 Sep 2025 11:43:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758645807;
	bh=fqSCirw/c8Z7cc7b3Ln2Cy6x+uK8X79dKr/wAnlsOcY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=RzhNiRleFvGzFtS7QlTL31hOglTmJH+doc1mt1Goo1JfLD1M2wDGroJYO28Tx6QKx
	 ioiVIohHXLfssICYHEtrtl8UjTO70dG/ri1aqVcxvAUGxcvrp5RtHC/wP3E9YWwSd2
	 RdWYLTmg61BX1lVFsKEtTul7G2VHDRnDZe1dILvA=
Received: from DLEE209.ent.ti.com (dlee209.ent.ti.com [157.170.170.98])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58NGhQGp1796207
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Sep 2025 11:43:26 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Sep
 2025 11:43:26 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 11:43:26 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58NGhPYk346672;
	Tue, 23 Sep 2025 11:43:26 -0500
Date: Tue, 23 Sep 2025 22:13:24 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman
	<khilman@baylibre.com>, <linux-pm@vger.kernel.org>,
        Pavel Machek
	<pavel@kernel.org>, Len Brown <len.brown@intel.com>,
        Daniel Lezcano
	<daniel.lezcano@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Maulik
 Shah <quic_mkshah@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/PATCH 1/3] PM: QoS: Introduce a system-wakeup QoS limit
Message-ID: <20250923164324.mo6gkzlfb6y7spvo@lcpd911>
References: <7hldnp6apf.fsf@baylibre.com>
 <CAJZ5v0j=9RXHrcVEBp0yy1Ae4_kC1y-WFQyBf89r3NtoL-tYQw@mail.gmail.com>
 <CAPDyKFpeVF_EHJDQ9u=LDuJ56g7ykYUQWHXV2WXTYLa-mYahVA@mail.gmail.com>
 <CAPDyKFpc-PHC1QhoSrNt9KnaGov749H1AwFZUwnDDzG7RDYBRw@mail.gmail.com>
 <CAJZ5v0hC=sEcC-mU8jArwVN3EA6+U=EmCa2e7TKO0sg6LJiz7g@mail.gmail.com>
 <CAPDyKFqG=bFSP2rJ3PXt5=6_nLdpJ+ir80krU1DrRCCMhwKQng@mail.gmail.com>
 <CAJZ5v0hYN5G_WpA6KDpeDgowc2i9AvrUBCq-egS==8RNVb6N=w@mail.gmail.com>
 <CAPDyKFr0-yh8wt169QanAo3AmuXBq_9p3xiiqeFmmWz-ntNQsw@mail.gmail.com>
 <CAJZ5v0h4nS7fm347ue0Kj_eGwAi=o1vzyJm25_Q67dWzyoXR+Q@mail.gmail.com>
 <CAPDyKFos=rM6Y-6tFbifpFp8XxwA=t_aya-nWhz=6ME1FaBEoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPDyKFos=rM6Y-6tFbifpFp8XxwA=t_aya-nWhz=6ME1FaBEoA@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Ulf,

On Sep 23, 2025 at 14:36:53 +0200, Ulf Hansson wrote:
> On Tue, 23 Sept 2025 at 13:39, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Tue, Sep 23, 2025 at 11:42 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Mon, 22 Sept 2025 at 20:55, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Thu, Sep 18, 2025 at 5:34 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > >
> > > > > On Wed, 17 Sept 2025 at 21:24, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > Sorry for the delay.
> > > > > >
> > > > > > On Fri, Sep 12, 2025 at 3:58 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > > >
> > > > > > > On Tue, 12 Aug 2025 at 11:26, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > > > >
> > > > > > > > On Mon, 11 Aug 2025 at 21:16, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Aug 11, 2025 at 7:16 PM Kevin Hilman <khilman@baylibre.com> wrote:
> > > > > > > > > >
> > > > > > > > > > "Rafael J. Wysocki" <rafael@kernel.org> writes:
> > > > > > > > > >
> > > > > > > > > > > On Wed, Jul 16, 2025 at 2:33 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > > > > > > >>
> > > > > > > > > > >> Some platforms and devices supports multiple low-power-states than can be
> > > > > > > > > > >> used for system-wide suspend. Today these states are selected on per
> > > > > > > > > > >> subsystem basis and in most cases it's the deepest possible state that
> > > > > > > > > > >> becomes selected.
> > > > > > > > > > >>
> > > > > > > > > > >> For some use-cases this is a problem as it isn't suitable or even breaks
> > > > > > > > > > >> the system-wakeup latency constraint, when we decide to enter these deeper
> > > > > > > > > > >> states during system-wide suspend.
> > > > > > > > > > >>
> > > > > > > > > > >> Therefore, let's introduce an interface for user-space, allowing us to
> > > > > > > > > > >> specify the system-wakeup QoS limit. Subsequent changes will start taking
> > > > > > > > > > >> into account the QoS limit.
> > > > > > > > > > >
> > > > > > > > > > > Well, this is not really a system-wakeup limit, but a CPU idle state
> > > > > > > > > > > latency limit for states entered in the last step of suspend-to-idle.
> > > > > > > > > > >
> > > > > > > > > > > It looks like the problem is that the existing CPU latency QoS is not
> > > > > > > > > > > taken into account by suspend-to-idle, so instead of adding an
> > > > > > > > > > > entirely new interface to overcome this, would it make sense to add an
> > > > > > > > > > > ioctl() to the existing one that would allow the user of it to
> > > > > > > > > > > indicate that the given request should also be respected by
> > > > > > > > > > > suspend-to-idle?
> > > > > > > > > > >
> > > > > > > > > > > There are two basic reasons why I think so:
> > > > > > > > > > > (1) The requests that you want to be respected by suspend-to-idle
> > > > > > > > > > > should also be respected by the regular "runtime" idle, or at least I
> > > > > > > > > > > don't see a reason why it wouldn't be the case.
> > > > > > > > > > > (2) The new interface introduced by this patch basically duplicates
> > > > > > > > > > > the existing one.
> > > > > > > > > >
> > > > > > > > > > I also think that just using the existing /dev/cpu_dma_latency is the
> > > > > > > > > > right approach here, and simply teaching s2idle to respect this value.
> > > > > > > > > >
> > > > > > > > > > I'm curious about the need for a new ioctl() though.  Under what
> > > > > > > > > > conditions do you want normal/runtime CPUidle to respect this value and
> > > > > > > > > > s2idle to not respect this value?
> > > > > > > > >
> > > > > > > > > In a typical PC environment s2idle is a replacement for ACPI S3 which
> > > > > > > > > does not take any QoS constraints into account, so users may want to
> > > > > > > > > set QoS limits for run-time and then suspend with the expectation that
> > > > > > > > > QoS will not affect it.
> > > > > > > >
> > > > > > > > Yes, I agree. To me, these are orthogonal use-cases which could have
> > > > > > > > different wakeup latency constraints.
> > > > > > > >
> > > > > > > > Adding an ioctl for /dev/cpu_dma_latency, as suggested by Rafael would
> > > > > > > > allow this to be managed, I think.
> > > > > > > >
> > > > > > > > Although, I am not fully convinced yet that re-using
> > > > > > > > /dev/cpu_dma_latency is the right path. The main reason is that I
> > > > > > > > don't want us to limit the use-case to CPU latencies, but rather allow
> > > > > > > > the QoS constraint to be system-wide for any type of device. For
> > > > > > > > example, it could be used by storage drivers too (like NVMe, UFS,
> > > > > > > > eMMC), as a way to understand what low power state to pick as system
> > > > > > > > wide suspend. If you have a closer look at patch2 [1] , I suggest we
> > > > > > > > extend the genpd-governor for *both* CPU-cluster-PM-domains and for
> > > > > > > > other PM-domains too.
> > > > > > > >
> > > > > > > > Interested to hear your thoughts around this.
> > > > > > >
> > > > > > > Hey, just wanted to see if you have managed to digest this and have
> > > > > > > any possible further comment?
> > > > > >
> > > > > > The reason why I thought about reusing /dev/cpu_dma_latency is because
> > > > > > I think that the s2idle limit should also apply to cpuidle.  Of
> > > > > > course, cpuidle may be limited further, but IMV it should observe the
> > > > > > limit set on system suspend (it would be kind of inconsistent to allow
> > > > > > cpuidle to use deeper idle states than can be used by s2idle).
> > > > >
> > > > > Agreed!
> > > > >
> > > > > >
> > > > > > I also don't think that having a per-CPU s2idle limit would be
> > > > > > particularly useful (and it might be problematic).
> > > > > >
> > > > > > Now, it is not as straightforward as I thought because someone may
> > > > > > want to set a more restrictive limit on cpuidle, in which case they
> > > > > > would need to open the same special device file twice etc and that
> > > > > > would be quite cumbersome.
> > > > > >
> > > > > > So in the end I think that what you did in the $subject patch is
> > > > > > better, but I still would like it to also affect cpuidle.
> > > > >
> > > > > Okay. I will update the patches according to your suggestions!
> > > > >
> > > > > >
> > > > > > And it needs to be made clear that this is a limit on the resume
> > > > > > latency of one device.  Worst case, the system wakeup latency may be a
> > > > > > sum of those limits if the devices in question are resumed
> > > > > > sequentially, so in fact this is a limit on the contribution of a
> > > > > > given device to the system wakeup latency.
> > > > >
> > > > > Indeed, that's a very good point! I will keep this in mind when
> > > > > working on adding the documentation part.
> > > >
> > > > Well, this also means that using one limit for all of the different
> > > > devices is not likely to be very practical because the goal is to save
> > > > as much energy as reasonably possible in system suspend while
> > > > respecting a global resume latency constraint at the same time.
> > > >
> > > > Using the same limit on a local contribution from each device to the
> > > > combined latency is not likely to be effective here.  Rather, I'd
> > > > expect that the best results can be achieved by setting different
> > > > resume latency limits on different devices, depending on how much
> > > > power they draw in each of their idle states and what the exit latency
> > > > values for all of those states are.  In other words, this appears to
> > > > be an optimization problem in which the resume latency limits for
> > > > individual devices need to be chosen to satisfy the global resume
> > > > latency constraint and minimize the total system power.
> > >
> > > I am following your reasoning and I agree!
> > >
> > > Perhaps we should start with extending the cpu_dma_latency with an
> > > ioctl after all? This would allow userspace to specify constraints to
> > > be applicable for system-wide-suspend (s2idle), but it would still be
> > > limited for CPUs/CPU-clusters.
> >
> > Right.
> >
> > Adding a separate device special file to represent the limit affecting
> > s2idle may be somewhat cleaner though as mentioned before.
> 
> Okay, sounds good to me too!
> 
> >
> > > For other devices, we should probably explore the per device PM QoS
> > > (pm_qos_latency_tolerance_us) instead. Currently the
> > > pm_qos_latency_tolerance_us is used for "runtime_suspend", so perhaps
> > > adding another per device sysfs file, like
> > > "pm_qos_system_wakeup_latency_us",  that we can use for the
> > > system-wide-wakeup latency constraint?
> > >
> > > Would this make better sense, you think?
> >
> > I think that this can be made work.
> 
> Okay, I will explore this approach.

I think this is kind of similar to how we did it for the TI SCI
pmdomains driver for TI SoC. See Kevin's patch [1] where we read from
dev_pm_qos_read_value and then based on that we set some constraints on
the firmware entity based on which the firmware entity chose which low
power mode to enter. It's nice to see that the logic is finally getting
into a much more central part of the kernel PM.

About this series itself, Kevin and I have been working to integrate a
branch where we can have some platform specific support for the TI AM62L
SoC along with this series applied on it on vendor kernel, but I think
it should be good enough to test a proof of concept that we can finally
do mode selection while using s2idle.

So yeah - I was able to write some values into
/dev/system_wakeup_latency and then see that before setting any value it
picked the deepest idle-state in the DT. When I programmed some latency
constraint into /dev/system_wakeup_latency then I could see that the
cpuidle_enter_s2idle picked the shallower idle-state.

These idle-states we had were modelling 2 different low power mode
variants of suspend to RAM, and based on the different suspend-param
that I recieved in the firmware (in this case TF-A via PSCI), I did the
mode selection bits and switched between low power modes purely based on
system_wakeup_latency. There's definitely more work to do, and I will
continue to closely monitor the next revisions of this series as well,
so please feel free to include me in To/CC.

[1] https://lore.kernel.org/linux-pm/20241206-lpm-v6-10-constraints-pmdomain-v6-1-833980158c68@baylibre.com/

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

