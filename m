Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468E14B388F
	for <lists+linux-pm@lfdr.de>; Sun, 13 Feb 2022 00:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbiBLXV7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 12 Feb 2022 18:21:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbiBLXV7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Feb 2022 18:21:59 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B7E5FF06
        for <linux-pm@vger.kernel.org>; Sat, 12 Feb 2022 15:21:54 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id y129so35583588ybe.7
        for <linux-pm@vger.kernel.org>; Sat, 12 Feb 2022 15:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ym6I7JEa6rfW55O5nuas5EliDSFM8fGB/TqN7zqNxv4=;
        b=qLrwdjM5Xs22ufOVS4Sad6Kp249ezwFrop7V7CIkXlNIdPpDOIvbJbgpFBNSkagqvC
         uq+sWrgkMh8RzO64aGY/0uZygimloCUjzKHSyT4AM8Gw7BvjA1XvvItbtSXAcpqOUIrH
         pwO589SfFp6gQ20QS1cMXojyslBrxQXJEoqOO+Z80I90sg0OaNfFmDuBAWYR7gEKoLSw
         sgbZq5qir77pWjFlQH/LHQAm5NDTu5hG6Ec6/1DmP7FigNZ7134l+aWjfMBCBEXQSuIV
         /C4NrDKURpHgWudg7XiWBCGcObnmCweraqgmvOzgcs5oVAKtC3ppJ1mSfjhi0s0YiZ05
         J67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ym6I7JEa6rfW55O5nuas5EliDSFM8fGB/TqN7zqNxv4=;
        b=Fb382ESYjEh0FksFCSPmyTWI3c0xENYXlqryh9uKfjgx6bET5+7crjqJBH/qYdq1rp
         QlPE1mLFyRJPMZVcT+XvU+1Wz/+XuslLX/YgU4/vVT2+KwXTF2VUrxXget5q0zABbJdS
         nTGpxI4xtpCi7CAVB47y98rOaEewxAbmikAJcxmn9kMTGlT70908IBPZqWvYgl9PhpyE
         rRDekAQaOLS3tZf9qdYa+LC4PQn9HDPm9G830HoAyaPld735Wcat/3OIXgeADHIp/0F/
         X6Ys6aMX1RsgtulebUfOb+EzDj7A0cs29nmoxkmrxaRcmDqK5RuZE/4mYyOViSC7w9tq
         dNgg==
X-Gm-Message-State: AOAM5322Sq7ZNqProz3FFyO6WLfzDpvn7n26eTEMuIDsnBWqsnYwfgOL
        tr4ifLZazLMOmIZpWnsFR/jQR6/ZVzHTccNFTJmZQg==
X-Google-Smtp-Source: ABdhPJxfU08xaQwxBWJ/vROzSYq24ZsJ2Z+Jg3oeOhocfGLnrIgehx1cnJVhmGYaVK8cq2HXTab8YQL8vq/1Rgvz7tw=
X-Received: by 2002:a81:ad1e:: with SMTP id l30mr7853300ywh.151.1644708113793;
 Sat, 12 Feb 2022 15:21:53 -0800 (PST)
MIME-Version: 1.0
References: <20220203171633.183828-1-linus.walleij@linaro.org>
 <20220203171633.183828-2-linus.walleij@linaro.org> <d49e08be-d24a-6cc7-21e5-c568015b9076@fi.rohmeurope.com>
In-Reply-To: <d49e08be-d24a-6cc7-21e5-c568015b9076@fi.rohmeurope.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 13 Feb 2022 00:21:42 +0100
Message-ID: <CACRpkdbZ4GSWVr+o1+76-FpiQiC4Ru9OEWrG3Y=tCjV_MVYJBw@mail.gmail.com>
Subject: Re: [PATCH 1/6] power: supply: ab8500: Standardize maintenance charging
To:     "Vaittinen, Matti" <matti.vaittinen@fi.rohmeurope.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Feb 7, 2022 at 12:15 PM Vaittinen, Matti
<Matti.Vaittinen@fi.rohmeurope.com> wrote:

> > @@ -124,7 +133,6 @@ struct ab8500_bm_data ab8500_bm_data = {
>
> static ?

Could be, but not related to this patch, and gets deleted in this series :)

Fixed the other static.

> Following is not expected to be done for this patch series - but I think
> we should try to enhance the power-supply core to provide some more
> framework support. For example this maintenance charging could be taken
> care of by the core(?) Eg, drivers would only register the callbacks for
> setting charging currents/voltages - and potentially event of requesting
> the maintenance charging (unless core could detect this for the drivers).
>
> I think bunch of drivers do polling or timers or at least IRQ bottom
> halves for fuel-gauging etc. For example the last series from Hans seems
> to need periodic coulomb counter polling for fuel-gauging. Perhaps we
> could try moving to direction of adding some common "loop
> implementation" to the core - and allow drivers just register required
> callbacks? I believe we could simplify many of the drivers.

We have this loop in ab8500_chargalg.c, it's rather a state machine,
ab8500_chargalg_algorithm() is called periodically from
ab8500_chargalg_periodic_work() which just constantly
queues itself. So it is a HZ-based loop.

which I think is a good model because many charging chips are
essentially state machines written in vhdl, so we can mimic these
with code.

This charger has these states:

enum ab8500_chargalg_states {
        STATE_HANDHELD_INIT,
        STATE_HANDHELD,
        STATE_CHG_NOT_OK_INIT,
        STATE_CHG_NOT_OK,
        STATE_HW_TEMP_PROTECT_INIT,
        STATE_HW_TEMP_PROTECT,
        STATE_NORMAL_INIT,
        STATE_NORMAL,
        STATE_WAIT_FOR_RECHARGE_INIT,
        STATE_WAIT_FOR_RECHARGE,
        STATE_MAINTENANCE_A_INIT,
        STATE_MAINTENANCE_A,
        STATE_MAINTENANCE_B_INIT,
        STATE_MAINTENANCE_B,
        STATE_TEMP_UNDEROVER_INIT,
        STATE_TEMP_UNDEROVER,
        STATE_TEMP_LOWHIGH_INIT,
        STATE_TEMP_LOWHIGH,
        STATE_OVV_PROTECT_INIT,
        STATE_OVV_PROTECT,
        STATE_SAFETY_TIMER_EXPIRED_INIT,
        STATE_SAFETY_TIMER_EXPIRED,
        STATE_BATT_REMOVED_INIT,
        STATE_BATT_REMOVED,
        STATE_WD_EXPIRED_INIT,
        STATE_WD_EXPIRED,
};

The _INIT states are just a name for the first entry of a new state.

For each state there is one or two callbacks to code handling the
hardware.

This I think could be centralized, but I don't have the picture of what
all software controlled chargers could need? (Also short on time right
now but that will change I suppose.)

Yours,
Linus Walleij
