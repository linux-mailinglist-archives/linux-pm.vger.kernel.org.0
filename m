Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBA17EE3C4
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 16:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbfKDP3k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 10:29:40 -0500
Received: from mail-il1-f182.google.com ([209.85.166.182]:42683 "EHLO
        mail-il1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbfKDP3k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 10:29:40 -0500
Received: by mail-il1-f182.google.com with SMTP id n18so8158120ilt.9
        for <linux-pm@vger.kernel.org>; Mon, 04 Nov 2019 07:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=NqR5XU4p3tUzLoUU09owoA1NuABgrde5Fo+bBm5B7SA=;
        b=J8jC2c2QV11dg73MpdfG0fAtIy9Lb6rlSVF3pZjoVhSMpEbhnJf7PCAu34T2X3teTu
         aSjI2oT5KeOh9JRBzERBGw0QpEqoorjVlCgIuBYM6ILwEvE5Bs1npHu7qUiB+QZzU+rJ
         YqyM7s2h1qJYPL1VSyPQ+TubSLVquTQSJBjYCTaaiF6pnaJfdrio7sKTEFtEcj4utLnJ
         1RV6pQlAeUGjT8T06l2gcIvWvXzXwxTjYBo6i0YBy/AvgWwtgHrCWSWnuODyeQ0BvssO
         vnYERMskr+iH3g8iPBzPP7QDb7Y8ntSGFah9DvgmEIOqxbST2QtrqFuP9eahmtVy2o9m
         BOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NqR5XU4p3tUzLoUU09owoA1NuABgrde5Fo+bBm5B7SA=;
        b=Ka4T1EdcO6pmVkhoXm2pqYysDMhZuiGFoz3+pe8Mim9CY3MFfzwH1JLxAVMmoMJmee
         ao4MhLOx6l5K9hbudqQ/hrG/9lwhYawy2oasWGDSCEEa/yKJWd7K+bDvmFOpjlrvZ9+3
         gTGT831OnpSwPM2G1xfe5d55VDRL1Ah3UTbYJfgJdntJz3zNimbCs7vkkXw3Kl54hEHn
         RkcXivhqb1EaEeuu2ydMux4ChTTzzrfCspwOIj5Sd5/LY1YcWk1y4iDnm+AWBW0EaHz+
         ULJl0PEHOeuISwoCCmwxk1xQLlEhFHNhw9sFzMH96+E8yFYj17cUivJdoLr31f9rj1c9
         LGZA==
X-Gm-Message-State: APjAAAWztsWTdAlm1lYPj2G2gtlppzrIl0pJfd1940jyGw6z9gGx20y1
        iM9Vi1z0rZYWjynKTs6FDdzq3TYhnEbiEVeQXgNRJGub
X-Google-Smtp-Source: APXvYqxjIXnxwgnPjv+S6A5tvIH+lNE1dGic5nJ7S6nTQAnRIDglZkn9GD4R/hx7SCnuEl0XNbzwPn0QZA542LXEXsI=
X-Received: by 2002:a92:9908:: with SMTP id p8mr28009578ili.304.1572881379103;
 Mon, 04 Nov 2019 07:29:39 -0800 (PST)
MIME-Version: 1.0
From:   Tom Cook <tom.k.cook@gmail.com>
Date:   Mon, 4 Nov 2019 15:29:27 +0000
Message-ID: <CAFSh4UxDh4fuRgKv4puz3i9Y4KT+V+BBN21v4KxzRd2zpgKb5g@mail.gmail.com>
Subject: Power management on HP 15-ds0502na
To:     linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I've been pointed here from the LKML.  I've recently bought an HP
15-ds0502na 2-in-1 laptop.  It does not appear to support
suspend-to-ram at all; /sys/power/mem_sleep contains only "[s2idle]"
and adding mem_sleep_default=deep on the command line doesn't help
this.

Which leaves s2idle.  The O/S (Ubuntu 19.10 in this case) correctly
tries to initiate s2idle.  But leaving it in this state in a bag
results in a very hot laptop and the battery drain is still
considerable.

It seems that this is likely to be caused by a device driver that
isn't correctly powering down its corresponding device.  Can someone
point me towards how to figure out which one?

Thanks,
Tom
