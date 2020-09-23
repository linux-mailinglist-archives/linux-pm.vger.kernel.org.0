Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D652275DB7
	for <lists+linux-pm@lfdr.de>; Wed, 23 Sep 2020 18:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgIWQn7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Sep 2020 12:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWQn7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Sep 2020 12:43:59 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B70C0613CE
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2020 09:43:59 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p16so38236pgi.9
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2020 09:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9kKVBm2QDcEhoI7VNH0u9uwqsgFbX84K7to4q+EvAF8=;
        b=wo1HxCm5bKIVa9so0OH72jUPeuxpy0gBmSztrnAMX5SSm8gqDsd/uDbJD7n0nTY7Hv
         CKJoObg/EBB1JCvStmCq+2DKeNopjuTxhY6T7yv5TlzOVOSgvtBEy4neG07it4ARoA4J
         WHOi+7obrEMIUDmzT3kBBEHLDf0ZbrbNxMoUwtAnQnNZ4qwV/A1Mq5PJhKVbgpJ/Rod5
         V4wdCnvNPJU0KSWHIs05KbU5DxoLhNDG93YaWxwBm6g7XccmnyHw+ixRtSpxeaSGMhwd
         mx1/GOsS6pG7kDo6kprXjUbJ/6H+1rzHGTrQ7trw2dp1Uk7jyzCH8F6put7clvS8xmh3
         DueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9kKVBm2QDcEhoI7VNH0u9uwqsgFbX84K7to4q+EvAF8=;
        b=oyMXytkOyjvO6xvvAPraWayyUdzIoUENwRMlTMGWZUCXd27kXLe+M1uE2TMqYGdV+Q
         croIymWpFSON7FL5psYtQZSbEWrp5f42DrEyt3rbU/PFhVE/5EoKe6F/VLJGXzpMG+su
         6oisw8RZJV20nMv6MEkLvjIa4G4Rr1TOBJGFG6UavR6+ZoqYHCjpowN2jzTNEPxqoHiq
         i2/DLoZz6n9sE60TLqL6nAegSJpzGCIrMy+CM1bAL2Qqy4dGsyhsMKpc/7zmY/2PCCV5
         O3UmONHQWObuGgHVpNdy5ZwGLX6szR7h+sDaYHxFqfNzYVxEOQPVt+I0En2fq3zmer4Y
         hkXg==
X-Gm-Message-State: AOAM532ZB/8DkBPrblGtAyQM7JV5polbyS6YNb0JFVvKUsHV2OnWb78D
        AVbhINjoxD8z5/SXY5TmJjcb9g==
X-Google-Smtp-Source: ABdhPJzQnxjNRw3M1n4lJU3pDIkemY3ZCQKnOQ7VywhFrMYRm0itMgYfj3gWdktm3tes58COiW8SXA==
X-Received: by 2002:a62:2b52:0:b029:142:2501:39e9 with SMTP id r79-20020a622b520000b0290142250139e9mr746426pfr.56.1600879439083;
        Wed, 23 Sep 2020 09:43:59 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q190sm241046pfq.99.2020.09.23.09.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 09:43:58 -0700 (PDT)
Subject: Re: remove blkdev_get as a public API v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        linux-ide@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        linux-pm@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
References: <20200921071958.307589-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d23e5bd4-4d69-f909-eb8b-10c489b67f8b@kernel.dk>
Date:   Wed, 23 Sep 2020 10:43:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200921071958.307589-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/21/20 1:19 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series removes blkdev_get as a public API, leaving it as just an
> implementation detail of blkdev_get_by_path and blkdev_get_by_dev.  The
> reason for that is that blkdev_get is a very confusing API that requires
> a struct block_device to be fed in, but then actually consumes the
> reference.  And it turns out just using the two above mentioned APIs
> actually significantly simplifies the code as well.
> 
> Changes since v1:
>  - fix a mismerged that left a stray bdget_disk around
>  - factour the partition scan at registration time code into a new
>    helper.

Applied for 5.10, thanks.

-- 
Jens Axboe

