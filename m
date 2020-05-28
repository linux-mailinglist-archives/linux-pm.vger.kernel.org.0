Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1FBD1E6C79
	for <lists+linux-pm@lfdr.de>; Thu, 28 May 2020 22:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407066AbgE1U0i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 May 2020 16:26:38 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43642 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407016AbgE1U0g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2020 16:26:36 -0400
Received: by mail-io1-f68.google.com with SMTP id h10so31620392iob.10;
        Thu, 28 May 2020 13:26:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CnTYR1lY8ZOkI8xNqLhIayUWxms1+ukkgQb4iVjhgzQ=;
        b=Cj6cP7tMNZgc7qIHonT0L6+bzGvpxCuHCe3svmySACJ0/T3V00cxqrr87BoLQCXEOP
         gIRrAsJhJmn9UUIuyyMVaVia9iQDcBa7SSotxgSD9TC6HXYyf/X9OgPoEiyBrdxhFHXb
         MsgGoxreI938X4i3Wp35zobcwee/HXi9WjoDMOf9FwCEONIm3eUtugP8nh05g+yQNqjc
         HRS8miuj5drFvVxLYGmpKEP4aSNggMvNLig+aDmN5x2FuCf/b8qaquIGxI10jp2OgXlK
         kAJ6/BSyISx44Voy3aUK3wY/TmYlN+ceb4yN8DY3mM9gEK90W72hYmS1GKTS/QoGif6y
         0kPw==
X-Gm-Message-State: AOAM530hfO7hcnOP81QuWO3INMNqpy4GSk5IoDxUdT2yspZtj4fusDX7
        z7fPaiJP0zbQygYNUUmeUW0QCMQ=
X-Google-Smtp-Source: ABdhPJy8hPLVFbURKpzt4JkKcaVfPLpOG6kL1j2S6lIetgpuuXVfA0JTlrPJA9FkG7UPnq7IBYsoNw==
X-Received: by 2002:a6b:7017:: with SMTP id l23mr3953486ioc.140.1590697595804;
        Thu, 28 May 2020 13:26:35 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id r10sm1796858ile.36.2020.05.28.13.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 13:26:35 -0700 (PDT)
Received: (nullmailer pid 620829 invoked by uid 1000);
        Thu, 28 May 2020 20:26:34 -0000
Date:   Thu, 28 May 2020 14:26:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
Cc:     linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: thermal: tsens: Add zeroc interrupt
 support in yaml
Message-ID: <20200528202634.GA620781@bogus>
References: <20200517104627.29501-1-manafm@codeaurora.org>
 <20200517104627.29501-3-manafm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200517104627.29501-3-manafm@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 17 May 2020 16:16:27 +0530, Manaf Meethalavalappu Pallikunhi wrote:
> Add zeroc interrupt support for tsens in yaml.
> 
> Signed-off-by: Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
> ---
>  .../bindings/thermal/qcom-tsens.yaml          | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
