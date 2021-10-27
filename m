Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09A743C632
	for <lists+linux-pm@lfdr.de>; Wed, 27 Oct 2021 11:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241200AbhJ0JNA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Oct 2021 05:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241205AbhJ0JM7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Oct 2021 05:12:59 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C92C061767;
        Wed, 27 Oct 2021 02:10:34 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id bq11so4677409lfb.10;
        Wed, 27 Oct 2021 02:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=b2WtcqjAXmB+CrfbkP3LQY/joTB+xvHpfYZWIvXjo6M=;
        b=L5rmYNLueY+Dhu/hF80/2GxUhnbkG1t2WCOL2VxD7DQV6vMXh0EyHwNRWFf2PC5UUy
         3psOt3S/zu66fsywS5veIRn91PAtdgy7k1bSzUqfpwdlY3G1otaLGg/FP++tq7f5tXBN
         V0jyi/UM+8XQlOMjnDeFIVydJyAjL5JGQ81lcXESXRYa8kRp6iMM+bIVuOSnGemaV553
         p0e+vYLTMY/VCamGOTBOJI8IG+3CDcYj8f+6aTnQtO7z0MLKuAZbrBPoYSO1GvvfQOOn
         tR8Z3JuWakGa/v/n7DBApG5Vtmu4cKp6I7SZcJS/QiK/nXf4qfxSuWIOjQy77MNiIVZB
         bhiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=b2WtcqjAXmB+CrfbkP3LQY/joTB+xvHpfYZWIvXjo6M=;
        b=qQyPKp5E4p+Q2JwiIsbzz3Em4bkAfu4UBSUKcLjtdc3+GVwL69Z+mnsRaIwCHh+w3g
         NGLTqNEIqENI5VKSZRbPTnonQbRz3W5/n6oqwU+dzpe0WU5VtulaxH922vxv4m6QawTM
         HfUeOEfgV4Jbm4INZZEWfwP/G/QWuIWQSvnq1aaJj7uu5AaxAdGLbdGNMK06xw5yVA16
         13SODNpk7ZMresOo+sBY+TPHT39vykdgI2U0EQeI/dj7/bahEQhQch/h4OSPLQ7FGjfo
         wUD2aBUrEZExnK2B9vODbnZepKmA5oAEK7xEqw1mwkK7eMiPLj4ev7GYHifsIQNgE3mm
         4wnQ==
X-Gm-Message-State: AOAM533wf7457Zui5kst5aZIWJlsJNyhjU8xRL4QJfkeNReCpcoorQOn
        wqrztZ0uQ6yowC3WMNdVrXlGpXwehhcc280FmsdggCYqaec=
X-Google-Smtp-Source: ABdhPJwB4tMLCavlEsrPLIk8ajLHb6v8j0nkkIgDwvID4dkPvBUPBB/p9g5ci8IiE2ZgWd6E8aK2H3a07ZTFeGNEbxo=
X-Received: by 2002:a05:6512:1089:: with SMTP id j9mr29388429lfg.680.1635325832327;
 Wed, 27 Oct 2021 02:10:32 -0700 (PDT)
MIME-Version: 1.0
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Wed, 27 Oct 2021 18:09:56 +0900
Message-ID: <CAGTfZH22TzasJcVa65WXqXa_f_Wp03SGp5UOMRqkx3KO2KZhYw@mail.gmail.com>
Subject: [GIT PULL] devfreq next for 5.16
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Chanwoo Choi <chanwoo@kernel.org>,
        "cwchoi00@gmai.co" <cwchoi00@gmai.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear Rafael,

This is devfreq-next pull request for v5.16-rc1. I add detailed description of
this pull request on the following tag. Please pull devfreq with
following updates.
- tag name : devfreq-next-for-5.16

Best Regards,
Chanwoo Choi

The following changes since commit 3906fe9bb7f1a2c8667ae54e967dc8690824f4ea:

  Linux 5.15-rc7 (2021-10-25 11:30:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
tags/devfreq-next-for-5.16

for you to fetch changes up to 5cf79c293821d12fd88dee901692cd404247782e:

  PM / devfreq: Strengthen check for freq_table (2021-10-27 14:22:12 +0900)

----------------------------------------------------------------
Update devfreq next for v5.16

Detailed description for this pull request
1. Add minor update for exynos-ppmu devfreq-event driver
- Devicetree naming convention requires the device node manes
to use hyphens instead of underscope. In order to support
this requirement changes the code with hyphens.
- Simplify parsing event-type from devicetree without behavior changes

2. Strengthen check for freq_table in devfreq core
- Check whether both freq_table is not NULL and size of freq_table
is not zero in order to prevent the error by mistake of devfreq driver
developer.
----------------------------------------------------------------

Krzysztof Kozlowski (2):
      devfreq: exynos-ppmu: use node names with hyphens
      devfreq: exynos-ppmu: simplify parsing event-type from DT

Samuel Holland (1):
      PM / devfreq: Strengthen check for freq_table

 drivers/devfreq/devfreq.c           |  2 +-
 drivers/devfreq/event/exynos-ppmu.c | 12 +++++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)
