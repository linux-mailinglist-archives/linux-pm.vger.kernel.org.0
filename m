Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E052114784
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 20:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbfLETMG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 14:12:06 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43136 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLETMF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 14:12:05 -0500
Received: by mail-oi1-f196.google.com with SMTP id x14so235065oic.10
        for <linux-pm@vger.kernel.org>; Thu, 05 Dec 2019 11:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lbTgn4jNgsokf2M6goUMgel36hy0BJM0Dor775D7GSE=;
        b=KqaiLT61/XGnqIJhyHQusP4pG9VwXR+bKLFriLrHG7+eWANmbvM2tv0SS0gLxwZVAU
         nsmUBgaji2JlUcHgiQDOK6v3RPwyLG7HmyQ+b7bBZfvD03vCB90Ym/p77Py1195ubD4M
         Lzkwqu6taOKa4HIz7qyRUfhUcEEHsEUfVmZfOoE73SX7H04DnFOSEw1+af0sto1/idf7
         z1UqhwrzFEfVZKYMRDIEFScrL5o6Fzw5U8b842jXc6f6vNOSDmB0HYWzOBuJawEHmebm
         NViX2VGHk77eRYN+46e8IBzsNFnxcFC2VEtgC0sYd5mbWZqrXldmWhSitZUJej3nXAdd
         kHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lbTgn4jNgsokf2M6goUMgel36hy0BJM0Dor775D7GSE=;
        b=Y9Q+8n6UZOm6wmG2Uxg/idW7+z7OW4kNXwrASNW62Icga88Ze9yP1Js+WkgOw3seuJ
         roDM/1FIqVIPcpMTjruROBKkci0zdscDfgUaYP+UMUway/2CF2jXIbRq15vlBL6g5kJo
         VujgeGppouJGw/LEFTSU0rM2TxrE/itorB6tFlNA9kJI/ysf9N+Dv/OO5Dcgfg4IDKc5
         bAKqT68wqPsebRrDPpuu7jNg/1k8iv3VgBBs1ucieVEen1KBrGnqU0tkEweTyrzerr7h
         kfOjeB1VzTa8IS2FghmN+SsFOvxBqp+HjVK3sOWCOgUzC7z2X2kk4X8zec8G14cynWNo
         xlBg==
X-Gm-Message-State: APjAAAUG2oJP454lYjQi9RarzpH4YVs6MfvcBSksrd5ZRmGujY8HlKVO
        gtgyZkT5zo9AkqHW1rmeF0p2hChgHaA5Y+aeG3DKHg==
X-Google-Smtp-Source: APXvYqwO24mcZkmRu8n96LRippWIZh/qu1VArRKN8KHPM7/mkUlrnXW//GsNTA2ZsMEsxE5rDQ505XtmyKjgLo6mZSc=
X-Received: by 2002:aca:503:: with SMTP id 3mr2990513oif.24.1575573124553;
 Thu, 05 Dec 2019 11:12:04 -0800 (PST)
MIME-Version: 1.0
References: <20190717222340.137578-1-saravanak@google.com> <20190717222340.137578-4-saravanak@google.com>
 <20191125112812.26jk5hsdwqfnofc2@vireshk-i7> <20191125112952.uwrmeukppkqu4hvm@vireshk-i7>
In-Reply-To: <20191125112952.uwrmeukppkqu4hvm@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 5 Dec 2019 11:11:28 -0800
Message-ID: <CAGETcx_uohJknvW8pDb6XXBkZveFqMvt5wRyecV5sye5a8vLpQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] OPP: Improve require-opps linking
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 25, 2019 at 3:29 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 25-11-19, 16:58, Viresh Kumar wrote:
> > Message-Id: <8df083ca64d82ff57f778689271cc1be75aa99c4.1574681211.git.viresh.kumar@linaro.org>
> > From: Viresh Kumar <viresh.kumar@linaro.org>
> > Date: Mon, 25 Nov 2019 13:57:58 +0530
> > Subject: [PATCH] opp: Allow lazy-linking of required-opps
>
> Forgot to mention that this is based of pm/linux-next + following series
>
> https://lore.kernel.org/lkml/befccaf76d647f30e03c115ed7a096ebd5384ecd.1574074666.git.viresh.kumar@linaro.org/

Thanks Viresh. Is there a git I can pull a branch that has your lazy
linking patch series and whatever dependencies it has?

-Saravana
