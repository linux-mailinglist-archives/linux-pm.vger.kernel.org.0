Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BAD639D59
	for <lists+linux-pm@lfdr.de>; Sun, 27 Nov 2022 22:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiK0VgL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Nov 2022 16:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiK0VgK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Nov 2022 16:36:10 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A940BF4B
        for <linux-pm@vger.kernel.org>; Sun, 27 Nov 2022 13:36:09 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 04C90835FE;
        Sun, 27 Nov 2022 22:36:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1669584968;
        bh=8uKaQIGdvQXTbnoAHR4WB2dFAM7SCoRNVIzbTz8fIl4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=l2PKZWYqm3S4lBYq4rRcKqd1d9TIa2W3xqv0rwyX4c34ajBY/SAbYoGwzEsvhyDBK
         4h7HivBjGDGftz3GIlDelcTbNNJszAxZWXNHIwPjDJo+lepZK5zBLvoGHH1tNU8KAk
         GZPFvVHm2WnvGndoITC92JBSVah4K7qLSAfMTz5g2/Sr0IVrz1E3AvlRNf24sYrk/Q
         Ueq/+bhh0C1p3RKPQSlEPxZDipeuq5zyxJLIvU8drFIsBa9bjbcCTyOg2sgALlJOcx
         GjLlrHFYkyXjKS+n2Ama7hNB6vmgBGyM9kB/DSUudlhTLRyywI+Ypb5UHQW+tWkUNC
         MMMSa5rZKHsnA==
Message-ID: <49894bab-3ff2-2153-9253-4b672b680983@denx.de>
Date:   Sun, 27 Nov 2022 22:25:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 07/10] power: supply: bq25890: Always take HiZ mode into
 account for ADC rate
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org
References: <20221127180233.103678-1-hdegoede@redhat.com>
 <20221127180233.103678-8-hdegoede@redhat.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20221127180233.103678-8-hdegoede@redhat.com>
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
> The code to check if F_CONV_RATE has been set, or if a manual ADC
> conversion needs to be triggered, as well as the code to set
> the initial F_CONV_RATE value at probe both where not taking
> HiZ mode into account. Add checks for this.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Marek Vasut <marex@denx.de>
