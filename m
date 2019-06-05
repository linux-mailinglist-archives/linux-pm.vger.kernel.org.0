Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEFF0366E2
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 23:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfFEVgJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 17:36:09 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:37385 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfFEVgJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2019 17:36:09 -0400
Received: by mail-it1-f194.google.com with SMTP id s16so5942317ita.2;
        Wed, 05 Jun 2019 14:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PHfDRrrcA5x6FyJdpB895HBnjOPm4pCQHaO4/FIqnPg=;
        b=R+mxYsNJNPN8RQyh8lCcbxSHzS2GVAGekhCZ22eaU6ejLMavmLUhDs426vgzWxOxoM
         CaKG5ATehvNlMXd7eTfJDzBJ3zSQ3RS3bMLQ/QGLZzz44iInc7AzRtUKty4TbCMS0VmS
         UqpCGwE91JSm27gXLyPn/RAvvLGvhb8NDNz1bEtyv9iDqVwEQvzfcOPN5QSE3/wQpDeq
         EM+fEyZ5d5LVGMBSRLK880IeUHGRx5WXf1URVuVSmvUGyAmxaP5F8MlT0/ZE7UzCJhUZ
         f/flUQK+Hzq9VbAsHZtbookQQK3wwPo4W2W2L4Jsgk8+iq8Qs6WphDxL2kdr4z9Tf+Hf
         PzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PHfDRrrcA5x6FyJdpB895HBnjOPm4pCQHaO4/FIqnPg=;
        b=NSDhkqDOQuvfAwp0Zxe5gBjhRbmvLJeRDPXxSXaZZxaTzzCJh0f6JPgbHiqprct//g
         hTJAzu6PGC/vmQ+3ZuR/SurlbRMVz6wUlXLoUFnisD8yhsaNM6Y/PtW1SzLq/sodjNBV
         IPTPFj4UKiB9b7CRuRbbj1pIN6ia3TxxRYzw7jGBd+TIF6y/MMdLXyeQ4x35oi/zzHCU
         l9ZpPlHFDqeB0iy1wmeR40J5iws046xr3jCP5MoFM6Q5J4TNQgNHXdsaq3YbfSsJQnQg
         JHFK1KN7DSIKlIYGz92I6kPKPimFy756UFxWulCe13xN4VNe7LpNlQI+aaJ5wUxgARbF
         YSqw==
X-Gm-Message-State: APjAAAUZ/yGa1OA94Iog7YVbWv8wBTi7T1Klll6EuvU2SlDKLVa1OL+v
        HWHmWk/VdZ42xfzhCgzwvfJEWlvi3U+Xt8MIm1Q=
X-Google-Smtp-Source: APXvYqyTIuxC5XW7fKzfooebrIftPixEXcOoP9du2pQBhfXVcBlAKSaqDAH48FQJ++xlI0Tf5QEl2YRO5nNN4IsLO1Y=
X-Received: by 2002:a24:4f4a:: with SMTP id c71mr26978770itb.65.1559770568336;
 Wed, 05 Jun 2019 14:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190605072323.21990-1-andrew.smirnov@gmail.com>
In-Reply-To: <20190605072323.21990-1-andrew.smirnov@gmail.com>
From:   Chris Healy <cphealy@gmail.com>
Date:   Wed, 5 Jun 2019 14:35:57 -0700
Message-ID: <CAFXsbZoSmzGZWtGa+OPvLDnq9nPiy30u-CZ0wb8QCrOPgQvpCA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] HWMON compatibility layer for power supplies
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-pm@vger.kernel.org, Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> This small series contains the code I wrote to expose various power
> supply sensors via HWMON layer in order to be able to access all of
> the sensors in the system with libsensors.
>
> Changes since [v2]:

Full series is tested using the UCS1002.

Tested-by: cphealy@gmail.com <cphealy@gmail.com>
