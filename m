Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7DE9B444D
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2019 00:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387679AbfIPWzx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Sep 2019 18:55:53 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45355 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbfIPWzx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Sep 2019 18:55:53 -0400
Received: by mail-lf1-f68.google.com with SMTP id r134so1219985lff.12
        for <linux-pm@vger.kernel.org>; Mon, 16 Sep 2019 15:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mHwZiUEWjc9swLSrA+O8n+3GFYnLBPp2503+qbDKMPk=;
        b=Jh55DSMRwVsr83uMOMNRECQdUb6hFZEa8/M5uMYTQZEF397XeQkCHw2NFgXX7BTdLf
         o8wjqUb5PE+erW1iJHUY2RXXFBLcWkdYEajivumQAeTByirDKkhog5PqKRR4yAcuK/jx
         3WztjSGqwaFFf4XsfmEn5psOHDHFf9zBuMFjS28vkZdGIh6/bzSLXpnpz027Egf69y4U
         IOhKKx+jU5uZ1uOZsmGoMH5djfad58sTXhbhQO9tZerT/XCfYdU2HlHBp9kysBJsg02s
         JIxx197aBFsM/zzcq0Ulv6Yr7diTfVqMLPOsXXhU+vZLniVMEt5/4JsSXthyTkQRe8Yo
         ssLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mHwZiUEWjc9swLSrA+O8n+3GFYnLBPp2503+qbDKMPk=;
        b=GfXnJvZfmw9nL2EkF981YtYBYPFOyXY4U2HWFXcgrM0kJ/DKlGInphf6c3ua1tt+Ul
         4t45J/W2JTFUKsUBZ4CNT+VtfXCnFjHo57cX34EAgB711YiekMaorJW3sNpIRv1F3KgA
         yUoHcCMEWmsZrBTPWKa2IJJHVv6bA9rbzLXRYUgdqwcb7zikC+ebOXRMmBmDGR1eTV2J
         FDVuRsMiVOtIU4KkLGqQebRJpqT+7461Lh4BWWxFPnvupKYFW1P6wqQdfbh7bNh0aUuU
         p5HtdlDju/nn/lLPXhYkZnypjUKUoxxMWQS4aFfzoX+UmjLck60Xryr5DMNtXU5wl5jw
         uBYg==
X-Gm-Message-State: APjAAAXqK1jQaXiiOzlWrSJRgYoDrAmZ7ibklSxa5CoyDEhOYDjYeIqg
        F+tGOm0hEM91b6y8vtB7UVR1ElL/DWAdAIaCqxi9zQ==
X-Google-Smtp-Source: APXvYqzxHqS/wbbqGLeDYbPwJ9trlFq8XBxwGF0oVQVnQJJDp/7Sg9VgZLqu7ZmLIRVj250jBfNcAYImGk2AHGrh27g=
X-Received: by 2002:a19:48c3:: with SMTP id v186mr289298lfa.141.1568674551419;
 Mon, 16 Sep 2019 15:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190828130320.6174-1-linus.walleij@linaro.org>
In-Reply-To: <20190828130320.6174-1-linus.walleij@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 17 Sep 2019 00:55:39 +0200
Message-ID: <CACRpkda1Qzc2K0TixHCN+y6qr5bCdq1ZfxvpGObSbci052Y0Tg@mail.gmail.com>
Subject: Re: [PATCH 1/3 v4] thermal: db8500: Finalize device tree conversion
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 28, 2019 at 3:03 PM Linus Walleij <linus.walleij@linaro.org> wrote:

> At some point there was an attempt to convert the DB8500
> thermal sensor to device tree: a probe path was added
> and the device tree was augmented for the Snowball board.
> The switchover was never completed: instead the thermal
> devices came from from the PRCMU MFD device and the probe
> on the Snowball was confused as another set of configuration
> appeared from the device tree.
>
> Move over to a device-tree only approach, as we fixed up
> the device trees.
>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v3->v4:
> - No change, resending with the rest of the patches

Eduardo: are you picking up these patches for v5.4?
Or is Zhang doing it?

I am still confused, and a bit worried to miss the merge
window with this series.

Yours,
Linus Walleij
