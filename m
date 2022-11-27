Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C593D639D55
	for <lists+linux-pm@lfdr.de>; Sun, 27 Nov 2022 22:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiK0VgJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Nov 2022 16:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiK0VgI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Nov 2022 16:36:08 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD13D2F2
        for <linux-pm@vger.kernel.org>; Sun, 27 Nov 2022 13:36:06 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 5F2BB850D1;
        Sun, 27 Nov 2022 22:36:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1669584965;
        bh=TzeKo5Mh7ICHTdgMprNU/6fv71pHoypygS2bF0thQA8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GscXsRz3YdkEeGug3ixjlvtxWbgm1CNrswgIqJUfuPbfluS+B8ZwkHgxHf0pU6F2G
         LwHMMesH2CGeF0wN9zngG7VzkrUCBGVO9NSvnOfkfD8m9QIVD1iaewzfYuGeRG6EvS
         aTZguzn/heHANstyTK3hk6sMMIZeXXn3Yf7JUp9I5WNA+8kUiRRB3z/JnTPAoKUrSD
         fQCpBV2YfarcUhnd5wrMyjKGgGjetnqugzTUpN2/7bGZgsUMFwynIa14/haX7K3MzT
         LiGBJyEsGjFWUT7B9s1G+/aafmY28qEXI7qTUa+tfgdv3QjwiprbKZ9v3z0SNu/E/U
         HYrPwrxBy4wsQ==
Message-ID: <b20d8c6b-0f1e-382e-27e2-7a3b63b2fb01@denx.de>
Date:   Sun, 27 Nov 2022 22:17:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 02/10] power: supply: bq25890: Ensure pump_express_work is
 cancelled on remove
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org
References: <20221127180233.103678-1-hdegoede@redhat.com>
 <20221127180233.103678-3-hdegoede@redhat.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20221127180233.103678-3-hdegoede@redhat.com>
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
> The pump_express_work which gets queued from an external_power_changed
> callback might be pending / running on remove() (or on probe failure).
> 
> Add a devm action cancelling the work, to ensure that it is cancelled.
> 
> Note the devm action is added before devm_power_supply_register(), making
> it run after devm unregisters the power_supply, so that the work cannot
> be queued anymore (this is also why a devm action is used for this).
> 
> Fixes: 48f45b094dbb ("power: supply: bq25890: Support higher charging voltages through Pump Express+ protocol")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

A comment in the code matching the last paragraph of this commit message 
would be helpful I think.

Reviewed-by: Marek Vasut <marex@denx.de>
