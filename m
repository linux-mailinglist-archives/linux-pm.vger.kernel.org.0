Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB8699A134
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2019 22:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389188AbfHVUdB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Aug 2019 16:33:01 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:34089 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389591AbfHVUdB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Aug 2019 16:33:01 -0400
Received: by mail-lj1-f177.google.com with SMTP id x18so6821950ljh.1
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2019 13:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aSnnc8KBnx7nrvm7nH0Gg3VFjqjZe9P0okjTldYJjjI=;
        b=iSYgPMbsL3t6QnFwApaGXlR0ZbuJs+IAPKIsNUEqxemsMpgbcVe6mSUpMDalbU/ynk
         SImZR6mf+Pp+jqfXBRZXecFPsJaR+boZwmg96r7FAbVkf7NIqcBXWfAbX4qtWr2PhJgp
         d12vXFDVjMQ02Zr5ssJiB1GXnyGDqa8HoXJVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aSnnc8KBnx7nrvm7nH0Gg3VFjqjZe9P0okjTldYJjjI=;
        b=OcjNbgyBK2UfsTEjIBqqui6lfDRTTIfq1mcs7/VI08tHRRtgCpLNnktRDjR/U152Yq
         wpSDMYnYYw1WvWTnoNIQHER6Dw+3kaY7kkPd0vIvyxNkoAhn8bYTtYjYqQQQYkplT1z9
         y6a6VI/aFKcWc/2YslrBJG/O47rFcYNPhHrb3BRR/tVJsCWFytsJC1Xh+rOrEcJcHXfP
         AioK6g/uOL/X0gwvrYUzcGFx1PuIfIG72sj0EcJDhKsd1p0+sTHN4zVWfuypFTauJ+8l
         bKuLk3ROdBAww+M8cY0gN8eqYT+k6JjBHjCXqVL6sNe/SxLyjHVZA9TtFaODaam3B3Xh
         /LhA==
X-Gm-Message-State: APjAAAUDvk2oh3BbXLHRnKlJSD/Dg1KnWeI9dRFtfQfEHzUFivz7QevO
        0GL0ik47tqmFZI5BoVNaSyRyzhWA5tc=
X-Google-Smtp-Source: APXvYqwZDQpT9JpWA16UbuaZtMit20wwPr2xHXSm9ZXSXCPY3xAmnBM3/e0FGDm06o0lTxQ2sZevLg==
X-Received: by 2002:a2e:1518:: with SMTP id s24mr645145ljd.205.1566505979024;
        Thu, 22 Aug 2019 13:32:59 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id r8sm114733lfc.39.2019.08.22.13.32.57
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2019 13:32:57 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id b17so5490725lff.7
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2019 13:32:57 -0700 (PDT)
X-Received: by 2002:ac2:5181:: with SMTP id u1mr561108lfi.42.1566505977561;
 Thu, 22 Aug 2019 13:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190816075842.27333-1-committed@heine.so> <20190822014655.GA165945@google.com>
 <5D5E47B1.70604@heine.so>
In-Reply-To: <5D5E47B1.70604@heine.so>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 22 Aug 2019 13:32:46 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMETzc72iZq5pN6QfySXGiHQEcsB0A5ZujSyg-YhKNBBw@mail.gmail.com>
Message-ID: <CA+ASDXMETzc72iZq5pN6QfySXGiHQEcsB0A5ZujSyg-YhKNBBw@mail.gmail.com>
Subject: Re: [PATCH] power: supply: sbs-battery: only return health when
 battery present
To:     Michael Nosthoff <committed@heine.so>
Cc:     linux-pm <linux-pm@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 22, 2019 at 12:43 AM Michael Nosthoff <committed@heine.so> wrote:
> This done at the end of 'sbs_get_property' if the presence state changed and
> no gpio is used. I suspect it triggers a readout of all the properties
> and leads to this
> endless loop?

Ah, it's not all properties IIUC, but it does lead to
power_supply_update_leds() -> power_supply_update_bat_leds() ->
power_supply_get_property(... POWER_SUPPLY_PROP_STATUS ...). That
would be enough to kick off the loop you're noticing.

Brian
