Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555573118C3
	for <lists+linux-pm@lfdr.de>; Sat,  6 Feb 2021 03:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhBFCp1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Feb 2021 21:45:27 -0500
Received: from condef-02.nifty.com ([202.248.20.67]:32514 "EHLO
        condef-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbhBFClX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2021 21:41:23 -0500
X-Greylist: delayed 502 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Feb 2021 21:41:18 EST
Received: from conssluserg-06.nifty.com ([10.126.8.85])by condef-02.nifty.com with ESMTP id 1160sDqm007252;
        Sat, 6 Feb 2021 09:54:13 +0900
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 1160r6ML013051;
        Sat, 6 Feb 2021 09:53:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 1160r6ML013051
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1612572787;
        bh=GPySi5FWUUgt3Nf/zevYzreQ14QCHC7dq4Gj7Iu6PdM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KzoShgNcKgDb7aRIUtJmJ1rx2FCzGlFX5m421RSg8KaR+ZHU8DcZFfkcqCpImJ9Se
         20oACGiCEzq35ncdGVLdFr6G1HYhyWy3yG5j/x9hhHGP5NxMYVrw8h5YL8Obo6YLgf
         0JL+92QeKSoxYEWm/F+wV2qZUWoO7N4oDG5iKl1+/QwFmgAkEuLBfJn6y9tjzrDebn
         CkTvpcRmcekx+4ZSrH5eVn29+qe268TkYo2LZ43I6TRxiQJVDMNn33AogXk8F6sYKx
         vh58eyX+5U0MuKjD6MMyeih7AS0CJ0J0dJLiYuJsou+U3K8BZAAhnwrtxQ+ZftcYw/
         XzdXCJifY0GFQ==
X-Nifty-SrcIP: [209.85.216.47]
Received: by mail-pj1-f47.google.com with SMTP id nm1so4543652pjb.3;
        Fri, 05 Feb 2021 16:53:06 -0800 (PST)
X-Gm-Message-State: AOAM530vi38FgUq3BStni3+djPmsdCkMkd75APd+ouP2CUqitGa9qRye
        8vhfsDS++evyT1BiAfd2zU/jnAdQ25D8Yun4xHI=
X-Google-Smtp-Source: ABdhPJy2iadLfW+f/QGkcC2eqfoUOehXlU0LObloB/V5zjeO+YCzFrx6L4Mi1lzQVdV+RNvC/ncuPB1ZZ0t1rSii5I8=
X-Received: by 2002:a17:902:bb87:b029:e1:d1f:2736 with SMTP id
 m7-20020a170902bb87b02900e10d1f2736mr6360693pls.1.1612572786057; Fri, 05 Feb
 2021 16:53:06 -0800 (PST)
MIME-Version: 1.0
References: <1612518255-23052-1-git-send-email-yangyicong@hisilicon.com>
 <1612518255-23052-5-git-send-email-yangyicong@hisilicon.com> <YB0VxBrYM3BSoxrc@kroah.com>
In-Reply-To: <YB0VxBrYM3BSoxrc@kroah.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 6 Feb 2021 09:52:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQoUZYxswxT9zkq=G_2A4tdkhkedMyQhj8eHkBeqz7+Lw@mail.gmail.com>
Message-ID: <CAK7LNAQoUZYxswxT9zkq=G_2A4tdkhkedMyQhj8eHkBeqz7+Lw@mail.gmail.com>
Subject: Re: [PATCH 4/4] staging: comedi: Use subdir-ccflags-* to inherit
 debug flag
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Yicong Yang <yangyicong@hisilicon.com>, jdelvare@suse.com,
        Guenter Roeck <linux@roeck-us.net>, giometti@enneenne.com,
        Ian Abbott <abbotti@mev.co.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>, kw@linux.com,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, devel@driverdev.osuosl.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>, linuxarm@openeuler.org,
        prime.zeng@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 5, 2021 at 6:54 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Feb 05, 2021 at 05:44:15PM +0800, Yicong Yang wrote:
> > From: Junhao He <hejunhao2@hisilicon.com>
> >
> > Use subdir-ccflags-* instead of ccflags-* to inherit the debug
> > settings from Kconfig when traversing subdirectories.
>
> Again, explain _why_.
>
> Please read the section entitled "The canonical patch format" in the
> kernel file, Documentation/SubmittingPatches for what a proper changelog
> should look like.
>
> thanks,
>
> greg k-h


I think this is a good clean-up,
assuming CONFIG_COMEDI_DEBUG intends to
give the DEBUG flag to all source files
under drivers/staging/comedi/.



-- 
Best Regards
Masahiro Yamada
