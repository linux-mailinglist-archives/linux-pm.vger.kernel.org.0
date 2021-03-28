Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9C534BD52
	for <lists+linux-pm@lfdr.de>; Sun, 28 Mar 2021 18:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhC1Qqm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Mar 2021 12:46:42 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:45039 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhC1Qqd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Mar 2021 12:46:33 -0400
Received: by mail-pg1-f172.google.com with SMTP id y32so6746962pga.11;
        Sun, 28 Mar 2021 09:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zUrmPJ5aVO2O9N2xMzVXNuPc7aWWUFka/oP/svM2se4=;
        b=WcVgAtQ8Tu9SamA/Lg7NXnk+MAwiqX5h8j6NTuhVZZwZmT+bTR/cQ0dUUiBbJpuDCE
         PDF0yaUZAbUZEYDkxa7Q7YZiWKUJJrA70QDkk6lp+xiG017l0bmR54lTuO8RASEmeBt6
         b5IQG2UWz+1Li+nU5oBLkQhiAj6bnmRFKUFUKY2wKQkyipVvN/Q4dvMe0EaCPjqAonpV
         gImSnBBubKqTkbbA2ZFeT3U5xxCA6DV7K+KMKVLWxdjBM2RNEpEccz+6O2ZGocjgaJQy
         KJvFztMKtawktsJvs9X9KG4Kqrat4fgCa4CTnfLydRpNvHjAhPC9duiUeW/SCG0jlSBu
         D2gA==
X-Gm-Message-State: AOAM533eAlqCEeoLzIlQea+bcIIPzWFEtjAaNVHujmVYTk7g6mLTeVM2
        idhwOQxoeevfMQdrH/+qZuM=
X-Google-Smtp-Source: ABdhPJzr8/xJbe8FMg1O03vwVwZlf/ewEaa+brN4/n9bqZDXynKjID3xF1FkMk8SZz16VsPfXJcMFw==
X-Received: by 2002:a63:e19:: with SMTP id d25mr14178412pgl.24.1616949993099;
        Sun, 28 Mar 2021 09:46:33 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:7123:9470:fec5:1a3a? ([2601:647:4000:d7:7123:9470:fec5:1a3a])
        by smtp.gmail.com with ESMTPSA id k5sm15193010pfg.215.2021.03.28.09.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Mar 2021 09:46:32 -0700 (PDT)
Subject: Re: [PATCH v3 3/4] scsi: sd: use expecting_media_change for
 BLIST_MEDIA_CHANGE devices
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     jejb@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
        martin.petersen@oracle.com, stern@rowland.harvard.edu
References: <20210328102531.1114535-1-martin.kepplinger@puri.sm>
 <20210328102531.1114535-4-martin.kepplinger@puri.sm>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <a82dacfb-70cf-da73-5a76-dc0c4cca0e62@acm.org>
Date:   Sun, 28 Mar 2021 09:46:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210328102531.1114535-4-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/28/21 3:25 AM, Martin Kepplinger wrote:
> Since these devices don't distinguish between resume and medium changed
> there's no better solution.

Is there any information in the SCSI VPD pages that could be used to
determine whether or not the medium has been changed, e.g. in VPD page 0x83?

Thanks,

Bart.
