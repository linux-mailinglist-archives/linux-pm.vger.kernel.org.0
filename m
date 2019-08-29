Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9A75A1E06
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2019 16:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbfH2OyY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Aug 2019 10:54:24 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37490 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727565AbfH2OyY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Aug 2019 10:54:24 -0400
Received: by mail-pl1-f194.google.com with SMTP id bj8so1696548plb.4
        for <linux-pm@vger.kernel.org>; Thu, 29 Aug 2019 07:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:to:from:user-agent:date;
        bh=GCLBREhsH0y+iPt4sZdcYSbSFOKA3tBuxEXbqgrezQs=;
        b=GodzQTP7hIIoeFf5qkuQPtLv5FVme1IU5vK2YxaYFRfsd1+IIn7ODeDG9/hkE9TIzT
         ZVaAR2V8JaM0aV7K3VGFj+Np41A23tJulYB9IWiY9oOAy0Ug7au3VF+WOffZ5AZBPL7Z
         oxaXKYOIr+rFyeoJgVEWdvwhpUI6iWfCjLQk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:to:from
         :user-agent:date;
        bh=GCLBREhsH0y+iPt4sZdcYSbSFOKA3tBuxEXbqgrezQs=;
        b=eHgFBoCS68r8+oJVPOaH2ik8ylNPHhCW9EFhtBazxwcEFpAvoS6X7Oj9WIwSZ51alf
         AjAKk2N0Ky+DAdhZXvdl9rlGh8mgFvFoGUPZCT/F0dpVCv995swPjDud41EN315s0E2Y
         Vo9hCKdHS8xFDhIUnA6qU/KLHrGfdpdF0521o8hE4NrvM7TQyqpVCiu1xqfM4cQ6J3s7
         bup9s/vjb/stLoDmmUh+B2FGAKdGL5AsMz0ig2v4b5Yx3fSSQ0J0Ud8AvDyuWzygfTvG
         elrO6mOz7Rja8duk0XfwVrJZmebGl1qsbewi8w97leM+nemqrx0Nez393mTp0fym1mmE
         vG3w==
X-Gm-Message-State: APjAAAWcbeNU55eEMr9r5ezkmsZIfFhaF03JqYLkFbV7uVoyY4O4SIA5
        DEnPlpjGwVYLwpuUV0GhQ03HMQ==
X-Google-Smtp-Source: APXvYqz1wXQ3Fs4ACdKQNpbWss1Cxcv8o0j6fSXkYr+ALiIPpGyD8X9qfb6eDwoJXJOhVX94ja/i7Q==
X-Received: by 2002:a17:902:6a84:: with SMTP id n4mr10430031plk.109.1567090463353;
        Thu, 29 Aug 2019 07:54:23 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id z68sm2717912pgz.88.2019.08.29.07.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 07:54:22 -0700 (PDT)
Message-ID: <5d67e71e.1c69fb81.6f885.6391@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAP245DVV=7wfJqQdknoovqarXnHdzZzfhPQCkKxCy+heGrz9Ag@mail.gmail.com>
References: <cover.1566907161.git.amit.kucheria@linaro.org> <a4666f8afa39471658602e06758b04a991f80828.1566907161.git.amit.kucheria@linaro.org> <5d66f545.1c69fb81.3663f.129d@mx.google.com> <CAP245DVV=7wfJqQdknoovqarXnHdzZzfhPQCkKxCy+heGrz9Ag@mail.gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Brian Masney <masneyb@onstation.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 15/15] drivers: thermal: tsens: Add interrupt support
To:     Amit Kucheria <amit.kucheria@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Thu, 29 Aug 2019 07:54:21 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Amit Kucheria (2019-08-29 05:30:59)
> On Thu, Aug 29, 2019 at 3:12 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Amit Kucheria (2019-08-27 05:14:11)
> > > +                       thermal_zone_device_update(priv->sensor[i].tz=
d,
> > > +                                                  THERMAL_EVENT_UNSP=
ECIFIED);
> > > +               } else {
> > > +                       dev_dbg(priv->dev, "[%u] %s: no violation:  %=
d\n",
> > > +                               hw_id, __func__, temp);
> > > +               }
> > > +       }
> > > +
> > > +       return IRQ_HANDLED;
> >
> > Should we return IRQ_NONE in the case that the above for loop didn't
> > find anything in those if/else-ifs?
>=20
> The upper/lower interrupts are non-sticky, level-triggered. So if the
> temp returns to within the thresholds in the time that a IRQ was
> triggered and the handler scheduled, we might not see any threshold
> violations/interrupt bits set.
>=20
> It feels to me that this is a case of the IRQ being handled
> (automagically) instead of IRQ_NONE. The definition of IRQ_NONE[1]
> also seems to suggest that it should be used when the IRQ wasn't
> handled. But it was handled in this case (although, automatically),
> wasn't it?

Ok I see. Sounds fine then to always return IRQ_HANDLED. Maybe you can
add a comment to this effect right above the return statement.

