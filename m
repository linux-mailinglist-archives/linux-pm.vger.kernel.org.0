Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17D1639D5B
	for <lists+linux-pm@lfdr.de>; Sun, 27 Nov 2022 22:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiK0VgM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Nov 2022 16:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiK0VgM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Nov 2022 16:36:12 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32217BF4B
        for <linux-pm@vger.kernel.org>; Sun, 27 Nov 2022 13:36:11 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 9E9AC844FA;
        Sun, 27 Nov 2022 22:36:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1669584969;
        bh=RrP1cGJRK3IpM/mdfS1icWAv8lsU8AyFkLsoSIFYpDQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YHnYzigKce806oWwpt25gnGzlwsB7L1SN3tOxeXcEZT23fpYSz7479DZQ3YAQ6Jpy
         StkrZetYGMH6v21ruhvNTI/weRFiwRojNOkvYtBIa8o+tqju0+FR9gy41OxLyTSHGk
         ZmxFcvxFwAsQu3cwP14lO0w1ZQK99nxNrkHKMlHogXURmAl2307E3fLTgMMDW1w0Yh
         658vBvRfMnqaDTvFuGLym8CR3vb7cZnla6iajM4Or/Bnv0uZaAjVJSoIh0FB1yjcjn
         jic38J3nFVeHDpuMLxayibtwkzXX7zAWROrLjPYfe5uM3PCpFd7oqTAjWSAIuBCT0K
         Oq+ZO0WMKIXjg==
Message-ID: <246b8650-f8ae-ef5a-b7ca-2ce0c4bf28a3@denx.de>
Date:   Sun, 27 Nov 2022 22:33:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 09/10] power: supply: bq25890: Add support for having a
 secondary charger IC
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org
References: <20221127180233.103678-1-hdegoede@redhat.com>
 <20221127180233.103678-10-hdegoede@redhat.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20221127180233.103678-10-hdegoede@redhat.com>
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
> Some devices, such as the Lenovo Yoga Tab 3 Pro (YT3-X90F) have multiple
> batteries with a separate bq25890 charger for each battery.
> 
> This requires some coordination between the chargers specifically
> the main charger needs to put the secondary charger in Hi-Z mode when:
> 
> 1. Enabling its 5V boost (OTG) output to power an external USB device,
>     to avoid the secondary charger IC seeing this as external Vbus and
>     then trying to charge the secondary battery from this.
> 
> 2. Talking the Pump Express protocol to increase the external Vbus voltage.
>     Having the secondary charger drawing current when the main charger is
>     trying to talk the Pump Express protocol results in the external Vbus
>     voltage not being raised.
> 
> Add a new "linux,secondary-charger-name" string device-property, which
> can be set to the power_supply class device's name of the secondary
> charger when there is a secondary charger; and make the Vbus regulator and
> Pump Express code put the secondary charger in Hi-Z mode when necessary.
> 
> So far this new property is only used on x86/ACPI (non devicetree) devs,
> IOW it is not used in actual devicetree files. The devicetree-bindings
> maintainers have requested properties like these to not be added to the
> devicetree-bindings, so the new property is deliberately not added
> to the existing devicetree-bindings.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

I kind-of wonder whether there shouldn't be some generic implementation 
of this kind of charger interaction on subsystem level. But maybe that 
is something for a subsequent series.

Reviewed-by: Marek Vasut <marex@denx.de>
