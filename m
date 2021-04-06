Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682B9355CBB
	for <lists+linux-pm@lfdr.de>; Tue,  6 Apr 2021 22:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbhDFUKq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Apr 2021 16:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbhDFUKp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Apr 2021 16:10:45 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DF7C06174A
        for <linux-pm@vger.kernel.org>; Tue,  6 Apr 2021 13:10:36 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id i20-20020a4a8d940000b02901bc71746525so4008770ook.2
        for <linux-pm@vger.kernel.org>; Tue, 06 Apr 2021 13:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ctl1+sHC/d1YW62SoDI6AnpBJsfXmRKEeXHTRy6ZSQU=;
        b=Toz25f8A5C42QMVQ+PqZH2aLemjEzU+UCtnUQADpvNK96nCJv8qPhLn2VTyk/vJLKc
         r58dyWUVqqUj4QjnM/9e7/w82jHPR9ovYZzu1RM9cvTDHWSz8pVxFZ2/TfjkqZ2/YQHO
         FBGTelMkSdVa0NEMzxs9VCz5r84Dup/Dlnl+kJBDTtJIW35gIddT4Zg+hwebmXt0jvtQ
         awAZGNIoLReoiDOhJOskG1YqM/1uwmzfhpMrN3wtgAzS7Q7FsAAUU+RUeFFR6YuRvNKY
         nPQ9k+8qfQae3uEQQxXJnnH62K7o1Ir/1BsDSrZ2o09uzOjvEdAoiBL4JaSSJSeCJuf2
         Re6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ctl1+sHC/d1YW62SoDI6AnpBJsfXmRKEeXHTRy6ZSQU=;
        b=Mj6Q2xAR9EF1nZTn765CcMXCxUGNaxVOwH+kQXBVxiEkwcPAoTy649zyhiBY2WI85U
         ELlhBzT4703ACTE+0p9FtQINA3wx0hZj9Il+CcPcGO5zVmUoxJ2mMjUijf/+RQ3xRMN3
         /Cq+Gou2x7ujQ3Tl7RBu8QjjxorS7qsCWCr/vTPhWDMXgXo+SOOQvE/LD9gKizxiuFqu
         lpo4nNPveJFafJhTir1XpKhOM8aRybpSR7kYpyygjI9nN/IZQKwnchkaClmpt939xRNq
         zwKZ5aawrr9v93c7DqOeyOZHQPHiRqz1PM4J0OPj9LDTFWvqxzxoVCUiAzDgiRVw2EzF
         ntcA==
X-Gm-Message-State: AOAM533lVCQPRGWYNose4fRwpcS6QrH0vQzJ726E/tvwBY5TaIZSrmv3
        3mh2r2jEZMCZYoDB8v1lxfdFATwy0R57M1KtfFuIcTrxCj5KJQ==
X-Google-Smtp-Source: ABdhPJyqmuw3d6No2EfJtgLBJlkl7nYRWi88oVrLcUqMGh/1k5EDtiamW9uxg0AkVJU3AUAjdXOAwImkhuuznAHWjS8=
X-Received: by 2002:a4a:4005:: with SMTP id n5mr28300672ooa.61.1617739835598;
 Tue, 06 Apr 2021 13:10:35 -0700 (PDT)
MIME-Version: 1.0
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 6 Apr 2021 16:10:24 -0400
Message-ID: <CADnq5_My3jOOTyg+iP6-RANTFkVHZhoQw-oH10Di6zrveV6dbA@mail.gmail.com>
Subject: Understanding DPM_FLAG_SMART_SUSPEND and DPM_FLAG_MAY_SKIP_RESUME
To:     Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Can someone help me understand how DPM_FLAG_SMART_SUSPEND and
DPM_FLAG_MAY_SKIP_RESUME are supposed to work?  I've read through the
kernel documentation[1] on these features and it's not clear to me
exactly how these are supposed to work and which PM callbacks the
driver needs to handle in what way for this to work.  What I would
like to do is runtime suspend a device when it's idle and keep it
runtime suspended through a platform level suspend/resume cycle any
only have it be runtime resumed when its next accessed (e.g., via
pm_runtime_get_sync() from an IOCTL) after the platform suspend/resume
cycle.  There's no reason to wake it prior, but in practice this does
not seem to be the case.  Any insight would be much appreciated.

Thanks,

Alex


[1]: https://www.kernel.org/doc/html/latest/driver-api/pm/devices.html
