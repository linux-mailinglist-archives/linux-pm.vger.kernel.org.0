Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F10CB12E084
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jan 2020 22:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbgAAVQL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jan 2020 16:16:11 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:43345 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgAAVQK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jan 2020 16:16:10 -0500
Received: by mail-ua1-f66.google.com with SMTP id o42so12988828uad.10
        for <linux-pm@vger.kernel.org>; Wed, 01 Jan 2020 13:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CcCF1rxq2Pk5WTtIE879sPZ4spchmlqFWlGadt2tei8=;
        b=WX7N4eXBYo8B4Y/qw45TKK1fBOA03UGCzBkKH0DOYphDG7KdePyxbYAzDAeiqIGGkU
         lRc0/8KrEefOwe/TOXds6249+PxHVd0P/nZNYtNcHGaZlSu9lbFRc+uJJ/lPrKDhcpby
         Euk8Ka8N7Ikkpqk8AJjO6s2quZNqWXcUWQNejhgqSF0BiohaFol038E3nlMcK8faLpsv
         IXo46d2Iim7HkEw+SVdmdjgbgJBGjt2fEgxFP9SwM+ZdfDNIQQWVqSIqFtkh/SdTPN60
         0697oZNB4/+HbKlZFhKlw86fVGYWO300F4wFJMQ4y+lEcAd5hzsETlmE8NvdmnXckeSp
         MPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CcCF1rxq2Pk5WTtIE879sPZ4spchmlqFWlGadt2tei8=;
        b=FygyM9uq0eQqfQ2ViG242YUm8PNPoBLItb0aohY3Xxjbrsy2YkDoCMUX44djHffhvf
         2cui7CP3eDyOaJu6vbWl/2Bk9Q49w7Cs4+BTWhjzvQD/A+86e31ClinrL+uG0oson3m9
         HWde/dkblbdKRm1IAKEoeK2AjhfIf1pu6leMXQ6kPaJHuO7xVfns3ks8r4mDqGv0ODY9
         hpoCeesxeeaELirGD3XciDrIGONZ6nDLHE7CnI11rTb6ogeINAmfiR1XYHK77e0AtH2B
         W2Q2WiXIWiMoys97f1V3yKPj4oKcQGYtgbU9+eGLQjRixSNQDzRjAJ0C7V1onYodyf4C
         wGqQ==
X-Gm-Message-State: APjAAAWjQ0p7DbPf0CjkxTjyGF/PqTao0c3CY1Wu6I5fqvHipt8SV6n9
        kiBJjiviiHBrlGL4HlaOvPHk7ii4GmVlH4njo5sCJg==
X-Google-Smtp-Source: APXvYqzfUap7PPa4Ci4VcLXoV15qac7sY43uAqaI29GOvH6BmNigjds4Fe4HtOfWU09OaXLR7dEm+FndCbPAoJAP0oU=
X-Received: by 2002:ab0:634c:: with SMTP id f12mr41911073uap.48.1577913369830;
 Wed, 01 Jan 2020 13:16:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576146898.git.amit.kucheria@linaro.org>
 <cea3317c5d793db312064d68b261ad420a4a81b1.1576146898.git.amit.kucheria@linaro.org>
 <be07b05d-421f-35a7-0582-a04a226c8c2c@linaro.org>
In-Reply-To: <be07b05d-421f-35a7-0582-a04a226c8c2c@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 2 Jan 2020 02:45:59 +0530
Message-ID: <CAHLCerMYkEBs7HfYV0WNfypNPCRBEeU3w7ye=4+VxiiXVZT9GQ@mail.gmail.com>
Subject: Re: [PATCH v2] drivers: thermal: tsens: Work with old DTBs
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Olof Johansson <olof@lixom.net>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 16, 2019 at 2:58 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 12/12/2019 11:38, Amit Kucheria wrote:
> > In order for the old DTBs to continue working, the new interrupt code
> > must not return an error if interrupts are not defined. Don't return an
> > error in case of -ENXIO.
> >
> > Fixes: 634e11d5b450a ("drivers: thermal: tsens: Add interrupt support")
> > Suggested-by: Stephan Gerhold <stephan@gerhold.net>
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
>
> Applied.

Hi Daniel,

I haven't seen this fix until -rc4. Do you plan to send it?

Regards,
Amit
