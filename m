Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6DB304841
	for <lists+linux-pm@lfdr.de>; Tue, 26 Jan 2021 20:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbhAZFrM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jan 2021 00:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbhAYJUO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jan 2021 04:20:14 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10D9C061226
        for <linux-pm@vger.kernel.org>; Mon, 25 Jan 2021 01:05:55 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id e22so25026115iog.6
        for <linux-pm@vger.kernel.org>; Mon, 25 Jan 2021 01:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RFuyLVDtLc2EnagVSKSkkI4AlK/6//a9pOD3OMIzloQ=;
        b=GLVyI0q6znNhqi8+MqGgiRP5fsoGuSyn5AbGuY7457oyjwEqRG6RAvKYC9nbcHMASg
         +zCpjWKjNu8RfFvWsMEYBG7IZ5CV5jbNFn513XcbWCMMKmPJd+H5MQOPYXtY6qpG+3j+
         yJKBbZCfFt41zjxXcK75AQddTsT/giaXXln3kj5KwLZwY7DURz5M81H/Y2us28P0gZSq
         y///2ds14ad3SvRRhutzRt7tSzVCpzTc2OuWtycVD9m+duezXXejBqC184aOxRADYCbC
         xwRllcpO6hey/di2ED+7r2r/F2+4BsmZS8E8QVqTcRW8hiNfQRe6Su3efAjPDj9Vfr2k
         thNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RFuyLVDtLc2EnagVSKSkkI4AlK/6//a9pOD3OMIzloQ=;
        b=pWtd1TeF5wEokcOKwBaIuqFLko1ibgB6UYqZFZ1dFoYGpwlCqX443kswg2AP/uCqnR
         injN1hA1AUv5AZnTj2HE3fO2mNnJROhGL1wGrO5X86LiWSwnCWV+KuRa6teZC+6O+ePK
         ixKX0wtrdTJt7H3tOIQr/9IAy4ExoFGscbv/gSNMJUta4RHYX/O23c4E+2WW3d43QtRJ
         NccfllnaltmIhXlZHEI9epnuzTXbNq99E6eT4jozAMZCrViEep2lKq7yGBVL2RdKbpCN
         E5SR93uA+w027+A0NdHnWkYMAR5UQck/cm6OYFLPvckOfKoRnAShaGgIhV+sytkyzhIz
         39Cw==
X-Gm-Message-State: AOAM5301Kv/A1ryAbSg3AmTY58tVMdlvyqWZC+shYsmi9L9QWaG4GPHX
        cvRVgSCXNoWTN295slpgMVFe2rfpkjviJrX1DQ==
X-Google-Smtp-Source: ABdhPJw8ZNa4ohJxH0wqszaylWODHKxvu1kldTfxOHIcL9s+D/JjRjyY/r/lWsWN0Dxl1brzZM1O5nQrtMuKU+CAUKw=
X-Received: by 2002:a05:6e02:c2d:: with SMTP id q13mr158779ilg.83.1611565555089;
 Mon, 25 Jan 2021 01:05:55 -0800 (PST)
MIME-Version: 1.0
References: <20210122074214.26583-1-bhe@redhat.com>
In-Reply-To: <20210122074214.26583-1-bhe@redhat.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Mon, 25 Jan 2021 17:05:44 +0800
Message-ID: <CAFgQCTuvh40hOUKS1MLnuUm_14JeKUg_c1rncAFmd1bRXML0xA@mail.gmail.com>
Subject: Re: [PATCH] kernel/kexec: remove the lock operation of system_transition_mutex
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-pm@vger.kernel.org,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 22, 2021 at 3:42 PM Baoquan He <bhe@redhat.com> wrote:
>
> Function kernel_kexec() is called with lock system_transition_mutex held
> in reboot system call. While inside kernel_kexec(), it will acquire
> system_transition_mutex agin. This will lead to dead lock.
>
> The dead lock should be easily triggered, it hasn't caused any failure
> report just because the feature 'kexec jump' is almost not used by anyone
> as far as I know. An inquiry can be made about who is using 'kexec jump'
> and where it's used. Before that, let's simply remove the lock operation
> inside CONFIG_KEXEC_JUMP ifdeffery scope.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: Pingfan Liu <kernelfans@gmail.com>
> ---
>  kernel/kexec_core.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 80905e5aa8ae..a0b6780740c8 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1134,7 +1134,6 @@ int kernel_kexec(void)
>
>  #ifdef CONFIG_KEXEC_JUMP
>         if (kexec_image->preserve_context) {
> -               lock_system_sleep();
>                 pm_prepare_console();
>                 error = freeze_processes();
>                 if (error) {
> @@ -1197,7 +1196,6 @@ int kernel_kexec(void)
>                 thaw_processes();
>   Restore_console:
>                 pm_restore_console();
> -               unlock_system_sleep();
>         }
>  #endif
>
> --
> 2.17.2
>
Reviewed-by: Pingfan Liu <kernelfans@gmail.com>
