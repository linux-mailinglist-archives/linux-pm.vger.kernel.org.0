Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB4A344FCA
	for <lists+linux-pm@lfdr.de>; Mon, 22 Mar 2021 20:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhCVTU0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Mar 2021 15:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhCVTT5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Mar 2021 15:19:57 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDA7C061574;
        Mon, 22 Mar 2021 12:19:57 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v11so18337048wro.7;
        Mon, 22 Mar 2021 12:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=XQseG+vS6FVhRx/oQta3S0usw68fkincPFQ5bP01yH4=;
        b=jxRk5NHzUembvmgk1WfSORNIUqkmesKAjcNciwMeOvBqtFZE6oBWFcMH12wRDqNQSW
         dWOFZM+nHs/Bdui2xUFDh0eRsBr7rNs5rz5LEeuw1shbvwnbYkycagdNcCDH++7JRyLN
         2VNKwpto9bVsBSeJXeykXpYmlmBtTFKbHm5CXlex+sYjH09xlTOn1IjPMLmDTgJLunFY
         V1VViKgQVbwnNXJRVKqo0xsL7uMHmUCJzgNvjM7kTfjhPqzy7AVFnMx9QQ1eMyjl0R0t
         YOvfMzKkfuWQnBXHXyllC4oDTx96tHVFLPUXWjFcmxoy+nD9UkGZUkfYQOCOXz7g20AF
         Tc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=XQseG+vS6FVhRx/oQta3S0usw68fkincPFQ5bP01yH4=;
        b=VzYvxCEUKCu/ep8LIXsR2Y3k895p/snq0c/rkq90EwLhUn1PS1C1Bm7BNxETWE02Cg
         CeGPb/UKT8WVNp7nV64FEH7T6Kr4kEKWbB+AsHzG1Sa4A/Yr/iDzer/K8eVFJdEjxoOM
         Xf1gi1rIPVNd2gXtgCCnLWIB8yI2uFctMA4/qVN7suBt3s4ve/oJ7SdyGF3fC92mn+E+
         HNSUlBKjHccm1E3UmtPZoOQ4Ad0XxHNqFjyPdhhfMLln3XXop+3CIulBlH/OY7BHCyeX
         q+PEmnbEKda4wvKnrxN0cZG1lZz2WHF2Njffk9wsYC8rh+qHbAMSVl6btpkABgVjYfXG
         uNCA==
X-Gm-Message-State: AOAM530C+1DAvT9TQ5KDdHD1mV/6HwAPr5AYBZdpPIEPGfBCdqx+dEGE
        Ar0VpyGGEzJLHmWYkDXDxJI=
X-Google-Smtp-Source: ABdhPJyWA8nDg2lWTNgP9luWb/6mtZX1inEaC3NW7cCw6JG/Q4v6l1WG6IrJgaPvz+pvhodfep4guA==
X-Received: by 2002:a05:6000:1547:: with SMTP id 7mr69306wry.365.1616440795875;
        Mon, 22 Mar 2021 12:19:55 -0700 (PDT)
Received: from 192.168.8.101 ([111.119.187.31])
        by smtp.gmail.com with ESMTPSA id o15sm15253100wra.93.2021.03.22.12.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 12:19:55 -0700 (PDT)
Message-ID: <959e827d3407bfee9a367d8a68aa9aed184ddcf5.camel@gmail.com>
Subject: Re: [PATCH] thermal/core: avoid memory leak
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        colin.king@canonical.com
Date:   Tue, 23 Mar 2021 00:19:50 +0500
In-Reply-To: <20210322191817.GG1717@kadam>
References: <20210322191204.GA2122573@LEGION> <20210322191817.GG1717@kadam>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2021-03-22 at 22:18 +0300, Dan Carpenter wrote:
> On Tue, Mar 23, 2021 at 12:12:04AM +0500, Muhammad Usama Anjum wrote:
> > When memory allocation for cdev is successful but ida_simple_get fails,
> > branch to out_kfree_cdev label happens and cdev isn't freed. There are
> > other some other branches in which the memory can leaked. Fix it by
> > freeing cdev.
> > 
> 
> The patch is correct, but Daniel already sent a fix for it.
> 
Got it. Thank you.

Thanks,
Usama
> regards,
> dan carpenter
> 

