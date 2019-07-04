Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6DDF5F19B
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2019 04:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfGDCur (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jul 2019 22:50:47 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]:33786 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfGDCuq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jul 2019 22:50:46 -0400
Received: by mail-qk1-f176.google.com with SMTP id r6so4542392qkc.0
        for <linux-pm@vger.kernel.org>; Wed, 03 Jul 2019 19:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S+IXxr+abpHhDDRXw42OXWi4mQf3QQjf0lYBdp2BUd0=;
        b=BoQwlPESat3vqlYl92F30Gdk5A6JE6W3KJCh84WmOtqpJRjehcewk59XzXrLi51E3n
         rKTHjjE+fIJd/Zj9h7ze07AMN/ppJqA5kwHcpCoqiFO2PNCUzZXgNwit2Esd96Ju/wND
         q2Pj05H3z6faW3QrzvLZXNlxXBtEolst+6xwGCk/USIEzqXCqJ2TJMwQaWfTCn88h+Te
         hmgeY3WsyEzoVNdYnCjFFEYHbjLzJRaGZru23hcEqjI/b1Af/tIZ9TGZ28N9REz2nWKJ
         2lzpww/+AeKPC4jOlINeDSsQAx2YZufZnvXx1IrvpH+gWNiinUcvyGnsQF2rZayen2PZ
         iHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S+IXxr+abpHhDDRXw42OXWi4mQf3QQjf0lYBdp2BUd0=;
        b=oj8I06xcSn+oHNeYqli780fMPkb7Eq1ynDHaElyoR72Jd5tNYfm1VE+j5HR57qv1YC
         lKuEPZ/whEDdE3265Trf3H3LnYDueXWGobp1cqKYZZzf8xXrBlDdnCMyaTmyrk+D7CK/
         wVO3pM+/r+yxRn7rWxKHMqyYZLz0VM3+9daA8aVXPL4E7q4cAvLIGY4gOigaiIiI75Jy
         5ueWjuF0IytAAuTxLF/Hu5oUwBKWL0EtN9Fij0QVFZ2YbWrlevt2GlosvQLyNNM9l0gV
         rBUR7vyaqJyNjJPImi70yukK0oNOgEiVv2haUNB8ZzBdn1d0JNkfIBhQI8B3OrF9DBzH
         Yu2Q==
X-Gm-Message-State: APjAAAUL3y2ztBrvaVqzd0XcZGlkgzNg9Axz8ijXTY1hJqL3fWO2S8tr
        hQ8PFbD2rAP4SHMIQ7jts0K2X2w/1jxhnF5GCSUeTg==
X-Google-Smtp-Source: APXvYqyO5NntceONwaRYD/j1CsLBefv6eaqnlV6TVAH2usW07ylbNLFmQkc5wyEGESam1iws4OHkacfUvpHhyVLn/GM=
X-Received: by 2002:a05:620a:1506:: with SMTP id i6mr8929202qkk.346.1562208645585;
 Wed, 03 Jul 2019 19:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <f1efad22-66a6-a094-1ebe-43e794aff6d0@linaro.org>
 <CAP245DVGekWAS1O6ZbNi52K5LyQw8vqVXM6DSBvOieAT3v1fpQ@mail.gmail.com> <8d4b31d46c5a3ee1f79eb65cbe03bc2065ce8696.camel@intel.com>
In-Reply-To: <8d4b31d46c5a3ee1f79eb65cbe03bc2065ce8696.camel@intel.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 4 Jul 2019 08:20:34 +0530
Message-ID: <CAP245DV==fQDzyE=jxq9qNNP-DG54Pd6=nqAu99nCwfNjs9ePw@mail.gmail.com>
Subject: Re: Thermal microconference proposal @ LPC
To:     "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Srinivas,

On Thu, Jul 4, 2019 at 2:15 AM Pandruvada, Srinivas
<srinivas.pandruvada@intel.com> wrote:
>
> Hi Amit,
> On Mon, 2019-06-24 at 19:22 +0530, Amit Kucheria wrote:
> > Hi all,
> >
> > We've proposed a thermal microconf at LPC again this year. I've
> > bcc'ed
> > a few people who were interested last year. We already have the
> > following topics listed for the proposal but could certainly use more
> > topics especially from the non-mobile Linux community.
> >
>
>
> Thermal/Power mitigation on high powered laptops
>
> Some of the high powered laptops released with KabyLake and later
> generations of processors can reach more than 50W with some busy
> workloads like kernel compilation. This results in CPU temperature to
> quickly reach close to the critical temperature. To avoid this OEM=E2=80=
=99s
> have used a very conservative power limits  by default. But this
> results in a bad performance on Linux laptops compared to other
> operating systems. We have implemented a solution for Linux to mitigate
> this. This quick presentation will show the approach Linux users
> particularly kernel developers can use to get a very high performance
> from these laptops.
>
> This should be a quick 5-10 min talk.

Thanks for the submission. Is this supposed to be a discussion or only
a presentation?

In any case, Rafael and Eduardo are now triaging the list of talks as MC le=
ads.

Regards,
Amit
