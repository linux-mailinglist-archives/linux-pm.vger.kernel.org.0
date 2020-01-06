Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23A43131C1A
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 00:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgAFXKZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jan 2020 18:10:25 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:36807 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgAFXKZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jan 2020 18:10:25 -0500
Received: by mail-yw1-f65.google.com with SMTP id n184so22625687ywc.3
        for <linux-pm@vger.kernel.org>; Mon, 06 Jan 2020 15:10:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t+t1eROLK9g0HiqH07fHsSxCWd48TLqA6FF38j0G2gc=;
        b=D6nIejLhOsbXYF0eb77JKYRSykqg/RYdIZf/cnKbbXPY4QrSbMsVAmBzcT5tWfguaV
         S+s6WTL0PeV0tErMSqL7pgmivMC+xhJs0U42ZdAWV9XquRMyXDrQdmBvyDIHAizC5+MV
         4TWaZ4t0b0uk/0Rcnw+ZADqZTTQz/40T8PdWUR48oDtngQwHibub4VToSnBRmgjz/5Ky
         SKfe68m+3BmjtwSzx2/IiPZFxFAB053onKWxKGLK5gRqcYsf2z9Ffk8PZ3dEBuEje8c4
         5+MDSEDuK7edIKPXQbuBj7YvWNaXcUATcmbOeuoTJ5xXev6n+Bv2aoHjBR1kiE9TjHL/
         AaUA==
X-Gm-Message-State: APjAAAVWOwQwH9Uv+OMPEkD2WcvOs4ZqhcAn7NIOJ46gpJu23OkoZK6J
        IrivMnMEymCJqkkbAdVyQlfmOCKHug==
X-Google-Smtp-Source: APXvYqxFYTP8lKXpYQd2wZkgsR7601IXw4hdiobUwEXQ9sjcOUrB/lbdFWLIctP9bCxXDPyv2sfh0w==
X-Received: by 2002:a81:69c5:: with SMTP id e188mr77261190ywc.443.1578352223618;
        Mon, 06 Jan 2020 15:10:23 -0800 (PST)
Received: from rob-hp-laptop ([2607:fb90:1cd7:d95f:3549:d84c:9720:edb4])
        by smtp.gmail.com with ESMTPSA id d143sm28972041ywb.51.2020.01.06.15.10.20
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 15:10:22 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2209ae
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 06 Jan 2020 17:03:01 -0600
Date:   Mon, 6 Jan 2020 17:03:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rajeshwari <rkambl@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        sanm@codeaurora.org, sivaa@codeaurora.org, manaf@codeaurora.org,
        Rajeshwari <rkambl@codeaurora.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: thermal: tsens: Add configuration in
 yaml
Message-ID: <20200106230301.GA12602@bogus>
References: <1578317369-16045-1-git-send-email-rkambl@codeaurora.org>
 <1578317369-16045-3-git-send-email-rkambl@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578317369-16045-3-git-send-email-rkambl@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon,  6 Jan 2020 18:59:29 +0530, Rajeshwari wrote:
> Added configuration in dt-bindings for SC7180.
> 
> Signed-off-by: Rajeshwari <rkambl@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
