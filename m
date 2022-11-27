Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC226639D56
	for <lists+linux-pm@lfdr.de>; Sun, 27 Nov 2022 22:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiK0VgK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Nov 2022 16:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiK0VgI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Nov 2022 16:36:08 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB70BF4B
        for <linux-pm@vger.kernel.org>; Sun, 27 Nov 2022 13:36:06 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 2254A8400F;
        Sun, 27 Nov 2022 22:36:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1669584964;
        bh=MdXp/MIH8bRopADfHap0x6lCrMgObIksvn2RwOL7UrQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VWXDzJUWmkdD9q3/RpmQxRm5AG5wvdxjDAQJ3YOdDPwTm9hWe3YWgDlCurgTRcN2D
         lNLh/KMcT2a349HiXBrsHKvDaQRj9tN2Nd4LqPfBu+dNFNKEgT6AG/XT53Z4OhDhD6
         KhBu+k+fJ466+JErKYiQ4zHKYwoWKrxQDu9hVwhAujJ+LnfzB/yJhvr+xyu+tkzJ1x
         8DNxIGADF94GSFb7GApByWaRzGpGLJ16mCUduCq+P32p/t+ofTTACHXO0o4BzSQFM1
         PshNvZCzNSDRF3xlYzD7Z50/0U36jlJ0QS8WIXAiHjHPKlC/lT/qGEt3tRu52Ud91W
         BIKWoFg830LTg==
Message-ID: <4c28094a-de79-cdaf-9449-eddd5039a004@denx.de>
Date:   Sun, 27 Nov 2022 22:16:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 01/10] power: supply: bq25890: Only use
 pdata->regulator_init_data for vbus
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org
References: <20221127180233.103678-1-hdegoede@redhat.com>
 <20221127180233.103678-2-hdegoede@redhat.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20221127180233.103678-2-hdegoede@redhat.com>
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
> bq25890_platform_data.regulator_init_data is intended to only provide
> regulator init_data for the vbus regulator.
> 
> Remove this from the regulator_config before registering the vsys
> regulator. Otherwise the regulator_register() call for vsys will fail
> because it tries to register duplicate consumer_dev_name + supply
> names from init_data->consumer_supplies[], leading to the entire
> probe of the bq25890 driver failing:
> 
> [   32.017501] bq25890-charger i2c-bq25892_main: Failed to set supply vbus
> [   32.017525] bq25890-charger i2c-bq25892_main: error -EBUSY: registering vsys regulator
> [   32.124978] bq25890-charger: probe of i2c-bq25892_main failed with error -16
> 
> Fixes: 14a3d159abf8 ("power: supply: bq25890: Add Vsys regulator")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Marek Vasut <marex@denx.de>
