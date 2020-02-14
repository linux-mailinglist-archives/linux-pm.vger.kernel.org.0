Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1846C15FAAD
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2020 00:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgBNXeZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Feb 2020 18:34:25 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44992 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbgBNXeZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Feb 2020 18:34:25 -0500
Received: by mail-oi1-f196.google.com with SMTP id d62so11041852oia.11
        for <linux-pm@vger.kernel.org>; Fri, 14 Feb 2020 15:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bDwgZwWEZBQk29NnYfaGxDMUMeCdsRhSZX1d/rIRhxg=;
        b=OOd5U6oKpovMR6LKPXMaj8uM7Mw2QJILaFv1jCn8dj8LNnoYbRfBdI6LICyZRTke9A
         vBS3qYHaUpSILlCiysIyflj8cmWyTq7jOnN0ctlCO/9ZM0tMR0/fhFllptCByH8WNapx
         xiBZirFjgWTgNYTkkjrcMJDdFfV+j2uacM++cCbGmtAed1Dd2EgM/DlBlGqTP1G/c85X
         iBHzbQOiRNi5Uos3mBcxtHFcLknEC/v10ui/M8CwxwjwQ1YqbHHrncLwCc3cg9FCuZkK
         3qMiYL3ZXd0NxDFqJpxYoRcu1PorX/wCWV7svDqPs2U6ko7ferg4QrKcVtvyOMjAteFS
         Fa5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bDwgZwWEZBQk29NnYfaGxDMUMeCdsRhSZX1d/rIRhxg=;
        b=POu7OZ+j/xuNyHLeGf44sIgT3j4JD0Qgia9E3ZBXmrg6oafoaH96CjveHNmctREmk8
         /H8qBWxxfXBNh65aQ5by67TfeHGnPNMzHnrLSjnq8oxxiIizA2P0WObLsJXMwjEtRHBV
         N4gIylk+ecLCU/VBOTzR85Ro2fMx6o4MUIOlSecp/8qnjH6AsXw4QML14Cs69GTqVmUX
         VCQlKDrNFlW0aQJrIz2jY+c2x9MRn6vo8bpw5R6wUKg27k/EE9ZP+CqtzW/moqNjUK6z
         btyNXhID9mdQz332gVlAJwiQLpJ92/CtHswdqdhgtm4ueYjLSdBEDnjlzI1qfNkPw1OR
         S5wg==
X-Gm-Message-State: APjAAAXFIBNhKpoMeXTjRkhI7mutoSZ9Z/X3cxVzQFdVc8040TMhXMnp
        1Uz6tjO0R6JEy34NahNAPpZbV/KNu0WgcUrjlhmXIA==
X-Google-Smtp-Source: APXvYqyxEEchfAIYCAJCyFLYCbJyC5TN4Yg6b/NqwWNA0uFFN3wAJLP6U99c68Vkxn+8vw95fl2ig1lswc/FIbYIKTk=
X-Received: by 2002:aca:c551:: with SMTP id v78mr3569733oif.161.1581723262981;
 Fri, 14 Feb 2020 15:34:22 -0800 (PST)
MIME-Version: 1.0
References: <20200214233226.82096-1-john.stultz@linaro.org>
In-Reply-To: <20200214233226.82096-1-john.stultz@linaro.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 14 Feb 2020 15:34:11 -0800
Message-ID: <CALAqxLVukbQETMSfjc3OsEE4BGt-uXxw-NTqgLxA=ja4JAVD4w@mail.gmail.com>
Subject: Re: [PATCH v2] driver core: Extend returning EPROBE_DEFER for two
 minutes after late_initcall
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 14, 2020 at 3:32 PM John Stultz <john.stultz@linaro.org> wrote:
>
> Due to commit e01afc3250255 ("PM / Domains: Stop deferring probe
> at the end of initcall"), along with commit 25b4e70dcce9
> ("driver core: allow stopping deferred probe after init") after
> late_initcall, drivers will stop getting EPROBE_DEFER, and
> instead see an error causing the driver to fail to load.
>
> That change causes trouble when trying to use many clk drivers
> as modules, as the clk modules may not load until much later
> after init has started. If a dependent driver loads and gets an
> error instead of EPROBE_DEFER, it won't try to reload later when
> the dependency is met, and will thus fail to load.
>
> Instead of reverting that patch, this patch tries to extend the
> time that EPROBE_DEFER is retruned by 30 seconds, to (hopefully)
> ensure that everything has had a chance to load.

Oh, and of course I forgot to fix the subject line and didn't see it
until git send-email was done.  That should be 30 seconds, not two
minutes. I'll fix that up for the next version.

Apologies!
-john
