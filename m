Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74A2518A2F9
	for <lists+linux-pm@lfdr.de>; Wed, 18 Mar 2020 20:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgCRTLU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Mar 2020 15:11:20 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41833 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgCRTLU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Mar 2020 15:11:20 -0400
Received: by mail-ot1-f65.google.com with SMTP id s15so26749922otq.8
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2020 12:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YEcNvKoxRLNncmofEeVv4yeDWdrbk4dUuTY3/HM5SJg=;
        b=lkxzxSmPoiFVrjW+D44Nlzoy7Y9BTyZ6PQpCllGw154b100MP5WuWaOD8/idtKRdN1
         eW54dVH6b4J85Yh7iKi6bJJfbSelvRDFyXBx3wyvx0oFFus1AOlmctj2Z5JvbyIEHHUZ
         /Jr09tDhinfXqXBq2oebzgol6mVeYcC+UyXyTHDzlp5RJD7V8dU38+VbiMAZuPGG6YF9
         hvBVYwDFqmUd6ydHL8N8g88fq/GSAzaTFW8j6JuF/V3UyExsBxHJS4eMrACrNI4o5nLl
         sC+7J1xx3mn9ikCZuhxsvKAh6qOSY243TaGZYevQ1VsO2EVhb25BOP3Gwdm7RCayZFKz
         QIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YEcNvKoxRLNncmofEeVv4yeDWdrbk4dUuTY3/HM5SJg=;
        b=iKlXLZSxM/Sfg2Ux8b0eJxt2YWPEfsE62wMtpUJ96tn6EYWULVm0HuQ5Yi4lu16NDF
         yXRKOwU2+TTFR6tuJrYXmoRL+V4w6yYZURMdQ4ull6WYkifkehfmlzpSWiqd0AjeEPYt
         ZDmHEYuU+yIu3EyAkQ2UdSbWsICQAWRpAf2peXmYfRsaUtGsA6wAKQ3y+QDPT+egUCDb
         mSRxX8s+/+gH8JW9+ge4ru46aqQiCQrB8cxf+n7Q3MIlncuQYQe9FSIhnmPQTIuDZ7So
         NpkvwSKwEkX+oDyrQYMqVVLP6cPhgaqnSFsElVPINiH7icuap6a2zsxkBJIxQUFtEOXV
         n6UQ==
X-Gm-Message-State: ANhLgQ0aGolWPBoTeFeDcdnJe+bUNvYVC7AUnyU80+fONErc0HSMiFNM
        ANhYacqqQ24aJfyPK1IxBTS17w88ULCIbMKZ4Zym1Q==
X-Google-Smtp-Source: ADFU+vuQqQyKYY3GzReouxvk6jJyqQUm+Irep1pzseE+uxctbZi52pzI8VMFuxyNWh599gkbGFQoVDq1JwgQY4XyDz8=
X-Received: by 2002:a9d:6186:: with SMTP id g6mr5088006otk.236.1584558679434;
 Wed, 18 Mar 2020 12:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200317065452.236670-1-saravanak@google.com>
In-Reply-To: <20200317065452.236670-1-saravanak@google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 18 Mar 2020 12:10:43 -0700
Message-ID: <CAGETcx-uZ3YJHCYqFm3so8-woTvL3SSDY2deNonthTetcE+mXQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] Fix device links functional breakage in 4.19.99
To:     stable <stable@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 16, 2020 at 11:54 PM Saravana Kannan <saravanak@google.com> wrote:
>
> As mentioned in an earlier email thread [1], 4.19.99 broke the ability
> to create stateful and stateless device links between the same set of
> devices when it pulled in a valid bug fix [2]. While the fix was valid,
> it removes a functionality that was present before the bug fix.
>
> This patch series attempts to fix that by pulling in more patches from
> upstream. I've just done compilation testing so far. But wanted to send
> out a v1 to see if this patch list was acceptable before I fixed up the
> commit text format to match what's needed for stable mailing list.
>
> Some of the patches are new functionality, but for a first pass, it was
> easier to pull these in than try and fix the conflicts. If these patches
> are okay to pull into stable, then all I need to do is fix the commit
> text.

I took a closer look at all the patches. Everyone of them is a bug fix
except Patch 4/6. But Patch 4/6 is a fairly minimal change and I think
it's easier/cleaner to just pick it up too instead of trying to
resolve merge conflicts in the stable branch.

1/6 - Fixes what appears to be a memory leak bug in upstream.
2/6 - Fixes error in initial state of the device link if it's created
under some circumstances.
3/6 - Fixes a ref count bug in upstream. Looks like it can lead to memory leaks?
4/6 - Adds a minor feature to kick off a probe attempt of a consumer
5/6 - Fixes the break in functionality that happened in 4.19.99
6/6 - Fixes bug in 5/6 (upstream bug)

Greg

Do these patches look okay for you to pull into 4.19 stable? If so,
please let me know if you need me to send v2 with commit fix up.

The only fix up needed is to these patches at this point is changing
"(cherry picked from commit ...)" with "[ Upstream commit ... ]". The
SHAs themselves are the correct SHAs from upstream.

Thanks,
Saravana
