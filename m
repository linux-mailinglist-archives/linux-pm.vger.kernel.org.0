Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F2435C6BD
	for <lists+linux-pm@lfdr.de>; Mon, 12 Apr 2021 14:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239439AbhDLMw1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Apr 2021 08:52:27 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:41484 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239364AbhDLMw1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Apr 2021 08:52:27 -0400
Received: by mail-oi1-f173.google.com with SMTP id x77so3907204oix.8
        for <linux-pm@vger.kernel.org>; Mon, 12 Apr 2021 05:52:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xpo3TckKaHNiDw3wSyXZBpsmO26WwZJti6++Tk062Es=;
        b=YeV5Ngj+JiTxm13EDiiQU1Bk+1Ae89N8vmZ/Qks8NADGJcvVAvuEf76voB37LT53rS
         +tzqZa+9V2rtAPpLFtbKophvj96ysALtRLg3hs46AHJ+Wt5PMqoNzZazetpknrMomETi
         VXJDxt8yRx2eKmA8VhqujQiHt9uvDCP5kHdrjYRuJuNNX5/i/ebXW5/DSEcjScCT3vgW
         IJvaJ6XMVvK6QNwFUxWw8udCZo/P+0QM0y3PUOZZ3y6zXJH+wCS7N222ESKIiYZzOTra
         K0IKpo86gwGL12tEJ2DOxnDphzIyVQ8pwPgebjtEeK3kI9YzEneS2i2L2mm8d3wc6w24
         xGYQ==
X-Gm-Message-State: AOAM532gNkYbQJ5IellWX198Kc2v5T3Q+8lZwi8VmtT8aIAyiyqbItVl
        wRgIDkONLkPw4qstHg5MNLcW12BjkVxp5ys+TM47dKH9
X-Google-Smtp-Source: ABdhPJxy8gEausERpUaiSNXq/pRezPXMN4iBPaVku4nfse6EFUy+u4/yp1JuEy3gNbrlbr/bfgySAEnwrF7vo/lIen8=
X-Received: by 2002:aca:5fc3:: with SMTP id t186mr18611491oib.69.1618231929033;
 Mon, 12 Apr 2021 05:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210412055219.zt47pkorhxbnsg5z@vireshk-i7>
In-Reply-To: <20210412055219.zt47pkorhxbnsg5z@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Apr 2021 14:51:53 +0200
Message-ID: <CAJZ5v0jcOVOfGN658q62uZ4AUgq74M9SrCO3iF+CrQkVBF-XuQ@mail.gmail.com>
Subject: Re: [GIT PULL] OPP updates for 5.13
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Apr 12, 2021 at 7:52 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request adds devm variants for OPP APIs, and updates few of the users
> as well (Yangtao Li and Dmitry Osipenko).
>
> Thanks.
>
> --
> Viresh
>
> -------------------------8<-------------------------
>
> The following changes since commit 606a5d4227e4610399c61086ac55c46068a90b03:
>
>   opp: Don't drop extra references to OPPs accidentally (2021-03-12 09:26:52 +0530)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next
>
> for you to fetch changes up to a8bb0e872bfb962de4653ce8f8723c0e1f712ce3:
>
>   memory: samsung: exynos5422-dmc: Convert to use resource-managed OPP API (2021-03-25 14:38:48 +0530)

Pulled, thanks!
