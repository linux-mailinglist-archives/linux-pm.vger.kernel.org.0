Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13713D8BA6
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jul 2021 12:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhG1KYS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Jul 2021 06:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhG1KYS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Jul 2021 06:24:18 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F5EC061757;
        Wed, 28 Jul 2021 03:24:16 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id m10-20020a17090a34cab0290176b52c60ddso3416009pjf.4;
        Wed, 28 Jul 2021 03:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=XidBTdQ5uPkt5vfN57UDqH+N5ltbBIRRuv2VRdTk2Zg=;
        b=fEpU7dw+rghIJT929Lau0M1sTD34ly6Vu3A6LY6lnxM7LrdfInYGSK7O3C3M51EUcD
         1GNJ7W4TItHQIBL74tJZqmhmGc/cs2xbebsPYdidhL3rU7MT4VjC03KBd/7bppOWcbc4
         oeleTuWwxOygXwwj+ocxpaUtZj3E2clzjHnNHeJAIit9AlQtqz/OCMtUa7nKccNhn6AA
         I+1AZUGljc3yMKoXAJqEufH0c6P7T3j/iK6idFvD56B9OF9Mvf/tAfof16McP5UP3O22
         qOU/qf2qsnxucDEyGKmkWOHR5B+OxSZAOTh094XUwalob4QdzEgZAjCQECKRlT+71wTk
         3CNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=XidBTdQ5uPkt5vfN57UDqH+N5ltbBIRRuv2VRdTk2Zg=;
        b=gO+QcT59Ldl7rdo4dGgf7uVQ06awZHeYl41tsNuhD9CemSjuXqJCRtrW0mJ1eZ0hXQ
         Vuv4FfMckB6Nffk23xnGj3d4SZhvaUCChAF41GHqgK8mm1sZW7Q9jJXQX2R8Wdg60m8F
         NoPYvm9nOu7nhLn29WybuATAK/BMaKw97aE0OLQlZvu6xhMEV0YxtLUQUVqwvOnA3XEL
         ArkU44RPqbuFenrDnHkg75OE/5ofXzxTVazyYucWFCTI2vkweMnsv1chWOs+68lpBmJ8
         xRA5pBJjugVGTjuZ6+wfSdlMoIJVonQFhKdMA2zvGTER9HNxhajeSjBKZxHKNP2FKtfl
         5Zzg==
X-Gm-Message-State: AOAM530632J3/Mz/cK799CvicQrXtL4a61qCW60XXH4C5z0OBwbnDaWo
        NA2l4/ZgbomIIDodjbJaJqc=
X-Google-Smtp-Source: ABdhPJyFTuwN9atLCkTmWglcY1RVNTF2pH6x7tCZGfUfM5IEO6OqyvrnI5ynOXPAjDm62wTcZTtOhA==
X-Received: by 2002:a17:90a:8914:: with SMTP id u20mr9046669pjn.47.1627467855653;
        Wed, 28 Jul 2021 03:24:15 -0700 (PDT)
Received: from [10.55.0.86] ([45.135.186.18])
        by smtp.gmail.com with ESMTPSA id 26sm5734396pjg.8.2021.07.28.03.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 03:24:15 -0700 (PDT)
From:   Li Tuo <islituo@gmail.com>
Subject: [BUG] power: supply: 88pm860x_battery: possible
 uninitialized-variable access in measure_vbatt()
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com
Message-ID: <e2080eb9-bbe2-5077-761d-b5594edb6006@gmail.com>
Date:   Wed, 28 Jul 2021 18:24:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

Our static analysis tool finds a possible uninitialized-variable access 
in the 88pm860x_battery driver in Linux 5.14.0-rc3:

In calc_soc():
369:    int ocv;
376:    switch (state) {
380:    case OCV_MODE_SLEEP:
381:        ret = measure_vbatt(info, OCV_MODE_SLEEP, &ocv);

In measure_vbatt(struct pm860x_battery_info *info, int state, int *data)
176:    switch (state) {
184:    case OCV_MODE_SLEEP:
201:        *data = ((*data & 0xff) * 27 * 25) >> 9;

If the variable state is OCV_MODE_SLEEP, the function measure_vbatt() is 
called with the argument &ocv,
and the corresponding parameter is data. Thus *data is uninitialized but 
it is used at line 201.

I am not quite sure whether this possible uninitialized-variable access 
is real and how to fix it if it is real.
Any feedback would be appreciated, thanks!

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>

Best wishes,
Tuo Li
