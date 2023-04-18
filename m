Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9148C6E686D
	for <lists+linux-pm@lfdr.de>; Tue, 18 Apr 2023 17:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbjDRPmK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Apr 2023 11:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjDRPmI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Apr 2023 11:42:08 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2ED8A5B
        for <linux-pm@vger.kernel.org>; Tue, 18 Apr 2023 08:42:07 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-328c29b587dso895475ab.0
        for <linux-pm@vger.kernel.org>; Tue, 18 Apr 2023 08:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1681832527; x=1684424527;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ws+tP+/n1Nzk7cpc3aqJ9f/a7UKxs5QX5O6zzTT+5Ag=;
        b=bfeOU2Hi5TQwfcpc4Frb2kZOPe/H5iVpkGnkyNAciLB0yb8BHanqFopr/P6vyuhVxw
         k9xnp7ICZ4+QDTeSlFNDUu76XLb47UXQSq+E3Dez7tZ3T/sqliYbd0VSktHhCE25xa6z
         yH1yYuItt1HBhf7BQeyT8q6DwYlBu+Zng8j4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681832527; x=1684424527;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ws+tP+/n1Nzk7cpc3aqJ9f/a7UKxs5QX5O6zzTT+5Ag=;
        b=RuD5R4LOBlo9gbQpyee+Idu85MnY2ZdP4Eg5qgKDm9/ltQ7V9evZ7978Muo2aVGWWg
         emFSZ6btN7Fk9fRJqpZ7DiSnufCHXw5r6Ep8LqKk1UdnOQjYMJ0o/3/Py5xPkJB00nHC
         5ZoTWr7vhlozTbDm8f5iF0bbPIbK+whyA2oNq85NOV6l48nHRpZUoIKRQDn40Q37Ctr9
         Jxq5FrLoWALfWyh5aWoR3/QuPggdtS7nvpC4uywv9x5frgLW2uDk/Rggkbtl/M2vM0c3
         0fzXSnYYKDpiCYPs0fjDNBDlRULPCfEtbUDK1ayffs5i3J+H235D67+7If0D7LFzhC5H
         XQMQ==
X-Gm-Message-State: AAQBX9dht91bme9sx1IsafuI3tNxca/O7gTzUskdaigAjpNA+WLCnlmU
        ygmgdytKCJtYbPSJZra1iQi1GBywm/qmQNMxVTM=
X-Google-Smtp-Source: AKy350arBx9RQyGaTymwP+zoBEZlGrhbOsSZ7wlA+l0fWtg/EHdWVGiwgJDxZ275ckxQEJdVjuqJ0w==
X-Received: by 2002:a05:6e02:1308:b0:32a:d83e:491e with SMTP id g8-20020a056e02130800b0032ad83e491emr6439122ilr.0.1681832526832;
        Tue, 18 Apr 2023 08:42:06 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id r2-20020a92c502000000b00322fd960361sm3883370ilg.53.2023.04.18.08.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 08:42:06 -0700 (PDT)
Message-ID: <dd604e20-1daf-5778-0408-956b27a1b640@linuxfoundation.org>
Date:   Tue, 18 Apr 2023 09:42:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4] cpupower:Fix resource leaks in sysfs_get_enabled()
Content-Language: en-US
To:     Hao Zeng <zenghao@kylinos.cn>
Cc:     trenn@suse.com, shuah@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230418013056.995478-1-zenghao@kylinos.cn>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230418013056.995478-1-zenghao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4/17/23 19:30, Hao Zeng wrote:
> The sysfs_get_enabled() opened file processor not closed,
> may cause a file handle leak.
> Putting error handling and resource cleanup code together
> makes the code easy to maintain and read.
> Removed the unnecessary else if branch from the original
> function, as it should return an error in cases other than '0'.
> 
> Signed-off-by: Hao Zeng <zenghao@kylinos.cn>
> Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>   tools/power/cpupower/lib/powercap.c | 23 ++++++++++++++++-------
>   1 file changed, 16 insertions(+), 7 deletions(-)
> 

Thank you.

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git cpupower
branch for Linux 6.4-rc1

thanks,
-- Shuah
