Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C16358B43
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 19:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbhDHRYr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 13:24:47 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:38661 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbhDHRYr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 13:24:47 -0400
Received: by mail-ot1-f44.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so3050294otk.5;
        Thu, 08 Apr 2021 10:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vGCnfDw9SSDsfCUsuqEnV4jC28XwKrPjr5OR4iCLoO4=;
        b=Cy79LZ1j8kgo/KaJ2INautQXYoz9OQxDF+NIW3BdHsf4TqhN6xFKMkItmkSeU8NpRv
         o3DY84cHo8cQFeqDWCCWkT940qDoljHXXX9bzKNb8PH7X+QGhSpy3+2K5L/LNhLrSqY3
         PdZ21Io8TN7XOquBPZlXjIQYnfPIyBGJOgJLPfnBNqHmRq5ymV+1oZ8dKri4xl2kt6++
         b6AZKCnRA+xEhg9jhDGttOTK8DrJWZjfq0tC6ClPLCA1MSHbfQ8TBUMLX2r3Q3roUDOh
         Pn7QAgdGAYvrX9SQIVRUgWeAybQy5LE9U9YvPOwGXk7G+3Ic4uo/eUctircFR/f9k5tt
         edag==
X-Gm-Message-State: AOAM530E+xGI+9qH8bAVAEav1fPb5Wj3XqzDLObb/n9/5hUDpjTw+6FE
        /9BDLZ1CgqiuF2eeHgMSqVvpte7raKPZqnlCskc=
X-Google-Smtp-Source: ABdhPJxYzwWsy6QKevubEqHV1CWr7Kmw0Fyj01QRPmGVrsD3Z2QLvvZFgPUrvHaELkygiK4GEYkLyLvBazYAZsL2CUY=
X-Received: by 2002:a9d:4811:: with SMTP id c17mr8894282otf.206.1617902675805;
 Thu, 08 Apr 2021 10:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <03743d3c-a3bf-066f-614c-1a49f566fdb2@linaro.org>
In-Reply-To: <03743d3c-a3bf-066f-614c-1a49f566fdb2@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Apr 2021 19:24:24 +0200
Message-ID: <CAJZ5v0iGQGRvjaesmvvxpmot9vkyEEVWHkj3Wka24xZCzL351w@mail.gmail.com>
Subject: Re: [GIT PULL] cpuidle for v5.13-rc1
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        He Ying <heying24@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 8, 2021 at 5:10 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> please consider pulling the following change for cpuidle on ARM for
> v5.13-rc1
>
> Thanks
>
>   -- Daniel
>
>
> The following changes since commit dde8740bd9b505c58ec8b2277d5d55c6951b7e42:
>
>   Merge branch 'acpi-processor-fixes' into linux-next (2021-04-07
> 19:02:56 +0200)

Can you please rebase this on 5.12-rc6?  My linux-next branch is
re-merged on a regular basis.

Generally speaking, if you want me to pull from a branch, please make
sure that this branch is based on a commit present in the Linus' tree,
preferably one of the commits tagged as -rc or a specific merge.
