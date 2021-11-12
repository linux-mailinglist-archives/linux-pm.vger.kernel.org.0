Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F318944ED50
	for <lists+linux-pm@lfdr.de>; Fri, 12 Nov 2021 20:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbhKLThC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Nov 2021 14:37:02 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:33600 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbhKLThB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Nov 2021 14:37:01 -0500
Received: by mail-oi1-f173.google.com with SMTP id q25so14217222oiw.0;
        Fri, 12 Nov 2021 11:34:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6Wy6C8P80iIYfCtHt3mNEASrUsBSkcrXUkyTq/TPB+k=;
        b=fiX6TZbZHpwQrw6miclYPp4GHO5nDzTu+UVRbtb7ArkmA91cSwiUmQ9zRf+IipOw3g
         JEX8O/TbcAz00rj0XcZlt4gP6wjdWG9zS9Puhwn4tKwOl3sxyS6IbTZwuYM9hupO0oyJ
         VFVYnxcO1GIIEQA2ubd4PRgS4IQ9RXMk/wpaxkGr1CfP8tHKGPjIKioSllN3bx0swxhl
         1fJUKNKkusdQgPpN+X1IUGIxaEssLnQkC32tHKS4eXUj8caDZBZ2OsNY3XSQ+HFhSKpV
         pNAyZXtLVsgX7r98zIztGP/x8HBkYFOc/xu1N6W/NNuYRNOk0JMLkpX/le6nuqUmdfcm
         NfIA==
X-Gm-Message-State: AOAM531gg0AjZNctdNxG4Zko0rHvvDOCOtwpCCqpkArMJhEFFPm1c4wk
        33DEt0+apCPQ4/gK8RBLFw==
X-Google-Smtp-Source: ABdhPJwQ9RZXzvhOppRZxXpAPyxvG2EbmdYCGOlr5ko+agpX7xIC2ZiqVQ7OgYHm9cNtXjrjxcFmRA==
X-Received: by 2002:aca:58d6:: with SMTP id m205mr29101315oib.126.1636745650639;
        Fri, 12 Nov 2021 11:34:10 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id y12sm1748669oiv.49.2021.11.12.11.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 11:34:10 -0800 (PST)
Received: (nullmailer pid 3232662 invoked by uid 1000);
        Fri, 12 Nov 2021 19:34:09 -0000
Date:   Fri, 12 Nov 2021 13:34:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Sebastian Reichel <sre@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-pm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 2/3] dt-bindings: power: reset: syscon-reboot: add
 "reg" property
Message-ID: <YY7Bsbq9BViCqkjq@robh.at.kernel.org>
References: <20211102152207.11891-1-zajec5@gmail.com>
 <20211102152207.11891-3-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211102152207.11891-3-zajec5@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 02 Nov 2021 16:22:06 +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Reboot node should be a child of mfd/syscon node and should use "reg"
> property to specify regmap offset.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  .../bindings/power/reset/syscon-reboot.yaml        | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
