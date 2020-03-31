Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A30AF19A19A
	for <lists+linux-pm@lfdr.de>; Wed,  1 Apr 2020 00:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731400AbgCaWFk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Mar 2020 18:05:40 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36485 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731304AbgCaWFj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Mar 2020 18:05:39 -0400
Received: by mail-io1-f65.google.com with SMTP id n10so9416918iom.3;
        Tue, 31 Mar 2020 15:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rOIfNa9jSDYoTkdrnG0D+oJgScAuNFcwTbvGHk2M+5Q=;
        b=t/2TZv8H5UWAI1IidOAixyP3tg1b72+CsVQ1lJ83steObxqv3igw5QzOvFrpwVHu2t
         Z4yaHdygEHQ9pc++xuR7jmuP5gmw0ystrRqdabWCCaAkJZsU2R4YhCtWAH3uLYnTzLA0
         u/X0VLXf6ahy2xSvYx7B7ZwQzRUlzAm7+AUPFJcYiksoSkg5vbIrPMrpaSoC2qlZpaCw
         jw/AtY+uwoz0jqNQNNCQ5kP3kEGKLjg2xnLyAXWYOEPGmxu5EBl7QzwTnCjeJ8WAAuOK
         Ew1fAyIOAWfF6JznMcvhVMz9KnvEKTBuOqxCNsZlZtpJ9nTjYKvzEYPlhpbCaGJlOrJj
         abUA==
X-Gm-Message-State: ANhLgQ2L4rgDALITBa0AGymbLk0a5tB5/exxUUl9lEwuEHk8yQ3VEuQX
        DtXI2J18e1+ahLmIXjTgRQ==
X-Google-Smtp-Source: ADFU+vsYaihj3BeOAMA2dZQ0vbo9icSYSvG7WTj4zQz/949WwYlUKMhl4yzmFbTx86K+/WBDGD7Ctg==
X-Received: by 2002:a02:634e:: with SMTP id j75mr17812133jac.23.1585692338870;
        Tue, 31 Mar 2020 15:05:38 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z13sm45525ioh.16.2020.03.31.15.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 15:05:38 -0700 (PDT)
Received: (nullmailer pid 29406 invoked by uid 1000);
        Tue, 31 Mar 2020 22:05:36 -0000
Date:   Tue, 31 Mar 2020 16:05:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     devicetree@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: power: Fix example for power-domain
Message-ID: <20200331220536.GA29336@bogus>
References: <20200326105626.6369-1-ulf.hansson@linaro.org>
 <20200326105626.6369-3-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326105626.6369-3-ulf.hansson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 26 Mar 2020 11:56:26 +0100, Ulf Hansson wrote:
> The change that converted the domain-idle-states DT bindings to the
> json-schema, forgot to update the corresponding example for the
> power-domain binding. Let's fix it.
> 
> Fixes: 3261227d136d ("dt-bindings: power: Convert domain-idle-states bindings to json-schema")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  .../bindings/power/power-domain.yaml          | 28 +++++++++----------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 

Applied, thanks.

Rob
