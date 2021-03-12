Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA92333961C
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 19:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhCLSS7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 13:18:59 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:41807 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbhCLSSs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 13:18:48 -0500
Received: by mail-oi1-f169.google.com with SMTP id y131so24881457oia.8
        for <linux-pm@vger.kernel.org>; Fri, 12 Mar 2021 10:18:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+QLxzXMRF6FUEMf4KzHfLvgy/WINAIfsEEwU4VHF9kc=;
        b=FxHlUiMqiWX2cwdSEq8XD34XpL2jkHiFTMQXf7kbpmVAVW5ITrj6dyY8s6NDeV1g0r
         bhlRBOCImWkPhA0EPFmYONWFS2A/DoQ3+py1Bkwh52fnG0I57d4Il083RitQlX9DGu9a
         E7rLQEsCWrreShkpcQkhBbaBLsgQ87/rXsmmnaYDCx57aSarJd5fFUP0DbpF01yPKjNO
         GY/P8VZWJK6SRG4N9XpLMgmk4KbpP5unWYQCPB8d2/zNAXyzvTX4RGx5irRxFXjIfJU0
         oaDk2fUd2ZBwGSvFzSvAEdCNlgpsUZHaGhTQkltwHSzaB0iA4A1B4rcD8sGzYQkRibxQ
         FNEQ==
X-Gm-Message-State: AOAM532Qgy6SUcfTi12gCbgnJ9sdnez9O/0dEpmMINwihWaZcn8rh8+r
        hx0UN0LTp/Pir2MMMMyQUP/46g1vE97KKzyjiVNu8OnN
X-Google-Smtp-Source: ABdhPJykTefLnrqoLuzIaNQDLEsn56jr1Ba7BQ127NNbf+8C3tnotG1CioWMjBJPE03iqtNH+RCg1lMpGA9cgCfZ2Wk=
X-Received: by 2002:aca:3d85:: with SMTP id k127mr11070501oia.157.1615573127634;
 Fri, 12 Mar 2021 10:18:47 -0800 (PST)
MIME-Version: 1.0
References: <20210312042019.wpn64ic5y7jjrrwd@vireshk-i7>
In-Reply-To: <20210312042019.wpn64ic5y7jjrrwd@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 12 Mar 2021 19:18:36 +0100
Message-ID: <CAJZ5v0gKWESoH0O1yXVA1WoBgJs4aLkU9mkk7KSqUGhOxcF8Gg@mail.gmail.com>
Subject: Re: [GIT PULL] OPP fixes for 5.12-rc3
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 12, 2021 at 5:20 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request contains a single patch to fix OPP refcount issue noticed by
> Beata.
>
> Thanks.
>
> --
> Viresh
>
> -------------------------8<-------------------------
>
> The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:
>
>   Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next
>
> for you to fetch changes up to 606a5d4227e4610399c61086ac55c46068a90b03:
>
>   opp: Don't drop extra references to OPPs accidentally (2021-03-12 09:26:52 +0530)
>

Pulled, thanks!
