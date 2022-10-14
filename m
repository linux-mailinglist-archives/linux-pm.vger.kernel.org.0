Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CC15FF140
	for <lists+linux-pm@lfdr.de>; Fri, 14 Oct 2022 17:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiJNPZN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Oct 2022 11:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiJNPZJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Oct 2022 11:25:09 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E9011831
        for <linux-pm@vger.kernel.org>; Fri, 14 Oct 2022 08:24:47 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id h10so3426207qvq.7
        for <linux-pm@vger.kernel.org>; Fri, 14 Oct 2022 08:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8srtPqHGa40CVslrURYXsHSOfQqBi5LmheASbuMqgVc=;
        b=qcTAeaAa3q5DBM3sbVJ4oUjdktutaxqU3rr8IdCFsW9wPJnSYgImx0dNu0FMyYrH8R
         hanQkYVd75F7yv0HvNgIhf3sn13iW1eFf3BE1sZbpLFGbJPZe705DoVavp0Yzx6ebT41
         V9firAUWgdxk7Rp2TKdRaQCuBt6G1OnYIF0PETfq9iz6ObS49/cJgfM/fDxWaXqEX3+k
         s0WQ64erNi2xkeDuzFyGuQx2WxBCkYiU7zs7e0Pjmp4EgQkX7xBi3fMQccYoSVXVpM1R
         OR0WyGrdd5GHLRW49xt6Dh/5uJ8n4Lulkq6mavRC02+qXeTeOoD4xeaZUvWgnYI2cNgb
         DL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8srtPqHGa40CVslrURYXsHSOfQqBi5LmheASbuMqgVc=;
        b=WFlBMUD6siU1GozucRbsOWgCLyhGErVECxCImmL5xy9ZNel7OmmIc78LQRFT3+yrUP
         6wmqzJW8cA/1Nv/cGFxtqT0soHjOYpoj0Err1M1Ta8eRJYUqdXe6Seg0fXq+xzh2z2Tc
         4l69e8IS/tkr7DmFa+ph8Z0noIbHrW+3CZw0wYRb4qfeSv570Kpru3pZVV5l9gjLeaIN
         gJ531FJLeRxGqS/iP7IK9fl7tNxeGWw5O8IE9joNPa9khISCB1U/yvkVI+euc/Y6NIDt
         SyM19A+QVYXHKQ9zy3Mr6MAJ0vwUccMtWLnoop4G/ySjeoAoLxoQT8MccsdKdnemP5yr
         TRMg==
X-Gm-Message-State: ACrzQf3jKcIqsEK+F9aVK78iRz35t4rlyjMmq9jPsa0DpCarPRqOXkO8
        zrJsSdFJ7uDpS3zOvKs8pE91vXkJ2J/WwQnvfP8=
X-Google-Smtp-Source: AMsMyM66/9V0hiYngFsfBDM8+JbqFskih95boZ0yPyGhxH85Jld/00GaBcjBeXgiwRDdJ+dbMPPV4JUgm6UTKG3IuhI=
X-Received: by 2002:ad4:5aee:0:b0:4b4:595:fb54 with SMTP id
 c14-20020ad45aee000000b004b40595fb54mr4642461qvh.5.1665761072129; Fri, 14 Oct
 2022 08:24:32 -0700 (PDT)
MIME-Version: 1.0
Sender: klin.mlin122@gmail.com
Received: by 2002:ac8:7f4b:0:0:0:0:0 with HTTP; Fri, 14 Oct 2022 08:24:31
 -0700 (PDT)
From:   Sophia Erick <sdltdkggl3455@gmail.com>
Date:   Fri, 14 Oct 2022 17:24:31 +0200
X-Google-Sender-Auth: vowOCk0XPpe9aq9iPLIEEkxsyhE
Message-ID: <CAMwUt-qfPG+8B3m6anbG1YTKtmr0-Hanc+Z91Q6vbJk5mFth3g@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,HK_RANDOM_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dearly Beloved In Christ,

Please forgive me for stressing you with my predicaments as I directly
believe that you will be honest to fulfill my final wish before i die.

I am Mrs.Sophia Erick, and i was Diagnosed with Cancer about 2 years
ago, before i go for a surgery i have to do this by helping the
Orphanages home, Motherless babies home, less privileged and disable
citizens and widows around the world,

So If you are interested to fulfill my final wish by using the sum of
$ 11,000,000.00, Eleven Million Dollars, to help them as I mentioned,
kindly get back to me for more information on how the fund will be
transferred to your account.

Warm Regards,
Sincerely Mrs. Sophia Erick.
