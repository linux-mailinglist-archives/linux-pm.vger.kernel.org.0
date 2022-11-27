Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5284A639D5A
	for <lists+linux-pm@lfdr.de>; Sun, 27 Nov 2022 22:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiK0VgM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Nov 2022 16:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiK0VgK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Nov 2022 16:36:10 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDA9D2F2
        for <linux-pm@vger.kernel.org>; Sun, 27 Nov 2022 13:36:10 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id D1E4B85031;
        Sun, 27 Nov 2022 22:36:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1669584969;
        bh=6vEmSjGMQDmzHrixZiCi1K5BAYIuxCt+6pIsc3A6Tcs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mR/01qpNcwhs7Zh9vc2UEnX1mgbrAXFSJOK0tr0AHKTd80vkTiDMlSOu6qKpbtF5l
         jQ8ecuGMwbdwLmkkqxjKM+cqLe6jMr3Zcp2HVnu6tjswBytGM+/5rRdX0JxcJCWuDm
         im5M1FW7HvhxIPJPbWh44SxUCN5Ey2dH9Pk1ALvDGi1a5Hl3k65++cW5kuQ94PCTjh
         bMlxd0pa3xBw7cpfMpJ9xZQH6PdFRbWr2o0vb0F3xKCuMdny5bRUkjb2EdjIz8Gu07
         eFjg4X9nP6bLP1gzHeo+UvJAbh747KLJDyerHYncuYLJ9w31oQdhOYj1OTYXYcx8TL
         yfv6ZlC3Crb5Q==
Message-ID: <95a5a333-9f3d-a0a4-f484-5a5e881ee326@denx.de>
Date:   Sun, 27 Nov 2022 22:27:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 08/10] power: supply: bq25890: Support boards with more
 then one charger IC
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org
References: <20221127180233.103678-1-hdegoede@redhat.com>
 <20221127180233.103678-9-hdegoede@redhat.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20221127180233.103678-9-hdegoede@redhat.com>
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
> Some devices, such as the Lenovo Yoga Tab 3 Pro (YT3-X90F) have
> multiple batteries with a separate bq25890 charger for each battery.
> 
> This requires the bq25890_charger code to use a unique name per
> registered power_supply class device, rather then hardcoding
> "bq25890-charger" as power_supply class device name.
> 
> Add a "-%d" prefix to the name, allocated through idr in the same way
> as several other power_supply drivers are already doing this.
> 
> Note this also updates: drivers/platform/x86/x86-android-tablets.c
> which refers to the charger by power_supply-class-device-name for
> the purpose of setting the "supplied-from" property on the fuel-gauge
> to this name.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Marek Vasut <marex@denx.de>
