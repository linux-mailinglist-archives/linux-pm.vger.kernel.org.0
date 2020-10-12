Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEDA128BD25
	for <lists+linux-pm@lfdr.de>; Mon, 12 Oct 2020 18:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389068AbgJLQDA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Oct 2020 12:03:00 -0400
Received: from foss.arm.com ([217.140.110.172]:55098 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388982AbgJLQDA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Oct 2020 12:03:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C5B631B;
        Mon, 12 Oct 2020 09:02:59 -0700 (PDT)
Received: from bogus (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F9653F719;
        Mon, 12 Oct 2020 09:02:57 -0700 (PDT)
Date:   Mon, 12 Oct 2020 17:02:46 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Nicola Mazzucato <nicola.mazzucato@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        vireshk@kernel.org, daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, chris.redpath@arm.com,
        morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] [RFC] CPUFreq: Add support for
 cpu-perf-dependencies
Message-ID: <20201012160232.GF16519@bogus>
References: <20200924095347.32148-3-nicola.mazzucato@arm.com>
 <20201006071909.3cgz7i5v35dgnuzn@vireshk-i7>
 <2417d7b5-bc58-fa30-192c-e5991ec22ce0@arm.com>
 <20201008110241.dcyxdtqqj7slwmnc@vireshk-i7>
 <20201008150317.GB20268@arm.com>
 <56846759-e3a6-9471-827d-27af0c3d410d@arm.com>
 <20201009053921.pkq4pcyrv4r7ylzu@vireshk-i7>
 <42e3c8e9-cadc-d013-1e1f-fa06af4a45ff@arm.com>
 <20201009140141.GA4048593@bogus>
 <2b7b6486-2898-1279-ce9f-9e7bd3512152@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b7b6486-2898-1279-ce9f-9e7bd3512152@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 12, 2020 at 11:22:57AM +0100, Lukasz Luba wrote:
[...]

> 
> True, the SCMI clock does not support discovery of clock tree:
> (from 4.6.1 Clock management protocol background)
> 'The protocol does not cover discovery of the clock tree, which must be
> described through firmware tables instead.' [1]
>

By firmware, spec refers to DT or ACPI, just to be clear.

> In this situation, would it make sense, instead of this binding from
> patch 1/2, create a binding for internal firmware/scmi node?
>

Why ? I prefer to solve this in a generic way and make it not scmi
specific issue. If OPP idea Viresh suggested can be made to work, that
would be good.

> Something like:
> 
> firmware {
> 	scmi {
> 	...		
> 		scmi-perf-dep {
> 			compatible = "arm,scmi-perf-dependencies";
> 			cpu-perf-dep0 {
> 				cpu-perf-affinity = <&CPU0>, <&CPU1>;
> 			};
> 			cpu-perf-dep1 {
> 				cpu-perf-affinity = <&CPU3>, <&CPU4>;
> 			};
> 			cpu-perf-dep2 {
> 				cpu-perf-affinity = <&CPU7>;
> 			};
> 		};
> 	};
> };
> 
> The code which is going to parse the binding would be inside the
> scmi perf protocol code and used via API by scmi-cpufreq.c.
>

Not completely against it, just need to understand how is this solved
or will be solved for any DT(non SCMI) and why it can be generic.

-- 
Regards,
Sudeep
