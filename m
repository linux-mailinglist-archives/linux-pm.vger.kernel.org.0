Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD9FD14A104
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2020 10:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbgA0Jl5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jan 2020 04:41:57 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:32868 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbgA0Jl5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jan 2020 04:41:57 -0500
Received: by mail-ot1-f67.google.com with SMTP id b18so7773073otp.0
        for <linux-pm@vger.kernel.org>; Mon, 27 Jan 2020 01:41:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gLJaYu9bZweKG6WznEIjdwWl0C9Vk8ADsn0kX8joTDQ=;
        b=SwM24gxtLk8+FZbR4Wzm2j6LjK0GSfIgasEINpqpHVYJ/IEEiQKaIc4zu+hifxLABR
         tSfi3xQoYboV7gtAMTx9ndc9LoaJbCbls36YujzikqVh2IhU3PdyuwrGY3lYNyfO/Wdu
         fxLebcdWb4dHcxjB+OIIjYGa0VLFbmxoz6pCXeX2AwI7Zr8ysCTL5A5XXus1mkrVwn94
         M/1IPv9+xvh3P6gbm0hP1QZD0m+3mhiHATwkIizQrduJRBDKOjZkpgkqh82hSPPwE73v
         4yJMtGGId+u+cncT718F6gOsfNkW2wBj6KrvpGhT2Jc+yQSdNa1h2PQBzrLYITM0cGcl
         +Y8Q==
X-Gm-Message-State: APjAAAXhgLe7FRiHLNd4vyJS3SoQAzmfMSlgIAmsplU3M2UZlANc+SE6
        RP0rB95ZtX7Hi1a5ka2pTxDa/jaoUZ4dipeoXZQQcw==
X-Google-Smtp-Source: APXvYqymdBaBS1AQadQv2ZAUkdzLDWaEhWyn1S+3lXnBvBQ68jB/hQpbya2FVxzYQCe8gbGrmet3KktFbulrXKcfqR4=
X-Received: by 2002:a05:6830:1651:: with SMTP id h17mr11231109otr.167.1580118116817;
 Mon, 27 Jan 2020 01:41:56 -0800 (PST)
MIME-Version: 1.0
References: <20200127062052.hbu3ubh6budlirm4@vireshk-i7>
In-Reply-To: <20200127062052.hbu3ubh6budlirm4@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Jan 2020 10:41:46 +0100
Message-ID: <CAJZ5v0irwgrkU+PpAtee9GL9uTBnPE-Lf1gJM-CNcqzuoM9cuw@mail.gmail.com>
Subject: Re: [GIT PULL] OPP changes for 5.6
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 27, 2020 at 7:20 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request contains a single patchset to fix reference counting
> of OPP table structures.
>
> --
> viresh
>
> -------------------------8<-------------------------
> The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:
>
>   Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next
>
> for you to fetch changes up to 03758d60265c773e1d06d436b99ee338f2ac55d6:
>
>   opp: Replace list_kref with a local counter (2019-12-10 15:57:00 +0530)

Pulled, thanks!
