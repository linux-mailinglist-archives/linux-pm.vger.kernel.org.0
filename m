Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3E63E1E1D
	for <lists+linux-pm@lfdr.de>; Thu,  5 Aug 2021 23:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbhHEVtu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Aug 2021 17:49:50 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:43892 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbhHEVtt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Aug 2021 17:49:49 -0400
Received: by mail-pj1-f41.google.com with SMTP id pj14-20020a17090b4f4eb029017786cf98f9so12944560pjb.2;
        Thu, 05 Aug 2021 14:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=85q1TWvdIg3Q1tg33lfn2LEZWz7HALfzriSudANt+bw=;
        b=TT7yu8uY5VopLdKnYPPLNFAubrR2t9sa7LXpFV6V3pCoUqIEmr58vk59Dw1JMaxzpm
         3tVH7jcMK2tXxLMI7/E4JCXnd8DWT79zKEiJmeBVqspBjzvdc5L4dTV2BSJTep0eJNLs
         VBYopcHpFkr0eFJhx9g0u+hDt7zIWWsCZBt9tUSjoD951S7vcYIoK8ES8qcVkzIT9McB
         Oxjh17oV1VpNodjLmQH1YMb7TxqcCvkMLR+FG2UgnmsgdXP2cUz+6ZTKAErd/T3HojKj
         N+5qM64m0OyyXzCmQz9Qas5hb/CPV/1DPKQMqw8NMO/Vqicl8lmjcRnRg1AycE5y3oyF
         kv2A==
X-Gm-Message-State: AOAM532Hgmq2sK3TH6J3+3iFUoOPOftz8a1vv1uj6MxRkGnXUD84ukcI
        rqyKCxpdCinWIb5SbNrg0cU=
X-Google-Smtp-Source: ABdhPJwl8oF/QtQiNY6vF8GhJ8tYsCzPCivI5KgNe9KMP8EIkKNEKEkY3Rjywfr9ezHQGHT4uqHegw==
X-Received: by 2002:a17:90b:1981:: with SMTP id mv1mr17640552pjb.227.1628200173404;
        Thu, 05 Aug 2021 14:49:33 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:93c2:eaf5:530d:627d])
        by smtp.gmail.com with ESMTPSA id p34sm7849792pfh.172.2021.08.05.14.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 14:49:32 -0700 (PDT)
Subject: Re: [PATCH V4 2/2] scsi: ufshcd: Fix device links when BOOT WLUN
 fails to probe
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        Bean Huo <huobean@gmail.com>, Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>
References: <20210716114408.17320-1-adrian.hunter@intel.com>
 <20210716114408.17320-3-adrian.hunter@intel.com>
 <c78aac34-5c55-f6b6-3450-d5c3f09781fa@intel.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <35b2bd0f-5766-debd-2b4c-c642a85df367@acm.org>
Date:   Thu, 5 Aug 2021 14:49:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <c78aac34-5c55-f6b6-3450-d5c3f09781fa@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8/4/21 8:33 AM, Adrian Hunter wrote:
> Martin, perhaps you could consider picking up this patch if no one objects?

Since patch 1/2 went in through Greg's tree, if patch 2/2 goes upstream 
via Martin's tree, will the resulting kernel be bisectable if Linus 
pulls Martin's tree before he pulls Greg's tree?

Thanks,

Bart.
