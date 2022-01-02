Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F6C482A50
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jan 2022 07:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbiABGoL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Jan 2022 01:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbiABGoL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Jan 2022 01:44:11 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26CCC061574
        for <linux-pm@vger.kernel.org>; Sat,  1 Jan 2022 22:44:10 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id q8so35406868ljp.9
        for <linux-pm@vger.kernel.org>; Sat, 01 Jan 2022 22:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hBaWxbtCPSIrnNlIsbfh2h4Tv6caCN36fG0hhG2CIl8=;
        b=LKWp+IYCyLW4ZX96eGz/dV09zm/C4GQJD6VrQPa0poZqvUtqjlgw3StfoK3yDymwMa
         ZKx2yg8V7f0vO85X6DNIfkZaJq54KDLElws6cxTxN7TIgdcDzTkWw+k7UOyKnk1dkVrd
         b2WdYZdZjyRaYDdMg0on/B/yIfCKbfV58tx4OL1mMsUyZJ/hr8pcHkPlQzLaHAu/PCCl
         OWFX+Jb4z43XV2ckzxKf3Z3a7W9iex+wqSmuObiUXdUIxQ4kMQlN72ILXxi0uAAQSrXX
         n2P1trawr3hvy+1mayya9jySsrk7jXR+3wyWtQG6MHcEOjz9zg4m4siEhyx1ffGpX7AN
         1I+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hBaWxbtCPSIrnNlIsbfh2h4Tv6caCN36fG0hhG2CIl8=;
        b=pfqgARcdZlU7/jWIoo455RasEcbUabcw2zHNZdut8fcOyy16mYEAhv6yTDb+Z3nAFq
         Iqpx36zdOE05y04cgCWslu3D34gM17kl5g86Q7f/4RhnTIHFHi2E20FpUbYfziTp58H2
         /xLifFxvQ7HvEFMOgaWy5Ifqy3gFt/OO3Ar1NLqBH8mgUWSaMhLTkGfpRYOR5bNgYTsn
         rqwEF70RMM2C30mU6sloHCRNkQxhzepHRenpyaqExUx+nMp9zcQZsCk0y0laq1aGJy2c
         OO77tf73RSu9hcKHb4pRcFHO0QHtlrM2W64ak3FIIYyA6LyLsY3d2Usxcxbj4g72yn/b
         fkCg==
X-Gm-Message-State: AOAM530+hKOcbLp1HjLzVOF6AMGOsnjmjowoNtXQ+gXNI1QEnFawaXaH
        ovlBW0qLLzKS6fY1LBcACNmZ8SvUxOD1g8duLmX4o0A8OR4=
X-Google-Smtp-Source: ABdhPJyXo+R0z+uJrO92Rt1Mnb4iQGwk2XG4mkcsGblvjFALPbeSf7AIV8rwEKDL3J5LKtcXrVr0+Yg+wPnrsuqFwyw=
X-Received: by 2002:a2e:3a07:: with SMTP id h7mr30066567lja.478.1641105849036;
 Sat, 01 Jan 2022 22:44:09 -0800 (PST)
MIME-Version: 1.0
References: <24a8b7e7b7b8f9f4b8eaad6707f420d55fd10aac.1640722789.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <24a8b7e7b7b8f9f4b8eaad6707f420d55fd10aac.1640722789.git.christophe.jaillet@wanadoo.fr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jan 2022 07:43:55 +0100
Message-ID: <CACRpkdbTo2Xp9EUWPHjGafLRTh_9Vt54VoJ8fwDsbBukai3+Fw@mail.gmail.com>
Subject: Re: [PATCH] power: supply: ab8500: Fix the error handling path of ab8500_charger_probe()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 28, 2021 at 9:43 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:

> Since the commit below, ab8500_bm_of_remove() needs to be called after a
> successful ab8500_bm_of_probe() call.
> This commit has only updated the remove function.
>
> Fix the error handling path of the probe the same way.
>
> Fixes: 6252c706cdb0 ("power: supply: ab8500: Standardize operating temperature")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Nice catch,
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
