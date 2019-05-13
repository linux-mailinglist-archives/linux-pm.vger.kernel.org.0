Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 932841B0F3
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 09:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfEMHMi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 03:12:38 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46493 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfEMHMi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2019 03:12:38 -0400
Received: by mail-ot1-f68.google.com with SMTP id j49so3133067otc.13;
        Mon, 13 May 2019 00:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=03yJKmjQ5gsLyTCS7O1UYQdONzM/n4B9Y3IAylqGFBw=;
        b=htlFxFdstGcnMKpUW2vUVzAG1u6z7Eqxpm3yRJpBAQFFy+kkD2LGv6Vbs/YV0f2hiy
         EsASdWx7WnOKNErRPCwPwMWI5nIwPSOi3yuN4zbjjUNOctnr69mRVhLTczTMg5fh/Gf2
         KSSeMn7+0rhOdoh1JZMzO0q2LkSpMoVXdlpu4m5mXFAATbzmmtvfDiWL55RUmWTM1qSr
         X9I4WF4RlGF9JTjCKmYLDecfTTUx+kceQQrpkF1RnTn61JXNU3BfDyj2oxltKgbwfC/k
         gd6mcjiCPWMtf5qvl2g1opz6HoLgZ3xyWHwK3dXR8MXzIzWgKsuQd6Rdz6xTRxs2NLpw
         O4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=03yJKmjQ5gsLyTCS7O1UYQdONzM/n4B9Y3IAylqGFBw=;
        b=ajxVaLofpkfMF8evrAFCsNy1H6kTxv07rN+TcEoJdrq5NOiGh/JAlPL3AtMpjCsbO3
         RuPaAaEz98YBJSyHRJAgF/On2+AsmI/d6hegqb4mw9Wo+afLR0KcJIam022/pTuyGosA
         6P/MbErKIYAW84XQlG/YSfg+Qw0PggtcJXN+Rk27zX2kb0/dhvzps66lG+m7gn56MXI7
         IrVd5+NcOmGOLQsMhoNwbSgyHk+tklC7yyjwnYa5mxvijCGXD3ovYVs8oCmNVNpcU3tg
         rphPVSj88B0xLQdG5MZYClL/fvbAhIVZUemhiqodsYDWRYWJKFTn3MvAgmVbt2qubVV3
         x6ZQ==
X-Gm-Message-State: APjAAAWRpMh65rdT8lN7ua4y72hl3qs9U2n1eTml457/76A8o3qlYLiR
        s688ADKPh5BXVYzeu1wGtgetsd6Okl2/QqIu50s=
X-Google-Smtp-Source: APXvYqxMNXEni8A0/au2t7JWxUYpsDcQtk6mbwIegVrWtYmHPIlBOdBHl/gKxjeWS+fD0ogXpA4qqWm+K/PKkprRxao=
X-Received: by 2002:a9d:3608:: with SMTP id w8mr15748192otb.189.1557731557348;
 Mon, 13 May 2019 00:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190508174301.4828-1-douglas.raillard@arm.com>
In-Reply-To: <20190508174301.4828-1-douglas.raillard@arm.com>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Mon, 13 May 2019 12:42:26 +0530
Message-ID: <CAOh2x=k23D_FefOnmLjExj1d+UiothgOmyUk=1mqFknpHNwWGg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] sched/cpufreq: Make schedutil energy aware
To:     douglas.raillard@arm.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, quentin.perret@arm.com,
        patrick.bellasi@arm.com,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 8, 2019 at 11:57 PM <douglas.raillard@arm.com> wrote:
>
> From: Douglas RAILLARD <douglas.raillard@arm.com>
>
> Make schedutil cpufreq governor energy-aware.

Hi Douglas,

I was wondering on why the cpufreq maintainers weren't cc'd for this set and
then I noticed that get_maintainers doesn't report us at all for schedutil :(

I have sent a patch to fix that, but please include us as well in the
future even
if get_maintainers doesn't report us :)

--
viresh
