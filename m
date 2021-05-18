Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759FA386EE4
	for <lists+linux-pm@lfdr.de>; Tue, 18 May 2021 03:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345584AbhERBLp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 May 2021 21:11:45 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:43930 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345592AbhERBL0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 May 2021 21:11:26 -0400
Received: by mail-oi1-f170.google.com with SMTP id j75so8205574oih.10;
        Mon, 17 May 2021 18:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7VRx1KOGTd/mlN9tivtVrwdAcsGI2VRzEg2JPb/ZPK4=;
        b=mU3Dq29JGDKOMCkjlmPmkp5wm7QI329MKXp+DDQhFNXHMRqI1ys4+xRsAm+cX8EMjb
         Qynu5rR4xDR6lBfyZDrlOwERPjL2Ou7hG+atW2LpcgO2oGzuIawv1z69Kp4yC959uoi4
         ZvMDfAjV4eNIK4+vOBH6X8LBMJS1NB/OPDUfM2tlnjcyHgEhxjCxtYWIY4hMjb1mMZwg
         qZ+TCnoB7kIlIh+Z5Yh3BkYH/FGzviJGWrkgbqYHQs7X8G+jNC2Ws4qnQPPCkGjjWdDR
         JxofuQjVunr82spCHemvHb2xEtJGl7XwVAlSEn1iV7jiQxNOVBB6RoQGFtyC2DcPEFLo
         86bQ==
X-Gm-Message-State: AOAM531wGvdgUBe029vdpwJHgqj8yVipTno6Kj8u6tcXbgfYmZMGM3rI
        iaHR1PwUooM++Eez8DUd4g==
X-Google-Smtp-Source: ABdhPJxJwaQqKnuSbG53ylbD2hOPzHyziLLftz7JZWGc73yw7BNscf0h/pFLTwqkn/9oQux8MjpoLw==
X-Received: by 2002:aca:da8b:: with SMTP id r133mr1949783oig.36.1621300208883;
        Mon, 17 May 2021 18:10:08 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z4sm1046825oib.40.2021.05.17.18.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 18:10:08 -0700 (PDT)
Received: (nullmailer pid 3571898 invoked by uid 1000);
        Tue, 18 May 2021 01:10:07 -0000
Date:   Mon, 17 May 2021 20:10:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bartosz Dudziak <bartosz.dudziak@snejp.pl>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-msm@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] dt-bindings: arm: msm: Add SAW2 for APQ8026 and
 MSM8226
Message-ID: <20210518011007.GA3571838@robh.at.kernel.org>
References: <20210513150150.51464-1-bartosz.dudziak@snejp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513150150.51464-1-bartosz.dudziak@snejp.pl>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 13 May 2021 17:01:49 +0200, Bartosz Dudziak wrote:
> Add the dt-binding compatible in the SPM AVS Wrapper 2 (SAW2) for the
> APQ8026 and MSM8226 SoC platforms.
> 
> Signed-off-by: Bartosz Dudziak <bartosz.dudziak@snejp.pl>
> ---
>  Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
