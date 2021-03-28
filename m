Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E092B34BD5B
	for <lists+linux-pm@lfdr.de>; Sun, 28 Mar 2021 18:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbhC1Qxo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Mar 2021 12:53:44 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:36752 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbhC1QxT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Mar 2021 12:53:19 -0400
Received: by mail-pl1-f177.google.com with SMTP id ay2so3259040plb.3;
        Sun, 28 Mar 2021 09:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mvRXE0XLYFueX2SPNFqy9a8VLw6xb54CbbEqC7V6ZA4=;
        b=mL2fqfb7bakBUGvM/fQZM6ytC8a3DpoevaQLkUTNS4oEOdG0iBnNQ/nQbhw2PB8bWf
         hWF1CNN8oGg4R3y35SH4aHXIrCAUGwfxVpzmcVcnvSW6FFE5Mh6avLbo4wl2kf+dOIqa
         48dpNL8Xm/FBqYgm1ed0fWHLuszVH1VBr2RFYd47X08tZrtG/1iNTLWJtcG/K1eK7moX
         4kwNeVels0qn2lJcJBSdX6L/ZCN62AhkSV7AeTxAsXYR/xwUXnfx/kVpuVTJo1FJg6iO
         Y+zjC9RMU0CPhcT14l2iZGv6L3/8fXEjWBKuPw9bdnsM8aqVmIvFzDa2QK3b56AqG9N7
         PYbg==
X-Gm-Message-State: AOAM530Vav1phE88tU6n3D/rBF26RPu5DeAJ5LaxRUreF3L2UcgxYGuK
        2VZ2e+FmIcFYd2ecIFS+8VI=
X-Google-Smtp-Source: ABdhPJykm+1+4pufUSxWSwufMfRHPmgmkjHpV8nY88F5RnutF5q/bMiNGvu+kEZoTslaBi8XdrZy5Q==
X-Received: by 2002:a17:902:c204:b029:e7:32fd:bc8f with SMTP id 4-20020a170902c204b02900e732fdbc8fmr11901521pll.43.1616950398405;
        Sun, 28 Mar 2021 09:53:18 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:7123:9470:fec5:1a3a? ([2601:647:4000:d7:7123:9470:fec5:1a3a])
        by smtp.gmail.com with ESMTPSA id d20sm7767575pfn.166.2021.03.28.09.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Mar 2021 09:53:17 -0700 (PDT)
Subject: Re: [PATCH v3 1/4] scsi: add expecting_media_change flag to error
 path
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     jejb@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
        martin.petersen@oracle.com, stern@rowland.harvard.edu
References: <20210328102531.1114535-1-martin.kepplinger@puri.sm>
 <20210328102531.1114535-2-martin.kepplinger@puri.sm>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <22533564-9f21-df1a-8cab-7996ccadc788@acm.org>
Date:   Sun, 28 Mar 2021 09:53:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210328102531.1114535-2-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/28/21 3:25 AM, Martin Kepplinger wrote:
> diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
> index 08c06c56331c..c62915d34ba4 100644
> --- a/drivers/scsi/scsi_error.c
> +++ b/drivers/scsi/scsi_error.c
> @@ -585,6 +585,18 @@ int scsi_check_sense(struct scsi_cmnd *scmd)
>  				return NEEDS_RETRY;
>  			}
>  		}
> +		if (scmd->device->expecting_media_change) {
> +			if (sshdr.asc == 0x28 && sshdr.ascq == 0x00) {
> +				/*
> +				 * clear the expecting_media_change in
> +				 * scsi_decide_disposition() because we
> +				 * need to catch possible "fail fast" overrides
> +				 * that block readahead can cause.
> +				 */
> +				return NEEDS_RETRY;
> +			}
> +		}

Introducing a new state variable carries some risk, namely that a path
that should set or clear the state variable is overlooked. Is there an
approach that does not require to introduce a new state variable, e.g.
to send a REQUEST SENSE command after a resume?

Thanks,

Bart.
