Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03CC723F296
	for <lists+linux-pm@lfdr.de>; Fri,  7 Aug 2020 20:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgHGSNG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Aug 2020 14:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgHGSNE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Aug 2020 14:13:04 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEA2C061756
        for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2020 11:13:04 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id v12so3137429ljc.10
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2020 11:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=leE2Cykz74amz3n8V90szIGU70TUJ9qpRsnnAIasBxc=;
        b=OE21AsDR2Yh6e0J4PH/Q+90anBoRnVpEvcC9LHTVLEhVlelx2/tMuGFoZc8H74JmJS
         eKPlUr5Uc1yPRnpAjlcOvrk1np+0uO3nFHparP3JQQ4Y4kd6yA0K7mz/vAGLs74kexZE
         D0+tNGggLXYbsXpwvjejbKohWdZs0q0GDu5lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=leE2Cykz74amz3n8V90szIGU70TUJ9qpRsnnAIasBxc=;
        b=aVNcSPeG9FM6uRqdi4tdhhpLlOX3cmk7Z2yIVYGv0LyQzXwvxr4QPApndU8TjAQLMM
         CiCbYnO4r1itjHIxflqNilD8XAFLDRnSn4Pzpa5SyQoXq5DwbRTH6+hGIs8qHUmGLndf
         YKQ3ZL1oFPw4F9ixi/blF5UR5+xFMiBk1Q7NZtjLWXNyvKHpcTA8JOqbOISo0G/G7xp+
         fK0uvOs9FLHFwvsMGYIy5npTGQv3/o50wfk949WezrDWCfGEcWYwH0yp6+X7qBSPqMBB
         ZYc9lcljPaRpj5rBipqX4ty7HC5EWfGkrR5Hnb/CWv7w1ErBEteB4CEXwxNc0toS7QGp
         +jjw==
X-Gm-Message-State: AOAM531qh530F3uoE87s9mDJHCfHLPvD4/HdHurYEV6Z5sxgiCIL1X+Y
        f2Im+28ezz/srtV/sHM28m941cva2ck=
X-Google-Smtp-Source: ABdhPJzNUcbdBT8ncbR0WqcZbJNK3hgoAabgH94tfo+VL3mfq//m4X5lQ2Vu/nWnql6ljrJ6K1/OWw==
X-Received: by 2002:a2e:8e9a:: with SMTP id z26mr6363888ljk.271.1596823981910;
        Fri, 07 Aug 2020 11:13:01 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id g24sm4089220ljl.139.2020.08.07.11.12.59
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 11:13:00 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id t23so3165862ljc.3
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2020 11:12:59 -0700 (PDT)
X-Received: by 2002:a2e:9a11:: with SMTP id o17mr6645875lji.314.1596823979484;
 Fri, 07 Aug 2020 11:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <db1dc155-0c7c-f4eb-7fa6-047a78829a82@linaro.org>
 <CAHk-=wgLt61owJ_eKwy43bBujxy3-s=xQXwsSi6VHME7SiAgiA@mail.gmail.com>
 <b903cdd8-cbb5-1a6a-3943-9bb019f1eed7@linaro.org> <CAHk-=wgSJwbghhQYCoAVq6ewGKZ+rZvxeKvxb-o_gMt7d7-Nbw@mail.gmail.com>
 <88678a80-4ca2-5cb0-d9c5-3e64b7f113f5@linaro.org>
In-Reply-To: <88678a80-4ca2-5cb0-d9c5-3e64b7f113f5@linaro.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Aug 2020 11:12:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=whe9+soLhAtO2hctL4PgnnG67BGHpSPSyxTLAe0c2zqmQ@mail.gmail.com>
Message-ID: <CAHk-=whe9+soLhAtO2hctL4PgnnG67BGHpSPSyxTLAe0c2zqmQ@mail.gmail.com>
Subject: Re: [GIT PULL] RESEND: thermal for v5.9-rc1
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Colin King <colin.king@canonical.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Lukasz Luba <Lukasz.Luba@arm.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Henry Yen <henry.yen@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Marian-Cristian Rotariu 
        <marian-cristian.rotariu.rb@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 7, 2020 at 11:06 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Ok, I will send a fix.

I ended up doing it during my morning routine of looking around for,
and applying, random patches.

So it's commit 0f5d0a4c01cc ("thermal: don't make THERMAL_NETLINK
'default y'") in my tree now.

                 Linus
