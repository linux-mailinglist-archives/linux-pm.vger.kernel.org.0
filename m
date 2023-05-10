Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2818A6FE82F
	for <lists+linux-pm@lfdr.de>; Thu, 11 May 2023 01:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236291AbjEJXqU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 May 2023 19:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjEJXqT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 May 2023 19:46:19 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C7B19AA
        for <linux-pm@vger.kernel.org>; Wed, 10 May 2023 16:46:17 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 5754981DCF;
        Thu, 11 May 2023 01:46:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1683762375;
        bh=cwjWqfVxm24t4WCRu2F9SbvvMTXeHf5HiGjWu1y2aAY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=W4QSNW0X6gzXQ6Ua8qQslHPMrlF9u3ymFezvZd3NQEyGMm+WK0yh/0G+Vyes1MfeU
         addHu9gMyVdXpzeboRTz0t+sSNyp2L2ySIw3g07nTfQEmFQWo73rw2giOZ8x5JZEVN
         5dkoBmdgcfD9yRbcpOx5LNg+Sv7kBuW8zrzZH0JwPtpz/NlTMXD7u3xYnjG9UlVLVM
         i8C2ZRRSuSzVBt8Y7xi0XJ4xzAD8tMxZSjYmz2QhBqA7KJUf0oM0panxH8aF/XQt7Q
         o1OPGHfXv89cnagsSyecAOAVWPTUJS4yQWe2aSAdl/Y/oWsWrmdp5onmt+djtN2o+Q
         ocoWjaJ+OJoTw==
Message-ID: <0d74f4a4-1388-a588-f663-fc7061f6cee9@denx.de>
Date:   Thu, 11 May 2023 01:46:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] power: supply: Ratelimit no data debug output
To:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>
References: <20230305205226.773025-1-marex@denx.de>
 <bd24cdb6-4db4-feff-57d5-dc0cb64aff0c@redhat.com>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <bd24cdb6-4db4-feff-57d5-dc0cb64aff0c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/5/23 21:57, Hans de Goede wrote:
> Hi,

Hi,

> On 3/5/23 21:52, Marek Vasut wrote:
>> Reduce the amount of output this dev_dbg() statement emits into logs,
>> otherwise if system software polls the sysfs entry for data and keeps
>> getting -ENODATA, it could end up filling the logs up.
>>
>> This does in fact make systemd journald choke, since during boot the
>> sysfs power supply entries are polled and if journald starts at the
>> same time, the journal is just being repeatedly filled up, and the
>> system stops on trying to start journald without booting any further.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Hans de Goede <hdegoede@redhat.com>
>> Cc: Sebastian Reichel <sre@kernel.org>
>> Cc: linux-pm@vger.kernel.org
> 
> Thanks, patch looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Any news ? Maybe this could be applied now ?
