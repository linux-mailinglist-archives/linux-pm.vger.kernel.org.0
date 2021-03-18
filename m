Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154AA340C88
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 19:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhCRSKx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 14:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhCRSKp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 14:10:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57F4C06174A;
        Thu, 18 Mar 2021 11:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=VpBVHEHjT9Gn8HLTeG3OWujXi0ViVeHzxP9bjFBnQQo=; b=Mbevz6wwP8YcVaAWZYp9yt4OYl
        +0eC0M9P7IddC9+MkZCAJIoQTfbeb2eQYebx5ht2ZmXdliNKEUl/eOl/mQYjzh1uQCR8ciuyg+6Pu
        e2UBRCnHfwmW0teD5Q6Nch43yUylbtZ82Fa0bT8bEKH8aa/CAOepq5fLUvvO8ckkcSn6oDhBp7kiG
        qR/sbQBLj3rrbyFSg7u+ns5oq3Wq8J6Mwy0AdgeJMIT4lsqFryyy0aKKUUzX1buibJUYLlXk5Qc6l
        QRT05zRHo2gkyq5Ubp0Ci7p15ChIn54y1LDDDBX+KfOkQLc0Hrg7zTN6bJ2qO4oip+NfaeIc0W6Kc
        s528fZUg==;
Received: from [2601:1c0:6280:3f0::9757]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMx6I-003Kat-UF; Thu, 18 Mar 2021 18:10:34 +0000
Subject: Re: [PATCH] PM: devfreq: Couple of typo fixes
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, cw00.choi@samsung.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210318112025.22755-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <46a5ce65-c5c9-8d1e-9bc1-12ff56c28186@infradead.org>
Date:   Thu, 18 Mar 2021 11:10:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210318112025.22755-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/18/21 4:20 AM, Bhaskar Chowdhury wrote:
> 
> s/stoping/stopping/
> s/opeations/operations/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  drivers/devfreq/devfreq-event.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
> index 6765c03334bc..2f841d7d9d8d 100644
> --- a/drivers/devfreq/devfreq-event.c
> +++ b/drivers/devfreq/devfreq-event.c
> @@ -155,7 +155,7 @@ EXPORT_SYMBOL_GPL(devfreq_event_set_event);
>   * @edata	: the calculated data of devfreq-event device
>   *
>   * Note that this function get the calculated event data from devfreq-event dev
> - * after stoping the progress of whole sequence of devfreq-event dev.
> + * after stopping the progress of whole sequence of devfreq-event dev.
>   */
>  int devfreq_event_get_event(struct devfreq_event_dev *edev,
>  			    struct devfreq_event_data *edata)
> @@ -184,7 +184,7 @@ int devfreq_event_get_event(struct devfreq_event_dev *edev,
>  EXPORT_SYMBOL_GPL(devfreq_event_get_event);
> 
>  /**
> - * devfreq_event_reset_event() - Reset all opeations of devfreq-event dev.
> + * devfreq_event_reset_event() - Reset all operations of devfreq-event dev.
>   * @edev	: the devfreq-event device
>   *
>   * Note that this function stop all operations of devfreq-event dev and reset
> --
> 2.26.2
> 


-- 
~Randy

