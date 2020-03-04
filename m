Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 765F91792AE
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2020 15:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgCDOrH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Mar 2020 09:47:07 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33911 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgCDOrH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Mar 2020 09:47:07 -0500
Received: by mail-ot1-f68.google.com with SMTP id j16so2261830otl.1;
        Wed, 04 Mar 2020 06:47:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e1DUnUjPD4cs9mZrpkxpL4JIApSZcJjsqgIO7F3uZcw=;
        b=VGnvu0amDkLdginOih57RE9Q1zu4IJzdPS7ZpxNoI6QS2JTWFlfXxFn/w+REghRAPd
         og57DzVBEcccq5YbQWZ99Zuk198Aon/Fe5sin1uAaShKOM8BRD8JzkTn/75018UMexFz
         DlMupGfj80HxP2daCw3Cv9IUl49ccA1V2Nlj9KDfKGsNvbCSaU+XHbuQ8Uw5bIA75wyn
         gv7cnC5WGOM3GAeGY7iQl968vhkvb80WYX37uOQZ4/SXPjAUSqjJt3xBQc7uAs3FAL+X
         Ww0SNQwf1tKZUz8dav8Nyo3YvtNn3Woini9RuHOJBWr+qo3mWKQOD17Grfp0yvc61Dn9
         QDng==
X-Gm-Message-State: ANhLgQ10aC59CWVyK32BIWnijMnn/RIZxHfOOuzfQU4n7s7tRgxMmr1L
        C5TwYfxQWApVNDYzD1b3Cg==
X-Google-Smtp-Source: ADFU+vuv2Nvk4B7ivVbJLVEh0/GC20+gc6oP+nZrLgfo1+h+gcHdpJZ5L8QZydnr2GL6G7+II3O/RQ==
X-Received: by 2002:a05:6830:155a:: with SMTP id l26mr2644933otp.339.1583333226403;
        Wed, 04 Mar 2020 06:47:06 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f20sm184242ots.47.2020.03.04.06.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 06:47:05 -0800 (PST)
Received: (nullmailer pid 30371 invoked by uid 1000);
        Wed, 04 Mar 2020 14:47:04 -0000
Date:   Wed, 4 Mar 2020 08:47:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        devicetree@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: arm: Correct links to idle states
 definitions
Message-ID: <20200304144704.GA30104@bogus>
References: <20200303150749.30566-1-ulf.hansson@linaro.org>
 <20200303150749.30566-2-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303150749.30566-2-ulf.hansson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue,  3 Mar 2020 16:07:43 +0100, Ulf Hansson wrote:
> The arm,idle-state DT bindings recently got converted to the json-schema,
> but some links are still pointing to the old, non-existing, txt file. Let's
> update the links to fix this.
> 
> Fixes: baac82fe06db ("dt-bindings: arm: Convert arm,idle-state binding to DT schema")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml               | 2 +-
>  Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt | 2 +-
>  Documentation/devicetree/bindings/arm/psci.yaml               | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 

Applied, thanks.

Rob
