Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D0B344722
	for <lists+linux-pm@lfdr.de>; Mon, 22 Mar 2021 15:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhCVO3A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Mar 2021 10:29:00 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:34656 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbhCVO2l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Mar 2021 10:28:41 -0400
Received: by mail-ot1-f50.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so16121031otn.1
        for <linux-pm@vger.kernel.org>; Mon, 22 Mar 2021 07:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4VBPAX2cbeRw+FSmOobVDwYnlj86TmWNP5IqvaTOlfU=;
        b=e2bJYGl1t3sjzYDmVbicXgqlDXjazcdZCaPFn87zmM14Q6ITFcjw7ArwfqvWqFmA/t
         PFWUl52hszOZinPI+gRAVyRxRi456SizQEm/E26Tny3A1Vp5hxjea2q6ufbWY1yee90d
         zkrY1GZihfTp4q3T29TKhY17FupPpSBvZBlYS0siInw3VETpUz/OAP6ecMgIb8/qfUFP
         rzD46YLHxPKhGsrI3pBbTBIG+tpt3mJ8mE3MweWKxLnVg43AjWvvfhe0ko1m0IPcuL8+
         HTRfDrwzaI6gQNAClH8ou+2m3P4qgBOI0ZjqoUPolU6tB7OxZ8i6OgR6uAhP1+fZWzRf
         /B3Q==
X-Gm-Message-State: AOAM532y/vFQq92iP2XxAhzs5TTog5sJ613FtBon5bXbGpOV5tnREj5F
        y9X+JNSiTHaYK1e+RFfyuqXEJwWNJUo9c6poZ5a+qzKp
X-Google-Smtp-Source: ABdhPJwsDC7sjQLbfkvh84CRMx3norqSlrVQGDu12SgDpystdOYVA/STmvQlzy2TZ+YZkdhDaBjvbP3AJAZg1+Flib8=
X-Received: by 2002:a05:6830:20d2:: with SMTP id z18mr204423otq.260.1616423321269;
 Mon, 22 Mar 2021 07:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210318202223.164873-1-ribalda@chromium.org> <20210318202223.164873-9-ribalda@chromium.org>
In-Reply-To: <20210318202223.164873-9-ribalda@chromium.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 22 Mar 2021 15:28:26 +0100
Message-ID: <CAJZ5v0jsPi6A9CnZL533YugZVGa_kW+_pr2dY6EAQtAu0ZFp_Q@mail.gmail.com>
Subject: Re: [PATCH 9/9] pm-graph: Fix typo "accesible"
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Jiri Kosina <trivial@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 18, 2021 at 9:23 PM Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Trivial fix.
>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  tools/power/pm-graph/sleepgraph.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-graph/sleepgraph.py
> index 81f4b8abbdf7..ffd50953a024 100755
> --- a/tools/power/pm-graph/sleepgraph.py
> +++ b/tools/power/pm-graph/sleepgraph.py
> @@ -6819,7 +6819,7 @@ if __name__ == '__main__':
>                         sysvals.outdir = val
>                         sysvals.notestrun = True
>                         if(os.path.isdir(val) == False):
> -                               doError('%s is not accesible' % val)
> +                               doError('%s is not accessible' % val)
>                 elif(arg == '-filter'):
>                         try:
>                                 val = next(args)
> --

Applied as 5.13 material, thanks!
