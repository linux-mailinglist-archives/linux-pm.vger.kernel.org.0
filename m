Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB38323B0EF
	for <lists+linux-pm@lfdr.de>; Tue,  4 Aug 2020 01:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgHCXbI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Aug 2020 19:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgHCXbH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Aug 2020 19:31:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0829C06174A;
        Mon,  3 Aug 2020 16:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=nY1BD+OgwGXtiyrMMaJXadzrrIDNfHmtspydZcAV3LA=; b=iiUNiQD7jhIo194MEQM6uDkUtk
        x1kY90nRb/wKVe8+MI4AG6Iq9ZvrzrtEC1LPQ7PPW00spxgPytuNPUX2Oc9EHRBaeIUimX+m/TQVY
        6AmPmTRfIsnKmEq9CGN1pUZTo9plsKzGNZdAO4XYiUPc2u1Tsc98dIVozn1JNAFaO670yy+x4EE9P
        mJ0TwsG1NnYlvL+p45itpZUi0AlyIbnGp+tEwIurSwxlaSdUG3oyS81GCA0AmQHAqp3VqGKU7A6a1
        fi1GXneSNMf3FUwEP7AaAW+BNndMxzOOcbAlx1UxGP7UVnlwr9KlUkdjBec7YFS3Huo8RTmKNlmYJ
        hPoIVsgw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2juy-0007ex-8O; Mon, 03 Aug 2020 23:30:57 +0000
Subject: Re: [PATCH v3] sched: Provide USF for the portable equipment.
To:     Dongdong Yang <contribute.kernel@gmail.com>,
        gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org, yangdongdong@xiaomi.com,
        tanggeliang@xiaomi.com, taojun@xiaomi.com, huangqiwu@xiaomi.com,
        rocking@linux.alibaba.com, fengwei@xiaomi.com,
        zhangguoquan@xiaomi.com, gulinghua@xiaomi.com, duhui@xiaomi.com
References: <cover.1596464894.git.yangdongdong@xiaomi.com>
 <23719695ee476715ec54d3310c95d535f8e1391a.1596464896.git.yangdongdong@xiaomi.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cb8dc2cc-376a-f7e5-614b-400245204b34@infradead.org>
Date:   Mon, 3 Aug 2020 16:30:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <23719695ee476715ec54d3310c95d535f8e1391a.1596464896.git.yangdongdong@xiaomi.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8/3/20 7:31 AM, Dongdong Yang wrote:
> diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
> index 4ec5528..05b231e 100644
> --- a/drivers/staging/Kconfig
> +++ b/drivers/staging/Kconfig
> @@ -120,4 +120,6 @@ source "drivers/staging/qlge/Kconfig"
>  
>  source "drivers/staging/wfx/Kconfig"
>  
> +source "drivers/staging/fbsched/Kconfig"

where is this fbsched/Kconfig and its associated source files?

> +
>  endif # STAGING


-- 
~Randy

