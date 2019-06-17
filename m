Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF8D4847B
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2019 15:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbfFQNtk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jun 2019 09:49:40 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:40089 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFQNtj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jun 2019 09:49:39 -0400
Received: by mail-ua1-f67.google.com with SMTP id s4so3503592uad.7;
        Mon, 17 Jun 2019 06:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=gAJ7/EU7d8odPoO9pWe4aDd9tc+dB/pfZ4tLxqLbXJg=;
        b=dID/X0G/KZCIk0PgUq85ATt2ShNl8nWB/JSZ2MU+e/u9iYRUuDlEZ+OmnlGCUG6Cq9
         xUuixKV5I3YGnHJ18kmDfhsJIuPDCaoZuZ+41VZtWguUQuzKtF9fSgOt3qIK9n+TuQBA
         hW2pYqBzh2YEf+qn9jJXdJ6dMlIehWdFFuMfWYfApTI84C47l3xuqFroUgR/PwJLqU3e
         o2//ueyeebjPI6oD1edVHqQubwI9jFslJVkivA6yy7IfJx+wzD/J/Es5IXq0ZOBOofQE
         ZKoZXKstVTeKKhyRgo3zwb0a5lxWjZt2CIpUOMhuCA8THO1RCF4k1v+f/6RuOALNzZeH
         zg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=gAJ7/EU7d8odPoO9pWe4aDd9tc+dB/pfZ4tLxqLbXJg=;
        b=FC5AEiEfQk5N6tSQYsQrNdU20pP2fSe3xPHCQ9pE6LZJvymZK48WJ9WS4t4gfYtRxU
         hqUB2Hdt1zEWHi4rYFvdPlMykSUyleNsPHhhiNICY8472NWpDEh76v5uwAnm7pY7hO7W
         eF3qF//2sAzzHoi3Ao/AzjaJI3zk8+Vz4BLygik6InyaDAwmvEIgzr4Z3bBjlTmyprCL
         1U8UoD7tgRIE56AHQOCdwnfGxIs4pWl22+QhQxlrmbt2ZQ2S3EWw6rqg9tm11hKUW8pc
         /fH1+ZVgG7XmEbgLL1rXwb83FcO4+LTzaA5jr0yG8ETIUcnu+ZZ+rOwnlGVSz+f8lu24
         i6yg==
X-Gm-Message-State: APjAAAUcatmPvl9JH5gl5UG4XDijDAogZRs/sKer31oa3pl6TaSFnWCy
        wBi+I4nD7KwxxUxlBDn8zeCSbPmP5fJ13W7pu4JX1t68ukM=
X-Google-Smtp-Source: APXvYqw4lxNSbbGaEiZRZPbsUHGxGYb5IJWBMmyaQeJGDHMhb/Zi1+yaYBKQIdcSBRrrpLlKATPxaL8tMoEsEBHYy3g=
X-Received: by 2002:ab0:4521:: with SMTP id r30mr31857546uar.70.1560779378220;
 Mon, 17 Jun 2019 06:49:38 -0700 (PDT)
MIME-Version: 1.0
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Mon, 17 Jun 2019 19:19:27 +0530
Message-ID: <CAOuPNLiBA9VjEoG_D2y2O5mKiqsDNW1VZXOk1eWXpGY+h86acg@mail.gmail.com>
Subject: [IMX] [DRM]: suspend/resume support
To:     open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

I am trying to implement suspend/resume functionality to to imx-hdmi driver:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/gpu/drm/imx/dw_hdmi-imx.c?h=v4.9.181

So, I need some help about this.
I logged the request in imx community, but it seems they are not responding.
Firstly I expect nxp community members to support (if anybody here).
Otherwise, I guess, people who are experts here and have prior
experience in implementing suspend/resume for their drivers, should be
able to give me some guidance.

Currently, I am trying to understand what needs to be taken care
during suspend/resume.
With some reference, I figured out that hdmi power off/on needs to be
done during suspend/resume.
But after resume, system is hanging.
It seems like vblank events are not getting triggered after the resume.
May be irq remains disabled after resume, I need to figure out some
way to enable the all the irqs again.

Even if I try to install hdmi driver as a dynamic loadable module,
still I get the same issue.

So, I wonder, what is the right way to handle suspend/resume for any driver.
Some clue/reference should help me to keep going...


Regards,
Pintu
