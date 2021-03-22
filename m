Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49720344FF1
	for <lists+linux-pm@lfdr.de>; Mon, 22 Mar 2021 20:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhCVTez (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Mar 2021 15:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhCVTeh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Mar 2021 15:34:37 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8041EC061574;
        Mon, 22 Mar 2021 12:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=7xKmCxyQPvl42IWT3XOz+Eqs7sg3fubOuPLoTQP1+NM=; b=DrCzi4T1XOoI9G0w9+1gRJ3Urk
        plZc9P1yY/d9kR51+Zo3eC65spGBf0aak1Kc7Bbd2swCkkVUUcuQr+wxy7bPoogw0j3o0mNkf8wD7
        ypxN5AWVx6q+cCb8ukr1WHgoW4YdeJ0EVhL6O/YCpHj6wvYRTnXdzl3rh5GNatYcZuj0wZ49LAAuZ
        KgE4cdqowHaKZH1lRw1SLeHLSNzoN2BlftTFJHs+kGpXIqUu0JnmOih6UQe/vlsUnYBWEXyMrtGnO
        lZcanoU/S590lV66nz8pKStJiN1b6XrVyEAm5fQJ6SkGS2eXF8PZPXwDKuxFq4Nl84dq592xubHSA
        A5Pu6adw==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOQJu-00CRLI-Mn; Mon, 22 Mar 2021 19:34:35 +0000
Subject: Re: [PATCH] PM: devfreq: Fix a typo
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, cw00.choi@samsung.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210322072454.864068-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5a1ecec1-676a-1453-ba9a-cb1e7f6bafd5@infradead.org>
Date:   Mon, 22 Mar 2021 12:34:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210322072454.864068-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/22/21 12:24 AM, Bhaskar Chowdhury wrote:
> 
> s/stoping/stooping/

nope.

> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  drivers/devfreq/devfreq-event.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
> index 6765c03334bc..5e1908507783 100644
> --- a/drivers/devfreq/devfreq-event.c
> +++ b/drivers/devfreq/devfreq-event.c
> @@ -155,7 +155,7 @@ EXPORT_SYMBOL_GPL(devfreq_event_set_event);
>   * @edata	: the calculated data of devfreq-event device
>   *
>   * Note that this function get the calculated event data from devfreq-event dev
> - * after stoping the progress of whole sequence of devfreq-event dev.
> + * after stooping the progress of whole sequence of devfreq-event dev.
>   */
>  int devfreq_event_get_event(struct devfreq_event_dev *edev,
>  			    struct devfreq_event_data *edata)
> --


-- 
~Randy

