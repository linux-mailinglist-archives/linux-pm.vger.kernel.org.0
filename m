Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE1717031E
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2020 16:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgBZPu6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Feb 2020 10:50:58 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45205 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbgBZPu6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Feb 2020 10:50:58 -0500
Received: by mail-ot1-f68.google.com with SMTP id 59so3327329otp.12;
        Wed, 26 Feb 2020 07:50:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XLG/HcpDoefwlDbSA6KkLlzoOTV7gKxlBKi85al1w9c=;
        b=ELz6ZMZr0rtKQ2d7fLzJdm1LmTURZt4Azsc0C2oDviJpliY1ved5qP4QJBBXa9s4Z7
         buTzqKGcciVBE5NuCzxLfhR+8fPaNz+MTJ+oHEj/K5RKc+JS9SyVDmlxjub7nMAwijLs
         +xq3U7FAAZo3l0RNuAnubvyzjWH0fDt9pRzEz0dhe5ubJb45tpwW22LJIPm2aR3v4H9D
         ZBCkt/+dcFjUSvxNW4o/9P0Hk9BOq+FF/k/yaJeGiqYZNo/HN7g+ypmj/HrzDgiEHBpy
         Ewrq9wMv97A2Ow7lgFOjzoHjOaCDD7ViH73TsHO2zWr6V2tBRB1E/x5+KEnqbg84yKcx
         JOOA==
X-Gm-Message-State: APjAAAUMH5x0duMm5wo8HtiWwAqutEXIZMf/3vwRq2DLD91DlYtprq82
        rXCueEX6jfwxIUOvqlH53g==
X-Google-Smtp-Source: APXvYqzz9bkQxK085SBSKbtINgYFodulsnBaryzAcNMdYU2j6sh2uVsRdP6BGe4x3hIwiFVgNwCLpg==
X-Received: by 2002:a05:6830:1e6b:: with SMTP id m11mr3726402otr.293.1582732257205;
        Wed, 26 Feb 2020 07:50:57 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s128sm923004oia.4.2020.02.26.07.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 07:50:56 -0800 (PST)
Received: (nullmailer pid 3525 invoked by uid 1000);
        Wed, 26 Feb 2020 15:50:55 -0000
Date:   Wed, 26 Feb 2020 09:50:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, kernel-team@android.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] of: property: Add device link support for
 power-domains  and hwlocks
Message-ID: <20200226155055.GA3403@bogus>
References: <20200220055250.196456-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220055250.196456-1-saravanak@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 19 Feb 2020 21:52:50 -0800, Saravana Kannan wrote:
> Add support for creating device links out of more DT properties.
> 
> To: lkml <linux-kernel@vger.kernel.org>
> To: John Stultz <john.stultz@linaro.org>
> To: Rob Herring <robh@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/of/property.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Applied, thanks.

Rob
