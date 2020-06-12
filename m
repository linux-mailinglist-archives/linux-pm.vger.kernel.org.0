Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9977E1F7E49
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jun 2020 23:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgFLVC4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Jun 2020 17:02:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48638 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLVC4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Jun 2020 17:02:56 -0400
Received: from mail-pj1-f71.google.com ([209.85.216.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <alex.hung@canonical.com>)
        id 1jjqpB-0001iV-O5
        for linux-pm@vger.kernel.org; Fri, 12 Jun 2020 21:02:53 +0000
Received: by mail-pj1-f71.google.com with SMTP id j43so7635994pje.0
        for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2020 14:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=rrP+T3snK0vFi42pWy2B4BqHfXedF4bPvzcWJ/8qGkc=;
        b=CklTK1AHAk6pr24oyCvx0IyOVt2lOQgph2eXeisWvhg5TpwSPkG2BfhBiOoF1R7zld
         +ZiEWhfyZS+bPcfVP//KisxkI2TVGpSLUtctdoBvatCmndv6SgMwUCxK1wDp4muaSuJS
         IsbtnEtFOc7BN3JCseCjFljmEdVim1fiYvz9lfv/v2EkyVNbBCC5F5vN6JeSuUM0sJ95
         K3xW2fHQtZ2OwB6SgnBUS8AYCBK6q/olJT4atElC3e2TkmwBa5OVvRg6yEpoEIIrron3
         +ac3NkVqEN99imgWoHViuhr8teAcuMquNFF7okhck5a2TwONrXYIzBwu/7fNiEUoOWmf
         sYUA==
X-Gm-Message-State: AOAM530dVO+0hAfI44OBvpvbJiirOlZSzYG6mhCRCMLBYsG5bTl0x+3t
        /0dZXQXp/3veGMLp29Pjcwq91eIhsqTS9G0M0BQLzfmh057O/b8Pl2ZDHZd812RzGO5U/o2fSTS
        kkmjzHLH3H7QhDIaSqES4JJ9SuCP5X2ZNyGWy
X-Received: by 2002:a17:902:bcc9:: with SMTP id o9mr13454800pls.335.1591995772250;
        Fri, 12 Jun 2020 14:02:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzItSmSVzLsQzpGlXKO1S80TyuTT2MnmmPLYc71J6NSIuT1pBaYP51gNwnEdgFG0Yj8m8uVQQ==
X-Received: by 2002:a17:902:bcc9:: with SMTP id o9mr13454777pls.335.1591995771970;
        Fri, 12 Jun 2020 14:02:51 -0700 (PDT)
Received: from [192.168.0.119] (d66-222-144-129.abhsia.telus.net. [66.222.144.129])
        by smtp.gmail.com with ESMTPSA id q145sm6953259pfq.128.2020.06.12.14.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 14:02:50 -0700 (PDT)
From:   Alex Hung <alex.hung@canonical.com>
Subject: [THERMAL] INT3403 and new 0x91 thermal events in dmesg
To:     linux-pm@vger.kernel.org, "Zhang, Rui" <rui.zhang@intel.com>,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com
Message-ID: <ee531821-83f1-2c80-4e2c-b2a359af7583@canonical.com>
Date:   Fri, 12 Jun 2020 15:02:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

A user reported int3403 was flooding his dmesg like following

[ 8.112761] int3403 thermal INT3403:00: Unsupported event [0x91]
[ 10.121722] int3403 thermal INT3403:00: Unsupported event [0x91]
[ 12.165233] int3403 thermal INT3403:00: Unsupported event [0x91]

Buglink: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1882823

In int3403_thermal.c the events are defined up to INT3403_THERMAL_EVENT
(0x90), and thus int3403 complains 0x91 is not supported.

I did a quick search online and found this is not the only case:
https://www.spinics.net/lists/ibm-acpi-devel/msg04629.html (though the
0x91 was unrelated to this problem).

This is likely a new feature in int3403 but I wasn't able to find any
specifications or documents. Does anyone know what it is and how this
can be added to int3403_thermal.c ?

Cheers,
Alex Hung
