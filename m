Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D451ECD58
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jun 2020 12:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgFCKR7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jun 2020 06:17:59 -0400
Received: from foss.arm.com ([217.140.110.172]:59584 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbgFCKR6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Jun 2020 06:17:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E101131B;
        Wed,  3 Jun 2020 03:17:57 -0700 (PDT)
Received: from bogus (unknown [10.37.12.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59CE13F305;
        Wed,  3 Jun 2020 03:17:56 -0700 (PDT)
Date:   Wed, 3 Jun 2020 11:17:53 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>, rjw@rjwysocki.net,
        guohanjun@huawei.com, ionela.voinescu@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [Question]: about 'cpuinfo_cur_freq' shown in sysfs when the CPU
 is in idle state
Message-ID: <20200603101753.GC7259@bogus>
References: <f1773fdc-f6ef-ec28-0c0a-4a09e66ab63b@huawei.com>
 <20200603075200.hbyofgcyiwocl565@vireshk-i7>
 <20200603100727.GB7259@bogus>
 <20200603101010.alijrfmte2c6xv5c@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200603101010.alijrfmte2c6xv5c@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 03, 2020 at 03:40:10PM +0530, Viresh Kumar wrote:
> On 03-06-20, 11:07, Sudeep Holla wrote:
> > But I have another question. If we can detect that CPPC on some platforms
> > rely on CPU registers(I assume FFH registers here and not system/io/...
> > type of GAS registers), can we set dvfs_on_any_cpu(can't recall exact
> > flag name) to false if not already done to prevent such issues. Or I am
> > talking non-sense as it may be applicable only for _set operation and
>
>           Yes, non-sense :)
>

Thanks for confirming 👍.

--
Regards,
Sudeep
