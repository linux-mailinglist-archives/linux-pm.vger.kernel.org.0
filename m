Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2F53B7C89
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jun 2021 06:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhF3EWt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Jun 2021 00:22:49 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:38802 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhF3EWt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jun 2021 00:22:49 -0400
Received: by mail-pj1-f52.google.com with SMTP id cs1-20020a17090af501b0290170856e1a8aso3381217pjb.3;
        Tue, 29 Jun 2021 21:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u8J7Yl4OGOCLjzbKj5DpiKK+IE2cs8gVlsUXpHJs5ug=;
        b=IVab2Nf8SgONCvC9aNliRClvKhkbpwUgJbdO30XJmr6vfaVU91XaS2eSU4Wmo8WIRH
         X8Hw8yTuU6wOdvGOto9Xm/lNJt/RszfY6UUHCwAWKbGLmwmVs/K/gSvfmiWwu5tyd9hP
         HIewGxWK9XPt/vpuw/sCgKg9TTJXdtwOH75PkOnJhXxsSWk9KnjROpDlVv0rE/6JFF5l
         jmE4lIk/JjDDwg686J3z/jKlGB+/NUBuQLU9lqZQPXd+FuL7ZBgw10M/J1C699dZaf9x
         QiVuaSUDZBdPYXoKZL03FTlOGQ8N60oZBHNxpsrGGdQLBGtOOHFGSvkw5P1bY/Aipqqb
         m+sQ==
X-Gm-Message-State: AOAM530FtCfeqe3YWwkoKm416X8/COYGU/RiFBmvoRjDdQq84XM4Ixwz
        9XApdwZdab+6/hz7Y07nmqo=
X-Google-Smtp-Source: ABdhPJxbLMRWntzXediNp1/2eNs0/uwkhFfdoGy6hvJMxJ/Hqrf9Ihu4jVyXxCz+Gq1lE4b5nOHJ7A==
X-Received: by 2002:a17:902:ea12:b029:128:977b:fa78 with SMTP id s18-20020a170902ea12b0290128977bfa78mr24686188plg.15.1625026820695;
        Tue, 29 Jun 2021 21:20:20 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:b36f:1d4c:3b33:df45? ([2601:647:4000:d7:b36f:1d4c:3b33:df45])
        by smtp.gmail.com with ESMTPSA id q27sm20276707pfg.63.2021.06.29.21.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 21:20:19 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] scsi: devinfo: add BLIST_MEDIA_CHANGE for Ultra
 HS-SD/MMC usb cardreaders
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     jejb@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, stern@rowland.harvard.edu
References: <20210628133412.1172068-1-martin.kepplinger@puri.sm>
 <20210628133412.1172068-4-martin.kepplinger@puri.sm>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <a77f4fc7-39dc-cf1a-c317-43fdd2c49bde@acm.org>
Date:   Tue, 29 Jun 2021 21:20:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210628133412.1172068-4-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/28/21 6:34 AM, Martin Kepplinger wrote:
> These cardreader device issues a MEDIA CHANGE unit attention not only
> when actually a medium changed but also simply when resuming from suspend.
> 
> Setting the BLIST_MEDIA_CHANGE flag enables using runtime pm for SD cardreaders.

"device issues" -> "devices issue"? Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
