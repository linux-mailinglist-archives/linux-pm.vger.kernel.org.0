Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9887934E36A
	for <lists+linux-pm@lfdr.de>; Tue, 30 Mar 2021 10:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhC3InW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Mar 2021 04:43:22 -0400
Received: from foss.arm.com ([217.140.110.172]:53308 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231602AbhC3Im5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 30 Mar 2021 04:42:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BC4EED1;
        Tue, 30 Mar 2021 01:42:56 -0700 (PDT)
Received: from [10.57.21.131] (unknown [10.57.21.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B45713F719;
        Tue, 30 Mar 2021 01:42:52 -0700 (PDT)
Subject: Re: [PATCH v2] thermal: cpufreq_cooling: fix slab OOB issue
To:     Michael Kao <michael.kao@mediatek.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>, fan.chen@mediatek.com,
        linux-pm@vger.kernel.org, srv_heupstream@mediatek.com,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        brian-sy yang <brian-sy.yang@mediatek.com>,
        linux-kernel@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org, hsinyi@chromium.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <20201229050831.19493-1-michael.kao@mediatek.com>
 <1617072684.13941.2.camel@mtksdccf07>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <e7bf390f-c4b8-0ba0-6bab-41a8bd406046@arm.com>
Date:   Tue, 30 Mar 2021 09:42:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1617072684.13941.2.camel@mtksdccf07>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 3/30/21 3:51 AM, Michael Kao wrote:
> Dear Daniel,
> 
> Kindly ping.
> Can this patch be merged? Or any comment?
> 
> BR,
> Michael
> 
> On Tue, 2020-12-29 at 13:08 +0800, Michael Kao wrote:

Please also send it to stable@vger.kernel.org
since it affects stable versions starting from v5.7.
Was applied there as  9006b543384ab10 [1].

Regards,
Lukasz

[1] https://cdn.kernel.org/pub/linux/kernel/v5.x/ChangeLog-5.7.8
