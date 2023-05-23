Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDB470E362
	for <lists+linux-pm@lfdr.de>; Tue, 23 May 2023 19:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237894AbjEWQ75 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 May 2023 12:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237911AbjEWQ7y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 May 2023 12:59:54 -0400
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3670C19B
        for <linux-pm@vger.kernel.org>; Tue, 23 May 2023 09:59:04 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-61cd6191a62so32019386d6.3
        for <linux-pm@vger.kernel.org>; Tue, 23 May 2023 09:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684861143; x=1687453143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwRGjqJkSXRPJHHzQwuRJHCwrUdQwcyQ9byVzjawyEc=;
        b=N4+ov7h8wm1GWoLrbaDGUV4YnjbaidP7kcmuONjn5rg7DYf6X6QU32+E1UCq1nx5Kj
         DPxeAfngclVBhsOiP/dhJn7kjKqOC684PPnXy1nFWAZD+3kQwyLHeK1SN3jqHAMMDTdj
         w5MMf5hKb2qdW0cilgjVL+AlMsjZqhv9DjhHAd2UDL6a4Rg72yVn0LZmYoaxK1JfY8q7
         e2O4Rj7x1O+2cLtnff+2Ofwmd/MdtrVu93YdU0ZOwk8ETIZe/6FFqptyDsSDBAcr75AJ
         taZCAxX8YKETMaQBNKeG+qu1pUuCvBErk0UiuCUAgcFq9mFiL/OuHugQAFV1CHYm9Nnp
         peJA==
X-Gm-Message-State: AC+VfDy8upU0dszxpZG++NsQnFgb24fD5vpZhvSKDz/WoFMqvlJqkfIa
        mM3f8QB/s5q7vuuM/9jR2SR7
X-Google-Smtp-Source: ACHHUZ7KDQ2Jp5KWH/08+Nowc+ZerVbKYaqFsCmja4tNY6veUp3xnJBwfILDlwQLmRkuu4hWo14WpA==
X-Received: by 2002:ad4:5742:0:b0:621:64c7:235f with SMTP id q2-20020ad45742000000b0062164c7235fmr24446598qvx.27.1684861143301;
        Tue, 23 May 2023 09:59:03 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id x19-20020ae9f813000000b00759333a57adsm2666246qkh.11.2023.05.23.09.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 09:59:02 -0700 (PDT)
Date:   Tue, 23 May 2023 12:59:01 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 20/24] dm: only call early_lookup_bdev from early boot
 context
Message-ID: <ZGzw1c60WJBTNclC@redhat.com>
References: <20230523074535.249802-1-hch@lst.de>
 <20230523074535.249802-21-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523074535.249802-21-hch@lst.de>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 23 2023 at  3:45P -0400,
Christoph Hellwig <hch@lst.de> wrote:

> early_lookup_bdev is supposed to only be called from the early boot
> code, but dm_get_device calls it as a general fallback when lookup_bdev
> fails, which is problematic because early_lookup_bdev bypasses all normal
> path based permission checking, and might cause problems with certain
> container environments renaming devices.
> 
> Switch to only call early_lookup_bdev when dm is built-in and the system
> state in not running yet.  This means it is still available when tables
> are constructed by dm-init.c from the kernel command line, but not
> otherwise.
> 
> Note that this strictly speaking changes the kernel ABI as the PARTUUID=
> and PARTLABEL= style syntax is now not available during a running
> systems.  They never were intended for that, but this breaks things
> we'll have to figure out a way to make them available again.  But if
> avoidable in any way I'd rather avoid that.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/md/dm-table.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index e997f4322a9967..c230241a76b374 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -326,8 +326,11 @@ static int upgrade_mode(struct dm_dev_internal *dd, fmode_t new_mode,
>  /*
>   * Add a device to the list, or just increment the usage count if
>   * it's already present.
> + *
> + * Note: the __ref annotation is because this function can call the __init
> + * marked early_lookup_bdev when called during early boot code from dm-init.c.
>   */
> -int dm_get_device(struct dm_target *ti, const char *path, fmode_t mode,
> +int __ref dm_get_device(struct dm_target *ti, const char *path, fmode_t mode,
>  		  struct dm_dev **result)
>  {
>  	int r;
> @@ -346,8 +349,10 @@ int dm_get_device(struct dm_target *ti, const char *path, fmode_t mode,
>  			return -EOVERFLOW;
>  	} else {
>  		r = lookup_bdev(path, &dev);
> -		if (r)
> +#ifndef MODULE
> +		if (r && system_state < SYSTEM_RUNNING)
>  			r = early_lookup_bdev(path, &dev);
> +#endif
>  		if (r)
>  			return -ENODEV;
>  	}
> -- 
> 2.39.2
> 

I think/hope this will be fine:

Reviewed-by: Mike Snitzer <snitzer@kernel.org>
