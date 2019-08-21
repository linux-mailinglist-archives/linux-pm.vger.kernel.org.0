Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2D2985A6
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 22:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfHUUd4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 16:33:56 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43907 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfHUUd4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2019 16:33:56 -0400
Received: by mail-ot1-f65.google.com with SMTP id e12so3319364otp.10;
        Wed, 21 Aug 2019 13:33:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qddeoYMCExSrGP0Z53XPfFm7HJjj7gnNcVMHSsnjg6k=;
        b=Ta3529WtkXF6AqLEpIBRXK+4g98Gf8f4aAHE9ZCK4H7KtGs+Q3cGmUsSwwEkioMQzW
         F3zuPr5gdVxuC1AhTtrTzVBBUGEMr4OryskNh6Bw0d4H0zizCz3etXqBW4HPE5/iF/az
         PRR0unBboEU4P/6Nu1iKw8aBwCULEaJm2zHBpGYq+8nM8VraLTbNsaxzoJcDcZi3Miyx
         042YNNpqaJqMffNwwUYt8zAzRG9IClj8iPeHShMUaqCLYppJW8TUh0rkaXDboHkDs9dv
         o02gAuXKDa7e1fFlua6vJVHr3K+jEJByP5P1S1PBnZ+fHQekFX0PI2AaBRzzmQNc83cI
         M2Bg==
X-Gm-Message-State: APjAAAUWADW3/PD1Wd6Lir8cglVKvA2oSodXTcKGzmQjjCxI/ysDEBXC
        zWTsDJDjXyF2Zd1xicLy+w==
X-Google-Smtp-Source: APXvYqxhu2sMRWnxO1/JyTvViI5ZgZxKPzyjavAq7Q7nYMVfG75BxtNwatC+amOPfMkRDOIRBTP9hg==
X-Received: by 2002:a9d:77c4:: with SMTP id w4mr28980235otl.40.1566419634795;
        Wed, 21 Aug 2019 13:33:54 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m26sm6204580oie.58.2019.08.21.13.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 13:33:54 -0700 (PDT)
Date:   Wed, 21 Aug 2019 15:33:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Saravana Kannan <saravanak@google.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        vincent.guittot@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>, sibis@codeaurora.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        kernel-team@android.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: opp: Introduce opp-peak-kBps and
  opp-avg-kBps bindings
Message-ID: <20190821203353.GA11783@bogus>
References: <20190807223111.230846-1-saravanak@google.com>
 <20190807223111.230846-2-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807223111.230846-2-saravanak@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed,  7 Aug 2019 15:31:09 -0700, Saravana Kannan wrote:
> Interconnects often quantify their performance points in terms of
> bandwidth. So, add opp-peak-kBps (required) and opp-avg-kBps (optional) to
> allow specifying Bandwidth OPP tables in DT.
> 
> opp-peak-kBps is a required property that replaces opp-hz for Bandwidth OPP
> tables.
> 
> opp-avg-kBps is an optional property that can be used in Bandwidth OPP
> tables.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  Documentation/devicetree/bindings/opp/opp.txt     | 15 ++++++++++++---
>  .../devicetree/bindings/property-units.txt        |  4 ++++
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
