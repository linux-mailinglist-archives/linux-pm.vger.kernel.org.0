Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2BE61CC446
	for <lists+linux-pm@lfdr.de>; Sat,  9 May 2020 21:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbgEIT4y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 May 2020 15:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727938AbgEIT4y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 May 2020 15:56:54 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F00DC061A0C
        for <linux-pm@vger.kernel.org>; Sat,  9 May 2020 12:56:54 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id w6so4717716ilg.1
        for <linux-pm@vger.kernel.org>; Sat, 09 May 2020 12:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=1TGVQpNFmxPokiSkHbYv59AhWmEUxZVocgOxVRedEyc=;
        b=tqjkeQvEYAZOmHNSm7kAp3bbKLN4eM/4X8/IgdRJR7vqg06JabjncUXGPIIYMctbYc
         CQFKMbjrzA7fvBdcNgLFWKg5C2zOtJgGul3uiWoM8Aac0HXkVoWRSc4J8rbDiiSsyWuC
         9IJhaHCrWmC3/kYwYqYKmYRw5C7WIxbuF2d5yEc+J+7OXs/O78NvB3wFvJitI1adSk5q
         ha3ilxh0IH9nStqs1IL7doXJ/OwJHuW7TpmvHQ6pi6THcuI6AF6oEb13FvnttctogoZI
         0jVHAdzdrqkTE3qc3LzNzp3ztLCKVuGpL29l5yQcuf8T37V7yrZU8mBlOSHImAQj6sZi
         ou4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=1TGVQpNFmxPokiSkHbYv59AhWmEUxZVocgOxVRedEyc=;
        b=fMFo+dtYxULqddPhAj3oxwujCPEoKIVIoaK18PyLGUxVQFIY3bMYh8SPOvRv3NPbf5
         uQAehMYm5e7XY+Clr7gQV8seolW1RMOdems3uB0BU2CXSmvGJUQXoG2gSi9l03V4KscT
         u39JGKkWX6HOlkQdVh0EuaAcq6XYGdthSRsZDX1iBtDQfDgy9zDkvhbCUMr2CoajB7po
         +OX+FQ9FHjJ7nGyc40jb+iQ9iDyB1qwHlkPPoI6YkGFaBpU5Y0HlUugN+RIcXqB8xib2
         poameSPpepWtysafp5JSjUMCBoeGx+nbk8QZD3U0mke/4XEUjM9qiSmBY+p4ggDTf6G6
         iCQQ==
X-Gm-Message-State: AGi0PubUqVwFBWps89X0B05nSTEoOTYJyeO9DkrgGykcPKyziNh4ppiL
        Xi95oMAGbDAc7NewGJv70QwuFhV21mgIw8svrfc=
X-Google-Smtp-Source: APiQypKFdaBfeAb/HEJhn/ChACQGkbVwyZU/fZy/+UBk2o8NxVidB4ilA6EAZAR582CAb7SZ/bvaoB/a3hjJxrlcqvY=
X-Received: by 2002:a92:507:: with SMTP id q7mr3652870ile.150.1589054213457;
 Sat, 09 May 2020 12:56:53 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sat, 9 May 2020 21:56:42 +0200
Message-ID: <CAJiuCce9ZxeXnQzEW_3dbBDNZmmtWmKeft0hX+F9+SYu80NU=Q@mail.gmail.com>
Subject: Question about OPP regulator for Panfrost Devfreq
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     "open list:ALLWINNER CPUFREQ DRIVER" <linux-pm@vger.kernel.org>,
        Steven Price <steven.price@arm.com>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear OPP Maintainers,

I'm working on adding DVFS support using the generic OPP framework to Panfrost.
I'm using the dev_pm_opp_set_regulators() to let OPP framework get and
manage the regulator.
https://github.com/clementperon/linux/commit/be310c37b82010e293b7f129ccdcb711a2abb2ce

However it seems that this function only get the regulator but never enable it.
This result that the regulator is disabled later by the
regulator_late_cleanup().

In a previous version I let the Panfrost driver to get and enable the
regulator in addition to OPP but this create a conflict in debugFS
because the regulator is "get" two times.

Quick discussion with Mark Brown point that we should try to avoid
getting two times a regulator as it can create "confusion in your code
with two different parts of the device controlling the same supply
independently."

Is my understanding correct? If yes,
Should we not add a call to regulator_enable() in the
dev_pm_opp_set_regulators() ?

My WIP branch :
https://github.com/clementperon/linux/commits/panfrost_devfreq

Thanks for your help,
Clement
