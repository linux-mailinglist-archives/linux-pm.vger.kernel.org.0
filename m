Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2791D17E7
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 16:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732972AbgEMOuB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 10:50:01 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:35778 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbgEMOuA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 10:50:00 -0400
Received: by mail-ot1-f52.google.com with SMTP id k110so13605973otc.2;
        Wed, 13 May 2020 07:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SAbLyrX15xBugrHqLh1DzP9lO+IcFmGTTH9e2AAiAfE=;
        b=jYcXQOoF0Cu8lVuybGoomKrhrgs0ZOHM/5Myyw9zJJ6hitYZq0aVOl20BIlr0+i3s2
         3yxMrjUo2CT8eHBgKuJmCkEpSGAXCYx4YDX+2haWOxOeKJjMRsKU37XWrS2zf6zl8v83
         HC3QzHZemdenyoXz92xeMkMu1h+djoetJmvSlciV0kLg9/yPZA8WmYIk/UNwzL4HCk3v
         OGdY8VIeRmETlkF+ZqnHcvsnQt6cK9ps9lp1/0yh0KiclAXCWC2P1+nArNRf0YqErn9U
         AFiFyydpctPfP6Motq7O0fMRYhMru8wXXfGHOuA0k8xNazcciYS1qaoC2S0CeiJiToHv
         XXeA==
X-Gm-Message-State: AGi0PuZzGgMIF2KMJvOoY1fMKWkiIY6RbamobSNRZXUNCUzMfOIqeLFM
        pWEumSpxRLleR+cRS+UK9Oy9/wGI/Ftwup8gPOw=
X-Google-Smtp-Source: APiQypIg69c+IYHdIw/Uc0QagYnFp6R8j/4nzfZYarcmyaJHslCGTtx87TUZUMxDQftmuuwo+jaB7ub6AVOc9N1QV4A=
X-Received: by 2002:a9d:6356:: with SMTP id y22mr7737375otk.167.1589381398522;
 Wed, 13 May 2020 07:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200511141055.43029-1-psampat@linux.ibm.com> <20200511141055.43029-2-psampat@linux.ibm.com>
 <20200512173722.GM2978@hirez.programming.kicks-ass.net> <09b8bf40-e371-e1eb-d77e-6c676f22dd29@linux.ibm.com>
In-Reply-To: <09b8bf40-e371-e1eb-d77e-6c676f22dd29@linux.ibm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 May 2020 16:49:47 +0200
Message-ID: <CAJZ5v0jOGRQv1EUEhkba30OKuS8aupdoGConKJH9C=R6DxptFA@mail.gmail.com>
Subject: Re: [RFC 1/1] Weighted approach to gather and use history in TEO governor
To:     Pratik Sampat <psampat@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Doug Smythies <dsmythies@telus.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
        pratik.sampat@in.ibm.com, pratik.r.sampat@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 13, 2020 at 7:31 AM Pratik Sampat <psampat@linux.ibm.com> wrote:
>
> Thanks for your comment.
>
>
> On 12/05/20 11:07 pm, Peter Zijlstra wrote:
> > Just a quick note..
> >
> > On Mon, May 11, 2020 at 07:40:55PM +0530, Pratik Rajesh Sampat wrote:
> >
> >> +    /*
> >> +     * Rearrange the weight distribution of the state, increase the weight
> >> +     * by the LEARNING RATE % for the idle state that was supposed to be
> >> +     * chosen and reduce by the same amount for rest of the states
> >> +     *
> >> +     * If the weights are greater than (100 - LEARNING_RATE) % or lesser
> >> +     * than LEARNING_RATE %, do not increase or decrease the confidence
> >> +     * respectively
> >> +     */
> >> +    for (i = 0; i < drv->state_count; i++) {
> >> +            unsigned int delta;
> >> +
> >> +            if (idx == -1)
> >> +                    break;
> >> +            if (i ==  idx) {
> >> +                    delta = (LEARNING_RATE * cpu_data->state_mat[last_idx][i]) / 100;
> > 100 is a crap number to divide by as a computer. We bio-puddings happend
> > to have 10 digits, so 100 makes sense to us, but it does not to our
> > binary friends.
> >
> >
> Absolutely! I just wrote the code exactly the way I did the Math on paper,
> definitely need to figure out an optimal way of doing things.

There is no particular reason to use percent in computations at all.
You may as well use 1/1024 parts instead (and then use shifts instead
of divisions).
