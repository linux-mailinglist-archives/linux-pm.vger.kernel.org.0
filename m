Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70567221647
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 22:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgGOUcI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 16:32:08 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33233 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgGOUcH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 16:32:07 -0400
Received: by mail-io1-f68.google.com with SMTP id d18so3709557ion.0;
        Wed, 15 Jul 2020 13:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xgpaPe39mEo1k9W7lGAlknVj+R0r4vQdiUF0SkOMUw8=;
        b=bqOYjFOM0b+cvBl+/JZNVYQR0qOD5OcVVL/B+gidid2UXi7I8utqqRE6kMK8PZizEP
         Tpo9YzG6zWSUVthYipMAyefWDXPqiuBiZSj9/mkyUaeKlnnO1D+XPi11YNj6QBLYnwU/
         YkgdTRkIDyxlmKxzzOxyCDdqNdlAkaj3C6QtdTwOyxprhKY1f8uPz7CzG7UjGIw7mT/H
         HFjHHSNxCGF4MRFI3x/+bV1bi54NTFvDVDNI9ybkE1AbHTsK21pBll2nlMpIsjU6glXz
         NN1tdOsZUrUoeee2m7NYDbYjqE3orlNPgVy6w7N+WBWsgzNuGLVzx+ABZbdWolLJHf7c
         Pp9w==
X-Gm-Message-State: AOAM531oLRKNXQMUzVdPqVBGkOM9jPZgF+aAyWSjoidOUf1mcM+1/R43
        TNbzst7fOUX2E0B6PYdxR1U2pRUlqw==
X-Google-Smtp-Source: ABdhPJznWQ9ULp+AZKrH/U6yUY+gFlaVC14n5TBcxj+4CLE+vxs6itLKSVREKbLdn7XNPC7/zvYV/g==
X-Received: by 2002:a05:6602:148f:: with SMTP id a15mr1165503iow.26.1594845126473;
        Wed, 15 Jul 2020 13:32:06 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id v13sm1641502iox.12.2020.07.15.13.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 13:32:05 -0700 (PDT)
Received: (nullmailer pid 769501 invoked by uid 1000);
        Wed, 15 Jul 2020 20:32:04 -0000
Date:   Wed, 15 Jul 2020 14:32:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update Amit Kucheria's email to a single
 email address
Message-ID: <20200715203204.GA769304@bogus>
References: <8cbb7004a6a9b846a8d827f514f33f1a265dd5d4.1593498024.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cbb7004a6a9b846a8d827f514f33f1a265dd5d4.1593498024.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 30 Jun 2020 11:52:32 +0530, Amit Kucheria wrote:
> Emails currently go to different mailboxes. Switch to the kernel.org
> address so I can forward them to a single mailbox.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 2 +-
>  MAINTAINERS                                               | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 

Applied, thanks!
