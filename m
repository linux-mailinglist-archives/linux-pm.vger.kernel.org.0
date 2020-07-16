Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C88D222BD0
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 21:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbgGPTWb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jul 2020 15:22:31 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33511 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbgGPTWb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jul 2020 15:22:31 -0400
Received: by mail-io1-f68.google.com with SMTP id d18so7256959ion.0;
        Thu, 16 Jul 2020 12:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cqz5mY+nuj0F7UbkiJ7lZ+wxAgeIQfIj+O61Hsq2EXI=;
        b=eISVR0nesAiOjPSRGmvmsPYs9PIEYO7/bP6UuaOcUzvNJj1Sul9ibXibFRG1NcYOsK
         HMsnwCfHiFas/pTZaSk5jr0zD3OXTwzdQ+J5zKAAj6PKFfDLRae1LlPM25Sfm3t+OL+h
         v4RFPm2PrcISeMDso0z/PtLt2Ni+FjgBjGbIXbhMmVraHH2awQ8BEh77ncqVp3RRwDON
         KvWWH+SdINkZT03kHfmRchmHSoIPvG3r1Q32EGgs6M7ky8mKvW5DxAOw+xV2HNvuzis7
         vQRlTKBXabYBGuPSzdFdAaGp1XffuyOUNyILpOAcB1Hp7XhWTZpvcwp5kU4A+Z0DUQon
         URbQ==
X-Gm-Message-State: AOAM530ntTbgZYsjf6Ox1gBsQJxLAr6MvxIdQji0mznNOUM5dX0FBqAI
        krTRo6GiBixaj5igTa0n5w==
X-Google-Smtp-Source: ABdhPJzdzz9GqOzCp0S73abYRGHy0O/xklH2y/q2Q4ZJIKOklp2/IUF/5/MnEh4+RKnRy3rptViJxQ==
X-Received: by 2002:a02:c604:: with SMTP id i4mr6684334jan.19.1594927350008;
        Thu, 16 Jul 2020 12:22:30 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id l18sm3129341ill.56.2020.07.16.12.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 12:22:29 -0700 (PDT)
Received: (nullmailer pid 2697481 invoked by uid 1000);
        Thu, 16 Jul 2020 19:22:28 -0000
Date:   Thu, 16 Jul 2020 13:22:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH v2 3/7] dt-bindings: interconnect: Add Qualcomm SM8250 DT
 bindings
Message-ID: <20200716192228.GA2697434@bogus>
References: <20200713154121.22094-1-jonathan@marek.ca>
 <20200713154121.22094-4-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713154121.22094-4-jonathan@marek.ca>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 13 Jul 2020 11:41:12 -0400, Jonathan Marek wrote:
> The Qualcomm SM8250 platform has several bus fabrics that could be
> controlled and tuned dynamically according to the bandwidth demand.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  .../bindings/interconnect/qcom,rpmh.yaml      |  11 ++
>  .../dt-bindings/interconnect/qcom,sm8250.h    | 173 ++++++++++++++++++
>  2 files changed, 184 insertions(+)
>  create mode 100644 include/dt-bindings/interconnect/qcom,sm8250.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
