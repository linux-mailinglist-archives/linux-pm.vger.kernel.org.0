Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D43443A3F
	for <lists+linux-pm@lfdr.de>; Wed,  3 Nov 2021 01:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhKCAKP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Nov 2021 20:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbhKCAKP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Nov 2021 20:10:15 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666A0C061203
        for <linux-pm@vger.kernel.org>; Tue,  2 Nov 2021 17:07:39 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id f3so1673995lfu.12
        for <linux-pm@vger.kernel.org>; Tue, 02 Nov 2021 17:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pTPaTBnI3uTKahtUXWpwKrD7YLY0qqSnFOplkZZDwHo=;
        b=GWoIAF5+7S75wVjiD4B+y2LUrJSa2rebj6DdjV9vt4snLgE1AZLikSmqjhgqM83btm
         +V/ImMuGAxqWsLF/+//yPy7HanwrOoUCoCMHtxzEpz0KHFfeAKAhji1HokhBSgMWtXcD
         pGG7rNUZzWBGJ9ozwiFBAgLcWS0iSidSDFbjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pTPaTBnI3uTKahtUXWpwKrD7YLY0qqSnFOplkZZDwHo=;
        b=AC+LmxHqv+v/cn7yPSfvnxZWkxLMPVLwJ8jrwhQLgKsMVdyV+3syVnX9IVezMyefi1
         PKXZzb+VDHO0VWxpo5Q4gUYx4C/EJW0ohVMSQWPyAuZW+ETxS4anuvb2aXWctoZ+VH1R
         cYW0rR78bO+J/oYJNoZieL2PVAWPnLTMB9SKuHzNoZ55oSKDdZkpqkWUW9ItDTAEeLjU
         Yie48/zyXlOxN2/wsoZh5IvWtg9Ybl4pJmmH/QKrgpeE/2SNkkDBhf7PQgLvxVCynoGM
         sINrVXmq+N9oPeKklDuvobwJFCh992bnRA9NOjJBZaBJOiNmGNk1DD+2eS15zm5FbPK8
         AhVQ==
X-Gm-Message-State: AOAM532O53Et5qMv1KyVIZHeFdHmKn3VJ2aT66DCYQ7/LM4XaDiN4+dY
        K/7b5d+2Vj6Ue55RBfTuwAn21BvX03hSdKxH
X-Google-Smtp-Source: ABdhPJyoOD1CQXETMNTF5LeJyWcjrVYyNcdvPdUkRcCcfjeREuRGLusE8b1dsGxS1Ep/8ZqlOZGFRg==
X-Received: by 2002:a05:6512:987:: with SMTP id w7mr37617441lft.556.1635898057286;
        Tue, 02 Nov 2021 17:07:37 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id h14sm34159lfv.83.2021.11.02.17.07.36
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 17:07:36 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id h11so948888ljk.1
        for <linux-pm@vger.kernel.org>; Tue, 02 Nov 2021 17:07:36 -0700 (PDT)
X-Received: by 2002:a2e:a7d3:: with SMTP id x19mr14555294ljp.68.1635898055944;
 Tue, 02 Nov 2021 17:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0hnj0zCXsZy0=Ukud3U_cn054GULmHmpz7Qrpg_TkLLqA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hnj0zCXsZy0=Ukud3U_cn054GULmHmpz7Qrpg_TkLLqA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Nov 2021 17:07:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wijOKZNA0Ahd0fNDDa8pc6abv9wUHbxBf8giOeERHkW0g@mail.gmail.com>
Message-ID: <CAHk-=wijOKZNA0Ahd0fNDDa8pc6abv9wUHbxBf8giOeERHkW0g@mail.gmail.com>
Subject: Re: [GIT PULL] Thermal control updates for v5.16-rc1
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 2, 2021 at 12:55 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> Daniel Lezcano (3):
>       thermal/core: Make the userspace governor deprecated

This one is very annoying indeed.

How about making that "pr_warn()" be a "pr_warn_once()"?

Because I don't see the point of

    dmesg  | grep "Userspace governor deprecated" | wc -l
    19

almost immediately after boot.

              Linus
