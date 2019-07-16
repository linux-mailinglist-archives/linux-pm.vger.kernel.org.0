Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFC136B084
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 22:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388588AbfGPUgf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 16:36:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41696 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbfGPUgf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 16:36:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0B0EE61778; Tue, 16 Jul 2019 20:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563309394;
        bh=hofFwRcWzR8HLOCx0JLYE7YouqvH4oqoWzq69rSYnWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gVAshI+cMlo+QAiwi0nx4iSoU/ncPLOvM5fCbM1+o+4gd1UcNZEI1EkEPthXsUWa2
         OT3mPq4xmjl1zCwt93RJOdEaZd9mf+TwY7ix7hTK33gcJTtV2V7zmKIHrx4gGkvoUQ
         g2meXUA0pB3EmKchWbnUKWYg+RzrvcC65qKErylQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8A23A60D35;
        Tue, 16 Jul 2019 20:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563309392;
        bh=hofFwRcWzR8HLOCx0JLYE7YouqvH4oqoWzq69rSYnWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lxqeIxL7fH5wgBEIJ0eRhQRdb7GTxejCZarchIbaJIAS09QQkab2nu3r6udvHLYqk
         /bomMgRWEmfzlKzBIgRw90HK0pPIcct1a1Gr9EWMeMK6UxIBSSvgoBW8i+E/1Y5oyT
         wHBsZ+RKidkAiWX7UgwhDvAbCXnOUgqgGAsyE6LA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8A23A60D35
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Tue, 16 Jul 2019 14:36:31 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Subject: Re: [PATCH 17/18] arm64: dts: Convert to the hierarchical CPU
 topology layout for MSM8916
Message-ID: <20190716203631.GC25567@codeaurora.org>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
 <20190513192300.653-18-ulf.hansson@linaro.org>
 <20190716144730.GA7250@e107155-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190716144730.GA7250@e107155-lin>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 16 2019 at 08:47 -0600, Sudeep Holla wrote:
>On Mon, May 13, 2019 at 09:22:59PM +0200, Ulf Hansson wrote:
>> From: Lina Iyer <lina.iyer@linaro.org>
>>
>> In the hierarchical layout, we are creating power domains around each CPU
>> and describes the idle states for them inside the power domain provider
>> node. Note that, the CPU's idle states still needs to be compatible with
>> "arm,idle-state".
>>
>> Furthermore, represent the CPU cluster as a separate master power domain,
>> powering the CPU's power domains. The cluster node, contains the idle
>> states for the cluster and each idle state needs to be compatible with the
>> "domain-idle-state".
>>
>> If the running platform is using a PSCI FW that supports the OS initiated
>> CPU suspend mode, which likely should be the case unless the PSCI FW is
>> very old, this change triggers the PSCI driver to enable it.
>>
>> Cc: Andy Gross <andy.gross@linaro.org>
>> Cc: David Brown <david.brown@linaro.org>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>
>[...]
>
>> @@ -166,12 +170,57 @@
>>  				min-residency-us = <2000>;
>>  				local-timer-stop;
>>  			};
>> +
>> +			CLUSTER_RET: cluster-retention {
>> +				compatible = "domain-idle-state";
>> +				arm,psci-suspend-param = <0x1000010>;
>> +				entry-latency-us = <500>;
>> +				exit-latency-us = <500>;
>> +				min-residency-us = <2000>;
>> +			};
>> +
>> +			CLUSTER_PWRDN: cluster-gdhs {
>> +				compatible = "domain-idle-state";
>> +				arm,psci-suspend-param = <0x1000030>;
>> +				entry-latency-us = <2000>;
>> +				exit-latency-us = <2000>;
>> +				min-residency-us = <6000>;
>> +			};
>>  		};
>>  	};
>
>I was trying to understand the composition of composite state parameters
>in this series and that made me look at these DT examples.
>
This was meant to depict a hierarchical state format for OSI.

>What format does the above platform use ? I tried matching them to
>both original as well as extended format and I fail to understand.
>Assuming original format:
>	State         power_state PowerLevel  StateType     StateID
>	SPC           0x40000002   0(core)    0(Retention)  0x2 (Res0 b[29]=1?)
>	CLUSTER_RET   0x1000010   1(clusters) 0(Retention)  0x10
>	CLUSTER_PWRDN 0x1000030   1(clusters) 0(Retention?) 0x30
>Now extended format:
>	State         power_state StateType     StateID
>	SPC           0x40000002  0(Retention)  0x40000002 (Res0 b[29]=1?)
>	CLUSTER_RET   0x1000010   0(Retention)  0x1000010
The composite state would comprise of CPU state and  Cluster state.
So for the last CPU entering idle -
(CLUSTER_RET | SPC)
0x41000012
>	CLUSTER_PWRDN 0x1000030   0(Retention?) 0x1000030
>
(CLUSTER_PWRDN | SPC)
0x41000032

Hope this helps.

Lina
