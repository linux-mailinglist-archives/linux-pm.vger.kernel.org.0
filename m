Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC7C44ED4E
	for <lists+linux-pm@lfdr.de>; Fri, 12 Nov 2021 20:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbhKLTgv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Nov 2021 14:36:51 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:46727 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhKLTgv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Nov 2021 14:36:51 -0500
Received: by mail-oi1-f182.google.com with SMTP id s139so19691496oie.13;
        Fri, 12 Nov 2021 11:34:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=57Adm9risFC+iiho0gvxjmtvx2b1Ul1A2/SX3qSS5Jc=;
        b=cESD5Ht9h1xURQB2nH3yBSFwVkygYl0l//rJDb3AqLEirwindXu2tbvkEPHxRTxkhS
         f8+Dq17r8dhDlS1FcRWzPzgnQL79rZTLZmbU4zyAe0UCkWbZ3zrYggXtcJpd2FUilDKf
         zeYBOryoYuADySP3Rixp1kewlDh7aXrPUImO7SoH3EfBf4+w22addSj78R8hKISexuf1
         z771uJAZZvcjl64ph9gTD5AdDknnpw9R2L5iia3VK0piLMqexpkgOF29zBNkk08KuuJn
         mnval8VU6NIVRqshf+d7Q5088nouZrCfuDOluLHTxlUE57TskQcJKeUVf5mjfgi/Tjfi
         iYEg==
X-Gm-Message-State: AOAM532q6HEU7O6pHhdPzJhZubbnlRHw9oXQwfn57kKXipdfGfvIwz+i
        +9LIzqj9nsIux8ezUca03w==
X-Google-Smtp-Source: ABdhPJwCVnbZJHOqyOwKUfLZqJRrGRpVXWj6i9/qA5s0AHlXT2sIkmi0agaMsW5YBXeuze0I92CYLg==
X-Received: by 2002:aca:df82:: with SMTP id w124mr28360042oig.171.1636745639570;
        Fri, 12 Nov 2021 11:33:59 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w19sm353035oik.58.2021.11.12.11.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 11:33:58 -0800 (PST)
Received: (nullmailer pid 3232250 invoked by uid 1000);
        Fri, 12 Nov 2021 19:33:57 -0000
Date:   Fri, 12 Nov 2021 13:33:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH RFC 1/3] dt-bindings: power: reset: syscon-reboot: use
 non-deprecated example
Message-ID: <YY7BpeQ4mee6EVmA@robh.at.kernel.org>
References: <20211102152207.11891-1-zajec5@gmail.com>
 <20211102152207.11891-2-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211102152207.11891-2-zajec5@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 02 Nov 2021 16:22:05 +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Usage of "regmap" property has been deprecated by the commit
> 2140d68d69d4 ("dt-bindings: power: reset: Unrequire regmap property in
> syscon-reboot node"). Rewrite example to help people using
> non-deprecated binding.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  .../bindings/power/reset/syscon-reboot.yaml        | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
