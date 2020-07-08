Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B15921857B
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jul 2020 13:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgGHLEw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jul 2020 07:04:52 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34709 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbgGHLEw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2020 07:04:52 -0400
Received: by mail-ot1-f66.google.com with SMTP id e90so6082819ote.1;
        Wed, 08 Jul 2020 04:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IHCyGxj1cvpIoNYOX+nc8vjaWSXk9jF7cUyVbUqeMg0=;
        b=J1Z3boooAV5Cn+Kp5oI8251HzkrPIExYbm/sVOlh+QQ928bqYOra/OSqZGr04bcI+w
         J4mOTlNJbjg5NPW2ebhNtPgXUBV1nn2E1A2kt0tRiHcXblNv8sofqPYRi32igW30DYCy
         T3ceyHrQR8P0jFEchMCAEYxR4SMC2W7QrOcicmvkboiCRXP51S/KySy0dzF0RcrQd2yM
         SdqSgT3FErJobV5rfnu+Ai8Y+iJcNd0K6+1GCcSrBnXu0lULkuqLJuaImk4TXgJeZotu
         uQm346UwL4D3Trujy5X5UvOKhJ8fJiJL6ItEtF3TQb6a7OMAwC74L6LY6LPIGBQSKuG2
         nuaw==
X-Gm-Message-State: AOAM532XKjbVxegZVwmQ62l1oRHGUxqTj60cQDWTDGejuQnoFPgDG0fz
        Ird13t4uZfkKo8jC1jucH55/6ckdMSiomxwnFbk=
X-Google-Smtp-Source: ABdhPJx0pYxRbD1A4YMqTXjB55nDwyDRMhKrjXyrUYVPPyCD8Vl+kVThCEsAAO/sNGwFVTx7mhc5bKdEBSapC4H9cgM=
X-Received: by 2002:a9d:590a:: with SMTP id t10mr12704394oth.262.1594206290904;
 Wed, 08 Jul 2020 04:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <202007080131.3E6D0858@keescook> <CAPDyKFqT4DXr9pn3+mGmsdxTD6nNWfod_Z13fpzpHf0STOt_XQ@mail.gmail.com>
In-Reply-To: <CAPDyKFqT4DXr9pn3+mGmsdxTD6nNWfod_Z13fpzpHf0STOt_XQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 8 Jul 2020 13:04:38 +0200
Message-ID: <CAJZ5v0iovBAj5-HyD0SA1UEfJ3+mfv=Ke04pEebbmbhH6q7Zsg@mail.gmail.com>
Subject: Re: [PATCH] genpd: Fix up terminology with leader/follower
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 8, 2020 at 11:04 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 8 Jul 2020 at 10:35, Kees Cook <keescook@chromium.org> wrote:
> >
> > The genpd infrastructure uses the terms master/slave, but such uses have
> > no external exposures (not even in Documentation/driver-api/pm/*) and are
> > not mandated by nor associated with any external specifications. Change
> > the language used through-out to leader/follower.
>
> In my opinion this doesn't really make it more clear, but rather the opposite.
>
> If we should improve, I suggest using "parent" and "child" instead. As
> matter of fact, that's already the de-facto terminology that people
> are using when talking about master/subdomains of genpd.

IMO "parent" and "child" would be better indeed, because genpd only
supports strict hierarchies.

Thanks!
