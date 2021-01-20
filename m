Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A4D2FD985
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 20:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391914AbhATTYL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 14:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731961AbhATTXh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2021 14:23:37 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1667DC061575;
        Wed, 20 Jan 2021 11:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=KZ0iCEv8dO4oaEcXXlKBGTHYzPM9i6Lr3e34zMPgxiw=; b=s0r1NF4bIp0KXSj/YxPnbiRQlC
        5lsms4Jhix04Cgj4F3NEehgwMENlKw5VroDWGNkpT773VXJOPlxSYPvhKlPnj8smmJpKebTqufPzs
        +P79bRD+2C/Zedy/9Ea/VeKmgEA0L667/+TkXmALu1CeiDQ73oPrQhlnT6wZ1xGFNfvGRzznhgEF5
        R/6zgAuOtaUIwDNsMwL1Mvd3joURqhLI3qvDt+p5jOu6AA6QSMJJHczDuXotztySw0+BPrBI0gM5E
        2j0P386+6qzwI2C+KwQu58wBaUxQvA/YqLPpqeCU1LM5OQaI/WSDSJrkmRC08vs70fieMVONK7JUD
        e6uo5r1w==;
Received: from [2601:1c0:6280:3f0::9abc]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l2J49-0003PH-CD; Wed, 20 Jan 2021 19:22:53 +0000
Subject: Re: [PATCH] drivers: base: power: Fix resposible -> responsible in
 runtime.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rjw@rjwysocki.net,
        len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210120143312.3229181-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <50d66599-bd99-1402-a387-2c4d37ce1a61@infradead.org>
Date:   Wed, 20 Jan 2021 11:22:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210120143312.3229181-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/20/21 6:33 AM, Bhaskar Chowdhury wrote:
> s/resposible/responsible/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

thanks.

> ---
>  drivers/base/power/runtime.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index bfda153b1a41..a46a7e30881b 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1100,7 +1100,7 @@ EXPORT_SYMBOL_GPL(__pm_runtime_resume);
>   * suspending the device when both its runtime PM status is %RPM_ACTIVE and its
>   * runtime PM usage counter is not zero.
>   *
> - * The caller is resposible for decrementing the runtime PM usage counter of
> + * The caller is responsible for decrementing the runtime PM usage counter of
>   * @dev after this function has returned a positive value for it.
>   */
>  int pm_runtime_get_if_active(struct device *dev, bool ign_usage_count)
> --
> 2.30.0
> 


-- 
~Randy
"He closes his eyes and drops the goggles.  You can't get hurt
by looking at a bitmap.  Or can you?"
(Neal Stephenson: Snow Crash)
