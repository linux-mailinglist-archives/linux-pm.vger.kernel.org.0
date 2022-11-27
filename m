Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEAB639D57
	for <lists+linux-pm@lfdr.de>; Sun, 27 Nov 2022 22:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiK0VgL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Nov 2022 16:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiK0VgJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Nov 2022 16:36:09 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B67E0AC
        for <linux-pm@vger.kernel.org>; Sun, 27 Nov 2022 13:36:08 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 23E8C84508;
        Sun, 27 Nov 2022 22:36:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1669584967;
        bh=owasDf4TDX5npEc5KyHtlJ3Xqg806wAs8kP8RB/IYTI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZJBT4wmJy+GPrz1DwEW1Q7qnGf/vgNouG0GBv470pKHTn8xqT7XsVj3w6ph9jS+eg
         nNnBO46bVpcKWPgk3s2gffb5miz53kHHmvAXe6Nu42FyPRyIMfh4Yjwjb7ak3XOpQW
         IdUqHy2lVFTsPTaAY0mAryAwXMZTuRphifmfynGvpOlJ7y/DJEBSzWAHTXZgXy2HSe
         UJLcQzxro0aUoSdV/HLfUbPBtiL1iAA94yzDEpcTZnXB4Cq2hszFkJnAtUXEHDFAOQ
         3OUhtnStNd4rvq/0j3bxvyJ25SYvguN5vaTIeM+/YYQ5iOtDerZvRhVzWm+OEhpWiY
         tlh/7gA3uKTYg==
Message-ID: <86f8b67d-547a-a57e-26dc-08a41e2ba715@denx.de>
Date:   Sun, 27 Nov 2022 22:24:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 06/10] power: supply: bq25890: Fix setting of F_CONV_RATE
 rate when disabling HiZ mode
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org
References: <20221127180233.103678-1-hdegoede@redhat.com>
 <20221127180233.103678-7-hdegoede@redhat.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20221127180233.103678-7-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/27/22 19:02, Hans de Goede wrote:
> The recent "power: supply: bq25890: Add HiZ mode support" change
> leaves F_CONV_RATE rate unset when disabling HiZ mode (setting
> POWER_SUPPLY_PROP_ONLINE to 1) while a charger is connected.
> 
> Separate the resetting HiZ mode when necessary because of a charger
> (re)plug event into its own if which runs first.

I think this one sentence needs rephrasing ^ .

> And fix the setting of F_CONV_RATE rate by adding helper variables for
> the old and new F_CONV_RATE state which check both the online and hiz bits
> and then compare the helper variables to see if a F_CONV_RATE update is
> necessary.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Marek Vasut <marex@denx.de>
