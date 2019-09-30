Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B43DC1D0E
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 10:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbfI3IWc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 04:22:32 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39775 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfI3IWc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Sep 2019 04:22:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id v17so11628110wml.4
        for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2019 01:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=ShSdTe5Qp8z7m+jUtvQKDuCvb0VtDo609FCfYvndEno=;
        b=exPnKZEYefJsNZMJjFnNmAXEv7dbG77oiHob/ywzmo4aeZfj7pFMylI2JIvFMtFjgz
         B0Ww5uxtxnbhyX3kcs03yySNcCTd2yQp9hgO5sZPs+M1dBZRpgnUz0HuKuoFHAyzNdAT
         Ay/W7zajAfCPVhaes66qjL57Qa8KBqYrGfmMm8viotFX+RiSbbh1Wh7h/S635yvrnk1X
         inAQ83q/tdXfSyKb8MedQCC2lK2kaCriTxVwcMqt/XG0ceO3g6NjOLaKS9Ao1MsGaQhv
         dwEwQHnevgCD3DOW4dRIx6XbE7NRex1y67oDlTVh4sDKiBaZJ6Mgm/WoPiNbYCId9AQs
         JXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=ShSdTe5Qp8z7m+jUtvQKDuCvb0VtDo609FCfYvndEno=;
        b=MAfnA+QwIxMb8gclcEbnAfLNrZlVtf4EIvdrQJFva76/+GXWl0LKU4hSygJiMElSbS
         LCffNeObJsQ5ASFxRnOvZ7+QoQ4roMa0Bpau69y7JVOTWIcz7uO2/4z0wf8dap4UIoUc
         L46OQ4l6K80vEBdWlgYAVqZPHuMwJXLIDz1i53M3qwVrmrBugJK8fJNnPuXBiHrrzQ0/
         t0UaUK3ijJX8C8tLZLlxq9Qp1tOuCbjCXbYqj8+/IS+yF9vvI/UFJiwlcOidnninStxY
         GAeHx2uszY5UabSOTnWqnZci0hux7vDlgY34jS315DkK8ZsAjsXWYxgqBQU6FD6hcSl3
         BI5g==
X-Gm-Message-State: APjAAAUhtVMZKn+ZXhysdmNK/xFyeraba83Ob9ADw8gMalchmmHT9yxO
        oY78yIDuy3Zg4v3ZCMjHGDu2ErjQJ8A=
X-Google-Smtp-Source: APXvYqyIM0BrCVvOADyXCOsoNjMjmm0DeuCYw4kWcFR08dZvDMjsgIDwDmqsdt3YFbfjPrmhjktI9A==
X-Received: by 2002:a1c:cbcc:: with SMTP id b195mr17236045wmg.80.1569831749974;
        Mon, 30 Sep 2019 01:22:29 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l11sm14198165wmh.34.2019.09.30.01.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 01:22:29 -0700 (PDT)
References: <20190925213528.21515-1-khilman@kernel.org> <20190925213528.21515-3-khilman@kernel.org> <8936e777-8996-5c7b-ea9d-8e17c8d6c4b1@baylibre.com> <7hwodulvu6.fsf@baylibre.com> <21eafa69-fe26-2df1-d187-cddfe5b37951@baylibre.com>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] soc: amlogic: ee-pwrc: ensure driver state maches HW state
In-reply-to: <21eafa69-fe26-2df1-d187-cddfe5b37951@baylibre.com>
Date:   Mon, 30 Sep 2019 10:22:28 +0200
Message-ID: <1jd0fi19dn.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Fri 27 Sep 2019 at 08:37, Neil Armstrong <narmstrong@baylibre.com> wrote:

> On 26/09/2019 21:08, Kevin Hilman wrote:
>> Neil Armstrong <narmstrong@baylibre.com> writes:
>> 
>>> On 25/09/2019 23:35, Kevin Hilman wrote:
>>>> From: Kevin Hilman <khilman@baylibre.com>
>>>>
>>>> During init, ensure that the driver on/off state as well as clock and
>>>> reset state matches the hardware state.  Do this by always calling the
>>>> drivers 'on' function, and then callling the 'off' function if the
>>>> HW state was initially detected as off.
>> 
>> [...]
>> 
>>> I don't see what you are trying to solve except simplifying the code.
>> 
>> Simplifying the code is a worthwhile goal on its own, but that's not the
>> only thing I'm tring to accomplish.
>
> I still find it ugly to power_on a domain to power it off right afterwards.
> The issue is with the CCF enable handling which is not in sync with the
> HW, if you boot with an already enabled clock, it won't be marked enabled
> in CCF, and it's clearly bad when you want to have a fine-tuned gate state
> handling.
>

CCF should disable unused clock so, in theory, you should not have to
call enable() then disable() to get things in sync.

I suppose the clock in question has the flag CLK_IGNORE_UNUSED (one of
the gates) ?

If the CLK_INGORE_UNUSED is becoming a problem, it would be better to
fix the clock tree rather than adding quirks in consumers.
