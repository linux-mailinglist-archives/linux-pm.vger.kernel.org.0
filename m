Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B1A3B936E
	for <lists+linux-pm@lfdr.de>; Thu,  1 Jul 2021 16:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhGAOiY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 10:38:24 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:42632 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbhGAOiY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 10:38:24 -0400
Received: by mail-pj1-f50.google.com with SMTP id p17-20020a17090b0111b02901723ab8d11fso4074662pjz.1;
        Thu, 01 Jul 2021 07:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rhwwrVZz+3q2u34WXXvY5qtEuhJYAxQ78ls6PGqWemA=;
        b=Y0NIfppQFYZh9z1ccl6P9Hht4rtGz55e+VtNRG6z67I8DIYrNxFMN0fWN+E5Tt1zVX
         SUN5X9Q/SIzwhFWJHBGtPnGeAXUDOTsW1cvWirxsS/x/arWSspvVh5TvGQB56X1PZ9jt
         NoBLInFH0aMl5SDkszy99d0252dMjnFbM13goHTOTyRsIrJcU4Uya8enJjdCR6mCnOsc
         sIMYClyDblp4JF7BOnI5LdDRGC8K4t5MQJEPYawiD3LlFTeWSraERZr3W9mjgcDLoZoS
         oGmLXsn/jTCuIpDWu5zqSHhjReIQE6eQmkLoAxz3PWKcqVIUBwKZVk6cN4ZswZMsQsPK
         U9XA==
X-Gm-Message-State: AOAM533Nbdk7phjEFIEgGbkKmp2gInr/4ukk7auBMLYjRznEejvJDYdC
        S+troVwUYITlY1qpMByCk34=
X-Google-Smtp-Source: ABdhPJxapccyljp3iISjUHH2+Nn7rh6IyOfdRchRc/IaMWHzTY6TGwdWsXOAPOH/MXX2xbAEwlRyAw==
X-Received: by 2002:a17:903:248e:b029:101:fa49:3f96 with SMTP id p14-20020a170903248eb0290101fa493f96mr217849plw.16.1625150152343;
        Thu, 01 Jul 2021 07:35:52 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:6a75:b07:a0d:8bd5? ([2601:647:4000:d7:6a75:b07:a0d:8bd5])
        by smtp.gmail.com with ESMTPSA id c9sm236888pfb.82.2021.07.01.07.35.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jul 2021 07:35:51 -0700 (PDT)
Subject: Re: [PATCH v5 2/3] scsi: sd: send REQUEST SENSE for
 BLIST_MEDIA_CHANGE devices in runtime_resume()
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     jejb@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, kernel@puri.sm,
        stern@rowland.harvard.edu
References: <20210630084453.186764-1-martin.kepplinger@puri.sm>
 <20210630084453.186764-3-martin.kepplinger@puri.sm>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <e84173b0-7ee5-4987-10ce-babc9f262be3@acm.org>
Date:   Thu, 1 Jul 2021 07:35:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630084453.186764-3-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/30/21 1:44 AM, Martin Kepplinger wrote:
> For SD cardreader devices that have the BLIST_MEDIA_CHANGE flag set,
> a MEDIA CHANGE unit attention is received after resuming from runtime
> suspend. Send a REQUEST SENSE to avoid that.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
