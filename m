Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABE2433EA8
	for <lists+linux-pm@lfdr.de>; Tue, 19 Oct 2021 20:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbhJSSnz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Oct 2021 14:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhJSSnz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Oct 2021 14:43:55 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A748C06161C;
        Tue, 19 Oct 2021 11:41:42 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id gn3so683765pjb.0;
        Tue, 19 Oct 2021 11:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yMmq/EvVUp6K2/9IlYhUruY5kDimDnW8QzqXZwCnn/Y=;
        b=KDloipmUeFx1W7w3ZzgQpdg2EUUoK+eAoyRMF7ETZTLIMs39uMKRTFGmLS5q0O+7hX
         kbXNnxSe+pSb3I+9daTBXIkaUwPs1jmXPOxWKNmbuRmbbzJjuo5XYfqoL6z9L5eLaJbo
         +ALVAgfFNt9R1QBUeuy0E16WhGGjaxlm9YguoXl0LnC0h/o+vV3P+bG2mk6Leg5YmLaJ
         1RpAjpbg+K/kbRw/nDeO2K3QjRhjb61/VuXYDdwskRy7RnQ1S96NBsvFWdnpne/Zuf76
         bgOZ3j4UuzCNTzDccMErGOGsWqrJzxxDXTGkGh5FKML+oMIsEdx8nAZ3FaQnfNRyL8WZ
         +7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=yMmq/EvVUp6K2/9IlYhUruY5kDimDnW8QzqXZwCnn/Y=;
        b=ksZ5jbj8wwmXG/CbRYiYwu3gCGYSS6RRNVda6SfYzHcQGEFL2WeRAec7rnBI0Cl4zw
         mStJpSzA/jvlyUp5Qh6PRGES5GlFsI5gBgdk1z+QZCfPbZjxS0KQeKqrjsdVN5RGwCSN
         zlzUloDVkDRw9Gu244KKf0n0mfCJXhwWIQgCjoV2xK9DXymm1TJBje/EP3OUJvfv6mg8
         gjkvAqDL4UwaE8QVbV7SXM2cq/grmTLSywgUzIJ7YtKHUl0VxGaRaOrDWlv5pDWA/MrJ
         4LLUmaj5U0UVxBmT50yVP68LRNd8YoGVYfkvf0JzuxG4725f3IxAlGfIrIBkCGjo0qSi
         mYLg==
X-Gm-Message-State: AOAM531oFLXqXYMwUjesFIL8+vGT+zWnJeSExA/xpdgBwEbN1ReSz277
        mkJ3ayskwB+R/30HteKivaE=
X-Google-Smtp-Source: ABdhPJzPx4AgsWbz11VtL9l8HJ4U9YNHo08SHbucAYizDyOmrLQqyiEuOfHfa3WyRdm2HILYdrLU1w==
X-Received: by 2002:a17:90b:3786:: with SMTP id mz6mr1720720pjb.245.1634668901861;
        Tue, 19 Oct 2021 11:41:41 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id bp19sm3194802pjb.46.2021.10.19.11.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 11:41:41 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 19 Oct 2021 08:41:39 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     jiangshanlai@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, rafael@kernel.org, pavel@ucw.cz,
        len.brown@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH v3] workqueue: Introduce show_one_worker_pool and
 show_one_workqueue.
Message-ID: <YW8RYxb3rKGcD5mR@slm.duckdns.org>
References: <20211016002007.143661-1-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211016002007.143661-1-imran.f.khan@oracle.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Oct 16, 2021 at 11:20:07AM +1100, Imran Khan wrote:
> Currently show_workqueue_state shows the state of all workqueues and of
> all worker pools. In certain cases we may need to dump state of only a
> specific workqueue or worker pool. For example in destroy_workqueue we
> only need to show state of the workqueue which is getting destroyed.
> 
> So rename show_workqueue_state to show_all_workqueues(to signify it
> dumps state of all busy workqueues) and divide it into more granular
> functions (show_one_workqueue and show_one_worker_pool), that would show
> states of individual workqueues and worker pools and can be used in
> cases such as the one mentioned above.
> 
> Also, as mentioned earlier, make destroy_workqueue dump data pertaining
> to only the workqueue that is being destroyed and make user(s) of
> earlier interface(show_workqueue_state), use new interface
> (show_all_workqueues).
> 
> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>

Can you respin the patch on top of the following branch?

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.16

Thank you.

-- 
tejun
