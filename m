Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088F2455DB5
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 15:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbhKRORY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Nov 2021 09:17:24 -0500
Received: from mail-oo1-f42.google.com ([209.85.161.42]:42970 "EHLO
        mail-oo1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbhKRORY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Nov 2021 09:17:24 -0500
Received: by mail-oo1-f42.google.com with SMTP id x1-20020a4aea01000000b002c296d82604so2465677ood.9;
        Thu, 18 Nov 2021 06:14:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2/i4V3dtpF9xb337GEz6haUH1nPDQyWK9CkRADwvN/w=;
        b=Wo2tdUvkCdlTlzT+WCEJtD6FP+qBr1jADDXxdh/34dkSjmUfvE2tyipPe1SUrizhYi
         WZcCFl5jm1qU4iBlrYIAp1KGLWTsC+5CFxadlQNHRbtF0w3IXFOrub92euZ/Q1aYUCiy
         ieNbBIRyuvSyRnxACRCLUCILS7Zi43Zb5zcnmjNSy1X/gPsMn8NwnA6Infq0o5HYUuLX
         cbwJOqyu7phTHqX4z2/s5pFNnXKsyKsa1yljadz7m62XzOy7/vmDGn5XDEledKdtNKpz
         DL1QShr0c50hKFraYl5pf23s2vJAD3fxzecJDeM0+6ZvYglpYtFtvDs6aB3HjFn8BYdh
         YQQA==
X-Gm-Message-State: AOAM531DMlQgqlTrXjZpAkAFO+wPfZXky1UBPpNRPRRWC1r64Y95qJ6E
        JLmk2HrsMdeo3J1Kc+YopA==
X-Google-Smtp-Source: ABdhPJw5DIO10PUkulsiGGz8NUhs86NhGFWYHTAurERsDa36PCBYh8eFzT7BCiomj7x7s6JWqmBvZw==
X-Received: by 2002:a4a:5842:: with SMTP id f63mr13573966oob.97.1637244863639;
        Thu, 18 Nov 2021 06:14:23 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e3sm573529otk.71.2021.11.18.06.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 06:14:22 -0800 (PST)
Received: (nullmailer pid 1025107 invoked by uid 1000);
        Thu, 18 Nov 2021 14:14:21 -0000
Date:   Thu, 18 Nov 2021 08:14:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Saravana Kannan <saravanak@google.com>,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] of: property: fw_devlink: Fixup behaviour when
 'node_not_dev' is set
Message-ID: <YZZfvU2SQp5A09vF@robh.at.kernel.org>
References: <20210902090221.820254-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902090221.820254-1-ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 02 Sep 2021 11:02:21 +0200, Ulf Hansson wrote:
> In the struct supplier_bindings the member 'node_not_dev' is described as
> "The consumer node containing the property is never a device.", but that is
> inconsistent with the behaviour of the code in of_link_property(), as it
> calls of_get_compat_node() that starts parsing for a compatible property
> from the node it gets passed to it. The proper behaviour is to start at the
> node's parent, so let's do that.
> 
> While at it, let's take the opportunity to update the description of the
> 'node_not_dev' flag, as to clarify its purpose.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/of/property.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 

Applied, thanks!
