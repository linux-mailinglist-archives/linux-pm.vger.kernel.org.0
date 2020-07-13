Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F71221E06B
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 21:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgGMTEs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 15:04:48 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33299 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgGMTEs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 15:04:48 -0400
Received: by mail-io1-f67.google.com with SMTP id d18so14711768ion.0;
        Mon, 13 Jul 2020 12:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9Y5DNiwAmGhm3HKzfpsHejLrXSZAto6ZRm11P2NdgXA=;
        b=sTcnz3v+zPwlxWhmeMydjHN73LWV0xRpNdlaj0PmBt6ulMy9V3QdnGnz46UnRtZNOL
         PFq4GVP1ikJy+3MgkgHe9dGZsNO/wUNsVuB6HDmQhVwPgbu/y88c0q7f//uxxqIi26wX
         vbQfLXNKcoyDFcbzCNTSdwGwDPriq8oFLOMsERrYCF9RVvakD1WOuwTeyw1+/QL4cgT3
         9w2yHO9YQSeU8VE8PGMA7A21dKQqELq6OvuPezmlMyaq00TtJBIXX6wrGT2hK3fNOVMm
         AX7yVnlIFdR1wNGSE67j0DI5UcFAWl+b8ELovdUQVzjPGpZSD9XHXzl52itw/Jnn+QmP
         anlg==
X-Gm-Message-State: AOAM530T1CtUUg2ai31mxetSh6Z97y3urGQismLkV/GcDot3I0B8NfXk
        zYdyCivpfl7qDZ5rqAw3zg==
X-Google-Smtp-Source: ABdhPJzCZ2ShnGuQdGALu+LVtZuGO9ZYNT0pBJbHbB9eI23ej5zGDsQEo3GuSkzG87PksqB5cCwIQA==
X-Received: by 2002:a6b:ce01:: with SMTP id p1mr1199862iob.19.1594667087573;
        Mon, 13 Jul 2020 12:04:47 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id y8sm8720000ilq.21.2020.07.13.12.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 12:04:47 -0700 (PDT)
Received: (nullmailer pid 549846 invoked by uid 1000);
        Mon, 13 Jul 2020 19:04:46 -0000
Date:   Mon, 13 Jul 2020 13:04:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Iskren Chernev <iskren.chernev@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        devicetree@vger.kernel.org, Jonathan Bakker <xc-racer2@live.ca>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 4/6] dt-bindings: power: supply: max17040: Add
 maxim,rcomp
Message-ID: <20200713190446.GA549816@bogus>
References: <20200624155633.3557401-1-iskren.chernev@gmail.com>
 <20200624155633.3557401-5-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624155633.3557401-5-iskren.chernev@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 24 Jun 2020 18:56:31 +0300, Iskren Chernev wrote:
> To compensate for the battery chemistry and operating conditions the
> chips support a compensation value. Specify one or two byte compensation
> via the maxim,rcomp byte array.
> 
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
> ---
>  .../devicetree/bindings/power/supply/max17040_battery.txt   | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
