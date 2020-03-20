Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46A9A18DB63
	for <lists+linux-pm@lfdr.de>; Fri, 20 Mar 2020 23:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgCTW4g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Mar 2020 18:56:36 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42346 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbgCTW4f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2020 18:56:35 -0400
Received: by mail-io1-f65.google.com with SMTP id q128so7696820iof.9;
        Fri, 20 Mar 2020 15:56:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lwcjdkfu56Ps5KeJNV/bbYNr993lvtt9wQjpi7hvu/o=;
        b=MbL6rTcfJYFgXWUUwSGXKvYZGJ+gde7PlIRt5STeXNJtcLe8DCD2ZaHkMWF53fSqOo
         +Mx1x9QS1CllYG9yNoPMKlgHgzpxqC0480b6PUiZ23hcR0rERgZq2G9nIiZU4p5Q1QSY
         OnmpCgTptQeamMWgCti8a9za3/7KzhmrA1s0nuzvFAXH05llb9+A31D5LKTOj8fN875a
         uwglv5QrCn0wqJRQJBPegYikvrgvGI7K6JiLQUPHMQ3BGwW++t4PfAWdH1BRZ4uyFDDy
         OrbTm/aNjPwwfcrBnOMmTpvZrylCCDp4YUrShZuLUxMwAm3Mx/uLxFqvv+mFmMjsKrcJ
         T9jQ==
X-Gm-Message-State: ANhLgQ3pp50ZiOAD9Uwf3jfH9aCwpssupBe7E3iUrR1EOcpoahZy5ogP
        sqznea2BTH7xJNnqXPVmtlB3WTA=
X-Google-Smtp-Source: ADFU+vst4fYbKhEbWEQ6y4E2xPnfEbBGpi6R4S8PRy3f65rUNbMunmOd7RJQhP/rbMVxptFzDw6Hng==
X-Received: by 2002:a02:b897:: with SMTP id p23mr10655513jam.120.1584744994695;
        Fri, 20 Mar 2020 15:56:34 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id u188sm2433372ilc.59.2020.03.20.15.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 15:56:33 -0700 (PDT)
Received: (nullmailer pid 24999 invoked by uid 1000);
        Fri, 20 Mar 2020 22:56:32 -0000
Date:   Fri, 20 Mar 2020 16:56:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org, robh@kernel.org, amit.kucheria@verdurent.com,
        mark.rutland@arm.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v5 5/6] dt-bindings: power: Extend RPMh power controller
 binding to describe thermal warming device
Message-ID: <20200320225632.GA24944@bogus>
References: <20200320014107.26087-1-thara.gopinath@linaro.org>
 <20200320014107.26087-6-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320014107.26087-6-thara.gopinath@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 19 Mar 2020 21:41:06 -0400, Thara Gopinath wrote:
> RPMh power controller hosts mx domain that can be used as thermal warming
> device. Add #cooling-cells property to the power domain provider node to
> indicate this.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
> 
> v3->v4:
> 	- Removed subnode to indicate that mx power domain is a warming
> 	  device. Instead #cooling-cells is used as a power domain
> 	  provider property to indicate if the provider hosts a power
> 	  domain that can be used as a warming device.
> 
> v4->v5:
> 	Moved the property from .txt format to .yaml format.
> 
>  Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
