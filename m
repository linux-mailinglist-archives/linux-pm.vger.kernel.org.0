Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A602348C1
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jul 2020 17:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387577AbgGaP44 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jul 2020 11:56:56 -0400
Received: from foss.arm.com ([217.140.110.172]:34782 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbgGaP44 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 31 Jul 2020 11:56:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAD25101E;
        Fri, 31 Jul 2020 08:56:55 -0700 (PDT)
Received: from bogus (unknown [10.37.12.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D47A93F66E;
        Fri, 31 Jul 2020 08:56:53 -0700 (PDT)
Date:   Fri, 31 Jul 2020 16:56:50 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, cristian.marussi@arm.com,
        rjw@rjwysocki.net, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 0/4] CPUFreq statistics retrieved by drivers
Message-ID: <20200731155650.GC14529@bogus>
References: <20200729151208.27737-1-lukasz.luba@arm.com>
 <20200730085333.qubrsv7ufqninihd@vireshk-mac-ubuntu>
 <20200730091014.GA13158@bogus>
 <3b3a56e9-29ec-958f-fb3b-c689a9389d2f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b3a56e9-29ec-958f-fb3b-c689a9389d2f@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 30, 2020 at 10:36:51AM +0100, Lukasz Luba wrote:
> 
> In this case I think we would have to create debugfs.
> Sudeep do you think these debugfs should be exposed from the protocol
> layer:
> drivers/firmware/arm_scmi/perf.c

I prefer above over cpufreq as we can support for all the devices not
just cpus which avoids adding similar support elsewhere(mostly devfreq)

> or maybe from the cpufreq scmi driver? I would probably be safer to have
> it in the cpufreq driver because we have scmi_handle there.
>

Cristian was thinking if we can consolidate all such debugfs under one
device may be and that should eliminate your handle restriction. I would
like to see how that works out in implementation but I don't have any 
better suggestion ATM.

--
Regards,
Sudeep
