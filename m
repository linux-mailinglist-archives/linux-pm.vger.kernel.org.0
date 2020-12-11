Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42072D794A
	for <lists+linux-pm@lfdr.de>; Fri, 11 Dec 2020 16:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391075AbgLKPat (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Dec 2020 10:30:49 -0500
Received: from foss.arm.com ([217.140.110.172]:35416 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732092AbgLKPaS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 11 Dec 2020 10:30:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 381FA31B;
        Fri, 11 Dec 2020 07:29:33 -0800 (PST)
Received: from [10.57.25.185] (unknown [10.57.25.185])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C6EF3F66B;
        Fri, 11 Dec 2020 07:29:30 -0800 (PST)
Subject: Re: [PATCH v4 0/5] Thermal devfreq cooling improvements with Energy
 Model
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, orjan.eide@arm.com, robh@kernel.org,
        alyssa.rosenzweig@collabora.com, steven.price@arm.com,
        airlied@linux.ie, daniel@ffwll.ch, ionela.voinescu@arm.com
References: <20201210143014.24685-1-lukasz.luba@arm.com>
 <04bdcc7a-c264-ffd2-89a2-5606e59ff786@arm.com>
 <7545df9d-9cbc-d35c-6d32-39c4f96cc216@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <20b01b9a-3ec6-4521-bcd1-a218199e1732@arm.com>
Date:   Fri, 11 Dec 2020 15:29:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <7545df9d-9cbc-d35c-6d32-39c4f96cc216@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 12/11/20 3:15 PM, Daniel Lezcano wrote:
> On 11/12/2020 16:11, Lukasz Luba wrote:
>> Hi Daniel,
>>
>> Do you think it has chance to go to as material for v5.11?
> 
> Yes, it is in the thermal/linux-next material ATM.

Thank you!

Regards,
Lukasz
