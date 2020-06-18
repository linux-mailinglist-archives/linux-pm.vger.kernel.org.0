Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E194A1FED41
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jun 2020 10:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgFRIJV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jun 2020 04:09:21 -0400
Received: from foss.arm.com ([217.140.110.172]:45672 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728420AbgFRIIq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 18 Jun 2020 04:08:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85FC731B;
        Thu, 18 Jun 2020 01:08:41 -0700 (PDT)
Received: from bogus (unknown [10.37.12.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC4633F6CF;
        Thu, 18 Jun 2020 01:08:39 -0700 (PDT)
Date:   Thu, 18 Jun 2020 09:08:33 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Nicola Mazzucato <nicola.mazzucato@arm.com>,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/2] cpufreq: arm_scmi: Set fast_switch_possible
 conditionally
Message-ID: <20200618080833.GA20559@bogus>
References: <20200617094332.8391-1-nicola.mazzucato@arm.com>
 <20200617094332.8391-2-nicola.mazzucato@arm.com>
 <20200617124753.GA15211@bogus>
 <20200618061420.5q7xsldakax2zro5@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200618061420.5q7xsldakax2zro5@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 18, 2020 at 11:44:20AM +0530, Viresh Kumar wrote:
> On 17-06-20, 13:47, Sudeep Holla wrote:
> > This is first step towards avoiding polling based cpufreq set if firmware
> > has fast access registers that bypass normal mailbox based messaging.
> >
> > If you happy with this and provide ack, I will take this along with scmi
> > changes via ARM SoC. Hope that is fine by you.
>
> Sudeep,
>
> I am not sure how it concerns me frankly :)
>

Sorry I wasn't clear.

> AFAICT, this is enabling fast switch based on some mechanism (internal
> to scmi) and so either the cpufreq driver will have fast-switch
> enabled or not, and both are fine by the cpufreq core.
>

Indeed.

> And so I am confused on why my Ack is important here :)
>

Generally ARM SoC team expects a stamp from other subsystem maintainers
if they are pulling it. I understand there is more firmware aspect than
cpufreq aspect here, but still we may need your stamp to this 😉 for
logistic reasons.

--
Regards,
Sudeep
