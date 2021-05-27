Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC0D3930DE
	for <lists+linux-pm@lfdr.de>; Thu, 27 May 2021 16:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbhE0O2h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 10:28:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235718AbhE0O2g (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 May 2021 10:28:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F45C60233;
        Thu, 27 May 2021 14:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622125623;
        bh=3RGwy0E3qD8kP02c4nF4XtwJ1weDmH+8h4KkQG5Oo8o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WMdj6HrMf649FtKIqCVaBrVDc+Akxu3KzaNihhwtsc5VpR4Z/5qMpx1++DhxVeUVp
         IOqwzflymg2Y4BYpOkRDygunHe3YfXLaFYIYJs/xcoLlccweZOhdsj10Li7zouyTN2
         jA+79PQ2LqEJBxTLirbVksBzstP2lz+Ps9N9/IWaepaDVlMG+GuFsaFTZ2QoxZiUZe
         O83s7hW8O2jy9JQ7FZIJDdeaE/ER/5hF/fhTsksD1OBUKMGW58IHxs0JGxM/9GaFVh
         P0sczttuwpF8yDKhN1ka0AQ6SF+M8pfr5299pVm5lvdTHNIKCW7+hXpZNXzQaVvtd9
         r4GIyHeic2mIw==
Received: by mail-ed1-f44.google.com with SMTP id df21so1097690edb.3;
        Thu, 27 May 2021 07:27:03 -0700 (PDT)
X-Gm-Message-State: AOAM533OMIGNM8iDYlOiN9QUAob58XTMICfWXbWzbD9nES/HuhT1LQ8p
        XTEhWSgooDcYbBxnGSwqkedL1NIOsTHfJ9SeIQ==
X-Google-Smtp-Source: ABdhPJxaOyI+oliVAThCvN+GoGSj+B43dsXcsxc3Cm8bHclqkC/jYDPYrAZghoDHcvcVhqrOSoMC0HsXCEn2gm+RbSY=
X-Received: by 2002:aa7:cb19:: with SMTP id s25mr4510289edt.194.1622125622043;
 Thu, 27 May 2021 07:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <1622095949-2014-1-git-send-email-rnayak@codeaurora.org>
 <1622095949-2014-2-git-send-email-rnayak@codeaurora.org> <1622125407.790558.731791.nullmailer@robh.at.kernel.org>
In-Reply-To: <1622125407.790558.731791.nullmailer@robh.at.kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 27 May 2021 09:26:50 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL=Vppsxi1yERmd4HAXkUfBkP3pFkTct0CMOeO109U-aA@mail.gmail.com>
Message-ID: <CAL_JsqL=Vppsxi1yERmd4HAXkUfBkP3pFkTct0CMOeO109U-aA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: power: Introduce 'assigned-performance-states'
 property
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 27, 2021 at 9:23 AM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, 27 May 2021 11:42:27 +0530, Rajendra Nayak wrote:
> > While most devices within power-domains which support performance states,
> > scale the performance state dynamically, some devices might want to
> > set a static/default performance state while the device is active.
> > These devices typically would also run off a fixed clock and not support
> > dynamically scaling the device's performance, also known as DVFS techniques.
> > Add a property 'assigned-performance-states' which client devices can
> > use to set this default performance state on their power-domains.
> >
> > Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> > ---
> >  .../devicetree/bindings/power/power-domain.yaml    | 50 ++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/power/power-domain.yaml:72:8: [warning] wrong indentation: expected 6 but found 7 (indentation)
>
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/power/power-domain.example.dt.yaml:0:0: /example-3/power-controller@43210000/opp-table: failed to match any schema with compatible: ['operating-points-v2']

You don't really need to worry about this one as it is already a
warning (but patches welcome if someone wants to convert the OPP
binding).

Rob
