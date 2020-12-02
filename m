Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5252CC31B
	for <lists+linux-pm@lfdr.de>; Wed,  2 Dec 2020 18:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbgLBRKb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Dec 2020 12:10:31 -0500
Received: from foss.arm.com ([217.140.110.172]:45360 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbgLBRKa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Dec 2020 12:10:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4442D1FB;
        Wed,  2 Dec 2020 09:09:44 -0800 (PST)
Received: from [10.57.31.176] (unknown [10.57.31.176])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBE363F575;
        Wed,  2 Dec 2020 09:09:40 -0800 (PST)
Subject: Re: [PATCH v4 4/4] powercap/drivers/dtpm: Add CPU energy model based
 support
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, ulf.hansson@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Anup Patel <anup.patel@wdc.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kajol Jain <kjain@linux.ibm.com>,
        Zqiang <qiang.zhang@windriver.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Mike Leach <mike.leach@linaro.org>,
        Atish Patra <atish.patra@wdc.com>,
        Andrew Jones <drjones@redhat.com>
References: <20201201192801.27607-1-daniel.lezcano@linaro.org>
 <20201201192801.27607-5-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <54ca2ae1-a7c5-f587-c1e7-583b5e3113af@arm.com>
Date:   Wed, 2 Dec 2020 17:09:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201201192801.27607-5-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 12/1/20 7:28 PM, Daniel Lezcano wrote:
> With the powercap dtpm controller, we are able to plug devices with
> power limitation features in the tree.
> 
> The following patch introduces the CPU power limitation based on the
> energy model and the performance states.
> 
> The power limitation is done at the performance domain level. If some
> CPUs are unplugged, the corresponding power will be subtracted from
> the performance domain total power.
> 
> It is up to the platform to initialize the dtpm tree and add the CPU.
> 
> Here is an example to create a simple tree with one root node called
> "pkg" and the CPU's performance domains.
> 
> static int dtpm_register_pkg(struct dtpm_descr *descr)
> {
> 	struct dtpm *pkg;
> 	int ret;
> 
> 	pkg = dtpm_alloc(NULL);
> 	if (!pkg)
> 		return -ENOMEM;
> 
> 	ret = dtpm_register(descr->name, pkg, descr->parent);
> 	if (ret)
> 		return ret;
> 
> 	return dtpm_register_cpu(pkg);
> }
> 
> static struct dtpm_descr descr = {
> 	.name = "pkg",
> 	.init = dtpm_register_pkg,
> };
> DTPM_DECLARE(descr);
> 
> Cc: Thara Gopinath <thara.gopinath@linaro.org>
> Cc: Lina Iyer <ilina@codeaurora.org>
> Cc: Ram Chandrasekar <rkumbako@codeaurora.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>


LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
