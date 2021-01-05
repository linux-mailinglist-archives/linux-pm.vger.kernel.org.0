Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE532EA19A
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jan 2021 01:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbhAEAsP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Jan 2021 19:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbhAEAsN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jan 2021 19:48:13 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D95C061796;
        Mon,  4 Jan 2021 16:47:33 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id x20so68746981lfe.12;
        Mon, 04 Jan 2021 16:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=LbJgq5BqlhcAKKUuFodkRpsTucTQHhzOBEK4gO821Bo=;
        b=COrfHp/+heOjspVaVTZbnxYjzbzUFe09lWQ9a49kTJC4UQvnyfme/5tFIbM6l3aZCZ
         TVuZvg/wmmzU4OiTCBsFMiJKlPct+rWnIpLkN/2GTEu5HSorCW6QYT9/MIpgNdrzBY9B
         xF4ELoMXQK+CKZMzxFVoLAWZf0C6t8qPn1sqBCHt6r8hS4E9+Ml25nAUYhu6vSbGQBCx
         HU/l8YqfGyT8j9MoGlZDLt2P1NvK180j2m7M6Bzd/sqf4bRKteRwbHC9+mowUtMKRkjs
         WIdmu61I5ipKxzYVzzSDgvlztlDiGM8wJL8LgTEzUcMXYsCK2rQkf+omo/m5XIwbHSJw
         sWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=LbJgq5BqlhcAKKUuFodkRpsTucTQHhzOBEK4gO821Bo=;
        b=pMmnbEFlyyRU9Y7m0s5dMtR1aWQVllEDg26R5vgYf59HMUgnResQfC5N75StCDx8Qq
         nEyKuaa2Tav2jDBMaKyfjAy91Q7M1b9UK/j1VxMTr/us58ky0hto6KNDZTh/Z+Iyya0J
         4DwqxMLpQh5Mza77OEAXJcOy4NDODln4cUiAJw72swgxiXPVKmchs/h9nZLg/X6Hj4PD
         Wn7PeAybcuxVH1eZa1Stu4IIgRK5ikJZyTJ3JK6ye9FT6CvsSoJEuaIaIWGMdQIl6oxA
         qAWu7qnV4aDm0dEDND2j2CMyyT1syssPsv+ooFSzEryTBKhc5c0VXDQM8c7pbVZCVOpy
         A+JA==
X-Gm-Message-State: AOAM532Z0MGrlnyqinJPFi1U4b41tGKbteQF2EhjAhYv+uzIbay5+L9/
        S9xP0Aylt8+2tMFXOGVAorGHRomYlp9UfRkaqNXcQqo3DLs=
X-Google-Smtp-Source: ABdhPJwsKBgmYJWYbFIIxdmIRXJF/zK+FsyQxCRrJGVep9xL3skCukBiryHnEnE9a2ZFA3ZkN6HRcA4IogEXX0JBxLc=
X-Received: by 2002:a05:6512:789:: with SMTP id x9mr31112231lfr.487.1609807651799;
 Mon, 04 Jan 2021 16:47:31 -0800 (PST)
MIME-Version: 1.0
References: <20210104135912.8185-1-lukasz.luba@arm.com>
In-Reply-To: <20210104135912.8185-1-lukasz.luba@arm.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Tue, 5 Jan 2021 09:46:55 +0900
Message-ID: <CAGTfZH0eG_gKPfzW-xCrMK7MwraGkxygocEKH1TDVurp3ZGXVQ@mail.gmail.com>
Subject: Re: [PATCH] PM / devfreq: spelling correction in a comment
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz,

On Mon, Jan 4, 2021 at 11:01 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> The device attribute exposed in sysfs is called 'polling_interval'. Align
> the comment.
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
> Hi Chanwoo,
>
> While grepping the devfreq polling_interval sources I've found
> this trivial mistake in the comment.
>
> Regards,
> Lukasz
>
>  drivers/devfreq/governor.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
> index 2a52f97b542d..70f44b3ca42e 100644
> --- a/drivers/devfreq/governor.h
> +++ b/drivers/devfreq/governor.h
> @@ -40,7 +40,7 @@
>  /*
>   * Definition of governor attribute flags except for common sysfs attributes
>   * - DEVFREQ_GOV_ATTR_POLLING_INTERVAL
> - *   : Indicate polling_interal sysfs attribute
> + *   : Indicate polling_interval sysfs attribute
>   * - DEVFREQ_GOV_ATTR_TIMER
>   *   : Indicate timer sysfs attribute
>   */
> --
> 2.17.1
>

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
