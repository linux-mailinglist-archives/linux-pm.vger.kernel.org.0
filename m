Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0C53FC8F3
	for <lists+linux-pm@lfdr.de>; Tue, 31 Aug 2021 15:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhHaN5Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Aug 2021 09:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhHaN5W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Aug 2021 09:57:22 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08BDC061764
        for <linux-pm@vger.kernel.org>; Tue, 31 Aug 2021 06:56:25 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id d16so31951338ljq.4
        for <linux-pm@vger.kernel.org>; Tue, 31 Aug 2021 06:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=GHw91jE4urGzuAZWeCNVF0wY1JmpGNBGveBNe7Ax0Vg=;
        b=MZggc6Q3tq62yniJQ8TOlxyxADB7u+JwqBceXF7wsT6YU+FvWjjIVhAv28O+nTJFnc
         BAnGzmLk2zrncJvnt+N5HpmnFQtv1icgAMuC3J1ep8Icf+jOptjTfms8LM/JVorY1SmF
         EMw+ogP10CHA/34LT886Q32WJthi9VdgJZ7CQi92QqGdZ35NomPUqSjC/ujjL7QJdgR2
         IrJV5Zisn4wG6Kljqb+uZZ161kfaG/2mpu/nzO+kSjlDCiCoYf7z7Iq6eKqo/5YkYmNX
         +BVYEwaoP/BH706Me7QnmsxrxrH0bYZxxtXxAl1naF/2qpcwlfvZL8uvmO1awt6prYUV
         pafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=GHw91jE4urGzuAZWeCNVF0wY1JmpGNBGveBNe7Ax0Vg=;
        b=aiof4aHVbi7TrIT/nVvF/+vfC1TbYsjBXCMqB9Jw4oRgyHu5fWl9D2aKHqAAWKJ0oh
         z5LqO/1z/E7uP46+N6Tz3QbzczOjci8kQ0RCcX9fBVI49X+4WpaOuPQn5OXILKHmRbFu
         K/2X5s3QewbmMrQTHdDAyrv0/atvqcTmXhWjj/S5cZ2wYMDmd7NHZ3+jCR0CQySNjYH6
         +1YwkrvfzkEIxQMjeJTQ2Rsrz430I5Fc6tsz2JM3/HEcs7YkziMvSRPlxK4QPCK6+1mB
         WmtFem9vpJfbTBtX3CPXIYK54M7Sv+ibBC9II6aece+ZosGPGwPLFIN1NWONhh9X+J0D
         bwXg==
X-Gm-Message-State: AOAM530UxV5o1eRV9ZJhtLrpsfoGBRSPSvtLqJqpevxJnv0/hhsCyBr6
        8CtFmY/i9czk8+xN9eOhtBof9YF3K72TNP9OP7JixthAvZ3Uob15
X-Google-Smtp-Source: ABdhPJzIAcRINhNa4Ey0Ec1ehsMZYqqzQVMJpqPtfaXq1kuyy8opAvDt09+49VbqBd6l2Mu4eB3zKNN0aPJfqJss4WY=
X-Received: by 2002:a05:651c:158f:: with SMTP id h15mr25197229ljq.249.1630418183988;
 Tue, 31 Aug 2021 06:56:23 -0700 (PDT)
MIME-Version: 1.0
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 31 Aug 2021 15:55:47 +0200
Message-ID: <CAPDyKFo9Bxremkb1dDrr4OcXSpE0keVze94Cm=zrkOVxHHxBmQ@mail.gmail.com>
Subject: [RFD] drivers: base: A driver's ->sync_state() callback don't get called
To:     Saravana Kannan <saravanak@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Saravana, Rafael, Stephen,

I have observed an issue with a driver's  ->sync_state() callback that
doesn't get called, even if consumers/supplier device links conditions
should have been satisfied. I have narrowed down the problem, but I am
not sure what is the best solution to fix it, hence I am turning to
you for some discussion/advice.

I have two test platform drivers, one that matches on the
"test,pm-domains-test" compatible string (this driver also has the
->sync_state() callback assigned) and another driver that matches on
"test,runtime-pm-test".

This is the relevant part in my DTS file:

       pm_domain_test {
                compatible = "test,pm-domains-test";

                pdParent: power-domain-parent {
                        #power-domain-cells = <0>;
                };

                pdChild: power-domain-child {
                        #power-domain-cells = <0>;
                        power-domains = <&pdParent>;
                };
        };

        soctest: soctest {
                compatible = "simple-bus";

                rpmtest0 {
                        compatible = "test,runtime-pm-test";
                        power-domains = <&pdParent>;
                };
        };

During boot the fw_devlinks are being created and their corresponding
links. With some debug enabled this shows some of the interesting
parts that are being printed to the log:

[    0.041539] device: 'pm_domain_test': device_add
[    0.041629] OF: Not linking pm_domain_test to pm_domain_test - is descendant
[    0.041718] device: 'soctest': device_add
[    0.041803] OF: Linking rpmtest0 (consumer) to pm_domain_test (supplier)
[    0.041829] device: 'platform:pm_domain_test--platform:soctest': device_add
[    0.041892] platform soctest: Linked as a sync state only consumer
to pm_domain_test
[    0.041957] OF:    create child: /soctest/rpmtest0
[    0.041995] device: 'soctest:rpmtest0': device_add
[    0.042072] device:
'platform:pm_domain_test--platform:soctest:rpmtest0': device_add
[    0.042132] devices_kset: Moving soctest:rpmtest0 to end of list
[    0.042141] platform soctest:rpmtest0: Linked as a consumer to pm_domain_test

The interesting thing here is the "sync state only" link that gets
created. I assume there are good reasons for creating this link, even
if I fail to understand exactly why.

In any case, the sync state only link never gets dropped, which I
assume is because there is no driver getting bound for the "soctest"
device (it has only the "simple-bus" compatible).

In other words, it doesn't matter that both the rpmtest0 and the
pm_domain_test devices are probed, thus satisfying the
supplier/consumer conditions, the ->sync_state() callback doesn't get
called anyway.

Can you perhaps help to point me in a direction of how to best fix this problem?

Kind regards
Ulf Hansson
