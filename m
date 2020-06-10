Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8941F5AE3
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jun 2020 19:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgFJR7B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jun 2020 13:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgFJR7A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jun 2020 13:59:00 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A631C03E96B;
        Wed, 10 Jun 2020 10:58:59 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id n22so803936vkm.7;
        Wed, 10 Jun 2020 10:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=qPDDsblskj7YQmgnouxNlkCLsEOLE3lWy+i5i5BsSyk=;
        b=Ed8Q/VdKzx70Hkg1B9bBSd28+aKmZRAjdKlNjSK91zvZF1DNrNUf8d9zKBjBQo8+KX
         TMbuKQtZ+8hS/oVcUn0gyANMUZSv/JLYNPUzvotSJUSZuH11hedRVl/ay8xYXySV2u+7
         LfihLzrAujQEp2jBfkXLX7uOwCd6pAm8NgE2JxyAfkvudZyT8Q4a+kA1f6g/KC/8hVmD
         OphOFAhRDfpleloVPlDxzMkTZixMzPD9YgNCLmq+Lbl4cSUqPXqpedqvGjvH3QwzBbw8
         Ut5k9R/7LO2YhfY3CBiXNN5ktF/nCqYHJ3vDX6DO4QuANJpx2gxqUfeyi81B431vrd5J
         OHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=qPDDsblskj7YQmgnouxNlkCLsEOLE3lWy+i5i5BsSyk=;
        b=Kyacca+nlPeB2DmGqtTHSQqMlBSipuBZeuIIauxU/hKdYW98gj+dbKgDBsq3YhI+Ew
         2+JUF9FbDu0ktfHYB4D1hClbGLAJco7Dwug+YsfNkHv3TY2uUurPu4Ql6cEyHa81qlue
         TjwwkAGC4uvM+lXS8hstEXoXXyEMFToIGuVSDUmbQdK6u7R3QIdqnw96sCOQcJKmyh3F
         rzmFbiB7Ar7xjtEoxydFXLFUf62TvTRNG9bexqQjmBll+DRCvegrDBUhhoIFfsrqduqa
         GFq+jKAMS0mTYo0FQqcD4lg4EyueK8SstdxDtpixbITkdiFp7FuURf1pY42/Dq3ua3vs
         3SuA==
X-Gm-Message-State: AOAM532ZGJ4HhG7tX2RWxlO2Px8LiV8PT7QVTcq9m+8CO1Zaq3H26dBw
        LlwE+OMe3y1O5hLvKHUFlvl6YurT8sgLbw6RRZw=
X-Google-Smtp-Source: ABdhPJw9uDJgVd9SIg6w/P15cfth+r88JW04PZtQl+ymB+hw4QcQ5bSyBNW+x3Ocs/2YUYOxW0gDFgZPBv8Du1d8H8A=
X-Received: by 2002:a1f:18c7:: with SMTP id 190mr3423466vky.39.1591811938261;
 Wed, 10 Jun 2020 10:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLj4m_jvs90YpAq5r4gAP9o8Y1Uck3HN+MbsTPb3zP=4eA@mail.gmail.com>
In-Reply-To: <CAOuPNLj4m_jvs90YpAq5r4gAP9o8Y1Uck3HN+MbsTPb3zP=4eA@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Wed, 10 Jun 2020 23:28:47 +0530
Message-ID: <CAOuPNLhQFegohvCx3dD-CtDdYrTSfGrJ1M3ps_YLn4j29x5pFw@mail.gmail.com>
Subject: Re: Generic way for verifying GPIO wakeup capability
To:     Kernelnewbies <kernelnewbies@kernelnewbies.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, linux-gpio@vger.kernel.org,
        zonque@gmail.com, sergiosiena@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 9 Jun 2020 at 23:06, Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> Hi All,
>
> I am looking for ways to wakeup any devices (from sleep) using any
> arbitrary gpio wakeup method in a generic way (either from user space
> or kernel space) that should work on any kernel version (starting from
> 4.14 onwards).
>
> What are the options available right now ?
> I wanted to experiment with all of them and decide which is best for us.
>
> Is /sys/class/gpio/ method still valid with the latest kernel ?
> Or is there any other method to do it from user space ?
>
> One option I know is to use enable/disable_irq_wake() API from kernel
> driver suspend/resume path.
> Just like this:
> https://lwn.net/Articles/569027/
>
> But this requires an additional kernel driver and device-tree changes
> for each gpio wakeup, which the end-user needs to implement on their
> own.
>
> Is there any other existing generic mechanism?
>

https://embeddedbits.org/new-linux-kernel-gpio-user-space-interface/

Is it possible to achieve this using this new interface ?

And I think another option is to use gpio-keys defined in device-tree.
Will this method work for any wake-capable gpio ?
How to verify this for any arbitrary gpio ?
