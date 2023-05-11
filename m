Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1876FFB0B
	for <lists+linux-pm@lfdr.de>; Thu, 11 May 2023 22:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjEKUHB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 May 2023 16:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239066AbjEKUHA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 May 2023 16:07:00 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D1D10EC
        for <linux-pm@vger.kernel.org>; Thu, 11 May 2023 13:06:56 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 3F74F861BE;
        Thu, 11 May 2023 22:06:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1683835609;
        bh=TZbZtscrIqIo9gATRaoLcZmxsA6+6rHsSUctIlbOcWc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=m4LQ0JfIf8qIcboLxYAz5wT45oVv+RirqBBi4owlvOm6Ewcuohlwy1l70anilm7Jh
         8qHA9/bFmIePhUfzj2TVgkhHr6tS84FrsthsCliQ+8vjuk4Gd+tTCM4DIVS+co3YGy
         W8aH1+7Ij8TjmaycvB/PLM0djy9dmeZbRTTcSy2tPh07Oi4p2xJu+e6uFHVy+eAdBX
         +XTceq67thYMDF6wpc9xUU92c2fsIMqOkv4oS11MBMuBw59pmC/0ictii3Uiy+DyCv
         Z97d9WyjqeZPKYORdcSPjf2HRx4wTpoVungrLrTV42UMb6f8jW2Ihf2LKhDu3Jf6wl
         QAb6B1TM+DSSw==
Message-ID: <9c15897f-9c9f-7d75-4556-ca7904b8a9f8@denx.de>
Date:   Thu, 11 May 2023 22:06:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] power: supply: Ratelimit no data debug output
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
References: <20230305205226.773025-1-marex@denx.de>
 <bd24cdb6-4db4-feff-57d5-dc0cb64aff0c@redhat.com>
 <0d74f4a4-1388-a588-f663-fc7061f6cee9@denx.de>
 <20230511184817.rgsuggdoumyvky3y@mercury.elektranox.org>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230511184817.rgsuggdoumyvky3y@mercury.elektranox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/11/23 20:48, Sebastian Reichel wrote:
> Hi,

Hi,

> On Thu, May 11, 2023 at 01:46:14AM +0200, Marek Vasut wrote:
>> On 3/5/23 21:57, Hans de Goede wrote:
>>> On 3/5/23 21:52, Marek Vasut wrote:
>>>> Reduce the amount of output this dev_dbg() statement emits into logs,
>>>> otherwise if system software polls the sysfs entry for data and keeps
>>>> getting -ENODATA, it could end up filling the logs up.
>>>>
>>>> This does in fact make systemd journald choke, since during boot the
>>>> sysfs power supply entries are polled and if journald starts at the
>>>> same time, the journal is just being repeatedly filled up, and the
>>>> system stops on trying to start journald without booting any further.
>>>>
>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>> ---
>>>> Cc: Hans de Goede <hdegoede@redhat.com>
>>>> Cc: Sebastian Reichel <sre@kernel.org>
>>>> Cc: linux-pm@vger.kernel.org
>>>
>>> Thanks, patch looks good to me:
>>>
>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>
>> Any news ? Maybe this could be applied now ?
> 
> Sorry for the delay; I applied it to my fixes branch now.

Thanks !
