Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075652FD255
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 15:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732374AbhATOHs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 09:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388339AbhATNc2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2021 08:32:28 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB4FC061575
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2021 05:31:48 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id t43so7848248uad.7
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2021 05:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EygyrNo1L66YguGSTSkEZs1oOOE5dPsaKPmSAlahwhk=;
        b=hFuCyLYIUL4bPuSmVyGwJ5qOdl9VuxHNMdTOzr19HhTY8Qw8M95643Sr3sDDY21Zyu
         jNzFPBb0zSofa2aZatqnXTmPP2A3EJeg8yfRxYVD6DihsAyj8Maeg9uS9lLCNNXdVdTQ
         PW2VMXc5rtoUbZO4cuH3/JfK7gVdE59o8Ten4A9HedDee2EqeCupC4s/KIHpVsRaf7CT
         ur2XoCezvAZaDTLJbgoP5Gq/Jwyr3yknamxPGVOa5y5ngerkbktCxytiKcxbgbm1NsLs
         M9cupGjLJf30oFZQ90aLQbh9Zxwq49JQkZ+dqcg3cAnVp7Ce70WZI42+e5dc3JSMr/LW
         LtBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EygyrNo1L66YguGSTSkEZs1oOOE5dPsaKPmSAlahwhk=;
        b=fqukK1mfCWywD80DzZNif24klOJ+/eLvv6V6jMSVAlI1p5W78upf0dZq42i9It4Sgv
         Tv/jxucgZf7CT7kHMqbnIKW/coce2+CImae69WuBmfaxNjfrsSaEUTksX5rOLwADbR16
         OWeh2TG9y/ILPzuDDD7tQI5+y+VerYyqoIa6LdqqxI6LEdqk7iblfFIJV46Xu9emyytQ
         XhnPMX4rNlMd6c+7HCMwNXRl6wei9CxSirxb/JnvevDkhTwfHc19dE9WhwanoCAMzIaa
         xBdoLzcAaR6xM+U/adTg53Li5JtjlLKN3HogUY9Ey3IySiyjFHfalQ+kBLs7i4HTKXNu
         ytgw==
X-Gm-Message-State: AOAM531nmQeUwS4shHuOa1/It5WZAYvA7F8gS1ojn+BGdW68bGWihIQ4
        GAG7p2FKAB7jEo6JLoU+anMnYX5AfpWbhHmYJ9VhHw==
X-Google-Smtp-Source: ABdhPJzkobxZ3ZkN8/e+5qJpHJ+BQ3MwguUnina2HKp/lBcnr/mhXKUDNIf5dGu8SstEZIGrIePbNt3r4BgNcnONcXo=
X-Received: by 2002:ab0:768:: with SMTP id h95mr6005681uah.104.1611149507447;
 Wed, 20 Jan 2021 05:31:47 -0800 (PST)
MIME-Version: 1.0
References: <20201224111210.1214-1-rojay@codeaurora.org> <20201224111210.1214-4-rojay@codeaurora.org>
 <YAGqKfDfB7EEuZVn@builder.lan> <6bfec3e6-3d26-7ade-d836-032273856ce2@codeaurora.org>
 <CAPDyKFqF0NE3QRAEfiqj5QOXXH2om4CpyyeudeqoovANfvjsaQ@mail.gmail.com> <20210119110516.fgbbllyg7lxwwfdz@vireshk-i7>
In-Reply-To: <20210119110516.fgbbllyg7lxwwfdz@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 20 Jan 2021 14:31:10 +0100
Message-ID: <CAPDyKFogrWt=K3VtEZVH5bPL_fYt7rgdm5wGgq+QHtzX-n0z7g@mail.gmail.com>
Subject: Re: [PATCH 3/3] i2c: i2c-qcom-geni: Add support for 'assigned-performance-states'
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>, akashast@codeaurora.org,
        msavaliy@qti.qualcomm.com, parashar@codeaurora.org,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 19 Jan 2021 at 12:05, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 19-01-21, 12:02, Ulf Hansson wrote:
> > As a matter of fact this was quite recently discussed [1], which also
> > pointed out some issues when using the "required-opps" in combination,
> > but perhaps that got resolved? Viresh?
>
> Perhaps we never did anything there ..

Okay. Looks like we should pick up that discussion again, to conclude
on how to move forward.

>
> --
> viresh

Kind regards
Uffe
