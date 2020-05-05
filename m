Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9321C5F66
	for <lists+linux-pm@lfdr.de>; Tue,  5 May 2020 19:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbgEERz3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 May 2020 13:55:29 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39655 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729315AbgEERz3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 May 2020 13:55:29 -0400
Received: by mail-pl1-f196.google.com with SMTP id s20so1127650plp.6;
        Tue, 05 May 2020 10:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1XnfAt3AGQh/rZFKS28B4m7OBt34dcyuM9xZseDj1Xg=;
        b=V2a9379zoGg3wdiuWGt8M6z5qkVEYZ25os4xgwLlG+2FnOHjtr70iuN6CBeQ8cEy2+
         x4eckPo2By8HsZGrsbfFgyDwxPR49Z0X+F5OePeVQ+4qf1/hCYpZya7NgBKTz07nNPGs
         Q8uyglXxR3J3AxZXxCUmmYic/nq69FdX/ngEiwX+LEyBSeoxsb3SNuXgJAeVYfHJw4Xr
         opVR5iSRQmsoMTAmGI00BgaYZDzTszHRj3U8uEwdzSq72LI8CmauFHK/iTnn7sENbWJI
         ZITGUDEW33iVdkTTqyKCapYov5upwlMT+NipxNoPqOPHq9bC1Wyg7yoydPPDMs1Q56ls
         Ji5Q==
X-Gm-Message-State: AGi0Pubf6c/6S2bCsBepki4VsVPkzpSeeGptO8dFBt27uyuFqtSBoD1C
        VIpf205YWCrkuNnGP8KlFoZELY9FfJk=
X-Google-Smtp-Source: APiQypICWTGE1KQHkpbZ7IS/dKQ3RPVusxPoSo0sC1YDpPK0n48xr0WoIfvQv3xSkcps+BXqktFuqA==
X-Received: by 2002:a17:90a:3327:: with SMTP id m36mr4559967pjb.116.1588701326798;
        Tue, 05 May 2020 10:55:26 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:b435:750c:4181:403d? ([2601:647:4000:d7:b435:750c:4181:403d])
        by smtp.gmail.com with ESMTPSA id c10sm2783227pfm.50.2020.05.05.10.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 10:55:25 -0700 (PDT)
Subject: Re: [PATCH v2] block: Make request_queue.rpm_status an enum
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200505140314.28813-1-geert+renesas@glider.be>
From:   Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <92f41148-5973-a786-31f8-7a4e2f4c9b6c@acm.org>
Date:   Tue, 5 May 2020 10:55:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505140314.28813-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-05-05 07:03, Geert Uytterhoeven wrote:
> request_queue.rpm_status is assigned values of the rpm_status enum only,
> so reflect that in its type.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> Perhaps this was done to avoid the need to #include <linux/pm.h>?
> Let's see what kbuild has to report about this...
> 
> v2:
>   - Add Acked-by.
> ---
>  include/linux/blkdev.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index f00bd4042295967d..1e2c6f7a188941f1 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -454,7 +454,7 @@ struct request_queue {
>  
>  #ifdef CONFIG_PM
>  	struct device		*dev;
> -	int			rpm_status;
> +	enum rpm_status		rpm_status;
>  	unsigned int		nr_pending;
>  #endif

Forward declarations of enums are not supported by the C language as far
as I know. Relying on kbuild to decide whether or not to include
<linux/pm.h> seems wrong to me. Please either add #include <linux/pm.h>
or drop this patch.

Thanks,

Bart.
