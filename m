Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4A9914D9EF
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2020 12:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgA3LkN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jan 2020 06:40:13 -0500
Received: from foss.arm.com ([217.140.110.172]:51404 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbgA3LkM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 30 Jan 2020 06:40:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DF96328;
        Thu, 30 Jan 2020 03:40:12 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 734143F67D;
        Thu, 30 Jan 2020 03:40:09 -0800 (PST)
Date:   Thu, 30 Jan 2020 11:40:04 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Sibi Sankar <sibis@codeaurora.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, saravanak@google.com, nm@ti.com,
        bjorn.andersson@linaro.org, agross@kernel.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        ulf.hansson@linaro.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC v3 02/10] cpufreq: blacklist SDM845 in cpufreq-dt-platdev
Message-ID: <20200130114004.GA56122@bogus>
References: <20200127200350.24465-1-sibis@codeaurora.org>
 <20200127200350.24465-3-sibis@codeaurora.org>
 <20200128204423.GF46072@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128204423.GF46072@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 28, 2020 at 12:44:23PM -0800, Matthias Kaehlcke wrote:
> On Tue, Jan 28, 2020 at 01:33:42AM +0530, Sibi Sankar wrote:
> > Add SDM845 to cpufreq-dt-platdev blacklist.
>
> nit: you could mention that cpufreq is handled by the
> 'qcom-cpufreq-hw' driver.
>

IIUC, these platforms get the OPP table from the firmware and there shouldn't
be OPP entries in the DT. If not, why not fix that to avoid more confusion.
Can we make cpu0_node_has_opp_v2_prop return false in short.

--
Regards,
Sudeep
