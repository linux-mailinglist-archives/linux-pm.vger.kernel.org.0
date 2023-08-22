Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8D67837DE
	for <lists+linux-pm@lfdr.de>; Tue, 22 Aug 2023 04:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjHVCWO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Aug 2023 22:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjHVCWJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Aug 2023 22:22:09 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A371918B
        for <linux-pm@vger.kernel.org>; Mon, 21 Aug 2023 19:22:07 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bf1876ef69so4569225ad.1
        for <linux-pm@vger.kernel.org>; Mon, 21 Aug 2023 19:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692670927; x=1693275727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6x7mtElCvEcBk5Pz54P3MMXpgHbAKCeqZ4XfiqbTIQ=;
        b=Fb0KlB9sgWlcj/n8dReUcucTUxY0oXEV/OcFUcBli+/QtHOht4H4ph4z2f7Yj1qVKL
         6dZYWPgtYVPd3kIPo/kmR0eiZpaz8p5NaROizgrYoYHGxN3mWylfrJetBVMJ9IFPTpaC
         ufOJ6Lt038m//UBZbeb5zblHAMY6dkhr1W2VLH634ucn/wW0RpSZ1SNc3dEsam9KP6yW
         Rojli5ue8ytoeQwIGekeHM+uxa5U4SH6Pn2YXd+8O9KA7/GHSbKvWIBfoz4jfob0JdG/
         CX2Kz7EiHjxQTldshFeV/dWS4IfN7KIcofquMaFUBhfw0txSVTrfBMaxe73fGINwrpz+
         dFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692670927; x=1693275727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6x7mtElCvEcBk5Pz54P3MMXpgHbAKCeqZ4XfiqbTIQ=;
        b=IOwvqwqZR61RYSI75EmAC29L4+hvdYD71oyWfnqU9NxdtqKYrBkQKNEHmcEGyymk8s
         X4FQfLYqZtN32Vy4YUDXX8JMNKnlhzEENQuSnCbqaC1H40RgO8G9XP4cZC/dJ7a1TPZW
         Vz4vZLy0dJg9I77t5UCGK4NjpOuhfW8Ok+G9mUmlXQ+9lW6vzIG/4fsDU4WTAr+Lds/9
         3PphrhVD5IGSolz2StXSZQNOgpxCBfAUk2OVTBPx00slGxRU4mdn0V5gWM/BABjrQ+o0
         aWwWINZpZd2bSa0iFBtYc2EoAxwrW+Y68/7yJzkrvi9u3kT96TNiIxB3sdTEGEZcajbV
         OatA==
X-Gm-Message-State: AOJu0YzXEF9ZwuiWdireJxFmF0Vbe7fZuYrvpfpdaJOMzsmjNl+iUpXt
        LZ3iVnGLCSAjzAqP8QUO1hIRymqPTRfLG1uLdx8=
X-Google-Smtp-Source: AGHT+IFVEXCRSQY4QtDg39s8bPLq+nx4l4a4RUH9JGPC+4Id/dx6B65bLlcZmOJX5zJBrlPDg5FjHyh2CLlcgJ9PSa0=
X-Received: by 2002:a17:90a:64c9:b0:263:2312:60c2 with SMTP id
 i9-20020a17090a64c900b00263231260c2mr7450026pjm.3.1692670927048; Mon, 21 Aug
 2023 19:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5ByXdEK6Zsa3ObNinnROn=qsde_xvn3WcR2RLioMKk0JQ@mail.gmail.com>
In-Reply-To: <CAOMZO5ByXdEK6Zsa3ObNinnROn=qsde_xvn3WcR2RLioMKk0JQ@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 21 Aug 2023 23:21:55 -0300
Message-ID: <CAOMZO5AR5AP_bBJxn8GE6sZXQq6wgzU-qDda43567fs=m7eoRA@mail.gmail.com>
Subject: Re: imx8mm: Forcing a reboot when critical temp is reached
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>
Cc:     linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 21, 2023 at 2:27=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi,
>
> I am working with an i.MX8MM-based board and I do see that the system shu=
ts down
> when the critical trip point is reached, as expected.
>
> As the board is unattended, it would be more appropriate if the board
> could reboot itself instead of shutting down when the critical
> temperature is reached.
>
> The bootloader has a mechanism to only allow to boot the kernel when
> the temperature is below a certain temperature.
>
> Is there a mechanism in place to force a reboot instead of shutdown
> when the critical temperature is reached?

I did an ugly hack like this:

--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -315,16 +315,10 @@ static void handle_non_critical_trips(struct
thermal_zone_device *tz, int trip)

 void thermal_zone_device_critical(struct thermal_zone_device *tz)
 {
- /*
- * poweroff_delay_ms must be a carefully profiled positive value.
- * Its a must for forced_emergency_poweroff_work to be scheduled.
- */
- int poweroff_delay_ms =3D CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS;
-
  dev_emerg(&tz->device, "%s: critical temperature reached, "
-   "shutting down\n", tz->type);
+   "rebooting\n", tz->type);

- hw_protection_shutdown("Temperature too high", poweroff_delay_ms);
+ kernel_restart("w");
 }
 EXPORT_SYMBOL(thermal_zone_device_critical);

and this causes a reboot after the critical temperature is reached.

Would it be OK to add a devicetree property that when present would
call kernel_restart()?

Any suggestions?

Thanks
