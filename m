Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D322F9D17
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 11:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388870AbhARKrJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 05:47:09 -0500
Received: from foss.arm.com ([217.140.110.172]:59874 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389378AbhARJ5N (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 18 Jan 2021 04:57:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DCCC1FB;
        Mon, 18 Jan 2021 01:56:27 -0800 (PST)
Received: from [10.57.2.166] (unknown [10.57.2.166])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BE193F66E;
        Mon, 18 Jan 2021 01:56:25 -0800 (PST)
Subject: Re: [PATCH] PM / devfreq: Add sysfs attributes to simple_ondemand
 governor
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com
References: <CGME20210115170541epcas1p1b7bc36fb5a4f1b907da5771ca0c37891@epcas1p1.samsung.com>
 <20210115170530.22603-1-lukasz.luba@arm.com>
 <e09da2a0-f4cc-d93e-07a5-3551004fed83@samsung.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <3b0c23f9-a160-6cbc-e2e1-8b9afd2d094d@arm.com>
Date:   Mon, 18 Jan 2021 09:56:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e09da2a0-f4cc-d93e-07a5-3551004fed83@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

On 1/18/21 6:49 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> I has been developed[1] the sysfs attributes for upthreshold and downdifferential.
> But, I has not yet posted it[1]. I'll post my approach with some changes.

Fair enough. Please add me on CC when you post it. I can help you with
reviewing it.

> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?h=devfreq-testing&id=e7c59dfb4afebe0c96de54516e9be23d76d96492

Thank you for the link. The code looks pretty good, just use
kstrtouint() instead of sscanf() - checkpatch would not complain.

Regards,
Lukasz
