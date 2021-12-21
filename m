Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291F447C6B4
	for <lists+linux-pm@lfdr.de>; Tue, 21 Dec 2021 19:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241404AbhLUSgy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Dec 2021 13:36:54 -0500
Received: from mail-qv1-f46.google.com ([209.85.219.46]:38777 "EHLO
        mail-qv1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237219AbhLUSgy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Dec 2021 13:36:54 -0500
Received: by mail-qv1-f46.google.com with SMTP id o10so85686qvc.5;
        Tue, 21 Dec 2021 10:36:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BwuHhEErlhOrEBWN0F2K7bnC+VuA2g6qjmBjpkSXVWE=;
        b=uBDVdyZr/bqS8muxgSU1i9WixFqhRP62JJVjFLx7AyHEclqIjHf6okOh1ItZeedwxZ
         qcBiK3Fr4bpa7WsQkX7Pg83fYYa8kwjaTsz9hsQZWj+he4ZK46dJRA3oczpgM2FQuKaI
         8NS0JWiPX3OnA+buSXsZymLehchi3jURC2Ec+7Eeo/5R3Xh0X9/vIXNnQl8t9who2+gI
         5ENt4gQir7IUBcHnCyChMZVhjZJEHP8zavEBnOiuiPIEzhLj4mQlcb72iuFU4FHqzVUX
         DJtpVYMRwpuB3h8T253TfiagTu9kywvI6Wyuu56Dq1oRqWCopEHbArgQ/6iKaHNqqLaK
         GN2g==
X-Gm-Message-State: AOAM531OY04oBb5qSCf40sbaKRGhP5ycphC0KTAFc0tmhB+urnOrx9wa
        J1ukhapFxFjzsdf1LiMJsuFRV/56O7A7
X-Google-Smtp-Source: ABdhPJyDRlLrlh+BUAnq5NK6Y3yT0CSN8lqZ3xisjbY1Tm19bHm9vdHjB9QyQe75qmTH8mZU67t++w==
X-Received: by 2002:a05:6214:2a88:: with SMTP id jr8mr3846082qvb.118.1640111813161;
        Tue, 21 Dec 2021 10:36:53 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id z8sm18474428qta.50.2021.12.21.10.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 10:36:52 -0800 (PST)
Received: (nullmailer pid 1542555 invoked by uid 1000);
        Tue, 21 Dec 2021 18:36:51 -0000
Date:   Tue, 21 Dec 2021 14:36:51 -0400
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: power: reset: gpio-restart: Convert to
 json-schema
Message-ID: <YcIew5b7kEMYZxEL@robh.at.kernel.org>
References: <20211217170042.2740058-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217170042.2740058-1-thierry.reding@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 17 Dec 2021 18:00:42 +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Convert the GPIO restart bindings from the free-form text format to
> json-schema.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../bindings/power/reset/gpio-restart.txt     | 54 ------------
>  .../bindings/power/reset/gpio-restart.yaml    | 86 +++++++++++++++++++
>  2 files changed, 86 insertions(+), 54 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/reset/gpio-restart.txt
>  create mode 100644 Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
> 

Applied, thanks!
