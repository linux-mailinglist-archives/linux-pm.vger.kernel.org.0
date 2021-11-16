Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FA145330F
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 14:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236810AbhKPNpp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 08:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236805AbhKPNpg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Nov 2021 08:45:36 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F218C061764
        for <linux-pm@vger.kernel.org>; Tue, 16 Nov 2021 05:42:39 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id g91-20020a9d12e4000000b0055ae68cfc3dso33529543otg.9
        for <linux-pm@vger.kernel.org>; Tue, 16 Nov 2021 05:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xFfJHhRZIlLYKrIYfTgaafjwjSJ3a79IaKfU78a0reo=;
        b=EtLFUCUp99nlDc4mfV/+ZpKBrcMWJVDBYlDgf9XxH13TNrKlZzQq4mdaaqkHTkuhzR
         sATLuO/yQ4TGbut/fV2KUyNrPVkPf6b3GM3068J4+bS4kaQDW9NrhGdul9y9rlA8yxFm
         yTzQSeOelPcuSWHOFdFoTGk/sUAnJmYs2Ynuvv9McPVTUoLzmgJkTiUeJaAi44EnzhBE
         0C9NvhhmYT94ISGw2Arzx51sgeWV/a3RH10poUff4mc1GCZ/qEr0j2w6qWo8lsAJr3dY
         alz96x4QotRnMmYB+NGe50Md1PMYbvB7S3+GMY+Ie1ERXfUNSAXl7nhamD6ShTViRX+s
         nFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xFfJHhRZIlLYKrIYfTgaafjwjSJ3a79IaKfU78a0reo=;
        b=jBPB9odbushWk+cUtSC2tPw2ascMI0dP/TcANq9+GE0RCL1Uwb1i1eOuqm8yD9Qo74
         94q3aFJaJz2vgY3DNczopq6zsUHeVGlyObz9/GYI5Sf6y/ju14cSDA+7L/lYhUbUeF0o
         d4E3WfN1RdTUp/whPDX+QZFloAtS9iJqDZGM4taBsUEKsLVWfH14Iob6JCvXN+adrYce
         qpzsIgUhWl0EbHVP4FX/Z3iDfPh0Kdm3fqdzyZlagtMfA9LLBkgF8/9WUvo94OILF/so
         uFpeFwVj7A8P6uHoF/BAz+vag3ZYjJF0qEep2WOhKsa8GfT9ad/E1TrjNxeAjzXOzAvk
         NAHw==
X-Gm-Message-State: AOAM531T1G3cQ/2+C1lKlGz/gw5uMXmvBQJ3Jxa7rE+ihQjedpANE1fp
        TGSgs0yHHBsKTs+k8XjAVim2gP7IVV0RR56ORV1cFA==
X-Google-Smtp-Source: ABdhPJxXInsP/FJy1qHETUXJ7gUb4FF+bfxkMBY1i3J+GfcQMaQd7N0N3Bmf/5VS5XNIvw3dWtn5hQSnROhRwXq49DY=
X-Received: by 2002:a9d:ed6:: with SMTP id 80mr6027570otj.35.1637070158510;
 Tue, 16 Nov 2021 05:42:38 -0800 (PST)
MIME-Version: 1.0
References: <20211116001755.2132036-1-linus.walleij@linaro.org> <bbaa93fe-8a10-7c80-2b5d-c36b0968429f@fi.rohmeurope.com>
In-Reply-To: <bbaa93fe-8a10-7c80-2b5d-c36b0968429f@fi.rohmeurope.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 Nov 2021 14:42:26 +0100
Message-ID: <CACRpkdYNe8cMo016ZCtgnOLs2b5JzHXUB34KkNR_dzBRZQh8nA@mail.gmail.com>
Subject: Re: [PATCH v3] power: supply: core: Add kerneldoc to battery struct
To:     "Vaittinen, Matti" <matti.vaittinen@fi.rohmeurope.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 16, 2021 at 7:21 AM Vaittinen, Matti
<Matti.Vaittinen@fi.rohmeurope.com> wrote:

> > This is done to first establish semantics before I can
> > add more charging methods by breaking out the CC/CV parameters
> > to its own struct.
>
> Just a request... This sounds like you're having some bigger changes
> coming in? Are the changes visible anywhere?

Yup, see:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git/log/?h=ux500-href-charging-v5.16-rc1

The first change to add something is actually this:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git/commit/?h=ux500-href-charging-v5.16-rc1&id=45bdb4c543320803606f0e74dc47ebec1e88dc53

here I add a table to interpolate the temperature from an NTC
resistance to struct power_supply_battery_info.

> I'd be interested in seeing what you're planning :) I've had a
> fuel-gauge RFC series sitting in my own git (for a long time) waiting
> for me to get it more extensively tested (and waiting for me to learn
> how things are handled in user-space. Funny that waiting has not
> increased my knowledge :rolleyes:).

Apart from this I want to add:
maintainance charging A and B so essentially two voltage+current
levels after CV charging has finished, each with a safety timer so
2 * 3 new properties to struct power_supply_battery_info.
But I haven't coded it yet.

(I am officially on parental leave so this is all getting coded while my son
is sleeping.)

> It was just yesterday I dug it up and rebased it onto 5.16-rc1 for a
> re-spin. I'd like to see how it fits into what you have on mind :) I
> might give my simple-gauge series a go as RFCv3 later today.

OK I'll give it a look!

Yours,
Linus Walleij
