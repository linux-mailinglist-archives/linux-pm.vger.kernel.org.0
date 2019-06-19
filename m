Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9E464AEF6
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 02:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfFSATI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Jun 2019 20:19:08 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38091 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfFSATI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jun 2019 20:19:08 -0400
Received: by mail-pl1-f194.google.com with SMTP id g4so147621plb.5;
        Tue, 18 Jun 2019 17:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=txJdPsxZSfIBkxE29piYLVegiEe9gNrp9bOhE5fYOl0=;
        b=lfeGDFqyhuiwVwvn1PDvA1xUq/S4wMLLjIkpTBW4eG7ssMAmoew9vdyQFyQItAhnrx
         da8tUfoTkpmbwCB1kPj6ArT8iwnyIXBcNhYW30E483PdQddNDRPSjST8IPO4NJE/hSL6
         hvS66vveifYvcFg8c6QDhM6o/RQ4G17ZfpokmAm68iIp9QmeR8DQfVbjlCctAORUxZhZ
         pA+yN477p6M9WRM54752vFTdhhM/brUWgJyj8IufU6Ufm00w9gADCXVocRGGShJ8LQpj
         r8bzkcFBAomvuiFXzOZR6tUiSus+RJmbchP/HALcuWq1Qx4pbG0E4/yriqtyFd9N3p4s
         gjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=txJdPsxZSfIBkxE29piYLVegiEe9gNrp9bOhE5fYOl0=;
        b=rePzplR8abg3lIRGpjG3ds3aqdgs9MQzBrJQEzemTAFdOycg3QF+rh79x3VRq7nHGS
         H19i10IJ2qG0gOZFGvF85pKo1Vxul7/Ls39AZ5nxCvM2WstmkympSA4Zrog4sb0KHzxR
         5lERZHtzm9FoRDHGusYSJn9yLdzlGL3d2QkGGAuHQErT+jnalUGLoHRnPmbzJziGL8ak
         eCRXcwlT/5akd16KohsoVrybVF16CZSpOaRSbDNY6O2w2cxTypzTYviOKgB/L7J2MHf0
         yGl1dtaNx4NNUEmoNKaVpJqqrvq+6EP0b3oi/FL+WmAUTG4Lf4tz5VPoZ/+h9eqFTIKV
         r+CQ==
X-Gm-Message-State: APjAAAVyRm6C1rGnuW/e69Zt69NCnszjPe9Asz+9Vt6ybRx9hZoLI4kZ
        43wHYordbupkmIYSm/N/luk=
X-Google-Smtp-Source: APXvYqxjpYLS684icAeEZCpfYS4B0tYeeGanzJ2b3pTXI+Dq+FPKke2PUv6gDWZa2CieqXUzmB4RAw==
X-Received: by 2002:a17:902:4222:: with SMTP id g31mr38664934pld.41.1560903547121;
        Tue, 18 Jun 2019 17:19:07 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id r1sm3478742pji.15.2019.06.18.17.19.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 17:19:06 -0700 (PDT)
Date:   Tue, 18 Jun 2019 17:19:05 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
Subject: Re: [PATCH] PM: suspend: Rename pm_suspend_via_s2idle()
Message-ID: <20190619001905.GA62571@dtor-ws>
References: <7812857.KkDK7346ep@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7812857.KkDK7346ep@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On Tue, Jun 18, 2019 at 10:18:28AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The name of pm_suspend_via_s2idle() is confusing, as it doesn't
> reflect the purpose of the function precisely enough and it is
> very similar to pm_suspend_via_firmware(), which has a different
> purpose, so rename it as pm_suspend_default_s2idle() and update
> its only caller, i8042_register_ports(), accordingly.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I assume you'll take it through your tree...

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

-- 
Dmitry
