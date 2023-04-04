Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9CE6D6E5E
	for <lists+linux-pm@lfdr.de>; Tue,  4 Apr 2023 22:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbjDDUtQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Apr 2023 16:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbjDDUtP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Apr 2023 16:49:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4CDAC;
        Tue,  4 Apr 2023 13:49:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B7B063874;
        Tue,  4 Apr 2023 20:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3AEC4339B;
        Tue,  4 Apr 2023 20:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680641353;
        bh=gXqIcJnn5Eq5okLMpDEb9nxUz3SeXdgGCHq7sJi3mH4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CtyWHrJha0wN1fTMK3NpqKRCmt11CL56a5Z8muzaCRqQWsJy7r5Y9Yl3zLU3fjyEH
         hCDUmR6dQQLAq46HmHA6CY8AoaY/rVu5X32EsbMOstevgFcKnTuG0gLwkzdZB3ilhp
         vjkw8Vm3SSrNv1Zlb0k9XyLj4TO3GqQ+Kg8tLl2XiVq/csKBVyaa6pDCfw9j9gktnZ
         u1CgwUF4S/IlC4auLKpQzclYprcp5T9wsRxFoiyfHfDUhWhKV15DJCXOGGI8vJX8UQ
         qrtkRfFEMJ/qgcTxiAzvcJoC7l3oAfhnMFG2mV3pn8/ejQj2NUOY8ghg/wSfjoHNOv
         YvdRLhNXBpsRA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1pjnaZ-005l6L-AO;
        Tue, 04 Apr 2023 21:49:11 +0100
Date:   Tue, 04 Apr 2023 21:49:10 +0100
Message-ID: <86sfdfv0e1.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     David Dai <davidai@google.com>,
        Oliver Upton <oliver.upton@linux.dev>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        kernel-team@android.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Subject: Re: [RFC PATCH 0/6] Improve VM DVFS and task placement behavior
In-Reply-To: <ZCx97IKjsBibjdGc@linux.dev>
References: <20230330224348.1006691-1-davidai@google.com>
        <ZCx97IKjsBibjdGc@linux.dev>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/28.2
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: davidai@google.com, oliver.upton@linux.dev, rafael@kernel.org, viresh.kumar@linaro.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, pbonzini@redhat.com, corbet@lwn.net, james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, lpieralisi@kernel.org, sudeep.holla@arm.com, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, kernel-team@android.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 04 Apr 2023 20:43:40 +0100,
Oliver Upton <oliver.upton@linux.dev> wrote:
> 
> Folks,
> 
> On Thu, Mar 30, 2023 at 03:43:35PM -0700, David Dai wrote:
> 
> <snip>
> 
> > PCMark
> > Higher is better
> > +-------------------+----------+------------+--------+-------+--------+
> > | Test Case (score) | Baseline |  Hypercall | %delta |  MMIO | %delta |
> > +-------------------+----------+------------+--------+-------+--------+
> > | Weighted Total    |     6136 |       7274 |   +19% |  6867 |   +12% |
> > +-------------------+----------+------------+--------+-------+--------+
> > | Web Browsing      |     5558 |       6273 |   +13% |  6035 |    +9% |
> > +-------------------+----------+------------+--------+-------+--------+
> > | Video Editing     |     4921 |       5221 |    +6% |  5167 |    +5% |
> > +-------------------+----------+------------+--------+-------+--------+
> > | Writing           |     6864 |       8825 |   +29% |  8529 |   +24% |
> > +-------------------+----------+------------+--------+-------+--------+
> > | Photo Editing     |     7983 |      11593 |   +45% | 10812 |   +35% |
> > +-------------------+----------+------------+--------+-------+--------+
> > | Data Manipulation |     5814 |       6081 |    +5% |  5327 |    -8% |
> > +-------------------+----------+------------+--------+-------+--------+
> > 
> > PCMark Performance/mAh
> > Higher is better
> > +-----------+----------+-----------+--------+------+--------+
> > |           | Baseline | Hypercall | %delta | MMIO | %delta |
> > +-----------+----------+-----------+--------+------+--------+
> > | Score/mAh |       79 |        88 |   +11% |   83 |    +7% |
> > +-----------+----------+-----------+--------+------+--------+
> > 
> > Roblox
> > Higher is better
> > +-----+----------+------------+--------+-------+--------+
> > |     | Baseline |  Hypercall | %delta |  MMIO | %delta |
> > +-----+----------+------------+--------+-------+--------+
> > | FPS |    18.25 |      28.66 |   +57% | 24.06 |   +32% |
> > +-----+----------+------------+--------+-------+--------+
> > 
> > Roblox Frames/mAh
> > Higher is better
> > +------------+----------+------------+--------+--------+--------+
> > |            | Baseline |  Hypercall | %delta |   MMIO | %delta |
> > +------------+----------+------------+--------+--------+--------+
> > | Frames/mAh |    91.25 |     114.64 |   +26% | 103.11 |   +13% |
> > +------------+----------+------------+--------+--------+--------+
> 
> </snip>
> 
> > Next steps:
> > ===========
> > We are continuing to look into communication mechanisms other than
> > hypercalls that are just as/more efficient and avoid switching into the VMM
> > userspace. Any inputs in this regard are greatly appreciated.
> 
> We're highly unlikely to entertain such an interface in KVM.
> 
> The entire feature is dependent on pinning vCPUs to physical cores, for which
> userspace is in the driver's seat. That is a well established and documented
> policy which can be seen in the way we handle heterogeneous systems and
> vPMU.
> 
> Additionally, this bloats the KVM PV ABI with highly VMM-dependent interfaces
> that I would not expect to benefit the typical user of KVM.
> 
> Based on the data above, it would appear that the userspace implementation is
> in the same neighborhood as a KVM-based implementation, which only further
> weakens the case for moving this into the kernel.
> 
> I certainly can appreciate the motivation for the series, but this feature
> should be in userspace as some form of a virtual device.

+1 on all of the above.

The one thing I'd like to understand that the comment seems to imply
that there is a significant difference in overhead between a hypercall
and an MMIO. In my experience, both are pretty similar in cost for a
handling location (both in userspace or both in the kernel). MMIO
handling is a tiny bit more expensive due to a guaranteed TLB miss
followed by a walk of the in-kernel device ranges, but that's all. It
should hardly register.

And if you really want some super-low latency, low overhead
signalling, maybe an exception is the wrong tool for the job. Shared
memory communication could be more appropriate.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
