Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8B73572F5
	for <lists+linux-pm@lfdr.de>; Wed,  7 Apr 2021 19:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347872AbhDGRTx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Apr 2021 13:19:53 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:39517 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347825AbhDGRTw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Apr 2021 13:19:52 -0400
Received: by mail-oi1-f178.google.com with SMTP id i81so19509867oif.6;
        Wed, 07 Apr 2021 10:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fkgm8HAgL/Gal4L28d+A7F24+oEWebbCO/PFXp5cWhQ=;
        b=Oyb1flSSBsDMza0Cba+SSjHWLu4Fs0fqYsGACQErimUw5JxeMx2l0Ysyao+p5Ftabh
         MY+VI5Z4X3TkorFCarrHYiINpIGx6xoXg99SQk9nnkWiBrHDpKLZWQztgSQifvRoopgP
         5JP/Y6wf6ncW4lfqr+94szOOiBl9cd6Y/B3gaiJ4QroMr/t42Z+7esDIKMJQAvjVNi25
         EFSw88TU6dQv/0Lvi9Ua7kJLhP8hF9tsu6Ob4RT8dYoYuaLORi1NmKj8ITckK5el8GZ+
         wJw6WkcqShcQxUmFJxmEhdDfD1E0/YE49EM2sXYc6GZwJE0cDeoGzVGQv7mnk0WxSW4y
         Kxww==
X-Gm-Message-State: AOAM532XTKZGLtu+fpSuWnOKlTWvlC/R4lZ7mG5CWmWouei4nY5v/Leq
        wGWrQcaHEKtjCpN+mPvnc5gn1MEHzPGD/nzpgX4=
X-Google-Smtp-Source: ABdhPJxt8u8Tjz8h2lok5NThS4zt0oc6H4V2sQd1IfhMrpLhLYGtLeBhl0aaFt30aSSEWLkYoktWSnwx1nJYj9Kdnvo=
X-Received: by 2002:aca:5fc3:: with SMTP id t186mr2906295oib.69.1617815980877;
 Wed, 07 Apr 2021 10:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210324072912.737621-1-wanjiabing@vivo.com>
In-Reply-To: <20210324072912.737621-1-wanjiabing@vivo.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 7 Apr 2021 19:19:29 +0200
Message-ID: <CAJZ5v0h8Zsq0W2Cxx4ufkbejbisJJUcv8gSkE8jzLsnmT2ADKA@mail.gmail.com>
Subject: Re: [PATCH] include: linux: pm: Remove duplicate declaration
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kael_w@yeah.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 24, 2021 at 8:30 AM Wan Jiabing <wanjiabing@vivo.com> wrote:
>
> struct device is declared twice.So remove the duplicate.
>
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  include/linux/pm.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 482313a8ccfc..c9657408fee1 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -39,7 +39,6 @@ static inline void pm_vt_switch_unregister(struct device *dev)
>   * Device power management
>   */
>
> -struct device;
>
>  #ifdef CONFIG_PM
>  extern const char power_group_name[];          /* = "power" */
> --

Applied as 5.13 material, thanks!
