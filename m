Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1CE639B918
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jun 2021 14:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhFDMgD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Jun 2021 08:36:03 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.144]:16218 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230262AbhFDMgC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jun 2021 08:36:02 -0400
X-Greylist: delayed 1248 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Jun 2021 08:36:02 EDT
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id EA1FE7635
        for <linux-pm@vger.kernel.org>; Fri,  4 Jun 2021 07:13:25 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id p8hZlHU0f1iQOp8hZlbhFJ; Fri, 04 Jun 2021 07:13:25 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eqKhXZsa1Dsfpezqh/4ReBH1SK5a/dlNfmODaKhMUVg=; b=RWKEzlcv4womW/oDY1tsgTCu7e
        moWq0Gdva6L/qTmMYSJAkkfAiBzDDne1pFuFvJhhOB1+waAY9H9MjIdwpbj1DrlwS9xH9TAVnt+/U
        DHgPv6/emXqeVxyzecDLVZ8DMSgTGBNXd56cRwOb/MM7F2HVYE72cHgzXGhPvk5okwnIrSkukI1q+
        RafHk+QewETN/ntSNKis9c1kcjby4MQ6dGvnMWb7R83vU2die7gXx/NY+bOA3dDug0F5yr+T+LSp4
        7O0VYP14FKZGEnHHTqiMOP4vh2iHvyQoztxsvnObYEyxgFFL4JSocqN3WMnWhurVan5bH4gjS2cQk
        Q+RyX5WA==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:38194 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lp8hX-001vay-IM; Fri, 04 Jun 2021 07:13:23 -0500
Subject: Re: [PATCH] power: supply: oplc_battery: Use fallthrough
 pseudo-keyword
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Wei Ming Chen <jj251510319013@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
References: <20210507124724.10825-1-jj251510319013@gmail.com>
 <20210604115424.3jjkrdd4ysbuamka@earth.universe>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <a1593ef1-3a5b-b036-7744-b724be5a9629@embeddedor.com>
Date:   Fri, 4 Jun 2021 07:14:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210604115424.3jjkrdd4ysbuamka@earth.universe>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1lp8hX-001vay-IM
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:38194
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/4/21 06:54, Sebastian Reichel wrote:
> [+cc Kees and Gustavo]
> 
> Hi,
> 
> On Fri, May 07, 2021 at 08:47:24PM +0800, Wei Ming Chen wrote:
>> Add pseudo-keyword macro fallthrough[1]
>>
>> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
>>
>> Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
>> ---
> 
> I suppose completely empty case branch is also ok and just not
> documented? I mean it does not hurt much in this case, but quite

Exactly; it's not documented because it doesn't need to be marked
with fallthrough; :)

Not sure what was the motivation for this patch.

--
Gustavo

> a few power-supply drivers have something like this and it would
> IMHO reduce readability to add fallthrough; to all of them.
> 
> property_is_writable(dev, prop) {
>     switch (prop) {
>         case A:
>         case C:
>         case E:
>             return true;
>         default:
>             return false;
>     }
> }
> 
> Thanks,
> 
> -- Sebastian
> 
>>  drivers/power/supply/olpc_battery.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/olpc_battery.c
>> index e0476ec06601..743b7f1cf9ea 100644
>> --- a/drivers/power/supply/olpc_battery.c
>> +++ b/drivers/power/supply/olpc_battery.c
>> @@ -238,6 +238,7 @@ static int olpc_bat_get_charge_full_design(union power_supply_propval *val)
>>  	case POWER_SUPPLY_TECHNOLOGY_LiFe:
>>  		switch (mfr) {
>>  		case 1: /* Gold Peak, fall through */
>> +			fallthrough;
>>  		case 2: /* BYD */
>>  			val->intval = 2800000;
>>  			break;
>> -- 
>> 2.25.1
>>
