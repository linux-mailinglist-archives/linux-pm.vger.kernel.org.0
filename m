Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761961AA9E5
	for <lists+linux-pm@lfdr.de>; Wed, 15 Apr 2020 16:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392052AbgDOO2F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Apr 2020 10:28:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729551AbgDOO2C (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Apr 2020 10:28:02 -0400
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FE362137B;
        Wed, 15 Apr 2020 14:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586960881;
        bh=ZB6JwYNcMXtDqUpFqr+tucEk39Yxv3CVPGoD0O1qI9k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EdiMO3msQAgzx0TyMSchthqY2rs2o5vaaovfnRG9lP0sq2zRvSd7A5QMdCQu0XiW5
         uXdY7A/C7z5pANdqM7vdXpHOqvF+/a1K/sl74bMMKu9+Sx9F8tCvvrpCb/AwQAy0r7
         2owN22MwmG4CKqQ5uKU7THxXQD4eJIJx09UaBv1c=
Received: by mail-qv1-f51.google.com with SMTP id di6so78414qvb.10;
        Wed, 15 Apr 2020 07:28:01 -0700 (PDT)
X-Gm-Message-State: AGi0PuaxPsZ2sH6+7fEAC4bgOx5Bb6QfaCNZ1i5DfYDOecdNR3rQtC0V
        DVtUBF+kUf2L03+tH+JEjiEHCkTr2XgbnI845Q==
X-Google-Smtp-Source: APiQypLsz6XmmIsYo7wzUtEP93/5Mi9D1CSe82grG2qT7IqkeUxM3r49phjnJKjx+Z5cjvQrWQxLKQ0q/vwRTjsscsU=
X-Received: by 2002:a05:6214:a8a:: with SMTP id ev10mr4632235qvb.20.1586960880451;
 Wed, 15 Apr 2020 07:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200329161552.215075-1-david@ixit.cz> <20200329162128.218584-5-david@ixit.cz>
 <20200410164905.GA719@bogus> <8c4ab1ce-1947-ab38-3f8c-9055406428e4@gmail.com>
In-Reply-To: <8c4ab1ce-1947-ab38-3f8c-9055406428e4@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 15 Apr 2020 09:27:46 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJgZaQux04vdkShX4vkmOK5T-H6tOXt7Da19jgG0P76-Q@mail.gmail.com>
Message-ID: <CAL_JsqJgZaQux04vdkShX4vkmOK5T-H6tOXt7Da19jgG0P76-Q@mail.gmail.com>
Subject: Re: [PATCH 4/9] dt-bindings: power: supply: Add device-tree binding
 for Summit SMB3xx
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     David Heidelberg <david@ixit.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Myungjoo Ham <myungjoo.ham@samsung.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        ramakrishna.pallala@intel.com,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 10, 2020 at 2:02 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 10.04.2020 19:49, Rob Herring =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> ...
> >> +  summit,max-chg-curr:
> >> +    description: Maximum current for charging (in uA)
> >> +    allOf:
> >> +      - $ref: /schemas/types.yaml#/definitions/uint32
> >> +
> >> +  summit,max-chg-volt:
> >> +    description: Maximum voltage for charging (in uV)
> >> +    allOf:
> >> +      - $ref: /schemas/types.yaml#/definitions/uint32
> >> +    minimum: 3500000
> >> +    maximum: 4500000
> >> +
> >> +  summit,pre-chg-curr:
> >> +    description: Pre-charging current for charging (in uA)
> >> +    allOf:
> >> +      - $ref: /schemas/types.yaml#/definitions/uint32
> >> +
> >> +  summit,term-curr:
> >> +    description: Charging cycle termination current (in uA)
> >> +    allOf:
> >> +      - $ref: /schemas/types.yaml#/definitions/uint32
> ...
> > These are all properties of the battery attached and we have standard
> > properties for some/all of these.
>
> Looks like only four properties seem to be matching the properties of
> the battery.txt binding.
>
> Are you suggesting that these matching properties should be renamed
> after the properties in battery.txt?

Yes, and that there should be a battery node. Possibly you should add
new properties battery.txt. It's curious that different properties are
needed. Ultimately, for a given battery technology I would expect
there's a fixed set of properties needed to describe how to charge
them. Perhaps some of these properties can just be derived from other
properties and folks are just picking what a specific charger wants.
Unfortunately, we have just a mess of stuff made up for each charger
out there. I don't have the time nor the experience in this area to do
much more than say do better.

Rob
