Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA5E79CB30
	for <lists+linux-pm@lfdr.de>; Tue, 12 Sep 2023 11:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbjILJKi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Sep 2023 05:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbjILJKf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Sep 2023 05:10:35 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C431FC0
        for <linux-pm@vger.kernel.org>; Tue, 12 Sep 2023 02:10:29 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-59b90c199f5so16902437b3.2
        for <linux-pm@vger.kernel.org>; Tue, 12 Sep 2023 02:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694509828; x=1695114628; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4wS5QgdUOCC9VaeBKhtLVMz+PTz3QdvRlZVKaTgTJWE=;
        b=VzAu1pNcB38JZBb5qj75ZEdFMzTVzfzgUSWDQGyqj7OOuqKb7zalrhq9tAAG8MVCRf
         B1paD6RDA63uoVovHiaL4mdGSk5yw741Hs7fTgjEtWC/c8rVs3aTYaLJaKZpnijhcEyz
         dRshRi/fydVnBJ4iHbdy9lt0tgUecP1NDBwQxq1ZdHUeiyN6pebg4HXMC0I669qv/vhK
         bdjNttZR9LVw7T7SvyhbTTCIK8NKPqSCvXYL6D4RQa6HUCaD1rJKZnr1ICN4/3T/3Yo1
         RtvatGStEdc883xG1gptrtIMD7rhbV230gq2adeBy/wpp6pk3CDtRslTyuHXR/m4bKBx
         taSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694509828; x=1695114628;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4wS5QgdUOCC9VaeBKhtLVMz+PTz3QdvRlZVKaTgTJWE=;
        b=F1OWPSb/7U7q6007KHYrZGPxYI9NkTeUOGrSzg+QNxScHuC1NLycjFcdKRXpJsP2S5
         CXqX9CjheIZRV7vrVEAkNdGJAafZ1UR9D/j99Da5Kr64C/K7SPEN61gfGCrqeItj1QZ2
         y8ekHaKFrFjJZYqPrK9X5cN2PQNfY2tbRZAAocxdgbxcmk9/sEXEz2uE7uQ2wjoSY0R6
         jumhal46A7PghMds+bHpj2yYiNgOyOo9OhdQC1OJyF3tlL1cnS1b5X424mCo3TxXiNKB
         GKV5/lrj8OZP9MW2sCxDJFxqm6d8O1PjZG0DEzEmHXX9K3IxMtaU8v4QMfeteS2ppC6W
         9OpA==
X-Gm-Message-State: AOJu0Yw2LuShNYozs8dPJOXjtKMzaG3bVfFYP5RbqW2rAdRwyPL17o+w
        1BIgaRTKP/Twnz5LiY0pi2qyPPfkbnDuYvu2ni8UV68AIcfsBiESMMI=
X-Google-Smtp-Source: AGHT+IHaJe8TVI8OD48JzqiIz2fgcaPOPkTxwV3k9ta7dUaBVJiSwzwwTaqTlLeLEY/v/DqmQCJAEEnkVBsSvzdrZo0=
X-Received: by 2002:a25:2409:0:b0:d71:8729:23b8 with SMTP id
 k9-20020a252409000000b00d71872923b8mr11479439ybk.13.1694509828307; Tue, 12
 Sep 2023 02:10:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230911-scouring-squash-3ef2cc8b1ee2@spud>
In-Reply-To: <20230911-scouring-squash-3ef2cc8b1ee2@spud>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Sep 2023 11:09:51 +0200
Message-ID: <CAPDyKFqB_2KiqYy1Li1sGkXPiEAnc2GOUO7SdqCxy5G+YkeLcA@mail.gmail.com>
Subject: Re: Missed soc/genpd PR for 6.6 mw
To:     Conor Dooley <conor@kernel.org>
Cc:     arnd@arndb.de,
        Changhuang Liang <changhuang.liang@starfivetech.com>,
        Walker Chen <walker.chen@starfivetech.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh@kernel.org>,
        Jia Jie Ho <jiajie.ho@starfivetech.com>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 12 Sept 2023 at 00:11, Conor Dooley <conor@kernel.org> wrote:
>
> Hey all,
>
> So I've been informed that I made a hames of things and forgot to send
> my soc driver PR for the 6.6 merge window. There's not too much in my
> branch
> https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/log/?h=riscv-soc-for-next
> so I would've kicked the can to 6.7, but the majority of changes there were
> made to the starfive pmu driver that has since moved to the new genpd
> subsystem.
>
> Sending a PR to Arnd for 6.7 with the pmu bits & based on v6.5-rc1 doesn't
> seem to make all that much sense to me, since that stuff is no longer in
> drivers/soc, but rebasing on top of v6.6-rc1 would make these genpd changes,
> with a different path to Linus.
>
> What's the best way to rectify me screwing this up? Should I split out
> the non genpd patch and send a PR for that for the genpd tree for 6.7?

Yep, that seems like the best option.

If you think it's better to re-post the re-based genpd patches, I can
certainly pick them up from the mailing lists too.

Kind regards
Uffe
