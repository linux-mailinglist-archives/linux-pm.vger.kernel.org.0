Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 837C73265B
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2019 04:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfFCCJG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Jun 2019 22:09:06 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35010 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfFCCJG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Jun 2019 22:09:06 -0400
Received: by mail-pg1-f194.google.com with SMTP id s27so1737389pgl.2;
        Sun, 02 Jun 2019 19:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HqluNYrDBsoPinlng5BznRxmf0UReQXXe0CGI9T8DwI=;
        b=p3Iq0AntEOA964pYuRQ0D31Kbq7J6y7pO0NpDP/cQPhHCUITOaWm94FP2C2a6GvW0M
         I8YTTCsM+IPg5RHEVR7Gxn7jxy5wJSi1400Bs5G5tAqKNgI06D8K3UAT/HB89Ed1a3Ml
         ie4OaW5RaTzDDIBlNJwfY/ShzfmwjhnOxImxKcEnmKcO5zyingeijKfVrgfvJH8nxrd0
         /BB7hVJJITjDwRR5lxmkmsupCz8kwbRu/ImSMcBsKQ1CN9yFoo1lAbpQbUxig3hL2FOh
         jgi3wqKd+PHWU49AC/0WUaViRCrPBqoBXNq0/Gg5bWhu/Gj+YYo1jUY63Bz8zezTGK4k
         DzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HqluNYrDBsoPinlng5BznRxmf0UReQXXe0CGI9T8DwI=;
        b=GzIqn22SWz6gzg49bwL95PmpigQodu6lAZTw9W6H8S1JHZfp7WKQA2VzPcihXjMthJ
         WFsBKdtqkkDc6fHk+vm5P8xZdhdGaaF9c80d6S60g0Mv3qirMQhppdpxVathTrJ25ivv
         kUvf24BQ+IZgMlryFsH/iT99livkZ68gG7W1r6cmGE+xA4BGHjpWlCmWJSgK2y3azyCf
         ieiWIcg+3VhetPQk0rD7wKtXJe3peFD/suE3X2Jr2PS5xw/akMPNhoODAkUC4t1yyluE
         ODy1U+ihzaAAL6iEE6iGzk9PlYdvdvdmO1F9f5KIPvnwYNKTLQYgBdsC11VfqX37aCVJ
         zDsA==
X-Gm-Message-State: APjAAAVxYBfL12xzde5uFAuo7rR30AMwibZt5drmbmw/dNWvmu25jSg2
        loF3JgUkj8smcpElVbFMJQA=
X-Google-Smtp-Source: APXvYqwNgTHlNqM6oP/R/pjal7jyNBtGB5WYTQe0b77R+/lG0nnTQFUCU6vHtovHVnkAO6kSk+E3cA==
X-Received: by 2002:a62:6046:: with SMTP id u67mr28071420pfb.118.1559527745396;
        Sun, 02 Jun 2019 19:09:05 -0700 (PDT)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id j64sm29473295pfb.126.2019.06.02.19.09.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 19:09:04 -0700 (PDT)
Date:   Sun, 2 Jun 2019 19:09:03 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     "Shenhar, Talel" <talel@amazon.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] thermal: mmio: remove some dead code
Message-ID: <20190603020901.GA7918@localhost.localdomain>
References: <20190515093420.GC3409@mwanda>
 <87257cd4-a7c8-3531-1033-84a6f79e6588@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87257cd4-a7c8-3531-1033-84a6f79e6588@amazon.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

hey Dan, Talel,

On Mon, May 20, 2019 at 05:26:51PM +0300, Shenhar, Talel wrote:
> 
> On 5/15/2019 12:34 PM, Dan Carpenter wrote:
> >The platform_get_resource() function doesn't return error pointers, it
> >returns NULL.  The way this is normally done, is that we pass the NULL
> >resource to devm_ioremap_resource() and then check for errors from that.
> >See the comment in front of devm_ioremap_resource() for more details.
> >
> >Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Acked-by: Talel Shenhar <talel@amazon.com>

Cool. I will be collecting this. The only change I will do while
applying this is that the subject will look like this:
"thermal: thermal_mmio: remove some dead code"

Just to match the file / driver name.


> >---
> >  drivers/thermal/thermal_mmio.c | 7 -------
> >  1 file changed, 7 deletions(-)
> >
> >diff --git a/drivers/thermal/thermal_mmio.c b/drivers/thermal/thermal_mmio.c
> >index de3cceea23bc..40524fa13533 100644
> >--- a/drivers/thermal/thermal_mmio.c
> >+++ b/drivers/thermal/thermal_mmio.c
> >@@ -53,13 +53,6 @@ static int thermal_mmio_probe(struct platform_device *pdev)
> >  		return -ENOMEM;
> >  	resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >-	if (IS_ERR(resource)) {
> >-		dev_err(&pdev->dev,
> >-			"fail to get platform memory resource (%ld)\n",
> >-			PTR_ERR(resource));
> >-		return PTR_ERR(resource);
> >-	}
> >-
> >  	sensor->mmio_base = devm_ioremap_resource(&pdev->dev, resource);
> >  	if (IS_ERR(sensor->mmio_base)) {
> >  		dev_err(&pdev->dev, "failed to ioremap memory (%ld)\n",
