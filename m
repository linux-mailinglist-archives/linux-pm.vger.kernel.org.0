Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA4A2F0D2F
	for <lists+linux-pm@lfdr.de>; Mon, 11 Jan 2021 08:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbhAKH2O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jan 2021 02:28:14 -0500
Received: from comms.puri.sm ([159.203.221.185]:57824 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727450AbhAKH2N (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 Jan 2021 02:28:13 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id E80BCE124F;
        Sun, 10 Jan 2021 23:27:02 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VsKND9w91ELS; Sun, 10 Jan 2021 23:27:01 -0800 (PST)
Subject: Re: [PATCH v4 0/5] imx8mq: updates for the interconnect fabric
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     robh@kernel.org, festevam@gmail.com, catalin.marinas@arm.com,
        will@kernel.org, georgi.djakov@linaro.org, cdleonard@gmail.com,
        gregkh@linuxfoundation.org, kernel@pengutronix.de,
        linux-imx@nxp.com, kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20210107121754.3295-1-martin.kepplinger@puri.sm>
 <20210111045103.GH28365@dragon>
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
Message-ID: <3c50b545-b4d5-f65a-7994-c97e7e80d508@puri.sm>
Date:   Mon, 11 Jan 2021 08:26:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20210111045103.GH28365@dragon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11.01.21 05:51, Shawn Guo wrote:
> On Thu, Jan 07, 2021 at 01:17:49PM +0100, Martin Kepplinger wrote:
>> revision history:
>> v4: (thanks Shawn, Georgi and Greg)
>>   * reorder to have dt-bindings doc before code addition
>>   * add newline between dt nodes
>>   * removed "interconnect: imx8mq: Use icc_sync_state" from the patchset
>>     since it's part of gregkh/char-misc.git
>>   * Add acks
>>
>> v3: (thanks Krysztof and Georgi)
>>   * drop the defconfig cycling patch and fix the interconnect enable config
>>   * add the noc node to imx8mq only
>>   * add missing signed-off-by
>>   * https://lore.kernel.org/linux-arm-kernel/20201210100906.18205-1-martin.kepplinger@puri.sm/T/#t
>>
>> v2: (thanks Lucas)
>>   * reorder and clean up defconfig changes
>>   * use "dram" for the interconnect path name and document it
>>   * https://lore.kernel.org/linux-arm-kernel/20201201123932.12312-1-martin.kepplinger@puri.sm/T/#t
>>
>> v1:
>>   * https://lore.kernel.org/linux-arm-kernel/20201201100124.4676-1-martin.kepplinger@puri.sm/T/#t
>>
>> thanks,
>>                          martin
>>
>>
>> Leonard Crestez (1):
>>    arm64: dts: imx8mq: Add NOC node
>>
>> Martin Kepplinger (4):
>>    arm64: dts: imx8mq: Add interconnect provider property
>>    dt-bindings: mxsfb: Add interconnect bindings for LCDIF path
>>    arm64: dts: imx8mq: Add interconnect for lcdif
>>    arm64: defconfig: Enable interconnect for imx8mq
> 
> I only received 3 patches, 1/5, 4/5 and 5/5.
> 
> Shawn
> 

strange as they made it to the lists, see 
https://lore.kernel.org/linux-arm-kernel/20210107121754.3295-1-martin.kepplinger@puri.sm/ 
but I can resend into this thread.

                              martin
