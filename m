Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F76A1EBEC2
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jun 2020 17:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgFBPJJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Jun 2020 11:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgFBPJJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jun 2020 11:09:09 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1468C08C5C0
        for <linux-pm@vger.kernel.org>; Tue,  2 Jun 2020 08:09:08 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k26so3492425wmi.4
        for <linux-pm@vger.kernel.org>; Tue, 02 Jun 2020 08:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmurf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=ujqEBlYn5RW/FhZ8oAAH/cXGb5bCvd0doM2u32QuzYo=;
        b=kWlaKUtL6A9ooKziy6WjhDj/04toYGKI3J/Ws5qprRSOuav6MxlOXqEuamefsbGxZZ
         6pC8POgV5aEgSGJW3SkJuecaJuoaak+Yz8gEE49RGJedD3FUUlJvnXi3h0TwFFbmhu3D
         QMrnzQKvFyYmeGepbWRjDfZ+jG3M4jLUNZgJ4tX46NswUlgJS6I579bLZmoduA8Ge/Gj
         ZrGu1e5GY0GrbPDKOufpE3rNCIHGQ9A93WU9pE9W28sqz74SGLCrH8Xp/DuGALx0CWpR
         Gq/y1m6oACzyJqQnBWFR7EcAj4F0rCVGHJRAnkxRUpv+GoaIKzxnxi/R/PQXhY8WvV+r
         kgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ujqEBlYn5RW/FhZ8oAAH/cXGb5bCvd0doM2u32QuzYo=;
        b=ZBmpuFKv6+E/K5y/6h7hnoQrfyoE4wrZ4zxW5IIuek0KbtkDLEN0f8JsZWvnt083gd
         gBrixT0ugULa2/qJBcwKU3kZFsZP2fqOVymDqGeQ5Avq7/IX72tR+2MAQTUJLwROfn/Y
         tLwzuDCKo8Mbn05ZUBPSPde196YZaFesT4r/Ei+liaKGdm4SC2XPzEqXVdDyEoMydXtL
         tEye/aruJ6N9GK2OAYVxnrhnho2G2BZNV6WVkTPAFZBJFmAqori6Imutpea+sEORZsFp
         /oweSxQOA/10lCTOhrdvr2JxkprufMrf6rJ+qWd0cCCCuoLbvznWPKo8au+yvcyAbmDK
         tmeQ==
X-Gm-Message-State: AOAM533VnPO7KN3CyKksENArfOtxzsbNGM36x/AJshcmjuAGChGnPB7h
        UFzh1MXmTiErcDOqz4MLh2XxgQEFMXj9ULWDKU7GXx59OPVdag==
X-Google-Smtp-Source: ABdhPJxYZe4bgjRengh/9QW+7JMImooXNjU+uaWUVYtGKjfTjEJUY5t5YxMT0WN30A9ZcaRt2ySLaPGGn8Cvtr5o020=
X-Received: by 2002:a05:600c:2110:: with SMTP id u16mr4436151wml.26.1591110546955;
 Tue, 02 Jun 2020 08:09:06 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <chris@cmurf.com>
Date:   Tue, 2 Jun 2020 09:08:51 -0600
Message-ID: <CAMN_aZCqH=wHErqybNj6BaAq=jfi8ox_JJxfj=ocNgCX9FCeLA@mail.gmail.com>
Subject: Re: PM: Image not found (code -22)
To:     linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A few more data points:

1.
# echo reboot > /sys/power/disk
# echo disk > /sys/power/state

This just reboots, does not resume. There are no messages during the
boot that it's even attempting to resume. This used to work as
recently as February so there's a regression somewhere.

2.
There's suspicious evidence that there's a crash following
'hibernation entry' message, with no further events logged. On Btrfs,
there's no log replay, but I do see:

[   22.947118] systemd-journald[629]: File
/var/log/journal/26336922e1044e80ae4bd42e1d6b9099/user-1000.journal
corrupted or uncleanly shut down, renaming and replacing.

And on ext4 I see evidence of journal replay and fsck finds orphaned
inodes. Why and how is hibernation entry leaving the file system in an
unclean state for the next reboot to clean up?

3.

I did the tests in section a.) and they aren't showing any problems as
far as I can tell
https://www.kernel.org/doc/html/latest/power/basic-pm-debugging.html

dmesg here contains 'freezer' and 'core' tests.
https://drive.google.com/file/d/1AhPBV8J_wA3m1M6n1EsgWSW_f42rxRYX/view?usp=sharing



-- 
Chris
