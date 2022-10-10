Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364165FA414
	for <lists+linux-pm@lfdr.de>; Mon, 10 Oct 2022 21:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJJTW2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Oct 2022 15:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiJJTW1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Oct 2022 15:22:27 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B739C60693
        for <linux-pm@vger.kernel.org>; Mon, 10 Oct 2022 12:22:25 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 92C9684A73;
        Mon, 10 Oct 2022 21:22:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1665429743;
        bh=rdYj6KJaNQ4lbn118QI9y7+KQmUmUhqvxHofQq9TNWg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NfNQojHjBboyIMQCzpgDaOWZpm+3hZg3Rp7nkaO98RJA9gI611iaQ5o40IoL9TzFZ
         7/LPVC55/O4rakhJK42QNOKO5vjnqzeoPnnIBp+3O8HpnKy/NekPhbQA+EK771GQUi
         EgDaioEfFzQbWR9rYrBJf16/Vnb1Q5Q1i5+EqsGnyQFcOrYZNqhBXfVwPEMAYklwbG
         hLi/BYysaPVcAntWPy2n9JbjYgEP/SqQq+/fX8e0bamRYx+xVn5FGLrj+PvkVHF1Mu
         mKVZ0S3L9uUXfuh85woCpt5G1R7f7D2c5dLQ/VAPZbzAi2lCdrUvh91hgRemv+bzju
         vDSSy5A2ySHYg==
Message-ID: <c528ae92-26bd-e6a9-a406-93a077d2fab7@denx.de>
Date:   Mon, 10 Oct 2022 21:22:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/2] power: supply: bq25890: Add CC voltage to ADC
 properties
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20221009191839.102686-1-marex@denx.de>
 <Y0NUbeUae01t+UGa@qmqm.qmqm.pl>
 <dde63fea-04eb-c438-27d3-fe6ff5c174bc@redhat.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <dde63fea-04eb-c438-27d3-fe6ff5c174bc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/10/22 15:50, Hans de Goede wrote:
> Hi,

Hi,

[...]

>> Though I think there is no proper property
>> for the VSYS value that is currently occupying VOLTAGE_NOW - this
>> might be better modelled as a separate regulator maybe?
> 
> Ack, see above.

We already do have a regulator in the bq25890 driver. The regulator is 
used as a switch to toggle OTG boost mode (supply from battery to VBUS), 
but I don't see any users of this functionality, and I cannot imagine 
how this would be modeled in DT. (Hans, can you clarify?)

There is the usb_work (usb_register_notifier()) which triggers workqueue 
which does the same, toggles OTG boost mode, but this is only used in 
case a valid USB PHY is found. I didn't find any users of this either.

Anyway, maybe we can extend the regulator to report VBus and register 
another one to report VSys, where the VSys one can be plugged e.g. as 
supply for PMIC in DT ?

[...]
