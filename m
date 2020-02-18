Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB676163507
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2020 22:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgBRVbk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Feb 2020 16:31:40 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45579 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgBRVbk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Feb 2020 16:31:40 -0500
Received: by mail-ot1-f68.google.com with SMTP id 59so21035700otp.12;
        Tue, 18 Feb 2020 13:31:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PyZM4tCjgTwD6aYfoDzIWv9a874H9XwwMkRT7i0BQWE=;
        b=Su8HnnYm/dGhT/uHPbO4tSkni8uB3PC2CYPVashO8bOXNspZFarxNI8fJUuor257It
         sYDmaWRFvAmHBwDztj2iT+cfJEyBqc1SCmRe8u1aR61kaKoNJpel2W4qk+bxYDd6nMaF
         BCUTOYgaSDYc1eGcFqFWZeELQ4r3Q1GIVDRtNNFKiwGOyWwElDDGtBQuu4tthugNd7QD
         Jr0ibf8JV40W43e/B/qK/IkfcBrbGI04949U7e5WYU+LkZn06uF+t07hlRU5t8bswzzr
         1npJV8yi8BaMCHwmR1TI5SqsRCuy6yvAMov95J1gt4qY4u3Omgt/CSjNKmHYg+0Ex2zx
         IBuQ==
X-Gm-Message-State: APjAAAVci1mFVVXQxG1Mxx9HERMh+7gLkaJpTqswA8WmHC/s3kofFOqD
        qDj6+xUq+euOb7LbiJ/0Iw==
X-Google-Smtp-Source: APXvYqzcQ5B6Jqv7ykwcXbxhubiIg4tzjWg968oQFRq7I7DKyRZ7OSbD5dZ/ERQzRBwPGUamWs1Xlw==
X-Received: by 2002:a9d:48d:: with SMTP id 13mr16210737otm.249.1582061498523;
        Tue, 18 Feb 2020 13:31:38 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t20sm29716oij.19.2020.02.18.13.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 13:31:37 -0800 (PST)
Received: (nullmailer pid 8809 invoked by uid 1000);
        Tue, 18 Feb 2020 21:31:37 -0000
Date:   Tue, 18 Feb 2020 15:31:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     robh+dt@kernel.org, georgi.djakov@linaro.org, evgreen@chromium.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mark.rutland@arm.com,
        daidavid1@codeaurora.org, saravanak@google.com, mka@chromium.org,
        linux-pm@vger.kernel.org, Odelu Kukatla <okukatla@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH v3 3/6] dt-bindings: interconnect: Update Qualcomm SDM845
 DT bindings
Message-ID: <20200218213137.GA8767@bogus>
References: <20200209183411.17195-1-sibis@codeaurora.org>
 <20200209183411.17195-4-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200209183411.17195-4-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 10 Feb 2020 00:04:08 +0530, Sibi Sankar wrote:
> From: David Dai <daidavid1@codeaurora.org>
> 
> Redefine the Network-on-Chip devices to more accurately describe
> the interconnect topology on Qualcomm's SDM845 platform. Each
> interconnect device can communicate with different instances of the
> RPMh hardware which are described as RSCs(Resource State Coordinators).
> 
> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  .../bindings/interconnect/qcom,sdm845.yaml    | 49 +++++++++++++++----
>  1 file changed, 40 insertions(+), 9 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
