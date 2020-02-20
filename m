Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF14166AF4
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 00:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbgBTX1A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 18:27:00 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35462 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbgBTX1A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 18:27:00 -0500
Received: by mail-wm1-f66.google.com with SMTP id b17so354884wmb.0;
        Thu, 20 Feb 2020 15:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gXhC1fUagtJi7fZvzRqoyd1CGAuI4p99NoxRHov+yno=;
        b=eAcVw+X81nRW3zoI1yR5wX/S5pCZdqCpf4aSF10m//RBc65CtQ6FtpIKhlvnQFtiis
         vIaDPSvJNiwXLbTeyMwpuWe6qxjB+EfwhlYr2i7vOplHTR+hDtnBfiUvIMQyjvNOFGt/
         FYEvmwxVqBw1sNcD6vLVt+MwiYSC8T++DRFmPiCsKOcFnJVHUfoaobWvd4slo1vuJTCd
         TVFBzdL2+h55plGDe3xnpBKFs5yw7s2O8UNK3yGEyXNUn8z7uzf75su9zERhxPdvF6+e
         UxW9p8jR4bf0YKJzhHeHvXil6rbPIR6Fp56Simdy5Rb4HXEenX1qdxEFHOe1F7L9BOKv
         5Fxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gXhC1fUagtJi7fZvzRqoyd1CGAuI4p99NoxRHov+yno=;
        b=MBryMIMhQ3zyx+Oz5eSPQZu65atqqWr79DRUdifkTE/5KYhAyXGpq+Cw9cI+/kkBBn
         c2RyU/WDMjgHgZXTFyWxRYHZpN5eN+N39qas+u5yr38o49vasB8aoQzcXtuFdZY5FalW
         SfEiW5sYg+mnetJafkoj2olpZFqoZvTwVVllkzrDKDlyL8wsxDvGADVuTBopuppXgQcH
         5QXgFExhc1uJO+d3blgW8Sd6XobbAsqPO2BOz1W31YsLf0N1t4JFU0k2DP5Q7JgriqB/
         ACxybSbxgcTN3bs9ikIXKR0qMpYgw6MwM8YiHfA9kgCBbUXxga9eOElR27cR0+kW96A5
         XceA==
X-Gm-Message-State: APjAAAXn60iSBJvxJjK+h4H822lCIKviWIvbBTsQTgfmhZCB2hr/rPxs
        Fe4XrPSDQobklhJnCVu8h3QUBE7urLt36RBLGn8=
X-Google-Smtp-Source: APXvYqxvDI4BZ8Sh8Jlyyw7mZ5xY0GgwMwrJBslvznQ5W22et9Ic+Vm2lPfCJqJOT1go6PmZMIA59zuA2EOnxaWxX1o=
X-Received: by 2002:a1c:1d09:: with SMTP id d9mr7100967wmd.91.1582241218869;
 Thu, 20 Feb 2020 15:26:58 -0800 (PST)
MIME-Version: 1.0
References: <20200220055250.196456-1-saravanak@google.com>
In-Reply-To: <20200220055250.196456-1-saravanak@google.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 20 Feb 2020 15:26:46 -0800
Message-ID: <CANcMJZBQe5F=gbj6V2ybF-dK=kRsGZT2BX9CBJiBFoK=5Hg-kA@mail.gmail.com>
Subject: Re: [PATCH v1] of: property: Add device link support for
 power-domains and hwlocks
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org,
        Android Kernel Team <kernel-team@android.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 19, 2020 at 9:53 PM Saravana Kannan <saravanak@google.com> wrote:
>
> Add support for creating device links out of more DT properties.
>
> To: lkml <linux-kernel@vger.kernel.org>
> To: John Stultz <john.stultz@linaro.org>
> To: Rob Herring <robh@kernel.org>

Just as a heads up, git-send-email doesn't seem to pick up these To:
lines, so I had to dig this out of an archive.

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

This does seem to work for me, allowing various clk drivers to be used
as modules! This removes the functional need for my recent driver core
patch series around the deferred_probe_timeout (though the cleanup
bits in there may still be worth while).

Tested-by: John Stultz <john.stultz@linaro.org>

Thanks for sending it out!
-john
