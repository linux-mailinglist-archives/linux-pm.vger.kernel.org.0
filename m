Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C80B23D451
	for <lists+linux-pm@lfdr.de>; Thu,  6 Aug 2020 01:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgHEX5s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Aug 2020 19:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgHEX5p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Aug 2020 19:57:45 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393ABC061757
        for <linux-pm@vger.kernel.org>; Wed,  5 Aug 2020 16:57:45 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id f9so5533505pju.4
        for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2020 16:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=4ifd5xwQw/fF71sDAVj0NW6xVjjKI1lLoO8YrlRE1c0=;
        b=W6CnF3IFM1qV4vtyI4l+BsHliSAapqyzRfwP5beGaDhXjDfZFPIU6UStOC92nizOTo
         aWkDKwkFohx7OKn2mg8i/RSJrfwtBoR5s6iBJWAGa9yjAqbJVL7kn4mG5Ax8Ih/a0UGL
         b1ZjUdMSZyOOwYExEooYKVQan12BTOgKsSKo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=4ifd5xwQw/fF71sDAVj0NW6xVjjKI1lLoO8YrlRE1c0=;
        b=B7lCaEQtismbKXbvxylPZ7/cRK0bxk4e8SF/Hz7HFAOKC4ZjKmtsfO4Ze2gUosqiaE
         IRv7AAXbGyRN3izWrCY1Bt3bL1RKlQbLK51PP5IT4EPiIgB0Nr5HF/+yu3NowMSrjnI+
         AW5Yr3YnKPxz6dektKXulVgl7W9GNwZC8PKHO5SctNyIH5jD+UXdfj/XatelsHyo4Riq
         uvKDd2JeEgmx1LXE/hKywbBXklMKw9MYQ0t88Bo4Vn1AbqJW96bTicm/vhI09i4JrwGU
         VdPHjUdR1J1T1VNfI0ndy+NdF33+w5vUXj1ftXTGuhy5Z52lZdLpBGRA4eKHVjy0rTp5
         xiHA==
X-Gm-Message-State: AOAM533f5EV9qVpwi3CRIA4MNAxFVzxAivQO0wAh9obu1kUBDDOxrkSm
        JZJepz3LgDMDTqFFrqbg0/poR4HjPNY=
X-Google-Smtp-Source: ABdhPJxdV4c+ByHIoyl3UTQ5JOq/H3l5NMy7snS9vWIKQev3DSMuRd8Yi8bmuJJTKYnajrrlgKX1jg==
X-Received: by 2002:a17:90a:f68a:: with SMTP id cl10mr5578673pjb.40.1596671864307;
        Wed, 05 Aug 2020 16:57:44 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id go12sm4214725pjb.2.2020.08.05.16.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 16:57:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <98050322-9ba6-303c-4ca4-07baa56ebd80@codeaurora.org>
References: <1596541616-27688-1-git-send-email-rnayak@codeaurora.org> <1596541616-27688-2-git-send-email-rnayak@codeaurora.org> <159660954201.1360974.5176671532597020049@swboyd.mtv.corp.google.com> <98050322-9ba6-303c-4ca4-07baa56ebd80@codeaurora.org>
Subject: Re: [PATCH 1/3] dt-bindings: power: Introduce 'assigned-performance-states' property
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
To:     Rajendra Nayak <rnayak@codeaurora.org>, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, ulf.hansson@linaro.org
Date:   Wed, 05 Aug 2020 16:57:41 -0700
Message-ID: <159667186194.1360974.10053425753327700919@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Rajendra Nayak (2020-08-05 01:13:06)
>=20
> On 8/5/2020 12:09 PM, Stephen Boyd wrote:
> > Quoting Rajendra Nayak (2020-08-04 04:46:54)
> >=20
> >> +       device's performance, also known as DVFS techniques. The list =
of performance
> >> +       state values should correspond to the list of power domains sp=
ecified as part
> >> +       of the power-domains property.
> >=20
> > This is different than assigned-clock-rates. I guess that's OK because
> > we don't need to assign parents with more specifiers. Maybe it should be
> > worded more strongly to clearly state that each cell corresponds to one
> > power domain? And that it should match the opp-level inside any OPP
> > table for the power domain?
>=20
> Sure, I'll reword it to make it clear that we need the same number of cel=
ls
> as power-domains, and as you pointed out below that 0 corresponds to not =
setting
> anything.
>=20
> For the matching of opp-level inside the OPP table of the power-domain, I=
 don't
> think from the power-domain bindings we limit providers with only OPP tab=
les to
> support performance states? It could be just a range that the provider ma=
nages
> internally?

Ok. The example made it match so maybe that can be clarified as well
that it doesn't need to match any OPP table performance state.
