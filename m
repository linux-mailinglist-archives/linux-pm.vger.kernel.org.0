Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584FC4369BD
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 19:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhJURvm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 13:51:42 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:46866 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbhJURvm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Oct 2021 13:51:42 -0400
Received: by mail-oi1-f177.google.com with SMTP id o204so1789235oih.13
        for <linux-pm@vger.kernel.org>; Thu, 21 Oct 2021 10:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rt+lNr6KqOUDY+4CYIAbS4cHVc/frOb5ip5H9wqkfOs=;
        b=TFuxKGaEUmwGNttIIzorXRtRUK4gtxM/ipHjQpjUJqC2nNUJcTibCSreLcowmWpoNH
         s0Cs4sLz7aicrqhSu/tMA6festJmSnggfjZZ3lDZjyPHdBsrvO7ddmYrJhSDiZeFFMVW
         6FIkY72RA1Mp/TNqibd7urbSnTCU8Rs73ZmLTKi4TJ3HRFjyu0r4axwEuXhw6zTUf+5h
         h+G23W0/E7h7nW80CPh+YuJ5IGtKLbVrQH9SCjf3WBqSH6MiVrG4fx5psY0rndkpmPis
         44NfE7DmBFlnWLq0DVC+ydZv7AYAuVps81Abt07KzkMJ3jcAciqjTfEgvt+HP9KVBkkT
         3gyw==
X-Gm-Message-State: AOAM530fGu8hUXd+jNUCpq0hf/uuyVskQy+RAYafq7Mp3GFzGh0QTsyu
        n9/6HQxnfqtI78DUh5AhG0gUq5ZCgudpcU89Tfo=
X-Google-Smtp-Source: ABdhPJxk15ADYth87gTZdNlCH3QCVUaOFpL10R3iI5R3zWvOadz/8SH1xRAdzSzBG3zbTn/X4TV9IeWEYnPTT2Oei/A=
X-Received: by 2002:a05:6808:e87:: with SMTP id k7mr1878169oil.166.1634838565692;
 Thu, 21 Oct 2021 10:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <9c7709b1-c5df-a87e-d9d4-e83a749fa488@linaro.org>
In-Reply-To: <9c7709b1-c5df-a87e-d9d4-e83a749fa488@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Oct 2021 19:49:14 +0200
Message-ID: <CAJZ5v0jKStav_u0kb=MWFGRA_RKhus-ciw1hxZLnPRkARuCYYA@mail.gmail.com>
Subject: Re: [GIT PULL] dtpm for v5.16
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukasz Luba <Lukasz.Luba@arm.com>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 21, 2021 at 4:47 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> please consider the changes for v5.16 for the dtpm framework.
>
> Thanks
>
>  -- Daniel
>
>
> The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:
>
>   Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/daniel.lezcano/linux.git tags/dtpm-v5.16
>
> for you to fetch changes up to 5d8cb8db9f791252ef5b7951b6d8cc6281de60a6:
>
>   powercap/drivers/dtpm: Fix power limit initialization (2021-10-21
> 16:03:31 +0200)
>
> ----------------------------------------------------------------
> - Simplify and make the code more self-encapsulate by dealing with the
>   dtpm structure only (Daniel Lezcano)
>
> - Fix the power intialization (Daniel Lezcano)
>
> - Add the CPU load ponderation when estimating the instaneous power
>   consumption (Daniel Lezcano)

Pulled, thanks!
