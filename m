Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250A15FF2D4
	for <lists+linux-pm@lfdr.de>; Fri, 14 Oct 2022 19:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiJNROo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Oct 2022 13:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiJNROn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Oct 2022 13:14:43 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B21A444
        for <linux-pm@vger.kernel.org>; Fri, 14 Oct 2022 10:14:40 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 5EDE1803D2;
        Fri, 14 Oct 2022 19:14:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1665767678;
        bh=wjTa/LR19TM3f2nCl1k+QMz8PZWBG9LvIm6SAyCnMVQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=anAmvjmlDi4pgm3s5d6jJtX+kCQKJbZYF7LFqYjLbHtKTXV2pXJrvkB6olPI8Far2
         HF5T279fYUfmUG5luASaokOjRujjDHsqxGn+RmrkOMnyxsK9YuqC+pDjKxgC0+aUpZ
         ub9FhPjJoeWw4tCfRjfSrApOOK3sRPVVmHMwV0FHeo3XGVeskNrRxuFrMyR0fNL/jh
         GxFTQ2P6iUQVY/+rVEMizBoDBgq53uOt64cq+lCOadDaGS0o4nRHVNQQ9B0fjDLTEs
         RzS5Ksz6DFBd5BZyJsfuua2zLEghZbaFNaR/PYZQAWM0ebvBpvW6sBZ+IV/OqUb5cN
         IcDAIDTEREQvw==
Message-ID: <08bbfa77-8001-9a69-94ea-936afe8195a8@denx.de>
Date:   Fri, 14 Oct 2022 18:46:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 5/7] power: supply: bq25890: Factor out regulator
 registration code
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20221010210310.165461-1-marex@denx.de>
 <20221010210310.165461-5-marex@denx.de>
 <e0659fb1-7e1e-de5c-de6a-99a8f180bd3f@redhat.com>
 <00e6b9b0-ddef-6e2f-0603-9a25fd3b9e0d@denx.de>
 <848ada38-00a1-0631-871f-926bb33a166f@redhat.com>
 <021a1dfc-eb05-77ad-644c-f967a5bf7799@denx.de>
 <27d4c17a-1894-e055-9311-9fb6d69d3665@redhat.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <27d4c17a-1894-e055-9311-9fb6d69d3665@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/13/22 11:12, Hans de Goede wrote:
> Hi,

Hi,

[...]

>>> Looking at standard Linux userspace (Debian/Fedora/etc.)
>>> all the userspace tools capable of reporting voltages
>>> of various voltage rails inside the system to the user
>>> use the hwmon interface for this. This is also why
>>> the power-supply class core recently got support for
>>> proxying some psy properties to a hwmon class device.
>>>
>>> So the way I see it is that if we want to report Vsys to
>>> userspace, that we then clearly need to report it through
>>> the hwmon interface.
>>
>> For regulators, you can read their values via /sys/class/regulators/* , if the user is interesting in Vsys .
>>
>> Maybe that is where we disagree -- I'm not particularly interested in exposing Vsys to user space, but since it was exposed before, I tried to retain that exposure, although via different channel. And the regulator also makes the Vsys useful, since it can be used as a supply on the kernel level.
> 
> I don't particularly care a lot about exposing Vsys to user space either,
> but like you I do believe that we should at least keep the functionality
> around while fixing the wrong property use.

I agree.

> I'm still not 100% convinced a regular for Vsys is not a bit
> overkill but I don't want to block going this route either.

Why would a regulator be an overkill compared to hwmon ?
What am I missing here ?

> So I'll go and review the last 3 patches and then lets wait
> and see what Sebastian (SRE) has to say.

Thank you

[...]
