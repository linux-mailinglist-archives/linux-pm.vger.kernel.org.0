Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1163629E1
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 21:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404716AbfGHTsj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jul 2019 15:48:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36866 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403978AbfGHTsj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jul 2019 15:48:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id 19so8104449pfa.4
        for <linux-pm@vger.kernel.org>; Mon, 08 Jul 2019 12:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=512KKBgMVMKz7gfdhR+61KZQfqeAp9wKriOTY9W/m3g=;
        b=nk4eEHvRWL+iwbjHPfzWA2bwFqOrjBs/6yoeYW+T0NWwpl+A+LyelGf8yDtREXYMio
         84fax2cP6HZeBOMtboM2Xa/oEIkR9MBe+CAPVg2QbhSDzy80Me+qVd1K3oI9HCD+s8UJ
         9SWMbbUAlxJTRz5Mxwskro4e0wga/BTHth49pxcvyLY6GYFI428FRcLgLE3sQpefXbmK
         vjLyJ66VmjUVXwxeDV/jjCvTA1AOXTClMeKsGIv8pKXNL/nD2ztpl3g9XgYLd0fYrpp5
         VNatAwhFZyEHPKDHa3TWIchiUQXetJuH2TJgfFEhO2axpxWxq49xtFQz5sRojzhF3qj6
         NjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=512KKBgMVMKz7gfdhR+61KZQfqeAp9wKriOTY9W/m3g=;
        b=QiNaYRbBlVJfs1VCIApjaNsZWVYV7bpRG9vMT2TCE96nFIiYUYOIhVYlJyZNTybkkc
         S++UVaoQl9LMHBoThncGWt9NslnnHvcvP0zw39Uq5HNqs2BOJ6I4QQdujAGgyB1tNd7y
         Jzyi+Gyv7NWPu0TuoluHYTp9mw5kOMt3VdNUkFAv24t6R4W/v8gHVe09896dnPMiwnaz
         Ip2W+WNDaJ+ph39SO+rx6e3QEyQRxDMEBmEwxjvrXnsYcaj3rDSafonk7kr/aaNNNL5s
         xVkGZ03AGvMdPMjSal6IbcSBtFIAdNFruIaG+MTEPm4UvhSf/F9BnIYGyHNWdHqQDNdC
         EcKQ==
X-Gm-Message-State: APjAAAX55012mHHoRQaWThr+2NdOqzD1bLxMKbz8oZ8Y9jODdzHkkS24
        fQyOgmkLaF3pTekNaBMqmBmqJk2e4E1yuXelx3A99ftzYIo=
X-Google-Smtp-Source: APXvYqz3kepxoBnI/20kBYgZAH+SX9+WDVqBbCry27iyABWVXc/qd1sTgk2tbuotlRG3aQYul41xMTsgJY8n1MhcaPM=
X-Received: by 2002:a63:6eca:: with SMTP id j193mr25415263pgc.74.1562615318771;
 Mon, 08 Jul 2019 12:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190708173156.30902-1-prarit@redhat.com>
In-Reply-To: <20190708173156.30902-1-prarit@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Jul 2019 22:48:27 +0300
Message-ID: <CAHp75VfFh4gv2gk=Sumsfbtd_eM5qF5kQLdfmpVU7VXug9jxng@mail.gmail.com>
Subject: Re: [PATCH] tools/power/x86/intel-speed-select: Add .gitignore file
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Arcari <darcari@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 8, 2019 at 8:32 PM Prarit Bhargava <prarit@redhat.com> wrote:
>
> Andy, could you please add this patch to Srinivas' intel-speed-select
> patchset?

Please, sent it as usual and I will add it.
The series can't be modified anymore (it's published).


>
> Thanks,
>
> P.
> ---8<---
>
> Add a .gitignore file for build include/ and final binary.
>
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
