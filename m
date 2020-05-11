Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCAEA1CE7BD
	for <lists+linux-pm@lfdr.de>; Mon, 11 May 2020 23:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgEKVv0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 May 2020 17:51:26 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43682 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgEKVvZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2020 17:51:25 -0400
Received: by mail-oi1-f196.google.com with SMTP id j16so16461043oih.10;
        Mon, 11 May 2020 14:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DfyKKTmDjv9m+OiuNuIy9KTZuQJffzzNH09317cH/0o=;
        b=FNnTV69nvjC6QlxzJgaEnIj8pEGHR2K8UqsliyTW63qrstL5AKVCP3znU8C0T6o20i
         Aj69fcL0NEEk1e0MHxwPTyEK7A7FS+W8HRA57AqDh25NzwMJFAXeLy+O1lv5ZdYhse5A
         nmdP+GRvEhzh6QsjL1lgAZA46tz2IOlrUNaRB0Msh71dsqIthso1r1hBtUvFEwTHlBDA
         kSuOYmwSnb2cRxjR+08YiPfAuXMIN9LCooXZwj/UBN27XP1oYU3/ROlHd0S1i5Ea17YX
         a5wPSUz5889kmqnqo4hVtSkASh/99xb1bmJFK5KUvcGKrdFSa73OptCJlknXycL2KUlS
         imUw==
X-Gm-Message-State: AGi0PuYNSHseogJyDSE+8rzc8aaSSTCgzFgNt+ePuuJDnAZm//cYdRU+
        NTs2VKmcUOBo6Jn5UvgVYw==
X-Google-Smtp-Source: APiQypIGO0kmzMcw63VT/1hO5t2+X0q9f/ugFKCDUdcjKV1R0yK1FpsrF1KOJWEqlHyg4ULtacbphw==
X-Received: by 2002:aca:dcd4:: with SMTP id t203mr19764116oig.72.1589233884866;
        Mon, 11 May 2020 14:51:24 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m19sm2498144otj.81.2020.05.11.14.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 14:51:23 -0700 (PDT)
Received: (nullmailer pid 10023 invoked by uid 1000);
        Mon, 11 May 2020 21:51:22 -0000
Date:   Mon, 11 May 2020 16:51:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, nm@ti.com, saravanak@google.com,
        rjw@rjwysocki.net, bjorn.andersson@linaro.org,
        evgreen@chromium.org, vincent.guittot@linaro.org,
        vireshk@kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org, sboyd@kernel.org, sibis@codeaurora.org,
        robh+dt@kernel.org, jcrouse@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/7] dt-bindings: opp: Introduce opp-peak-kBps and
 opp-avg-kBps bindings
Message-ID: <20200511215122.GA9964@bogus>
References: <20200424155404.10746-1-georgi.djakov@linaro.org>
 <20200424155404.10746-2-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424155404.10746-2-georgi.djakov@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 24 Apr 2020 18:53:58 +0300, Georgi Djakov wrote:
> From: Saravana Kannan <saravanak@google.com>
> 
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
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
> v7:
> * I have dropped Rob's Reviewed-by, because of the minor change below:
> * In order to store the bandwidth values for multiple paths, the
> opp-peak-kBps and opp-avg-kBps are now defined as arrays of integers,
> instead of just integers.
> * Improved wording (Viresh)
> 
> v6: https://lore.kernel.org/r/20191207002424.201796-2-saravanak@google.com
> 
>  Documentation/devicetree/bindings/opp/opp.txt | 20 ++++++++++++++++---
>  .../devicetree/bindings/property-units.txt    |  4 ++++
>  2 files changed, 21 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
