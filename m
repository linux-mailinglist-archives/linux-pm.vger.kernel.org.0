Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F56214A105
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2020 10:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbgA0JmY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jan 2020 04:42:24 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43775 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbgA0JmY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jan 2020 04:42:24 -0500
Received: by mail-oi1-f193.google.com with SMTP id p125so6026221oif.10
        for <linux-pm@vger.kernel.org>; Mon, 27 Jan 2020 01:42:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1YS0X1wBdYQn1m6vmhFAGPjx0NFQYz0XFsgZxeXRo9k=;
        b=HWK1Wc1a3TxAtukc430njNJX60CIpVHs82syCO59YrAXsCmu1/FVLel+ndKO7qWbk5
         0BSmhZzbDQr+tEUiRrXWZQMn1aXrryvk4o7Q9ARg2DSBmoUpwzh418D0UzXS5Vjb/nZv
         rgbnob/AXaBNKkzMZ8+vu5/uOhi9BDarjSouTyneJT2kRt+rPaDOO6SH45P4L4TbLCt0
         hXnWYTmZA9amk9rznZ88JjL9LJgDYVfJLjjIaAE/68sh78Ax+p6GrW+ZlaNtNu/HFhMv
         d0z/5kcQAT8fFxGdbRn5Y0G6dDcZ2YiE0rD0aXyzokc7YqGGrrweqkdrWEU4xTOi4iNR
         FPTQ==
X-Gm-Message-State: APjAAAWPToIa6gKE/ulBefKU3Ccf1pKeK6/GnChSx/tvmUfONwT6jSN8
        pUirnmuwtRWDBC9L+9y4Os2yX/WmstkPsAp4WGI=
X-Google-Smtp-Source: APXvYqyXUKeuqK9t+DKR52selPFGdM8fve9nX7ZXlMM1f2pcU1AWgRgx7WOg2250bf6Mae4APXT0Ny/ZkxrNWpprnhM=
X-Received: by 2002:a54:4e96:: with SMTP id c22mr7052019oiy.110.1580118143661;
 Mon, 27 Jan 2020 01:42:23 -0800 (PST)
MIME-Version: 1.0
References: <20200127064347.npuud5gblrm7iyyi@vireshk-i7>
In-Reply-To: <20200127064347.npuud5gblrm7iyyi@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Jan 2020 10:42:12 +0100
Message-ID: <CAJZ5v0hZyaG5Oy_vWa4tsY=SuuRt5S8gdeijafpY5y78CEqMJg@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm changes for 5.6
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 27, 2020 at 7:43 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request contains:
>
> - update to imx cpufreq driver to add support for i.MX8MP platform.
>
> - Blacklists few NVIDIA socs from cpufreq-dt-platdev layer.
>
> - Convert few platform drivers to use
>   devm_platform_ioremap_resource().
>
> - Fixed refcount imbalance in few drivers.
>
> --
> viresh
>
> -------------------------8<-------------------------
>
> The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:
>
>   Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next
>
> for you to fetch changes up to a48ac1c9f294e1a9b692d9458de6e6b58da8b07d:
>
>   cpufreq: brcmstb-avs: fix imbalance of cpufreq policy refcount (2020-01-20 13:23:34 +0530)

Pulled, thanks!
