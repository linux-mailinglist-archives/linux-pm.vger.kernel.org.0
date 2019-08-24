Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E47E9BC04
	for <lists+linux-pm@lfdr.de>; Sat, 24 Aug 2019 07:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbfHXF6M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 24 Aug 2019 01:58:12 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:38275 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfHXF6M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Aug 2019 01:58:12 -0400
Received: by mail-pl1-f172.google.com with SMTP id w11so6405102plp.5
        for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2019 22:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9XRmX24je7yglBYNnKykqbyW6HW63V9ReMAxFYEEt1s=;
        b=qkF+5Fb1zSoQCB4yA3iJFPvYFkOn+QAGCxX1cDIS47hpoTsNIylKqNs6zKfF0r0iqS
         Szq6IQtSIS5Pe7Pd3S4OqOJoFEZhEFEN/YB0sFk+f+WEdOm45fWTREN1MXMGJKRlGnn+
         gdI7fqv9JswyhDpABaQX7fvDvDRFG7MPBjihoPEMuudwGT4dl4oJjfY/6s7znvE38oZM
         nP2P9ROqQ8FhO9cW1Qv1YHcYOaaGUJ+8+vqRlm/aBa6nSFZNmn6zxXWgWzmcXiuBnKd9
         AVWfItHhsDHiaD0Gc5YIMG1REV74ppZf7c4SiiUcC/BIlrGSzz60S7TpSSI+ATYwwXH1
         YAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9XRmX24je7yglBYNnKykqbyW6HW63V9ReMAxFYEEt1s=;
        b=Z7LwLJZn8CuXtzw9+M7PpqO3LUL4KHH1Yo65jYG/tNI2M6stlVzQM+pcL/pwIxNuuR
         j5dcmjdkbyHBjTDA8ZKtZGogvFfBo/pJlwLnUO/N3yNMFtUbmZ3750Dxad38681Smqwd
         AWuNYYdbA9zjboP4mYyxwBbF9aHVZL+iXhf3KInu+1qdlXUWoAHj22WFse5OoEeMPA/8
         r3Jrr7Szv9raJ1pMV/nb4ah1tumZWh8h3g4fLcP9UY/X77p4qQgcGbwnuU7kwR+NeBqL
         l0Tf6VV853axCuY7ErjjpbnkjMsXLsIIXpWHpqe8Dnk8uWZo9niwjy+adTyyuCbiFbDk
         ZxJg==
X-Gm-Message-State: APjAAAUm5r//KhGzSI7yBiiaPO2BLDmzrqAsAuqzGaw9l0yf76pCdc34
        95gDaMUkuJYtESz0eUPagP724g==
X-Google-Smtp-Source: APXvYqx/S116wBZhFEBYMvZPw0PX30vsJXa9tlWx1ji4IPTccDJ/vnV/LOzMfXLdMIT08JMykBbf9A==
X-Received: by 2002:a17:902:302:: with SMTP id 2mr8654563pld.149.1566626291651;
        Fri, 23 Aug 2019 22:58:11 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d18sm3580521pgi.40.2019.08.23.22.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 22:58:10 -0700 (PDT)
Date:   Fri, 23 Aug 2019 23:00:02 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        qualcomm-lt@lists.linaro.org, linux-pm@vger.kernel.org,
        ulf.hansson@linaro.org, rnayak@codeaurora.org
Subject: Re: [PATCH 0/4] qcom: Model RPMH power domains as thermal cooling
 devices
Message-ID: <20190824060002.GS26807@tuxbook-pro>
References: <1565398727-23090-1-git-send-email-thara.gopinath@linaro.org>
 <efe98b11-9b79-4ecb-5e28-2a62235cf56c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efe98b11-9b79-4ecb-5e28-2a62235cf56c@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed 14 Aug 03:52 PDT 2019, Daniel Lezcano wrote:

> 
> Hi Thara,
> 
> interesting series. Can you describe what use case this series will solve?
> 

The purpose is to ensure a minimum voltage (voltage corner) on the
memory rail (mx) at low temperature, to meet some physical requirement.

> On 10/08/2019 02:58, Thara Gopinath wrote:
> > Certain RPMH power domains can be used to warm up the SoC (mx on sdm845)
> > if the temperature falls below certain threshold. 
> 
> What is the relationship between the temperature fall, the sensor(s)
> location and the warming device(s) in this case?
> 

Presumably any on-die sensor could be used and the minimum voltage
requirement only applies below some configurable threshold.

> 
> > These power domains
> > can be considered as thermal warming devices
> > (opposite of thermal cooling devices).
> 
> Is it possible to elaborate how works the RPMH as a warming device and
> what is the "mx on sdm845"?
> 

RPMh is the interface used to configure the voltage corner (and other
shared resources, such as regulators, interconnects etc). mx is the
"memory rail" power domain.

Regards,
Bjorn
