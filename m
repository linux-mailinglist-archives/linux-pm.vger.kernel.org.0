Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D474639C17
	for <lists+linux-pm@lfdr.de>; Sun, 27 Nov 2022 18:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiK0RiK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Nov 2022 12:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiK0RiJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Nov 2022 12:38:09 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6293BEE28
        for <linux-pm@vger.kernel.org>; Sun, 27 Nov 2022 09:38:06 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 53E1A83A26;
        Sun, 27 Nov 2022 18:38:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1669570684;
        bh=xH6545ZqTFpBcyC4j5tNrn032eTxgrl3gaHqc96gzq8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PMYrDGG/LoQuIF0xk1mQbH0NHMVkpEhxGZeIro3F/m26tCoK3q+1nupdOBFhfRSCQ
         zAFEaBSn95i3h0EMxeE2HkKa3rytTBUowKuBWJxrnuoSkR09OUWs3mLVAms+tb5zbY
         G72Lx+IQTQ62Ff7hy6fo+0iNtuYFEi15nWUW6PNFxdchiGNTk9cp+FgkjgCYbk9x9M
         USOVFoVYxf9qLIWF4w/wjaLZp8/bY8uVg1y5Zh2QYxnqSdDVV2gBijpW2CB10B23sj
         3xhfQYENYGFQYeqOgmVQGei3/YETAtBK6wv+WAuSBCfhF9+YBDTCz2fl7g9lPi6hfc
         JxAQbwZu416qQ==
Message-ID: <81267d70-4db6-d589-d515-e20e40c8b0db@denx.de>
Date:   Sun, 27 Nov 2022 18:38:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/2] power: supply: bq25890: Add HiZ mode support
To:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sre@kernel.org>
References: <20221126120849.74632-1-marex@denx.de>
 <20221126120849.74632-2-marex@denx.de>
 <0bb3a66a-17ad-74bd-7d1e-0e1402c6c9dd@redhat.com>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <0bb3a66a-17ad-74bd-7d1e-0e1402c6c9dd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/27/22 17:43, Hans de Goede wrote:

Hi,

[...]

>> @@ -522,7 +525,7 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
>>   		break;
>>   
>>   	case POWER_SUPPLY_PROP_ONLINE:
>> -		val->intval = state.online;
>> +		val->intval = state.online & !state.hiz;
> 
> Please use "&&" instead of "&" here, since these are both 1 bit values the "&"
> will also work but "&&" better expresses that this is a boolean compare and you
> use "||" in the negated cases above, so using "&&" is consistent with that.
> 
> I have fixed this up in my local copy of the patch.
> 
> I have also noticed some other issues, which are best addressed with a follow-up
> patch.
> 
> Once I have run a few final tests I plan to submit a bigger bq25890_charger
> patch series, which includes a bugfix to your previous series, as well as
> a few follow up patches to this series.
> 
> To make things easier for Sebastian, I'm going to include your patches
> in my bigger series, making that series look like this:
> 
> 1. A couple of bug fixes for the current bq25890 code
> 2. Your patches (this series) with the mentioned small "&" -> "&&" squashed in + my Reviewed-by
> 3. Some follow up patches from me to this series
> 4. My recent patches building on top of this series.
> 
> This way Sebastian can apply all the patches without conflict,
> which I hope makes things easier for him.
> 
> Marek, I will Cc you on the entire series.

Sounds good, thanks !
