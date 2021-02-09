Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9FA2315756
	for <lists+linux-pm@lfdr.de>; Tue,  9 Feb 2021 21:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbhBIUA4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Feb 2021 15:00:56 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:33630 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbhBITwO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2021 14:52:14 -0500
Received: by mail-oi1-f178.google.com with SMTP id g84so6925749oib.0;
        Tue, 09 Feb 2021 11:51:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=djpia0FYNCw9tE3WP5Tr7Z3WXN4BAb7/Bz2WXM06cjM=;
        b=FNCy/ITnb/xo2eNmfXPI8mVnDc1D/YvTLG6dK7PVMBxbEfWeNRey7hXCGgnDFSncUE
         sNTK+XHhCQHZjqASP9+Hzd1DTHCbWAV1qr66Ts9udAEqP6tq3rXKujUQkf4CivwvbA01
         ZE8Vy5s6lZvWf3NNcH4vSuJkAhCdb7de52hhbKMmROkGsIQVvsiFzuxBI0BtNgzh6o1g
         3aY3hpJYyoFyk61tOhYWmtv21UFmfE96X2ZqF4PS8+FimpqHRHseV691I8bJYk9weWL3
         gA5EkOVOor589L4DNKIa9x/w+TdXRueOMDGQEnuX27oDn4XLssVnqea19VqxfF6Redct
         yCrQ==
X-Gm-Message-State: AOAM532GLVCobPKjPB+z2BHYpH+r2bNjgwHe7m6Yhx3qFJ7SnYbvBnsq
        ujQ1u0hZCU/edtrQKjavAE5VSV17RQ==
X-Google-Smtp-Source: ABdhPJxXHj8LriG5h7lJxb2HcSAF8ts/EcRL9+I3AD9cV1JfGEQuW4cd3YqKhp5vJufOIMZhs5T04Q==
X-Received: by 2002:aca:2102:: with SMTP id 2mr3615711oiz.80.1612898444606;
        Tue, 09 Feb 2021 11:20:44 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i13sm2821404oth.52.2021.02.09.11.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 11:20:43 -0800 (PST)
Received: (nullmailer pid 4189533 invoked by uid 1000);
        Tue, 09 Feb 2021 19:20:41 -0000
Date:   Tue, 9 Feb 2021 13:20:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] dt-bindings: power: sysc-remobile: Convert to
 json-schema
Message-ID: <20210209192041.GA4168680@robh.at.kernel.org>
References: <20210127132840.2019595-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127132840.2019595-1-geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 27, 2021 at 02:28:40PM +0100, Geert Uytterhoeven wrote:
> Convert the Renesas R-Mobile System Controller (SYSC) Device Tree
> binding documentation to json-schema.
> 
> Document missing properties.
> Drop consumer example, as it does not belong here.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Marked RFC, as it does not check deeper levels than the first level of
> the "pm-domains" subnode.
> 
> I think the reference in
> 
>     additionalProperties:
> 	$ref: "#/patternProperties"
> 
> should become "#/patternProperties/0/additionalProperties", but that
> gives:
> 
>     Unresolvable JSON pointer: 'patternProperties/0/additionalProperties'

AFAIK, numbers only work on lists (such as 'allOf' values). So I think 
you'd want '#/patternProperties/^pm-domains$/additionalProperties'. 
However, regex's can have illegal characters. I think URI escaping them 
would work, but that gets too readable and unmaintainable for my tastes. 
The other way to do this is put the schema under a '$defs'. But in your 
case, you have just a fixed string, so there's no need for it to be a 
pattern. Just move it to 'properties'.

Otherwise, looks good to me.

Rob
