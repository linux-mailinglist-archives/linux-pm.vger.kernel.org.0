Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F219FF0981
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2019 23:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387514AbfKEW3s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Nov 2019 17:29:48 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36606 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387510AbfKEW3s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Nov 2019 17:29:48 -0500
Received: by mail-oi1-f196.google.com with SMTP id j7so19155100oib.3;
        Tue, 05 Nov 2019 14:29:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z7tp25VndUU2SQvLj+7Afh5KthhkxtDUjWXwp7kRqgE=;
        b=ZW+UQn74UW1fU94FmrQmhg9cbkcdPK/XjT8HI2z5vL+LxsD9rVVl5JG1owNJ27BHIW
         wHfwHrOQ8HXgV6Gjmcm/J78A7Z3u2WVQ/2ebNGTbImR/qzMT+ft0gCRaKGKJONWEzeMr
         xgeYiMA3IUJ1I3MeXthcq5SUHd3Nn6kYIrahBu/t8ir3eFNOxeeV6c0LWzs4Eyc8dp7W
         F3T975Of+iZ2sfEyDqkl7z3FuoUN5Fng4FUMpJdI33Aq6EwKsW4alhVGM0A6AsrWV8+I
         YE6Lcov94mykykHIS/+dOkh8Lb1H343rHolhnL9WSgaE2MWThKkKU5cgJOF8r8ZXAfYe
         FCkA==
X-Gm-Message-State: APjAAAWJWeN4G19MTJYcOxNcOzNYIcJYCqbaqtITamT2Zl4DvOqzTTlx
        1hSNqHFT9Mkkab9HrCa5hA==
X-Google-Smtp-Source: APXvYqyhK7AUSPwmqZbNmejWamAemZ+axvCS4LAN4H8GYf1OJoK/53IfPKiJNk401p7XudennKRngQ==
X-Received: by 2002:a05:6808:6d8:: with SMTP id m24mr1154604oih.73.1572992987349;
        Tue, 05 Nov 2019 14:29:47 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r14sm5862799oij.6.2019.11.05.14.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 14:29:46 -0800 (PST)
Date:   Tue, 5 Nov 2019 16:29:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com, orsonzhai@gmail.com
Subject: Re: [PATCH v2 4/5] dt-bindings: power: sc27xx: Add a new property to
 describe the real resistance of coulomb counter chip
Message-ID: <20191105222946.GA14320@bogus>
References: <cover.1572523415.git.baolin.wang@linaro.org>
 <b7c373b4329fe7a506890dd4c4c53e73cc64ff8d.1572523415.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7c373b4329fe7a506890dd4c4c53e73cc64ff8d.1572523415.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 31 Oct 2019 20:22:43 +0800, Baolin Wang wrote:
> Add a new property to describe the real resistance of coulomb counter chip,
> which is used to calibrate the accuracy of the coulomb counter chip.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  .../devicetree/bindings/power/supply/sc27xx-fg.txt |    3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
