Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5983BA185
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 15:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbhGBNqI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Jul 2021 09:46:08 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:42532 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbhGBNqH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jul 2021 09:46:07 -0400
Received: by mail-pj1-f41.google.com with SMTP id p17-20020a17090b0111b02901723ab8d11fso6112999pjz.1;
        Fri, 02 Jul 2021 06:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A8O7QLpS69tWkUIOVJYRaUSUHM9jeCpg1TDyB8l/WfE=;
        b=AkzIIjjQFagT3MRFqRHlIig3OTeoysRuD6PGzd9LgGnf2Q2dLHhpiyoAzz/rGSi50j
         eJXy9AUd8vY32OlGDgC1a624ub/qk5diKa709qB3qbROkHBTNecmCtNRpPp5TapGLw5s
         Dzx4w6EB7jHLwcHVeMiQ/MC5cbbpiQheyLWhrrXj875cJrQJDUdW6JmDeXrSQVDXXhq1
         XOTquTEj6MrU6HMvOyfGVFiZ3pqwo1Wh4w/8BMmK7haaXErBBYQdag44HWZ5VNWgue+J
         QnZ9Bee1tw330AzIVEnO+JM9VcmPq6FYkNpnh2PFuegihk6k9tTHSCpok7XT8Bn7dI9Z
         n3Kg==
X-Gm-Message-State: AOAM532lx13mbV5AIwu7ca6HYc7Eeq5+n/EBIVdrjNrsKfVxkhryEwG7
        5BCp0v0/nmBy5R34f+iRTYw=
X-Google-Smtp-Source: ABdhPJzXiskbJbYqJP+kYAuyYuVXSmi+ghRxO8IMEExGuk/sE1rHVR9pt46XfZdmem3E39NYRg+/6A==
X-Received: by 2002:a17:90b:3142:: with SMTP id ip2mr14954286pjb.63.1625233415268;
        Fri, 02 Jul 2021 06:43:35 -0700 (PDT)
Received: from [192.168.50.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id m205sm2975341pfd.25.2021.07.02.06.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 06:43:34 -0700 (PDT)
Subject: Re: [PATCH v5 2/3] scsi: sd: send REQUEST SENSE for
 BLIST_MEDIA_CHANGE devices in runtime_resume()
To:     Martin Kepplinger <martin.kepplinger@puri.sm>,
        Christoph Hellwig <hch@infradead.org>
Cc:     jejb@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, kernel@puri.sm,
        stern@rowland.harvard.edu
References: <20210630084453.186764-1-martin.kepplinger@puri.sm>
 <20210630084453.186764-3-martin.kepplinger@puri.sm>
 <YN3WD4Vem5Zx8Dvq@infradead.org>
 <b1d39dfbe1398192ef1181fc98d6b7e6bedeb649.camel@puri.sm>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <232717d6-fa10-aaec-cd15-8ed5e7e1117e@acm.org>
Date:   Fri, 2 Jul 2021 06:43:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b1d39dfbe1398192ef1181fc98d6b7e6bedeb649.camel@puri.sm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/2/21 1:04 AM, Martin Kepplinger wrote:
> Am Donnerstag, dem 01.07.2021 um 15:49 +0100 schrieb Christoph Hellwig:
>> On Wed, Jun 30, 2021 at 10:44:52AM +0200, Martin Kepplinger wrote:
>>> +       struct scsi_disk *sdkp = dev_get_drvdata(dev);
>>> +       struct scsi_device *sdp = sdkp->device;
>>> +       int timeout, res;
>>> +
>>> +       timeout = sdp->request_queue->rq_timeout *
>>> SD_FLUSH_TIMEOUT_MULTIPLIER;
>>
>> Is REQUEST SENSE reqlly a so slow operation on these devices that
>> we need to override the timeout?
> 
> using SD_TIMEOUT works equally fine for me. Is that what you'd rather
> like to see?
> 
> Bart, is SD_TIMEOUT equally ok for you? If so, I'll resend with your
> reviewed-by.

Hi Martin,

I prefer sdp->request_queue->rq_timeout instead of SD_TIMEOUT since the 
former is configurable via sysfs.

Thanks,

Bart.
