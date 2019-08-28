Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB059FDB0
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2019 10:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfH1I6B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Aug 2019 04:58:01 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46697 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfH1I6B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Aug 2019 04:58:01 -0400
Received: by mail-lj1-f196.google.com with SMTP id f9so1798596ljc.13
        for <linux-pm@vger.kernel.org>; Wed, 28 Aug 2019 01:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Dj8LmPieYY5dvTtBzhD92CL3igI6c2zFq5PFUauKgI=;
        b=XbUsoNvh9Tq1qDLPai7nTihmhWPo29i7h43cBSo1jzze4Smoe5aizmV/hOVP/kF9kF
         pi3j863knGU1vScsr+8q6JNzG6ttkK2rPNJQQEb02z2pgiG9ECQHjiUlMe3/03PqrQTU
         AKgqZcFG++gc3GzMZgfYJhWHlJUq4Asx9Tna5b+GvuZjtsoS8f1UwlmR8HedNvgv8PRR
         /iwSuyJEtTR0qxIMO4DXSUHvblx3mwDCYZGZvdyCuM20jY2VaeOG1FklD1iy44xqFCqD
         XawdTJTtTMXmcNlDecK849sGaZQ6B9bfSReJvhIXOa4DRNHskUqvZmY5wC15XUOCDHnJ
         7xTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Dj8LmPieYY5dvTtBzhD92CL3igI6c2zFq5PFUauKgI=;
        b=fTZTQNQjPCdRRIbwtrD2GxKksZQWBBtxM28fe6yWpMdW0j8qiDObyIbDDTnmZoCVlj
         4M1TGRdUvPUQsOjJhgF3tyIAKmrbA6P19/WzvHr4dlJ9fKAct2kKBR35GfQXhFMs5RiQ
         Iqxu255hWp1psct9Cd6xP2dO8YL2GMbDWVWfd2eCxQ5PfXvaV5EWotY+QX5xHByAgKVP
         Mxqs/ZLcVj5NQE7H9YcQEqNAQswOdOaf0LrJAVWMzePywG3QAruFH3Z8FqbZJ/LkSYjM
         bEclTwrZy6MW5Y1YNsg787VAi8TampXjwm6yOMdxB3vTyVtmC6+9AyvCpcoZILj0k1MI
         wxQQ==
X-Gm-Message-State: APjAAAUDl608TjXrjwWBxqszv2k+3NAMLLsc83vMFXUu1HfFDtAIsGBu
        hkPIiRfVsjVSxufca6m6DViPDzXgPjpHvH+o/qyW3g==
X-Google-Smtp-Source: APXvYqwLbeUXXeJUs7AfoZyBOvWne0rlMO+VrmYzgELwU1Ww4jlvX4rG67wzMy8K3B9AlEEUqFwTTJsNkaLsnFNHsBQ=
X-Received: by 2002:a2e:9903:: with SMTP id v3mr1425524lji.37.1566982678814;
 Wed, 28 Aug 2019 01:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190717063222.5902-1-linus.walleij@linaro.org>
 <47cb523f-60ad-750e-4374-6563f8230593@linaro.org> <CACRpkdYO7zzrUg=7=4D7XMUwoa6XQggm0jB1PtPhKK=3EV9AyQ@mail.gmail.com>
 <f683466b-a554-87c4-0bfd-4d56bd1142fe@linaro.org>
In-Reply-To: <f683466b-a554-87c4-0bfd-4d56bd1142fe@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 28 Aug 2019 10:57:47 +0200
Message-ID: <CACRpkdZ6rnV8isO4SF86jiY2E2pbR9f2OBKYQBbML53A90WCig@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: db8500: Finalize device tree conversion
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 27, 2019 at 3:54 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 27/08/2019 15:07, Linus Walleij wrote:

> > I think this is something that should be done inside the
> > driver, not by abusing the trip points, so I try to rewrite the logic
> > so that the driver fires these IRQs internally without using any
> > trip points from the thermal subsystem.
>
> In the comments, it is mentioned something is missing with the PRCMU but
> when the interface will be available, the get_temp won't have to
> interpolate. Wouldn't make sense to add the PRCMU interface instead ?

Yes. But this is a firmware that I cannot rewrite or control,
and which is preinstalled on a lot of shipped devices, so we
cannot fix it that way. It was more a suggestion for internal
development in later generations at the time :(

I have made a new 3-part patch set that fixes this up as
good as I can, will send it out!

Yours,
Linus Walleij
