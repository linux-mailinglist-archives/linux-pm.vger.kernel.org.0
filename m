Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 948EF63986
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2019 18:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbfGIQjr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jul 2019 12:39:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40118 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfGIQjr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jul 2019 12:39:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so9723486pgj.7
        for <linux-pm@vger.kernel.org>; Tue, 09 Jul 2019 09:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=woBNlKk4Hh5lTjjA6Hp5rYNnMie/ehvrqBILCc4HbHw=;
        b=AkS1SWf/ja/lzwQa5bQOkbPPXloIfx9NVEeEuosbf1HVIkDYRwBITVuPGAhJ8vskJm
         AImpmwHQP6zzYSvz0kxH8auXZv9ze7yKsvPWsXESVOjb83rpjwx+aZAmEcQgK2MyQPIB
         iO2/nTJTgVM5Hd97uPHaQNFdeZ68kemofmv3UhVcWCDC0uO4YDeYq5tnT8ep5UmdH19n
         1ylA4IHWK/004PmITkufSLYtemLvh4A3We4+6pBjGX7W/joUOC6uwgBTaWDGqRHiLmCW
         lshgmVfRbM/lEAR4tKP/ouMSQlm8IlPXSfh34AlQCW7EzeXs2o/cocADZyXg/CvOD/vw
         kukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=woBNlKk4Hh5lTjjA6Hp5rYNnMie/ehvrqBILCc4HbHw=;
        b=dzhU9oJqGO0vQOA74m8bBMuhM2aEZ1ir0qOmxwy/Y4qGSxMJakNpuwBw/EWtOICCz6
         XVVOKIeH10IiyO1pBtzPnX0N2vA7rTSN3l4211mcmOIPdqm+ISs8biSJoHVfVDrFh9al
         aUH3bas6nXPX3MuGZMv+9sqeUogEKYLSMgNzxp75C8g19kiGZq3GqLf3ZJCsqwy/+Pus
         CA6JNX7CPXwas5IIZk3x59Gccg0hJUlwkwUNHcexO8zQkZuKMNT7HzBdqyNq+Px4Iz6e
         MgXnlw+FfPcRWVTRFaNWeuCiCZrGiHyuuTYcgROWbE6Jp6V6VDCmXNW8x6uPYi9sDDdy
         k5RQ==
X-Gm-Message-State: APjAAAVwWwHq3CBIKF40bbZ7/ju+fEwZbeOhshLZth0ZDPYUyb0trU2D
        3Kbc7g9PKbTO/q3DMe4RuyJaVcXC64HsWVxgSK8=
X-Google-Smtp-Source: APXvYqzxKwtLMR+oTbyexFqD369LiAZ7Cj9qONAvKcfvW4z5inBX8218qnB2nN9G1C9W3Ezs8jc1nqUl3hDnURjZbPU=
X-Received: by 2002:a63:f346:: with SMTP id t6mr32675055pgj.203.1562690386707;
 Tue, 09 Jul 2019 09:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190708231725.11353-1-prarit@redhat.com>
In-Reply-To: <20190708231725.11353-1-prarit@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 Jul 2019 19:39:35 +0300
Message-ID: <CAHp75VeyUK_ohxPwTg988gXugRh=y5QxT1zhSCmKoG5-CutRnQ@mail.gmail.com>
Subject: Re: [PATCH v2] tools/power/x86/intel-speed-select: Add .gitignore file
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Arcari <darcari@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 9, 2019 at 2:17 AM Prarit Bhargava <prarit@redhat.com> wrote:
>
> Add a .gitignore file for build include/ and final binary.
>

It has improper Cc list (No PDx86, no its maintainers, no LKML, which
is also requirement to send patches to PDx86).
Please, gather the tags you got and send v2 with properly formed Cc list.

> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: David Arcari <darcari@redhat.com>
> ---
>  tools/power/x86/intel-speed-select/.gitignore | 2 ++
>  1 file changed, 2 insertions(+)
>  create mode 100644 tools/power/x86/intel-speed-select/.gitignore
>
> diff --git a/tools/power/x86/intel-speed-select/.gitignore b/tools/power/x86/intel-speed-select/.gitignore
> new file mode 100644
> index 000000000000..f61145925ce9
> --- /dev/null
> +++ b/tools/power/x86/intel-speed-select/.gitignore
> @@ -0,0 +1,2 @@
> +include/
> +intel-speed-select
> --
> 2.21.0
>


-- 
With Best Regards,
Andy Shevchenko
