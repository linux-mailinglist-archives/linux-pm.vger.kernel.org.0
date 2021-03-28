Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951C634BD5E
	for <lists+linux-pm@lfdr.de>; Sun, 28 Mar 2021 18:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhC1Qyt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Mar 2021 12:54:49 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:46804 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbhC1QyZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Mar 2021 12:54:25 -0400
Received: by mail-pf1-f171.google.com with SMTP id x126so8278723pfc.13;
        Sun, 28 Mar 2021 09:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cOvZHgHcQoUoCNnI/BSccLwDn7HyC/XNdV/V6GVUOF0=;
        b=q9gJWb4/nxspnT68g+jxZeHU37OCW0wwHPQHnZs7VdBjab5h1Unkd+0DGbm+Z/SdiF
         NX/AaZZgVHWbfWIlKZQwTdi6rGUGEkn9Z7mcpTvTFsVs+GhACl+cYSZSJA2JolgXgNXd
         FvxwyTihZkcuvERazGpV/FhQrSNrhP9KhiSCC8iX4Of0p9m9lf+QU5P9Du0F+/y6fBES
         PlYNTHkIxy6Xar8Xq9ONuBReXB/5tbFst6RCdaC5FqosYk8VHg0pbCr2nANGAXJYzVqj
         5vS0EJhVy/JIucbY6FXaLkKtkaJZfheG/7xn6Z9w/gsvAQFc1SXMrs6qZjFGvXqLKEn6
         9TQQ==
X-Gm-Message-State: AOAM532a7fd6vpzycmpCuAMXBbquR7qHZTavRcOyLTdIqEejgXvsQZux
        AONG9J86sKzUN//RWHThN5A5JOs9qhw=
X-Google-Smtp-Source: ABdhPJwu6+cT4o9DHZ4ruS4HPmjsDt7ggFXXEyCnwchLU284GLDkxFCY5824EAeooY9wTtti90YXYA==
X-Received: by 2002:a63:6486:: with SMTP id y128mr15181054pgb.260.1616950464684;
        Sun, 28 Mar 2021 09:54:24 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:7123:9470:fec5:1a3a? ([2601:647:4000:d7:7123:9470:fec5:1a3a])
        by smtp.gmail.com with ESMTPSA id u79sm15481286pfc.207.2021.03.28.09.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Mar 2021 09:54:23 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] scsi: devinfo: add new flag BLIST_MEDIA_CHANGE
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     jejb@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
        martin.petersen@oracle.com, stern@rowland.harvard.edu
References: <20210328102531.1114535-1-martin.kepplinger@puri.sm>
 <20210328102531.1114535-3-martin.kepplinger@puri.sm>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <96931408-2613-4de3-e220-fd63f02b6095@acm.org>
Date:   Sun, 28 Mar 2021 09:54:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210328102531.1114535-3-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/28/21 3:25 AM, Martin Kepplinger wrote:
> +/* Ignore the next media change event */
> +#define BLIST_MEDIA_CHANGE	((__force blist_flags_t)(1ULL << 11))

That comment is not descriptive enough. Consider to change it into
something like the following: "ignore one MEDIA CHANGE unit attention
after resuming from runtime suspend".

Thanks,

Bart.
